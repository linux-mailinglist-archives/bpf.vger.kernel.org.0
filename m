Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D94164EEB
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 20:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgBSTbN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 14:31:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27488 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbgBSTbN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Feb 2020 14:31:13 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JJTFnZ024117
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 11:31:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=V7dz0i2D3diuWXpw4UjKMnLZzfOvSs2Y57FfkPRcDVM=;
 b=LTZMpsLFJjuM26/A97c9M1vMbba6nFpPR+Zytua8Eg44v0GEYB3RD8gJDdlAHj+PxmPN
 BImhfFoUMz3aDXGv5ukXK4S2N+VEEFx+fuZnZ1aEzZMBC+5AJScOWbukHG2fjdgHenY1
 TQeQQeHqRA+LS2/bySBOMdmcZs35kLwg8JY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y8ubtmcvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 11:31:11 -0800
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 19 Feb 2020 11:31:10 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id E34063703120; Wed, 19 Feb 2020 11:31:06 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf v3] bpf: fix a potential deadlock with bpf_map_do_batch
Date:   Wed, 19 Feb 2020 11:31:06 -0800
Message-ID: <20200219193106.2246922-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_05:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=38 adultscore=0 malwarescore=0
 mlxlogscore=742 bulkscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190149
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 057996380a42 ("bpf: Add batch ops to all htab bpf map")
added lookup_and_delete batch operation for hash table.
The current implementation has bpf_lru_push_free() inside
the bucket lock, which may cause a deadlock.

syzbot reports:
   -> #2 (&htab->buckets[i].lock#2){....}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
       htab_lru_map_delete_node+0xce/0x2f0 kernel/bpf/hashtab.c:593
       __bpf_lru_list_shrink_inactive kernel/bpf/bpf_lru_list.c:220 [inline]
       __bpf_lru_list_shrink+0xf9/0x470 kernel/bpf/bpf_lru_list.c:266
       bpf_lru_list_pop_free_to_local kernel/bpf/bpf_lru_list.c:340 [inline]
       bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:447 [inline]
       bpf_lru_pop_free+0x87c/0x1670 kernel/bpf/bpf_lru_list.c:499
       prealloc_lru_pop+0x2c/0xa0 kernel/bpf/hashtab.c:132
       __htab_lru_percpu_map_update_elem+0x67e/0xa90 kernel/bpf/hashtab.c:1069
       bpf_percpu_hash_update+0x16e/0x210 kernel/bpf/hashtab.c:1585
       bpf_map_update_value.isra.0+0x2d7/0x8e0 kernel/bpf/syscall.c:181
       generic_map_update_batch+0x41f/0x610 kernel/bpf/syscall.c:1319
       bpf_map_do_batch+0x3f5/0x510 kernel/bpf/syscall.c:3348
       __do_sys_bpf+0x9b7/0x41e0 kernel/bpf/syscall.c:3460
       __se_sys_bpf kernel/bpf/syscall.c:3355 [inline]
       __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:3355
       do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

   -> #0 (&loc_l->lock){....}:
       check_prev_add kernel/locking/lockdep.c:2475 [inline]
       check_prevs_add kernel/locking/lockdep.c:2580 [inline]
       validate_chain kernel/locking/lockdep.c:2970 [inline]
       __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3954
       lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
       bpf_common_lru_push_free kernel/bpf/bpf_lru_list.c:516 [inline]
       bpf_lru_push_free+0x250/0x5b0 kernel/bpf/bpf_lru_list.c:555
       __htab_map_lookup_and_delete_batch+0x8d4/0x1540 kernel/bpf/hashtab.c:1374
       htab_lru_map_lookup_and_delete_batch+0x34/0x40 kernel/bpf/hashtab.c:1491
       bpf_map_do_batch+0x3f5/0x510 kernel/bpf/syscall.c:3348
       __do_sys_bpf+0x1f7d/0x41e0 kernel/bpf/syscall.c:3456
       __se_sys_bpf kernel/bpf/syscall.c:3355 [inline]
       __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:3355
       do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

    Possible unsafe locking scenario:

          CPU0                    CPU2
          ----                    ----
     lock(&htab->buckets[i].lock#2);
                                  lock(&l->lock);
                                  lock(&htab->buckets[i].lock#2);
     lock(&loc_l->lock);

    *** DEADLOCK ***

To fix the issue, for htab_lru_map_lookup_and_delete_batch() in CPU0,
let us do bpf_lru_push_free() out of the htab bucket lock. This can
avoid the above deadlock scenario.

Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
Reported-by: syzbot+a38ff3d9356388f2fb83@syzkaller.appspotmail.com
Reported-by: syzbot+122b5421d14e68f29cd1@syzkaller.appspotmail.com
Suggested-by: Hillf Danton <hdanton@sina.com>
Suggested-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/hashtab.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

Changelog:
  v2 -> v3:
     . changed variable name, fixed reverse Christmas tree
       coding style and added more comments, from Martin.
  v1 -> v2:
     . coding style fix to have braces in both then and else
       branch, from Jakub.

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 2d182c4ee9d9..9395dcdab3fa 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -56,6 +56,7 @@ struct htab_elem {
 			union {
 				struct bpf_htab *htab;
 				struct pcpu_freelist_node fnode;
+				struct htab_elem *batch_flink;
 			};
 		};
 	};
@@ -126,6 +127,17 @@ static void htab_free_elems(struct bpf_htab *htab)
 	bpf_map_area_free(htab->elems);
 }
 
+/* The LRU list has a lock (lru_lock). Each htab bucket has a lock
+ * (bucket_lock). If both locks need to be acquired together, the lock
+ * order is always lru_lock -> bucket_lock and this only happens in
+ * bpf_lru_list.c logic. For example, certain code path of
+ * bpf_lru_pop_free(), which is called by function prealloc_lru_pop(),
+ * will acquire lru_lock first followed by acquiring bucket_lock.
+ *
+ * In hashtab.c, to avoid deadlock, lock acquisition of
+ * bucket_lock followed by lru_lock is not allowed. In such cases,
+ * bucket_lock needs to be released first before acquiring lru_lock.
+ */
 static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 					  u32 hash)
 {
@@ -1256,6 +1268,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	void __user *ukeys = u64_to_user_ptr(attr->batch.keys);
 	void *ubatch = u64_to_user_ptr(attr->batch.in_batch);
 	u32 batch, max_count, size, bucket_size;
+	struct htab_elem *node_to_free = NULL;
 	u64 elem_map_flags, map_flags;
 	struct hlist_nulls_head *head;
 	struct hlist_nulls_node *n;
@@ -1370,16 +1383,31 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		}
 		if (do_delete) {
 			hlist_nulls_del_rcu(&l->hash_node);
-			if (is_lru_map)
-				bpf_lru_push_free(&htab->lru, &l->lru_node);
-			else
+
+			/* bpf_lru_push_free() will acquire lru_lock, which
+			 * may cause deadlock. See comments in function
+			 * prealloc_lru_pop(). Let us do bpf_lru_push_free()
+			 * after releasing the bucket lock.
+			 */
+			if (is_lru_map) {
+				l->batch_flink = node_to_free;
+				node_to_free = l;
+			} else {
 				free_htab_elem(htab, l);
+			}
 		}
 		dst_key += key_size;
 		dst_val += value_size;
 	}
 
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	while (node_to_free) {
+		l = node_to_free;
+		node_to_free = node_to_free->batch_flink;
+		bpf_lru_push_free(&htab->lru, &l->lru_node);
+	}
+
 	/* If we are not copying data, we can go to next bucket and avoid
 	 * unlocking the rcu.
 	 */
-- 
2.17.1

