Return-Path: <bpf+bounces-18603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF6781C9CB
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 13:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CAE1C2512E
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 12:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDBB179B2;
	Fri, 22 Dec 2023 12:21:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077218636;
	Fri, 22 Dec 2023 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vz-sd5I_1703247708;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0Vz-sd5I_1703247708)
          by smtp.aliyun-inc.com;
          Fri, 22 Dec 2023 20:21:49 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	hengqi@linux.alibaba.com,
	shung-hsi.yu@suse.com
Subject: [PATCH bpf-next 1/3] bpf: implement relay map basis
Date: Fri, 22 Dec 2023 20:21:44 +0800
Message-Id: <20231222122146.65519-2-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231222122146.65519-1-lulie@linux.alibaba.com>
References: <20231222122146.65519-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_MAP_TYPE_RELAY is implemented based on relay interface, which
creates per-cpu buffer to transfer data. Each buffer is essentially a
list of fix-sized sub-buffers, and is exposed to user space as files in
debugfs. attr->max_entries is used as subbuf size and attr->map_extra is
used as subbuf num. Currently, the default value of subbuf num is 8.

The data can be accessed by read or mmap via these files. For example,
if there are 2 cpus, files could be `/sys/kernel/debug/mydir/my_rmap0`
and `/sys/kernel/debug/mydir/my_rmap1`.

Buffer-only mode is used to create the relay map, which just allocates
the buffer without creating user-space files. Then user can setup the
files with map_update_elem, thus allowing user to define the directory
name in debugfs. map_update_elem is implemented in the following patch.

