Return-Path: <bpf+bounces-78870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31870D1E629
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76A59307DBF0
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 11:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCD8395248;
	Wed, 14 Jan 2026 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/4O8e7Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6520536C5A7
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389938; cv=none; b=B+UyoXGSE8o1f0mR2/WB12WxQaDeHTVi8dESqruHkVvshz7eEFo7ZIS8rDKbrZdkVlhv9CVWV0NLn6RHCNCLw4Jw4xVWkM0wLiVCYt/rcYoMXFNqATbJAy/zzbF+itEf4AkGrTxnCxwrD0VEJWwyFGkefPxv9YZj19NK0NzJPoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389938; c=relaxed/simple;
	bh=hgXJpH77hvcBVKHH1im1p86iTVxyWxbx+ia9CwbiWZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xv2sdNUBysbTS4fqdMKxiGJPSWB1TvkKwqmS0p6qomS2x6ySh18nJEBemH7bq2DG6LK8bxvYmjKYQRTXSyecBDkM+EDrIEu8D+rlZpIIzHMGnP/k0THlAMoeshJ1N4rJkk7L/4kCKmET4AskQOVpvLgIhkpsCgkrT7wyZeywWjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/4O8e7Y; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso13069967a12.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768389935; x=1768994735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGbsNX6gJa1WyRpXzSxqLCWBhCF/R+wAe4rBID2DyBE=;
        b=g/4O8e7Yk75v2p+CqWP7PI7r15yQLoNaM8mw6v3olvb7T/cpgW2u6nk7utPLJAnkv/
         NpkQm2XeOVtCjiN5FnFKXDxtK/QFp0JUMdZrvlQELm3Zfi7gZ2fVIfpmBDpOQePaH5m/
         O/UsqoNDTJrBY5qDR7LbzTllPsSTri2R3zxN2N67BrOscVdtqX74hPr7uNn6vyv1K/84
         anHabALGV3ZFBpZ7x7bt6Jz2FcCEtfqVIRFBfNoiU5lrnT6wG5lx9k+wCk0AK7s56Y4l
         CvWnyknpd9AgYXGw39lTDM+VA2LNcmV9SWF81/znVUV2IbXlwi/CGtytGiTexHTGsG+J
         ynxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389935; x=1768994735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MGbsNX6gJa1WyRpXzSxqLCWBhCF/R+wAe4rBID2DyBE=;
        b=r6myM8rb2+8Q04dP1BlYe0GTuBeHoUWkELKF9M+Y5cNIhUzoLcM4Ei3e8z5GQjSbWO
         TB80iKytxeXTbB30k4ij+3hn+7Sr/OW/CoKF3znWIM0JgsM6mJ/rFrestaONROWMzQQv
         rDQSR5Dvdp1lLC47lTqO8eGMbdF1Ld+SmQd26aX4rgPyx4fRZfB59QD1/OSsyW5H39EG
         f16gk9qkdPdHBlSOVsqGSOpJSPR6UAyAAzUvFcR+bf1e0KXydVDEOu4m8Spp3e3jW1uf
         jwUimk2EEdFCoGkcHgECO65E8MIWoYGNetMF9u9AeMpVWqGlEMQK9biTsDMor+YDWq4N
         Gz2g==
X-Gm-Message-State: AOJu0YxjiKXPvvY5vgztfBrCzEgmOjisLYuA7JE36eLu49cI6co2A1AF
	KMZiqyfFUqE0e4V68OJDSr751fTsTpPTP539VjHeXe/AdU5sEkK+erzxoWbiNg==
X-Gm-Gg: AY/fxX7uZT5I5NVNR7h5BGIj3NAPIGB89hinQhM2j/u/D/1HcyVs9vLUqED8oOb8cse
	y+aSZu0VVRrhRYRc+iQp9V9XYyHwQETo+/7uRBwIQ1XKF9bdPSWLevv/AiIHChwAeMSV74AaGYq
	XR/iYlyqfTdfjEkOb3lQ3B1AyQhoQpqGnuRiYFjF3PV2drC2bTfuQl/SouWV/Xt6+RolaSEQ9g4
	V9vn4Z0dTKGMbQe66Jb8dace9cgfEtuMMLBUgw6ecITWPKJKF7E1KNKN9flEBuqXqNfaWnXfN0k
	+ZiK1tDrgKB64IbrTZDgSYZzvUA4FuqGVYOEj5jkgVyoMYFm4jzA8zN5v5Fnur+paRmPPhNQljv
	Rf5o1pYDqx8So545nNbhM+bHPr+pAhlvx79zMExOHAUwx9aRHlImjbgy/ovjHCysiU7Qt6X8AhC
	bevfJMstw2qt2qBdh+HAHTJMWIWjhnPg==
X-Received: by 2002:a17:906:ee8d:b0:b83:246c:c514 with SMTP id a640c23a62f3a-b87613f83ffmr191774466b.51.1768389935211;
        Wed, 14 Jan 2026 03:25:35 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b871188ec63sm980423266b.1.2026.01.14.03.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:25:34 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Properly mark used registers for indirect jumps
Date: Wed, 14 Jan 2026 11:33:13 +0000
Message-Id: <20260114113314.32649-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114113314.32649-1-a.s.protopopov@gmail.com>
References: <20260114113314.32649-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a `gotox rX` instruction the rX register should be marked as used
in the compute_insn_live_regs() function. Fix this.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa1ecc1fe9d..fdd65107a9e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24843,6 +24843,12 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 	case BPF_JMP32:
 		switch (code) {
 		case BPF_JA:
+			def = 0;
+			if (BPF_SRC(insn->code) == BPF_X)
+				use = dst;
+			else
+				use = 0;
+			break;
 		case BPF_JCOND:
 			def = 0;
 			use = 0;
-- 
2.34.1


