Return-Path: <bpf+bounces-51132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C40EA3094E
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 12:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D62162E5D
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 10:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4171F7561;
	Tue, 11 Feb 2025 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="misKKmMT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB71F4E30
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271580; cv=none; b=eXBpwkAu0sNcHsmFd/amQ0Ojl41mPxXz/VlYVqUdYfthINcWbjcrrVEJfZuJj4m10JA3Of1i05GIzW6RUfqrFcFBaNoG7SGnuo25lCRZ1hdA8edRRUNskAi6rNsR79WVCebcOERsUE6XTyKCEMpB8H7FcValq1yTf/qT/luzfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271580; c=relaxed/simple;
	bh=4PFcDZHaqRE1yfVc9zAub1O0Tuf/RnqJk1BHBxU1fRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg+N14DzCtXOz0FbPqSHquNHViMoamAbrm+lWAmj4gB+zTFoNmdJ6/LzxkV8/ZAJan1apSvHcQm6d2SAO3HeldhLBX/83VDYBShM03MaRgwMbDok1SSMBFOdM77YUcUbfQCjVB6t7NkN6auKAiLxDg3ouqhB3n6krBecM+1IvyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=misKKmMT; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so2491892a91.2
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 02:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1739271576; x=1739876376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwV8OaMi5n/l04YD9LOH13d+H0D0axM53N76szIr1NU=;
        b=misKKmMTIfWavK1l49vX1BA9rWq0rww69MVaugo9dV2QoiD4x6XxYM4eHORbIV1aSr
         q2GeI3Vi137Molj3/huukc/vKsuf1Il+uSVweaDcfHUCAa6NyUghMSMeIn21WljyuHPc
         7DQQKneVnN1YT/jOvfCZNnR9GezgydG+SIcL3WYEGSYXq2+GLxTxunc7A+zmu2DZWMU+
         uwRx67hFbBalQ8LtO9DFNKkS7N560vJuME91lhLJkkAcZCe43awzVh868prOaJ588qMg
         VrLQoCgGiYpUcSLGGSyolzvdP8t1hzd5MRWeiMmWem0Jg5MJSi9iuljPnECaBEaZ3WR7
         tUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739271576; x=1739876376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwV8OaMi5n/l04YD9LOH13d+H0D0axM53N76szIr1NU=;
        b=DfD4gJpujPOqmqDkRZ45PFmkEUazWaYkEcOdNf7IMVjyvJ+yKWYOYFU8qyvMkMm2W0
         /KhcY3/B1nOKDzBVVScdS5pI/kXXcprxweAWSYdm8Ds9if1bM0K1xGkNLSJ27UIdQD0S
         wGSWZvll4PPTdWv/jpYje38Bx3cj+Hbq+4AJreDfH22QHdThQp74uknQmRSislf5iBaT
         c8HwTLggJiSvxUNC4UFtQntSsvbK48o3BGBJJhmICruZKrScl70XlHG8Uywqi+Hviic5
         JsyuJFfidV62ZWoKaB6vT+LV2CausXsnV9LprmUeeNWO8dXtLdW3EhCOoK72LCM8jGyo
         BmdA==
X-Gm-Message-State: AOJu0YxaBLapg+WtBP9sFMs8yzIn5XH/FH1qVwpqiSX2PjwZpCDonZ1l
	gONFKF8/yhMOlS/LjXjKwCNEF/uVvU67YiOh77VeCm1j8ZnI+ksIn7aMiIL6tsKJfA3Oup5gDCy
	N5cCq8EazVVztNZq//H7CmaryydAerxKom0sCFogdTuYXD2qivq4=
X-Gm-Gg: ASbGncv/9K2Keytp/j8UB5EoO4MkD4YBuk4LWU9GPxuTkfmO4MH7/BPhDwg7jTPzUSz
	ZSgk6XG2PgbojBanuSqNCdTpQhkBT1k6cM1Vp1F0v6EBA1Zy+cForQSRRZCoMpL4T2gj3gRrM9X
	J5tqaPN+H+XkZxVUuYnagLupxBfmtm12Q=
X-Google-Smtp-Source: AGHT+IEhBgBCA2Mu+Y9isulF/ag/MjQ7qsnvppaoWo2CuTLF+EABrvOJutGMOyaLmwf0PWMisShXrXZSoR5IVnKXIeQ=
X-Received: by 2002:a17:90b:1e41:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-2fa24064ed1mr27919961a91.9.1739271575636; Tue, 11 Feb 2025
 02:59:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
 <CAADnVQ+FJA6jBRxCagAR6GuW0uRysfmgCnGk=ym1-rV0DPHPJg@mail.gmail.com>
 <CAH6OuBQa2QbCXzksiy5PhTCEYBf6m=w0ZKAUzTptxjgqKC25Mw@mail.gmail.com> <CAADnVQJaOJbu9odEqCSRRfhvWtudzdN9_=ZqqO7A-jxQf9ZRJQ@mail.gmail.com>
