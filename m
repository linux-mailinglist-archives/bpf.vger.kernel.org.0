Return-Path: <bpf+bounces-57068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8494AA51BC
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691911C045B8
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDA425EF94;
	Wed, 30 Apr 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZwdLHEG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B516B2DC768
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746030902; cv=none; b=FG1cWd1M/6gW55GLCagfZDhr0bqM5Iew767zN6AFMqyZAiZ5jGORlhKZB7lL+uGak2maK68yAVuFbaTA4GZPUVeQK8wUP+ePwUVaBeRFUZujQuAJpJonGpUr0d2pZtnfxdAgJRyh4Z8tWPRIn8WvzzVxTdkpD3HQnH1r/4ewd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746030902; c=relaxed/simple;
	bh=JGT0tG/hy+L2KzEO9YZ3Iuuh4B+I+0qeVp6FjQUdHEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBIiQycsVHA19gEQYhvCcIa+qHsDXxDgrQD3OZV9Y7YWpe2o0ExRjffG4m9Pw1A7vcUd1uS7vvaZqHiV3SXg3WvGLv4ZwGs2FJYG2/CJD4qB2+u3oxyUfusRsEpFh8WKcuI2iehx+XUucBuTEwFBn07LFfLB3fk+lgk4wMcw1pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZwdLHEG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43edb40f357so86175e9.0
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746030899; x=1746635699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B8thz0BO3ZL4HL1BarmCDmtZdcXw24TAXPnlRD+kpM=;
        b=UZwdLHEGvIfT8/uUrQRCWiTr6Bmcx3JU1gJU5hDG84c916BsIOwWGn8gHi2grBeMay
         /uvG+BYGgqccnMv9K+WpG+1ppyNrxd5619sTcC7IfTQk7c+wmu5t19A42eb3RWzuvkPX
         LfGwV1HI1arewcqOdvaVQc+hoL4KZ20tcCwGipBQkeds80+6ahzgO5R3welqyR0vFag8
         CK0majckFbFCjb4SepkrEzvd5CiyGsXly3wOs2rjFD4Hl3+H95hqP6y2PjiOvUhaHRBr
         Ph82m9QJEMyC5DjgTOB5OI/HgYIkQ/C2pkKQwyZReemigDyDCpVyysXBr3ZOdj5SLDYt
         G43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746030899; x=1746635699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3B8thz0BO3ZL4HL1BarmCDmtZdcXw24TAXPnlRD+kpM=;
        b=shiyLaCTzBoeN3zNZ4CbyvVei/jAXRYjiRHWkawrWoy0XfroFXnVIVQ5ie3Ag5IzEc
         hMixFleDwos0euTBzp3Phjh58v4M9yK/atnn7Ukoht0RY08jLL2z3uypV/T0otauMgWO
         62a3AUVweNE/9LiswMMrKsf41a+Z3+KJ5pNPCdzkYmt1cCjyoSj7Xuf9tNDOV9wex16w
         bWiaCC9y3z3B6igFRnGAb10w2lyiOvbScIm++E2fS5f0zCtH26qzg82E4E9ajNB3F3pm
         lQq7z5Hp1hFDKgknw1G/92FssGLFv84wcFAVldI+jrnxpGbfqiT8QHabs2E4yUumzO2q
         ji+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXapDXjEOIJyZWBYZ3rZyIyrUI1j0C6DQ5CNyDGo5/KJX7BQuwhgqBpK1TTWq3tssIMFGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjaouG+hK+hfPNj76pcYZnUT8L6idxFPxos6tsuZsn1b4AbSQ
	wxl2CGgQ+9XhvUaMV/IojwEraJSP4fiH/0f/XB4cCTiOi4+KZwkpIbhbmRGG58xf9ondiUUGJX3
	uT12i/Ahf1x0JNhxfmWabe8i7NJHjPfeM
X-Gm-Gg: ASbGncvygn97ptnYTuVAZOxMy7fLHKz1wsLX6FhxzvBz0Sj18yR/Sq/r4uNSWxeKDyI
	uGlcZS2tG38oIO0y42gvx6ejFSE9YOQOmvmB4LupwH4uqH6BQmL8wH3raV3xex+38nAcqU42o2T
	4gYEuLDDcT4Ulw3GMF2du6l3/21LIES62dqI3/bQ==
X-Google-Smtp-Source: AGHT+IEngPsm4OVH3QQRVQCgTC4wSLmYLRpG94Yx/28weA4bdWaOALWpxv+Xkge0juUJrzOum1IQKAUBP1doiR51Bs8=
X-Received: by 2002:a5d:59af:0:b0:39f:76:8bc with SMTP id ffacd0b85a97d-3a08f765397mr3518949f8f.17.1746030898917;
 Wed, 30 Apr 2025 09:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429142241.1943022-1-a.s.protopopov@gmail.com>
 <CAEf4BzYeKLgqn+yq3Mt+Vv-9t6qmzQqimb31zD=y-Cw474LU5w@mail.gmail.com> <aBJQ6lsZfg8xlM5e@mail.gmail.com>
In-Reply-To: <aBJQ6lsZfg8xlM5e@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Apr 2025 09:34:47 -0700
X-Gm-Features: ATxdqUGqJg5njhJgBe5tsI2wLR_Ghfiw6-RZ7BkmnR-irwrMGBqQYFER4THfuBM
Message-ID: <CAADnVQJV5SMRvt_0YvdRdCys4oBR-x3baqBBmp1mxAeUx=EtJw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: fix uninitialized values in BPF_{CORE,PROBE}_READ
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 9:29=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/04/30 09:00AM, Andrii Nakryiko wrote:
> > On Tue, Apr 29, 2025 at 7:19=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > With the latest LLVM bpf selftests build will fail with
> > > the following error message:
> > >
> > >     progs/profiler.inc.h:710:31: error: default initialization of an =
object of type 'typeof ((parent_task)->real_cred->uid.val)' (aka 'const uns=
igned int') leaves the object uninitialized and is incompatible with C++ [-=
Werror,-Wdefault-const-init-unsafe]
> >
> > this is BPF-side code, what does C++ have to do with this, I'm confused=
...
>
> This I am not sure about why exactly, but clang (wihout ++) emits this wa=
rning
> now (try smth like `clang -c -x c - <<<'void foo(void) {const int x;}'`).
> When sending patch, I though that CORE* macros also can be used by ++ pro=
gs.
> For C, maybe, this is a problem with clang that it enables -Wdefault-cons=
t-init-unsafe?
>
> >
> > Also, why using __u8[] is suddenly ok, and using the actual type
> > isn't? Eventually it all is initialized by bpf_probe_read_kernel(), so
> > compiler is wrong or I am misunderstanding something... Can you please
> > help me understand this?
>
> So, when a const sneaks in, one have BPF_CORE_READ expanded into
> say smth like this:
>
>     ({
>     typeof(((parent_task)->real_cred->uid.val)) __r;
>     BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);
>     __r;
>     })
>
> It happens that real_cred is a pointer to const, so __r becomes const,
> and thus the warning (if enabled) is legit.
>
> With __u8 this turns into (let T =3D typeof(((parent_task)->real_cred->ui=
d.val)))
>
>     ({
>     __u8 __r[sizeof(T)];
>     BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);
>     * (T *) __r;
>     })
>
> So here we do not care if T is const or not, as __r is not in any case.

The problem with __u8 approach is that it's losing alignment.
Have you tried typeof_unqual instead ?
Modern gcc and clang support it directly.
For older compilers we have __unqual_typeof() in bpf_atomic.h

