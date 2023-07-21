Return-Path: <bpf+bounces-5641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0421B75D018
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 18:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB72282394
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140EE1FB50;
	Fri, 21 Jul 2023 16:53:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B727F00
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 16:53:36 +0000 (UTC)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1283A2727;
	Fri, 21 Jul 2023 09:53:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6vx72s5wz9xFQJ;
	Sat, 22 Jul 2023 00:23:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3hl1bs7pkcDDSBA--.22409S5;
	Fri, 21 Jul 2023 17:34:02 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	jarkko@kernel.org,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 03/12] integrity/digest_cache: Add functions to populate and search
Date: Fri, 21 Jul 2023 18:33:17 +0200
Message-Id: <20230721163326.4106089-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721163326.4106089-1-roberto.sassu@huaweicloud.com>
References: <20230721163326.4106089-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwC3hl1bs7pkcDDSBA--.22409S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtr43Cr1DWFyUtFWUKw4kJFb_yoWxJw1kpa
	s7Cr1Utr4rZF13Gw1xAF1ayr1FvrWqqF47Jw45Wr1ayr4DXr1jy3W8Aw1UXFy5Jr48Wa17
	tF4jgr1Uur1UXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jzE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj5DJQAAAso
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Add digest_cache_init_htable(), to size a hash table depending on the
number of digests to be added to the cache.

Add digest_cache_add() and digest_cache_lookup() to respectively add and
lookup a digest in the digest cache.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/digest_cache.c | 124 ++++++++++++++++++++++++++++++
 security/integrity/digest_cache.h |  24 ++++++
 2 files changed, 148 insertions(+)

diff --git a/security/integrity/digest_cache.c b/security/integrity/digest_cache.c
index 66c2c4088e9..7537c7232db 100644
--- a/security/integrity/digest_cache.c
+++ b/security/integrity/digest_cache.c
@@ -298,3 +298,127 @@ void digest_cache_put(struct digest_cache *digest_cache,
 	pr_debug("Put cache, algo: %s, digest list: %s",
 		 hash_algo_name[digest_cache->algo], digest_cache->path_str);
 }
