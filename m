Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E418B69C147
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 16:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjBSPxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 10:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjBSPxA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 10:53:00 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D817EF8
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:52:58 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id ek25so2801950edb.7
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gjATKTPjeef4UxhZLE+OVD3fftepy3M/KUpIRkKPPE=;
        b=g00tRZJ0/d0UGGZoHGw7+f7RjEZhEaelfXjKPE9IXnWveIDEAjscu7F+x7kFnLepf9
         psK9eqqwa3dSaqSCMHwoUTsbq8ZVmuCfW3zTJTMe2GSPlwExkglfht/GE20T1HTgxy9R
         FwnSU+kVhNsxsxDk1etakUtGKzp5YOg9y9NG+qg3yeSmPwMEb+VnBBTBqBUwXIrnyVkf
         g45207gmKSNeMN5G4xPOic1D0wG4DKDxDyCxTj9sewtuVEOE6QMT7XULmPs2CaQEndOz
         MSeoEmMtJUpt6nKhOd3H0IP1AwQb5VGri/uI5wMO6H5eBZWEebEZEhYr39umpGmjc3qz
         3vVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gjATKTPjeef4UxhZLE+OVD3fftepy3M/KUpIRkKPPE=;
        b=t6tOvDqxm+Md/N0FUWbtvXwaaFcdGz5S1KdmylY/bo4BygdQ3OJMASYuRR66c+KCQz
         JWlnulEMhcIoeDYvQFRyf9C/bPSkAtDrnu1Y42IrWZridviyHfwmN2cUm8Kxt4NsDUz9
         ncK1yH6OA39JgLokJyAncVJLtJUMsWPDchBqgA97K09atn+4tEIkCATySpl5XDvfgHSk
         ZMV7lHvmjPN8AVlNljEwKNborl16/Xsvou1hBtx7ExlqO0lYJjAVC7X1jO6CBc0ykeLt
         jL2Stbj/vOpVsOT0WsbvNroq8wxMErQZ8o9wl6a5Hn99mnWjrXAQ6RM2R21MBEUHo1Fz
         uuYQ==
X-Gm-Message-State: AO0yUKWRxmsFg3U5vJDQx6pfqoY5dzT1DxfJQllZEYgb1m4xIIyvY0L6
        mYe1zsUeIE+5mJUgBHHiVuiISE3oGcrHLw==
X-Google-Smtp-Source: AK7set/u7MO5NrXNupA9p+qTIRldZEG7CsD3tfEqtgio2Djkevm2jOne6vNDiFDQmopPv3Kbsg8s9A==
X-Received: by 2002:a17:906:f55:b0:8b1:315c:be04 with SMTP id h21-20020a1709060f5500b008b1315cbe04mr5398774ejj.27.1676821977635;
        Sun, 19 Feb 2023 07:52:57 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:8d0])
        by smtp.gmail.com with ESMTPSA id k3-20020a50ce43000000b004acbecf091esm947446edj.17.2023.02.19.07.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 07:52:57 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 5/7] bpf: Fix check_reg_type for PTR_TO_BTF_ID
