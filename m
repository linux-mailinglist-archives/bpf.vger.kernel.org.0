Return-Path: <bpf+bounces-68412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0F2B583C2
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 19:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4720E7A631C
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 17:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861871B423C;
	Mon, 15 Sep 2025 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhcGmzzw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504041AC43A
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957731; cv=none; b=RvvyKzbbj/Q7gveUeyI0Ij6BjJBsg4QkbWvg7Cwm8ifAvq//NafE9Ryk3Jmrdh/AwDXy/qVNWtMhNKSHZ0Zs3AdI2NvPGTMIHJt98K4lOol2LCp+2eQb3MvjR5jmExdeK791YmV2yoig5j9mQofxwFpz4pwFHvWm+lEdVvj0Ty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957731; c=relaxed/simple;
	bh=tKNwCRlUpZ36n3BTOOlgDofzQ7eZY11rXLylLx7uYh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gf18vF8rb8UD7RmdL5iCIWu6/rZRsaMYBvIM9FQA5kMv/QAst7uXNX8LdE/uKmLhVTHupUXRmtIgJlK0mHpDg76sNSnAK54bZ7d8OFhK2J4wc7Z3TiR7TVItJP3m9Bn136C0hqF19n8XaETyIxdp6vvt+fjlBsq/OulHCHVjCx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhcGmzzw; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b04770a25f2so620592066b.2
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757957728; x=1758562528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nv1aIqk7sfxvuKZmrW4v6rYi91yLiWkJs5I1Zxeu8Vk=;
        b=bhcGmzzwl0Pr94PbJTeACfMw9OaqUtYxtQl7euAoQ3raP5DJiYuBPBerjNAJJtuv5Z
         5M3mjADssA5E0Z51Mret5gBjkOnyR8zwQl6WrkTw0CpUPjaRv4pa3JLDGBiI9Vi0cQ1s
         JI2qWaeOI7sAmDg57MNwpSkUA+EH/sJZJkau7kCWRj8OBof+5rdMbcle24iP6cJgyywN
         ZOYHpHLd4CTxQG2TJ7bPbR8OVTYTmyozDRphBJFcw0099L0F89eBGQ0WL/IUsSi4Aj1l
         CRm5NQdmrccKlhnk+nyVtisDIK1AXWWqQgip4wJciJLtNaEhJ9tG/Dp7db1zgZI75huj
         PTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757957728; x=1758562528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nv1aIqk7sfxvuKZmrW4v6rYi91yLiWkJs5I1Zxeu8Vk=;
        b=wr0p0Uf0IQmRKucvWMLalSgV97sMdHsnkt+48SD/gNbByniZlHlUuzGdw9hx7dBnf2
         w469f/AIoFMDt9inlJGtGAo4le0/yuQtdjy1FbneFfSE9naLAIfpBhu3k1C9DBnOY+Z2
         j4n7Y1m8T2X9H+P1nnbzs1hqdlKXdbcmqthH4fTRDn8YMZAkCnaL37JTRBQfMmZFbicP
         4JY7ow/yoB+/m83v9Crpx8F7Y/xU141h2mDwelLz65RF5T4Ebl5haZY9DuKY7u4AE8bc
         oyp8D1UN0p24ODg1DWZ+0UNgG7VicxNEX6f/WrvbpEcImp7XCnolIGEd8Zmhk4bx8Mez
         FI3w==
X-Gm-Message-State: AOJu0YzelfltBRUPinjlhm4a8kIsh/vvc4vNb5XbSGNc+VJutvvnQcOj
	XfROzKQDOOsEbBExwrgvJWIIEbIBN+CAV2j9Az8llvJar1MApmqYgGV/Sr6UR2qT/CHeF1fDy8b
	swQMZxoFWUiAi2OJxOcLwZugAzLn/8h4=
X-Gm-Gg: ASbGncvwWr59ebq/eDf/eKXLcGhjJT3H1EM4c+c2miNbnVuNbOML7I3WqQUrlLc3fdX
	TAVBD26OFyByEFa4BvILF3IO5MuXGek7aXkv+l3qQbTYwEcXNASFrUkr8Uzxch0RtYW9LkWwMkJ
	0FZHLhZQN57YhepgFOq3ypjGuKHNIWY8Vj07hCEk80phHZhmuZo1wqSTa0btR6Ow5w+de8d6yuf
	k9CNkwg6myp8EznOtg=