+
+/**
+ * digest_cache_init_htable - Allocate and initialize the hash table
+ * @digest_cache: Digest cache
+ * @num_digests: Number of digests to add to the digest cache
+ *
+ * This function allocates and initializes the hash table. Its size is
+ * determined by the number of digests to add to the digest cache, known
+ * at this point by the parser calling this function.
+ *
+ * Return: Zero on success, a negative value otherwise.
+ */
+int digest_cache_init_htable(struct digest_cache *digest_cache,
+			     u64 num_digests)
+{
+	int i;
+
+	if (!digest_cache)
+		return 0;
+
+	digest_cache->num_slots = num_digests / DIGEST_CACHE_HTABLE_DEPTH;
+	if (!digest_cache->num_slots)
+		digest_cache->num_slots = 1;
+
+	digest_cache->slots = kmalloc_array(num_digests,
+					    sizeof(*digest_cache->slots),
+					    GFP_KERNEL);
+	if (!digest_cache->slots)
+		return -ENOMEM;
+
+	for (i = 0; i < digest_cache->num_slots; i++)
+		INIT_HLIST_HEAD(&digest_cache->slots[i]);
+
+	pr_debug("Initialized %d hash table slots for digest list %s\n",
+		 digest_cache->num_slots, digest_cache->path_str);
+	return 0;
+}
+
+/**
+ * digest_cache_add - Add a new digest to the digest cache
+ * @digest_cache: Digest cache
+ * @digest: Digest to add
+ *
+ * This function, invoked by a digest list parser, adds a digest extracted
+ * from a digest list to the digest cache.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+int digest_cache_add(struct digest_cache *digest_cache, u8 *digest)
+{
+	struct digest_cache_entry *entry;
+	unsigned int key;
+	int digest_len;
+
+	if (!digest_cache)
+		return 0;
+
+	digest_len = hash_digest_size[digest_cache->algo];
+
+	entry = kmalloc(sizeof(*entry) + digest_len, GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	memcpy(entry->digest, digest, digest_len);
+
+	key = digest_cache_hash_key(digest, digest_cache->num_slots);
+	hlist_add_head(&entry->hnext, &digest_cache->slots[key]);
+	pr_debug("Add digest %s:%*phN from digest list %s\n",
+		 hash_algo_name[digest_cache->algo], digest_len, digest,
+		 digest_cache->path_str);
+	return 0;
+}
+
+/**
+ * digest_cache_lookup - Searches a digest in the digest cache
+ * @digest_cache: Digest cache
+ * @digest: Digest to search
+ * @algo: Algorithm of the digest to search
+ *
+ * This function, invoked by IMA or EVM, searches the calculated digest of
+ * a file or file metadata in the digest cache acquired with
+ * digest_cache_get().
+ *
+ * Return: Zero if the digest is found, a negative value if not.
+ */
+int digest_cache_lookup(struct digest_cache *digest_cache, u8 *digest,
+			enum hash_algo algo, const char *pathname)
+{
+	struct digest_cache_entry *entry;
+	unsigned int key;
+	int digest_len;
+	int search_depth = 0;
+
+	if (!digest_cache)
+		return -ENOENT;
+
+	digest_len = hash_digest_size[digest_cache->algo];
+
+	if (algo != digest_cache->algo) {
+		pr_debug("Algo mismatch for file %s, digest %s:%*phN in digest list %s (*%s)\n",
+			 pathname, hash_algo_name[algo], digest_len, digest,
+			 digest_cache->path_str,
+			 hash_algo_name[digest_cache->algo]);
+		return -ENOENT;
+	}
+
+	key = digest_cache_hash_key(digest, digest_cache->num_slots);
+
+	hlist_for_each_entry_rcu(entry, &digest_cache->slots[key], hnext) {
+		if (!memcmp(entry->digest, digest, digest_len)) {
+			pr_debug("Cache hit at depth %d for file %s, digest %s:%*phN in digest list %s\n",
+				 search_depth, pathname, hash_algo_name[algo], digest_len,
+				 digest, digest_cache->path_str);
+			return 0;
+		}
+
+		search_depth++;
+	}
+
+	pr_debug("Cache miss for file %s, digest %s:%*phN in digest list %s\n",
+		 pathname, hash_algo_name[algo], digest_len, digest,
+		 digest_cache->path_str);
+	return -ENOENT;
+}
diff --git a/security/integrity/digest_cache.h b/security/integrity/digest_cache.h
index fa4a716df65..5e3997b2723 100644
--- a/security/integrity/digest_cache.h
+++ b/security/integrity/digest_cache.h
@@ -64,6 +64,11 @@ struct digest_cache *digest_cache_get(struct dentry *dentry,
 				      struct path *digest_list_path);
 void digest_cache_put(struct digest_cache *digest_cache,
 		      struct path *digest_list_path);
+int digest_cache_init_htable(struct digest_cache *digest_cache,
+			     u64 num_digests);
+int digest_cache_add(struct digest_cache *digest_cache, u8 *digest);
+int digest_cache_lookup(struct digest_cache *digest_cache, u8 *digest,
+			enum hash_algo algo, const char *pathname);
 #else
 static inline void digest_cache_free(struct digest_cache *digest_cache)
 {
@@ -80,5 +85,24 @@ static inline void digest_cache_put(struct digest_cache *digest_cache,
 {
 }
 
+static inline int digest_cache_init_htable(struct digest_cache *digest_cache,
+					   u64 num_digests)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int digest_cache_add(struct digest_cache *digest_cache,
+				   u8 *digest)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int digest_cache_lookup(struct digest_cache *digest_cache,
+				      u8 *digest, enum hash_algo algo,
+				      const char *pathname)
+{
+	return -ENOENT;
+}
+
 #endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
 #endif /* _DIGEST_CACHE_H */
-- 
2.34.1


