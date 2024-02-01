Return-Path: <bpf+bounces-20895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9C9845025
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061711F26275
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3933BB53;
	Thu,  1 Feb 2024 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJHxVyda"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30D73B78D
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761284; cv=none; b=isIs8Owq+3fEqmor6sWgttPAfc5fw+ga2wVLUTno65q8dLn/lHWZjA1+mzKE/g1VDOKlixCcw99YlECk06jN6H0uM09SioikYY/uJak0AazYAp/ziktdI9QDRKzzxioAw20ULBH7nxr2NVYWq0/NrzUkMVzOlqimsDtswtUDGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761284; c=relaxed/simple;
	bh=9/c2AaKHS4Ris+0Lp1KuGSpm1h7kSRvJFZgOzePFslo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EUx2CIDilLvGKO+COgJ1sAXeoe2a4yZjYDOcNQUxfCaOn5zxyI+RzKj0qF25jl5HQyXqprxpcLoS7W8e1iukQTDRX1zlC0QlIibxo8PoKAwc1DGVBcCaJGIGLCsA+1O5mz59trSvkQAmfKdz7wEzI/i2uiMtvX9mCBvCSVA/kY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJHxVyda; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so7337031fa.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761280; x=1707366080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSDuCib4mmoNQQ1LinjjB6FAjxnk/c1B43QuLBvcuFA=;
        b=iJHxVydaUbEGQrmXYXvSH1mZouDL8UeYESFKBE1OJfytf+Z2kxGDk1Pmi4erd7Hy+C
         M0IBBH69XTcr/DNDXOCw+k08tdiJXpCAcQPzdU86cXL3U04HTh8c6tyrFU1CUMWvX0US
         RMAW8mgS9P5lFcUlwe5lZaQoR0jhGaZYphjDLZif9roO1IrxbBcod0F/NyaCYTJpzqUM
         zHRLqQ0sXN9kJ0xc7eHI+2jKVsgdKnHIz/8ROVZk9BjmtSAYL06igTA1vIRTrnvwC54S
         qumtravtDFYDL3FbtO9DtH272Mbzd8wOGkr1h4g/Mbj+4l9CmgX4Kz9uSwOaM09LMalK
         0mHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761280; x=1707366080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSDuCib4mmoNQQ1LinjjB6FAjxnk/c1B43QuLBvcuFA=;
        b=ds0p7xTpodAJ6Hz3kSRseubq0ni4V4D65zWPCd+P4sOb2ythBmNVeR/P/mKrP0Tlkw
         MW47x3p8okFoIL21biS1RxwTGZz2s0bOVm0MV0+mmaPpKy4jMfoQLpCRg/JdQ2B4gmlG
         4OVUq5haNFQPQTdIfkfPZW2+5RvwyjlCuO8FhwNgoOAoDaiCqwM6ZYD/a4DimPRMZAv+
         hoT0t95+91WL7vY8D2oGU3QENaMeTx6e1tniX1tFmM0kkPtvXiq7eLPwXr3AWIl7dA9k
         Q1e2o5OFV5GxLNVITzNny+Fy+T9PHIIlGr4vXzLgmyHRkGngKFMbKAYU3uqBbeSVWarO
         GgaQ==
X-Gm-Message-State: AOJu0YwoRg+805257EiZsVrLY5zpvIMdvQAHByyhMBVqm2Vb40y9EIVw
	iTxgdSQygIZYgfn/4QtpQG2w3qkxJLKlBTBkDxcl91QNzZEoyne+Ey15I5eu
X-Google-Smtp-Source: AGHT+IHlgGw8qWZBKXQzHTOrU3Gi0P0x7yRVRFneUrWVMrVK8IaULW9onzfwsCwj+xwabS3MColu/g==
X-Received: by 2002:a2e:b710:0:b0:2ce:d23:ec79 with SMTP id j16-20020a2eb710000000b002ce0d23ec79mr2296691ljo.40.1706761280361;
        Wed, 31 Jan 2024 20:21:20 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id dj10-20020a05640231aa00b0055f1717216fsm3128556edb.51.2024.01.31.20.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:19 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 06/14] bpf: Adjust frame descriptor pc on instruction patching
