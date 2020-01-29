Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C704014D29F
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2020 22:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgA2VhC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jan 2020 16:37:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42824 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgA2VhB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jan 2020 16:37:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so465052pgb.9
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2020 13:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RDJvmSC05VOf/stL9p8O+7h9hNRl+T3s/8BaANNZGT8=;
        b=RkiLlqZ8CqT/LpycA1kUYiia5rBR9OZOT0jcy+A9iybkekhQ1h4zWGP0KycA/V///x
         o986scDQbE3SMWpSSWa4oT1VCVwqKLqNCm4FdIMYZ+5GgMAl4Ze25HMxBh0kLipku5Wh
         90v4DeoT/E8xaqDSdkjg80x14Q2NWnQD1DhvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RDJvmSC05VOf/stL9p8O+7h9hNRl+T3s/8BaANNZGT8=;
        b=OCxEtOq+rZNiaiRgzVuVzG1mkU25D8PZufj3T/eYdWisnzaEBHx7+qj9StD15T0xI8
         9E1n3XCUZEuCdqWlg0tTz6Vv/KLTb5hYlCWs539OE0Q0tgxsw4Ysksxug78o+Labd+49
         pJZDVW0Zr+Qxrqd2bgGQDg7iMHkzYJSPo52+IC4Ycepny8BQTvBpvMqiKkeHBT8qRMR4
         YzddsOsmPy5YIW/9B+Aw1CkJmhP7FVSOl6ya2KPEvcpmHPataUMtrl1twjnG3yu0cEv8
         Co8pxqOGnxIJS0/Bqp9itbeLXa9qlvor8boMUNl2hniP+1oKLcof6tvSN+mfczs5GkYX
         1UVg==
X-Gm-Message-State: APjAAAWu5m4YJqPfdmE9hZ2pIxPhEtyugr2F437iy+wBOG4y45LHOC0m
        riV+nHiaPa2SP4F3vgdue6Kctg==
X-Google-Smtp-Source: APXvYqzyPQqo1V/goi2qe7ia1r8g3MOEaHfi0xGzguk6OJCyAPZBIT9fuT0A/cNPJEI4cdvBXk+F/A==
X-Received: by 2002:a63:de03:: with SMTP id f3mr1170693pgg.141.1580333820733;
        Wed, 29 Jan 2020 13:37:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b65sm3820195pgc.18.2020.01.29.13.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 13:36:59 -0800 (PST)
Date:   Wed, 29 Jan 2020 13:36:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
Subject: [PATCH] bpf: Avoid function casting when calculating immediate
Message-ID: <202001291335.31F425A198@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In an effort to enable -Wcast-function-type in the top-level Makefile
to support Control Flow Integrity builds, rework the BPF instruction
immediate calculation macros to avoid mismatched function pointers. Since
these calculations are only ever between function address (these are
not function calls, just address calculations), they can be cast to u64
instead, where the result will be assigned to the s32 insn->imm.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/filter.h |  6 +++---
 kernel/bpf/hashtab.c   |  6 +++---
 kernel/bpf/verifier.c  | 21 +++++++--------------
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f349e2c0884c..b5beee7bf2ea 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -340,8 +340,8 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 
 /* Function call */
 
-#define BPF_CAST_CALL(x)					\
-		((u64 (*)(u64, u64, u64, u64, u64))(x))
+#define BPF_FUNC_IMM(FUNC)					\
+		((u64)(FUNC) - (u64)__bpf_call_base)
 
 #define BPF_EMIT_CALL(FUNC)					\
 	((struct bpf_insn) {					\
@@ -349,7 +349,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.dst_reg = 0,					\
 		.src_reg = 0,					\
 		.off   = 0,					\
-		.imm   = ((FUNC) - __bpf_call_base) })
+		.imm   = BPF_FUNC_IMM(FUNC) })
 
 /* Raw code statement block */
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 2d182c4ee9d9..325656a61708 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -517,7 +517,7 @@ static u32 htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 
 	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
 		     (void *(*)(struct bpf_map *map, void *key))NULL));
-	*insn++ = BPF_EMIT_CALL(BPF_CAST_CALL(__htab_map_lookup_elem));
+	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
 				offsetof(struct htab_elem, key) +
@@ -558,7 +558,7 @@ static u32 htab_lru_map_gen_lookup(struct bpf_map *map,
 
 	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
 		     (void *(*)(struct bpf_map *map, void *key))NULL));
-	*insn++ = BPF_EMIT_CALL(BPF_CAST_CALL(__htab_map_lookup_elem));
+	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 4);
 	*insn++ = BPF_LDX_MEM(BPF_B, ref_reg, ret,
 			      offsetof(struct htab_elem, lru_node) +
@@ -1749,7 +1749,7 @@ static u32 htab_of_map_gen_lookup(struct bpf_map *map,
 
 	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
 		     (void *(*)(struct bpf_map *map, void *key))NULL));
-	*insn++ = BPF_EMIT_CALL(BPF_CAST_CALL(__htab_map_lookup_elem));
+	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 2);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
 				offsetof(struct htab_elem, key) +
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1cc945daa9c8..70b4e47c2214 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9054,8 +9054,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			    insn->src_reg != BPF_PSEUDO_CALL)
 				continue;
 			subprog = insn->off;
-			insn->imm = BPF_CAST_CALL(func[subprog]->bpf_func) -
-				    __bpf_call_base;
+			insn->imm = BPF_FUNC_IMM(func[subprog]->bpf_func);
 		}
 
 		/* we use the aux data to keep a list of the start addresses
@@ -9429,28 +9428,22 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 
 			switch (insn->imm) {
 			case BPF_FUNC_map_lookup_elem:
-				insn->imm = BPF_CAST_CALL(ops->map_lookup_elem) -
-					    __bpf_call_base;
+				insn->imm = BPF_FUNC_IMM(ops->map_lookup_elem);
 				continue;
 			case BPF_FUNC_map_update_elem:
-				insn->imm = BPF_CAST_CALL(ops->map_update_elem) -
-					    __bpf_call_base;
+				insn->imm = BPF_FUNC_IMM(ops->map_update_elem);
 				continue;
 			case BPF_FUNC_map_delete_elem:
-				insn->imm = BPF_CAST_CALL(ops->map_delete_elem) -
-					    __bpf_call_base;
+				insn->imm = BPF_FUNC_IMM(ops->map_delete_elem);
 				continue;
 			case BPF_FUNC_map_push_elem:
-				insn->imm = BPF_CAST_CALL(ops->map_push_elem) -
-					    __bpf_call_base;
+				insn->imm = BPF_FUNC_IMM(ops->map_push_elem);
 				continue;
 			case BPF_FUNC_map_pop_elem:
-				insn->imm = BPF_CAST_CALL(ops->map_pop_elem) -
-					    __bpf_call_base;
+				insn->imm = BPF_FUNC_IMM(ops->map_pop_elem);
 				continue;
 			case BPF_FUNC_map_peek_elem:
-				insn->imm = BPF_CAST_CALL(ops->map_peek_elem) -
-					    __bpf_call_base;
+				insn->imm = BPF_FUNC_IMM(ops->map_peek_elem);
 				continue;
 			}
 
-- 
2.20.1


-- 
Kees Cook
