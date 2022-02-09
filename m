Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B953B4AE97E
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiBIFqI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:46:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbiBIFnU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:43:20 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF0DC02B67C
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:43:23 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k17so1347431plk.0
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbVcXmIPmQyLODgw0PJDs9iU4v+QvE3xVvMgCxPsVro=;
        b=hvD9kOe7VVUmZXcG6+vtrQfOH/xCF2/q0H/0PsFOEZCjjrohMUbGgnOWBV0P7GJ2EO
         AEDY9htSHqPWJ1bTGQRFne4WTuwcyRt0Ab8Pa3ZMQnLga2Z22i11oymRt0V6h8RMMj4b
         Aiv+TB3CwsczBYgbzZ3CN87X462dpktw/VoG0Y7iULeIPi43yc3dba5axKiRgpFtaiSa
         v+JOKGncNLT0IcbR3wwmww9cPdfn5pG/SYlviKBlE9swoJyJnaQ7Xe0Nt7eIbzfTOfXw
         ro8/A5G6Mh+a8GHwwex24o17Xukq4EWAhr0z2epWF2Fj0+8ZO9itCgU5JDG93LemPpST
         ojZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbVcXmIPmQyLODgw0PJDs9iU4v+QvE3xVvMgCxPsVro=;
        b=kBd3MLMoViHK5jLblSCYlz96HWy/6MMuRJQgIYc8HQJoQ5iuXi+wRv5XRAjzlxm6a1
         RpOTxPnImxQiKqenbSza2sVexrSFATIvLsHUhH8gBoEMAdTCaWxu2kW0WWdeM43l8m/z
         8cAd46XzYzA7iFK9kMbinXV9Rch3sRtiYb8jSKOja5gP+WfDSNOIiDfO09WeGPJnxSFR
         mxUEgJ/CCjQHPJxoq6CUmdnT3eqXx/zgn4jJzGG1jArgHDUV/6m5MD+mAklNtX6Tyalm
         lwMXEHHCjOu3VM2bHAfZM8kZD/XGOg4suPwKdHVd7nLft2dJtlzmFzI6rilwJ390vGcR
         DBFQ==
X-Gm-Message-State: AOAM533nEsUFpzw9z3I+zh5jO4gDa9c5jpYM4BH4wvaBrJ+szkCOlfpl
        q3Dmhb17fJEoMsT0dtl9dos=
X-Google-Smtp-Source: ABdhPJwRoCt+Y2bLBwNUFfjBEg3bxLAKXsiNY5OoaeTXK8s/4wmzxbGzi7lFfYekdEnrdZyJWzkQbA==
X-Received: by 2002:a17:902:eb8c:: with SMTP id q12mr659498plg.131.1644385403226;
        Tue, 08 Feb 2022 21:43:23 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:cbf])
        by smtp.gmail.com with ESMTPSA id x126sm4458205pfb.117.2022.02.08.21.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 21:43:22 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 2/5] libbpf: Prepare light skeleton for the kernel.
Date:   Tue,  8 Feb 2022 21:43:12 -0800
Message-Id: <20220209054315.73833-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
References: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Prepare light skeleton to be used in the kernel module and in the user space.
The look and feel of lskel.h is mostly the same with the difference that for
user space the skel->rodata is the same pointer before and after skel_load
operation, while in the kernel the skel->rodata after skel_open and the
skel->rodata after skel_load are different pointers.
Typical usage of skeleton remains the same for kernel and user space:
skel = my_bpf__open();
skel->rodata->my_global_var = init_val;
err = my_bpf__load(skel);
err = my_bpf__attach(skel);
// access skel->rodata->my_global_var;
// access skel->bss->another_var;

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/gen_loader.c    |  15 ++-
 tools/lib/bpf/skel_internal.h | 195 ++++++++++++++++++++++++++++++----
 2 files changed, 189 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 8ecef1088ba2..927745b08014 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1043,18 +1043,27 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
 	value = add_data(gen, pvalue, value_size);
 	key = add_data(gen, &zero, sizeof(zero));
 
