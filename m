Return-Path: <bpf+bounces-46285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE669E7535
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2773188614F
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E4420DD53;
	Fri,  6 Dec 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4ZulB1D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC76198E86
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501462; cv=none; b=NVkI2xyo/Ckm3RTJgHXU9f+WqiFTgwj7sTMLqL4/WYvqBBBiTh5SBVqj2DezvePAcnQSE42uWL7bgM27iWnR7W8PN0D2C30uc04gBJ7/9kuRdkXchpF+T57e+WH3b05QULSZ/vLmPX/uFzT2IoYlqtAYdbT41L04CJdAXOwf5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501462; c=relaxed/simple;
	bh=6SYnAZ+Yniywq17NYFLuBtuw5RJyC8ixM2EHSWHfS0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNun9rNbO8dNcsQb2Pa6X+M53b0HXppareMPqnuBVx9V5WJIROrFsSc87IVV6l3NXRh11wEuRIhkopepOOtbjDRB+oRbOb4Nh5t+OBXUix4Yj4vEc4BEetQJP00SOcpyyyfD+cz6/ovuNVo2n2hWsxEtc13u/1QdMyP66y3T5zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4ZulB1D; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a736518eso25678655e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733501458; x=1734106258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozlORsyVdl733TljK6jsEobVUX/kPQQUfwmQFnC3BSI=;
        b=H4ZulB1DlO/2j3hTHLe7SesPPeTmJXGACyFSNwbEMiSXdAP1OSdxUrMkTl6PAB0ipG
         7TJIQYQWAoY3B/n2nZH95/SGeRiRk4FhAWKGSPUxmZoDa/pfphK8biNjRCNjremmsDaq
         //sZ0/zCHrLJawgZB94v9txa5k7Qg1I9FkIEp6GEhCU9MvIefM1u8/Z5PMRyxk1dzMGw
         Xyf9id2sG9XpmUAuSwm7lHYLRQTrvI05lxOwdjJPXAF8P8pTn8gg1rVAood5Qx6sDRbT
         tzIzStWdJeIDyD/1VNgOZ0IFbH5ec+2YM9Y+143O0WV4+EIMxe4PPeUMfVsnPLYQiJo4
         r8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501458; x=1734106258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozlORsyVdl733TljK6jsEobVUX/kPQQUfwmQFnC3BSI=;
        b=sp+fkX9KXRxd7Q+ANlUZhHtM6mFNUY5PHSEZnCjy3bnkslU+zr8FU5i3idtKrZg/VC
         0a2M5G5h1eoN3hOBYwTA46TAcHv2k7doqcMfh5q6bbs+jm92DbZ+omGbmXIQK08RPqp/
         dpAYJZdOYyE/LOjwsz59SrF/IsNyj+XP2ZMOxcMDlzrSDm7GkvPvi0MUt7hAvMwnUOLQ
         9mX3MlhknsEcWMQWOhB++Aa91eWGHyYmULDnCe5SKZn/A7zF9v+fBNfN+FFMuMuFMMu+
         LhTt0mdxFt7rDYZkmV3ZB58JVJbeYrnwfMt+B1w4TDuppLKwaQhcFzXewk3OH/6zvcF2
         8mEA==
X-Gm-Message-State: AOJu0YxhQyul3FuSnYQ35qqGMyNEFKZMRpDzYg7sCtOHPlHbHeG4Foho
	6+nDG1KgR5xO1cDliZhlxslL12k7uUNR+ZywLmpbs7Y6cQRUSoxVs2f9QzRGEpo=
X-Gm-Gg: ASbGnctVbFkuZX9D08xClj2zwxhqKrVnKhy3aP2URv+BedMYjUqwoRlHYlKD92WcpLg
	vGReDsYaztisIDWrPydxKGqz/YvoPABQDNCAFwQq0dgZx58tFpM9DeOqKeHCMV9b3u9fXivWy8i
	kXttPgq3K6lXTZ0FWNViTXe66IkSQJctnSZswlQCRFA3GOctwIMLkBQuevlqXDfUCTgIk26bKCR
	gjY4q8Pmt0Iop/3wFFzorCmmSoQ657PqAk52AWyldodY9zZfODmNU0KCXrxePcd2Kf0eCjRKRft
	dA==
X-Google-Smtp-Source: AGHT+IF7gILd7UfSk0gj5vCm3CCG9iFPT5eDU9ZPkrVooR1CJeQ2zvbPuBqYRWGmfb61ysq5xt+EmQ==
X-Received: by 2002:a05:600c:1d85:b0:434:a955:ede with SMTP id 5b1f17b1804b1-434ddeb8d9dmr38503455e9.14.1733501458563;
        Fri, 06 Dec 2024 08:10:58 -0800 (PST)
