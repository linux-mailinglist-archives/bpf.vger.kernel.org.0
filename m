Return-Path: <bpf+bounces-69106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AEDB8CC57
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 17:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 343407A4EC3
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E6B2F7ABD;
	Sat, 20 Sep 2025 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2+N4XCv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66FB22541C
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758383691; cv=none; b=R6UC2TKHZukokuU6cPLcyngu7wye/EYSFTzfQ/saNPs46pXm+fFHXEzxKPhh5VeR8k2t1kqS/9js5A8fgAOqb0w90tJzpWfjvQ52HY1imFi+JolegVpHjyJH+IQ3PzWtEUPK5PC0cd7Oc6zsY7pPOtJkl+5PM1w3bGh4xYO48SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758383691; c=relaxed/simple;
	bh=hfAsZRGtQxjHaSqZBdycaABnPajls0rryhOYAO/rtVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXVM6SD233Cp+jED5evKKN51vJ7FyhCm6XmBf6Wej2Lyrmjh00bDg22rojbvC2NxJT0vqP8AeZpOI/BDd3H0MKcvpwSQfSLLmLSvmAIkYVJmDpJUSgKuID7XM0sthdigfbPFXG/1aaXBcjppoLO9Eh/KHoQamahWUoFobUmALqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2+N4XCv; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so1128378f8f.3
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758383686; x=1758988486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmL4fKaZHfu9Rove6sJqAWTVy87f5w83yGb6oPzqQsA=;
        b=E2+N4XCvwiNd5ASDO6TlAyD5DmG/mn3l+j6aGgKQDWMVqUJD8wOydA6eHIR2aWr2Gf
         kc1shBe7jfkeOGLdqmt5kcBuEKm4FtrjWAl/MMy3UVCfajq7PKXqPymEcDqAYfWy2mYP
         cGqYIJ9J6+oXKmMemI9KzUi+wrBU6XyQiH6QS6OiUhcQjEsydAa8wVdGg+R+0I9UMZvA
         x52smszhOkg5lEixmVVIfcXar8kqlQgMaKF7Z2PGkMFPpXk6pQQM4sypHfa8wFGbyFj9
         +o/dEM9nS//A64Li5/wAjEcv8DxgJfENmbayqw0Mf6T1jmyQ/tR2v9qsDlbU4BcVR5Zd
         dy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758383686; x=1758988486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmL4fKaZHfu9Rove6sJqAWTVy87f5w83yGb6oPzqQsA=;
        b=Nx9m8rYfL41NtYO8asmdli+TyklkTHngDMHugKNhcJ//xiuA9txvoCi2srbAwz80qD
         mwEw4NCaMGVcxPftG3RR6XPrH3wJh+SLUyXOKidv+p3RxKjZFS6OmCbVRagBWG/bCB47
         PoAMzeeF4VuIMDJfpPApr1f4Dq6tB+JzjfFni3t+Y0dfg+DUFRs9Z8fbQ9rdT798EVW2
         Xf/H8lsv0JUJjq7Y72rCBeXIRSOIhVbrJIWuPFdrc+5fVyh7Pc4vLqqoHZwufXk/o+f7
         zUrCrBKmFy0NwVhqdVNU0Z2kyKsOAWRsYWkNu23TDaH6x2yUOo6AGvvpBmWN1ZdId1p3
         AocQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK2QJmyuerx2CbZBzwZPrP2cCSzygyeXaeDvH1QAZRRv5mHGhAepoGmp0RMrpt9RH3MaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpKItxN+EbBF9eC6MnER90M4yc9i69ivFXyIGZ4H/cvSahRTtP
	6Di3kUe4FnTCk16Q4UxHZLUgUabwLgeMEJAuespK2tbh0q2B75lshHxC6zyN0Ez+V7xd63qY/oT
	vnen72/lMz8MzhBHKVmd/u2vDQs2rbNJSrlVM
