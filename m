Return-Path: <bpf+bounces-66601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D7B374D2
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 00:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227DE7C8553
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 22:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F9A23D2BF;
	Tue, 26 Aug 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8VyVtJq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545D21EDA0B
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756246698; cv=none; b=VLD5IFDoEnNHkkhP/90tURZMhhuXkQ4d16XxerY5TXXUJkwRLsIaz2I3gWANh3aJKVzLklJ6T9RDJ1V1LgI5ywADavzkEABrMdhmM20biarO5Yfw+f4yjBtfZxolMNGv8ey0fw8PeBSvzK3i7pa9drvorRoDmynDMQ2+pywyRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756246698; c=relaxed/simple;
	bh=HajCK9rq2UsPyOmvD6Bk+8IHWTHmOkXRRX1rEQVglvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If1MaokyJUKCOEWecYSKXG0gEAtjCvXtMb5gzcHkSPl02hq77MedDMxdRiXgq+YNIOha1XrRCSD0KDINwyDl2DZvsqB/TwE8UHaiiuvPZ6Uzd8pNulFmXVomp7hJ/1LImIfGuLn4R5yeOqxYqtwR0RVYWApNdNMELRmnMoCFeFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8VyVtJq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3cc95b0cc21so83267f8f.0
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 15:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756246694; x=1756851494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPXPAncY9llhWccSMUMKLVcgc/GIx1o1QinPMNVDeBc=;
        b=C8VyVtJq9f6Z18ZaWxoZMsI6D/lErUUvH/GaTqEUUgt0wcwUH2dn74k7XNff7YeFEi
         VZESnd1UxWQRrzIBfnKXlSHWXkz8/jxvt+/Loy3Owz3f8yCcO1bBWTmFOdq041SUB6Kx
         xT9S+umiI5q+EknxMa8KWOK6zfHsqCJ2TOuUdzWoH+ScaSyok2QeK84O7sYmOhPLxxJC
         R3tRuL8aC0+8E2j+qqqxehscfRBmjV3lZdcQPOeOLVK7U+0/GnV8fYtgDtwb2+N7zFcW
         NYxVVI0U7eK393BGjveRYs53UNKdGGUG58K1/+pQPD4f44azHyE+nLainXnj2saLNQvv
         EfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756246694; x=1756851494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPXPAncY9llhWccSMUMKLVcgc/GIx1o1QinPMNVDeBc=;
        b=Vk+e1OcJp2WtXQ9ayDN92DUgiHu8LWzA06tneUf19EV8+5TGkKjjlBgp7Ep/F5/MUl
         CBj1LZ6CJpAFVY5T2jEOYjH5jc6DRNWoT9qa8CY+ZztUAhzykFpFvWKQ0s/7b3cqgosg
         TDtWLVTUmSPKvEeCPhXjGDPNhuohy+GYmjQ689UAjOZ31AdQqDXmIcXDlYriwpdgniGD
         uB/D1mfHg6xTZbKrGzMpZr66Tif31/F2KBIL92PS1In5TlCWodARXxisgLObAaOXRMOO
         B0KiDRcxqWi0cvyFEngbVrsSXp07ujRbLaT+LDrTAy38ssrUpTt5u2iGAJRfwQNYf+0z
         j0SQ==
X-Gm-Message-State: AOJu0Ywpx1mTrB3jQBYDvE57zsJMXlJRYr+JF6FN//igRl5DaBMHbB4j
	5yUuSq6RwdX8A5/HsKzj/qHi1l+Uk77qx+a3ARpE1fAOvZR45F5cwlSCf7aPKgNu1FXhEeSLuG1
	usrMvs4+vAMpyfsT8jaL/8L4CdOHdEDQ=
X-Gm-Gg: ASbGnct8PX6UtDx+k01w5EoEpcHE8gpjYCMl9UegqD4iwdMN9Z8RhQplZdUpTL9AnEx
	mXaijv7eFoF5Uwlnjk7mpdKrxfv+Givv17rXJ/aeLMs6HoETwujoxIek6wwMr5fmIhhX8kLTtW/
	xxsKszRy8/suC9K9mMKVDejuhDgwIN+Rf2FOL1iVJ6ll4QM2aXmbZV4TTIDomFdsDyolfK0dS/W
	t7/LNleDjjAgb+9hQhKN/LVpYk/TMg5JtNTrQLHW0eyyGQ=