Date: Thu,  1 Feb 2024 04:21:01 +0000
Message-Id: <20240201042109.1150490-7-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3514; i=memxor@gmail.com; h=from:subject; bh=9/c2AaKHS4Ris+0Lp1KuGSpm1h7kSRvJFZgOzePFslo=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwOjo/557iiZfLQt9gP7hKhrM0CW/SNrKTSf 262qaTTgfeJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscDgAKCRBM4MiGSL8R yvuOD/9Koul7sAMyZpfRg6Sv1Dy3G1xBkYpiUZW4zkKtw/aTXA0HDEJTWQcJTNWSzwYEEOkeJyX zIoLruijYDJCCRu6kCiBf61lI002nh6HeKzjYvREsdZ6xDp32cny/5kYnySm/kCk/cDjWxJfvUJ 5dlYb0JRhGT1QvraGdWrm1bcZenptmD2g7Old3hREI5Jd2aNcHReEwUwX1I/puseyGaMRg5jiAK w+dzHyU5+FoH5q85N+IrT14jdDGdLsbohCBq+MuO9o7SKd+VsQi7WVDMF40nT3vVlv17vDFBln1 sQG8rqNBf2uCUcSeJUF5f0PdradLMfShB0PZJoo2AUYo2iR/ogBxAqatKPT8/PZLBbVUayccE30 vHsmyGojIS80gMUL4gYv1TQpbhiXatHWyP+1RTntbnUa8gJtVBVVNeyqBShAhryZ9nj1A/SuyX2 T4r3SBBffQ+pOrAUN2UYyrJgzLflkpz5G9FVtUC/RzDwEuF3+KFJPexVTxF09TenHZ1bA3hZaE6 i3sX+9bPM7NAOj/Sax3fOn1MCX7O2kHtEcE5NGwp6Yb4zHD9vkDyqZrVMX63blO5KHvFVwvYIRB agQ2w8sw5ebhKlWwikDY0EZHt3cCKCJ1xFaAfwltNmHe/lzQpr1QUwRUcURxMwDJptdURCEy+pv qSnK8jIe5+QcimQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

When instruction patching (addition or removal) occurs, the fdtab
attached to each subprog, and the program counter in its descriptors
will be out of sync wrt relative position in the program. To fix this,
we need to adjust the pc, free any unneeded fdtab and descriptors, and
ensure the entries correspond to the correct instruction offsets.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 27233c308d83..e5b1db1db679 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18737,6 +18737,23 @@ static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len
 	}
 }
 
+static void adjust_subprog_frame_descs(struct bpf_verifier_env *env, u32 off, u32 len)
+{
+	if (len == 1)
+		return;
+	for (int i = 0; i <= env->subprog_cnt; i++) {
+		struct bpf_exception_frame_desc_tab *fdtab = subprog_info(env, i)->fdtab;
+
+		if (!fdtab)
+			continue;
+		for (int j = 0; j < fdtab->cnt; j++) {
+			if (fdtab->desc[j]->pc <= off)
+				continue;
+			fdtab->desc[j]->pc += len - 1;
+		}
+	}
+}
+
 static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
 {
 	struct bpf_jit_poke_descriptor *tab = prog->aux->poke_tab;
@@ -18775,6 +18792,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	}
 	adjust_insn_aux_data(env, new_data, new_prog, off, len);
 	adjust_subprog_starts(env, off, len);
+	adjust_subprog_frame_descs(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
 	return new_prog;
 }
@@ -18805,6 +18823,10 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 		/* move fake 'exit' subprog as well */
 		move = env->subprog_cnt + 1 - j;
 
+		/* Free fdtab for subprog_info that we are going to destroy. */
+		for (int k = i; k < j; k++)
+			bpf_exception_frame_desc_tab_free(env->subprog_info[k].fdtab);
+
 		memmove(env->subprog_info + i,
 			env->subprog_info + j,
 			sizeof(*env->subprog_info) * move);
@@ -18835,6 +18857,30 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int adjust_subprog_frame_descs_after_remove(struct bpf_verifier_env *env, u32 off, u32 cnt)
+{
+	for (int i = 0; i < env->subprog_cnt; i++) {
+		struct bpf_exception_frame_desc_tab *fdtab = subprog_info(env, i)->fdtab;
+
+		if (!fdtab)
+			continue;
+		for (int j = 0; j < fdtab->cnt; j++) {
+			/* Part of a subprog_info whose instructions were removed partially, but the fdtab remained. */
+			if (fdtab->desc[j]->pc >= off && fdtab->desc[j]->pc < off + cnt) {
+				void *p = fdtab->desc[j];
+				if (j < fdtab->cnt - 1)
+					memmove(fdtab->desc + j, fdtab->desc + j + 1, sizeof(fdtab->desc[0]) * (fdtab->cnt - j - 1));
+				kfree(p);
+				fdtab->cnt--;
+				j--;
+			}
+			if (fdtab->desc[j]->pc >= off + cnt)
+				fdtab->desc[j]->pc -= cnt;
+		}
+	}
+	return 0;
+}
+
 static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
 				      u32 cnt)
 {
@@ -18916,6 +18962,10 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	if (err)
 		return err;
 
+	err = adjust_subprog_frame_descs_after_remove(env, off, cnt);
+	if (err)
+		return err;
+
 	err = bpf_adj_linfo_after_remove(env, off, cnt);
 	if (err)
 		return err;
-- 
2.40.1


