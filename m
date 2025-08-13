Return-Path: <bpf+bounces-65525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF56B24D7C
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677E17BEF88
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 15:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EEA269CE5;
	Wed, 13 Aug 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNMGQgEt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110E8266591
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099254; cv=none; b=CORi6fBrINY1sGm4vhqvLK5nIKQncJHOR/gvgNi3lEFRsKIwiwy1LhltYhtYsDhQzeiMMjdSbH02rm601RHzgzt/sjoJNJfT/3IkE+r5/wmNLWpREtiEpkTd/EzU+pI3skoIIIB8JQC6Y/yQ8jkqg0VSQ/SdscHrYzSNBeR89mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099254; c=relaxed/simple;
	bh=Z2K0ZO/aTkQROmJfTYlBgk90PUjTw/Vxk6fMOSaBRuk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=REPpAUZIic+kffPTRlPbDsvyb6oVNUxeyCquPObQ45+LumKbKn1HKMdNJL8xWmjVcPvFmwI2owgVi51KaWa3D6p5LZmKmsg3pCIN0beR9QaVjLANBuBvRNzXTpqGoiUIqPNRof4os7mIfxmOvOyc65667+VPKOFKenISaHpizpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNMGQgEt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so34867745e9.2
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099251; x=1755704051; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpJ8jIgGowTzBJitsrySjDaa8nHBSfr0te8y+RrEmRo=;
        b=nNMGQgEtABnKn6MI/iIAT1CSjVnvCd64RKyA9ZZgElkkgBxUiaCodzkYM0x7Q07auk
         hbUkBmW+Blq6ZbN5SGFKYAiSShD8NhwosH/1Nl1HouwIxc/Hr2qgWNSh0Si3AGSb4NYH
         otPCP2udzGdfqP+VQQicDsJNaXtk3TOYVQ+pR6S1SyLWFavNHWNI4Oh2WAybugjkRTRX
         tPu4OBGhsUpHVebDSWyu/gf1DHeu6oPm1vWPHtmLvNSHzIwI0/LhAB9yjNCpBgaBQycF
         SQ8MXF7xF/8BqdATiw4cRXbwBo8YcG+UGUheh0EtqYyzPEIPUFlyHXRB2ltCg7SHMpCv
         /Vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099251; x=1755704051;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpJ8jIgGowTzBJitsrySjDaa8nHBSfr0te8y+RrEmRo=;
        b=iG9QVBUJ61epfAyXYLZvmM4WM2DYLm7UdzHKXN564OK9YYFBulocDHgCAegNb2Tg2x
         wQtTHLf45QZrmch1Qhr/GXf1edLppC2vTuzkg8rKSJIsFIaduqIlMzDPAE0vB/evAKsb
         OiYO1C4EqHrkkg3cBYKvqt/pfYW5iv3u9MekpBq55EoXKa1/A+3WbAVBMDK9LIWaRnSP
         SpT+RiKG1H38nZLS5g/Aq70p3V2BGrCl3jnsCm7qVRwrEZ8oG/ZIeCUGSOoToXdAq3Ng
         bCGU7FoJIuIx2jdgP7u1jUNDstyV8MnV1LSsUioIjVg2VaAOugsARjrGP2sXo/0yrp9y
         wTMA==
X-Gm-Message-State: AOJu0YyF2XxAzhBTRLyCBhcKjeTgA3Aurnt5PoO5KQn1ghlm9sPpH4IQ
	15TjSmE8ay0jFrTgEpRN/tZHib3NHxxueD+pBxcldscOusUvsbEJPxywyU7eoEzj
X-Gm-Gg: ASbGnculqWcsgXcez2EBAeZT31bEBvWtWx6ELcSa4xSeJKXZEZCkC2wKGvm/PJVfw/u
	tU9nbtax27r1xCRsbkp4J9oqu9YJAdl0fpPNbMDSZ5Vc0y21awW6USRk6CWYvX+7GriVMeSaSHB
	UzSdPe4FQR6YFjjLpWvMklJ0pxvZIHg09yRF0TpKmff5b2wCCx8vYGSVuPv42cFqoRp9/Ki+/RL
	YxTn0AuiZWIU75q40oWbneXwVRKwwmFOgGZ+YD3p183oghipeEaUVODvBAqe1Co+0K5wMBKTiYf
	C5tgKeIX92rMCTc/8PCFvOdPURxtbMnWvTMfJnHAi0zb2hp+dDF8jqxV0yrf57Hrne3qp1P3y6m
	h7e+adbyXH52wtsyTPrXYTb9Z3V7nEQwkwJUUGVnr4Zpp3G7fKCQ9SEQYLOmS73eOF5BF+ZaMH4
	RfkwvueVQ26MspSqGuu0rSF4X/K/we9rA=
