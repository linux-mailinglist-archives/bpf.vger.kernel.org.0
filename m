Return-Path: <bpf+bounces-64332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC51B11ABF
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 11:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15A91CC6ABA
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855742D0C75;
	Fri, 25 Jul 2025 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q4aklL5e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2348285053
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435313; cv=none; b=Qf7BjtxVSXf3+iOQvwGNXRTRp/4BmKu2azDbx/K0U8w4X1oWEt91WZxCZxPz1oxH/jjSJlIblHOSWcrgfw7ai/KK/USfRJuvO8yI0Vr8fK6DuGoIcIYprhpwUYkjxfLkZiu82ZMXaar1G3R8nlX3IFAY4OD1ZkPjfvRWtyQrUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435313; c=relaxed/simple;
	bh=fHD0GDkTl2VPW8GotjbwI/iHR7726h2hQ9lvr/XGHCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edolvCQwtumoiUPdv33G+5a4NGB7rtORMvAwC9Eb/mQDZ4MqIPUcSyfFC3mxWBo16MR1qQea2IML4sv06isDR72fkshacLvOjEdQ8bnDeo+8rra76b25b9s8Q29chKgDtzuYqAyuqlJO0XiUH3wrCdAB1QaF/8rvpfVRHLAN4O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q4aklL5e; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3b77673fd78so282847f8f.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753435309; x=1754040109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Jns95K2CC9wrsrCmUf0a/beZ690kJlwnrWlOt/dNwE=;
        b=Q4aklL5eKO2ruB+XTn5/Q7jDA83DjJpodUT7oUtLat2svPDGTHvmBcqAV0YOsFMvZR
         3IWkihM3CalBlx3cPkIGrQR06grJXXuWsNl1LfOSY3jdnKchiQZmhJkHYvNoZdWBuxqK
         05HiGaj6v9iWEQ5gevQLInD1/y7BrVn4hfr36xVYQagjoiQkLCbACbhJ7URq21Kzh1C6
         l2xRH0U6/mXE9epsD+vg4usXSjbwD/7KYQlGfsVBA2SjC2nzU66EypNLm5Zemu+laDBW
         yFgku1fsI4Z6j2XnT+NrUsw8F/zVHbREofCEV1wRkbZ57ZDQKoRmJtuehmk/TTK6pgeg
         y/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753435309; x=1754040109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Jns95K2CC9wrsrCmUf0a/beZ690kJlwnrWlOt/dNwE=;
        b=H1zCOqyS70T7riDDccM/bZMN5sjsB2xrpSSYneXNaZJ1Ehm22qWvVZ4JGbLH+pWmdv
         jcnK41mQYN/zOrNdPPZ7WtbclQl4Y15E3FsiSnokauSg3Z4bMphSYAp+KAra5AFp9dfg
         olLntvLmlWM2bgsxifT+Cdlw97MOOm1gLjQw4kS77D+J4xb+uptpTW0AG4u5m7/tQK1L
         THXE4WkoTGkLPZNyWafAkP6VQrGU6uwvM82qsasTrwmcbXwSbzpMUflCAt1P48wiZl9y
         EhkGwm0DGs5etbxajZk5czHwPLy02jRLLTeHHGFzUwmwO6agOF8gkuJNsQFoaG1171BL
         DAEw==
X-Gm-Message-State: AOJu0YzsCV028yfSBcslI+5UmKTslpf/BjoAqMcLINz/2OQNPnmSrnGm
	Qwt2wLFiWJc/CJao96ttmE6eHb+FX5UoQUMM5kZS+qD8mY3uqPrie/HYif2tY9MeN1k=
