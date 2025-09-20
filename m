Return-Path: <bpf+bounces-69100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605DDB8C92D
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 15:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8CA7E7A6B
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DF52116E0;
	Sat, 20 Sep 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkIFRKXO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894E4433A6
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758375277; cv=none; b=FfDx85kGsvZLqbash2n3VGnEOxEjequr33kJS/lm6gSurBurgtXNb9BisjijLzvMiRf+CSGtrV7pXdEhrbTLfcEt98VL8AXfD+7J54KknNiIeO9DLlD1RXGbB6Q8so3vbCTAwFyfLzNhikeWDv4jPrdXnrKvmcZXMobBZ8ES9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758375277; c=relaxed/simple;
	bh=YnAuweZujrmQTV+1zFDHhxD3VmIyWXRjgIpz5Yo0okI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZJ39f8Qg51jjF1Ro8pHAkbOv61iTft3QQrrgU4bAbfm/XKkYx5ne3FV93kBAQL6+3+4j1n8a0eAdRyLA5AcGTfHHO4cClpk5uurDSfmrQPQOhVasTN5Jsxls2b8n8W2eVftRK6IoO7HiI7lBZePR+isgGkQDmXw1JiCMuCh+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkIFRKXO; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b5eee40cc0so29852441cf.0
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758375274; x=1758980074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQXZzHFfrKN8b1InafhMgULAsd5Yx+CYgRuUypJTSSE=;
        b=AkIFRKXOiZ81ibWTpUYeXREbmCqf01Xy8pFG+6nC1cvg7AujoE0B2kmmi5vdzWrKFJ
         f04GhDRH4AfrSy6KAE8ALqWREml0X1KBio7x4tn/gnAxDsakhXJSnBbxw24tX2wQIqyO
         QqGQvDy8MZrLci56h/nM7iYyFWAp6MewGsOAtLpO/y83WnIv5I8vIImPTpU08uWPZuhz
         uZvCx9XJth7/PJOwEru+ama04DyP+d824rSycEK2LGZHMYypc8oNJQFcXHSgsZ3cJa9g
         kfzUebJW88/9nA5Obz8M2lDP/BlLYbCUVudwRcl24MnkNy4SpdwU3yqi2TzWzVJnR2Od
         LVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758375274; x=1758980074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQXZzHFfrKN8b1InafhMgULAsd5Yx+CYgRuUypJTSSE=;
        b=u1ctNnAGk9VQmGCMXCcokA+GrX0rCV1GJJl0KwCLsSQeYtBsyli+ukUvR4wlpT6r0p
         xbHxeJjsUFNISmY1JjO8ULr6vhNX9DZ3bqGLVNZRqxBntVLIbi6uOvwy6wuqdMsqyHFZ
         axlus09Ob74pg8a2gfS92Aq7H6We0LS3NwTRxlQxnVhWIOQW86oFlSXtxpYM6RZRnJR8
         IfTTl3POzP1U599DPWcQ15RRp9fsbegpH6zft1VSALxGyaYZVnsKCoU1FH2OXdkRxCZO
         TCbMyWJX8f3RnmWykTSTbhsc6zw1//DlzX8b7gDBCAtPZkjNVnzNHaBjelsDk0MAwOk4
         +XTA==
X-Forwarded-Encrypted: i=1; AJvYcCWBZ6ixYHv7nylICiykUX2mFcCyj44T0Iv7qHt1Y57vSbROivFqKCVNtpSzpUBRb8Vc/FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjGGqsVVFL/A3eD8v0uCPIG0KZFhzYkJLsNp7VvIuRyJ/4PB9
	rKjQ4RX2BvyS+P9pDoZeTri+CnnOXhWYpBAjp34cGge64ri5//h7ipr+63927cl9jOEuj5OtZ+4
	dgWbN4ETSKnCyv10tiUDIyOKVizAaK5g=
X-Gm-Gg: ASbGncutce0S90+7CpXcUFURwzK5dOtCuaXpv0dlM61tS/WdmCRvCo8U646i3U2z/BB
	GsuPafD8Hy2rQE89vUCxKClkqdIuJKJIvqheVCdevP+ondb+nzNQ9RagVfED/40PJCDg3BvHvl/
	SiK4+LqTHOpF0HQ+jzYzSUNcdK4MGQs4IFtTu/GBmBUSTT8aZ3PY9R3UmhhMePKWdflQYjfPUp5
	vGj33I=
X-Google-Smtp-Source: AGHT+IHnD/grWuYTvxXVAXhog/+z2x2R887yNFiDBaRrVsGeuDWkUgulKiiDFlI9xEhymWc3a0xM+dtYR5IO52jFFXg=
X-Received: by 2002:a05:622a:17cb:b0:4b5:dada:9132 with SMTP id
 d75a77b69052e-4c073c995femr67939211cf.75.1758375274321; Sat, 20 Sep 2025
 06:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919163054.60723-1-vincent.mc.li@gmail.com> <CAADnVQJi93AiYf7+eF2z4kSKfJujgvF-7ZorccEfgvMHoLjM=Q@mail.gmail.com>
In-Reply-To: <CAADnVQJi93AiYf7+eF2z4kSKfJujgvF-7ZorccEfgvMHoLjM=Q@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Sat, 20 Sep 2025 06:34:23 -0700
X-Gm-Features: AS18NWBiJ7eXP0rk8jb1klAWt4vKpK5JWKCWNQ-A2dPL72ZBU5xsp_okqMjpebU
Message-ID: <CAK3+h2z4icrwcwoobMJCgO_YiPMFsbwbNvYOkYU-V_xMYpZvJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, x86: No bpf_arch_text_poke() for kernel text
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 7:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 19, 2025 at 9:31=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.c=
om> wrote:
> >
> > kernel function replies on ftrace to poke kernel functions.
> >
> > Signed-off-by: Vincent Li <vincent.mc.li@gmail.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 8d34a9400a5e..63b9c8717bf3 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -643,10 +643,12 @@ static int __bpf_arch_text_poke(void *ip, enum bp=
f_text_poke_type t,
> >  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
> >                        void *old_addr, void *new_addr)
> >  {
> > -       if (!is_kernel_text((long)ip) &&
> > -           !is_bpf_text_address((long)ip))
> > -               /* BPF poking in modules is not supported */
> > -               return -EINVAL;
> > +       if (!is_bpf_text_address((long)ip))
> > +               /* Only poking bpf text is supported. Since kernel func=
tion
> > +                * entry is set up by ftrace, we reply on ftrace to pok=
e kernel
> > +                * functions. BPF poking in modules is not supported.
> > +                */
>
> Not true. Pls study kernel/bpf/trampoline.c and how it's used.
>
oops :). I  copied and pasted  from arm64
arch/arm64/net/bpf_jit_comp.c and thought it applies to x86 too, sorry
about that.

       if (!__bpf_address_lookup((unsigned long)ip, &size, &offset, namebuf=
))
                /* Only poking bpf text is supported. Since kernel function
                 * entry is set up by ftrace, we reply on ftrace to poke ke=
rnel
                 * functions.
                 */
                return -ENOTSUPP;

> pw-bot: cr