X-Google-Smtp-Source: AGHT+IEFWm/DjOGstWDBkbVQbX1ozDY2pjI97NPGF9H339Dp4pi32l2B55OYgA11xAxq0emsCfbwAqRAo8UfwSX1hyg=
X-Received: by 2002:a17:907:1c01:b0:b04:4d7a:8509 with SMTP id
 a640c23a62f3a-b07c38291f8mr1338197866b.36.1757957727394; Mon, 15 Sep 2025
 10:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915032618.1551762-1-memxor@gmail.com> <20250915032618.1551762-2-memxor@gmail.com>
 <CAADnVQ+3NdReC_urqC9bv+2y-kq8m+e-eMGOm-ht8qEQUHShpQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+3NdReC_urqC9bv+2y-kq8m+e-eMGOm-ht8qEQUHShpQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 15 Sep 2025 19:34:50 +0200
X-Gm-Features: AS18NWAp36-7SrJiPpasCZpybSNXqNHwDf1N1-OpNXzNwGyCJO_V4_GxG0zNDPM
Message-ID: <CAP01T77F4cdFGvRB8Y6pf8QuW+6uEu01L_S6eXe5yDBYkHNx-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not limit bpf_cgroup_from_id to
 current's namespace
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Dan Schatzberg <dschatzberg@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sept 2025 at 19:20, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 14, 2025 at 8:26=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > The bpf_cgroup_from_id kfunc relies on cgroup_get_from_id to obtain the
> > cgroup corresponding to a given cgroup ID. This helper can be called in
> > a lot of contexts where the current thread can be random. A recent
> > example was its use in sched_ext's ops.tick(), to obtain the root cgrou=
p
> > pointer. Since the current task can be whatever random user space task
> > preempted by the timer tick, this makes the behavior of the helper
> > unreliable.
> >
> > Refactor out __cgroup_get_from_id as the non-namespace aware version of
> > cgroup_get_from_id, and change bpf_cgroup_from_id to make use of it.
> >
> > There is no compatibility breakage here, since changing the namespace
> > against which the lookup is being done to the root cgroup namespace onl=
y
> > permits a wider set of lookups to succeed now. The cgroup IDs across
> > namespaces are globally unique, and thus don't need to be retranslated.
> >
> > Reported-by: Dan Schatzberg <dschatzberg@meta.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/cgroup.h |  1 +
> >  kernel/bpf/helpers.c   |  2 +-
> >  kernel/cgroup/cgroup.c | 24 ++++++++++++++++++++----
> >  3 files changed, 22 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> > index b18fb5fcb38e..b08c8e62881c 100644
> > --- a/include/linux/cgroup.h
> > +++ b/include/linux/cgroup.h
> > @@ -650,6 +650,7 @@ static inline void cgroup_kthread_ready(void)
> >  }
> >
> >  void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
> > +struct cgroup *__cgroup_get_from_id(u64 id);
> >  struct cgroup *cgroup_get_from_id(u64 id);
> >  #else /* !CONFIG_CGROUPS */
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index c0c0764a2025..51229aba5318 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2546,7 +2546,7 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64=
 cgid)
> >  {
> >         struct cgroup *cgrp;
> >
> > -       cgrp =3D cgroup_get_from_id(cgid);
> > +       cgrp =3D __cgroup_get_from_id(cgid);
>
> All makes sense to me.
>
> Should bpf cgroup iterator
> in kernel/bpf/cgroup_iter.c bpf_iter_attach_cgroup()
> also use __cgroup_get_from_id() version
> to allow iterating any cgroup ?
>
> That can be a follow up, of course.

I didn't change it because attach_target happens in a reliable context
of the process setting up the iterator, so it might make sense to
scope lookups to its cgroup namespace. init_seq_pidns in task_iter.c
seems to agree. That said, I'm not sure what our policy for BPF
iterators in general is, and whether they should be namespaced or not
by default.