X-Gm-Gg: ASbGnctIdZ6iEgNri7nX6R+pUjxKQITmy2YJrea0mTZLO/lYS29C7nUywFlTdg1NDIQ
	zYKQHeFYUj1ayOEfP+dHkdoeb97+TYZvalgWcz3uTZuFxamlKyUUzwAJ/LAgzX2KezrFKYAZhjM
	7rVjqr5ISZVNDnRfuNKUYwiwON9fWHcqJzqeJOWGf4Eo1bk0tEHCNHwdjD+aqVNRwz5vRPlmEK/
	cyEEuq2Al0chIqOvl/HAMFxt+hLjd9yguTjDAsvfznkA4NxISIZjjHefSBgov8rVKTA425lbnfN
	S9b2aj73/PXlwTtn8nI0YaWrMYn35f2mk7HIczyvi2gcDXhwY89LJex+Ho934Gog/QlAR2akq2V
	Btb1Seae41uDUxoARWGB8I1dzRojDCwFemP/o7flOGmMFcLSdHzu8xjrGkteWun+gKHTg5Eom4V
	TPY5p7JuTmyR3tW7s=
X-Google-Smtp-Source: AGHT+IGrhsMBBUSreh3QqHGNveTrC5nIQFDPjriVzudy6YLHQmHZSmhUrhTri0b49ys1ihH5beXiPw==
X-Received: by 2002:a05:6000:40de:b0:3a5:8a09:70b7 with SMTP id ffacd0b85a97d-3b77663e8b8mr1257784f8f.38.1753435308686;
        Fri, 25 Jul 2025 02:21:48 -0700 (PDT)
