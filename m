Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75277631691
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 22:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKTV0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 16:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKTV0W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 16:26:22 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FD922B26
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 13:26:21 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id j12so8935263plj.5
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 13:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ahIz5CSqy8t/7nwtNXmt8bU2pqvl1zSBsr8ynBqzyI=;
        b=XzNHtjU2icKNlXQzygSbr1hc5GNe0nr5EQOkP/R4bJWoaLWxIt/nuG+0UjLA8j5Wjs
         e0xdROT9C+mOOij8Z8N8onw6OJc3K/uooH/6I91/+dW2RMMQOW2C+TWY30oRHf/JhnpG
         Zz2dmAZ3xzpEqFPmi9zSLDKNWwS5FdwuaGRXV/QjUculjCFwObVLPtj0o/7PlqKnmmQE
         eiyNaUycZM6/Sc3mSKZHyHuE0kPEiHgQ56pn2J8bH3UMqL0zGFFlJ/G/VvnFfdUSL1JX
         J/ZKi+kFIGN1LGhByrw/4CbMjR/LwO3NQihUkUbeW27VXcG/jl3h8tHIZ0KgnSzmz1ap
         5A4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ahIz5CSqy8t/7nwtNXmt8bU2pqvl1zSBsr8ynBqzyI=;
        b=xwN3ZRs5OVUSe7tYV2Tc8MX3an24aI/R7wjPqgpZ0ZaeeKYhm7RVXO5aU4nkfSSjRn
         pvoL/dj1H5fq7ZXT1wzy3Bch9uxaJKBmdpHgcbUvutNYqTy1/cX+xEUkkIw0igV2D162
         N6ByqKRzSTmklS6+SwM8mMF82sccFu5eVA0pZnkTYj+jPjVL1ccai73IOdIirXY/ziNe
         Vf+/8rh3wTU6RMvpHF/3L/MGqA2QbEK+FuTRK7V/GVqV9q3qUPUmB1iXNvLPxPao+r5o
         u6LhWcmGh/LpTPY3agJZW6RHyXPOIkfTF14QRABJkY0SM7d8PsZDzXRBgnrg1h/x65aZ
         dhjw==
X-Gm-Message-State: ANoB5pnLpGdH/hDyo4tRq6FBt38sc/l4tg+8nzyAOR0ak4DIChglG8Rv
        qp3pBgZNFeF9TdsKwWjkeJfzCxLkLBg=
X-Google-Smtp-Source: AA0mqf7NYjAB5XAFSdC6U5pxFlJUzHGD/9vjoJWzJmqKMCTYTfLPob71Rabc6h4Qv96khEhgSTV4yw==
X-Received: by 2002:a17:902:db0c:b0:189:1963:d0d7 with SMTP id m12-20020a170902db0c00b001891963d0d7mr4440423plx.100.1668979581247;
        Sun, 20 Nov 2022 13:26:21 -0800 (PST)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id w62-20020a628241000000b0056bb7d90f0fsm7035542pfd.182.2022.11.20.13.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 13:26:20 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Disallow bpf_obj_new_impl call when bpf_mem_alloc_init fails
Date:   Mon, 21 Nov 2022 02:56:10 +0530
Message-Id: <20221120212610.2361700-1-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=memxor@gmail.com; h=from:subject; bh=lKpJ6YTk7kMKOH2mLBt8iPlwQkKgvUbvsxkIzV/eiT8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjeplFL+N7uBya+GsZ2IKYTsSvTJq0S5/eXHR+YGdG RD5Z2tuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3qZRQAKCRBM4MiGSL8RyoKPD/ wNBmkBSDbl73mpqAomoQaRr2Wo9qgtCuhR3ropQZ2yd159483jlnww1FvU4VCIdhjd/DJurq1nt4W4 7dGlnAFwQFvalzVT9FFY8dfH0D/hCKNno8F95X6rzg7HE8KtjP7FhNSHtpj9vFa+RTfayZdhVG/K+k A3yYI7Rnt5lzj89NeM0YhvvktHeJbUuajACzUO+fNFtCNVrHTJ7lxwIh/69bdtoGJfqS0fNZ3BgJ9H 7wivLwyEW3tc5y352LNa92TlEvfLOsxLRPY3z5dcQo/KVy2r1oFSGI3i5lg6RddQ7ZiGzSQtJF9Au2 nUrOFXtJnoNCK9GvVTspZTlY/8dlRVLMCTdql6bHoHKydiRsvR7TZB/7GdiubBB7ycFVh/YCaG7xNY N4w1kJTenqcKfewDnBMtLC/TNwbZCcljrJ3Qi6cKwGhz0fIsTraXBd2V9Px+H46Akjk58oGJHbehku 3L2/QkaPehb24DM/9x3a9S9oEWWtatYcw55TN2loM609TGqsZdV9m/D8BbKCw26HD8hHpjBfzJc10A 9ZrY9hxtXvWZ8YNiJ8TTST8ZAiO9V6zW8kTc/Cp/ffbGLNdkcKcSrI3c34OSskgPjRbHuNEZ60/WCd uVUi5Y6h2X1cbsBPwe/wSCp/OBYYzE8budCsy84paBAYsJQg9sFK0jerOSyg==
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

In the unlikely event that bpf_global_ma is not correctly initialized,
instead of checking the boolean everytime bpf_obj_new_impl is called,
simply check it while loading the program and return an error if
bpf_global_ma_set is false.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c  | 2 --
 kernel/bpf/verifier.c | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 89a95f3d854c..3d4edd314450 100644
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
index 5bc9d84d7924..ea36107deee0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8878,6 +8878,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				struct btf *ret_btf;
 				u32 ret_btf_id;

+				/* Unlikely, but fail the kfunc call if bpf_global_ma
+				 * is not initialized.
+				 */
+				if (!bpf_global_ma_set)
+					return -ENOMEM;
+
 				if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
 					verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
 					return -EINVAL;
--
2.38.1

