Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1576380BE
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 22:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKXVxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 16:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXVxT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 16:53:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5847D2A9
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 13:53:18 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w4so2409185plp.1
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 13:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/tAxWlTOolZn2lVRwwoWfXDE3xWTzGriDe34hCbeFM=;
        b=e6mq2hNVzk7YkeiGVO/rnOMj/kvoc/PbWBcr0LNlvV4FMjoOU+ACcgGrmJ4UwF6oQf
         /cIpEdVzS+ukrJXx3bLyJlZoRr+Vd3Oom+SFxEknxKea6+sANjp6E7XzLyUkqyPQdyvC
         top3GWBe7BXNV+KQSmeyttPAgSs5IOx/BY2tVEt2XNFBjlYzk0RDFGSjH/KoW1ofznIi
         mUXJaU5JUm7LENMFsjJBNlx9aInJ3LlWZwjY3gJ0/KhPQ6vJOd1Ytl1arE1M9pHi3eKc
         79hzNT6piHXmZLdFGVqsMkXqDPVFR0iteOsQd45vYD5ZqoUgbuGcO2HpmwqIOVbzTz10
         basg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/tAxWlTOolZn2lVRwwoWfXDE3xWTzGriDe34hCbeFM=;
        b=y3jXTNE/kugGXywEQd9tBwBK01tvIIPmHOr8jQ1mDp2caSm6vN8RplYEvcrJnS2joC
         OAJJFT9mnEt2YX0ub/KM8BonD0zqneYeyVY25Ozr/L3pBNFji8J674Kd37KX4t9xC9Nx
         0vanGTBl08sXLKPGcBcm86QONMDJqNH2/k7QvjfgJGf+5//hJKsGQ/ywXGO12TkLn3Qo
         vY13VMP3EvcBJDxkc+ArfOkGGJghUiDBc+GUjYt9Wy7A+ojLbim4pHrSQIefuH0q+2QB
         DnMmK6vTM9b1CvOKAj3ZL9I6jBuNx8LsvDClMnPfrjrcwKphnu9ppLVMDTlolAum+WTZ
         bbDw==
X-Gm-Message-State: ANoB5plSztntD6l3I39Utxq6bJM550pN1mgXl4XhfBhrJ/Q13/yBu/Cc
        fjn4heP0S/E1NLZJzsqLKII=
X-Google-Smtp-Source: AA0mqf4vycUQwihPFqBsddVhOcgaQKyZCKfz41WHT6a7yUkQ3YDYxkC30i/8Hf5lENndp3jlKKdpQA==
X-Received: by 2002:a17:90a:ae16:b0:218:fada:57fd with SMTP id t22-20020a17090aae1600b00218fada57fdmr4905736pjq.12.1669326797925;
        Thu, 24 Nov 2022 13:53:17 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:4c7a])
        by smtp.gmail.com with ESMTPSA id t34-20020a632262000000b004771bf66781sm1413963pgm.65.2022.11.24.13.53.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Nov 2022 13:53:17 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        void@manifault.com, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Don't mark arguments to fentry/fexit programs as trusted.
Date:   Thu, 24 Nov 2022 13:53:14 -0800
Message-Id: <20221124215314.55890-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

From: Alexei Starovoitov <ast@kernel.org>

The PTR_TRUSTED flag should only be applied to pointers where the verifier can
guarantee that such pointers are valid.
The fentry/fexit/fmod_ret programs are not in this category.
Only arguments of SEC("tp_btf") and SEC("iter") programs are trusted
(which have BPF_TRACE_RAW_TP and BPF_TRACE_ITER attach_type correspondingly)

This bug was masked because convert_ctx_accesses() was converting trusted
loads into BPF_PROBE_MEM loads. Fix it as well.
The loads from trusted pointers don't need exception handling.

Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c      | 16 +++++++++++++---
 kernel/bpf/verifier.c |  3 ---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bd3369100239..d11cbf8cece7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5821,9 +5821,19 @@ static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
 	return nr_args + 1;
 }
 
-static bool prog_type_args_trusted(enum bpf_prog_type prog_type)
+static bool prog_args_trusted(const struct bpf_prog *prog)
 {
-	return prog_type == BPF_PROG_TYPE_TRACING || prog_type == BPF_PROG_TYPE_STRUCT_OPS;
+	enum bpf_attach_type atype = prog->expected_attach_type;
+
+	switch (prog->type) {
+	case BPF_PROG_TYPE_TRACING:
+		return atype == BPF_TRACE_RAW_TP || atype == BPF_TRACE_ITER;
+	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return true;
+	default:
+		return false;
+	}
 }
 
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
@@ -5969,7 +5979,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	}
 
 	info->reg_type = PTR_TO_BTF_ID;
-	if (prog_type_args_trusted(prog->type))
+	if (prog_args_trusted(prog))
 		info->reg_type |= PTR_TRUSTED;
 
 	if (tgt_prog) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f4500479f1c2..6599d25dae38 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14905,7 +14905,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			break;
 		case PTR_TO_BTF_ID:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
-		case PTR_TO_BTF_ID | PTR_TRUSTED:
 		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
 		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
 		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
@@ -14913,8 +14912,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		 * for this case.
 		 */
 		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
-		case PTR_TO_BTF_ID | PTR_UNTRUSTED | PTR_TRUSTED:
-		case PTR_TO_BTF_ID | PTR_UNTRUSTED | MEM_ALLOC | PTR_TRUSTED:
 			if (type == BPF_READ) {
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
-- 
2.30.2