A new map flag named BPF_F_OVERWRITE is introduced to set overwrite mode
of relay map.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 include/linux/bpf_types.h |   3 +
 include/uapi/linux/bpf.h  |   7 ++
 kernel/bpf/Makefile       |   3 +
 kernel/bpf/relaymap.c     | 157 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c      |   1 +
 5 files changed, 171 insertions(+)
 create mode 100644 kernel/bpf/relaymap.c

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fc0d6f32c687..c122d7b494c5 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -132,6 +132,9 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
+#ifdef CONFIG_RELAY
+BPF_MAP_TYPE(BPF_MAP_TYPE_RELAY, relay_map_ops)
+#endif
 
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 754e68ca8744..143b75676bd3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -951,6 +951,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	BPF_MAP_TYPE_RELAY,
 };
 
 /* Note that tracing related programs such as
@@ -1330,6 +1331,9 @@ enum {
 
 /* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
 	BPF_F_PATH_FD		= (1U << 14),
+
+/* Enable overwrite for relay map */
+	BPF_F_OVERWRITE		= (1U << 15),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -1401,6 +1405,9 @@ union bpf_attr {
 		 * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the
 		 * number of hash functions (if 0, the bloom filter will default
 		 * to using 5 hash functions).
+		 *
+		 * BPF_MAP_TYPE_RELAY - the lowest 32 bits indicate the number of
+		 * relay subbufs (if 0, the number will be set to 8 by default).
 		 */
 		__u64	map_extra;
 	};
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f526b7573e97..45b35bb0e572 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -10,6 +10,9 @@ obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
+ifeq ($(CONFIG_RELAY),y)
+obj-$(CONFIG_BPF_SYSCALL) += relaymap.o
+endif
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
diff --git a/kernel/bpf/relaymap.c b/kernel/bpf/relaymap.c
new file mode 100644
index 000000000000..d0adc7f67758
--- /dev/null
+++ b/kernel/bpf/relaymap.c
@@ -0,0 +1,157 @@
+#include <linux/cpumask.h>
+#include <linux/debugfs.h>
+#include <linux/filter.h>
+#include <linux/relay.h>
+#include <linux/slab.h>
+#include <linux/bpf.h>
+#include <linux/err.h>
+
+#define RELAY_CREATE_FLAG_MASK (BPF_F_OVERWRITE)
+
+struct bpf_relay_map {
+	struct bpf_map map;
+	struct rchan *relay_chan;
+	struct rchan_callbacks relay_cb;
+};
+
+static struct dentry *create_buf_file_handler(const char *filename,
+							   struct dentry *parent, umode_t mode,
+							   struct rchan_buf *buf, int *is_global)
+{
+	/* Because we do relay_late_setup_files(), create_buf_file(NULL, NULL, ...)
+	 * will be called by relay_open.
+	 */
+	if (!filename)
+		return NULL;
+
+	return debugfs_create_file(filename, mode, parent, buf,
+				   &relay_file_operations);
+}
+
+static int remove_buf_file_handler(struct dentry *dentry)
+{
+	debugfs_remove(dentry);
+	return 0;
+}
+
+/* For non-overwrite, use default subbuf_start cb */
+static int subbuf_start_overwrite(struct rchan_buf *buf, void *subbuf,
+						   void *prev_subbuf, size_t prev_padding)
+{
+	return 1;
+}
+
+/* bpf_attr is used as follows:
+ * - key size: must be 0
+ * - value size: value will be used as directory name by map_update_elem
+ *   (to create relay files). If passed as 0, it will be set to NAME_MAX as
+ *   default
+ *
+ * - max_entries: subbuf size
+ * - map_extra: subbuf num, default as 8
+ *
+ * When alloc, we do not set up relay files considering dir_name conflicts.
+ * Instead we use relay_late_setup_files() in map_update_elem(), and thus the
+ * value is used as dir_name, and map->name is used as base_filename.
+ */
+static struct bpf_map *relay_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_relay_map *rmap;
+
+	if (unlikely(attr->map_flags & ~RELAY_CREATE_FLAG_MASK))
+		return ERR_PTR(-EINVAL);
+
+	/* key size must be 0 in relay map */
+	if (unlikely(attr->key_size))
+		return ERR_PTR(-EINVAL);
+
+	if (unlikely(attr->value_size > NAME_MAX)) {
+		pr_warn("value_size should be no more than %d\n", NAME_MAX);
+		return ERR_PTR(-EINVAL);
+	} else if (attr->value_size == 0)
+		attr->value_size = NAME_MAX;
+
+	/* set default subbuf num */
+	attr->map_extra = attr->map_extra & UINT_MAX;
+	if (!attr->map_extra)
+		attr->map_extra = 8;
+
+	if (!attr->map_name || strlen(attr->map_name) == 0)
+		return ERR_PTR(-EINVAL);
+
+	rmap = bpf_map_area_alloc(sizeof(*rmap), NUMA_NO_NODE);
+	if (!rmap)
+		return ERR_PTR(-ENOMEM);
+
+	bpf_map_init_from_attr(&rmap->map, attr);
+
+	rmap->relay_cb.create_buf_file = create_buf_file_handler;
+	rmap->relay_cb.remove_buf_file = remove_buf_file_handler;
+	if (attr->map_flags & BPF_F_OVERWRITE)
+		rmap->relay_cb.subbuf_start = subbuf_start_overwrite;
+
+	rmap->relay_chan = relay_open(NULL, NULL,
+							attr->max_entries, attr->map_extra,
+							&rmap->relay_cb, NULL);
+	if (!rmap->relay_chan)
+		return ERR_PTR(-EINVAL);
+
+	return &rmap->map;
+}
+
+static void relay_map_free(struct bpf_map *map)
+{
+	struct bpf_relay_map *rmap;
+
+	rmap = container_of(map, struct bpf_relay_map, map);
+	relay_close(rmap->relay_chan);
+	debugfs_remove_recursive(rmap->relay_chan->parent);
+	kfree(rmap);
+}
+
+static void *relay_map_lookup_elem(struct bpf_map *map, void *key)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static long relay_map_update_elem(struct bpf_map *map, void *key, void *value,
+				   u64 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static long relay_map_delete_elem(struct bpf_map *map, void *key)
+{
+	return -EOPNOTSUPP;
+}
+
+static int relay_map_get_next_key(struct bpf_map *map, void *key,
+				    void *next_key)
+{
+	return -EOPNOTSUPP;
+}
+
+static u64 relay_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_relay_map *rmap;
+	u64 usage = sizeof(struct bpf_relay_map);
+
+	rmap = container_of(map, struct bpf_relay_map, map);
+	usage += sizeof(struct rchan);
+	usage += (sizeof(struct rchan_buf) + rmap->relay_chan->alloc_size)
+			 * num_online_cpus();
+	return usage;
+}
+
+BTF_ID_LIST_SINGLE(relay_map_btf_ids, struct, bpf_relay_map)
+const struct bpf_map_ops relay_map_ops = {
+	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc = relay_map_alloc,
+	.map_free = relay_map_free,
+	.map_lookup_elem = relay_map_lookup_elem,
+	.map_update_elem = relay_map_update_elem,
+	.map_delete_elem = relay_map_delete_elem,
+	.map_get_next_key = relay_map_get_next_key,
+	.map_mem_usage = relay_map_mem_usage,
+	.map_btf_id = &relay_map_btf_ids[0],
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1bf9805ee185..35ae54ac6736 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1147,6 +1147,7 @@ static int map_create(union bpf_attr *attr)
 	}
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
+	    attr->map_type != BPF_MAP_TYPE_RELAY &&
 	    attr->map_extra != 0)
 		return -EINVAL;
 
-- 
2.32.0.3.g01195cf9f


