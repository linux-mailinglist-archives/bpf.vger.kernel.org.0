Return-Path: <bpf+bounces-42023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3699EA3C
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B72B2223A
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E41C07CD;
	Tue, 15 Oct 2024 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bH/PNQUG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60291C07CA
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996447; cv=none; b=ryz3+WHN/6KNkPWJ+LZzlzKJkrtYH/UwklCDXguthgwNqC13FNGcYj/PDqmduDwqdWp1CzmAKU6XRF56+bpjUCX9jtpMCJZjcRUvfYNO1cznXsJUoFagFE/E9+d3akMLS9UbaA5MFY+1YggTZ9MsQkqelcj9esguXGVi4qlEhuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996447; c=relaxed/simple;
	bh=jV6HNCeMQBCrWZVPu5Vn7GR2b5gSFEUza0fk8I+KIjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrV9LzHYcNUO6EPO0d7Ot2zksvo5Obc7baAjvAZrX95yFADP/bgbsh/MKtCpA/Tmj5QFVX6mMxD+daPYNT1zltIF3r8RzwjxM358q0xAfkT3baAnFvWNEbXAi0uuJGxeN2hB6hn7gMMzBgceA0lFWwhZU2LSZ67ZYxppQvXpa1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bH/PNQUG; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb599aac99so13478711fa.1
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 05:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728996442; x=1729601242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GQRii7/hgRP5fMG4wIWbKS+mKhWdQtFD2oc1nXe9sY=;
        b=bH/PNQUGAzCBMdikH29mGJ6Aa8sygieXvYBl1mv1uCleDYN3fi3K7ghVsMEx52NOxA
         /bu/ABdkANNU8jZmvPUMPIcnHAPKiyLNDPMYxOlcETdUQCx0EcN1OGpJRi4A3rarZjxW
         RMx+W/4JU/SOTgGQJUOVNNsY//yhONwQT6KoXFzknkon4qSaKAtmTelpFvjltj49mpuI
         0oRPWoWAar9WUcXnXe4iPHtb3HloB7GsICM9jkfXmHe+80RBaZLeuUjtHQK7kpcTEYaI
         hbcL4eBKgfIST/H6VDWWm2KettpNr1n2c8CEdeVK/rN59a7cpXhJhXlY4IcOAJBXV81F
         js0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996442; x=1729601242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GQRii7/hgRP5fMG4wIWbKS+mKhWdQtFD2oc1nXe9sY=;
        b=QPeuL3lHU76hKMSgE0ZbhT82Y0kM+Hz+ffmimEiXqDnQB0W82AU/NB2ThTd5e0aGu5
         6PY2VWX+jw5q26B5xaTra9fqqYR7UetX7+M7lWkx1NYqXIz7JforRa5x9YOQjgGZfB8h
         0TV3vEcDb6wNgdpJL7f6TnSBggf6Dz9vOcuHI63OBilj0K9YMvgP0lyGm+t0HkqdF7Wo
         c5hKYbuVIslAZpg9Rhfz46kMkRZvmbPOx/S8ZMALDKRpSxirQRhfG5rdnbnGH4pvwhg3
         Y0c39SR5rLDccKRhup8npTAq4GxDeRCg+8+/cErShR1A6b1MhSXjvFNPykmYJxUNlMDP
         jlsg==
X-Gm-Message-State: AOJu0YwY7HuG9w1qu/72n0w9y1I98BhtpFf/di7F5lPFcQ2pSCsetjpO
	riqefpVgpFRTES/kd6Nw1+n6/y3CKeb6GdGNcWToNGDT3oV+iwQVa7/gG/aGaxo0lJAWKYSalG2
	HLYk=
X-Google-Smtp-Source: AGHT+IGJX5xRnXpOThYNzXzPAV+3287XVVkPfXD+R8AsdR28Ntpn7jdCGuV8Xh+3df0LuS91ANbEUg==
X-Received: by 2002:a2e:4609:0:b0:2f7:64b9:ff90 with SMTP id 38308e7fff4ca-2fb3f16fad9mr38585791fa.9.1728996442196;
        Tue, 15 Oct 2024 05:47:22 -0700 (PDT)
