Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A9844F001
	for <lists+bpf@lfdr.de>; Sat, 13 Nov 2021 00:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhKLXXQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 18:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhKLXXQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 18:23:16 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3304DC061766
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 15:20:25 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so8169047pjb.5
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 15:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UvTYB36cMA6r2Z6eadUH/W4+XG/Vd7tSWvehQOwerLo=;
        b=lb1QKtQIdcrSDA0kCAKe4DZC+NVuadiT587kleeDyJb74g0n14vm02v+UzC6wTBFLb
         fIvef7PQoMREZHdfPT0EXV16T8jWG8PIROwL5SgYK01GpM6azxnCVOQILu7eR31S1qFj
         ZwW1GlBmait/rojvKxkO0jEicDS6BgK3YlQy1B6Yd/SAJfhQDIRLX1GJq8yW5SrNa/iA
         PCiBE0Hz6/6qD6TPtqnOz0AftyCQ8UZCJQGSQ3GYpl+bCcmqMnkbzMsZX7q7TgzaZoRh
         sDSK/GDNXZ8RVh+iY/JlwgzSsTy0oaMH/6N5GaCsk2w41iesLrUrxIWBhKlbvjud/N0A
         KTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UvTYB36cMA6r2Z6eadUH/W4+XG/Vd7tSWvehQOwerLo=;
        b=pGZ/9/J9TegnQRWlUfXvGrllfRQWr2DL9xatDnzGiW61o5Z+zKY1JI9WS636ZQN/H6
         tHsJPwyeZ/zvXTrra5vr6wY5wi4/TfDgSsE0dOFLjVuKaSHlq+X68NiTndio6bNmTrVR
         VM1JpIs2n4i3vsEXVirE/kXKY1H9Qa8Tmvw41FcTQrbNW8NAJ4wslR7aWs4/fm2nbe4q
         lGN9TutaW5sM9EHHIUgS8LNIQcNmflDrjYANJtFVjFMutEaUYbiPY9gfBDztzDnkMUWj
         6oF0lOzrqFLYS/N7rawr19T4Pv6fiGvmdVa1xKsuszyK5KN6n7FtVylT6UizZ0hAUVuo
         YmHw==
X-Gm-Message-State: AOAM531eNw0wYw8wQKTWZT1q7bTBfP2W8fRn+ndqd0ZJTNOymiHtiPHT
        B5T6FsqZ3nIMT9DmjqHjg/BxpUWPEP8=
X-Google-Smtp-Source: ABdhPJwyS6LovtKXUfRsm7QSrgfCQrZzGehBT4rbvgxhYWaf7i+b6tILsuGeew++gys5XixgT9Jb1w==
X-Received: by 2002:a17:902:758b:b0:13e:8b1:e49f with SMTP id j11-20020a170902758b00b0013e08b1e49fmr12608084pll.6.1636759224499;
        Fri, 12 Nov 2021 15:20:24 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id hk18sm13311196pjb.20.2021.11.12.15.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 15:20:24 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf v2] libbpf: Perform map fd cleanup for gen_loader in case of error
Date:   Sat, 13 Nov 2021 04:50:22 +0530
Message-Id: <20211112232022.899074-1-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei reported a fd leak issue in gen loader (when invoked from
bpftool) [0]. When adding ksym support, map fd allocation was moved from
stack to loader map, however I missed closing these fds (relevant when
cleanup label is jumped to on error). For the success case, the
allocated fd is returned in loader ctx, hence this problem is not
noticed.

Make three changes, first MAX_USED_MAPS in MAX_FD_ARRAY_SZ instead of
MAX_USED_PROGS, the braino was not a problem until now for this case as
we didn't try to close map fds (otherwise use of it would have tried
closing 32 additional fds in ksym btf fd range). Then, do a cleanup for
all nr_maps fds in cleanup label code, so that in case of error all
temporary map fds from bpf_gen__map_create are closed.

