Return-Path: <bpf+bounces-71258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE7ABEBDD0
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 23:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 469104F2992
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6CA2D97B9;
	Fri, 17 Oct 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOy3pr5N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C22D59E8
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738192; cv=none; b=r0LVeMyozzPNs5ISn4aM03JqmCVXlA4UaUyGfjGlZE6ZdzKowar+Gv10dg0Cf02ZvtzqBM81j8L0MoBDF6U9WUcqyaEpLaNhKvdBSD9sekP80NxFProUdIQXs0rW6Q0rPajEI8cmnsENjQ1WwfEmz3tLVEIudwBvH/co1BJOyqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738192; c=relaxed/simple;
	bh=n0G0Z+92IypGH3eawej6SXwPonZZG9VIFFNWrEFNd3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nn4X3EyoW2QaNQag2O4RxHO3WKpBafBgEyz+7d2pVPbqrisrjo5843NCL/WKlWJ/gnqb+k6Xyohjob7y0CZo6RRyOwVWfuAucaRiVthKnl9xw41glj2/sxKfJhOKt5GaHJ5v2c53NEXFB0ba8NZ+XzLgW33fGNROsCF3MpodAHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOy3pr5N; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so2971992a91.1
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 14:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760738190; x=1761342990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSNp2i4w9S/UuwRxxUx4tJy96Wj8Kx1e17mXUe1U+I4=;
        b=jOy3pr5N38GOl4O0uekM/C8yTaOG/e6k9oFLPr8+P71No8jFigXhd0zE2bSg0m7/5P
         YyMpsun/WFrR2MJClYMjtdX8iMLIINcmk1al/ubvRAO51eTaodmDbIxoCOMumOt7wP3/
         UME5Tn6EoXtPt8fdoDh4aaUTvzRGjS3vw+3PpY1EbJ5r33MygPAFPMp64Fsw0ihBZgjx
         f4H/Ty1HNdgxCRqKXkPUgGDxijvb2lZQ8ayz/AnoBDJml41NNwAFUaqeriIf1U8y239I
         c2K7nn4dRUrJitpUmheWp4umZfhzH9QA73Eb/IKusI94qdoGS0Q2gn2CbaqKsOjVjlOI
         R5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760738190; x=1761342990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSNp2i4w9S/UuwRxxUx4tJy96Wj8Kx1e17mXUe1U+I4=;
        b=kecpbTGz0J4DN3G52iBNGzxLrcXMR1riU7oDFfCA0xLV/ovYajCDc811pQgOcafxv3
         a+/9o2so1VYkg+uogoW4Gt0QXEZ8q/iIbh/uh7tYsTntoA4kwhz2lctlRAArwNhDwHVJ
         xIAiGiejfNA0pMTJVUQ4mJWPFB5QmHVapwrjpcbW6utKuelD2lcp9mVCtnTsl3yhXqjC
         vYo8MxxggrtcMdyXqbUVyCeTiY4t1gInq5tVQ2QDhvMqbY6sNwaDk5o2aTkVH/mLiTK0
         1/Sv9s0T0kaBit4HRGey7gJRYlcI35lNg2VN6CEP3AD/pXc1z6u0bqNA+qCdNmNLlr7g
         6rlg==
X-Gm-Message-State: AOJu0YyDoqjTtZlsHjVkoJVKoz/LV/47JxASPV42Gc1ZrOiVC655YmVV
	HF+XhDj1F1ltjax9E4ZUkRmKPJQJvtlrrlf30/gruKsfCWkDsfqAJeYF06MIeg==
X-Gm-Gg: ASbGncv7uHwtgS6z5Wwjx9PT25udJdLVbl3QTdiGxxEZ+nlbmjY27AhJdn95W7QQ3tM
	xXQebeF6lqHgZS/tZn0kkBC32/KADXirCHqIxWtRvYAbuHcxrVMo19m4/tQl+yGB5GkdFPpS7lP
	bFBMOsmn4GxkUEM7yDVDseA5R3631fXsfxLWwZjuxh876BpwP7TXoGZMd/Q7m0GmIVZ3sMFpFOY
	RxRBrphzmpxi0lY3FEnfrUnnkUmecTRf7qbymW+wwhMnBXmMmW3iy6DgEpyzI/hEk7CvFo7kxc8
	JcTbUslyeVNSEAMWGq+5+l3MqRTJjaLUxEBP5uWclWn2snqPbMb6I5p8+y1jd0azez8xzhjAoij
	RhgE/bDV3FiZf/obq2GOjIqq1MCpLJObDg/XSusLnwqxcxT+irbOCD7eY7xWYOvzCaIi5dIURQr
	LLvA==
X-Google-Smtp-Source: AGHT+IGPkqtgYtMfBK5D3xvy6izkNvXdeJo/NsVEO9qJIPTFdmDTYo0zlfoGaIeGBJ7loNYCRgR7XQ==
X-Received: by 2002:a17:90b:1c0d:b0:32e:70f5:6988 with SMTP id 98e67ed59e1d1-33bcf90c0b5mr5233779a91.32.1760738189992;
        Fri, 17 Oct 2025 14:56:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bcfc12f82sm1722511a91.12.2025.10.17.14.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 14:56:29 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/4] bpf: Allow verifier to fixup kernel module kfuncs
Date: Fri, 17 Oct 2025 14:56:24 -0700
Message-ID: <20251017215627.722338-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017215627.722338-1-ameryhung@gmail.com>
References: <20251017215627.722338-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow verifier to fixup kfuncs in kernel module to support kfuncs with
__prog arguments. Currently, special kfuncs and kfuncs with __prog
arguments are kernel kfuncs. Allowing kernel module kfuncs should not
affect existing kfunc fixup as kernel module kfuncs have BTF IDs greater
than kernel kfuncs' BTF IDs.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e892df386eed..d5f1046d08b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21889,8 +21889,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
-	if (insn->off)
-		return 0;
+
 	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
 	    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
-- 
2.47.3