Received: from u94a (2001-b011-fa04-d953-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:d953:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b06199a8sm3435466b3a.112.2025.07.25.02.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 02:21:48 -0700 (PDT)
Date: Fri, 25 Jul 2025 17:21:38 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Simplify bounds refinement from s32
Message-ID: <nrsym2fuoeqoewmf7omq5dr2wtnq63bmivc2ndvkybi3xh4ger@7fenu3fa566i>
References: <aIJwnFnFyUjNsCNa@mail.gmail.com>
 <4da44707e926d2b2cb7e1d19572d006d7b7c06bd.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="awo2teqdyhaqjwfl"
Content-Disposition: inline
In-Reply-To: <4da44707e926d2b2cb7e1d19572d006d7b7c06bd.camel@gmail.com>


--awo2teqdyhaqjwfl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 24, 2025 at 02:49:47PM -0700, Eduard Zingerman wrote:
> On Thu, 2025-07-24 at 19:42 +0200, Paul Chaignon wrote:
> > During the bounds refinement, we improve the precision of various ranges
> > by looking at other ranges. Among others, we improve the following in
> > this order (other things happen between 1 and 2):
> > 
> >   1. Improve u32 from s32 in __reg32_deduce_bounds.
> >   2. Improve s/u64 from u32 in __reg_deduce_mixed_bounds.
> >   3. Improve s/u64 from s32 in __reg_deduce_mixed_bounds.
> > 
> > In particular, if the s32 range forms a valid u32 range, we will use it
> > to improve the u32 range in __reg32_deduce_bounds. In
> > __reg_deduce_mixed_bounds, under the same condition, we will use the s32
> > range to improve the s/u64 ranges.
> > 
> > If at (1) we were able to learn from s32 to improve u32, we'll then be
> > able to use that in (2) to improve s/u64. Hence, as (3) happens under
> > the same precondition as (1), it won't improve s/u64 ranges further than
> > (1)+(2) did. Thus, we can get rid of (3).
> > 
> > In addition to the extensive suite of selftests for bounds refinement,
> > this patch was also tested with the Agni formal verification tool [1].
> > 
> > Link: https://github.com/bpfverif/agni [1]
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> 
> So, the argument appears to be as follows:
> 
> Under precondition `(u32)reg->s32_min <= (u32)reg->s32_max`
> __reg32_deduce_bounds produces:
> 
>   reg->u32_min = max_t(u32, reg->s32_min, reg->u32_min);
>   reg->u32_max = min_t(u32, reg->s32_max, reg->u32_max);
> 
> And then first part of __reg_deduce_mixed_bounds assigns:
> 
>   a. reg->umin umax= (reg->umin & ~0xffffffffULL) | max_t(u32, reg->s32_min, reg->u32_min);
>   b. reg->umax umin= (reg->umax & ~0xffffffffULL) | min_t(u32, reg->s32_max, reg->u32_max);
> 
> And then second part of __reg_deduce_mixed_bounds assigns:
> 
>   c. reg->umin umax= (reg->umin & ~0xffffffffULL) | (u32)reg->s32_min;
>   d. reg->umax umin= (reg->umax & ~0xffffffffULL) | (u32)reg->s32_max;
> 
> But assignment (c) is a noop because:
> 
>    max_t(u32, reg->s32_min, reg->u32_min) >= (u32)reg->s32_min
> 
> Hence RHS(a) >= RHS(c) and umin= does nothing.
> 
> Also assignment (d) is a noop because:
> 
>   min_t(u32, reg->s32_max, reg->u32_max) <= (u32)reg->s32_max
> 
> Hence RHS(b) <= RHS(d) and umin= does nothing.
> 
> Plus the same reasoning for the part dealing with reg->s{min,max}_value:
> 
>   e. reg->smin_value smax= (reg->smin_value & ~0xffffffffULL) | max_t(u32, reg->s32_min_value, reg->u32_min_value);
>   f. reg->smax_value smin= (reg->smax_value & ~0xffffffffULL) | min_t(u32, reg->s32_max_value, reg->u32_max_value);
> 
>     vs
> 
>   g. reg->smin_value smax= (reg->smin_value & ~0xffffffffULL) | (u32)reg->s32_min_value;
>   h. reg->smax_value smin= (reg->smax_value & ~0xffffffffULL) | (u32)reg->s32_max_value;
> 
>     RHS(e) >= RHS(g) and RHS(f) <= RHS(h), hence smax=,smin= do nothing.
> 
> This appears to be correct.
> 
> Shung-Hsi, wdyt?

Agree with the reasoning above, it looks solid.

Beside going through the reasoning, I also played with CBMC a bit to
double check that as far as a single run of __reg_deduce_bounds() is
concerned (and that the register state matches certain handwavy
expectations), the change indeed still preserve the original behavior.

Reviewed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

Simplification of bound deduction logic! \o/


--awo2teqdyhaqjwfl
Content-Type: text/x-c; charset=us-ascii
Content-Disposition: inline

#include <stdint.h>
#include <limits.h>
#include <stdbool.h>
#include <assert.h>

// Define Linux kernel types
typedef uint64_t u64;
typedef int64_t s64;
typedef uint32_t u32;
typedef int32_t s32;
typedef uint8_t u8;
typedef int8_t s8;
typedef uint16_t u16;
typedef int16_t s16;

// Define limits
#define S8_MIN  INT8_MIN
#define S8_MAX  INT8_MAX
#define S16_MIN INT16_MIN
#define S16_MAX INT16_MAX
#define S32_MIN INT32_MIN
#define S32_MAX INT32_MAX
#define U32_MAX UINT32_MAX
#define S64_MIN INT64_MIN
#define S64_MAX INT64_MAX
#define U64_MAX UINT64_MAX

/* Crude approximation of min_t() and max_t() */
#define min_t(type, x, y) (((type) (x)) < ((type) (y)) ? ((type) (x)) : ((type) (y)))
#define max_t(type, x, y) (((type) (x)) > ((type) (y)) ? ((type) (x)) : ((type) (y)))

// Simplified version of bpf_reg_state with only field needed by
// coerce_reg_to_size_sx
struct bpf_reg_state {
	s64 smin_value;
	s64 smax_value;
	u64 umin_value;
	u64 umax_value;
	s32 s32_min_value;
	s32 s32_max_value;
	u32 u32_min_value;
	u32 u32_max_value;
};

static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
{
	if ((reg->umin_value >> 32) == (reg->umax_value >> 32)) {
		reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->umin_value);
		reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->umax_value);

		if ((s32)reg->umin_value <= (s32)reg->umax_value) {
			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
			reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->umax_value);
		}
	}
	if ((reg->smin_value >> 32) == (reg->smax_value >> 32)) {
		if ((u32)reg->smin_value <= (u32)reg->smax_value) {
			reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->smin_value);
			reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->smax_value);
		}
		if ((s32)reg->smin_value <= (s32)reg->smax_value) {
			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
			reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
		}
	}
	if ((u32)(reg->umin_value >> 32) + 1 == (u32)(reg->umax_value >> 32) &&
	    (s32)reg->umin_value < 0 && (s32)reg->umax_value >= 0) {
		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->umax_value);
	}
	if ((u32)(reg->smin_value >> 32) + 1 == (u32)(reg->smax_value >> 32) &&
	    (s32)reg->smin_value < 0 && (s32)reg->smax_value >= 0) {
		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
	}
	if ((s32)reg->u32_min_value <= (s32)reg->u32_max_value) {
		reg->s32_min_value = max_t(s32, reg->s32_min_value, reg->u32_min_value);
		reg->s32_max_value = min_t(s32, reg->s32_max_value, reg->u32_max_value);
	}
	if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
		reg->u32_min_value = max_t(u32, reg->s32_min_value, reg->u32_min_value);
		reg->u32_max_value = min_t(u32, reg->s32_max_value, reg->u32_max_value);
	}
}

