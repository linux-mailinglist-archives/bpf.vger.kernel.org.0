Return-Path: <bpf+bounces-43066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499049AED0F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC5A1C22C27
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5221F9EA1;
	Thu, 24 Oct 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FARaMjJV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF31F80A3
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789431; cv=none; b=M5b/W3SDrIPOzsOEOljv/1XcTY74GCpDOaGkrjkz8qgTlX0oUNiKhaqOL0mHcpRRmrz378zh8EvIaJz/hYaEyU2m2JViJA9ZPfL372vG4dthytQku6DWD11/kGl6t43xMnCyVqahJSbmRmAheKqal1rknKng8IQ/vAoyZkUPxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789431; c=relaxed/simple;
	bh=2bb7NxIBS4Ou7GGxBctXjqwhBp5t9357KBJ7wocKABA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUO0UOR9Pmb8aL1ezAEQp5HUx9oFF6YrmdOuCbt3AE20fL5335qzibovAFPYH7MbEQCC6uCZ9WV+DTkiMew+sMOsco7R20cebb5UMF5VOx+I2FTmG7yJcPxH2s6fw4WLZz/UnrTBen6sS2pwY1lyxxF+LCtJDxDlaVlUfeemFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FARaMjJV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4fd00574so757386f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729789424; x=1730394224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG18duqnsv9kt696cjHVfSiR3eddOuFYOTWjF+KLC2I=;
        b=FARaMjJVr/5CJiHYnHipqHNYbHwUWy1Axq7l/3T8B7ZoAHmJes6kUJJolyk0V4/Oy0
         MOVYyTWwG+oTYsiogzMoOQ1qn8hwNY8St581oas28mVp4n2bOzs//bL/DwDHhgydtssh
         hO1Bm2Q32PJFxlPSQyjZ9jmLVoPM+dU1Mxz79p9kxkTnwWK9oelcG4oR/FyoycH+RNqJ
         dwnWGFPMjOdTRtmzhBu0ukufjsdex4uVxYoW1BUnuyftvvjufT9NkR9ZRgmZ3+zOzGb5
         l0agT8uJIypVHgILDEsoKxcdIXKNO3ZXpV6Y+0i1clrlE33MrZMBSeVhZm1Mj5DJtvmr
         /mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789424; x=1730394224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jG18duqnsv9kt696cjHVfSiR3eddOuFYOTWjF+KLC2I=;
        b=QZo+BE2WH8xiVpeqwAoTn3jZb7N8Y8EtO0Ye8wQIWWA2/SZjLNQqzQlxMvNA4LRG2I
         qF+iY6eTje8OnyeEzHcyX1BilRn91CLJFeCLP65mxws5u8fTk6v7wk1kf64hh4hMYCLq
         W314Mtxx8nSm83eN2k+lrVI5WV8iQov8PdzsLtXgjBm18TBIWY5TbNU02jHa4jiOAxE3
         oPx+EkCXM+Udr01RKF/1S8jwCnA1XrLT74nSu47V1SarIXalME5m32feWIY4hOO7V+NW
         xgb4zQiXDALHj293oAmoATECylBz7nRtfkfsE23YI3RCU1w7m7H7lm1nJ+rXdeMN345W
         Emtg==
X-Forwarded-Encrypted: i=1; AJvYcCWkR64KxcyHFxvo3vAi+yPO+VnDgJ9Y5Cmk/bQmLJcmf3oW3hUWxJNo82VDkHZWMo8KlQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSyggVYGcWWN9VLeU0d+iaXXvHqpKZ1bXFLTgmz+Uh/tVLFU1
	nuQBeD01+bkC0jhMFmWxLdprJshX3CguP+PwkQmNXn6h6LwAwtyxbzaA+0/zb0IP9zey75IUZOg
	ihGpC3ucEwg8kMuY3LPReWtP2o/Y=
X-Google-Smtp-Source: AGHT+IFKXHsuapCCvK743FwpacKf6+0WisXaDhBbPtgTRxuVmx9W3Fi/W2rt3K9xqlHsf7dgqr6rGutUl6QFDCiUCXE=
X-Received: by 2002:a5d:4535:0:b0:37e:d942:f4bf with SMTP id
 ffacd0b85a97d-3803abf2349mr2088142f8f.12.1729789423606; Thu, 24 Oct 2024
 10:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023210437.2266063-1-vadfed@meta.com> <CAADnVQ+YRj2_wWYkT20yo+5+G5B11d3NCZ8TBuCKJz+SJo37iw@mail.gmail.com>
 <4d7f00e6-8fab-4274-8121-620820b99f02@linux.dev>
In-Reply-To: <4d7f00e6-8fab-4274-8121-620820b99f02@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Oct 2024 10:03:31 -0700
Message-ID: <CAADnVQLoucSrjXQeCqk3zVmaqEk8T91-tieVccjMMCEOa9dPWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_get_hw_counter kfunc
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 6:11=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> > static inline u64 __arch_get_hw_counter(s32 clock_mode,
> >                                          const struct vdso_data *vd)
> > {
> >          if (likely(clock_mode =3D=3D VDSO_CLOCKMODE_TSC))
> >                  return (u64)rdtsc_ordered() & S64_MAX;
> >
> > - & is missing
>
> & S64_MAX is only needed to early detect possible wrap-around of
> timecounter in case of vDSO call for CLOCK_MONOTONIC_RAW/CLOCK_COARSE
> which adds namespace time offset. TSC is reset during CPU reset and will
> not overflow within 10 years according to "Intel 64 and IA-32
> Architecture Software Developer's Manual,Vol 3B", so it doesn't really
> matter if we mask the highest bit or not while accessing raw cycles
> counter.
>
> > - rdtsc vs rdtscp
>
> rdtscp provides additional 32 bit of "signature value" atomically with
> TSC value in ECX. This value is not really usable outside of domain
> which set it previously while initialization. The kernel stores encoded
> cpuid into IA32_TSC_AUX to provide it back to user-space application,
> but at the same time ignores its value during read. The combination of
> lfence and rdtsc will give us the same result (ordered read of TSC value
> independent on the core) without trashing ECX value.

That makes sense.

One more thing:

> __bpf_kfunc int bpf_get_hw_counter(void)

it should be returning u64

> >> +               insn->imm =3D 0;
> >> +               insn->code =3D BPF_JMP | BPF_CALL;
> >> +               insn->src_reg =3D BPF_PSEUDO_KFUNC_CALL;
> >> +               insn->dst_reg =3D 1; /* Implement enum for inlined fas=
t calls */
> >
> > Yes. Pls do it cleanly from the start.
> >
> > Why rewrite though?
> > Can JIT match the addr of bpf_get_hw_counter ?
> > And no need to rewrite call insn ?
>
> I was thinking about this way, just wasn't able to find easy examples of
> matching function addresses in jit. I'll try to make it but it may add
> some extra functions to the jit.

func =3D (u8 *) __bpf_call_base + imm32;
if (func =3D=3D &bpf_get_hw_counter)