Received: from u94a (61-227-64-56.dynamic-ip.hinet.net. [61.227.64.56])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83a8b28be7fsm28438039f.11.2024.10.15.05.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:47:20 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:47:12 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Zac Ecob <zacecob@protonmail.com>
Subject: Re: [PATCH v2 1/3] bpf: Fix truncation bug in coerce_reg_to_size_sx()
Message-ID: <p2jblxfrextdynozuutpp722ipjklpidycpo43jwowfhuj2c3y@skfw5ttjrpp4>
References: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
 <20241014121155.92887-2-dimitar.kanaliev@siteground.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ejxwytbovvp7o3ny"
Content-Disposition: inline
In-Reply-To: <20241014121155.92887-2-dimitar.kanaliev@siteground.com>


--ejxwytbovvp7o3ny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 14, 2024 at 03:11:53PM GMT, Dimitar Kanaliev wrote:
> coerce_reg_to_size_sx() updates the register state after a sign-extension
> operation. However, there's a bug in the assignment order of the unsigned
> min/max values, leading to incorrect truncation:
> 
>   0: (85) call bpf_get_prandom_u32#7    ; R0_w=scalar()
>   1: (57) r0 &= 1                       ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>   2: (07) r0 += 254                     ; R0_w=scalar(smin=umin=smin32=umin32=254,smax=umax=smax32=umax32=255,var_off=(0xfe; 0x1))
>   3: (bf) r0 = (s8)r0                   ; R0_w=scalar(smin=smin32=-2,smax=smax32=-1,umin=umin32=0xfffffffe,umax=0xffffffff,var_off=(0xfffffffffffffffe; 0x1))
> 
> In the current implementation, the unsigned 32-bit min/max values
> (u32_min_value and u32_max_value) are assigned directly from the 64-bit
> signed min/max values (s64_min and s64_max):
> 
>   reg->umin_value = reg->u32_min_value = s64_min;
>   reg->umax_value = reg->u32_max_value = s64_max;
> 
> Due to the chain assigmnent, this is equivalent to:
> 
>   reg->u32_min_value = s64_min;  // Unintended truncation
>   reg->umin_value = reg->u32_min_value;
>   reg->u32_max_value = s64_max;  // Unintended truncation
>   reg->umax_value = reg->u32_max_value;
> 
> Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Reported-by: Zac Ecob <zacecob@protonmail.com>

FWIW sharing the CMBC checking .c file that found this bug 2 weeks back
(though Zac already discovered and debugged this back in July, which I
realized quite late). The command I used is simply

	cbmc --trace $ATTACHED_C_FILE

Which rougly reporting that the assertation in following piece of
(pseudo) code is failing:

	u64 x; /* assume reg.umin <= x <= reg.umax initially */
	struct bpf_reg_state reg, new_reg;
	u64 new_x;
	
	coerce_reg_to_size_sx(&new_reg, size);
	assert(new_reg.umin_value <= new_x);
	assert(new_x <= new_reg.umax_value);

It then takes some effort to dig through the CBMC traces backwards to
find the relevant parts. First finding where umin and umax was set to
locate the problematic code (CBMC points to line 140 and 141 in the
attached file):

	State 178 file tmp/coerce_reg_to_size_sx-verify.c function coerce_reg_to_size_sx line 140 thread 0
	----------------------------------------------------
	new_reg.umin_value=4294967294ul (00000000 00000000 00000000 00000000 11111111 11111111 11111111 11111110)
	...
	State 182 file tmp/coerce_reg_to_size_sx-verify.c function coerce_reg_to_size_sx line 141 thread 0
	----------------------------------------------------
	new_reg.umax_value=4294967295ul (00000000 00000000 00000000 00000000 11111111 11111111 11111111 11111111)