Then, adjust the cleanup label to only generate code for the required
number of program and map fds.  To trim code for remaining program
fds, lay out prog_fd array in stack in the end, so that we can
directly skip the remaining instances.  Still stack size remains same,
since changing that would require changes in a lot of places
(including adjustment of stack_off macro), so nr_progs_sz variable is
only used to track required number of iterations (and jump over
cleanup size calculated from that), stack offset calculation remains
unaffected.

The difference for test_ksyms_module.o is as follows:
libbpf: //prog cleanup iterations: before = 34, after = 5
libbpf: //maps cleanup iterations: before = 64, after = 2

Also, move allocation of gen->fd_array offset to bpf_gen__init. Since
offset can now be 0, and we already continue even if add_data returns 0
in case of failure, we do not need to distinguish between 0 offset and
failure case 0, as we rely on bpf_gen__finish to check errors. We can
also skip check for gen->fd_array in add_*_fd functions, since
bpf_gen__init will take care of it.

  [0]: https://lore.kernel.org/bpf/CAADnVQJ6jSitKSNKyxOrUzwY2qDRX0sPkJ=VLGHuCLVJ=qOt9g@mail.gmail.com

Fixes: 18f4fccbf314 ("libbpf: Update gen_loader to emit BTF_KIND_FUNC relocations")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
v1 -> v2
 * Only generate cleanup code for nr_progs/nr_maps (Alexei)
 * Reorder gen->fd_array init to start of bpf_gen__init (Alexei)
 * Don't reorder add_data
---
 tools/lib/bpf/bpf_gen_internal.h |  4 +--
 tools/lib/bpf/gen_loader.c       | 47 ++++++++++++++++++++------------
 tools/lib/bpf/libbpf.c           |  4 +--
 3 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 75ca9fb857b2..cc486a77db65 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -47,8 +47,8 @@ struct bpf_gen {
 	int nr_fd_array;
 };

-void bpf_gen__init(struct bpf_gen *gen, int log_level);
-int bpf_gen__finish(struct bpf_gen *gen);
+void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps);
+int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps);
 void bpf_gen__free(struct bpf_gen *gen);
 void bpf_gen__load_btf(struct bpf_gen *gen, const void *raw_data, __u32 raw_size);
 void bpf_gen__map_create(struct bpf_gen *gen, struct bpf_create_map_params *map_attr, int map_idx);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 7b73f97b1fa1..4746fb1949b2 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -18,7 +18,7 @@
 #define MAX_USED_MAPS	64
 #define MAX_USED_PROGS	32
 #define MAX_KFUNC_DESCS 256
-#define MAX_FD_ARRAY_SZ (MAX_USED_PROGS + MAX_KFUNC_DESCS)
+#define MAX_FD_ARRAY_SZ (MAX_USED_MAPS + MAX_KFUNC_DESCS)

 /* The following structure describes the stack layout of the loader program.
  * In addition R6 contains the pointer to context.
@@ -33,8 +33,8 @@
  */
 struct loader_stack {
 	__u32 btf_fd;
-	__u32 prog_fd[MAX_USED_PROGS];
 	__u32 inner_map_fd;
+	__u32 prog_fd[MAX_USED_PROGS];
 };

 #define stack_off(field) \
@@ -42,6 +42,11 @@ struct loader_stack {

 #define attr_field(attr, field) (attr + offsetof(union bpf_attr, field))

+static int blob_fd_array_off(struct bpf_gen *gen, int index)
+{
+	return gen->fd_array + index * sizeof(int);
+}
+
 static int realloc_insn_buf(struct bpf_gen *gen, __u32 size)
 {
 	size_t off = gen->insn_cur - gen->insn_start;
@@ -102,11 +107,15 @@ static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn in
 	emit(gen, insn2);
 }

-void bpf_gen__init(struct bpf_gen *gen, int log_level)
+static int add_data(struct bpf_gen *gen, const void *data, __u32 size);
+static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off);
+
+void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps)
 {
-	size_t stack_sz = sizeof(struct loader_stack);
+	size_t stack_sz = sizeof(struct loader_stack), nr_progs_sz;
 	int i;

+	gen->fd_array = add_data(gen, NULL, MAX_FD_ARRAY_SZ * sizeof(int));
 	gen->log_level = log_level;
 	/* save ctx pointer into R6 */
 	emit(gen, BPF_MOV64_REG(BPF_REG_6, BPF_REG_1));
@@ -118,19 +127,27 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level)
 	emit(gen, BPF_MOV64_IMM(BPF_REG_3, 0));
 	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));

