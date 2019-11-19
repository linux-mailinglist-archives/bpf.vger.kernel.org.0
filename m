Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DFB1010CC
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 02:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKSBis (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 20:38:48 -0500
Received: from www62.your-server.de ([213.133.104.62]:53654 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfKSBis (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 20:38:48 -0500
Received: from 45.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.45] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iWsTd-0002k1-Qu; Tue, 19 Nov 2019 02:38:45 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     john.fastabend@gmail.com, andrii.nakryiko@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next 3/8] bpf: move owner type,jited info into array auxiliary data
Date:   Tue, 19 Nov 2019 02:38:34 +0100
Message-Id: <5daa7bcfb424fd01ec15b29db7fd84205a3db915.1574126683.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1574126683.git.daniel@iogearbox.net>
References: <cover.1574126683.git.daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25637/Mon Nov 18 10:53:23 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We're going to extend this with further information which is only
relevant for prog array at this point. Given this info is not used
in critical path, move it into its own structure such that the main
array map structure can be kept on diet.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 include/linux/bpf.h     | 18 +++++++++++-------
 kernel/bpf/arraymap.c   | 32 ++++++++++++++++++++++++++++++--
 kernel/bpf/core.c       | 11 +++++------
 kernel/bpf/map_in_map.c |  5 ++---
 kernel/bpf/syscall.c    | 16 ++++++----------
 5 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cfecf6761bb7..836e49855bf9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -560,17 +560,21 @@ struct bpf_prog_aux {
 	};
 };
 
+struct bpf_array_aux {
+	/* 'Ownership' of prog array is claimed by the first program that
+	 * is going to use this map or by the first program which FD is
+	 * stored in the map to make sure that all callers and callees have
+	 * the same prog type and JITed flag.
+	 */
+	enum bpf_prog_type type;
+	bool jited;
+};
+
 struct bpf_array {
 	struct bpf_map map;
 	u32 elem_size;
 	u32 index_mask;
-	/* 'ownership' of prog_array is claimed by the first program that
-	 * is going to use this map or by the first program which FD is stored
-	 * in the map to make sure that all callers and callees have the same
-	 * prog_type and JITed flag
-	 */
-	enum bpf_prog_type owner_prog_type;
-	bool owner_jited;
+	struct bpf_array_aux *aux;
 	union {
 		char value[0] __aligned(8);
 		void *ptrs[0] __aligned(8);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index a42097c36b0c..5be12db129cc 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -671,10 +671,38 @@ static void prog_array_map_seq_show_elem(struct bpf_map *map, void *key,
 	rcu_read_unlock();
 }
 
+static struct bpf_map *prog_array_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_array_aux *aux;
+	struct bpf_map *map;
+
+	aux = kzalloc(sizeof(*aux), GFP_KERNEL);
+	if (!aux)
+		return ERR_PTR(-ENOMEM);
+
+	map = array_map_alloc(attr);
+	if (IS_ERR(map)) {
+		kfree(aux);
+		return map;
+	}
+
+	container_of(map, struct bpf_array, map)->aux = aux;
+	return map;
+}
+
+static void prog_array_map_free(struct bpf_map *map)
+{
+	struct bpf_array_aux *aux;
+
+	aux = container_of(map, struct bpf_array, map)->aux;
+	kfree(aux);
+	fd_array_map_free(map);
+}
+
 const struct bpf_map_ops prog_array_map_ops = {
 	.map_alloc_check = fd_array_map_alloc_check,
-	.map_alloc = array_map_alloc,
-	.map_free = fd_array_map_free,
+	.map_alloc = prog_array_map_alloc,
+	.map_free = prog_array_map_free,
 	.map_get_next_key = array_map_get_next_key,
 	.map_lookup_elem = fd_array_map_lookup_elem,
 	.map_delete_elem = fd_array_map_delete_elem,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0e825c164f1a..07af9c1d9cf1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1691,18 +1691,17 @@ bool bpf_prog_array_compatible(struct bpf_array *array,
 	if (fp->kprobe_override)
 		return false;
 
-	if (!array->owner_prog_type) {
+	if (!array->aux->type) {
 		/* There's no owner yet where we could check for
 		 * compatibility.
 		 */
-		array->owner_prog_type = fp->type;
-		array->owner_jited = fp->jited;
-
+		array->aux->type  = fp->type;
+		array->aux->jited = fp->jited;
 		return true;
 	}
 
-	return array->owner_prog_type == fp->type &&
-	       array->owner_jited == fp->jited;
+	return array->aux->type  == fp->type &&
+	       array->aux->jited == fp->jited;
 }
 
 static int bpf_check_tail_call(const struct bpf_prog *fp)
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 4cbe987be35b..5e9366b33f0f 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -17,9 +17,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	if (IS_ERR(inner_map))
 		return inner_map;
 
-	/* prog_array->owner_prog_type and owner_jited
-	 * is a runtime binding.  Doing static check alone
-	 * in the verifier is not enough.
+	/* prog_array->aux->{type,jited} is a runtime binding.
+	 * Doing static check alone in the verifier is not enough.
 	 */
 	if (inner_map->map_type == BPF_MAP_TYPE_PROG_ARRAY ||
 	    inner_map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE ||
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ae3b2c86ea17..7855f2dd3609 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -386,13 +386,12 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 {
 	const struct bpf_map *map = filp->private_data;
 	const struct bpf_array *array;
-	u32 owner_prog_type = 0;
-	u32 owner_jited = 0;
+	u32 type = 0, jited = 0;
 
 	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY) {
 		array = container_of(map, struct bpf_array, map);
-		owner_prog_type = array->owner_prog_type;
-		owner_jited = array->owner_jited;
+		type  = array->aux->type;
+		jited = array->aux->jited;
 	}
 
 	seq_printf(m,
@@ -412,12 +411,9 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 		   map->memory.pages * 1ULL << PAGE_SHIFT,
 		   map->id,
 		   READ_ONCE(map->frozen));
-
-	if (owner_prog_type) {
-		seq_printf(m, "owner_prog_type:\t%u\n",
-			   owner_prog_type);
-		seq_printf(m, "owner_jited:\t%u\n",
-			   owner_jited);
+	if (type) {
+		seq_printf(m, "owner_prog_type:\t%u\n", type);
+		seq_printf(m, "owner_jited:\t%u\n", jited);
 	}
 }
 #endif
-- 
2.21.0