Received: from localhost (fwdproxy-cln-031.fbsv.net. [2a03:2880:31ff:1f::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d25d6sm61264655e9.6.2024.12.06.08.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:10:57 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Manu Bretelle <chantra@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v3 2/3] bpf: Do not mark NULL-checked raw_tp arg as scalar
Date: Fri,  6 Dec 2024 08:10:52 -0800
Message-ID: <20241206161053.809580-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206161053.809580-1-memxor@gmail.com>
References: <20241206161053.809580-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2888; h=from:subject; bh=6SYnAZ+Yniywq17NYFLuBtuw5RJyC8ixM2EHSWHfS0k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnUyEsfmF8oUOOtv2aY5xv1sqMPfmrbi/THGTaOgca WMfSFzWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1MhLAAKCRBM4MiGSL8RylHnEA Ce5tiN5nG5NiTo0pyoXJ1z06kFqbkL8qEPM0t3q+qoL7kNDG9pmQ+uBrAXK2GVn9VDIQkZl1Wo6SHM 2HHNDWrODiUqWy8ECLU4QxYpGz6dYEW5ps+gWBbUKl5NnySW8IpUngwGMnFakkDJ2fiZ3stL4E6gNd rAUP9WOYUM29bK0AQr0xyIHgq1pvIplwHl+W5rgY0j8oIZdXpzyxTOMaCNBdZm1I03xuTPf2PfOjE5 ZK3M1tAxZplYFq5aIOvOpPDq/sQF4IBIC/zYoEMxYTBPWjzMSUh3FrNex+at4sXBbOLFLn6EP1m0Fk ZgL6UeVODDGp2/qvEHFrnmQjjgHhlE0OpctFa4Bl8nMEwZLEX+bOm50XI7iAitSoV68co81YPOARiP BZsz0i6AyC+yJEG2brsj0KLNr1kvSGK6ks9ZuEX19sTlEBF0zfSuRJjs+z991Za8jo2y42FX9DGz+w 0AdzgXxxq0e+dUaJ2Y+E6YgDM9bzX3T7jrSnvXaXLJ59OT4lGWy2P5HPGmeSl2OBy0Hzb42uG0BkGZ Flw3DktFf7ibWx9sML44eDkKXcxGyNa8ydPiWLBPFFvveWQf8c16VwgMmTdW41Esq4PhytQi9XH6UZ GhBM7pROA0yAc/LOvELprDaCinLjCaUxs65xaHhLagBicgDJBakf34M/r+sw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Commit cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
began marking raw_tp arguments as PTR_MAYBE_NULL, which caused the
values of these pointers in the branch where they are seen to be NULL to
be marked as scalar zero.

In comparison, raw_tp using programs which did the NULL check never
explored the NULL branch, hence successor instructions following the
NULL check always saw a non-NULL raw_tp pointer and performed memory
accesses on it.

To preserve compatibility, we need to leave a NULL raw_tp arg as is,
such that it can be allowed to be dereferenced. Otherwise, the verifer
will notice the dereference of a zero scalar in the path following the
NULL branch and reject existing programs.

This can allow programs that do bogus things with a NULL pointer to be
able to access memory (with PROBE_MEM) correctly, for instance a program
only having:

	if (!skb) __builtin_memcpy(dst, &skb->mark, sizeof(skb->mark));

However, such programs would also not fail on earlier kernels, since the
verifier would simply never explore this branch. Now, it will permit
behavior where such memory is accessed and explore the branch.

The correct way to fix this is to simply introduce the right annotations
per-tracepoint, and remove the masking/unmasking hack, until then the
raw_tp stop-gap allows programs to continue passing without deleting
code that at runtime can cause safety violations.

An implication of this fix, which follows from the way the raw_tp fixes
were implemented, is that all PTR_MAYBE_NULL trusted PTR_TO_BTF_ID are
engulfed by these checks, and PROBE_MEM will apply to all of them, incl.
those coming from helpers with KF_ACQUIRE returning maybe null trusted
pointers. This NULL tagging after this commit will be sticky. Compared
to a solution which only specially tagged raw_tp args with a different
special maybe null tag (like PTR_SOFT_NULL), it's a consequence of
overloading PTR_MAYBE_NULL with this meaning.

Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
Reported-by: Manu Bretelle <chantra@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 82f40d63ad7b..556fb609d4a4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15365,6 +15365,12 @@ static void mark_ptr_or_null_reg(struct bpf_verifier_env *env,
 			return;
 
 		if (is_null) {
+			/* We never mark a raw_tp trusted pointer as scalar, to
+			 * preserve backwards compatibility, instead just leave
+			 * it as is.
+			 */
+			if (mask_raw_tp_reg_cond(env, reg))
+				return;
 			reg->type = SCALAR_VALUE;
 			/* We don't need id and ref_obj_id from this point
 			 * onwards anymore, thus we should better reset it,
-- 
2.43.5