-	/* if (map_desc[map_idx].initial_value)
-	 *    copy_from_user(value, initial_value, value_size);
+	/* if (map_desc[map_idx].initial_value) {
+	 *    if (ctx->flags & BPF_SKEL_KERNEL)
+	 *        bpf_probe_read_kernel(value, value_size, initial_value);
+	 *    else
+	 *        bpf_copy_from_user(value, value_size, initial_value);
+	 * }
 	 */
 	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,
 			      sizeof(struct bpf_loader_ctx) +
 			      sizeof(struct bpf_map_desc) * map_idx +
 			      offsetof(struct bpf_map_desc, initial_value)));
-	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 4));
+	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 8));
 	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
 					 0, 0, 0, value));
 	emit(gen, BPF_MOV64_IMM(BPF_REG_2, value_size));
+	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6,
+			      offsetof(struct bpf_loader_ctx, flags)));
+	emit(gen, BPF_JMP_IMM(BPF_JSET, BPF_REG_0, BPF_SKEL_KERNEL, 2));
 	emit(gen, BPF_EMIT_CALL(BPF_FUNC_copy_from_user));
+	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 1));
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
 
 	map_update_attr = add_data(gen, &attr, attr_size);
 	move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index dcd3336512d4..a431144c922c 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -3,9 +3,19 @@
 #ifndef __SKEL_INTERNAL_H
 #define __SKEL_INTERNAL_H
 
+#ifdef __KERNEL__
+#include <linux/fdtable.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/slab.h>
+#include <linux/bpf.h>
+#else
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/mman.h>
+#include <stdlib.h>
+#include "bpf.h"
+#endif
 
 #ifndef __NR_bpf
 # if defined(__mips__) && defined(_ABIO32)
@@ -25,24 +35,23 @@
  * requested during loader program generation.
  */
 struct bpf_map_desc {
-	union {
-		/* input for the loader prog */
-		struct {
-			__aligned_u64 initial_value;
-			__u32 max_entries;
-		};
-		/* output of the loader prog */
-		struct {
-			int map_fd;
-		};
-	};
+	/* output of the loader prog */
+	int map_fd;
+	/* input for the loader prog */
+	__u32 max_entries;
+	__aligned_u64 initial_value;
 };
 struct bpf_prog_desc {
 	int prog_fd;
 };
 
+enum {
+	BPF_SKEL_KERNEL = (1ULL << 0),
+};
+
 struct bpf_loader_ctx {
-	size_t sz;
+	__u32 sz;
+	__u32 flags;
 	__u32 log_level;
 	__u32 log_size;
 	__u64 log_buf;
@@ -57,12 +66,154 @@ struct bpf_load_and_run_opts {
 	const char *errstr;
 };
 
+long bpf_sys_bpf(__u32 cmd, void *attr, __u32 attr_size);
+
 static inline int skel_sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
 			  unsigned int size)
 {
+#ifdef __KERNEL__
+	return bpf_sys_bpf(cmd, attr, size);
+#else
 	return syscall(__NR_bpf, cmd, attr, size);
+#endif
+}
+
+#ifdef __KERNEL__
+static inline int close(int fd)
+{
+	return close_fd(fd);
 }
 