In-Reply-To: <CAADnVQJaOJbu9odEqCSRRfhvWtudzdN9_=ZqqO7A-jxQf9ZRJQ@mail.gmail.com>
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Tue, 11 Feb 2025 11:59:24 +0100
X-Gm-Features: AWEUYZmo-4zBe8y4wSZ0G0-v9iyVyh33gL3aO6mXcMPmldiosYgqnoaBmp0JZ8U
Message-ID: <CAH6OuBQ5o7d1D1Atq7a+gLGcaH5YgpiYQk4tmZe0y3QQneT=CQ@mail.gmail.com>
Subject: Re: Poor performance of bpf_map_update_elem() for BPF_MAP_TYPE_HASH_OF_MAPS
 / BPF_MAP_TYPE_ARRAY_OF_MAPS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 5:15=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Feb 8, 2025 at 2:39=E2=80=AFAM Ritesh Oedayrajsingh Varma
> <ritesh@superluminal.eu> wrote:
> >
> > On Sat, Feb 8, 2025 at 4:58=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Feb 5, 2025 at 4:58=E2=80=AFAM Ritesh Oedayrajsingh Varma
> > > <ritesh@superluminal.eu> wrote:
> > > >
> > > > Given this, while it's not possible to remove the wait entirely
> > > > without breaking user space, I was wondering if it would be
> > > > possible/acceptable to add a way to opt-out of this behavior for
> > > > programs like ours that don't care about this. One way to do so cou=
ld
> > > > be to add an additional flag to the BPF_MAP_CREATE flags, perhaps
> > > > something like BPF_F_INNER_MAP_NO_SYNC.
> > >
> > > Sounds reasonable.
> > > The flag name is a bit cryptic, BPF_F_UPDATE_INNER_MAP_NO_WAIT
> > > is a bit more explicit, but I'm not sure whether it's better.
> >
> > I agree the name is a bit cryptic. A related question is whether the
> > optimization to skip the RCU wait should only apply to the update, or
> > also to delete. I think it would make sense for it to apply to all
> > operations. What do you think?
> >
> > I also realized the flag should technically apply to the *outer* map,
> > since that's the map that's actually being modified and synced on, not
> > the inner map. So I don't think "inner" should be part of the name in
> > retrospect.
>
> BPF_F_UPDATE_INNER_MAP_NO_WAIT suppose to mean update_OF_inner_map.
>
> > Perhaps BPF_F_MAP_OF_MAPS_NO_WAIT or
> > BPF_F_MAP_IN_MAP_NO_WAIT? I'm slightly leaning towards the latter
> > because the map of maps support code is also located in map_in_map.c,
> > so that matches nicely. They're both a bit long though. Either way,
> > the definition of the outer map when using this flag would become
> > something like:
> >
> > struct {
> >     __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
> >     __uint(max_entries, 4096);
> >     __type(key, u64);
> >     __type(value, u32);
> >     __uint(map_flags, BPF_F_MAP_IN_MAP_NO_WAIT);
> > } mapInMap SEC(".maps");
>
> Actually we probably should make it similar to BPF_NOEXIST/ANY flag,
> so it can be passed to update/delete command instead of
> being a global property of the map.
>
> BPF_F_MAP_IN_MAP_NO_WAIT name sounds fine.

Thanks. Making it part of the update/delete flags makes sense. There
is already something similar in BPF_F_LOCK. Looking at the code, that
does mean it would probably make the most sense to perform the check
for such a flag outside of maybe_wait_bpf_programs() and make the
calls to maybe_wait_bpf_programs() conditional on the flag in
map_update_elem() / map_delete_elem() / bpf_map_do_batch().

>
> But before we add the uapi flag please benchmark
> synchronize_rcu_expedited() as Hou suggested.

I'll need to find some time for this, but will do.

>
> > > Also have you considered a batched update? There will be
> > > only one sync_rcu() for the whole batch.
> >
> > We have, yes, but in our case, these updates are a result of another
> > system generating events, and it is a bit hard to batch them together:
> > it would involve waiting for multiple events to arrive, instead of
> > processing events as they come in, which introduces an additional
> > layer of latency by itself.
> >
> > Regarding batched update, we've found that it is also very slow when
> > inserting a large number of elements. In one example where we inserted
> > ~1.2 million 16-byte elements, we found it took 4-500 milliseconds to
> > update the map via batched update. This is due to the overhead of
> > generic_map_update_batch() individually copying each element to be
> > inserted from user space via copy_from_user(); almost all time is
> > going to __check_object_size() called by copy_from_user(). I suspect
> > this one is hard to fix though, due to how the elements in a map are
> > laid out in memory; it would be hard to change such batched updates
> > into a single copy. But perhaps that's something for a different
> > thread (and we can easily work around it on our side).
>
> Disable CONFIG_HARDENED_USERCOPY.

This is part of an application we're building (a new CPU profiler)
that will be shipped to end users, where we have no control over the
flags their kernel is compiled with. Nevertheless, as mentioned we can
easily work around this by not inserting individual elements, but by
batching them together, thus reducing the copies to fewer-but-larger
copies. So this is not really a problem for us.

