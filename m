Return-Path: <bpf+bounces-68268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE03DB55854
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 23:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4170B161E0E
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 21:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA9E25CC74;
	Fri, 12 Sep 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xw/F4P/O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D225785A
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712378; cv=none; b=rauxGCKBxJnGi1blm6FuLhYQ/yEcUccvrNbdmaJYbqU6Gg9bHDpO5iBQLGVSLOtxSm3bJjatBJVdz5AFglmguKsa5X2MTRXtHiWdR83jyU3X94QIzzumunPxSTw4JVEKInCd5PmNdZJ3VPWJIXZ9qmFDSxF5WnuLFaGCgllqBi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712378; c=relaxed/simple;
	bh=JEixxtEhxPjlS959xRf/vx8gj9Z6JTLECQKNsA1zBr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=norsyQHupyY73TOUKlvwkNLUSdDGoll2ITweQmJ7Dpuh7A63RyPDmXBGiZgdyuIztFDyp3tXk2nYux/pmPCeN4iwUcnOFY2mfAbXyulBNRTSpBGEGQFOAmgidiEYd+Eq54lEWuTPvDbjnbnq8aTsDN1wf6f9GX7yE1g3AvsyATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xw/F4P/O; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b48fc1d998so29191cf.1
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 14:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757712376; x=1758317176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvKdVbyifmMQtLiLEuJNO0oLY6w9M5FF6iZOtodu0JE=;
        b=xw/F4P/O4A0dtIpiHYE1rskui7XucGrvm5s5FMRPX9j6cvcuQ5yFDLWQ/bAoXG/5la
         dBPyfY58UlZ96zB7Us1/RGhhK5KYpns62YHBYmuZo8xXvXYCFquJ+QmnCkWrOUh7iQt8
         RgoykzelWoF+yGYjhw6JJSI9XQxtCet2o10YKLXePwwCOpXOnF8IlhEyHhU3bUJrdXZ4
         EuSw0uBbhPcax/yGS4f2mO8GnU4wZV6fqqhTjxZ2slgJTCKGomdkW4xLrcWmxuf3I8lJ
         yJoRKYB+eIVWFOkGropGZx0M7Mreg+g7ruXU9/Ruk41Mr73Nn1nTanTG6pS68eYG3OvL
         pT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757712376; x=1758317176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvKdVbyifmMQtLiLEuJNO0oLY6w9M5FF6iZOtodu0JE=;
        b=jFgi7Lftd54KdglubfFnW8jlz8RTyYnkbrdk1ky9e5/NfusruKs+gsJ4pz4DjTkXPv
         YFuYgfFcpMab1qtnML83TLdANZdicu8D4F+XwEjc/U4pRrXxNNDtY+FcggSCKfFPexFs
         Cid0ftnyIHT0yDbD7vNGj9D1MtfBNMvEKsjOowpsF0vNoYX2qVNJJKH7vbSc214eLjyv
         uethcf024Ldty04b2GjlqK+Zfipw8UT5/K0uBzf68na8DASZvg8VgXid2LmU9hDhFcRY
         4eJtVx/zgxDO5hSd8F6MsWGBmoRTGu3juDLi3OmccCCOX/nIrs3d1G/NwtXfow1nbI8T
         1mDA==
X-Forwarded-Encrypted: i=1; AJvYcCWAuETAGboBThtWwFdhWg2hEejlVKWfAG6JtB8CXdzjnLWIeGaicJGkqp5sRIZbRcCtFUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAf30tynjQBkuag/sjilhe0CA1pnteePxDLdPLbRfFReZkTDa9
	KW340yr/SfNSh+LP1gc0rlBD1BpYVYz7mCf5xWswklOFk/F9wLRT7YhcjTmN7AS9Km5T54BUxu3
	mYsTsZf3si1pFa8B+R69MTxqS1J/La6qwuU29lkfL
X-Gm-Gg: ASbGnctU9MlXigvLB6uwcZRVeZmQXxJbA77LjO1jXplxdM6paOSAkh4KxiwEllPl6Ag
	UtD+UdDiwd9EChEHdd35cOnhNyN6NrR787zf3dbh+3WBpDOofhJ/pbaj5UbNwbU9+S/EK2CYHgZ
	ulNLsGZgDt6YHH0SPEBjlOcx48Uy+IPc4hdemz4fEprp6CUhag69WGGaMd32LwD6JZKoSl5RUiC
	vgbe0ZdrGl+dmraaLu5obE=
X-Google-Smtp-Source: AGHT+IFSuL7CTzS4gEZSpO1X8g5FeeNt+3kp261icCkCLwm42ah7q7mBs5KzeZelGn9VF9fWNCIiTNhUC/wH74GMWkg=
X-Received: by 2002:ac8:5906:0:b0:4b3:8ee:521b with SMTP id
 d75a77b69052e-4b78c7452cbmr493111cf.0.1757712375514; Fri, 12 Sep 2025
 14:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-6-alexei.starovoitov@gmail.com> <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
 <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com> <avhakjldsgczmq356gkwmvfilyvf7o6temvcmtt5lqd4fhp5rk@47gp2ropyixg>
