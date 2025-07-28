Return-Path: <bpf+bounces-64501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640D0B1386E
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 11:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B623A281D
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36CD21FF4C;
	Mon, 28 Jul 2025 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2bla5Rj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97919259C
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696326; cv=none; b=S+2zneqZ8diK4g/lcYnT5OHMYUXneQnHuS18HL+kLAd31pvr3RRuAlDwAMxfT/ihzUViYRGeQTISLMA5O6DB3pR7fffzxGwcd4W0YssezD3SZ/A8LM4QUd21A9oKEOJYslShAjlgbL1A2ujFAORNj8i0Xu0Njk+BF1iOQ7YRbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696326; c=relaxed/simple;
	bh=LLYXmWzJFBMSUSdKGBqCJQVJtS9R7xx8Ofn4YGmiAqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcJuM/GccPU0g0AcHdQrUo1e6+AvfJg9+k8nkTAhk54Eo7TFQWOMS0vU/0nBTBubIpmmyJ4ZrP/JIANJdntaypt9H7slE88XKnwyJAYfw4o4Z+MlNaFYeCZzChzD+Mv94FLH8ekaWc63D/rpbznClNR9ssZtGl4rF++QJwFEfjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2bla5Rj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b785a69454so703624f8f.2
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 02:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753696323; x=1754301123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=daa7JtGD4OlZwWvbu/G4ziVW8ebBDCjAmpZ7JGfIY44=;
        b=a2bla5RjOrkAepS2PrjZYAyM5iX/5jTbso63u7+qT36K0UM8Lijx80+MEaVN8mJwJZ
         szJXlUvE/7nqLlVtsOSDZEcNaq1h8To/k+oY1ywy06MZpVJjTK4Zh2rn+W5FO97fYZB3
         dCrPUMbUR+FwhvP28prCZlCXb+DWTkl8YNQpctleeuARZY9azU+0p770fm6K/tCHUre/
         gPffCeY7oJQTw7WM8tnzkT4NiM84l4MSyw4ZEIOBPUxWgX0sLS3F5uBo/W2x58h8veZp
         0T2b2KjQVdX/q5leE7Oqs3kzN6Y2gBoIk5TdSzBnddrGTPbf61WC6Ptpj90gxMU0StID
         2g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753696323; x=1754301123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daa7JtGD4OlZwWvbu/G4ziVW8ebBDCjAmpZ7JGfIY44=;
        b=MUv1bY3G7iN9ft4mTMqHORRZPfi2yW92VdKHNj0qHOeTV4UijGx8fPOOIaNK1QFElE
         2uQCAAoz0kIOnYdhCDb4AdSKQLllgS+6xKl0LIH3e+iXiX2AfaHar01//El2MP7UiwfV
         13l/ttN/71bJcaa3H/anEEldYeSfTo4K2XVPnkpnq1/hPIWFHpnOKhVbto57/Erh1du9
         rbvPFqVQ/i58CA+CSt4Wga5ev9bO3+zlyqWGZjjPEOyQjSC7fb97FRoEGMebfoMyU2ZU
         XzEUGnMlcNA8dNeIkQ9xvCZ4zoDbxarA3th0GOgXuiqrb1b9j1W+GsVbiRPsVEmPXtWr
         UOPg==
X-Gm-Message-State: AOJu0Yw2hLWIb0vLUaFRouH9YrTBWRLb1W1ZWGAp+XF0wBkOw/2Yu/m4
	Wcsq4eIu9ttuLa4AVUXICRtCgxUBe4yj/8duGO10NT1PsGU2CJ7uuJ3OwFm7ZslQ
X-Gm-Gg: ASbGncvkLGdibUxEXdfLgfGls9+NchdDif7+0ueLWTTb9sCEzffGdPM+Q8Fnlogi3un
	S9gqQf6ZEVA/q4r782A31YO1QKINo6VBZueoYICYkV+i/Sd+v6SWnNugzKGtdr+GPtlpkIVQzwB
	y7g8/N+rqDpUSnXX0b5Qd5szAm/hGqQQffFlgDWVn5GiwY8OviqjBSunH495a2+/oRNI/ZByPhE
	zVCd5lowK4fo+IdZ39SKmW/YhlDhTPnJa/A/0RU4dUYAUBIQ/G3imlDyaZEqJr5bmcH8FYv+z5V
	z2cdAzHEN3j7ZB3Fs12/JzRqi16tpWF2bZx7djacntoF0H8zaYfBMW47fp8dqV1CVyFKB6usM2L
	0MTLbCMDrCwnhlQWPrkSbSN+edp0z2xaMuUpQ/XWKePrYdHa28EUx22/l+ffjqqJvvdYql0em0i
	TQzbTYoHRJIi2Dt2SHde0=
