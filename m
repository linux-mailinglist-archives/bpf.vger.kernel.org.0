Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC13120AC
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 02:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhBGBLz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 20:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhBGBLx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 20:11:53 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9107AC061786
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 17:11:13 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z22so7964785qto.7
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 17:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otgOeoYCDQUQhuP2LtXmMhwn3dnl+sJWTV8ebcGXgmI=;
        b=Z0CdyQq1fhroPaKw6ygez8WWAkQxli4tgMBqN29WPCMYX/ldDyJ6ZHb0E7gSNzL887
         +L9gkBV0nu22vOQxmFgAW/6bc7/42LE/eevBp4nTRmOES0rEB70aSBuEg5E3sKzZR6ON
         sKBXqL1zhcoJfCI3i8scSzwHMQTfj1fYewKBTQHSsxLWP8nZhSf1lHbsLVRxLMpyhoqT
         qb1cg4niRDEDDpZOHAA9Eh8uAsp/8uLFNEP+4APPznUMgSyHAcMEQh0VPITKK8Ss0J3e
         SLSoF6giUDAx8aJh1CLi0uvlQJn+Yy2mzSOhltc3J4E5h+2FrZK0ZAhNId4YqKdmnesr
         weOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otgOeoYCDQUQhuP2LtXmMhwn3dnl+sJWTV8ebcGXgmI=;
        b=GT8pABL8zrSd9DBlzLfrpHRH2tP5BL58xx+z+UQUvjamG1483x9JWNBDR8LJ0sSjDN
         qqZ3ajVp22VdtoMCHvcAwajtRHVQS8hEaQjv7nBMUW/MzH45RhI6Y+oIq+MKtfNU2qhJ
         4xhyLZEGcwFpAmiaS56dt4+QAc4TwIxehTJ0gODrd4o6cqd0UcWJmxcGSQuNhCPA43a1
         dJTgQQDQyj2r7nLThW1nJb0P7Yhg6wbLejvaJi7lXuiQkikmV15glwQKuf4PrLIjeYwm
         mOWZ7+DmGAW3o4ph/8QP1hM31cXksFroXqauLkiNM0lvXzWkZIkeRu8mcUFki12v6ryb
         qzYg==
X-Gm-Message-State: AOAM530f8noH/qsCrftXnGc4kZAHFPWcV6Cnvw+GXVrvRYJlcVHoP/Qg
        NNLApYsbzp969cGVw68mz/EisbLSaIKl3w==
X-Google-Smtp-Source: ABdhPJxAiwh90uL8AXdH3LKTbnmWTGVLEedNmTptLcSAW+ebb23a4Y2oPoX0rAiYZ04kVm2fleF3Vw==
X-Received: by 2002:ac8:3a65:: with SMTP id w92mr10431946qte.267.1612660272200;
        Sat, 06 Feb 2021 17:11:12 -0800 (PST)
Received: from localhost (pool-100-33-73-206.nycmny.fios.verizon.net. [100.33.73.206])
        by smtp.gmail.com with ESMTPSA id e15sm9401878qtq.43.2021.02.06.17.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Feb 2021 17:11:11 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v3 2/4] selftest/bpf: adjust expected verifier errors
Date:   Sat,  6 Feb 2021 20:10:25 -0500
Message-Id: <20210207011027.676572-3-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210207011027.676572-1-andreimatei1@gmail.com>
References: <20210207011027.676572-1-andreimatei1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier errors around stack accesses have changed slightly in the
previous commit (generally for the better).

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 .../selftests/bpf/verifier/basic_stack.c      |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  4 ++--
 .../testing/selftests/bpf/verifier/const_or.c |  4 ++--
 .../bpf/verifier/helper_access_var_len.c      | 12 +++++-----
 .../testing/selftests/bpf/verifier/int_ptr.c  |  6 ++---
 .../selftests/bpf/verifier/raw_stack.c        | 10 ++++-----
 .../selftests/bpf/verifier/stack_ptr.c        | 22 +++++++++++--------
 tools/testing/selftests/bpf/verifier/unpriv.c |  2 +-
 .../testing/selftests/bpf/verifier/var_off.c  | 16 +++++++-------
 9 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/basic_stack.c b/tools/testing/selftests/bpf/verifier/basic_stack.c
