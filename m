Return-Path: <bpf+bounces-69108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B86B8CC7C
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5623189559A
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4670D223707;
	Sat, 20 Sep 2025 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJkk2yMe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424320B7E1
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758384034; cv=none; b=BgIycg/jmJA8c1o/aaxXejD0J2Jm3TSWwN92qgVSjLqMfM0ymAF800tDo2Y+x4E4R0oJVIlkksvsbUsP5Q5LWdZ86vPKTQc5pMPLvRjmzUaSlUjWdMKweWWXIT+k1/90mPnTRYtShX+hvDRcD8CCFoPW6JfL2fMVN/PzNn6MINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758384034; c=relaxed/simple;
	bh=t+xMFzUNan4OAS3RwaNnsiNLjDi+tEvw4/Wobhi9LYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GS5IwfS2svL5YaqNLo0iVMEvSLe5mgm41Z9gr+GRTaXU+G/EaH3T7nXxLneQLkygypWybbqyRDHKjNhxWRAg/yeyeucGgo13Y3f4U+h7rRNlDXeXplvgR5thPb/XzcNnET0DdbjZw7RYWRtwC6NM1IgVpKvq2jS6eGxwyvcVIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJkk2yMe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso1785192f8f.0
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758384031; x=1758988831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9u1CGKyYBGrrt60O813LKsYEsL0X6fimnM3s4fCuWM=;
        b=FJkk2yMeMzx5rxyT97jjg7vaTeEGziR2zH1DJ1WaV4MXiygCqjD5gvZE+FuhW9p9FO
         UbdrfkFCPkU7KuJLlEKBG8AR4FFd3eG0XOwXSQPA05jHHAnUhcR3pUMvbOMaLWuWIgPt
         ut4lsA+pU/n2rTdFZa9gjzJcebO0wJcPM3pJ4M2Coq51ZKKbBEk/1pzYcH1dxAhHnTm3
         1BOaSt0xpCP7dYs/4VMIKL9q3SG7Pnfzlv8UKIVMLhz0QaQdcDxmgJ9VrH/wIU3jNPjz
         +FNmEcDPhhkS6vdH7O5vsLCLPXtyi+yA8pb9+q8CSG7I21Qe6C20qnTofwW6rgyYaGHH
         d44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758384031; x=1758988831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9u1CGKyYBGrrt60O813LKsYEsL0X6fimnM3s4fCuWM=;
        b=VnQio/Qf+Kiqy+E8hzLn7sjF47x+RoUwxkeg3qMejSAto9KQLmX6yfaxhnjxWZdmnn
         MWc8UX5Thv/cYx16KFvwYCkwbSKmPrb+M3/c52DbHM8lK/xgT8DPb8IKj28B+0tsK0E8
         YidSIHmJOLQVGwAaH5p8WGkkmnoIme2sAljmNHdhTdCZJppQ1Ghq4Cdh4frYx9zOxLFV
         jnK44FboM2JIDw3Y/qTkGL6BH915MkBUFIpi72OEE4kzNevjpT4VxFxHbEV00OBbBgIg
         1LszNdIRbiW070j9FarisrLLDKwlSrm4Zr0bHJi7Sm6EZlxlKuB/zJmm++oQA8DJYPic
         NrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJFLjwrfaSllAFUM3bvhmhFur+NjAB5xuzVJPFA7N7FwSKbTR72qDmA+pgp+yXqKzFU3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQ3/r7+4eQUX6KLqeJ0N3utTxYH4xyKue0reJV8bn9ZGiFofe
	Sv8kTN7wjB0dmyORp2JUn/b6ZW51QwdaXbDCpKG9kdRsTZV1b4STeQP7/aUOPlbIC/skU0gTsG+
	Yt2QwCOd0UjGVffKQ7TN6Eh/ZDk5gZ/U=
X-Gm-Gg: ASbGncsRhNQZb06tiDep0OI0dhvklngpyr4gSW3XUuNIqgkXQmEXbct2eR71jnPYyU9
	9IGQF/z91EO7tE0piKRYsiYvlqDEWXjQiRJpOLRJOjk9ir20BxKzkWYj0DHvAkS3xZZiRUVQRt6
	J80ffRqDya7nezbVg0Q98if9UzRPUsTFzupdSdZLWgMYPi2z4phwYXW9c2sz4rBcuZqd3fIwA59
	O0t5WRWzljJ00L2xDRzgAm89D/o7w4C6SUo
X-Google-Smtp-Source: AGHT+IFZBCve7+KXW4bfo2jvFwJICpmLMxwD5eIG5lPNkjimbgEgNO2cLyKlGEwHyNejKakihXZBhKcpzMKwfVoBJ4Q=
X-Received: by 2002:a05:6000:2881:b0:3ea:87f8:da4e with SMTP id
 ffacd0b85a97d-3ede1d9f615mr9356449f8f.29.1758384031242; Sat, 20 Sep 2025
 09:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919163054.60723-1-vincent.mc.li@gmail.com>
 <CAADnVQJi93AiYf7+eF2z4kSKfJujgvF-7ZorccEfgvMHoLjM=Q@mail.gmail.com> <CAK3+h2z4icrwcwoobMJCgO_YiPMFsbwbNvYOkYU-V_xMYpZvJg@mail.gmail.com>
In-Reply-To: <CAK3+h2z4icrwcwoobMJCgO_YiPMFsbwbNvYOkYU-V_xMYpZvJg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 20 Sep 2025 09:00:20 -0700
X-Gm-Features: AS18NWAmrX7d_WSMeukw0FTZ0PsrNvW51KgxG08_3HIIMp_OS_R5Bk4L-fGZgds
Message-ID: <CAADnVQKVyFThFz_kcCj0WSQX8zWJ7tysKActKiXJ7iFNNW+U1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, x86: No bpf_arch_text_poke() for kernel text
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 6:34=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.com=
> wrote:
>
> On Fri, Sep 19, 2025 at 7:59=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Sep 19, 2025 at 9:31=E2=80=AFAM Vincent Li <vincent.mc.li@gmail=
.com> wrote:
> > >
> > > kernel function replies on ftrace to poke kernel functions.
> > >
> > > Signed-off-by: Vincent Li <vincent.mc.li@gmail.com>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.=
c
> > > index 8d34a9400a5e..63b9c8717bf3 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -643,10 +643,12 @@ static int __bpf_arch_text_poke(void *ip, enum =
bpf_text_poke_type t,
> > >  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
> > >                        void *old_addr, void *new_addr)
> > >  {
> > > -       if (!is_kernel_text((long)ip) &&
> > > -           !is_bpf_text_address((long)ip))
> > > -               /* BPF poking in modules is not supported */
> > > -               return -EINVAL;
> > > +       if (!is_bpf_text_address((long)ip))
> > > +               /* Only poking bpf text is supported. Since kernel fu=
nction
> > > +                * entry is set up by ftrace, we reply on ftrace to p=
oke kernel
> > > +                * functions. BPF poking in modules is not supported.
> > > +                */
> >
> > Not true. Pls study kernel/bpf/trampoline.c and how it's used.
> >
> oops :). I  copied and pasted  from arm64
> arch/arm64/net/bpf_jit_comp.c and thought it applies to x86 too, sorry
> about that.

arm64 is different, since it has hw restriction on how far the jump can
reach. It has to do a very special dance.

