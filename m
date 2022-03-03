Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E704CB5FD
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 05:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiCCEvt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 23:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiCCEvs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 23:51:48 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F618164D12
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 20:51:03 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id t11so4473245ioi.7
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 20:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KMkbAw3Kp5EU/cxL2G8cv6kwfEfWhomGZ5srHO4udII=;
        b=gUy78XL/jhztpJGUxU+WwzFsRT4vvY16WHta3XvuIvzl81dcAHD5O7Bb0OYLfkohyJ
         h4FWv3FfwSW3WnjEGcfO9MdlaVQyS47wJ6muUnXl+QfjASgwPu8LXmJHGlcmCGLURdx9
         JpXP4mEvAnw+NiEK2Dxu+Nz04XUhHOdFKLAO15kDKb6AOWRyr8ku98t1S+nZ8WQNW7rS
         X9mie4pdEXUrQ+hk8Y4y7qulsQ3gHSkf5kUlC7FKrQhPgEEjx+b+0zGPBIXMw4hWNmNq
         OG54br+Cv3v4lVKKJ5nZFBzECTGV0KpCGc7aY3gZoqcwMGEakxqskPWTNvdlo0F/GgHx
         WUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMkbAw3Kp5EU/cxL2G8cv6kwfEfWhomGZ5srHO4udII=;
        b=sIaBy9j2COTwEeHctylpMAFGiqurdQgbeSUzYttyo+C0gzU7sIaCkl/924JCJEBwk2
         iJ93ueXqOxSAAA7MSIEM2Vp/VDh0C56gaqq8ZjcG/dCHX5GOFkBJU/4ORoNbGeH7Ywum
         J4TZ0klAEA773Ie2J+ZSd6BVDaNDdBTAN+vG2sGtqM+odqrG+ICxZxavAREWd/AhlHGU
         Tx3mTnSg4IZLypcFl0RqFVhWqQpZ6/sa1C+nB3ktkfSDlLtwP71oecYt/5OY5s+RiVyf
         e49ODZsz+52Ae63h7tHwqdUW6WxdyWepLntas/kgFQZ0FumP9ZnwtQsueJhaDG3JFf4g
         FCUw==
X-Gm-Message-State: AOAM533my9UgCoMoo5fLBewW01egTNjEKacBAK4XkyLd+u4vAoiwagNC
        HEFlc5nXRDgaYrnYMMhicgWeMbIf0UU=
X-Google-Smtp-Source: ABdhPJy12UlChhFH8KQptk/ZKhPVEWVJuoXrNDHOol6Gfeh9nTus5wnHDyI4vs1qnVFDZ3zXR15x5A==
X-Received: by 2002:a05:6638:594:b0:314:32a6:90b2 with SMTP id a20-20020a056638059400b0031432a690b2mr27914139jar.128.1646283062689;
        Wed, 02 Mar 2022 20:51:02 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id l3-20020a056e020e4300b002c242b778a5sm664943ilk.74.2022.03.02.20.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:51:02 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v2 8/8] selftests/bpf: Add tests for kfunc register offset checks
Date:   Thu,  3 Mar 2022 10:20:29 +0530
Message-Id: <20220303045029.2645297-9-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303045029.2645297-1-memxor@gmail.com>
References: <20220303045029.2645297-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5152; h=from:subject; bh=ZA6niTy+2R3m76GIXQOKUtiklHS04OcrNRxjzRASO10=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIEj/C0tK1mYDmNKcpRBqCXnBIQq6F9rLMiogUOof YrvxetOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiBI/wAKCRBM4MiGSL8RyljzD/ 44L9u+MECUkeNxCPIAjEVO1ONwGZGwiPSS4hRKEZ+OZxDY8tNvVmCS5O2/mhlRv//j7zxvQDNxJ3J/ fmkLbJuhxUuYduR4aNLDrxrlYumwhN6qdGQGwABiC/ndSEHHWpCOurkt8xeopAZEeTfMkVP5Xmut5c dQAfFrXURajfjFsi5PSjziju4FM5Zb++xXiHH7tX7e4IE/bWfVUs7TF0c4k8sFLEO7WrbyXiwpC8sN rMhw9Tq3GEGz2KRis+1H3EMwueNSGCkYqKo2q1v5EoigOJ+n5+QauAD3qvrt4Og0Txmvlhb2uyXGKl LLHGDmlMCWYRhC2DvyV2tbZtla6xFmGCutrsviCUDidR79PINeK565U+62Gh+A2Y66ClQ1CwQUIuxl SycGMYeBltF6JBXVfyt9xbJGUd7x7MNWX2J5K7OM59ydl+tO9u5BGrfSbqNLHjFhmncv6/CkuC6gaj 32dzSro4RJg1doMDQr1CgjLi54XZ3R9+XM7oQgf6EE4m6LzmTV26pukd54B5LVNtPcuIQlmMV3YRBz dWHQRG+UcTNGHZtj815dSElot6KQ+w03lXi4yBAJO8mEvyadAXCw3nEmKamlMHqXHW6aQyZxsm7fEa kcogFiI6enkq+KsHVMO2RqCJFQC4fOs6fTpBkUGiAxc3WQUgZjRUV54qQBIA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Include a few verifier selftests that test against the problems being
fixed by previous commits, i.e. release kfunc always require
PTR_TO_BTF_ID fixed and var_off to be 0, and negative offset is not
permitted and returns a helpful error message.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/bpf/test_run.c                           | 11 +++
 tools/testing/selftests/bpf/verifier/calls.c | 83 ++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index fcc83017cd03..ba410b069824 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -270,9 +270,14 @@ struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
 	return sk;
 }
 
