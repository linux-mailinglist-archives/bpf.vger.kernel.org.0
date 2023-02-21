Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACDE69E8D5
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 21:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjBUUG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 15:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjBUUG6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 15:06:58 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A770C30B3C
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:56 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id ec43so21440203edb.8
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gjATKTPjeef4UxhZLE+OVD3fftepy3M/KUpIRkKPPE=;
        b=at8R2zMXSQ5cnwEn81PMxocNPbkZmT2ngWt0PeVj0LG7RMvvjrISeePNHq+EhsoJtp
         BNiGId1oNrPjEm+FPGe2eNRxxHzNpEkRwAQX0ufCAxu8CAFyeVmpUE5PfmwZgStWpGZh
         91r1VZWydpOtW3DYovk6/FJXbxf3Ejtc3qq8orSXrE1TCouDBzPXTtzaNWFg+yw4NfSi
         k8J+2wFAUKSSOy2Fxn3qdkuCBT81d5bFD0U4Sj63O4Zltf16gBDWta8WROLN8BPVCXI1
         q/GI63GUXGSybD9oflB+YCdQuDU1WoA9RowaOXq5iMaXtO3rMF8OCpos+Hm9/M3Z830n
         C2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gjATKTPjeef4UxhZLE+OVD3fftepy3M/KUpIRkKPPE=;
        b=oltu1P1PGZMOla1OgNrdXTJpPPXh15vDFYFGWldz1brOM4A5pZZ6nQ6yQcWSfTe2TF
         L/Cf9ZhyyPtsQKPMU3d7xevGP/bhjm36CZY5YgaYixzU5YMJnlEhlcWiXAWUwgPjnDZ9
         Mg4ew3986HvSoodrOhLNrJUd5+Xng15lk6Yf1jM5a6anWndYoTZ6wGG6u9eVAESxJVcx
         nijoW1ByXRuLKWuK7GjMD0ZstyZtpr3brOy29/ixc/f035TtsI+ZyIEo9BaZEkoRs9Op
         L3AqfC1MmAl08D36b8f3Busz8gGiuONfVcsLqQciUJPIvIj8yNQ0nhtPIgeXebJj9IO3
         RoKg==
X-Gm-Message-State: AO0yUKVonPb/elL87Zlt4KTxRa/y/xitkePoLNdy3TJwzsI+sJ1dYtPK
        nwukQCq+qOa8fE7MbWNS5bdzlSu0BppEHw==
X-Google-Smtp-Source: AK7set8k+b++4ppKOF40b4mYhgBku1dh4Ei+pe+DsUVOR7nYhtLikZ3raXk7RQ+8gJNIrN91I1fKVg==
X-Received: by 2002:a17:907:9620:b0:8ab:a378:5f96 with SMTP id gb32-20020a170907962000b008aba3785f96mr13131498ejc.3.1677010014629;
        Tue, 21 Feb 2023 12:06:54 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:6d0])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906711000b008b17879ec95sm6805651ejj.22.2023.02.21.12.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:06:54 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 5/7] bpf: Fix check_reg_type for PTR_TO_BTF_ID
Date:   Tue, 21 Feb 2023 21:06:44 +0100
Message-Id: <20230221200646.2500777-6-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221200646.2500777-1-memxor@gmail.com>
References: <20230221200646.2500777-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2598; i=memxor@gmail.com; h=from:subject; bh=Lqdy/IKzOnseTIegz0Zq4nxx9kSW/9SvKf/gr8GzPMU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj9SRMwXAfDptv4JkR1DmGQNTV3abjCUocDju4yb7q Apnj8QeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/UkTAAKCRBM4MiGSL8RyjatD/ 0YaOgSFs3BqtRMpi7Zf9jjuPDgaQ88HnkoXx9OqarW3UbYg5qXTRESiGRrREH5Aq36jpe6/ymZKbtN NcR/dN1GVZKKoudtNAlDVsfXFGWtudtDkAnHWNzr8swb4kEzZLK+MpuzvvQsS7gzuvZuES0mDfS/ES FaCeObmP9W9RA/DYo0ywVx/AWf+A/+xvphxflXIGZ6kC8wVNpmnPeVwDCTWYNe/Y+LejRWaVOGU13x t1EnIfVN5sAr3aiEq/HfZMuVqGA0DGT+xIEqCDvwZlrF6dWUvJsuukr+y4Xe3HeagtAFaBg7k3bio9 vgRf2O9ckB+o9kMzK1fIKjB+vEDXco3SwRjGN/lZyju82eLe0o/IVxO6dBE8zHjtDV5MtQgGyHSLlP QmrrmfC0qcLnY3rh4PrTwzln4AMqBQ1E1NZczmVarVxNVZEBhcCPFGgvBuvxvQJ3RwSZXdTQhuDUds Eg+0WQyI5sxrrwiWeHR5EhhmpaLR/HSmI+mEw9GAqcv93IeCRJOcMURHjy46OafSwi7tDtIcirB++N ZavYwghngFKdWXkcLhlV7SdGz8ggvVen1bljxEadwaE3d+rITHuAatrtOLx0X8zJplLuTr4/4sk/QP 2rYv2xTTuK/vJrjE8B+65wiGSd6TfAsxzfKX/caZ0Dnyhjofl5Jux8jfgY6w==
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