index b56f8117c09d..f995777dddb3 100644
--- a/tools/testing/selftests/bpf/verifier/basic_stack.c
+++ b/tools/testing/selftests/bpf/verifier/basic_stack.c
@@ -4,7 +4,7 @@
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, 8, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid stack",
+	.errstr = "invalid write to stack",
 	.result = REJECT,
 },
 {
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index c4f5d909e58a..eb888c8479c3 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1228,7 +1228,7 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.fixup_map_hash_8b = { 23 },
 	.result = REJECT,
-	.errstr = "invalid read from stack off -16+0 size 8",
+	.errstr = "invalid read from stack R7 off=-16 size=8",
 },
 {
 	"calls: two calls that receive map_value via arg=ptr_stack_of_caller. test1",
@@ -1958,7 +1958,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 6 },
-	.errstr = "invalid indirect read from stack off -8+0 size 8",
+	.errstr = "invalid indirect read from stack R2 off -8+0 size 8",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_XDP,
 },
diff --git a/tools/testing/selftests/bpf/verifier/const_or.c b/tools/testing/selftests/bpf/verifier/const_or.c
index 6c214c58e8d4..0719b0ddec04 100644
--- a/tools/testing/selftests/bpf/verifier/const_or.c
+++ b/tools/testing/selftests/bpf/verifier/const_or.c
@@ -23,7 +23,7 @@
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid stack type R1 off=-48 access_size=58",
+	.errstr = "invalid indirect access to stack R1 off=-48 size=58",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 },
@@ -54,7 +54,7 @@
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid stack type R1 off=-48 access_size=58",
+	.errstr = "invalid indirect access to stack R1 off=-48 size=58",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 },
diff --git a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
index 87c4e7900083..0ab7f1dfc97a 100644
--- a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
@@ -39,7 +39,7 @@
 	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack off -64+0 size 64",
+	.errstr = "invalid indirect read from stack R1 off -64+0 size 64",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 },
@@ -59,7 +59,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid stack type R1 off=-64 access_size=65",
+	.errstr = "invalid indirect access to stack R1 off=-64 size=65",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 },
@@ -136,7 +136,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid stack type R1 off=-64 access_size=65",
+	.errstr = "invalid indirect access to stack R1 off=-64 size=65",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 },
@@ -156,7 +156,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid stack type R1 off=-64 access_size=65",
+	.errstr = "invalid indirect access to stack R1 off=-64 size=65",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 },
@@ -194,7 +194,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack off -64+0 size 64",
+	.errstr = "invalid indirect read from stack R1 off -64+0 size 64",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 },
@@ -584,7 +584,7 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack off -64+32 size 64",
+	.errstr = "invalid indirect read from stack R1 off -64+32 size 64",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 },
diff --git a/tools/testing/selftests/bpf/verifier/int_ptr.c b/tools/testing/selftests/bpf/verifier/int_ptr.c
index ca3b4729df66..070893fb2900 100644
--- a/tools/testing/selftests/bpf/verifier/int_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/int_ptr.c
@@ -27,7 +27,7 @@
 	},
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
-	.errstr = "invalid indirect read from stack off -16+0 size 8",
+	.errstr = "invalid indirect read from stack R4 off -16+0 size 8",
 },
 {
 	"ARG_PTR_TO_LONG half-uninitialized",
@@ -59,7 +59,7 @@
 	},
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
-	.errstr = "invalid indirect read from stack off -16+4 size 8",
+	.errstr = "invalid indirect read from stack R4 off -16+4 size 8",
 },
 {
 	"ARG_PTR_TO_LONG misaligned",
@@ -125,7 +125,7 @@
 	},
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
-	.errstr = "invalid stack type R4 off=-4 access_size=8",
+	.errstr = "invalid indirect access to stack R4 off=-4 size=8",
 },
 {
 	"ARG_PTR_TO_LONG initialized",
diff --git a/tools/testing/selftests/bpf/verifier/raw_stack.c b/tools/testing/selftests/bpf/verifier/raw_stack.c
index 193d9e87d5a9..cc8e8c3cdc03 100644
--- a/tools/testing/selftests/bpf/verifier/raw_stack.c
+++ b/tools/testing/selftests/bpf/verifier/raw_stack.c
@@ -11,7 +11,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
-	.errstr = "invalid read from stack off -8+0 size 8",
+	.errstr = "invalid read from stack R6 off=-8 size=8",
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 },
 {
@@ -59,7 +59,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
-	.errstr = "invalid stack type R3",
+	.errstr = "invalid zero-sized read",
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 },
 {
@@ -205,7 +205,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
-	.errstr = "invalid stack type R3 off=-513 access_size=8",
+	.errstr = "invalid indirect access to stack R3 off=-513 size=8",
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 },
 {
@@ -221,7 +221,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
-	.errstr = "invalid stack type R3 off=-1 access_size=8",
+	.errstr = "invalid indirect access to stack R3 off=-1 size=8",
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 },
 {
@@ -285,7 +285,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
-	.errstr = "invalid stack type R3 off=-512 access_size=0",
+	.errstr = "invalid zero-sized read",
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 },
 {
diff --git a/tools/testing/selftests/bpf/verifier/stack_ptr.c b/tools/testing/selftests/bpf/verifier/stack_ptr.c
index 8bfeb77c60bd..07eaa04412ae 100644
--- a/tools/testing/selftests/bpf/verifier/stack_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/stack_ptr.c
@@ -44,7 +44,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
-	.errstr = "invalid stack off=-79992 size=8",
+	.errstr = "invalid write to stack R1 off=-79992 size=8",
 	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
 },
 {
@@ -57,7 +57,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
-	.errstr = "invalid stack off=0 size=8",
+	.errstr = "invalid write to stack R1 off=0 size=8",
 },
 {
 	"PTR_TO_STACK check high 1",
@@ -106,7 +106,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.errstr = "invalid stack off=0 size=1",
+	.errstr = "invalid write to stack R1 off=0 size=1",
 	.result = REJECT,
 },
 {
@@ -119,7 +119,8 @@
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
-	.errstr = "invalid stack off",
+	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
+	.errstr = "invalid write to stack R1",
 },
 {
 	"PTR_TO_STACK check high 6",
@@ -131,7 +132,8 @@
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
-	.errstr = "invalid stack off",
+	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
+	.errstr = "invalid write to stack",
 },
 {
 	"PTR_TO_STACK check high 7",
@@ -183,7 +185,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.errstr = "invalid stack off=-513 size=1",
+	.errstr = "invalid write to stack R1 off=-513 size=1",
 	.result = REJECT,
 },
 {
@@ -208,7 +210,8 @@
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
-	.errstr = "invalid stack off",
+	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
+	.errstr = "invalid write to stack",
 },
 {
 	"PTR_TO_STACK check low 6",
@@ -220,7 +223,8 @@
 	BPF_EXIT_INSN(),
 	},
 	.result = REJECT,
