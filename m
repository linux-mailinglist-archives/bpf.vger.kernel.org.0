Return-Path: <bpf+bounces-5330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7D4759A38
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24211C2108F
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B116430;
	Wed, 19 Jul 2023 15:51:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185F156D1
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 15:51:24 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C77E1FFB;
	Wed, 19 Jul 2023 08:51:00 -0700 (PDT)
X-QQ-mid: bizesmtpipv603t1689781842tx00
Received: from ppw-Alienware-m16-R1.hsd1.co.co ( [255.72.231.8])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 19 Jul 2023 23:50:36 +0800 (CST)
X-QQ-SSF: 01400000000000D0Z000000A0000020
X-QQ-FEAT: 27H4dUct9tjNLmDiXhKyaB6+TfRlgRaiNjUHcWBaNSm8tEF1YJspeVHPM4OC7
	4//7tS7WzACT1INXSSwuoFAIzOrviPGzkWTWfCjFuIUe0lmxoGH+CWVDz9lz4gy/BuuIIz2
	j/nRbhBuiUerJSAWle+dyeKcS5mwD5trI5vw91fVSo/WW5g/VVpVZxBMctItij3ktdOoYyF
	d+Tcbnlww9/CGD5aGZTPhV5arYUG8i+QGasRFV+MwVNW/fp9GknQE3CMjr19jkyKBeXFhX/
	hLTFKdW1buy9vo+R/wGC+K4OzGu5tBvfOGrvMHvrmvsgGQVrCFR82u9GQ4k+rXJGRXqN+8n
	MFDqg8KOl1mYE2p/goLUkSHaQBp6ppfGrcO+xdCFg8117tH5EVj1T9lbeFMzwydR4Yzrwko
	AeEbAI6KFwA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 307596821782074127
From: wzc@smail.nju.edu.cn
To: linux-kernel@vger.kernel.org
Cc: jmorris@namei.org,
	ast@kernel.org,
	kpsingh@kernel.org,
	keescook@chromium.org,
	bpf@vger.kernel.org,
	yueqi.chen@colorado.edu,
	linux-hardening@vger.kernel.org,
	Zicheng Wang <wzc@smail.nju.edu.cn>
Subject: [PATCH RFC] HotBPF: Prevent Kernel Heap-based Exploitation
Date: Wed, 19 Jul 2023 09:50:32 -0600
Message-Id: <20230719155032.4972-1-wzc@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Zicheng Wang <wzc@smail.nju.edu.cn>

Request for Comments, a hot eBPF patch to prevent kernel heap exploitation.

SLUB exploitation poses a significant threat to kernel security. The exploitation
takes advantage of the fact that kernel objects share `kmalloc` slub caches.
This sharing setting allows to create overlapping between vulnerable objects that
introduce corruption, and other objects that contains sensitive data.
To mitigate this, we introduce HotBPF.

The key idea of HotBPF is to isolate vulnerable objects in isolated slub caches.
The slots in the isolated slub cache are only recycled for objects of the same type,
in the same size, with the same privilege, and allocated from the same site. As such,
we can not only prevent exploits that perform heap fengshui within or across caches,
but also hinders the newest data only attack like dirty cred, dirty page table, etc.

HotBPF is implemented using eBPF programs which are installed to intercept the
`call __kmalloc` or `call kmem_cache_alloc_trace` of vulnerable object, creating
isolated caches and storing objects in them.

We add 3 new eBPF helper functions for allocation:
1) `bpf_create_slub_cache(size, gfp_flags, ip_size_priv_zone)`: create a new slub
cache according to the allocation address, user privileges, size, and zone.
2) `bpf_cache_alloc(cache, gfp_flags)`: allocate objects in the new slub cache.
3) `bpf_jmp_next(pt_regs, nextip, newobj)`: skip to the next instruction after
`call kmalloc` and make kernel use new allocated objects.

After the objects’ life time ends, `kfree` can release the slot as usual.

