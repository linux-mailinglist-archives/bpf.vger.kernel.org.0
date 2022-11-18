Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6398062FD7F
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 20:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbiKRTAs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 14:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242850AbiKRTAa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 14:00:30 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F6B2A27C
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 11:00:05 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 130so5719192pfu.8
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 11:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNObVLUzMWL/DNto8HuZU0Z5bHWz1PqDjaESNm3v+qA=;
        b=n117NkfEJSdPPZllVNHgSwGoNGt2YcbXn04Cb1B7VByaPTFh1DLPaO/BreLi02PqJ2
         sVJ61ZOWh+7J7OVJsEHZi0dHJ98rffUBvI6R/mFmXGxYFpgqpGm2hnMqZ95eI0x0jCc3
         nQZxpAtOycRuiotmsG1tsLPLO1a8tNCZGJa4DO46r7+zTI2uvXtF2M19U/Qkw8NR9TYF
         mpazxWaUfZKMGiQHf5sy+eR1sUDVzSH9GU9f54Pv7iPTOq9898SVOxn6NgO6zLjzOf47
         gMar75tYKk4pqOfsW+VviwgAvaA/d/ddLtA96Or4myJaCPAJkwQXvphyGlNz9sVT9E6S
         izNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNObVLUzMWL/DNto8HuZU0Z5bHWz1PqDjaESNm3v+qA=;
        b=2A7R+DpGGZ6PSbksdhLCLu0p6des1iPFxWcH0qAi16jd642gtJK6GebnFSr0Bhvutc
         9/ONZMTgJ+kp8YT6pOF2elmRzkvHgDUihKlSwBfx2R9ggTDq8cHWciuHJR1++DOgvXmF
         JpjOcE1K0NYnjjo23mHooPOrdSUDjRKKDeHKHHFSygWe0npzqi01FKDRBvvweZgXcJcn
         Pt1jIYPCZp7oHDwSd5/R+Z+xL455lYq0DNz5H5T6+sYq7T1yVwPwMI14lvDj4GAamI2F
         btkPnrlp0hxGbypvLHXPX/ZYt5yBfDFAbulMvnXsjnzwDQHwNfC6RkTrRil6NKGV7mMW
         /wiQ==
X-Gm-Message-State: ANoB5pnKjM7Spe5JC0oMWSRPclgyfKKBKaE/cV1WiCsb4qWjRFKz3Ba0
        8psOiTcIZHyqpmnKDAau6r2AP17MIVU=
X-Google-Smtp-Source: AA0mqf52ANGz/o2yjCvxCivWTP5hHd5tc0Sl3dSBpUpDeomyYCmmyRSzAYI4Y4r2ldOgj5Hxr20rUQ==
X-Received: by 2002:a05:6a00:18a9:b0:572:6da6:218e with SMTP id x41-20020a056a0018a900b005726da6218emr9484837pfh.1.1668798004517;
        Fri, 18 Nov 2022 11:00:04 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id d20-20020aa797b4000000b005722f4dfbefsm3468598pfq.193.2022.11.18.11.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:00:04 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v1 1/2] bpf: Disallow calling bpf_obj_new_impl on bpf_mem_alloc_init failure
Date:   Sat, 19 Nov 2022 00:29:37 +0530
Message-Id: <20221118185938.2139616-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118185938.2139616-1-memxor@gmail.com>
References: <20221118185938.2139616-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; i=memxor@gmail.com; h=from:subject; bh=hO9444nz970VOtyxTd+RGoyPc12iJAZ/BKHWlQRgS54=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjd9WicXsmm8LVOQl/JB/4ifro6mjVEqhKGsIyRdC2 ZRZgI+iJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3fVogAKCRBM4MiGSL8RymzfD/ wMhFs5lPxIm9qI1kSPq3EuBPumSsRtSSy15Gl5U1/zxNBlnes6YH07Afwqm3ux0DxuElheBns9ukoI v2YCVC3sR9KPJxfCHN+rTsPbaOUzJ5mQh3mJLwKjlZXXHdsS3wCZ7Jg7++irRTMcF5+QNqjtBRCIfO 7jlVbfnTNR2c/M98dHSlznewT4D0Suz8JoM3E9Six3NFBnJyE+wmmGT6hUWtc7uNOhdjrSMq9eCn33 rcPOL2WCRoxrU3D5SHJHhcF1Vt7WesTHl5Kj0YB840hpZcA8HBWWt2CQNjf7j9nasxwh3jPpJQNVTf l/w6Ggnt8SK4kG91+KbyG1tp3RJKpANpXH7kolRLQZQcvsGDiGyFslTtKcwUYMMb72j7oabPqsXKio Y3zmn+QXIR3sRfUpODfqgo9UAQBP+wPPIIxKuQaksqXpAPFL8xmRWH9vEsX7CvJNr0j8BRvTXfLmNq kS5Jc8k9deDiMmxaU4DP8XHyaCQ670ivp16ik8QJw97lKzEUb5GRNGdRqS6DEI8wbrCbllEllNhPQz PTKu5aF+IE1cWWM1AW3CRu+IWM79tWNBtfFBdLBtBNiB90inHmG6fQURG9AmlWbiPAIFvmAXTseSb5 jh9Ri3/61kfjZaK8UAA3SmSTpPKhn/mnfTsNq3dG4v+CUEUjf2O7LwS8SZQA==
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

Instead of checking bpf_global_ma_set at runtime on each allocation
inside bpf_obj_new_impl, simply disallow calling the kfunc in case
bpf_global_ma initialization failed during program verification.

The error generated when bpf_global_ma initialization fails:
...
21: (18) r1 = 0x7                     ; R1_w=7
23: (b7) r2 = 0                       ; R2_w=0
24: (85) call bpf_obj_new_impl#36585
bpf_global_ma initialization failed, can't call bpf_obj_new_impl
calling kernel function bpf_obj_new_impl is not allowed

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c  |  2 --
 kernel/bpf/verifier.c | 13 ++++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 212e791d7452..bc02f55adc1f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1760,8 +1760,6 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 	u64 size = local_type_id__k;
 	void *p;
 
-	if (unlikely(!bpf_global_ma_set))
-		return NULL;
 	p = bpf_mem_alloc(&bpf_global_ma, size);
 	if (!p)
 		return NULL;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 195d24316750..f04bee7934a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8746,6 +8746,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 	return 0;
 }
 
+static bool is_kfunc_disabled(struct bpf_verifier_env *env, const struct btf *btf, u32 func_id)
+{
+	if (btf != btf_vmlinux)
+		return false;
+	if (!bpf_global_ma_set && func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
+		verbose(env, "bpf_global_ma initialization failed, can't call bpf_obj_new_impl\n");
+		return true;
+	}
+	return false;
+}
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -8773,7 +8784,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	func_proto = btf_type_by_id(desc_btf, func->type);
 
 	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, resolve_prog_type(env->prog), func_id);
-	if (!kfunc_flags) {
+	if (!kfunc_flags || is_kfunc_disabled(env, desc_btf, func_id)) {
 		verbose(env, "calling kernel function %s is not allowed\n",
 			func_name);
 		return -EACCES;
-- 
2.38.1