-	.errstr = "invalid stack off",
+	.errstr = "invalid write to stack",
+	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
 },
 {
 	"PTR_TO_STACK check low 7",
@@ -292,7 +296,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.result_unpriv = REJECT,
-	.errstr_unpriv = "invalid stack off=0 size=1",
+	.errstr_unpriv = "invalid write to stack R1 off=0 size=1",
 	.result = ACCEPT,
 	.retval = 42,
 },
diff --git a/tools/testing/selftests/bpf/verifier/unpriv.c b/tools/testing/selftests/bpf/verifier/unpriv.c
index ee298627abae..b018ad71e0a8 100644
--- a/tools/testing/selftests/bpf/verifier/unpriv.c
+++ b/tools/testing/selftests/bpf/verifier/unpriv.c
@@ -108,7 +108,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 3 },
-	.errstr_unpriv = "invalid indirect read from stack off -8+0 size 8",
+	.errstr_unpriv = "invalid indirect read from stack R2 off -8+0 size 8",
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 },
diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index 8504ac937809..49b78a1a261b 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -18,7 +18,7 @@
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
 {
-	"variable-offset stack access",
+	"variable-offset stack read, priv vs unpriv",
 	.insns = {
 	/* Fill the top 8 bytes of the stack */
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
@@ -63,7 +63,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "R4 unbounded indirect variable offset stack access",
+	.errstr = "invalid unbounded variable-offset indirect access to stack R4",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
 },
@@ -88,7 +88,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 5 },
-	.errstr = "R2 max value is outside of stack bound",
+	.errstr = "invalid variable-offset indirect access to stack R2",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
@@ -113,7 +113,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 5 },
-	.errstr = "R2 min value is outside of stack bound",
+	.errstr = "invalid variable-offset indirect access to stack R2",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
@@ -138,7 +138,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 5 },
-	.errstr = "invalid indirect read from stack var_off",
+	.errstr = "invalid indirect read from stack R2 var_off",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
@@ -163,7 +163,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 5 },
-	.errstr = "invalid indirect read from stack var_off",
+	.errstr = "invalid indirect read from stack R2 var_off",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
@@ -189,7 +189,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 6 },
-	.errstr_unpriv = "R2 stack pointer arithmetic goes out of range, prohibited for !root",
+	.errstr_unpriv = "R2 variable stack access prohibited for !root",
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
@@ -217,7 +217,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack var_off",
+	.errstr = "invalid indirect read from stack R4 var_off",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
 },
-- 
2.27.0

