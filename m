Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F42602DBC
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJROAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiJROAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 10:00:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780127C30B
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 07:00:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s196so12085676pgs.3
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPT/xLfKFwrrU4SwJxKlx5kwl9p+8LOa5HNWJZWwq8Y=;
        b=oe9RVtZAyBl7MVuan/eUuIBqvHxSc6t9XvxK2aNTv4YQ0Bxa19I9h9mcDg1IZHzQXi
         6yVeMw0pmpoDp8gpE20OKMjJ6lL7a+VGcefi91D7AP8S7ipiK2FBXVFZhCWTxJpnd7R9
         44+5utvdbcdcQoWxTcFfwRA+dHysyxvmkC1/Wb8xxlDQDjRToaodspQKv5K4oNTJ51xh
         67imcKRp4mNwZVUwB2JBwpn/c+Ad9MM9L8eCoNGICi4M0tLtoplK7k4yN//KiW/+7l/E
         Mv24+Jjs+PeL0ndeedyhvARbqZMAI8/E9GAWLUxFjOAmIBdwCOLpZ1P+G9tuBPermqq+
         OVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPT/xLfKFwrrU4SwJxKlx5kwl9p+8LOa5HNWJZWwq8Y=;
        b=rlQgONBKhri0dcSu+vtvlqt8lLKi9c5qT3qMDLq+vo6Fzs70inNS5illGv/6PZ7EBf
         oAc9MgNZTr7eGvdwtG0vWFDe9QJwwm8+0a2mMxAbjlQjLYMUbPlhvK2o4BoSPvLf3zw7
         BCoz95+nuwJAjWvwdISRbWJzgTQFLrpYiQBCzpKqg42p0GZ9DytaeC1sla8omE4sKy6R
         uL/NMZ/tNYn+AiajRfkbz57Q4QMkhJc2Ll0Q3zSULEN1Czv3U+raSFTpCRm78x5QG413
         IW886iE8aBtFZcsPBKOYnvt055Xrn0C6P0CEvZPQmLuYpO23WI3RKPO9gvjgc+G0714m
         HFKg==
X-Gm-Message-State: ACrzQf36ucVVBFr9x5urr+/kTnW3k+Sx5h/JciYg3u3HXaJYHTZkMNey
        e+NbT6z2aICKwR29nEn8l+niZ8Q2fUtKfg==
X-Google-Smtp-Source: AMsMyM56e5asRNUc/4hEuXI8Yu/eXQ+57HxgB/CWxlxAID/aRFotrnl761wTa1wIBi/z6+2t6lVNDg==
X-Received: by 2002:aa7:85d7:0:b0:562:6079:3481 with SMTP id z23-20020aa785d7000000b0056260793481mr3047782pfn.77.1666101604747;
        Tue, 18 Oct 2022 07:00:04 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id i2-20020aa796e2000000b00560e5da42d5sm9136600pfq.201.2022.10.18.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:00:04 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 11/13] selftests/bpf: Add dynptr var_off tests
Date:   Tue, 18 Oct 2022 19:29:18 +0530
Message-Id: <20221018135920.726360-12-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2558; i=memxor@gmail.com; h=from:subject; bh=lWtxzrANAZxyKY18Vsxv4Bbip2ZoyfaVfH5dUk1VWJk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEi9zSGeX57gcGd1S6tZ6TcqBjRE2nBrQm2pnqw lmHI1JOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIgAKCRBM4MiGSL8Ryn3HD/ 0RkvB7V2Thg++DgspbVjkbOlQ4MAMt9aBkPHujK/6qXjEeg2Y8yTWJ0FolfW1xmI0R2kIwYHbERp32 uCO/AwYAL6B8ddBU0ueX0s4dptw7RZeq5oOi0inryrDhXQcXZ9pdJV5ab/UH4wIA1TyBRqMMJTzNGk k4htyRyAbSMFac2olvR1bp2OuOzDfEYvoIZUBv18E1CPice2q+Urx/4IxqUVv6mS4tKj6wz8OcEdSo xJOPxxCRvrDtvuy8cNjmh8z3ixk2Hkg0mQSWSP+cMZlmhXRMaZVDXi4RSejtfZwY97Fp1Km8e+O5jf UiYMYn5ZNpnofTkzrgY8VKo22ksgjIBnaOUWLmSJNSQbQgtSxy0U58MxEjx9mQIB8oLkixBvEShfBv pT5vVMYKUKMH9q2MzOeE/6LdA+QqcNKbjqvh+84is4gdQdjKApSIUpjfkZ6y7gbRWalUeyxKJVB3PE wyX+k7GXkM2CXk63ZYIooHxagrEJZEyTjGIxhjIePwKnC0XCFiaSMu5clA/PhtyxB0OQLUP2aKlK9/ MrdkSesN1jA3gTNy1B6F56T1c5ae9iXEaPcVl8B9L0/eeC78gpOtMczyqUG09GzIc3eEgTJQiMi2jm g/X6QCL2HMM1UmS4OB6IHEnD09rKXsl9phz/aboIp9CxhLZ9S1czoipdlXVg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensure that variable offset is handled correctly, and verifier takes
both fixed and variable part into account. Also ensure that only
constant var_off is allowed.

Make sure that unprivileged BPF cannot use var_off for dynptr.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/verifier/dynptr.c | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/dynptr.c b/tools/testing/selftests/bpf/verifier/dynptr.c
index 798f4f7e0c57..1aa7241e8a9e 100644
--- a/tools/testing/selftests/bpf/verifier/dynptr.c
+++ b/tools/testing/selftests/bpf/verifier/dynptr.c
@@ -1,5 +1,5 @@
 {
-       "dynptr: rewrite dynptr slot",
+       "dynptr: rewrite dynptr slot (pruning)",
         .insns = {
         BPF_MOV64_IMM(BPF_REG_0, 0),
         BPF_LD_MAP_FD(BPF_REG_6, 0),
@@ -26,7 +26,7 @@
 	.errstr = "arg 1 is an unacquired reference",
 },
 {
-       "dynptr: type confusion",
+       "dynptr: type confusion (pruning)",
        .insns = {
        BPF_MOV64_IMM(BPF_REG_0, 0),
        BPF_LD_MAP_FD(BPF_REG_6, 0),
@@ -88,3 +88,37 @@
        .result = REJECT,
        .errstr = "arg 1 is an unacquired reference",
 },
+{
+       "dynptr: rewrite dynptr slot (var_off)",
+	.insns = {
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 16),
+	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_10, -4),
+	BPF_JMP_IMM(BPF_JGE, BPF_REG_8, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	BPF_JMP_IMM(BPF_JLE, BPF_REG_8, 16, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_8, 16),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_IMM(BPF_REG_2, 8),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_8),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0xeB9F),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_8),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_ringbuf = { 9 },
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "R4 variable stack access prohibited for !root, var_off=(0x0; 0x10) off=-32",
+	.result = REJECT,
+	.errstr = "dynptr has to be at the constant offset",
+},
-- 
2.38.0