We have evaluated HotBPF on v5.15.
The average overhead using LMBench and PhoronixBench (sockbench,osbench, apache,
sqlite, 7zip, ffmpeg, openssl, redis) is ~0.2% for one vulnerability and ~2% for
>40 vulnerabilities simultaneously.

Limitation: isolating I/O related slub objects is not supported thus far.

For illustration, we include two examples in attached patches. One is to isolate
`struct seq_operations` allocated in `single_open()` function.
Another is to isolate struct bio in `bio_kmalloc()` function. A diagram illustrating
the isolation of struct seq_operations is as follow.

/*
ffffffff813371a0 <single_open>:
...
ffffffff813371c5:    call <kmem_cache_alloc_trace><--------skip this instruction
ffffffff813371ca:    test %rax, %rax                                 |
                           ^                                         |
                           |                                         |
                           |                                         |
                           +-----------------------------------------+
                                      isolate object
                                    kernel uses the isolated seq_operations
 */

Since this is an initialization email, we cannot cover all details but only to provide a
high-level idea. We look forward to constructive comments and promise to respond to any
questions as promptly as possible.

Signed-off-by: Zicheng Wang <wzc@smail.nju.edu.cn>

---
 include/linux/bpf.h               |   3 +
 include/uapi/linux/bpf.h          |  22 ++++
 kernel/trace/bpf_trace.c          |  75 +++++++++++++
 lib/Kconfig.debug                 |  18 +++
 samples/bpf/hotbpf_example_kern.c | 180 ++++++++++++++++++++++++++++++
 samples/bpf/hotbpf_example_user.c |  89 +++++++++++++++
 6 files changed, 387 insertions(+)
 create mode 100644 samples/bpf/hotbpf_example_kern.c
 create mode 100644 samples/bpf/hotbpf_example_user.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3db6f6c95489..1a12af0b7347 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2105,6 +2105,9 @@ extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
 extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
 extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
