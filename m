Return-Path: <bpf+bounces-63088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666A4B025B3
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 22:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B3E3BD6F1
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B9BE4E;
	Fri, 11 Jul 2025 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiCemEBH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF919CC11
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752265277; cv=none; b=hL2dkoSAFp7U8djthk1293P7l5wiVt47XxoaUiJ13mCEGX5N00IHE2aI4KxqwBqFaf8D5WWftGoy5+zwRdKzjrcc0ybK5k4i/i60uh0aLo5KL5BhyHruzoF7jmRVPM+bdNwot7QM530REgevNSNxvuUsQdNRAy1PIr1WZKGCqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752265277; c=relaxed/simple;
	bh=/5d6L1IJ7eN2MKzKitj4kt74lh0NwMijgZsAqT5DzuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBEDoEIOFfM5d3Cdm32qI+CR+muQosb6QKKxHqWafKaiAI1PNLAI750Nd5+EaZdbb/n86ksQi0Tq4f4CJSUjuHGD4gGUUH9DKtVTwNY153+4qAftkh1fcXnYNhgp8e/hCN1A/PpcVv0Y6WJog58MwTK/qHqHfhv2roaO4utIRgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiCemEBH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so25128335e9.1
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752265274; x=1752870074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0NEhX22LjzXjHLaqGSMpH2jd8IODrD+xEAiP3ykLzs=;
        b=GiCemEBHorUbb3xqoiSrDrE0k1dNMA65g/5GbL5ngM5X6NiBTk4aFGv+rMSnuvuUVE
         LLfuqrNorUpPFPnec1VHssPw+uEXqGKyZ8v0y8XhQA9VchOOs/pb5UxN7vJfhjoatcAl
         jK4xMsH6ie8CY5lYYIlrvNlrc2I5YT/LxmrpwZLUPc9CZxoKHF8jZ0MEqhsRbH+LeRH2
         eBNNjoOsjW2c56GotVKyfdlUn8dE/1SbJBUIGqEhtXKDGkn547UEJcimGX8sUgX1Kvk2
         P/+FGGS6XZcY2Jv3RQc1G63a4DUfSufENx+NHqQCjA2iGvR2Alr96mF/NTX5KcCMrbW0
         Ztfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752265274; x=1752870074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0NEhX22LjzXjHLaqGSMpH2jd8IODrD+xEAiP3ykLzs=;
        b=I1DJzUsfIm1qV9Jut6KYbSRAYhlabnelpdqkyem4VsjrjPpg85dFMEIEerKMX1VjQ0
         7E3pP9kmO5sDuYIqcDdg1dO60cTR7vEKJLbuhSGGA5NzWGUuZYdQw/qYyNkLNcxi0qED
         UL424cRT0/LRdgiYxBb2e0YqAdY5aSKj9ytBkeCpdRJxfHhtZlgdHw8BznkrPpQlRUPe
         LIEsCDZG/u7gFXz3klqgZesIlsj+oAaq5WuCsA5V7p9x4Az5LSHs2DnJ45C/NIX0HvrP
         p/uSOD1eiMKUZSOixO0U/Z/d4jfaIlo5+ad9GOPLbTBbRNM5/+npp5RgjmzuAbrFo+TH
         turg==
X-Forwarded-Encrypted: i=1; AJvYcCVzBMhaoHJj6sFQh9+kTYMdZCQKiECrNOcAytlIp7naC/M4IBvsf8VZmiALp/iACFd+XXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmBO6enHYGuFHBW1kcCopudGDe3K5VtfB4YzmzmWF0LQq9aUn0
	KTFT0feS4NmM6yKNBecdXWckf/VXan3G8t5qsNkXmTuZkr7heLLvAW5VzC6WqOHCxOhA/fdjxhl
	ZsOhOVrity1M1MGO+cDyvcAzBBei976ZtNA==
X-Gm-Gg: ASbGncuSOXERDymr//AYVB3xRi/xe7rtcC9daFDK9I87Gqgv9bLzoySuZL2Q5d5XJi2
	AESKZWjKSLG2vD+tVKLh78kxtPLpOQPkKACTJ436ZxS/WZIm4c1siFrGzrr75ZGuNI6T3rC8gvN
	R7qCXvGLbJUCfbdo7S91OZT5PplLzuMQD6n3s3mKi7Tm07Xp6+Xn4r0Je5w8BMOyIqnVMnikG0j
	n5BshGMPeda3+pxiTTB5mllbdvdVKQt6paP
X-Google-Smtp-Source: AGHT+IGZAIvtMUmcddPEJ6OdFa1eoNSz/P/CFd1o4iaUsurj6jDnyIzNmnTPjN3uFnrvtsyaQnxZxpeK4LsDwhTk9bE=
X-Received: by 2002:a5d:64e8:0:b0:3a4:e480:b5df with SMTP id
 ffacd0b85a97d-3b5f2e33b06mr3477995f8f.44.1752265273810; Fri, 11 Jul 2025
 13:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708230825.4159486-1-ameryhung@gmail.com> <20250708230825.4159486-3-ameryhung@gmail.com>
 <68f4b77c-3265-489e-9190-0333ed54b697@linux.dev> <CAMB2axO3Ma7jYa00fbSzB8ZFZyekS13BNJ87rsTfbfcSZhpc6w@mail.gmail.com>
 <2d1b45f3-3bde-415d-8568-eb4c2a7dd219@linux.dev> <CAMB2axMDUr+s+f9K-4sj-5vSkPQV4RXHo8y73VH9V2JQbKZOxQ@mail.gmail.com>
 <CAEf4BzaUK0i7QFkKi800TQhAKw2WL+FyoG3eFP6nq_r-TUPBKw@mail.gmail.com> <CAMB2axONnVJ5BY-YOASWGUGpaZa-P64Yf5f6AbX+O8fjCiZNfw@mail.gmail.com>
