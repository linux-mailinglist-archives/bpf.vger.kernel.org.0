Return-Path: <bpf+bounces-62725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 715D3AFDCF8
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4664A5E8C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A53186284;
	Wed,  9 Jul 2025 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Prr048Fu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A988980C1C
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024849; cv=none; b=aIfwIWNmV7GZS/fFShT3YmX79oepPGzrOBg9OhR8MpAA7046F4FoSoZ2hxqK8QBpNhckA/JpWBSfXJZZtPyQWr0nWIiTntHKdWFb6mvMXf0oCd87OQZOy8PzXeQj8ZbW7r93hVGEST6bfSZihnWFyrPWAvcgkqeG9WMPZR8BF7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024849; c=relaxed/simple;
	bh=8kIiOPnjB3NCGDqGy+ztW1OQg1uVd47vgX2bH3uQptc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkvrviZ8yjYUVebd7WQumFG9JSargb0enGayh6u63GPm4usWYPk61mOvGuvdKFSfyGBV5osBMo9SOLW0G6iEwJj+fF+Co28aAOlEMUiSg6wBus2jscPLWoO07pybTjoP5fevyjWJ8WeoCt2zkRHB9FZlwJT1wy8oBO00boZ5bZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Prr048Fu; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e81cf6103a6so4665377276.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752024846; x=1752629646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHJWNNaWVn0wFc4/E6eZpiRedu5jY4vi3a6M/QE/ONU=;
        b=Prr048FuE0UhRFAYDTs7CxE7cBt/1a0rJH0lc3j+V1MyT3DYVZdOF67i26RjSSEV+E
         ZSqwktgdP/sQOe3UXpXwBvE2qbEeq4R+naEhQy6H/BaNfEWTXmrDQ88F8g5dxll+mu6h
         PI/Cd1qs17+XMXPo5ISQEMh80zUGixtD3pU5zjG4Dm11ecfbAc2UmlcxJuo3ZCe0MSgX
         QI8WrVgU7HT+QelI0m0gHadEGqn7bo5j73CjpwO5cBGiOCuNPypsuVX9vQDoykhe+Vme
         KEB6qKf4d1e/hmcXIggHteGGB3jNvlWutIAk5fvSxg3mH0vZ6q2Ni0dyjdu9S+adItYr
         AkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752024846; x=1752629646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHJWNNaWVn0wFc4/E6eZpiRedu5jY4vi3a6M/QE/ONU=;
        b=frIHILAObOwF/41DIOKRa1MFRczFbJHNaW+GpItSHFBm3mH5RNZsUmSJ2EIzXK0icO
         SIi45CRYChRwRDhpaiilIAL6myU+aq/sYrPLf5YDSPU7JyH7FDDc+CeENZaQ1DRu28Eg
         +CqWevI81i+h2zmnLpy1FfglcKBgq9je1x6ViCvsRdLxtSB+MfRlQBM03fgH++dtIZYu
         +/DgauE17P06pJp36gYkAHGZf3SO7agqymEbW7M3hf99olkEGhmpERxXEddXWHzLSuFj
         Mo2/feKuUHC89w09GUAIvcKVZOIPQqObUY9GJI2U2N3A0vfb27Hqq/iJhFCwnWg6UFVb
         1WIA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+ZfoF35xaumENzoXcMJt32B4eNF3XG2W+1heFS9GEFmt8P7vtAH4QRNWacG6gwmWvc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjS9KGt9aIDH7l55w3tzdSQ+twvb3/5H8d+C1ELY1Qb6jSjttB
	YpLzlUd/x4QpS1+uIzd/Sy3wetxiK7OHdCz+bmyxBlDFG2OGlWFN6wDVnN9jhPPoYL+fngPTrk4
	ejPz2JE9FNRfB+I+WP5Dg/EweGfsxY8WQ4aNc5VvOEA==
X-Gm-Gg: ASbGncu58ZuOrzvb69e/c5vIWbH5spwepcmXuM7NcQXHOEk/C34oDhJfCa5LxY+lQF+
	UpajxZIp0yRwXN6nH8k9+XBPv6cSN1vb1avFi9TykGdO0ue0lIVog2zk/BiA39dIQWxC3c/NYMR
	aHF5IelDTTacmkG6ukHFNLBxGPFD7A+YphxjNbR1+MwYk=
X-Google-Smtp-Source: AGHT+IFX4hGi0YHehQOMokctzm31eqGejm9TDow+vPZyQ3ZUmveX6Yl5fBPIG076vTBiVVRSYtx6MlbukdyIY3SCZnY=
X-Received: by 2002:a05:690c:4991:b0:716:59a6:2dc5 with SMTP id
 00721157ae682-717b1b7520fmr13226507b3.15.1752024846443; Tue, 08 Jul 2025
 18:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-18-dongml2@chinatelecom.cn> <CAADnVQKxgrXZ3ATO4rdC9GcTtXvURpKR8XcGCdCa_qPh4RGFrQ@mail.gmail.com>
In-Reply-To: <CAADnVQKxgrXZ3ATO4rdC9GcTtXvURpKR8XcGCdCa_qPh4RGFrQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 9 Jul 2025 09:33:06 +0800
X-Gm-Features: Ac12FXwmo8JYsvx_afItxIGJW13x6KZnDBWV8rpcQL02a2r_uKQK-ltGmeh3vQE
Message-ID: <CADxym3Y-Jbzp0FupUgBDJB99GhsbDHyuV71Q6m9xyTpFze4ESg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 17/18] selftests/bpf: add basic testcases for tracing_multi
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 4:08=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 3, 2025 at 5:18=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > +               return true;
> > +
> > +       /* Following symbols have multi definition in kallsyms, take
> > +        * "t_next" for example:
> > +        *
> > +        *     ffffffff813c10d0 t t_next
> > +        *     ffffffff813d31b0 t t_next
> > +        *     ffffffff813e06b0 t t_next
> > +        *     ffffffff813eb360 t t_next
> > +        *     ffffffff81613360 t t_next
> > +        *
> > +        * but only one of them have corresponding mrecord:
> > +        *     ffffffff81613364 t_next
> > +        *
> > +        * The kernel search the target function address by the symbol
> > +        * name "t_next" with kallsyms_lookup_name() during attaching
> > +        * and the function "0xffffffff813c10d0" can be matched, which
> > +        * doesn't have a corresponding mrecord. And this will make
> > +        * the attach failing. Skip the functions like this.
> > +        *
> > +        * The list maybe not whole, so we still can fail......We need =
a
> > +        * way to make the whole things right. Yes, we need fix it :/
> > +        */
> > +       if (!strcmp(name, "kill_pid_usb_asyncio"))
> > +               return true;
> > +       if (!strcmp(name, "t_next"))
> > +               return true;
> > +       if (!strcmp(name, "t_stop"))
> > +               return true;
>
> This looks like pahole bug. It shouldn't emit BTF for static
> functions with the same name in different files.
> I recall we discussed it in the past and I thought the fix had landed.

I have tested the latest pahole, and it seems it hasn't been fixed yet.

I sent a patch to relieve this problem in the kernel side:
https://lore.kernel.org/bpf/20250708072140.945296-1-dongml2@chinatelecom.cn=
/

It's not perfect, but it can still be of some use in this problem.