X-Google-Smtp-Source: AGHT+IF2AzE/fTMG1skEl15mPX6/RN4s3oY0Rk1SwAhItMEe7vKFD5GCXZJ3g391UTMGOyO8geAwAA==
X-Received: by 2002:a5d:5885:0:b0:3b6:d6c:a740 with SMTP id ffacd0b85a97d-3b776680be3mr7689730f8f.54.1753696322659;
        Mon, 28 Jul 2025 02:52:02 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00616c0b53953fa0e3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:616c:b53:953f:a0e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f0c866sm8127852f8f.55.2025.07.28.02.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:52:02 -0700 (PDT)
Date: Mon, 28 Jul 2025 11:52:00 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v4 5/5] bpf: Add third round of bounds deduction
Message-ID: <79619d3b42e5525e0e174ed534b75879a5ba15de.1753695655.git.paul.chaignon@gmail.com>
References: <cover.1753695655.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753695655.git.paul.chaignon@gmail.com>

Commit d7f008738171 ("bpf: try harder to deduce register bounds from
different numeric domains") added a second call to __reg_deduce_bounds
in reg_bounds_sync because a single call wasn't enough to converge to a
fixed point in terms of register bounds.

With patch "bpf: Improve bounds when s64 crosses sign boundary" from
this series, Eduard noticed that calling __reg_deduce_bounds twice isn't
enough anymore to converge. The first selftest added in "selftests/bpf:
Test cross-sign 64bits range refinement" highlights the need for a third
call to __reg_deduce_bounds. After instruction 7, reg_bounds_sync
performs the following bounds deduction:

  reg_bounds_sync entry:          scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146)
  __update_reg_bounds:            scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146)
  __reg_deduce_bounds:
      __reg32_deduce_bounds:      scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146,umin32=0xfffffcf1,umax32=0xffffff6e)
      __reg64_deduce_bounds:      scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146,umin32=0xfffffcf1,umax32=0xffffff6e)
      __reg_deduce_mixed_bounds:  scalar(smin=-655,smax=0xeffffeee,umin=umin32=0xfffffcf1,umax=0xffffffffffffff6e,smin32=-783,smax32=-146,umax32=0xffffff6e)
  __reg_deduce_bounds:
      __reg32_deduce_bounds:      scalar(smin=-655,smax=0xeffffeee,umin=umin32=0xfffffcf1,umax=0xffffffffffffff6e,smin32=-783,smax32=-146,umax32=0xffffff6e)
      __reg64_deduce_bounds:      scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e)
      __reg_deduce_mixed_bounds:  scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e)
  __reg_bound_offset:             scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))
  __update_reg_bounds:            scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))

In particular, notice how:
1. In the first call to __reg_deduce_bounds, __reg32_deduce_bounds
   learns new u32 bounds.
2. __reg64_deduce_bounds is unable to improve bounds at this point.
3. __reg_deduce_mixed_bounds derives new u64 bounds from the u32 bounds.
4. In the second call to __reg_deduce_bounds, __reg64_deduce_bounds
   improves the smax and umin bounds thanks to patch "bpf: Improve
   bounds when s64 crosses sign boundary" from this series.
5. Subsequent functions are unable to improve the ranges further (only
   tnums). Yet, a better smin32 bound could be learned from the smin
   bound.

__reg32_deduce_bounds is able to improve smin32 from smin, but for that
we need a third call to __reg_deduce_bounds.

As discussed in [1], there may be a better way to organize the deduction
rules to learn the same information with less calls to the same
functions. Such an optimization requires further analysis and is
orthogonal to the present patchset.

Link: https://lore.kernel.org/bpf/aIKtSK9LjQXB8FLY@mail.gmail.com/ [1]
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c                               | 1 +
 tools/testing/selftests/bpf/progs/verifier_bounds.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 251e06dc07eb..72e3f2b03349 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2672,6 +2672,7 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	/* We might have learned something about the sign bit. */
 	__reg_deduce_bounds(reg);
 	__reg_deduce_bounds(reg);
+	__reg_deduce_bounds(reg);
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(reg);
 	/* Intersecting with the old var_off might have improved our bounds
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 34b3f259b7a4..87a2c60d86e6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1573,7 +1573,7 @@ l0_%=:	r0 = 0;				\
 SEC("socket")
 __description("bounds deduction cross sign boundary, negative overlap")
 __success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
-__msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
+__msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=smin32=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,umin32=0xfffffd71,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
 __retval(0)
 __naked void bounds_deduct_negative_overlap(void)
 {
-- 
2.43.0