In-Reply-To: <CAMB2axONnVJ5BY-YOASWGUGpaZa-P64Yf5f6AbX+O8fjCiZNfw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Jul 2025 13:21:02 -0700
X-Gm-Features: Ac12FXxcyc3qzL_Rd1iMUT6LCPL-gzNfMubwjaAkEPQjj1t5A5Q2LRmhMa0D4oE
Message-ID: <CAADnVQJxu5hsDw0iCP68eRW3v2CXRBos8asfN1x9F=gVyGmqbw@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 2/4] bpf: Support cookie for linked-based
 struct_ops attachment
To: Amery Hung <ameryhung@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 12:29=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Fri, Jul 11, 2025 at 11:41=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jul 10, 2025 at 2:00=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > On Thu, Jul 10, 2025 at 12:47=E2=80=AFPM Martin KaFai Lau <martin.lau=
@linux.dev> wrote:
> > > >
> > > > On 7/10/25 11:39 AM, Amery Hung wrote:
> > > > >> On 7/8/25 4:08 PM, Amery Hung wrote:
> > > > >>> @@ -906,6 +904,10 @@ static long bpf_struct_ops_map_update_elem=
(struct bpf_map *map, void *key,
> > > > >>>                goto unlock;
> > > > >>>        }
> > > > >>>
> > > > >>> +     err =3D bpf_struct_ops_prepare_attach(st_map, 0);
> > > > >> A follow-up on the "using the map->id as the cookie" comment in =
the cover
> > > > >> letter. I meant to use the map->id here instead of 0. If the coo=
kie is intended
> > > > >> to identify a particular struct_ops instance (i.e., the struct_o=
ps map), then
> > > > >> map->id should be a good fit, and it is automatically generated =
by the kernel
> > > > >> during the map creation. As a result, I suspect that most of the=
 changes in
> > > > >> patch 1 and patch 2 will not be needed.
> > > > >>
> > > > > Do you mean keep using cookie as the mechanism to associate progr=
ams,
> > > > > but for struct_ops the cookie will be map->id (i.e.,
> > > > > bpf_get_attah_cookie() in struct_ops will return map->id)?
> > > >
> > > > I meant to use the map->id as the bpf_cookie stored in the bpf_tram=
p_run_ctx.
> > > > Then there is no need for user space to generate a unique cookie du=
ring
> > > > link_create. The kernel has already generated a unique ID in the ma=
p->id. The
> > > > map->id is available during the bpf_struct_ops_map_update_elem(). T=
hen there is
> > > > also no need to distinguish between SEC(".struct_ops") vs
> > > > SEC(".struct_ops.link"). Most of the patch 1 and patch 2 will not b=
e needed.
> > > >
> > > > A minor detail: note that the same struct ops program can be used i=
n different
> > > > trampolines. Thus, to be specific, the bpf cookie is stored in the =
trampoline.
> > > >
> > > > If the question is about bpf global variable vs bpf cookie, yeah, I=
 think using
> > > > a bpf global variable should also work. The global variable can be =
initialized
> > > > before libbpf's bpf_map__attach_struct_ops(). At that time, the map=
->id should
> > > > be known already. I don't have a strong opinion on reusing the bpf =
cookie in the
> > > > struct ops trampoline. No one is using it now, so it is available t=
o be used.
> > > > Exposing BPF_FUNC_get_attach_cookie for struct ops programs is pret=
ty cheap
> > > > also. Using bpf cookie to allow the struct ops program to tell whic=
h struct_ops
> > > > map is calling it seems to fit well also after sleeping on it a bit=
. bpf global
> > > > variable will also break if a bpf_prog.o has more than one SEC(".st=
ruct_ops").
> > > >
> > >
> > > While both of them work, using cookie instead of global variable is
> > > one less thing for the user to take care of (i.e., slightly better
> > > usability).
> > >
> > > With the approach you suggested, to not mix the existing semantics of
> > > bpf cookie, I think a new struct_ops kfuncs is needed to retrieve the
> >
> > yes, if absolutely necessary, sure, let's reuse the spot that is
> > reserved for cookie inside the trampoline, but let's not expose this
> > as real BPF cookie (i.e., let's not allow bpf_get_attach_cookie()
> > helper for struct_ops), because BPF cookie is meant to be fully user
> > controllable and used for whatever they deem necessary. Not
> > necessarily to just identify the struct_ops map. So it will be a huge
> > violation to just pre-define what BPF cookie value is for struct_ops.
> >
>
> We had some offline discussions and figured out this will not work well.
>
> sched_ext users already call scx kfuncs in global subprograms. If we
> choose to add bpf_get_struct_ops_id() to get the id to be passed to
> scx kfuncs, it will force the user to create two sets of the same
> global subprog. The one called by struct_ops that calls
> bpf_get_struct_ops_id() and tracing programs that calls
> bpf_get_attach_cookie().

Can we put cookie into map_extra during st_ops map creation time and
later copy it into actual cookie place in a trampoline?