Date:   Sun, 19 Feb 2023 16:52:47 +0100
Message-Id: <20230219155249.1755998-6-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230219155249.1755998-1-memxor@gmail.com>
References: <20230219155249.1755998-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2598; i=memxor@gmail.com; h=from:subject; bh=Lqdy/IKzOnseTIegz0Zq4nxx9kSW/9SvKf/gr8GzPMU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj8kUewXAfDptv4JkR1DmGQNTV3abjCUocDju4yb7q Apnj8QeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/JFHgAKCRBM4MiGSL8RyqL2D/ oDFwrfV9bvglckONid0Jpv4yTmNkPU48blpV7vYoMMaXzMVE+xNcoEQ9+BohIsLY7a4cp9JWpsBa5Q z3cHfIJjgZnTjBmTa8zMun1wZ72YJuBqVspfBRan4KJAvKOoQ16SGaqS+tDvqj7I7BHCCEmv30kzB9 6rgmH6P8NxHo84bnHfOGhcLmJeIp426A0EjuTgalnOIrhSu8iIhjh3b9eSCmNCtHTe26GEcTurPOWY U76x8t48fH5ZpDkt5vQoxFKaXY4dEr/dm++RaUzKPXyRFTiI3BFQtfmqJzHpqAUNutORBEfjhTGNAI WBbC6eKWtRGB+iDXgRTF2+1xyv2ZydgJbk+azzROUqCv5oao8eYyFgFVwg9787Z9ZHFAoKcIuWySW8 bcqpQ6QL43vmcyNPkBjfkZ18qveLhx8sCgTF8+Xta79rjoWI3aGoeLc4K6dUh13Ime2bzLhionywJN FknrW4tCTx7gHKPeVNRsmkUTLwI5JyZr+Ehj8q8ODIqXbYXTTl9GKDLvm51neunXD5K7/HGXQHdY1B XZA5CUD0Fz4hastaOtaOcmdYOIVkTKZ93ZLqaXsRpxuQubggBmzaTDS/50jba07Ye81ZqRURQJ3or3 kwez35Xv+AROOxSn95VxrNAzXIkpv4FyGLftMvFLWw8D96x/Pzv08tUzgFsw==
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

The current code does type matching for the case where reg->type is
PTR_TO_BTF_ID or has the PTR_TRUSTED flag. However, this only needs to
occur for non-MEM_ALLOC and non-MEM_PERCPU cases, but will include both
as per the current code.

The MEM_ALLOC case with or without PTR_TRUSTED needs to be handled
specially by the code for type_is_alloc case, while MEM_PERCPU case must
be ignored. Hence, to restore correct behavior and for clarity,
explicitly list out the handled PTR_TO_BTF_ID types which should be
handled for each case using a switch statement.

Helpers currently only take:
	PTR_TO_BTF_ID
	PTR_TO_BTF_ID | PTR_TRUSTED
	PTR_TO_BTF_ID | MEM_RCU
	PTR_TO_BTF_ID | MEM_ALLOC
	PTR_TO_BTF_ID | MEM_PERCPU
	PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED

This fix was also described (for the MEM_ALLOC case) in [0].

  [0]: https://lore.kernel.org/bpf/20221121160657.h6z7xuvedybp5y7s@apollo

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6837657b46bf..8dbd20735e92 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6522,7 +6522,14 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	return -EACCES;
 
 found:
-	if (reg->type == PTR_TO_BTF_ID || reg->type & PTR_TRUSTED) {
+	if (base_type(reg->type) != PTR_TO_BTF_ID)
+		return 0;
+
+	switch ((int)reg->type) {
+	case PTR_TO_BTF_ID:
+	case PTR_TO_BTF_ID | PTR_TRUSTED:
+	case PTR_TO_BTF_ID | MEM_RCU:
+	{
 		/* For bpf_sk_release, it needs to match against first member
 		 * 'struct sock_common', hence make an exception for it. This
 		 * allows bpf_sk_release to work for multiple socket types.
@@ -6558,13 +6565,23 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 				return -EACCES;
 			}
 		}
-	} else if (type_is_alloc(reg->type)) {
+		break;
+	}
+	case PTR_TO_BTF_ID | MEM_ALLOC:
 		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock) {
 			verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
 			return -EFAULT;
 		}
+		/* Handled by helper specific checks */
+		break;
+	case PTR_TO_BTF_ID | MEM_PERCPU:
+	case PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED:
+		/* Handled by helper specific checks */
+		break;
+	default:
+		verbose(env, "verifier internal error: invalid PTR_TO_BTF_ID register for type match\n");
+		return -EFAULT;
 	}
-
 	return 0;
 }
 
-- 
2.39.2

