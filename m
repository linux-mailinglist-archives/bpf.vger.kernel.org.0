Return-Path: <bpf+bounces-66088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EF0B2DD92
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 15:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B121C806FE
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7631CA68;
	Wed, 20 Aug 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0OFjkVj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A627EFEF
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695891; cv=none; b=adRsSusMKwkkH0+6+6xigo1TbDELphyxh0nMZIp7FajzhFqOSl4Hu61QsV61FLPiHMn5/GErDrFdvWp9Sr/mtWO0o6erJPeHWupmVNy9OA5oY3QoOlh9qHnjUOk1SnOlNhvz7ofXG1ZnU5JCcnk+1Cko6mjU+kA9eDERuVPeTTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695891; c=relaxed/simple;
	bh=l9kEWQ6v0uKHQbPKrOfHcb2BJG0yL+jJvdldXgn5UCM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZOERgs9IuedvEmlDWg5awvkopAqE/969mupGooxWg5fYu9AZstxp4wOPFBqM7Q3CpQlGllY/kP+tbxW/+SoIFUi/nNuVIb43vL5qpOioD4f/BJjsnVgJJPbIQOmUkoSvZaWDpyMjwZj+EiMojKxBz3SzqVnCTh1uCjC7SmGIsvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0OFjkVj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3bea24519c0so437477f8f.1
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755695888; x=1756300688; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXRY5zIjQz/Q+usb8cEh0MKl7uyLaZ7jEVhQipoPSrY=;
        b=L0OFjkVj+9yScjDhpDZRpGmH0LHtRTSSWSEPcQffAqBr/jE+fzKcJC90xyQzWNZofs
         WzHAPX3uVN13VOALWc1ttiPocmkKlTy9xbk5B5gnIkIaXTNifU3i82lSieOqJzNCKZk7
         mvGzx4YgmuUldfnl+Y+n0/tDnNxBiykmJDQzn5npo+gWG02fZJokR0mzkTycuciKlDsq
         W/cGtdBso2NUADMVZBykNn7ee+lsbSix5KrrTt2P9nae2pbAKsWW4zrnYnMsIumV9zq9
         4fSYAfV5CpFGCL8sGgJXuG0hn1ezTJcyA1o16Rc5KB1JpQmbDACOzFYIsZWk2EjRo0XO
         gCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755695888; x=1756300688;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXRY5zIjQz/Q+usb8cEh0MKl7uyLaZ7jEVhQipoPSrY=;
        b=Xh2NX1tnzhFRt/61HhiUtFuuO50seEuW1xhwCxDmyNDErqd8m8PJdrFeFKiEK6iwSO
         SllXeu2E8w+ctSPc6+6x3b3H4M5jYb7RheTJbdmDDBYXVEigvfz725cZpQGLK4GZlU2n
         Vxly85BMi3WqszyIeqp5NnIdL5oNSTTe2UJr4weB8YT5X9XjSXQA4pmZ4yy804srGwPr
         46qnhcNSIDFWh9iKtpkWlntFOdvRHaSuuk88jeEnpqezUaKtmCXnPHhmLZVZlCMXkpcF
         AqODWDl/PBqcPLxCrV8mnat6/9+jNbRPypaoJBM83/0P+dLGpyXbX8mtz+LVv23PIXYq
         Ty8Q==
X-Gm-Message-State: AOJu0YxUbsJXrFaq+zLdBMDBoXIjyqBHQk2kxSObMjwTLjeTgPl0IREU
	ds5ArzKu2qMZFo9gQf2qNrfMjnH5HQ7pbVOA659FOkQQQ06xzOetsNJ/dsyfTuIYQYU=
X-Gm-Gg: ASbGncscFM4n3Uvp1SyQjWja82kJuxv+vN1DBv/DbXJAVd9UK4hdY/4mI0rtHzUzbqj
	Ur5+OtS8NzxJ4Po9f/OLQMxvRY+dgnHUnC9M6AONs9YmvTsAChhvbmVDKsW11x+lxF/DIyvhnMu
	/IQkgXIiQ54QU3wUJ4DGiEgwqCVZiCfyEem0Yt6F93dXKoO3/Q5E7k/LT+xttIkW7spNJCqyWLM
	PIi/qikwTIFm0rR88OTgXhPGNhaxCOM+igpVCttkyik1yssDkKme/0nxNJCekN97ZIM3Ct127ta
	AEK9lf+ShfTf3gaIMTFU1h+aN7dKxumtGDqHbwrHd/hI0ecu3LwP9svX25KPWtokawgjaLXbLKt
	9K8xFej0lrGoz0daRK+N03whOzvSuux1zwaKbWLzT/Ps0bvF0N/hb05qeIjR5mXvC+CUInCNFWX
	66Fcna/Mu0jjbZA2TwVaei
X-Google-Smtp-Source: AGHT+IFuBr3kGKhuDy2pl1myLxzsZJwHuGF6WEpHofbF/ZJKHcR2ARBRzxsB2zmUO9ZdUtExDRQjzw==
X-Received: by 2002:a05:6000:400c:b0:3bd:13d6:6c21 with SMTP id ffacd0b85a97d-3c12195b451mr4948667f8f.0.1755695888227;
        Wed, 20 Aug 2025 06:18:08 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e008d321cde1f4699b8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8d32:1cde:1f46:99b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c42627sm31346095e9.10.2025.08.20.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 06:18:07 -0700 (PDT)
Date: Wed, 20 Aug 2025 15:18:06 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Use tnums for JEQ/JNE is_branch_taken
 logic
Message-ID: <be3ee70b6e489c49881cb1646114b1d861b5c334.1755694147.git.paul.chaignon@gmail.com>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v2:
  - Renamed tnum function to tnum_overlap as suggested by Shung-Hsi.
  - Grouped tnum checks together in is_scalar_branch_taken, as
    suggested by Shung-Hsi.
  - Rebased.

 include/linux/tnum.h  | 3 +++
 kernel/bpf/tnum.c     | 8 ++++++++
 kernel/bpf/verifier.c | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index 57ed3035cc30..0ffb77ffe0e8 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -51,6 +51,9 @@ struct tnum tnum_xor(struct tnum a, struct tnum b);
 /* Multiply two tnums, return @a * @b */
 struct tnum tnum_mul(struct tnum a, struct tnum b);
 
+/* Return true if the known bits of both tnums have the same value */
+bool tnum_overlap(struct tnum a, struct tnum b);
+
 /* Return a tnum representing numbers satisfying both @a and @b */
 struct tnum tnum_intersect(struct tnum a, struct tnum b);
 
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index fa353c5d550f..d9328bbb3680 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -143,6 +143,14 @@ struct tnum tnum_mul(struct tnum a, struct tnum b)
 	return tnum_add(TNUM(acc_v, 0), acc_m);
 }
 
+bool tnum_overlap(struct tnum a, struct tnum b)
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
index 4e47992361ea..5c9dd16b2c56 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15897,6 +15897,8 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
 		 */
 		if (tnum_is_const(t1) && tnum_is_const(t2))
 			return t1.value == t2.value;
+		if (!tnum_overlap(t1, t2))
+			return 0;
 		/* non-overlapping ranges */
 		if (umin1 > umax2 || umax1 < umin2)
 			return 0;
@@ -15921,6 +15923,8 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
 		 */
 		if (tnum_is_const(t1) && tnum_is_const(t2))
 			return t1.value != t2.value;
+		if (!tnum_overlap(t1, t2))
+			return 1;
 		/* non-overlapping ranges */
 		if (umin1 > umax2 || umax1 < umin2)
 			return 1;
-- 
2.43.0