+static inline void *skel_alloc(size_t size)
+{
+	struct bpf_loader_ctx *ctx = kzalloc(size, GFP_KERNEL);
+
+	if (!ctx)
+		return NULL;
+	ctx->flags |= BPF_SKEL_KERNEL;
+	return ctx;
+}
+
+static inline void skel_free(const void *p)
+{
+	kfree(p);
+}
+
+/* skel->bss/rodata maps are populated in three steps.
+ *
+ * For kernel use:
+ * skel_prep_map_data() allocates kernel memory that kernel module can directly access.
+ * skel_prep_init_value() copies rodata pointer into map.rodata.initial_value.
+ * The loader program will perform probe_read_kernel() from maps.rodata.initial_value.
+ * skel_finalize_map_data() sets skel->rodata to point to actual value in a bpf map and
+ * does maps.rodata.initial_value = ~0ULL to signal skel_free_map_data() that kvfree
+ * is not nessary.
+ *
+ * For user space:
+ * skel_prep_map_data() mmaps anon memory into skel->rodata that can be accessed directly.
+ * skel_prep_init_value() copies rodata pointer into map.rodata.initial_value.
+ * The loader program will perform copy_from_user() from maps.rodata.initial_value.
+ * skel_finalize_map_data() remaps bpf array map value from the kernel memory into
+ * skel->rodata address.
+ *
+ * The "bpftool gen skeleton -L" command generates lskel.h that is suitable for
+ * both kernel and user space. The generated loader program does
+ * either bpf_probe_read_kernel() or bpf_copy_from_user() from initial_value
+ * depending on bpf_loader_ctx->flags.
+ */
+static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
+{
+	if (addr != ~0ULL)
+		kvfree(p);
+	/* When addr == ~0ULL the 'p' points to
+	 * ((struct bpf_array *)map)->value. See skel_finalize_map_data.
+	 */
+}
+
+static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
+{
+	void *addr;
+
+	addr = kvmalloc(val_sz, GFP_KERNEL);
+	if (!addr)
+		return NULL;
+	memcpy(addr, val, val_sz);
+	return addr;
+}
+
+static inline __u64 skel_prep_init_value(void **addr, size_t mmap_sz, size_t val_sz)
+{
+	return (__u64) (long) *addr;
+}
+
+static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
+{
+	struct bpf_map *map;
+	void *addr = NULL;
+
+	kvfree((void *) (long) *init_val);
+	*init_val = ~0ULL;
+
+	/* At this point bpf_load_and_run() finished without error and
+	 * 'fd' is a valid bpf map FD. All sanity checks below should succeed.
+	 */
+	map = bpf_map_get(fd);
+	if (IS_ERR(map))
+		return NULL;
+	if (map->map_type != BPF_MAP_TYPE_ARRAY)
+		goto out;
+	addr = ((struct bpf_array *)map)->value;
+	/* the addr stays valid, since FD is not closed */
+out:
+	bpf_map_put(map);
+	return addr;
+}
+
+#else
+
+static inline void *skel_alloc(size_t size)
+{
+	return calloc(1, size);
+}
+
+static inline void skel_free(void *p)
+{
+	free(p);
+}
+
+static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
+{
+	munmap(p, sz);
+}
+
+static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
+{
+	void *addr;
+
+	addr = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
+		    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (addr == (void *) -1)
+		return NULL;
+	memcpy(addr, val, val_sz);
+	return addr;
+}
+
+static inline __u64 skel_prep_init_value(void **addr, size_t mmap_sz, size_t val_sz)
+{
+	return (__u64) (long) *addr;
+}
+
+static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
+{
+	void *addr;
+
+	addr = mmap((void *) (long) *init_val, mmap_sz, flags, MAP_SHARED | MAP_FIXED, fd, 0);
+	if (addr == (void *) -1)
+		return NULL;
+	return addr;
+}
+#endif
+
 static inline int skel_closenz(int fd)
 {
 	if (fd > 0)
@@ -136,22 +287,28 @@ static inline int skel_link_create(int prog_fd, int target_fd,
 	return skel_sys_bpf(BPF_LINK_CREATE, &attr, attr_sz);
 }
 
+#ifdef __KERNEL__
+#define set_err
+#else
+#define set_err err = -errno
+#endif
+
 static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 {
 	int map_fd = -1, prog_fd = -1, key = 0, err;
 	union bpf_attr attr;
 
-	map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4, opts->data_sz, 1);
+	err = map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4, opts->data_sz, 1);
 	if (map_fd < 0) {
 		opts->errstr = "failed to create loader map";
-		err = -errno;
+		set_err;
 		goto out;
 	}
 
 	err = skel_map_update_elem(map_fd, &key, opts->data, 0);
 	if (err < 0) {
 		opts->errstr = "failed to update loader map";
-		err = -errno;
+		set_err;
 		goto out;
 	}
 
@@ -166,10 +323,10 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 	attr.log_size = opts->ctx->log_size;
 	attr.log_buf = opts->ctx->log_buf;
 	attr.prog_flags = BPF_F_SLEEPABLE;
-	prog_fd = skel_sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
+	err = prog_fd = skel_sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
 	if (prog_fd < 0) {
 		opts->errstr = "failed to load loader prog";
-		err = -errno;
+		set_err;
 		goto out;
 	}
 
@@ -181,10 +338,12 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 	if (err < 0 || (int)attr.test.retval < 0) {
 		opts->errstr = "failed to execute loader prog";
 		if (err < 0) {
-			err = -errno;
+			set_err;
 		} else {
 			err = (int)attr.test.retval;
+#ifndef __KERNEL__
 			errno = -err;
+#endif
 		}
 		goto out;
 	}
-- 
2.30.2

