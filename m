Return-Path: <bpf+bounces-41008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B382E9910B9
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4324B28F85
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7AE1DE3DE;
	Fri,  4 Oct 2024 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5sdSjCt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D81DE3D7
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070400; cv=none; b=mzycECbe8ueqIJqo9Cf/XEKSpLpqPyTmg4Hcubfk/Cmsmr9rLTKP36hnDXboH9fz+Pko23UKjdwI8Xu5u3fiRtzOJXeDehWcGaWqpnZa6Zb0z8XKmmEWVMep58s4ynjEQbkEZ10OGrlNOf/N0XQBKd36K6GGq4VyT+wMG6bdpN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070400; c=relaxed/simple;
	bh=tNsdE8S1y2/qvFfQ6Fzm6/dbZahRhi5SeOFzBu5fTL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZXmeDlM0WhovK48c3bHiQF07vEpY1f59DZH6I2QpW48hPNUBPTGFfujsUUAhR+dTl77S/ar0tms3l76vh+vgT76O1PtjNCmofCZsRtjTMll8K0uGpD/UEf1Mwv1iFnb/bTjrpDhjGsiKPh/QMl8VATbLCP6kSi5XT4uVLspcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5sdSjCt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so22619325e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2024 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728070397; x=1728675197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8x0d5BMazKdzM6nUMys8BP3pEcVpBm56sV1lYEBiI0Q=;
        b=B5sdSjCt9JsUkU+fAywASmOiFY3QwuY9l+lF0cmcsX6LjAz/xpSsdJMT1wGrWeToUU
         RBrLGkNevpn4pC4Dzu9+8iYFX9vEDfzuRI0h549dPjZNrSJgfdl2SQDJciWOsIzPYEIY
         2kI+WIbT4MAwr2thvuKDcpIlhUDmSc9puK98JI1ZMXCIJ/dEKyCOTaj2Kuw4q0G9pr8E
         l0tRjEaD88920ceyZ7COZCRIa9zHdzizID5p1HMk3Poh9q+/5EtBTYpOKrPHBZEuxHUC
         8R4YFmJtkb3Xu0KCoqW8gm9llNeI1GrjSQwn+wf+vYMTsAHhy5LtxJ6HEWchrjnpiFDD
         oDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728070397; x=1728675197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8x0d5BMazKdzM6nUMys8BP3pEcVpBm56sV1lYEBiI0Q=;
        b=SPCFcriSW8S0V9ZZC7Ldwj4cqfRJk1rwyAzD5MCVVBEJyUcCJHgTqoz5A2DqQlvfSH
         MwBETNpDdGmNIsQMMzNlQi6NaJiDGd9Fgq275AXWZsEunLpdIod3Dnq45v0lpWLqUVdI
         9+lZXL5aG2bhFYKOVYTlmQv/lD2UT80DZZOqoo/lSskMwITlNbQ+D6q6Ge/HdswgQ8sD
         hQienjsoPdXVOLQ3cF5VEGpTwdwi/H5ZBmhiLtYpZh0E5OE3PD8aPUA3xZ+KV2+hCXo5
         mx2hNQGvVOZiil9HlxVYjDVZVElIyNjYq87wJFZEEaKUG/Ckr3AcqImPotWjiiuqjkMj
         /t/g==
X-Forwarded-Encrypted: i=1; AJvYcCU6f7Jj8TcltbjGVrtGYvvQbQsNnRefSvjbTkAQTCKZulhDye9a0aOeEwkeXDC8Nwcv8DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYf7jmmHyje/tWaY0uah8uqAFKttdNctdGRAgUW+brann8uRVf
	CIruF/lS4PeAC2EFE20Dm76bq+p+2uZcfIOxxvlDRC5L8gqSmh8li6HR7iVWnClc68Tgf2pFUtM
	3Rxblct05osBoZwFOplCDBP3T7Xc=
