import 'package:flutter/material.dart';
import 'carditem.dart';
import 'expandedCard.dart';

class LostFoundItem {
  final String image;
  final String title;
  final String desc;
  final String tag;
  final String contact;
  final String authorId;
  LostFoundItem({
    required this.image,
    required this.title,
    required this.desc,
    required this.tag,
    required this.contact,
    required this.authorId,
  });
}

class LostAndFoundHomePage extends StatefulWidget {
  const LostAndFoundHomePage({super.key});
  @override
  State<LostAndFoundHomePage> createState() => _LostAndFoundHomePageState();
}

class _LostAndFoundHomePageState extends State<LostAndFoundHomePage> {
  String? selectedFilter;
  String _searchQuery = '';
  String currentUserId = 'demo_user';
  late TextEditingController _searchController;

  final List<LostFoundItem> demoItems = [
    LostFoundItem(
      image: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400',
      title: 'Lost iPhone 14',
      desc: 'Lost my iPhone 14 near the library. Black color with clear case. Please contact if found.',
      tag: 'LOST',
      contact: 'Phone: +91 98765 43210',
      authorId: 'demo_user',
    ),
    LostFoundItem(
      image: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
      title: 'Found Red Wallet',
      desc: 'Found a red leather wallet near the canteen. Contains some cards and cash.',
      tag: 'FOUND',
      contact: 'Email: found@iitp.ac.in',
      authorId: 'demo_user',
    ),
    LostFoundItem(
      image: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
      title: 'Lost AirPods Pro',
      desc: 'Lost my AirPods Pro case near the gym. White color with engraving.',
      tag: 'LOST',
      contact: 'WhatsApp: +91 87654 32109',
      authorId: 'demo_user',
    ),
    LostFoundItem(
      image: 'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400',
      title: 'Found Silver Watch',
      desc: 'Found a silver analog watch near the parking area. Looks expensive.',
      tag: 'FOUND',
      contact: 'Phone: +91 76543 21098',
      authorId: 'demo_user',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LnF'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Demo mode - no logout needed')),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Demo mode - add feature not available')),
          );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(hintText: 'Search...'),
                    onChanged: (query) {
                      _searchQuery = query;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedFilter == 'LOST' ? Colors.red : Colors.white,
                    foregroundColor: selectedFilter == 'LOST' ? Colors.white : Colors.black,
                  ),
                  onPressed: () => setState(() => selectedFilter = selectedFilter == 'LOST' ? null : 'LOST'),
                  child: Text('L'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedFilter == 'FOUND' ? Colors.green : Colors.white,
                    foregroundColor: selectedFilter == 'FOUND' ? Colors.white : Colors.black,
                  ),
                  onPressed: () => setState(() => selectedFilter = selectedFilter == 'FOUND' ? null : 'FOUND'),
                  child: Text('F'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: demoItems.where((item) {
                final matchesFilter = selectedFilter == null || item.tag == selectedFilter;
                final matchesSearch = _searchQuery.isEmpty ||
                  item.desc.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                  item.title.toLowerCase().contains(_searchQuery.toLowerCase());
                return matchesFilter && matchesSearch;
              }).length,
              itemBuilder: (context, index) {
                final filteredItems = demoItems.where((item) {
                  final matchesFilter = selectedFilter == null || item.tag == selectedFilter;
                  final matchesSearch = _searchQuery.isEmpty ||
                    item.desc.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                    item.title.toLowerCase().contains(_searchQuery.toLowerCase());
                  return matchesFilter && matchesSearch;
                }).toList();
                
                final item = filteredItems[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LostFoundDetailPage(item: item))),
                  child: Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CardItem(
                        item: item,
                        currentUserId: currentUserId,
                        onDelete: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Demo mode - delete feature not available')),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 