+	/* amount of stack actually used, only used to calculate iterations, not stack offset */
+	nr_progs_sz = offsetof(struct loader_stack, prog_fd[nr_progs + 1]);
 	/* jump over cleanup code */
 	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
-			      /* size of cleanup code below */
-			      (stack_sz / 4) * 3 + 2));
+			      /* size of cleanup code below (including map fd cleanup) */
+			      (nr_progs_sz / 4) * 3 + 2 +
+			      /* 6 insns for emit_sys_close_blob,
+			       * 6 insns for debug_regs in emit_sys_close_blob
+			       */
+			      (nr_maps * (6 + (gen->log_level ? 6 : 0)))));

 	/* remember the label where all error branches will jump to */
 	gen->cleanup_label = gen->insn_cur - gen->insn_start;
 	/* emit cleanup code: close all temp FDs */
-	for (i = 0; i < stack_sz; i += 4) {
+	for (i = 0; i < nr_progs_sz; i += 4) {
 		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -stack_sz + i));
 		emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
 		emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
 	}
+	for (i = 0; i < nr_maps; i++)
+		emit_sys_close_blob(gen, blob_fd_array_off(gen, i));
 	/* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
 	emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
 	emit(gen, BPF_EXIT_INSN());
@@ -160,8 +177,6 @@ static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
  */
 static int add_map_fd(struct bpf_gen *gen)
 {
-	if (!gen->fd_array)
-		gen->fd_array = add_data(gen, NULL, MAX_FD_ARRAY_SZ * sizeof(int));
 	if (gen->nr_maps == MAX_USED_MAPS) {
 		pr_warn("Total maps exceeds %d\n", MAX_USED_MAPS);
 		gen->error = -E2BIG;
@@ -174,8 +189,6 @@ static int add_kfunc_btf_fd(struct bpf_gen *gen)
 {
 	int cur;

-	if (!gen->fd_array)
-		gen->fd_array = add_data(gen, NULL, MAX_FD_ARRAY_SZ * sizeof(int));
 	if (gen->nr_fd_array == MAX_KFUNC_DESCS) {
 		cur = add_data(gen, NULL, sizeof(int));
 		return (cur - gen->fd_array) / sizeof(int);
@@ -183,11 +196,6 @@ static int add_kfunc_btf_fd(struct bpf_gen *gen)
 	return MAX_USED_MAPS + gen->nr_fd_array++;
 }

-static int blob_fd_array_off(struct bpf_gen *gen, int index)
-{
-	return gen->fd_array + index * sizeof(int);
-}
-
 static int insn_bytes_to_bpf_size(__u32 sz)
 {
 	switch (sz) {
@@ -359,10 +367,15 @@ static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off)
 	__emit_sys_close(gen);
 }

-int bpf_gen__finish(struct bpf_gen *gen)
+int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 {
 	int i;

+	if (nr_progs != gen->nr_progs || nr_maps != gen->nr_maps) {
+		pr_warn("progs/maps mismatch\n");
+		gen->error = -EFAULT;
+		return gen->error;
+	}
 	emit_sys_close_stack(gen, stack_off(btf_fd));
 	for (i = 0; i < gen->nr_progs; i++)
 		move_stack2ctx(gen,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index de7e09a6b5ec..f6faa33c80fa 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7263,7 +7263,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	}

 	if (obj->gen_loader)
-		bpf_gen__init(obj->gen_loader, attr->log_level);
+		bpf_gen__init(obj->gen_loader, attr->log_level, obj->nr_programs, obj->nr_maps);

 	err = bpf_object__probe_loading(obj);
 	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
@@ -7282,7 +7282,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 		for (i = 0; i < obj->nr_maps; i++)
 			obj->maps[i].fd = -1;
 		if (!err)
-			err = bpf_gen__finish(obj->gen_loader);
+			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}

 	/* clean up fd_array */
--
2.33.1

