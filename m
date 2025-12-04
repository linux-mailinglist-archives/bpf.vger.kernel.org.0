Return-Path: <bpf+bounces-76030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C73CA2918
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 07:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E68773020699
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 06:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DEC30146A;
	Thu,  4 Dec 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fyncPvgY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38FA306B0C
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764831020; cv=none; b=ZNglZx6jWiCKGZ5kj8YTK49aVA6HlzCKNzCXtcZESEy0kxgkTO8GNJkSJd7L/VWUoeaOBI9ZiCpVt8CzBQpZpwIXWjY5OxsIb50kNB1sTSgPjKg3n2ATCA/E9ee6khmnPJk4c02afKvLvXdDIGAkjlX+zpsRQzGcP4mpR6HLe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764831020; c=relaxed/simple;
	bh=wyywuHGzWc4TxHOd+wN/I3C0iAmPRD4NZ2L4AEl/x0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc/PowDAMHpPKyE4TXHP/o1ZCGeaajQSXVTuT4eIv3egzrqKePRVFWjqEDS64iqra3C7UliLgeOD3MQQNU6MSzizE964REHBvd0khXSn7Ixi2++qsqFB3VPr5COwcDYCbbyzY+pUZl8Q6/2tTllYDNLY/K9Ssb3Gp0nNG2VCIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fyncPvgY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso5511575e9.3
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 22:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764831016; x=1765435816; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUU+JkiFIfgD+NCcLOexVb9Vwfjqim8x520BznV/LgU=;
        b=fyncPvgYOMt6/+/tAjlsAjrTYh1JvG6oXRoDgHLK8fCMIGf0wYx/bKly6ZUmzEfMLP
         UMEM54IyRdFA7ASQnoMce1Hcr7Rb+8x6Fxz+vs3dX+a6A5XhkWOpc5hTDn9yJmbMhWVd
         6WG1jcAJbpmD2KZdlw78eNcgxnw/XF783wMJfAWierHssGmmurx4JBTmzjUpWVkvyDK1
         GyPkKN0hlnC9SRhfiJZ0vspw+5bWbbDUGEFxTkZF3In8MB4A9kq379qaUrO0jdijde3U
         PT7BtDZqUNI69RBa/j+Tz5Us8wAgpuSh2sttcZUuj3AUVEXFqbRIasLxAlsIqvczHsBH
         AB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764831016; x=1765435816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUU+JkiFIfgD+NCcLOexVb9Vwfjqim8x520BznV/LgU=;
        b=xLLTJ/zQp1Gak2pZKp0TwgIkwQxkXZNzPWUMa76gQWeygmpvUbNeWnf5dNYTxhShEs
         3etODIW0QUYXHGX22wzqsrf9bfcfD074BRwbHecUBD8o9B2pu3Bvyb7R85YCQVQLN3Tv
         74iWHd2PY4PawmJhBA9Fheq4oOIUE5T7l5icSQH7uvQfxoJIgB0iYfQ9xezrKl1VIJoZ
         jsiMILHrIfgpDzih4I92h9t+HyX+aWDo5P+ocTGKkuOeGrHIhWV+FOsFoYkZ/N7Q0FGV
         albX1O0oUmIjhWZZyW1OTcEp73NQbA+gghtOsdHui1sSQjsDC0gAvxtIev90rDqoJtQG
         dgXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgpT6ASBb8r1uddftf1E+19eoXnqUBXnEWFQnCwF5tga8mn+TW9Q1iEz2+SIESg/JLhxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcGVyiU0uxdfLjLmHe3dAuM+v7+GCoHaXAzvEsozqzsCZO1f4+
	tR4LbOwguoElWBXcvfWGcXzmZ/CR6RT5dWxGMpRvNqucqwjEEEhS0/wY6hlvuLLzTBY=
X-Gm-Gg: ASbGncvrGw7nf2/bEjVk4ByrWMupfwaPo+GoYmDMfAbSuoo0qHA8cAZaIbdCsRDdRQW
	4cUexrURem56eGJkdyDSTTTto0zYOhZz5ejR1TIZ+0gzwLx9IBqjor4UDu+YN5HQxBbMtekSs+w
	jgK62oQapaLS0F58G8IAtIE5VFs3Em6XvqB5yIz5RvkjhsTvyqyYXaZtL1Buvkxvz9xVwgEYXSx
	c/Zo6fAewh8FNxUaowriCoSPhfcUc6FX14pVjlideXlrcWNV2mTL1A9kh6xBrQ3e0WywUw9e+m2
	VUJqDny/S39/frzimBEfw5Wx6673MctRv4yPp2AwBNCRUV2oSTeyMoBlFiOPqWTkhvQI62eIIfL
	M/u5RjSzKd30+blplENwDK8na8/NUWSplyoqwdwZp/BCYZU5ZXXFKXeOOa6ZrIa3542/JushSaA
	0JTHiOvw==
X-Google-Smtp-Source: AGHT+IEKI9cFeXL1koHldxyesVLpOuBPPh+Xavx+fFFxEQIxOE30PHrCd+RhU7/1vGrUKjbMkDCRWA==
X-Received: by 2002:a05:600c:548e:b0:477:7cac:508d with SMTP id 5b1f17b1804b1-4792af2fe86mr52227555e9.16.1764831015745;
        Wed, 03 Dec 2025 22:50:15 -0800 (PST)