+struct prog_test_member {
+	u64 c;
+};
+
 struct prog_test_ref_kfunc {
 	int a;
 	int b;
+	struct prog_test_member memb;
 	struct prog_test_ref_kfunc *next;
 };
 
@@ -295,6 +300,10 @@ noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 {
 }
 
+noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
+{
+}
+
 struct prog_test_pass1 {
 	int x0;
 	struct {
@@ -379,6 +388,7 @@ BTF_ID(func, bpf_kfunc_call_test2)
 BTF_ID(func, bpf_kfunc_call_test3)
 BTF_ID(func, bpf_kfunc_call_test_acquire)
 BTF_ID(func, bpf_kfunc_call_test_release)
+BTF_ID(func, bpf_kfunc_call_memb_release)
 BTF_ID(func, bpf_kfunc_call_test_pass_ctx)
 BTF_ID(func, bpf_kfunc_call_test_pass1)
 BTF_ID(func, bpf_kfunc_call_test_pass2)
@@ -396,6 +406,7 @@ BTF_SET_END(test_sk_acquire_kfunc_ids)
 
 BTF_SET_START(test_sk_release_kfunc_ids)
 BTF_ID(func, bpf_kfunc_call_test_release)
+BTF_ID(func, bpf_kfunc_call_memb_release)
 BTF_SET_END(test_sk_release_kfunc_ids)
 
 BTF_SET_START(test_sk_ret_null_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 0a8ea60c2a80..7bc077198033 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -115,6 +115,89 @@
 		{ "bpf_kfunc_call_test_release", 5 },
 	},
 },
+{
+	"calls: invalid kfunc call: reg->off must be zero when passed to release kfunc",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = REJECT,
+	.errstr = "R1 must have zero offset when passed to release func",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_kfunc_call_test_acquire", 3 },
+		{ "bpf_kfunc_call_memb_release", 8 },
+	},
+},
+{
+	"calls: invalid kfunc call: PTR_TO_BTF_ID with negative offset",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 16),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -4),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_kfunc_btf_id = {
+		{ "bpf_kfunc_call_test_acquire", 3 },
+		{ "bpf_kfunc_call_test_release", 9 },
+	},
+	.result_unpriv = REJECT,
+	.result = REJECT,
+	.errstr = "negative offset ptr_ ptr R1 off=-4 disallowed",
+},
+{
+	"calls: invalid kfunc call: PTR_TO_BTF_ID with variable offset",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_0, 4),
+	BPF_JMP_IMM(BPF_JLE, BPF_REG_2, 4, 3),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 3),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_kfunc_btf_id = {
+		{ "bpf_kfunc_call_test_acquire", 3 },
+		{ "bpf_kfunc_call_test_release", 9 },
+		{ "bpf_kfunc_call_test_release", 13 },
+		{ "bpf_kfunc_call_test_release", 17 },
+	},
+	.result_unpriv = REJECT,
+	.result = REJECT,
+	.errstr = "variable ptr_ access var_off=(0x0; 0x7) disallowed",
+},
 {
 	"calls: basic sanity",
 	.insns = {
-- 
2.35.1

