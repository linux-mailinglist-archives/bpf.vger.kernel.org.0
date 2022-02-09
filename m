Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7F4B011D
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 00:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiBIXUT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 18:20:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiBIXUO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 18:20:14 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C45EE068F47
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 15:20:10 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k17so329801plk.0
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 15:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yPwa01tjsPWnUCJ/o5n8GKsg45JKysgRtc7XDrF3PRs=;
        b=UkfhR5AIwqEaAtfG8PEBvMrmyPeZ3c4STsXeWWON18JPM2rka7le5AtCpJexSMe6kC
         4uDgX3fzUf7QF+q6aeR7VVPAomWMxEDABwIJE1+SIaHEyqgW2GegIxyOqSKFXOog1HR5
         ENCNMhwS95scTI5ONCLrivwvZeOr7gnTK/F3NxWd07vzSa3tCVmxrYOnlwxUiA8IS519
         HXF+RoFZoiYXGcf2yN368Vyi3W18E/4U3h8m0jxM3Vif14QErzNHxXvVJ3n5+4qrSztI
         EeFVcq1QXVhWSZ83SNjX5HuB6kDa/9tOzAnhy5cK8UJgYWUcYVCAT2bfG1dIh2gsvg4V
         KmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPwa01tjsPWnUCJ/o5n8GKsg45JKysgRtc7XDrF3PRs=;
        b=gOu9ndRGWrcBh2rs/zFyuDddyCaBfX8SRVKa8FbC0VMv9qdrPN6/VizMjD18SXq9Nf
         wXBgFkQ19Jg9w1N54wPfs6/bfajD4I1+HgFDA7GCKmGud70f3kZs3Of7rQaDSOyFg0E5
         g/RsNEglDYDjrNya3m8+cESxAAfTecq0ske51AwKEVO74hPMh6Mtui+W6yVoZ1MFzstB
         b4zmBUreQGV5YU0I3xd0WRLaSHEho5njlUzxEbR3FG6B6fBjx6hWXROhVAotQSstqsxP
         j87WGT2irXSGxYdQ4PhpxsTYw6kXMUNX7NfX2V2i2UDCFGWMENZZK4RWQHvDxI7iIZ5o
         iuwQ==
X-Gm-Message-State: AOAM532XnJb/3THBkhwhZeKf3xoDej2O6zODuU5c8q6/8zCcLe4mBabW
        GISY7rDsRQkADqRx8SlUVSs=
X-Google-Smtp-Source: ABdhPJyBO5MAVM1ZyscZnGHB1KeLz+XiokfO4ZhIEPp3P6TXCOwf5dgbcXqlVbCkl2eSD1XmCBjQGQ==
X-Received: by 2002:a17:902:a9c2:: with SMTP id b2mr4517245plr.168.1644448809460;
        Wed, 09 Feb 2022 15:20:09 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::2:9eba])
        by smtp.gmail.com with ESMTPSA id f5sm20466224pfc.0.2022.02.09.15.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:20:08 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 2/5] libbpf: Prepare light skeleton for the kernel.
Date:   Wed,  9 Feb 2022 15:19:58 -0800
Message-Id: <20220209232001.27490-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220209232001.27490-1-alexei.starovoitov@gmail.com>
References: <20220209232001.27490-1-alexei.starovoitov@gmail.com>
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

Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/gen_loader.c    |  15 ++-
 tools/lib/bpf/skel_internal.h | 185 ++++++++++++++++++++++++++++++----
 2 files changed, 179 insertions(+), 21 deletions(-)

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
index dcd3336512d4..bd6f4505e7b1 100644
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
@@ -57,12 +66,144 @@ struct bpf_load_and_run_opts {
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
+}
+
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
+/* skel->bss/rodata maps are populated the following way:
+ *
+ * For kernel use:
+ * skel_prep_map_data() allocates kernel memory that kernel module can directly access.
+ * Generated lskel stores the pointer in skel->rodata and in skel->maps.rodata.initial_value.
+ * The loader program will perform probe_read_kernel() from maps.rodata.initial_value.
+ * skel_finalize_map_data() sets skel->rodata to point to actual value in a bpf map and
+ * does maps.rodata.initial_value = ~0ULL to signal skel_free_map_data() that kvfree
+ * is not nessary.
+ *
+ * For user space:
+ * skel_prep_map_data() mmaps anon memory into skel->rodata that can be accessed directly.
+ * Generated lskel stores the pointer in skel->rodata and in skel->maps.rodata.initial_value.
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
 }
 
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
@@ -136,22 +277,28 @@ static inline int skel_link_create(int prog_fd, int target_fd,
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
 
@@ -166,10 +313,10 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
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
 
@@ -181,10 +328,12 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
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

