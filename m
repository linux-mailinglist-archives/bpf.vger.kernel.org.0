Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3CC5821DA
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 10:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiG0IQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 04:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiG0IQG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 04:16:06 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB36C5FB8
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 01:16:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z23so29923902eju.8
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mk387YyQOzYLCfm+4higeS5XmJx+fZHaqQIocnjiCAc=;
        b=K/Lcj7EsIgHKmT7+fT+LJ/iIA1L4XDc+L/hkQUo+onknB7GNUFuoAqEGPeIMIlfybo
         MMNFyewwIWP+yLWTarQe/y0oDC9c9HdAKK48+ZMfLbSoF6SIeikezPHDlNCxXhHw3UGb
         dDkS154QMPjLTDJ2hzRl4MdwroCdpR7SoTTJA4YoTe3N8HOEQq38C5pRPJgulVtXjw2f
         B99PKVtm0S8Dhzir4xZGrBj/iiOy7XVuUI6RlqsNMaeJgRo4BaqkkIRUIFBGQ/O8VlaD
         E14lM2heb/TBKlkU1swfE7u397oF1rrBRy1RzdMm78/D7kFGIpyi2Y/hr3oYqdUiE/EL
         mB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mk387YyQOzYLCfm+4higeS5XmJx+fZHaqQIocnjiCAc=;
        b=KK7wlVplKkPRlAxJVA1GH+5YjrnIaV2vfT0U2yzPmHhMoVVqWELcmmvLHTqHWNIdfb
         IWAC554tpRc9XCMReg2IOfEQMMsblSulpxXsl+hSK4oIeyr7AbRXRlIUK8s0KNpDl1fO
         BD4xoTqpXJFLzYnRIdMcCmCHpLIYQCXRk3hfOs1KtIbqRv9ytUz7ZO3hr8kWUP4qAZM4
         qs8UPFWdkrDgHp12mDLl8vVwiftm6R0vicZuYz3D1HaK3hbHMVM7E6yQKkV21OOvUJ6m
         0GxNgrqVqvPMnmww1Lq3GIuSC80IkYXqXAZiB21OiEFcrxgMvs/FxzciDyCU8Ffh/uBO
         8PTw==
X-Gm-Message-State: AJIora/fFYcfYCywgZ46YcOoVkivuLrGooeqhWJ3kEgSlRAq6wd3dQGz
        2wWJDPjYvJ2P1kilxBkDLHfK8Jjev3gtIg==
X-Google-Smtp-Source: AGRyM1tBLH4WhYbizpIj1opXMYo4U1j0fxyMWPENs86f11L2ti+uYzfVyPwKxFJd7O2igpkx3HizXA==
X-Received: by 2002:a17:907:7394:b0:72b:3e52:6262 with SMTP id er20-20020a170907739400b0072b3e526262mr17304847ejc.756.1658909763218;
        Wed, 27 Jul 2022 01:16:03 -0700 (PDT)
Received: from localhost (icdhcp-1-189.epfl.ch. [128.178.116.189])
        by smtp.gmail.com with ESMTPSA id kx6-20020a170907774600b0072b3182368fsm7290317ejc.77.2022.07.27.01.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 01:16:02 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Extend KF_TRUSTED_ARGS test for __ref annotation
Date:   Wed, 27 Jul 2022 10:15:59 +0200
Message-Id: <20220727081559.24571-3-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727081559.24571-1-memxor@gmail.com>
References: <20220727081559.24571-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3256; i=memxor@gmail.com; h=from:subject; bh=oggp7MloHYPPaWLBnaR7k7moESoZxhg/UVjpTnz98sM=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi4PP/0QkkPF6yK8mS7fWWJ8wGfEqa9y+3naffy3VN DyXB4deJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYuDz/wAKCRBM4MiGSL8RyuWwD/ sHk/WD4oZmhrqkXtJnHTLrCeh3Soq0WFLh97I/F2oxHBgj++A5HyS6UxhzAfd1IYMJ37K7zxJ4DYc+ rmUuxzL5ytu4CJfztprd7bZqVr67d9lsa4Vjv5Mn9YCvkPuuG5xe7XvUoKnV1b0jXVOdbTz7AWeSSc E7UVrIZxySIwprtTrRI+5df6LF+EfartsHM1hpfhvSGob7sh8CwlhEylDNgUP/xVRyTGk+NJOqMD5K 9UvNVJxlfELmWFRX4Ii+mhp7KMCo4hozsotHs+Swgn2AUsdCcgLmV/Chtow5+Qv9vmuDibGdvZFX15 O9bS7cGvS4TUvTIxBjzBXIdy6Stjx0oJbsfWKRPs6bkwI1geVsXkjiKUTk/QhdhTStOm95zNf2+Fh1 iO/i2fqeIfZgFfbWCPeiWvC4NWJbjG8eTIqbQBeEpfYWQcpfLL8GhgMdNdm6I0CfDwcePVCWRwyW7D 51p6Srgpo8qMdUWhq6gSrKBQ9f6rP9lpX2/JrkW2VVIQ9gB15E7ku2+4P33+MuScPmMrYxO64ijJ3f 5HhqVO4X8OES+Gpn/Yxou0oOxukgMeqB3bZiLn2jjaXuzRaX59F0a8XyIIV2o/S7cSYUN3MU/Fu2RO GvxNXm4sVk/MqggKxnpKIYVgkhBY+R1TC7nagAW7VLsX5KbQPmX0YUu/mTaA==
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

Extend the existing test for KF_TRUSTED_ARGS by also checking whether
the same happens when a __ref suffix is present in argument name of a
kfunc.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/verifier/calls.c | 38 +++++++++++++++-----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 3fb4f69b1962..891fcda50d9d 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -219,7 +219,7 @@
 	.errstr = "variable ptr_ access var_off=(0x0; 0x7) disallowed",
 },
 {
-	"calls: invalid kfunc call: referenced arg needs refcounted PTR_TO_BTF_ID",
+	"calls: invalid kfunc call: referenced arg needs refcounted PTR_TO_BTF_ID (KF_TRUSTED_ARGS)",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
@@ -227,10 +227,30 @@
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 16),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 16),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_kfunc_btf_id = {
+		{ "bpf_kfunc_call_test_acquire", 3 },
+		{ "bpf_kfunc_call_test_trusted", 7 },
+	},
+	.result_unpriv = REJECT,
+	.result = REJECT,
+	.errstr = "R1 must be referenced",
+},
+{
+	"calls: invalid kfunc call: referenced arg needs refcounted PTR_TO_BTF_ID (__ref)",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 16),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -238,8 +258,7 @@
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_acquire", 3 },
-		{ "bpf_kfunc_call_test_ref", 8 },
-		{ "bpf_kfunc_call_test_ref", 10 },
+		{ "bpf_kfunc_call_test_ref", 7 },
 	},
 	.result_unpriv = REJECT,
 	.result = REJECT,
@@ -259,14 +278,17 @@
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_acquire", 3 },
-		{ "bpf_kfunc_call_test_ref", 8 },
-		{ "bpf_kfunc_call_test_release", 10 },
+		{ "bpf_kfunc_call_test_trusted", 8 },
+		{ "bpf_kfunc_call_test_ref", 10 },
+		{ "bpf_kfunc_call_test_release", 12 },
 	},
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
-- 
2.34.1