+extern const struct bpf_func_proto bpf_create_slub_cache_proto;
+extern const struct bpf_func_proto bpf_cache_alloc_proto;
+extern const struct bpf_func_proto bpf_jmp_next_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 791f31dd0abe..2a0b03f4f2fc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4877,6 +4877,25 @@ union bpf_attr {
  *		Get the struct pt_regs associated with **task**.
  *	Return
  *		A pointer to struct pt_regs.
+ *
+ * long bpf_create_slub_cache(u32 size, u32 gfp_flags, u64 ip_size_priv_type)
+ *	Description
+ *		Create a new slab cache according to the ip/size/privilege/zone
+ *	Return
+ *		The cache's address or NULL.
+ *
+ * long bpf_cache_alloc(u64 cache, u32 gfp_flags)
+ *	Description
+ *		allocate memory objects from the slab cache
+ *	Return
+ *		The allocated memory or NULL.
+ *
+ * long bpf_jmp_next(struct pt_regs *ctx, u64 nextip, u64 ret)
+ *	Description
+ *		jump the `call kmalloc`'s next instruction, and set rax.
+ *	Return
+ *		0.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5055,6 +5074,9 @@ union bpf_attr {
 	FN(get_func_ip),		\
 	FN(get_attach_cookie),		\
 	FN(task_pt_regs),		\
+	FN(create_slub_cache),		\
+	FN(cache_alloc),		\
+	FN(jmp_next),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8e2eb950aa82..6847e9d78b06 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1017,6 +1017,73 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_pe = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+#ifdef CONFIG_HOTBPF
+
+BPF_CALL_3(bpf_create_slub_cache, u32, size, u32, gfp_flags, u64, ip_size_priv_type)
+{
+	slab_flags_t sflags = 0;
+	struct kmem_cache *new_cache;
+	char new_cache_name[64];
+
+	if (gfp_flags & ___GFP_DMA)
+		sflags |= SLAB_CACHE_DMA;
+
+	if (gfp_flags & ___GFP_RECLAIMABLE)
+		sflags |= SLAB_RECLAIM_ACCOUNT;
+
+	if (gfp_flags & ___GFP_ACCOUNT)
+		sflags |= SLAB_ACCOUNT;
+
+	snprintf(new_cache_name, sizeof(new_cache_name), "hotbpf_0x%x_%llx",
+				size, ip_size_priv_type);
+	new_cache = kmem_cache_create(new_cache_name, size, 4096, sflags, NULL);
+
+	return (u64)new_cache;
+}
+
+const struct bpf_func_proto bpf_create_slub_cache_proto = {
+	.func		= bpf_create_slub_cache,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_2(bpf_cache_alloc, u64, cache, u32, gfp_flags)
+{
+	struct kmem_cache *s = (struct kmem_cache *) cache;
+
+	return (u64)kmem_cache_alloc(s, gfp_flags);
+}
+
+const struct bpf_func_proto bpf_cache_alloc_proto = {
+	.func		= bpf_cache_alloc,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_3(bpf_jmp_next, struct pt_regs *, ctx, u64, nextip, u64, ret)
+{
+	ctx->ip = nextip;
+	ctx->ax = ret;
+	return 0;
+}
+
+const struct bpf_func_proto bpf_jmp_next_proto = {
+	.func		= bpf_jmp_next,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg1_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING,
+};
+
+#endif
+
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1132,6 +1199,14 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_snprintf_proto;
 	case BPF_FUNC_get_func_ip:
 		return &bpf_get_func_ip_proto_tracing;
+#ifdef CONFIG_HOTBPF
+	case BPF_FUNC_create_slub_cache:
+		return &bpf_create_slub_cache_proto;
+	case BPF_FUNC_cache_alloc:
+		return &bpf_cache_alloc_proto;
+	case BPF_FUNC_jmp_next:
+		return &bpf_jmp_next_proto;
+#endif
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2a9b6dcdac4f..2a27d8fcc196 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1,6 +1,24 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "Kernel hacking"
 
+menu "HotBPF heap vulnerability fast patch"
+
+config HOTBPF
+	bool "activate HotBPF for kmalloc"
+	depends on BPF && FUNCTION_ERROR_INJECTION && SLUB
+	help
+	  selecting this option activates HotBPF, a feature designed to
+	  inhibit kernel heap-based exploitation by utilizing eBPF programs.
+	  It mitigates the risk of overlap between victim and attack payload
+	  objects by isolating victim objects in a designated slub cache.
+	  Each cache is uniquely distinguished based on its allocation address,
+	  user privileges, size, and zone.
+
+	  examples are in samples/bpf/hotbpf_example
+
+
+endmenu
+
 menu "printk and dmesg options"
 
 config PRINTK_TIME
diff --git a/samples/bpf/hotbpf_example_kern.c b/samples/bpf/hotbpf_example_kern.c
new file mode 100644
index 000000000000..b1b3203c2ec5
--- /dev/null
+++ b/samples/bpf/hotbpf_example_kern.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HotBPF example kernel side
+ * Copyright Zicheng Wang, Yueqi Chen
+ */
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <uapi/linux/ptrace.h>
+#include <uapi/linux/bpf.h>
+#include <linux/version.h>
+#include <bpf/bpf_helpers.h>
+
+#define ___GFP_DMA		0x01u
+#define ___GFP_RECLAIMABLE	0x10u
+#define ___GFP_ACCOUNT		0x400000u
+
+
+struct kmem_cache {
+	unsigned long cpu_slab;
+	unsigned int flags;
+	unsigned long min_partial;
+	unsigned int size;
+	unsigned int object_size;
+	unsigned long reciprocal_size;
+	unsigned int offset;
+	unsigned int cpu_partial;
+	unsigned int oo;
+	unsigned int max;
+	unsigned int min;
+	unsigned int allocflags;
+	int refcount;
+    /* size: 8408, cachelines: 132, members: 26 */
+    /* sum members: 8392, holes: 4, sum holes: 16 */
+    /* paddings: 1, sum paddings: 2 */
+    /* last cacheline: 24 bytes */
+};
+
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 40960);
+	__type(key, u64);	// ip^size^priv^zone
+	__type(value, u64);	// cache addr
+} key2cache SEC(".maps");
+
+u64 get_key(u64 ip, u32 size, u32 uid, u32 zone)
+{
+	return ip ^ (u64) size ^ (u64) uid ^ (u64) zone;
+}
+
+u32 get_size(u32 size)
+{
+	u32 ret = (size + 4096) / 4096;
+
+	return (ret + 1) * 4096;
+}
+
+u32 get_zone(u32 gfp_flags)
+{
+	u32 ret = 0;
+
+	if (gfp_flags & ___GFP_DMA)
+		ret = 1;
+	else if (gfp_flags & ___GFP_RECLAIMABLE)
+		ret = 2;
+	else if (gfp_flags & ___GFP_ACCOUNT)
+		ret = 3;
+
+	return ret;
+}
+
+// ffffffff813371a0 <single_open>:
+// ...
+// ffffffff813371c5:   call   ffffffff812d61b0 <kmem_cache_alloc_trace>
+// ffffffff813371ca:   test   %rax,%rax
+
+// void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
+// python3 -c 'print(hex(0xffffffff813371c5-0xffffffff813371a0))'
+SEC("kprobe/single_open+0x25")
+int BPF_KPROBE(HANDLE_kmem_cache_alloc_trace)
+{
+	u64 ip = ctx->ip;
+	u64 *pv;
+	struct kmem_cache *cache = (struct kmem_cache *) ctx->di;
+	u64 alloc_size = BPF_CORE_READ(cache, size);
+	u32 gfp_flags = (u32) ctx->si;
+	u32 uid = bpf_get_current_uid_gid() >> 32;
+	u32 zone = get_zone(gfp_flags);
+	u64 key = get_key(ip, alloc_size, uid, zone);
+	u64 cache_addr = 0;
+	u64 alloc_addr = 0;
+	int err = 0;
+
+    // if there is a slab cache
+	u64 *pcache = bpf_map_lookup_elem(&key2cache, &key);
+
+	if (!pcache) {
+		cache_addr = bpf_create_slub_cache(alloc_size, gfp_flags, key);
+		if (!cache_addr) {
+			bpf_printk("probe create cache failed\n");
+			return -1;
+		}
+		err = bpf_map_update_elem(&key2cache, &key, &cache_addr, BPF_ANY);
+		if (err < 0) {
+			bpf_printk("update key2cache failed: %d\n", err);
+			return err;
+		}
+	}
+
+	// alloc a new object
+	cache_addr = *pcache;
+	alloc_addr = bpf_cache_alloc(cache_addr, gfp_flags);
+	if (alloc_addr == 0) {
+		bpf_printk("probe kmalloc failed\n");
+		return -1;
+	}
+	bpf_printk("===HotBPF isolate single_open %lx===\n", alloc_addr);
+
+	bpf_jmp_next(ctx, ip + 0x4, alloc_addr);
+
+	return 0;
+}
+
+
+// ffffffff81534d70 <bio_kmalloc>:
+// ...
+// ffffffff81534d9a:   call   ffffffff812d70e0 <__kmalloc>
+// ffffffff81534d9f:   test   %rax,%rax
+
+// void *__kmalloc(size_t size, gfp_t flags)
+// python3 -c 'print(hex(0xffffffff81534d9a-0xffffffff81534d70))'
+SEC("kprobe/bio_kmalloc+0x2a")
+int BPF_KPROBE(HANDLE___kmalloc)
+{
+	u64 ip = ctx->ip;
+	u64 *pv;
+	u64 alloc_size = get_size(ctx->di);
+	u32 gfp_flags = (u32) ctx->si;
+	u32 uid = bpf_get_current_uid_gid() >> 32;
+	u32 zone = get_zone(gfp_flags);
+	u64 key = get_key(ip, alloc_size, uid, zone);
+	u64 cache_addr = 0;
+	u64 alloc_addr = 0;
+	int err = 0;
+
+	// if there is a slab cache
+	u64 *pcache = bpf_map_lookup_elem(&key2cache, &key);
+
+	if (!pcache) {
+		cache_addr = bpf_create_slub_cache(alloc_size, gfp_flags, key);
+		if (!cache_addr) {
+			bpf_printk("probe create cache failed\n");
+			return -1;
+		}
+		err = bpf_map_update_elem(&key2cache, &key, &cache_addr, BPF_ANY);
+		if (err < 0) {
+			bpf_printk("update key2cache failed: %d\n", err);
+			return err;
+		}
+	} else {
+		cache_addr = *pcache;
+	}
+
+	// alloc a new object
+	alloc_addr = bpf_cache_alloc(cache_addr, gfp_flags);
+	if (alloc_addr == 0) {
+		bpf_printk("probe kmalloc failed\n");
+		return -1;
+	}
+	bpf_printk("===HotBPF isolate bio_kmalloc %lx===\n", alloc_addr);
+
+	bpf_jmp_next(ctx, ip + 0x4, alloc_addr);
+
+	return 0;
+}
+
+
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
diff --git a/samples/bpf/hotbpf_example_user.c b/samples/bpf/hotbpf_example_user.c
new file mode 100644
index 000000000000..04a68d5a9910
--- /dev/null
+++ b/samples/bpf/hotbpf_example_user.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HotBPF example user side
+ * Copyright Zicheng Wang, Yueqi Chen
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/resource.h>
+#include <bpf/libbpf.h>
+#include <fcntl.h>
+static sig_atomic_t stop;
+
+static void sig_int(int signo)
+{
+	stop = 1;
+}
+
+int main(int argc, char **argv)
+{
+	struct bpf_link *links[2];
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	char filename[256];
+	int j = 0;
+	int trace_fd;
+
+	trace_fd = open("/sys/kernel/debug/tracing/trace_pipe", O_RDONLY, 0);
+	if (trace_fd < 0) {
+		printf("cannot open trace_pipe %d\n", trace_fd);
+		return trace_fd;
+	}
+
+	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+
+	obj = bpf_object__open_file(filename, NULL);
+	if (libbpf_get_error(obj)) {
+		fprintf(stderr, "ERROR: opening BPF object file failed\n");
+		return 0;
+	}
+
+	/* load BPF program */
+	if (bpf_object__load(obj)) {
+		fprintf(stderr, "ERROR: loading BPF object file failed\n");
+		goto cleanup;
+	}
+
+
+	bpf_object__for_each_program(prog, obj) {
+		links[j] = bpf_program__attach(prog);
+		if (libbpf_get_error(links[j])) {
+			fprintf(stderr, "ERROR: bpf_program__attach failed\n");
+			links[j] = NULL;
+			goto cleanup;
+		}
+		j++;
+	}
+
+	if (signal(SIGINT, sig_int) == SIG_ERR) {
+		fprintf(stderr, "can't set signal handler: %s\n", strerror(errno));
+		goto cleanup;
+	}
+
+	printf("Please run `sudo cat /sys/kernel/debug/tracing/trace_pipe` "
+			"to see output of the BPF programs.\n");
+
+
+	printf("start tracing\n");
+	while (!stop) {
+		static char buf[4096];
+		ssize_t sz;
+
+		sz = read(trace_fd, buf, sizeof(buf) - 1);
+		if (sz > 0) {
+			buf[sz] = '\0';
+			puts(buf);
+		}
+	}
+
+cleanup:
+	for (j--; j >= 0; j--)
+		bpf_link__destroy(links[j]);
+	bpf_object__close(obj);
+	close(trace_fd);
+
+	return 0;
+}
-- 
2.34.1