X-Google-Smtp-Source: AGHT+IH+tei4P7734cqANm+2NbFTbMWhjwyElY0TVFDFsYkscEOxiOIxednD+ESHixp6t4pFqM/MI44yHnpJyD00Skg=
X-Received: by 2002:a05:6000:3102:b0:3c9:b8b7:ea40 with SMTP id
 ffacd0b85a97d-3c9b8b7ecf2mr6833516f8f.38.1756246694283; Tue, 26 Aug 2025
 15:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825131502.54269-1-leon.hwang@linux.dev> <20250825131502.54269-2-leon.hwang@linux.dev>
 <CAADnVQLdmjApwAbrGca2VLQ-SK-3EdQTyd0prEy0BQGrW4Fr6A@mail.gmail.com> <d7ca66b9-c8a5-47c4-9feb-d7814efcce0a@linux.dev>
In-Reply-To: <d7ca66b9-c8a5-47c4-9feb-d7814efcce0a@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Aug 2025 15:18:02 -0700
X-Gm-Features: Ac12FXxz3DgVMWX9OGjfI5qMJqGqf0YdbSkWl0JVk2WoOJompJHLgRnltejDMRQ
Message-ID: <CAADnVQKkEk=uZ6LBW2yXSAB2huYwpeOdDggaUAzd74_bs_6dcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Introduce bpf_in_interrupt kfunc
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 8:00=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 25/8/25 23:17, Alexei Starovoitov wrote:
> > On Mon, Aug 25, 2025 at 6:15=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> Filtering pid_tgid is meaningless when the current task is preempted b=
y
> >> an interrupt.
> >>
> >> To address this, introduce the bpf_in_interrupt kfunc, which allows BP=
F
> >> programs to determine whether they are executing in interrupt context.
> >>
> >> This enables programs to avoid applying pid_tgid filtering when runnin=
g
> >> in such contexts.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  kernel/bpf/helpers.c  |  9 +++++++++
> >>  kernel/bpf/verifier.c | 11 +++++++++++
> >>  2 files changed, 20 insertions(+)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 401b4932cc49f..38991b7b4a9e9 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -3711,6 +3711,14 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign,=
 const char *s2__ign)
> >>         return bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX);
> >>  }
> >>
> >> +/**
> >> + * bpf_in_interrupt - Check whether it's in interrupt context
> >> + */
> >> +__bpf_kfunc int bpf_in_interrupt(void)
> >> +{
> >> +       return in_interrupt();
> >> +}
> >
> > It doesn't scale. Next thing people will ask for hard vs soft irq.
> >
>
> How about adding a 'flags'?
>
> Here are the values for 'flags':
>
> * 0: return in_interrupt();
> * 1(NMI): return in_nmi();
> * 2(HARDIRQ): return in_hardirq();
> * 3(SOFTIRQ): return in_softirq();

That's an option, but before we argue whether to do as one kfunc with enum
vs N kfuncs let's explore bpf only option that doesn't involve changing
the kernel.

> >> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> >> +               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigne=
d long)&__preempt_count);
> >
> > I think bpf_per_cpu_ptr() should already be able to read that per cpu v=
ar.
> >
>
> Correct. bpf_per_cpu_ptr() and bpf_this_cpu_ptr() are helpful to read it.

Can you add them as static inline functions to bpf_experimental.h
and a selftest to make sure it's all working?
At least for x86 and !PREEMPT_RT.
Like:
bool bpf_in_interrupt()
{
  bpf_this_cpu_ptr(...preempt_count..) &  (NMI_MASK | HARDIRQ_MASK |
SOFTIRQ_MASK);
}

Of course, there is a danger that kernel implementation might
diverge from bpf-only bit, but it's a risk we're taking all the time.

