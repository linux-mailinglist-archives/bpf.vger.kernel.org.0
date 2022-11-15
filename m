Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217C1628DDF
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 01:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbiKOABz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 19:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKOABk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 19:01:40 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9EC60ED
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:39 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso15328759pjg.5
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPS13dYNuF95/UnFyu3fB5t8wmLAjV6BId42u1eCjj8=;
        b=JDV7cNezr2C5AIeeS4jG81im9yafoikbj9wuqTCR4jgJSTEgwx9Nd84rjLwtsQHSbX
         m+2uzNtwnCJGq7s+44ETPHo/rA28QIHBHguBqncINxvOfVd+uwbOQHHGNncvzhMYV0N6
         cDtL8RR3dqCG0RkpGh5O5z6IOm5naocrncke2m1SsrYm7heEYZuMMaoXvUeGlgK4bNzi
         sfcAEh4Nv5gxNQI9g5taErOhMT8sgq1xBX+RNe4m+qSB8WnJVSOf8sA9ty8TsIt+DL4X
         Oxln3TKy2L4EOhH02asl+Jgg6sNubVwxaoj07wyBm28bagj3ldiqOiVrPLzzKKWTj/xC
         kBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPS13dYNuF95/UnFyu3fB5t8wmLAjV6BId42u1eCjj8=;
        b=Pjt9oWbCqRxZiKbponavUVd00TEwau5p/vjWf2xjm+f+Q42gO2Utk+b+UPvlTbFXsI
         hG6YEhuBaC3TjiCAjP1AnFMTWTcABZfmlRaX3kUHtaZoMX/+lOCqutCzFU67ZBUeaD1S
         RaZ2ngW9mtvvmWmuO6CGq+MvbFQlFeCuNqkDq1eC8tfbJiuEAwxEcvWtBXGXEIxC6XQR
         dZuwtcIUQ0XdkeWNE72fWGyToAH8+/P1DIERCjiun8Fn2uMO2jAf/NQP2Cb/vZWjcT8o
         5Y0i36QMq7gsKVQLwNZIN9zGplfJrnnG88cj4L2pvUlbg8Jd1I9u8ihXXGD7MXkXpuxn
         3UiQ==
X-Gm-Message-State: ANoB5pnM5NskqptFouLdQ4ND7rpQrkZurVkT89yKqQ4jHakP//G4hFys
        810dKy535oKtU9jbt6O+Idw5fsuBdF0cBg==
X-Google-Smtp-Source: AA0mqf4eYmwwpIsdzkwxDQYIDMNRZWAH4b3jdVA8q8DujnhsPX5flPdVvU+B1meZ7Vghuuc6oZ53gA==
X-Received: by 2002:a17:90a:b894:b0:20a:7294:47dd with SMTP id o20-20020a17090ab89400b0020a729447ddmr15208720pjr.207.1668470498982;
        Mon, 14 Nov 2022 16:01:38 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0018703bf3ec9sm8155152plb.61.2022.11.14.16.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:01:38 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 2/7] bpf: Propagate errors from process_* checks in check_func_arg
Date:   Tue, 15 Nov 2022 05:31:25 +0530
Message-Id: <20221115000130.1967465-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115000130.1967465-1-memxor@gmail.com>
References: <20221115000130.1967465-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133; i=memxor@gmail.com; h=from:subject; bh=HjZ8n14OOOglk/GCqR2IboCzYEj0fP9YCcqR8T20538=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjctaC5wXp4g+aRZb0CeKDmgilfOm58S1Jtm41e5WG 3eiReXuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3LWggAKCRBM4MiGSL8RyqZ+D/ 9o09168Vw6GJdLfJ2KB7FseMuCHZQ4SAqyA2AC+xyYQQp2TJ70FIgqcud/b7rDB5AWJjaJG8W0IYNm aeD80aAnnK7MuNdftKxjzNyxDJrOhu0dUvfIevs0YWksaHN73GDIXIbVq+W7XYSGkrB7kDkhmriFrW E830acQd2T+Oss3BZ5zst7zW4IJtDEMVCzrVxyHUWUZXW/MbzgUnwFGxiwEEPVL+y/H9arBdw6w6kg bkT11TeMXrXe5n9hbfEir4Zunl22GnLxoKiyM/5W/olx9RI/GgZmIe7N9BVoX2RkAMmx1dRJnixatq VmLFsg0Sq9EcVt2wvv0WtLDlVFIy1iv3t3HWLuIb9MYaCdf3AtrjkLywTwBpawhPMKu40lCh0oO8G7 dtaThNUnUZC+kKoKP7al2zrvZLGYQ1lGBjl70MNNyiHZsK/Vm6V2O4Dmv6q3c5cUozt1hI/MsHju7b f/g4sEXmHM4tlvHthC5GOS9sAPxCmvA3LNivg63c2+kpukagzq+QgOhjc4X8SXwylEWNZU61alSt53 u8HwJ1yuwWhAaL0opthJ4U4cL+hN0D3PRZ+M0WP09aA8TJxU8j7E5vildM7EkGdciHZV0ysB5n2l2/ cVlWalU3uiOeg3Q6SNVrhl7knouUWG74rqjDejbPg84WbbfIvUPxsBSgOZdA==
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

Currently, we simply ignore the errors in process_spin_lock,
process_timer_func, process_kptr_func, process_dynptr_func.
Instead, bubble up storing and checking err variable.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56f48ab9827f..41ef7e4b73e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6220,19 +6220,22 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		break;
 	case ARG_PTR_TO_SPIN_LOCK:
 		if (meta->func_id == BPF_FUNC_spin_lock) {
-			if (process_spin_lock(env, regno, true))
-				return -EACCES;
+			err = process_spin_lock(env, regno, true);
+			if (err)
+				return err;
 		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
-			if (process_spin_lock(env, regno, false))
-				return -EACCES;
+			err = process_spin_lock(env, regno, false);
+			if (err)
+				return err;
 		} else {
 			verbose(env, "verifier internal error\n");
 			return -EFAULT;
 		}
 		break;
 	case ARG_PTR_TO_TIMER:
-		if (process_timer_func(env, regno, meta))
-			return -EACCES;
+		err = process_timer_func(env, regno, meta);
+		if (err)
+			return err;
 		break;
 	case ARG_PTR_TO_FUNC:
 		meta->subprogno = reg->subprogno;
@@ -6255,8 +6258,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_mem_size_reg(env, reg, regno, true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		if (process_dynptr_func(env, regno, arg_type, meta))
-			return -EACCES;
+		err = process_dynptr_func(env, regno, arg_type, meta);
+		if (err)
+			return err;
 		break;
 	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
 		if (!tnum_is_const(reg->var_off)) {
@@ -6323,8 +6327,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		break;
 	}
 	case ARG_PTR_TO_KPTR:
-		if (process_kptr_func(env, regno, meta))
-			return -EACCES;
+		err = process_kptr_func(env, regno, meta);
+		if (err)
+			return err;
 		break;
 	}
 
-- 
2.38.1

