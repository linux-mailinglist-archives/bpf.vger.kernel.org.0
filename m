Return-Path: <bpf+bounces-68270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45194B55866
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 23:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A67AC13FC
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 21:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22A267B7F;
	Fri, 12 Sep 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/6KQG8q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC52BAF4
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712722; cv=none; b=C+IpoPanVJ9f+b5xKaeYP169AaHsUPTUWXQndpZtDkKWvFUGGflmH5tdg2iwFpfBshAaLKPbm+2krquznwt1wCnwhxxnU07IvFVpMSwboi7rmRl2bnWIU45x8s8PhwgXEPxJCpMCtQqcwVrLx/gfYLyBFnf/yids0yim9weQ+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712722; c=relaxed/simple;
	bh=nB05rLXKMtPtZrh57BZDQzQHznNp2IGoQ+Wq3Ewi4RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xwe3pYAguIYcytUPHgV/DZIYIYDGOagjwQVjUPuWiB+2fzbBttutuvkBj+vGMXbcj24JpsWUf6xy6y0zwmnubLzKwpikZADGG/xm2k/nysjF+TYZhxGu2aSabya2AiLChE0TU7L1GSlcPg8XQ4PQaSVJSVCW2DDDnypD94KVdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/6KQG8q; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3df726ecff3so1362312f8f.3
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 14:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757712719; x=1758317519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB05rLXKMtPtZrh57BZDQzQHznNp2IGoQ+Wq3Ewi4RQ=;
        b=O/6KQG8qcJZp8mV9uPxvobJ/CxjkfV42vkefJCmRv3MenK1O4JZ46KeUafH7Ipaq79
         F14Lh03VMzjFNwNRyPLXZ0gwh9hOB1vW3hxEuIibGLelGlQb5rWXJRKYAvVXL4xmCs3Y
         k5Xrj2gwTxyEOXFcuh1SJA6RcF3dkVrqKIFxKWLJL6fL1AhJYO7QFep2+5cHyNuUOosF
         GoaOVscfqmlONT9AnowzSgi59ss+J/U/rM2dSBYDFtQBG9BDjnYFXK/0CUdDJ8nGHENw
         C56xYR6i5O5r9TmjdkIuTFXKCmzRRlRAR9fcRfPne7JQz9gKk+LrFa4a9UUsz2nRDvhw
         uvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757712719; x=1758317519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nB05rLXKMtPtZrh57BZDQzQHznNp2IGoQ+Wq3Ewi4RQ=;
        b=rrHwO/Cd4LRMsx76Wm6K8h4OWQE+7ep5y/GiyEH/ZTiDTqBZPsNUqJmkyWlISWvfre
         JJ/lRDTTXt0vfb/BfA4r5rBjv/c1nlVdL9gwFI7yX9rS7zBgidm44EbpoNnxACjHIf9c
         JoSOuNpL7hJE42eBjUMF3ZmSZFrYtTn1kFJGgyVrq7kA7qwM5LhE2iZypKsYqk4u0Z9I
         eQxOkvlKM2WFPUfHBxUbPF1WWw3hMWFMv1n4B1Fx1K1UcWBb0z6ya23n9qbdn71PU6f2
         Qz75FRj7y+hKInQOBRXRdT+rgN6nrfyzSaR51NCyChjrjWzmQ1Gpa4Zzb1FlE+yi2h4W
         GKcA==
X-Forwarded-Encrypted: i=1; AJvYcCUG3CM128Ko7boMX0aeBNbvb5hMyF4xRDk4TFiayUg6XyHljcf/h4WqHcdECUXmspQIqkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzokIcN3xA6+043AGgFyl4FWXRaYIqQ+Ol4zYFgXJYJYUGkes+w
	1JMD6vC/WcqnY/8CWNBFjPL8aVmwL50IJ+xvMKRXGrV0XpMn+eP6ZSXgeDUa9sf7lOUPcye5TWv
	hY6kid0zbKf7TeKW494jiXtw8Xs3WS+8C9g==
