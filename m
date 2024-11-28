Return-Path: <bpf+bounces-45803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8056D9DB1C8
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005282825F1
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28D085626;
	Thu, 28 Nov 2024 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaCLFBcl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F73B19A
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732763966; cv=none; b=eJF8D2tadLZUD1PveDEMPPDvEokESWme+WS5o9NXuqyTceXUHgyM3QVX5U3wTDKgPbvMTvg1JhfxJFiuae1OmvnHG5cNJjEaYVm+YitIIJtlfYNnmwVGKtFyxpjZsg97W9vuzSjjCgCl6wJflh9q+ncgowo1SIS53l3qPqViCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732763966; c=relaxed/simple;
	bh=3fBHkLBG3Gq9kW6qt++39g2+Qaadq3X7FNM++6uymvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMuf0RQ7P1ZDecdGtt1SAr2CiffkV40pIMe8cJErl+Nh8S1NQJSbHc9yC6prgFf6lOC22FLf9sfpXLuYI/eIjYk88AXJBP4jJRWXfOpTLwqNx0STmTar68wPD1Z3nliT/wrZ/P7l64mKDtqYK0rwNS1DpWeMuHC4egb5MCYwaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaCLFBcl; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2ff99b5ede4so3144591fa.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 19:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732763963; x=1733368763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TmIXqjnRv4y3EUBUtL+nF0r0Ku0bOp8H4/d0+Mvy/zo=;
        b=SaCLFBclM+7MlD9tfRAN4bOGvY25FZ5UQKofGjh77nfVXetSR7oYyEbe27BEHo7ntT
         zezQm6IloF/tOakBhh2gsl4486TlVm7yXPaxgZwIcCEMTVw6GNpLooMJdPvK32tgrPs8
         jezXpvNHYo7DEdxoihZYnytR1gDjQf7YL4bkxI50F6qnYui6OOaTICfqigmOsrzRccbM
         VOC/PN+pb+JIbXPzT5lvcV1SRFZ76gYGq0LWucCq1BvJeY+ihsLBhmVTt4+n9RheLgyp
         fv+XNHvboun27um26/gpiUA7s/MTb8Zp8o+d+oSNH2lFh5GeQbhZcsQtA/cTOebgmawm
         WjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732763963; x=1733368763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmIXqjnRv4y3EUBUtL+nF0r0Ku0bOp8H4/d0+Mvy/zo=;
        b=Jz7riQvrpFAn6Flf3icQqt8CtR7YEn9CvaBOjbuQQ6t/8BniNyHpDTjqwksHL6eLsV
         KVPMdxTfuowRB5Nw9bjUC0EwtsELlEZX2bnaZi4ktjTbvXfI6hM4nzVYlvUeW2kaIW5Q
         Grbjq19XKYKXVl2riXeX/pcuqv4kb6HWAzTi0hZn6uSI+eNaWWSjz5AUkP6ACo69welL
         YKV6LSe/Di/zu+B1ZTePqp3pDDIrxlWdjb1vFKLEkfVN2ljnkV3p88x3qhdMybkYhJv6
         kg5MziSGHTkXKl2cdK+XG4M3RssC+/VkIQ1v2CYEiCI89/aQEPMZNQhvI0mgMt6kNclz
         Ta6A==
X-Gm-Message-State: AOJu0Yyjaoo/BDOeeoBSfjc3FFzzy3WJs0j37HmReN44UIhMS4deCLsD
	yzjrZmUUG0RJEQrySDUsBnOsW4kolFZigko/DhIzyLD7MP43V54SXVz13OB1yPBe7CvVAsToBXK
	K7a+k5BdaKj5gz4KX+196QIRu9yrLMckux/I=
X-Gm-Gg: ASbGnct4ZlGglQMbqJuWousIElYDZksNNzflRpupwkPleKlFzUnnY5jErLYsFqBfOp/
	dv134QwZqJuy0wgBI/K5dZfGK8dL14LMl
X-Google-Smtp-Source: AGHT+IEb/GAVUcUOcowTq9sZXwmsIbHJw4sb4L/nbJO54y9seauXMLogRnhXIK1egkCUPfnyfMjZpE+bMJ7SFcYROe4=
X-Received: by 2002:a19:e00b:0:b0:53d:f712:53ce with SMTP id
 2adb3069b0e04-53df71253efmr65850e87.7.1732763962421; Wed, 27 Nov 2024
 19:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127165846.2001009-1-memxor@gmail.com> <20241127165846.2001009-2-memxor@gmail.com>
 <a4690c29ca3b5f34945cd507def7e0c6ecdec9e1.camel@gmail.com>
 <CAP01T77t=FmvzyeCJ_3Bp+8D0-Z4GGUHNeGbNBmSY6xFXi-ZgA@mail.gmail.com> <3cc26b1923426203b3d0df91ebb1638c0e492696.camel@gmail.com>
In-Reply-To: <3cc26b1923426203b3d0df91ebb1638c0e492696.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Nov 2024 04:18:46 +0100
Message-ID: <CAP01T76RCf1oHmWhhE8MzUYgJhkxkkqW7gRFCAPGiAgv8v7WkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Consolidate locks and reference
 state in verifier state
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 04:03, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-11-28 at 03:54 +0100, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > > > --- a/kernel/bpf/log.c
> > > > +++ b/kernel/bpf/log.c
> > > > @@ -756,6 +756,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
> > > >  void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_func_state *state,
> > > >                         bool print_all)
> > > >  {
> > > > +     struct bpf_verifier_state *vstate = env->cur_state;
> > >
> > > This is not always true.
> > > For example, __mark_chain_precision does 'print_verifier_state(env, func, true)'
> > > for func obtained as 'func = st->frame[fr];' where 'st' iterates over parents
> > > of env->cur_state.
> >
> > Looking through the code, I'm thinking the only proper fix is
> > explicitly passing in the verifier state, I was hoping there would be
> > a link from func_state -> verifier_state but it is not the case.
> > Regardless, explicitly passing in the verifier state is probably cleaner. WDYT?
>
> Seems like it is (I'd also pass the frame number, instead of function
> state pointer, just to make it clear where the function state comes from,
> but feel free to ignore this suggestion).

I made this change, but not passing the frame number: while most call
sites have the frame number (or pass curframe), it needs to be
obtained explicitly for some, so I think it won't be worth it.

>
> [...]
>

