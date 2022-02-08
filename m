Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A916C4AE203
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 20:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385883AbiBHTNQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 14:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385876AbiBHTNP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 14:13:15 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ADEC0612C0
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 11:13:14 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so3889391pjb.1
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SHhi0nf9DwDJT6jlxRE82NHhaQvbXywIwRW67/6Cw64=;
        b=A3isYZUmhdEOOBMHNeGJqXEEoRCjACjFwq8puowHpKlGRzzxM8vutM8+wUGoGjB83Q
         XBsbraUTc4ySKe4h3sJ9j7/zjyVAy30ylE6rrUUvj/j0TmOQGT+aWa2FO+x4XdqcGFJ/
         1CgDLKs7vBbxqpGELvohQXkAR095/ZeAH7vbu9RtVV7KtvwXbDdMDNEq3zdKuxEuSxeB
         SJdwex6yVQe8iHJVn/Nb8GNFkPx1m4m8UC0NNDUFyNNHs4hACQqWg6TRywTWVPxskk80
         HlXF4wH63bl9H9G+vGgTT864DZUKW8McHh2KXgKfr9spTxO5rN1gUrSwC9vnjW/NvTyM
         453w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SHhi0nf9DwDJT6jlxRE82NHhaQvbXywIwRW67/6Cw64=;
        b=7hfvwFbPQ6SMHbumZv6+j3ZLyNffSfovjDAj3/KYgpaejWXzltiiwUB9XKAa0DBZlt
         ok47f5OvagZDwg7+iqPEikfImdjD5vnSghguCP750pB/Qk01UUaxJVfSFlQv9i6lmwvb
         RFWmAHloSFw8184ztwhAlb92wqKg5AxfAp7P5i4PH1WGCkKMe1fXYCx0rfewIgFCym6H
         5VmLaq5j6dqGY8pOBD4ssqOAx5872F+jaJqQbcccXdF2YBig2oh4og0FCRWvxvhHO4Hg
         Nc92n0LO86QzXKdF5ovkLTjLz9ZelgKlzaxvnYaY/XT2IPsaq5X1qWiYywpZxs3m5g+0
         Erew==
X-Gm-Message-State: AOAM530dc08d24fgPxuxRqEj/GH0jR3aSRIESOib1fFe0NfBs9jgmc27
        gByHoGgDjQPGDNP+7AcLafA=
X-Google-Smtp-Source: ABdhPJzWv7rXFIyX69Qw5OnR8talXT3PwF0eq25UszwJcHILIT10CO+hi0UUjEASAPg2YoBsmRubww==
X-Received: by 2002:a17:903:234c:: with SMTP id c12mr5974786plh.55.1644347594062;
        Tue, 08 Feb 2022 11:13:14 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::2:72b2])
        by smtp.gmail.com with ESMTPSA id f8sm17044697pfe.204.2022.02.08.11.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:13:13 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 2/5] libbpf: Prepare light skeleton for the kernel.
Date:   Tue,  8 Feb 2022 11:13:03 -0800
Message-Id: <20220208191306.6136-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
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
 tools/lib/bpf/skel_internal.h | 193 +++++++++++++++++++++++++++++++---
 1 file changed, 176 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index dcd3336512d4..d16544666341 100644
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
@@ -25,17 +35,11 @@
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
@@ -57,12 +61,159 @@ struct bpf_load_and_run_opts {
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
+	return kcalloc(1, size, GFP_KERNEL);
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
+ * skel_prep_init_value() allocates a region in user space process and copies
+ * potentially modified initial map value into it.
+ * The loader program will perform copy_from_user() from maps.rodata.initial_value.
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
+ * copy_from_user() from intial_value. Therefore the vm_mmap+copy_to_user step
+ * is need when lskel is used from the kernel module.
+ */
+static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
+{
+	if (addr && addr != ~0ULL)
+		vm_munmap(addr, sz);
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
+	__u64 ret = 0;
+	void *uaddr;
+
+	uaddr = (void *) vm_mmap(NULL, 0, mmap_sz, PROT_READ | PROT_WRITE,
+				 MAP_SHARED | MAP_ANONYMOUS, 0);
+	if (IS_ERR(uaddr))
+		goto out;
+	if (copy_to_user(uaddr, *addr, val_sz)) {
+		vm_munmap((long) uaddr, mmap_sz);
+		goto out;
+	}
+	ret = (__u64) (long) uaddr;
+out:
+	kvfree(*addr);
+	*addr = NULL;
+	return ret;
 }
 
+static inline void *skel_finalize_map_data(__u64 *addr, size_t mmap_sz, int flags, int fd)
+{
+	struct bpf_map *map;
+	void *ptr = NULL;
+
+	vm_munmap(*addr, mmap_sz);
+	*addr = ~0ULL;
+
+	map = bpf_map_get(fd);
+	if (IS_ERR(map))
+		return NULL;
+	if (map->map_type != BPF_MAP_TYPE_ARRAY)
+		goto out;
+	ptr = ((struct bpf_array *)map)->value;
+	/* the ptr stays valid, since FD is not closed */
+out:
+	bpf_map_put(map);
+	return ptr;
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
+static inline void *skel_finalize_map_data(__u64 *addr, size_t mmap_sz, int flags, int fd)
+{
+	return mmap((void *)*addr, mmap_sz, flags, MAP_SHARED | MAP_FIXED, fd, 0);
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