X-Gm-Gg: ASbGnctnQFLlAIDiy81GJml4chv6rKj5rh+vkLi+u8rSHod2rGsy6Wdpy9h4s6j6Vmz
	VxKcqRKE2VdWWlZ4IHaIRBxKp8J/HncLwYQ/w1y2k5xzfVD599naeexbzeKts1rfu0YM2pxMgGi
	Ovhej1HHP21KeyFsIAdZxAJQwQQoZwm2NbxuPIlr1AqEroKxyC9t8p0Zg55jM+DN4wVLR5UeoVV
	OW7tb8RCnnMgEKWeD1/vFE0KMUqz6cTBqxnJpZGh2DcbeY=
X-Google-Smtp-Source: AGHT+IFUeMgQlf6fs6AORCntODMfu50pN2Us9+9v0ugPeBxALcefvSOo8Yzbnfmg1F1+efgTkLrMfu+7draX1MoM4pE=
X-Received: by 2002:a05:6000:250f:b0:3da:936b:95cf with SMTP id
 ffacd0b85a97d-3e7657a93b4mr4693306f8f.28.1757712718670; Fri, 12 Sep 2025
 14:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-6-alexei.starovoitov@gmail.com> <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
 <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
 <CAADnVQJu-mU-Px0FvHqZdTTP+x8ROTXaqHKSXdeS7Gc4LV9zsQ@mail.gmail.com> <shfysi62hb5g7lo44mw4htwxdsdljcp3usu2wvsjpd2a57vvid@tuhj63dixxpn>
In-Reply-To: <shfysi62hb5g7lo44mw4htwxdsdljcp3usu2wvsjpd2a57vvid@tuhj63dixxpn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Sep 2025 14:31:47 -0700
X-Gm-Features: AS18NWBW02h4cDWcOcjmf4PsYlNoMq0It-ylsFAZRRDqbaTi-aURNC-GRbMFqCw
Message-ID: <CAADnVQ+eD7p4i0B9Q2T-OS_n=AqcrrvYZGY57QOOqKEof6SkDQ@mail.gmail.com>
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 2:29=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Sep 12, 2025 at 02:24:26PM -0700, Alexei Starovoitov wrote:
> > On Fri, Sep 12, 2025 at 2:03=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Fri, Sep 12, 2025 at 12:27=E2=80=AFPM Shakeel Butt <shakeel.butt@l=
inux.dev> wrote:
> > > >
> > > > +Suren, Roman
> > > >
> > > > On Mon, Sep 08, 2025 at 06:00:06PM -0700, Alexei Starovoitov wrote:
> > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > >
> > > > > Since the combination of valid upper bits in slab->obj_exts with
> > > > > OBJEXTS_ALLOC_FAIL bit can never happen,
> > > > > use OBJEXTS_ALLOC_FAIL =3D=3D (1ull << 0) as a magic sentinel
> > > > > instead of (1ull << 2) to free up bit 2.
> > > > >
> > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > Are we low on bits that we need to do this or is this good to have
> > > > optimization but not required?
> > >
> > > That's a good question. After this change MEMCG_DATA_OBJEXTS and
> > > OBJEXTS_ALLOC_FAIL will have the same value and they are used with th=
e
> > > same field (page->memcg_data and slab->obj_exts are aliases). Even if
> > > page_memcg_data_flags can never be used for slab pages I think
> > > overlapping these bits is not a good idea and creates additional
> > > risks. Unless there is a good reason to do this I would advise agains=
t
> > > it.
> >
> > Completely disagree. You both missed the long discussion
> > during v4. The other alternative was to increase alignment
> > and waste memory. Saving the bit is obviously cleaner.
> > The next patch is using the saved bit.
>
> I will check out that discussion and it would be good to summarize that
> in the commit message.

Disgaree. It's not a job of a small commit to summarize all options
that were discussed on the list. That's what the cover letter is for
and there there are links to all previous threads.