Then get the used inital input by looking further back (note: I
explicitly asked CBMC to find a case where coerce_reg_to_size_sx()
doesn't work where var_off.mask==1 to make things simpler):

	State 30 file tmp/coerce_reg_to_size_sx-verify.c function verify_coerce_reg_to_size_sx line 162 thread 0
	----------------------------------------------------
	reg.var_off.value=254ul (00000000 00000000 00000000 00000000 00000000 00000000 00000000 11111110)
	
	State 36 file tmp/coerce_reg_to_size_sx-verify.c function verify_coerce_reg_to_size_sx line 163 thread 0
	----------------------------------------------------
	reg.var_off.mask=1ul (00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001)
	
	State 42 file tmp/coerce_reg_to_size_sx-verify.c function verify_coerce_reg_to_size_sx line 164 thread 0
	----------------------------------------------------
	reg.smin_value=254l (00000000 00000000 00000000 00000000 00000000 00000000 00000000 11111110)
	
	State 48 file tmp/coerce_reg_to_size_sx-verify.c function verify_coerce_reg_to_size_sx line 165 thread 0
	----------------------------------------------------
	reg.smax_value=255l (00000000 00000000 00000000 00000000 00000000 00000000 00000000 11111111)
	
	State 54 file tmp/coerce_reg_to_size_sx-verify.c function verify_coerce_reg_to_size_sx line 166 thread 0
	----------------------------------------------------
	reg.umin_value=254ul (00000000 00000000 00000000 00000000 00000000 00000000 00000000 11111110)
	
	State 60 file tmp/coerce_reg_to_size_sx-verify.c function verify_coerce_reg_to_size_sx line 167 thread 0
	----------------------------------------------------
	reg.umax_value=255ul (00000000 00000000 00000000 00000000 00000000 00000000 00000000 11111111)
	...

Which summarizes down to the input bpf_reg_state being

	struct bpf_reg_state reg = {
		.var_off = { mask=0x1, value=0xfe },
		.smin_value = 254,
		.smax_value = 255,
		.umin_value = 254,
		.umax_value = 255,
		/* 32-bit ranges aren't used as input and I couldn't get them
		 * generate right, so omitted here.
		 */
		...		 
	}

And from there things were largely straightforward to debug.

[snip]

--ejxwytbovvp7o3ny
Content-Type: text/plain; charset=us-ascii
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

struct tnum {
	u64 value;
	u64 mask;
};

// Simplified version of bpf_reg_state with only field needed by
// coerce_reg_to_size_sx
struct bpf_reg_state {
	struct tnum var_off;
	s64 smin_value;
	s64 smax_value;
	u64 umin_value;
	u64 umax_value;
	s32 s32_min_value;
	s32 s32_max_value;
	u32 u32_min_value;
	u32 u32_max_value;
};

// Global variable for unknown tnum
const struct tnum tnum_unknown = {.value = 0, .mask = U64_MAX};

// Helper functions
bool tnum_is_const(struct tnum t) {
	return t.mask == 0;
}

struct tnum tnum_range(u64 min, u64 max) {
	struct tnum t;
	u64 chi = min ^ max;
	u64 bits = 64 - __builtin_clzll(chi);
	u64 mask = (1ULL << bits) - 1;

	if (bits > 63)
		return tnum_unknown;

	t.value = min & ~mask;
	t.mask = mask;
	return t;
}
bool tnum_contains(struct tnum t, u64 v) {
	return (v & ~t.mask) == t.value;
}

static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
{
	if (size == 1) {
		reg->smin_value = reg->s32_min_value = S8_MIN;
		reg->smax_value = reg->s32_max_value = S8_MAX;
	} else if (size == 2) {
		reg->smin_value = reg->s32_min_value = S16_MIN;
		reg->smax_value = reg->s32_max_value = S16_MAX;
	} else {
		/* size == 4 */
		reg->smin_value = reg->s32_min_value = S32_MIN;
		reg->smax_value = reg->s32_max_value = S32_MAX;
	}
	reg->umin_value = reg->u32_min_value = 0;
	reg->umax_value = U64_MAX;
	reg->u32_max_value = U32_MAX;
	reg->var_off = tnum_unknown;
}

static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
{
	s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
	u64 top_smax_value, top_smin_value;
	u64 num_bits = size * 8;

	if (tnum_is_const(reg->var_off)) {
		u64_cval = reg->var_off.value;
		if (size == 1)
			reg->var_off = tnum_range((s8)u64_cval, (s8)u64_cval);
		else if (size == 2)
			reg->var_off = tnum_range((s16)u64_cval, (s16)u64_cval);
		else
			/* size == 4 */
			reg->var_off = tnum_range((s32)u64_cval, (s32)u64_cval);

		u64_cval = reg->var_off.value;
		reg->smax_value = reg->smin_value = u64_cval;
		reg->umax_value = reg->umin_value = u64_cval;
		reg->s32_max_value = reg->s32_min_value = u64_cval;
		reg->u32_max_value = reg->u32_min_value = u64_cval;
		return;
	}

	top_smax_value = ((u64)reg->smax_value >> num_bits) << num_bits;
	top_smin_value = ((u64)reg->smin_value >> num_bits) << num_bits;

	if (top_smax_value != top_smin_value)
		goto out;

	/* find the s64_min and s64_min after sign extension */
	if (size == 1) {
		init_s64_max = (s8)reg->smax_value;
		init_s64_min = (s8)reg->smin_value;
	} else if (size == 2) {
		init_s64_max = (s16)reg->smax_value;
		init_s64_min = (s16)reg->smin_value;
	} else {
		init_s64_max = (s32)reg->smax_value;
		init_s64_min = (s32)reg->smin_value;
	}

	s64_max = (init_s64_max > init_s64_min) ? init_s64_max : init_s64_min;
	s64_min = (init_s64_max < init_s64_min) ? init_s64_max : init_s64_min;

	/* both of s64_max/s64_min positive or negative */
	if ((s64_max >= 0) == (s64_min >= 0)) {
		reg->smin_value = reg->s32_min_value = s64_min;
		reg->smax_value = reg->s32_max_value = s64_max;
		reg->umin_value = reg->u32_min_value = s64_min;
		reg->umax_value = reg->u32_max_value = s64_max;
		reg->var_off = tnum_range(s64_min, s64_max);
		return;
	}

out:
	set_sext64_default_val(reg, size);
}

void verify_coerce_reg_to_size_sx()
{
	struct bpf_reg_state reg, new_reg;
	u64 x, new_x;
	int size;

	// Assume valid argument given to coerce_reg_to_size_sx()
	size = __CPROVER_int_input();
	__CPROVER_assume(size == 1 || size == 2 || size == 4);

	// Use CBMC's built-in nondeterministic functions to generate
	// struct bpf_reg_state that we're using as input
	reg.var_off.value = __CPROVER_unsigned_long_long_input();
	reg.var_off.mask = __CPROVER_unsigned_long_long_input();
	reg.smin_value = __CPROVER_long_long_input();
	reg.smax_value = __CPROVER_long_long_input();
	reg.umin_value = __CPROVER_unsigned_long_long_input();
	reg.umax_value = __CPROVER_unsigned_long_long_input();
	reg.s32_min_value = __CPROVER_int_input();
	reg.s32_max_value = __CPROVER_int_input();
	reg.u32_min_value = __CPROVER_unsigned_int_input();
	reg.u32_max_value = __CPROVER_unsigned_int_input();

	// Below are some assumption about how bounds in bpf_reg_state relates
	// for a reasonable and conherent bound in bpf_reg_state, however I
	// don't have any prove that this is a valid description of how bounds
	// in bpf_reg_state related, anyhow:

	// Assumptions about var_off and min/max values
	__CPROVER_assume(reg.var_off.value <= reg.umin_value);
	__CPROVER_assume(reg.var_off.value | reg.var_off.mask >= reg.umax_value);
	// Ensure umin_value <= umax_value
	__CPROVER_assume(reg.umin_value <= reg.umax_value);
	// Ensure smin_value <= smax_value
	__CPROVER_assume(reg.smin_value <= reg.smax_value);
	// Ensure u32_min_value <= u32_max_value
	__CPROVER_assume(reg.u32_min_value <= reg.u32_max_value);
	// Ensure s32_min_value <= s32_max_value
	__CPROVER_assume(reg.s32_min_value <= reg.s32_max_value);
	// Ensure 64-bit bounds are consistent with 32-bit bounds
	__CPROVER_assume(reg.umin_value <= (u64)reg.u32_max_value);
	__CPROVER_assume(reg.umax_value >= (u64)reg.u32_min_value);
	__CPROVER_assume((s64)reg.smin_value <= (s64)reg.s32_max_value);
	__CPROVER_assume((s64)reg.smax_value >= (s64)reg.s32_min_value);
	// Bound-crossing situations
	if (reg.var_off.value <= (u64)S64_MAX && (u64)S64_MIN <= (reg.var_off.value | reg.var_off.mask)) {
		__CPROVER_assume(reg.smin_value == S64_MIN && reg.smax_value == S64_MAX);
	} else if (reg.smin_value < 0 && reg.smax_value >= 0) {
		__CPROVER_assume(reg.var_off.value == 0 && reg.var_off.mask == U64_MAX);
		__CPROVER_assume(reg.umin_value == 0 && reg.umax_value == U64_MAX);
	} else {
		__CPROVER_assume(reg.umin_value == (u64)reg.smin_value && reg.umax_value == (u64)reg.smax_value);
	}
	// Probably need more relation between 32-bit range bounds...


	// Assuming we have some x
	x = __CPROVER_unsigned_long_long_input();
	// Mimick the sign-extension ourself
	new_x = (s64)((s64)x << (64 - size*8)) >> (64 - size*8);
	// Now say x could be ANY value that's bpf_reg_state represents
	__CPROVER_assume((reg.var_off.value & reg.var_off.mask) == 0); // tnum wellformedness
	__CPROVER_assume(tnum_contains(reg.var_off, x));
	__CPROVER_assume(reg.umin_value <= x && x <= reg.umax_value);
	__CPROVER_assume((s64)reg.smin_value <= (s64)x && (s64)x <= (s64)reg.smax_value);
	__CPROVER_assume((u32)reg.u32_min_value <= (u32)x && (u32)x <= (u32)reg.u32_max_value);
	__CPROVER_assume((s32)reg.s32_min_value <= (s32)x && (s32)x <= (s32)reg.s32_max_value);

	/* Since we know this will fail, we can have some additional contraints
	 * to "shrink" the input to something easier to consume for our human
	 * mind.
	 */
	__CPROVER_assume(x == 255);
	__CPROVER_assume(size == 1);
	__CPROVER_assume(reg.var_off.mask == 1);
	__CPROVER_assume(reg.umax_value - reg.umin_value == 1);
	__CPROVER_assume(reg.smax_value - reg.smin_value == 1);

	// Runs coerce_reg_to_size_sx()
	new_reg = reg;
	coerce_reg_to_size_sx(&new_reg, size);

	// Now ask CBMC to check that the sign-extended value of x is still
	// represented by bpf_reg_state after coerce_reg_to_size_sx()
	assert(new_reg.umin_value <= new_x && new_x <= new_reg.umax_value);
	assert(tnum_contains(new_reg.var_off, new_x));
	assert((s64)new_reg.smin_value <= (s64)new_x && (s64)new_x <= (s64)new_reg.smax_value);
	assert((u32)new_reg.u32_min_value <= (u32)new_x && (u32)new_x <= (u32)new_reg.u32_max_value);
	assert((s32)new_reg.s32_min_value <= (s32)new_x && (s32)new_x <= (s32)new_reg.s32_max_value);
}

int main()
{
	verify_coerce_reg_to_size_sx();
	return 0;
}

--ejxwytbovvp7o3ny--

