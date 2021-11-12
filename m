Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D69544EDE1
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 21:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhKLU1S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 15:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhKLU1R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 15:27:17 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9212CC061766
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 12:24:26 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y8so3862927plg.1
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 12:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HPXbpCvd21s1hlRivU+xTNTuH9s/JB2h7Y1MhOU9w6w=;
        b=YV8H8ByEVp6Lhyc6J5la4AYSV9OCwRho94u7EEdM2QEJUPMwQ0t8NU8ndu3nGFTPki
         6S40S/Ap8JobOiyc6YNPC/aXtzbFL1xPY2fKpEzEv65L5FS5kxvr1uPglXhBmUPdFuAc
         TFz/n7x68KrcIE7cxJxvs6A0x/RJAx7YwpdKUJl6pvIR+V14nw6FDf+mTC/8uXnZy5aJ
         +ST/HDNqTzM0sJLd7X/2gHnHzy//rnoekOGFK79VwlTwmZeN/xka4nSz1dLyDNCKvwfq
         Q8ZqLSWu3rLb8ZFd0uJI2+LKdmpcvzOA0uzuss3l0INLtqgOOyAy9s+Az3jUAtCirBV4
         Ahhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HPXbpCvd21s1hlRivU+xTNTuH9s/JB2h7Y1MhOU9w6w=;
        b=ZEu8veWbkCJkbdNFvProw44yvoQUx6btlBOt+Y16AonavmyXzCj8PX3pSnT/lci1b/
         2d5cYTKcIQ6v5fnbaPQwP6wIs5WAWZlvqBnVaV78MVIh7uI9ytFsXGjJZlJ91QXPxX6h
         4dce+TrLW6rqnARuEWS1JH1Yx0Mntt88uSaVNvMzcNszCSDJ5YsBa6zDxAG+dYhOpHxb
         tKIoQCnAkJEm2qz8h6c7EuBWhCWdCH4KzbEUvk/0vrMRZvzEsHjMlOzZbTpT2sFUTcV9
         SW1ze++/pitjDrR7q3KkoJSYnQu6PuZGcgEbmBpYP4qaJTxg1wyWGQby79Ms+N3I327M
         39ng==
X-Gm-Message-State: AOAM533eqn+kHrlgvCnZBV9zXa1honoj/Z7D1nntTBiHVYVuwHi3Hxbf
        PlqJuDzNWCaS1974kSs/agv03GvwI6k=
X-Google-Smtp-Source: ABdhPJyYhfeLlazPmfFHp6lg8kjcGgRfhlNRzim59SoaAHK3Ga6FdREKUFxMYxcAPhzFp+lMlokAKg==
X-Received: by 2002:a17:90a:bf8a:: with SMTP id d10mr20867042pjs.67.1636748665826;
        Fri, 12 Nov 2021 12:24:25 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id g17sm7445820pfv.136.2021.11.12.12.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 12:24:25 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf] libbpf: Perform map fd cleanup for gen_loader in case of error
Date:   Sat, 13 Nov 2021 01:54:21 +0530
Message-Id: <20211112202421.720179-1-memxor@gmail.com>
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

Make two fixes, first MAX_USED_MAPS in MAX_FD_ARRAY_SZ instead of
MAX_USED_PROGS, the braino was not a problem until now for this case as
we didn't try to close map fds (otherwise use of it would have tried
closing 32 additional fds in ksym btf fd range). Then, do a cleanup for
all MAX_USED_MAPS fds in cleanup label code, so that in case of error
all temporary map fds from bpf_gen__map_create are closed.

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
 tools/lib/bpf/gen_loader.c | 67 ++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 7b73f97b1fa1..558479c13c77 100644
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
@@ -102,6 +107,27 @@ static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn in
 	emit(gen, insn2);
 }
 
+static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
+{
+	__u32 size8 = roundup(size, 8);
+	__u64 zero = 0;
+	void *prev;
+
+	if (realloc_data_buf(gen, size8))
+		return 0;
+	prev = gen->data_cur;
+	if (data) {
+		memcpy(gen->data_cur, data, size);
+		memcpy(gen->data_cur + size, &zero, size8 - size);
+	} else {
+		memset(gen->data_cur, 0, size8);
+	}
+	gen->data_cur += size8;
+	return prev - gen->data_start;
+}
+
+static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off);
+
 void bpf_gen__init(struct bpf_gen *gen, int log_level)
 {
 	size_t stack_sz = sizeof(struct loader_stack);
@@ -120,8 +146,12 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level)
 
 	/* jump over cleanup code */
 	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
-			      /* size of cleanup code below */
-			      (stack_sz / 4) * 3 + 2));
+			      /* size of cleanup code below (including map fd cleanup) */
+			      (stack_sz / 4) * 3 + 2 + (MAX_USED_MAPS *
+			      /* 6 insns for emit_sys_close_blob,
+			       * 6 insns for debug_regs in emit_sys_close_blob
+			       */
+			      (6 + (gen->log_level ? 6 : 0)))));
 
 	/* remember the label where all error branches will jump to */
 	gen->cleanup_label = gen->insn_cur - gen->insn_start;
@@ -131,37 +161,19 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level)
 		emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
 		emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
 	}
+	gen->fd_array = add_data(gen, NULL, MAX_FD_ARRAY_SZ * sizeof(int));
+	for (i = 0; i < MAX_USED_MAPS; i++)
+		emit_sys_close_blob(gen, blob_fd_array_off(gen, i));
 	/* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
 	emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
 	emit(gen, BPF_EXIT_INSN());
 }
 
-static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
-{
-	__u32 size8 = roundup(size, 8);
-	__u64 zero = 0;
-	void *prev;
-
-	if (realloc_data_buf(gen, size8))
-		return 0;
-	prev = gen->data_cur;
-	if (data) {
-		memcpy(gen->data_cur, data, size);
-		memcpy(gen->data_cur + size, &zero, size8 - size);
-	} else {
-		memset(gen->data_cur, 0, size8);
-	}
-	gen->data_cur += size8;
-	return prev - gen->data_start;
-}
-
 /* Get index for map_fd/btf_fd slot in reserved fd_array, or in data relative
  * to start of fd_array. Caller can decide if it is usable or not.
  */
 static int add_map_fd(struct bpf_gen *gen)
 {
-	if (!gen->fd_array)
-		gen->fd_array = add_data(gen, NULL, MAX_FD_ARRAY_SZ * sizeof(int));
 	if (gen->nr_maps == MAX_USED_MAPS) {
 		pr_warn("Total maps exceeds %d\n", MAX_USED_MAPS);
 		gen->error = -E2BIG;
@@ -174,8 +186,6 @@ static int add_kfunc_btf_fd(struct bpf_gen *gen)
 {
 	int cur;
 
-	if (!gen->fd_array)
-		gen->fd_array = add_data(gen, NULL, MAX_FD_ARRAY_SZ * sizeof(int));
 	if (gen->nr_fd_array == MAX_KFUNC_DESCS) {
 		cur = add_data(gen, NULL, sizeof(int));
 		return (cur - gen->fd_array) / sizeof(int);
@@ -183,11 +193,6 @@ static int add_kfunc_btf_fd(struct bpf_gen *gen)
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
-- 
2.33.1