Received: from u94a ([2401:e180:8d04:3649:27f5:41c3:7aa3:452])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f179sm8818335ad.64.2025.12.03.22.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 22:50:15 -0800 (PST)
Date: Thu, 4 Dec 2025 14:50:02 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH v1 2/3] bpf: verifier: Simplify register sign extension
 with tnum_scast
Message-ID: <ishiaqquy6mcuq3ykea2kt36enf6g35u5yrb4hr4zavskcvmd3@ljj3hnubd5bx>
References: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>
 <20251125125634.2671-3-dimitar.kanaliev@siteground.com>
 <cad6577291b778e6caad2f06fae304b2ec07f752.camel@gmail.com>
 <CAHx3w9JOXv-p_LeTiS9Z=C+wvPn-PAbm6u-i8a3jnSTTqJo3eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHx3w9JOXv-p_LeTiS9Z=C+wvPn-PAbm6u-i8a3jnSTTqJo3eg@mail.gmail.com>

On Tue, Dec 02, 2025 at 12:53:45PM +0200, Dimitar Kanaliev wrote:
> On Tue, Dec 2, 2025 at 1:50 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > On Tue, 2025-11-25 at 14:56 +0200, Dimitar Kanaliev wrote:
[...]
> > Assume that size == 1, s64_min = 0b000, s64_max == 0b100.
> > This corresponds to tnum with value == 0b000 and mask == 0b111.
> > Old algorithm computes more precise range in this situation.
> > Old:
> >
> >   0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
> >   1: (25) if r0 > 0x4 goto pc+2         ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))
> >   2: (7b) *(u64 *)(r10 -8) = r0         ; R0=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7)) ...
> >   3: (91) r0 = *(s8 *)(r10 -8)          ; R0=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7)) ...
> >   4: (b7) r0 = 0                        ; R0=0
> >   5: (95) exit
> >
> > New:
> >
> >   0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
> >   1: (25) if r0 > 0x4 goto pc+2         ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))
> >   2: (7b) *(u64 *)(r10 -8) = r0         ; R0=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7)) ...
> >   3: (91) r0 = *(s8 *)(r10 -8)          ; R0=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=7,var_off=(0x0; 0x7)) ...
> >   4: (b7) r0 = 0                        ; R0=0
> >   5: (95) exit
> >
> > Note that range for R0 at (3) is 0..4 for old algorithm and 0..7 for
> > new algorithm.
> >
> > Can we keep both algorithms by e.g. replacing set_sext64_default_val()
> > implementation with tnum_scast() adding tnum_scast() in
> > coerce_reg_to_size_sx()?
> >
[...]
> 
> So I endeed up drafting this:
> 
>   static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>   {
>     s64 smin_value, smax_value;
>     u64 num_bits = size * 8;
>     u64 top_smax_value, top_smin_value;
> 
>     reg->var_off = tnum_scast(reg->var_off, size);
> 
>     top_smax_value = ((u64)reg->smax_value >> num_bits) << num_bits;
>     top_smin_value = ((u64)reg->smin_value >> num_bits) << num_bits;
> 
>     if (top_smax_value == top_smin_value) {
>             if (size == 1) {
>                 smin_value = (s8)reg->smin_value;
>                 smax_value = (s8)reg->smax_value;
>             } else if (size == 2) {
>                 smin_value = (s16)reg->smin_value;
>                 smax_value = (s16)reg->smax_value;
>             } else {
>                 smin_value = (s32)reg->smin_value;
>                 smax_value = (s32)reg->smax_value;
>             }
>     } else {
>         smin_value = -(1LL << (num_bits - 1));
>         smax_value = (1LL << (num_bits - 1)) - 1;
>     }
> 
>     reg->smin_value = smin_value;
>     reg->smax_value = smax_value;
> 
>     reg->umin_value = 0;
>     reg->umax_value = U64_MAX;
> 
>     reg->s32_min_value = (s32)smin_value;
>     reg->s32_max_value = (s32)smax_value;
>     reg->u32_min_value = 0;
>     reg->u32_max_value = U32_MAX;
> 
>     __update_reg_bounds(reg);

I'm rather unsure about keeping the __update_reg_bounds() call here, not
that it is incorrect, just that it is too convinent to throw in and
would take a lot of head scratching on why its there in the future.

Digging in a bit it seems like it might be because in ALU64 case (e.g.
"R1 = (s8, s16 s32)R2"), because the bounds were not synced after
calling coerce_reg_to_size_sx(); unlike coerce_subreg_to_size_sx(),
which is followed by zext_32_to_64() and reg_bounds_sync().

Given we have var_off at hand maybe we can just get the unsigned ranges
from there?

    reg->umin_value = reg->var_off.value;
    reg->umax_value = reg->var_off.value | reg->var_off.mask;

    /* Should be the same as using tnum_subreg(reg->var_off) to get u32
     * ranges.
     */
    reg->u32_min_value = (u32)reg->umin_value;
    reg->u32_max_value = (u32)reg->umax_value;

> }
> 
> I'm trying to always perform tnum_scast in order to preserve bitwise
> info, but attempt to use the old numeric logic first. If the range fits
> into the target size, we preserve the existing numeric bounds. If not, we
> fall back to the type limits and let __update_reg_bounds reconstruct the
> range from var_off. The imeplementation is similar for the subreg variant.
> 
> Rerunning the comparison for the same range looks much better, we should be
> consistently seeing precision gains in the cases where the original
> implementation bails out via goto:
> 
>   [-1024, 1024]:
>   Old Better: 0
>   New Better: 131072
>   Equal: 1969153
> 
> I also went through the CI, the existing selftest in the series still
> covers the change.
> 
> wdyt?

