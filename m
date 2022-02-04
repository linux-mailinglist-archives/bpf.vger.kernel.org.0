Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5385E4AA426
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 00:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378005AbiBDXRU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 18:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiBDXRU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 18:17:20 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D7DFDA6E4
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 15:17:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z5so6390862plg.8
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 15:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UYODaeY9R2B2JnqLrZ6rCIiYeLQeCLssHwMEt39uLGQ=;
        b=kkQ8o1cMtYF1Mtu4hB6IlDgzH4UUPQqz4/Wa4yfh38pVYanYZboRqOSM1P7LATYiUA
         WIYt1Y7C0aKJ09aUVopzdzlF0Ex3cBjMQpEMQTuZyjYv7o+z4wWpvIcQZ7mBmbWHPSht
         kxkp98oM9Zd98NUG0H2iIy+AumVNa1TEyRJgtYLZtJskGK12WQZjuU5Z7TgpNjTeL6aQ
         Syj6ur2p0vPxnxv1I+h8G6rhPr2FhvA+ZyFtuwyRnqch96/zCWDap+opUl5LBZJTYrVG
         eXtvSD8ngvkOmwxMfSpyD0iL9+lfCEuyPSB2yJ2ik1Wwpoeo0J5mUvl/NTvdwWWSLwWC
         NEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYODaeY9R2B2JnqLrZ6rCIiYeLQeCLssHwMEt39uLGQ=;
        b=yWfmu03mlJhIALeYfc0wBuRCZsRRgFCshpQJ8UzNFmZeHPzgXIdS+dsX5/vSaH2NgM
         GpvbjgcQwdaw/D4uQSQb+kAYigIYpphfkNytkrEZP6rda3iq8OYCP3qH5xtdb603q9Oh
         cPRbDBdUiLSnCCtTZAmmYdZojPAVa2AcvuTcaIyH5Zx/mmkd+4/PpixJnhrUR5+Haov6
         17894foJV4nuUFOP7ehW1oa0iNZ9pfg9mMCv4xD/hvqO16rfk9604+FDuRBRm9Tqrzw7
         RomQtQKRK5UKs7uesndE5JH5Ze1wi/h/W3ASPp+i0UKJEj1rhb4MfFgyIBXZAwoOXgsE
         0gBw==
X-Gm-Message-State: AOAM5325QTZ39kc4Urb1BXVmNPxuV/l+iT1qvXrw34FlqTiIfFsltfV/
        WBTAxGhxRugF5+yz1yUs7iM=
X-Google-Smtp-Source: ABdhPJx+AQ0OTFnHKCktERXpv3sQALbbV0ZUgxe5S0RGNDLsWwhlxKl4sp7NPwOXMu03zDZCZ7v1zg==
X-Received: by 2002:a17:90b:4d8c:: with SMTP id oj12mr1507831pjb.10.1644016638793;
        Fri, 04 Feb 2022 15:17:18 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:e4ee])
        by smtp.gmail.com with ESMTPSA id f15sm3505842pfn.19.2022.02.04.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:17:18 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 2/5] libbpf: Prepare light skeleton for the kernel.
Date:   Fri,  4 Feb 2022 15:17:07 -0800
Message-Id: <20220204231710.25139-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220204231710.25139-1-alexei.starovoitov@gmail.com>
References: <20220204231710.25139-1-alexei.starovoitov@gmail.com>
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
 tools/lib/bpf/skel_internal.h | 168 +++++++++++++++++++++++++++++++---
 1 file changed, 153 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index dcd3336512d4..4d99ef8cbbba 100644
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
@@ -25,16 +35,12 @@
  * requested during loader program generation.
  */
 struct bpf_map_desc {
-	union {
-		/* input for the loader prog */
-		struct {
-			__aligned_u64 initial_value;
-			__u32 max_entries;
-		};
+	struct {
 		/* output of the loader prog */
-		struct {
-			int map_fd;
-		};
+		int map_fd;
+		/* input for the loader prog */
+		__u32 max_entries;
+		__aligned_u64 initial_value;
 	};
 };
 struct bpf_prog_desc {
@@ -57,11 +63,135 @@ struct bpf_load_and_run_opts {
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
+static inline void *skel_alloc(size_t size)
+{
+	return kcalloc(1, size, GFP_KERNEL);
+}
+static inline void skel_free(const void *p)
+{
+	kfree(p);
+}
+static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
+{
+	if (addr && addr != ~0ULL)
+		vm_munmap(addr, sz);
+	if (addr != ~0ULL)
+		kvfree(p);
+}
+/* skel->bss/rodata maps are populated in three steps.
+ *
+ * For kernel use:
+ * skel_prep_map_data() allocates kernel memory that kernel module can directly access.
+ * skel_prep_init_value() allocates a region in user space process and copies
+ * potentially modified initial map value into it.
+ * The loader program will perform copy_from_user() from maps.rodata.initial_value.
+ * skel_finalize_map_data() sets skel->rodata to point to actual value in a bpf map.
+ *
+ * For user space:
+ * skel_prep_map_data() mmaps anon memory into skel->rodata that can be accessed directly.
+ * skel_prep_init_value() copies rodata pointer into map.rodata.initial_value.
+ * The loader program will perform copy_from_user() from maps.rodata.initial_value.
+ * skel_finalize_map_data() remaps bpf array map value from the kernel memory into
+ * skel->rodata address.
+ */
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
+#else
+static inline void *skel_alloc(size_t size)
+{
+	return calloc(1, size);
+}
+static inline void skel_free(void *p)
+{
+	free(p);
+}
+static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
+{
+	munmap(p, sz);
+}
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
+static inline __u64 skel_prep_init_value(void **addr, size_t mmap_sz, size_t val_sz)
+{
+	return (__u64) (long) *addr;
+}
+static inline void *skel_finalize_map_data(__u64 *addr, size_t mmap_sz, int flags, int fd)
+{
+	return mmap((void *)*addr, mmap_sz, flags, MAP_SHARED | MAP_FIXED, fd, 0);
+}
+#endif
 
 static inline int skel_closenz(int fd)
 {
@@ -136,22 +266,28 @@ static inline int skel_link_create(int prog_fd, int target_fd,
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
 
@@ -166,10 +302,10 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
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
 
@@ -181,10 +317,12 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
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