X-Google-Smtp-Source: AGHT+IG6zajfnpdM04vkx7TzQCd9KFj0cZYB+4UGgrwHEH6BEUfC+s/Z0vdwlqQJRoQStdTazlqVvapLu3n5xqXzw88=
X-Received: by 2002:a05:6000:124b:b0:37d:54a:900a with SMTP id
 ffacd0b85a97d-37d0e6bcc0fmr2520191f8f.4.1728070396452; Fri, 04 Oct 2024
 12:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929132757.79826-1-leon.hwang@linux.dev> <20240929132757.79826-3-leon.hwang@linux.dev>
 <378aa2d5-6359-4e89-a228-7ea47ba563c3@gmail.com>
In-Reply-To: <378aa2d5-6359-4e89-a228-7ea47ba563c3@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Oct 2024 12:33:04 -0700
Message-ID: <CAADnVQL_VUJCFH6TuHMLesafY8iQ-4xBkiTdfEMqr02C_G6T=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Prevent extending tail callee prog
 with freplace prog
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eddy Z <eddyz87@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 6:54=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 29/9/24 21:27, Leon Hwang wrote:
> > Alongside previous patch, the infinite loop issue caused by combination=
 of
> > tailcal and freplace can be prevented completely.
> >
> > The previous patch can not prevent the use case that updates a prog to
> > prog_array map and then extends subprog of the prog with freplace prog.
> >
> > This patch fixes the case by preventing extending a prog, which has bee=
n
> > updated to prog_array map, with freplace prog.
> >
> > If a prog has been updated to prog_array map, it or its subprog can not
> > be extended by freplace prog.
> >
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> >  include/linux/bpf.h   |  3 ++-
> >  kernel/bpf/arraymap.c |  9 ++++++++-
> >  kernel/bpf/syscall.c  | 11 +++++++++++
> >  3 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index aac6d2f42830c..dc19ad99e2857 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1484,7 +1484,8 @@ struct bpf_prog_aux {
> >       bool exception_cb;
> >       bool exception_boundary;
> >       bool is_extended; /* true if extended by freplace program */
> > -     struct mutex ext_mutex; /* mutex for is_extended */
> > +     u32 prog_array_member_cnt; /* counts how many times as member of =
prog_array */
> > +     struct mutex ext_mutex; /* mutex for is_extended and prog_array_m=
ember_cnt */
> >       struct bpf_arena *arena;
> >       /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
> >       const struct btf_type *attach_func_proto;
> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index 4a4de4f014be9..91b5bdf4dc72d 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -957,6 +957,8 @@ static void *prog_fd_array_get_ptr(struct bpf_map *=
map,
> >
> >       mutex_lock(&prog->aux->ext_mutex);
> >       is_extended =3D prog->aux->is_extended;
> > +     if (!is_extended)
> > +             prog->aux->prog_array_member_cnt++;
>
> prog_array_member_cnt must check U32_MAX before incrementing. Or it will
> overflow u32. So it will be better like:
>
>         mutex_lock(&prog->aux->ext_mutex);
>         is_invalid =3D prog->aux->is_extended || prog->aux->prog_array_me=
mber_cnt
> =3D=3D U32_MAX;

No. Just make it u64 instead.

btw the whole thing can be done with a single atomic64_t:
- set it to 1 at the start then

- prog_fd_array_get_ptr() will do
atomic64_inc_not_zero

- prog_fd_array_put_ptr() will do
atomic64_add_unless(,-1, 1)

- freplace attach will do
cmpxchg(,1,0)

so 1 - initial state
2,3,.. - prog in prog_array
0 - prog was extended.

If =3D=3D 0 -> cannot add to prog_array
if > 1 -> cannot freplace.

but it's too clever.
It's better to use mutex and keep bool + count,
but extra mutex is unnecessary.
Reuse prog->aux->dst_mutex.
Grab it prog_fd_array_get_ptr() and do the check and cnt++

Also pls combine patch 1 and 2.
They do one logical step.