X-Google-Smtp-Source: AGHT+IGtmb9RQi5r2yKPd3IOCnuW7Alq1lpQy397cS43Nw7vvO1woAo5FPtIP6mkMmjrbBoYFfXG1A==
X-Received: by 2002:a05:6000:22c5:b0:3b7:899c:e87c with SMTP id ffacd0b85a97d-3b917d1ed40mr2578955f8f.2.1755099250910;
        Wed, 13 Aug 2025 08:34:10 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c989eb83deecebd8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c989:eb83:deec:ebd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2848sm47259094f8f.71.2025.08.13.08.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:34:09 -0700 (PDT)
Date: Wed, 13 Aug 2025 17:34:08 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next 1/2] bpf: Use tnums for JEQ/JNE is_branch_taken logic
Message-ID: <ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In the following toy program (reg states minimized for readability), R0
and R1 always have different values at instruction 6. This is obvious
when reading the program but cannot be guessed from ranges alone as
they overlap (R0 in [0; 0xc0000000], R1 in [1024; 0xc0000400]).

  0: call bpf_get_prandom_u32#7  ; R0_w=scalar()
  1: w0 = w0                     ; R0_w=scalar(var_off=(0x0; 0xffffffff))
  2: r0 >>= 30                   ; R0_w=scalar(var_off=(0x0; 0x3))
  3: r0 <<= 30                   ; R0_w=scalar(var_off=(0x0; 0xc0000000))
  4: r1 = r0                     ; R1_w=scalar(var_off=(0x0; 0xc0000000))
  5: r1 += 1024                  ; R1_w=scalar(var_off=(0x400; 0xc0000000))
  6: if r1 != r0 goto pc+1

Looking at tnums however, we can deduce that R1 is always different from
R0 because their tnums don't agree on known bits. This patch uses this
logic to improve is_scalar_branch_taken in case of BPF_JEQ and BPF_JNE.

This change has a tiny impact on complexity, which was measured with
the Cilium complexity CI test. That test covers 72 programs with
various build and load time configurations for a total of 970 test
cases. For 80% of test cases, the patch has no impact. On the other
test cases, the patch decreases complexity by only 0.08% on average. In
the best case, the verifier needs to walk 3% less instructions and, in
the worst case, 1.5% more. Overall, the patch has a small positive
impact, especially for our largest programs.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/linux/tnum.h  | 3 +++
 kernel/bpf/tnum.c     | 8 ++++++++
 kernel/bpf/verifier.c | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index 57ed3035cc30..06a41d070e75 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -51,6 +51,9 @@ struct tnum tnum_xor(struct tnum a, struct tnum b);
 /* Multiply two tnums, return @a * @b */
 struct tnum tnum_mul(struct tnum a, struct tnum b);
 
+/* Return true if the known bits of both tnums have the same value */
+bool tnum_agree(struct tnum a, struct tnum b);
+
 /* Return a tnum representing numbers satisfying both @a and @b */
 struct tnum tnum_intersect(struct tnum a, struct tnum b);
 
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index fa353c5d550f..8cb73d35196e 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -143,6 +143,14 @@ struct tnum tnum_mul(struct tnum a, struct tnum b)
 	return tnum_add(TNUM(acc_v, 0), acc_m);
 }
 
+bool tnum_agree(struct tnum a, struct tnum b)
+{
+	u64 mu;
+
+	mu = ~a.mask & ~b.mask;
+	return (a.value & mu) == (b.value & mu);
+}
+
 /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
  * a 'known 0' - this will return a 'known 1' for that bit.
  */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3a3982fe20d4..fa86833254e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15891,6 +15891,8 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
 			return 0;
 		if (smin1 > smax2 || smax1 < smin2)
 			return 0;
+		if (!tnum_agree(t1, t2))
+			return 0;
 		if (!is_jmp32) {
 			/* if 64-bit ranges are inconclusive, see if we can
 			 * utilize 32-bit subrange knowledge to eliminate
@@ -15915,6 +15917,8 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
 			return 1;
 		if (smin1 > smax2 || smax1 < smin2)
 			return 1;
+		if (!tnum_agree(t1, t2))
+			return 1;
 		if (!is_jmp32) {
 			/* if 64-bit ranges are inconclusive, see if we can
 			 * utilize 32-bit subrange knowledge to eliminate
-- 
2.43.0


