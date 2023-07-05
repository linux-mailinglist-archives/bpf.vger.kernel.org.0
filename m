Return-Path: <bpf+bounces-4039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5AB7481A3
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 12:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0625B280FA7
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0474C95;
	Wed,  5 Jul 2023 10:02:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393420F4
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 10:02:50 +0000 (UTC)
X-Greylist: delayed 2556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Jul 2023 03:02:44 PDT
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080BB173F
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 03:02:43 -0700 (PDT)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qGyg7-00GIrV-WD
	for bpf@vger.kernel.org; Wed, 05 Jul 2023 09:20:06 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qGyg5-00CNIz-4N; Wed, 05 Jul 2023 10:20:03 +0100
From: anton.ivanov@cambridgegreys.com
To: bpf@vger.kernel.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] bpf: make ringbuf available to modules
Date: Wed,  5 Jul 2023 10:19:58 +0100
Message-Id: <20230705091958.2949447-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Ringbuf which was developed as a part of BPF infrastructure is
a very nice, clean, simple and consise API to relay information
from the kernel to userspace. It can be used in critical sections,
interrupt handlers, etc.

This patch exports ringbuf functionality to make it available to
kernel modules.

Demo: https://github.com/kot-begemot-uk/bpfnic-ng

The demo ships to userspace hardware offload notifications
without any mallocs, any workqueue and/or delayed work which
is normally needed to handle these. As a result it is ~ 150
lines of code instead of the 500+ usually needed to achieve the
same result.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 include/linux/bpf.h  | 16 ++++++++++++
 kernel/bpf/inode.c   | 43 ++++++++++++++++++++++++++++++
 kernel/bpf/ringbuf.c | 62 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..0882ba4a44dd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2004,6 +2004,20 @@ int  generic_map_delete_batch(struct bpf_map *map,
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
+void *_bpf_ringbuf_reserve(struct bpf_map *map,
+				 u64 size, u64 flags);
+void _bpf_ringbuf_commit(void *sample, u64 flags);
+void _bpf_ringbuf_discard(void *sample, u64 flags);
+int _bpf_ringbuf_output(struct bpf_map *map,
+			      void *data, u64 size, u64 flags);
+int _bpf_ringbuf_query(struct bpf_map *map, u64 flags);
+int _bpf_user_ringbuf_drain(struct bpf_map *map,
+				  void *callback_fn,
+				  void *callback_ctx,
+				  u64 flags);
+
+
+
 #ifdef CONFIG_MEMCG_KMEM
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node);
@@ -2245,6 +2259,8 @@ static inline int bpf_map_attr_numa_node(const union bpf_attr *attr)
 }
 
 struct bpf_prog *bpf_prog_get_type_path(const char *name, enum bpf_prog_type type);
+struct bpf_map *bpf_map_get_path(const char *name, fmode_t fmod);
+
 int array_map_alloc_check(union bpf_attr *attr);
 
 int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 4174f76133df..0518f122df68 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -597,6 +597,49 @@ struct bpf_prog *bpf_prog_get_type_path(const char *name, enum bpf_prog_type typ
 }
 EXPORT_SYMBOL(bpf_prog_get_type_path);
 
+static struct bpf_map *__get_map_inode(struct inode *inode, fmode_t fmode)
+{
+	struct bpf_map *map;
+	int ret = inode_permission(&nop_mnt_idmap, inode, MAY_READ);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (inode->i_op == &bpf_prog_iops)
+		return ERR_PTR(-EINVAL);
+	if (inode->i_op == &bpf_link_iops)
+		return ERR_PTR(-EINVAL);
+	if (inode->i_op != &bpf_map_iops)
+		return ERR_PTR(-EPERM);
+
+	map = inode->i_private;
+
+	ret = security_bpf_map(map, fmode);
+
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	bpf_map_inc(map);
+	return map;
+}
+
+struct bpf_map *bpf_map_get_path(const char *name, fmode_t fmode)
+{
+	struct bpf_map *map;
+	struct path path;
+	int ret = kern_path(name, LOOKUP_FOLLOW, &path);
+
+	if (ret)
+		return ERR_PTR(ret);
+	map = __get_map_inode(d_backing_inode(path.dentry), fmode);
+	if (!IS_ERR(map))
+		touch_atime(&path);
+	path_put(&path);
+	return map;
+}
+EXPORT_SYMBOL(bpf_map_get_path);
+
+
 /*
  * Display the mount options in /proc/mounts.
  */
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 875ac9b698d9..4d4750b9f963 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -452,15 +452,21 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	return (void *)hdr + BPF_RINGBUF_HDR_SZ;
 }
 