X-Gm-Gg: ASbGncuoS9TUWDo6vfM9XrwRo1ZH+Ayhb2o3QEqDpanDbS/qvoGl6ZAEV4c5+Q2sRng
	N/4DUzdwx7fTdLNc46oWbvSG+DvqAoSXVs15BQ+AJrxbe5sBdQr7G+2q3Atq/xPW41kvmAtbG5X
	m0Pk40gZNIGJNKecR4hw0uYsxwlQroqlg5hyhYZOcdo7jdb5gi947LcHuMoAEj6Gzp5ulSLSN+S
	+FQLlchV4oKVuGE5v9nefZLKL3EgSuaH+0A
X-Google-Smtp-Source: AGHT+IGfSRPp5unU0ikqgKe6L71mc7gqY7OrcTaOXCxInbx+GrRtbs1vqbP9ZDrhOUBg5/YKgmUImu9rrpRpu5dArLE=
X-Received: by 2002:a05:6000:1789:b0:3ee:154e:4f9 with SMTP id
 ffacd0b85a97d-3ee7d0c8af1mr7055134f8f.20.1758383685795; Sat, 20 Sep 2025
 08:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <5qi2llyzf7gklncflo6gxoozljbm4h3tpnuv4u4ej4ztysvi6f@x44v7nz2wdzd>
 <CAADnVQK_wvu-KBgF6dNq=F5qNk-ons-w3UenJNaew6h9qTBpGw@mail.gmail.com> <eba3aiglp2hmj65sd4vsmav26o45orrlog2ifexd44yovygcdg@43wfk6dbgqda>
In-Reply-To: <eba3aiglp2hmj65sd4vsmav26o45orrlog2ifexd44yovygcdg@43wfk6dbgqda>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 20 Sep 2025 08:54:34 -0700
X-Gm-Features: AS18NWC4-3QCvE4i9hUGZd-7Pyusy_D5tB_ZRka07Www2wvdZZcy7N-fgfJJ47M
Message-ID: <CAADnVQJF-JodmrfqJzwfpaK1wjmo6-4_R-cdUfu9ZFN52zxEsA@mail.gmail.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Peilin Ye <yepeilin@google.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:31=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Sep 19, 2025 at 07:47:57PM -0700, Alexei Starovoitov wrote:
> > On Thu, Sep 18, 2025 at 7:49=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> [...]
> > > +
> > > +static DEFINE_PER_CPU(struct defer_memcg_events, postpone_events) =
=3D {
> > > +       .memcg_llist =3D LLIST_HEAD_INIT(memcg_llist),
> > > +       .work =3D IRQ_WORK_INIT(process_deferred_events),
> > > +};
> >
> > Why all these per cpu stuff ? I don't understand what it helps with.
> > To have max_events per-cpu?
> > Just one global llist and irq_work will do just fine.
> > and global max_events too.
>
> Right, global llist and irq_work will work but max_events has to be
> per-memcg. In addition we will need llist_node per-memcg and I think we
> will need to do a similar cmpxchg trick I did in css_rstat_updated() to
> eliminate the potential race of llist_node of a given memcg i.e.
> multiple CPUs trying to add llist_node of a memcg to the global llist.

ohh. that cmpxchg is quite unusual. Never seen anything like that.
I'm not convinced it's correct either.
I would replace that with traditional:
if (!atomic_xchg(&c->enqueued, 1))
   if (llist_add(&c->llnode, &global_llist))
     irq_work_queue(&global_irq_work);

and use traditional dequeue:

nodes =3D llist_del_all(&global_llist);
for_each(nodes) {
  memcg_memory_event(c, MEMCG_MAX);
  atomic_set(&c->enqueued, 0);
}

since llist_del_first_init() is slower.

max_events still looks unnecessary to me.

> This can work but I am still debating if this additional complexity is
> worth it as compared to the original patch where we skip
> cgroup_file_notify() for !allow_spinning condition.

I would skip it too. deferral doesn't seem necessary.