In-Reply-To: <avhakjldsgczmq356gkwmvfilyvf7o6temvcmtt5lqd4fhp5rk@47gp2ropyixg>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Sep 2025 14:26:03 -0700
X-Gm-Features: AS18NWCT3yKzoCb64MG-xR1etkq8v64TAfWEV1zPfnX4dNeKLRbKwfi5_tlAVvc
Message-ID: <CAJuCfpGPcDUEd0A6jf=pmMkkF019JXGk9GxEPE6iTHOdp8+Xww@mail.gmail.com>
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	vbabka@suse.cz, harry.yoo@oracle.com, mhocko@suse.com, bigeasy@linutronix.de, 
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org, 
	peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 2:12=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Sep 12, 2025 at 02:03:03PM -0700, Suren Baghdasaryan wrote:
> [...]
> > > I do have some questions on the state of slab->obj_exts even before t=
his
> > > patch for Suren, Roman, Vlastimil and others:
> > >
> > > Suppose we newly allocate struct slab for a SLAB_ACCOUNT cache and tr=
ied
> > > to allocate obj_exts for it which failed. The kernel will set
> > > OBJEXTS_ALLOC_FAIL in slab->obj_exts (Note that this can only be set =
for
> > > new slab allocation and only for SLAB_ACCOUNT caches i.e. vec allocat=
ion
> > > failure for memory profiling does not set this flag).
> > >
> > > Now in the post alloc hook, either through memory profiling or throug=
h
> > > memcg charging, we will try again to allocate the vec and before that=
 we
> > > will call slab_obj_exts() on the slab which has:
> > >
> > >         unsigned long obj_exts =3D READ_ONCE(slab->obj_exts);
> > >
> > >         VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS), =
slab_page(slab));
> > >
> > > It seems like the above VM_BUG_ON_PAGE() will trigger because obj_ext=
s
> > > will have OBJEXTS_ALLOC_FAIL but it should not, right? Or am I missin=
g
> > > something? After the following patch we will aliasing be MEMCG_DATA_O=
BJEXTS
> > > and OBJEXTS_ALLOC_FAIL and will avoid this trigger though which also
> > > seems unintended.
> >
> > You are correct. Current VM_BUG_ON_PAGE() will trigger if
> > OBJEXTS_ALLOC_FAIL is set and that is wrong. When
> > alloc_slab_obj_exts() fails to allocate the vector it does
> > mark_failed_objexts_alloc() and exits without setting
> > MEMCG_DATA_OBJEXTS (which it would have done if the allocation
> > succeeded). So, any further calls to slab_obj_exts() will generate a
> > warning because MEMCG_DATA_OBJEXTS is not set. I believe the proper
> > fix would not be to set MEMCG_DATA_OBJEXTS along with
> > OBJEXTS_ALLOC_FAIL because the pointer does not point to a valid
> > vector but to modify the warning to:
> >
> > VM_BUG_ON_PAGE(obj_exts && !(obj_exts & (MEMCG_DATA_OBJEXTS |
> > OBJEXTS_ALLOC_FAIL)), slab_page(slab));
> >
> > IOW, we expect the obj_ext to be either NULL or have either
> > MEMCG_DATA_OBJEXTS or OBJEXTS_ALLOC_FAIL set.
> > >
> > > Next question: OBJEXTS_ALLOC_FAIL is for memory profiling and we neve=
r
> > > set it when memcg is disabled and memory profiling is enabled or even
> > > with both memcg and memory profiling are enabled but cache does not h=
ave
> > > SLAB_ACCOUNT. This seems unintentional as well, right?
> >
> > I'm not sure why you think OBJEXTS_ALLOC_FAIL is not set by memory
> > profiling (independent of CONFIG_MEMCG state).
> > __alloc_tagging_slab_alloc_hook()->prepare_slab_obj_exts_hook()->alloc_=
slab_obj_exts()
> > will attempt to allocate the vector and set OBJEXTS_ALLOC_FAIL if that
> > fails.
> >
>
> prepare_slab_obj_exts_hook() calls alloc_slab_obj_exts() with new_slab
> as false and alloc_slab_obj_exts() will only call
> mark_failed_objexts_alloc() if new_slab is true.

Sorry, I missed that detail. I think mark_failed_objexts_alloc()
should be called there unconditionally if vector allocation fails.

>
> > >
> > > Also I think slab_obj_exts() needs to handle OBJEXTS_ALLOC_FAIL expli=
citly.
> >
> > Agree, so is my proposal to update the warning sounds right to you?
>
> Yes that seems right to me.