-BPF_CALL_3(bpf_ringbuf_reserve, struct bpf_map *, map, u64, size, u64, flags)
+void *_bpf_ringbuf_reserve(struct bpf_map *map, u64 size, u64 flags)
 {
 	struct bpf_ringbuf_map *rb_map;
 
 	if (unlikely(flags))
-		return 0;
+		return NULL;
 
 	rb_map = container_of(map, struct bpf_ringbuf_map, map);
-	return (unsigned long)__bpf_ringbuf_reserve(rb_map->rb, size);
+	return __bpf_ringbuf_reserve(rb_map->rb, size);
+}
+EXPORT_SYMBOL(_bpf_ringbuf_reserve);
+
+BPF_CALL_3(bpf_ringbuf_reserve, struct bpf_map *, map, u64, size, u64, flags)
+{
+	return (unsigned long)_bpf_ringbuf_reserve(map, size, flags);
 }
 
 const struct bpf_func_proto bpf_ringbuf_reserve_proto = {
@@ -499,6 +505,12 @@ static void bpf_ringbuf_commit(void *sample, u64 flags, bool discard)
 		irq_work_queue(&rb->work);
 }
 
+void _bpf_ringbuf_commit(void *sample, u64 flags)
+{
+	bpf_ringbuf_commit(sample, flags, false);
+}
+EXPORT_SYMBOL(_bpf_ringbuf_commit);
+
 BPF_CALL_2(bpf_ringbuf_submit, void *, sample, u64, flags)
 {
 	bpf_ringbuf_commit(sample, flags, false /* discard */);
@@ -512,6 +524,12 @@ const struct bpf_func_proto bpf_ringbuf_submit_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
+void _bpf_ringbuf_discard(void *sample, u64 flags)
+{
+	bpf_ringbuf_commit(sample, flags, true);
+}
+EXPORT_SYMBOL(_bpf_ringbuf_discard);
+
 BPF_CALL_2(bpf_ringbuf_discard, void *, sample, u64, flags)
 {
 	bpf_ringbuf_commit(sample, flags, true /* discard */);
@@ -525,8 +543,8 @@ const struct bpf_func_proto bpf_ringbuf_discard_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_4(bpf_ringbuf_output, struct bpf_map *, map, void *, data, u64, size,
-	   u64, flags)
+int _bpf_ringbuf_output(struct bpf_map *map, void *data, u64 size,
+	   u64 flags)
 {
 	struct bpf_ringbuf_map *rb_map;
 	void *rec;
@@ -543,6 +561,13 @@ BPF_CALL_4(bpf_ringbuf_output, struct bpf_map *, map, void *, data, u64, size,
 	bpf_ringbuf_commit(rec, flags, false /* discard */);
 	return 0;
 }
+EXPORT_SYMBOL(_bpf_ringbuf_output);
+
+BPF_CALL_4(bpf_ringbuf_output, struct bpf_map *, map, void *, data, u64, size,
+	   u64, flags)
+{
+	return _bpf_ringbuf_output(map, data, size, flags);
+}
 
 const struct bpf_func_proto bpf_ringbuf_output_proto = {
 	.func		= bpf_ringbuf_output,
@@ -553,7 +578,7 @@ const struct bpf_func_proto bpf_ringbuf_output_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, u64, flags)
+int _bpf_ringbuf_query(struct bpf_map *map, u64 flags)
 {
 	struct bpf_ringbuf *rb;
 
@@ -572,6 +597,12 @@ BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, u64, flags)
 		return 0;
 	}
 }
+EXPORT_SYMBOL(_bpf_ringbuf_query);
+
+BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, u64, flags)
+{
+	return _bpf_ringbuf_query(map, flags);
+}
 
 const struct bpf_func_proto bpf_ringbuf_query_proto = {
 	.func		= bpf_ringbuf_query,
@@ -727,8 +758,8 @@ static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t siz
 	smp_store_release(&rb->consumer_pos, consumer_pos + rounded_size);
 }
 
-BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
-	   void *, callback_fn, void *, callback_ctx, u64, flags)
+int __bpf_user_ringbuf_drain(struct bpf_map *map,
+	   void *callback_fn, void *callback_ctx, u64 flags)
 {
 	struct bpf_ringbuf *rb;
 	long samples, discarded_samples = 0, ret = 0;
@@ -784,6 +815,21 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
 	return ret;
 }
 
+BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
+	   void *, callback_fn, void *, callback_ctx, u64, flags)
+{
+	return __bpf_user_ringbuf_drain(map, callback_fn, callback_ctx, flags);
+}
+
+
+int _bpf_user_ringbuf_drain(struct bpf_map *map,
+	   void *callback_fn, void *callback_ctx, u64 flags)
+{
+	return __bpf_user_ringbuf_drain(map, callback_fn, callback_ctx, flags);
+}
+EXPORT_SYMBOL(bpf_user_ringbuf_drain);
+
+
 const struct bpf_func_proto bpf_user_ringbuf_drain_proto = {
 	.func		= bpf_user_ringbuf_drain,
 	.ret_type	= RET_INTEGER,
-- 
2.30.2