static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
{
	if ((s64)reg->umin_value <= (s64)reg->umax_value) {
		reg->smin_value = max_t(s64, reg->smin_value, reg->umin_value);
		reg->smax_value = min_t(s64, reg->smax_value, reg->umax_value);
	}
	if ((u64)reg->smin_value <= (u64)reg->smax_value) {
		reg->umin_value = max_t(u64, reg->smin_value, reg->umin_value);
		reg->umax_value = min_t(u64, reg->smax_value, reg->umax_value);
	}
}

static void __reg_deduce_mixed_bounds_old(struct bpf_reg_state *reg)
{
	u64 new_umin, new_umax;
	s64 new_smin, new_smax;

	new_umin = (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
	new_umax = (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
	reg->umin_value = max_t(u64, reg->umin_value, new_umin);
	reg->umax_value = min_t(u64, reg->umax_value, new_umax);
	new_smin = (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
	new_smax = (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
	reg->smin_value = max_t(s64, reg->smin_value, new_smin);
	reg->smax_value = min_t(s64, reg->smax_value, new_smax);

	if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
		new_umin = (reg->umin_value & ~0xffffffffULL) | (u32)reg->s32_min_value;
		new_umax = (reg->umax_value & ~0xffffffffULL) | (u32)reg->s32_max_value;
		reg->umin_value = max_t(u64, reg->umin_value, new_umin);
		reg->umax_value = min_t(u64, reg->umax_value, new_umax);
		new_smin = (reg->smin_value & ~0xffffffffULL) | (u32)reg->s32_min_value;
		new_smax = (reg->smax_value & ~0xffffffffULL) | (u32)reg->s32_max_value;
		reg->smin_value = max_t(s64, reg->smin_value, new_smin);
		reg->smax_value = min_t(s64, reg->smax_value, new_smax);
	}
	if (reg->s32_min_value >= 0 && reg->smin_value >= S32_MIN && reg->smax_value <= S32_MAX) {
		reg->smin_value = reg->s32_min_value;
		reg->smax_value = reg->s32_max_value;
		reg->umin_value = reg->s32_min_value;
		reg->umax_value = reg->s32_max_value;
		/* var_off update with tnum_intersect() removed, was the last
		 * step, so shouldn't make a difference
		 */
	}
}

static void __reg_deduce_mixed_bounds_new(struct bpf_reg_state *reg)
{
	u64 new_umin, new_umax;
	s64 new_smin, new_smax;

	new_umin = (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
	new_umax = (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
	reg->umin_value = max_t(u64, reg->umin_value, new_umin);
	reg->umax_value = min_t(u64, reg->umax_value, new_umax);
	new_smin = (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
	new_smax = (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
	reg->smin_value = max_t(s64, reg->smin_value, new_smin);
	reg->smax_value = min_t(s64, reg->smax_value, new_smax);

	/* s32 -> u/s64 tightening removed */

	if (reg->s32_min_value >= 0 && reg->smin_value >= S32_MIN && reg->smax_value <= S32_MAX) {
		reg->smin_value = reg->s32_min_value;
		reg->smax_value = reg->s32_max_value;
		reg->umin_value = reg->s32_min_value;
		reg->umax_value = reg->s32_max_value;
		/* var_off update with tnum_intersect() removed, was the last
		 * step, so shouldn't make a difference
		 */
	}
}

static void __reg_deduce_bounds_old(struct bpf_reg_state *reg)
{
	__reg32_deduce_bounds(reg);
	__reg64_deduce_bounds(reg);
	__reg_deduce_mixed_bounds_old(reg);
}

static void __reg_deduce_bounds_new(struct bpf_reg_state *reg)
{
	__reg32_deduce_bounds(reg);
	__reg64_deduce_bounds(reg);
	__reg_deduce_mixed_bounds_new(reg);
}

/* helper function to initialize 'struct bpf_reg_state' */
static struct bpf_reg_state __bpf_reg_state_input(void)
{
	struct bpf_reg_state reg;
	reg.smin_value = nondet_long_long_input();
	reg.smax_value = nondet_long_long_input();
	reg.umin_value = nondet_unsigned_long_long_input();
	reg.umax_value = nondet_unsigned_long_long_input();
	reg.s32_min_value = nondet_int_input();
	reg.s32_max_value = nondet_int_input();
	reg.u32_min_value = nondet_unsigned_int_input();
	reg.u32_max_value = nondet_unsigned_int_input();
	return reg;
}

/* helper function to ensure 'struct bpf_reg_state' is in a proper state */
static bool valid_bpf_reg_state(struct bpf_reg_state *reg)
{
	bool ret = true;
	/* Ensure maximum >= minimum for all ranges */
	ret &= reg->umin_value <= reg->umax_value;
	ret &= reg->smin_value <= reg->smax_value;
	ret &= reg->u32_min_value <= reg->u32_max_value;
	ret &= reg->s32_min_value <= reg->s32_max_value;
	/* Ensure 64-bit bounds are consistent with 32-bit bounds */
	ret &= reg->umin_value <= (u64)reg->u32_max_value;
	ret &= reg->umax_value >= (u64)reg->u32_min_value;
	ret &= (s64)reg->smin_value <= (s64)reg->s32_max_value;
	ret &= (s64)reg->smax_value >= (s64)reg->s32_min_value;
	return ret;
}

/* helper function to check whether 'struct bpf_reg_state' contains certain value */
static bool val_in_reg(struct bpf_reg_state *reg, u64 val)
{
	bool ret = true;
	ret &= reg->umin_value <= val;
	ret &= val <= reg->umax_value;
	ret &= reg->smin_value <= (s64)val;
	ret &= (s64)val <= reg->smax_value;
	ret &= reg->u32_min_value <= (u32)val;
	ret &= (u32)val <= reg->u32_max_value;
	ret &= reg->s32_min_value <= (s32)val;
	ret &= (s32)val <= reg->s32_max_value;
	return ret;
}

void main(void)
{
	/* ------------ Assumptions and Setup ------------ */

	/* Input data structure that represents current knowledge of the possible
	 * values in a register, as well as some possible value 'x', which could be
	 * any value that is in the register right now.
	 */
	struct bpf_reg_state reg = __bpf_reg_state_input();
	u64 x = nondet_unsigned_long_long_input();
	__CPROVER_assume(valid_bpf_reg_state(&reg));
	__CPROVER_assume(val_in_reg(&reg, x));

	/* ------------- Operation to Check -------------- */
	/* Data structure to store the new output */
	struct bpf_reg_state new_reg;
	/* Clone the register state since __reg_deduce_bounds() modifies it */
	new_reg = reg;

	__reg_deduce_bounds_old(&reg);
	__reg_deduce_bounds_new(&new_reg);

	/* -------------- Property Checking -------------- */
	assert(new_reg == reg);
}

--awo2teqdyhaqjwfl--

