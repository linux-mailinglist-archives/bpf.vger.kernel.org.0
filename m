Return-Path: <bpf+bounces-20337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F8883CA63
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 18:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC81C29976A
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913D7133414;
	Thu, 25 Jan 2024 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="aoXEkDZo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85B13173D
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205560; cv=none; b=F0f2xfd2VYySiPg/iPdbzMLG70R+5h9FRUcsIPrjzHFu/S+dENhJGWOF7rd/QHrIB3AYN52pLIH3gPTHlVqcoZKRDtWVDEzVovbOxcnT9PukV+/mZ35LvKNV2Gk2fQpA7/TOf8mG4cJhtFrVwksZM9rx7iGC3bpg15Yx/1LDMEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205560; c=relaxed/simple;
	bh=HokMkpatYTT/5LYDKqsKvPpXb82sP0M5dZRdwLr8phI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtulhjNZsSCL0P/hTkQPU81uvN6fsJy3UZM06nC83io/X5nPTL8DqnmQ4MoLSeSuCHNEomjxTlgdpR2a5wfHwzPo6vJt0oC+wfG0Qd7xef89z3GLauwIezPh+whI27cnG+FkgttQY5usav2pu9Brdal+2c0VFRcCslLftdUYOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=aoXEkDZo; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5ebca94cf74so69202587b3.0
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 09:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706205557; x=1706810357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opjATsJuWVgGXtTi8L7n0XRJuMOSvz9YdFs6O7o9uKM=;
        b=aoXEkDZoZogjvJ1jQq6d6gxpWTkgys4xZ5P5/dX6T3/d5VTwsCFfVdtsEzGOWFK2Yx
         MT8ktVcMRl3lEhs4hwRNhp59yiIfLATxtpv72VxSo2uxG7tNeZn/yJB+GZzFr471sS+h
         6mkXfrrR1wQg5Xm+/mQ7JSZ2YrYEG/39fChzuNjyLJ88jGge22ZTld5UeSf6SSO36G6c
         pD1bry4BiQhmoZhuen5XHjapInOjc/qcCzz4wZRl0ME28u2iszDTzsD0+JKx6XLIsAv5
         0hr0l8nBfgte59x6NZbNKjo9cV/QXjDOAtBx1DSwxxN2kipl3pEBTNh0m+SDshNHg2FM
         M87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706205557; x=1706810357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opjATsJuWVgGXtTi8L7n0XRJuMOSvz9YdFs6O7o9uKM=;
        b=Vjc07jK9BV/Zh3EZaoG88lf+mwTnxDip56f7Bk1R5GccOSQQoo5Ku87CHrzcp0gS5E
         WVGz4EBRRaNT10PS7CDL2nxrJ8UUpJv8ngZ8XTeJZ7xUjKD9P8WIFbc2szcNv6ZZS+Se
         DZbpOjJoo2o/RVb6L9JBmhY9/hSWau1AAHAHXSw4BFpCgguu0BToUhVNvUVmnAJ8/DH7
         3PiCwP44wUIuMzyUqDwrH9oFh4NYQn3T3BlGm3vrFN574ZDYuTe4qWorr/mKcPMt3I6O
         e2I2i1KkXqkp+jLH8T06a+Rdm0ha1KMrX+b6hR6Nr5BWYQhmscXL3OnHCZdUgWcyYQvN
         D+/g==
X-Gm-Message-State: AOJu0Yx573zYrB+rk6ulYiQrouQqiOrU7Utv7RY9VMNx16An/TO5Zx6/
	zfQ5g1Kj7vAIaPuAcIztlKqt9lq599L9XTKUIqZ0b1UhL/QKOvjyOtIsNI7wsTVc/SBQDzxoc3c
	bVyyzgNzjSZZD8c84nqngvQ/4h7xkNDbqZbZQtXGncfGAj/o4Eg==
X-Google-Smtp-Source: AGHT+IGowX0N08oawtn0KVs5HNCBLreoSrbxiEirCSRM/mLryIU4XmEt0t4iRjISyBGuukOKp9GGcXndPPoCtPmx7kg=
X-Received: by 2002:a25:8246:0:b0:dc3:6b67:4998 with SMTP id
 d6-20020a258246000000b00dc36b674998mr167283ybn.114.1706205557120; Thu, 25 Jan
 2024 09:59:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-16-jhs@mojatatu.com>
 <6841ee07-40c6-9a67-a1a7-c04cbff84757@iogearbox.net> <CAM0EoMnjEpZrajgfKLQhsJjDANsdsZf3z2W8CT9FTMQDw2hGMw@mail.gmail.com>
 <a567ac93-2564-2235-b65f-d0940da076a5@iogearbox.net>
In-Reply-To: <a567ac93-2564-2235-b65f-d0940da076a5@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 25 Jan 2024 12:59:04 -0500
Message-ID: <CAM0EoM=XPJ96s3Y=ivrjH-crGb6hRu4hi90WB-O_SkxvLZNYpQ@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 15/15] p4tc: add P4 classifier
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:47=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 1/24/24 3:40 PM, Jamal Hadi Salim wrote:
> > On Wed, Jan 24, 2024 at 8:59=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> On 1/22/24 8:48 PM, Jamal Hadi Salim wrote:
> [...]
> >>>
> >>> It should also be noted that it is feasible to split some of the ingr=
ess
> >>> datapath into XDP first and more into TC later (as was shown above fo=
r
> >>> example where the parser runs at XDP level). YMMV.
> >>> Regardless of choice of which scheme to use, none of these will affec=
t
> >>> UAPI. It will all depend on whether you generate code to load on XDP =
vs
> >>> tc, etc.
> >>>
> >>> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> >>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >>> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> >>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>
> >> My objections from last iterations still stand, and I also added a nak=
,
> >> so please do not just drop it with new revisions.. from the v10 as you
> >> wrote you added further code but despite the various community feedbac=
k
> >> the design still stands as before, therefore:
> >>
> >> Nacked-by: Daniel Borkmann <daniel@iogearbox.net>
> >
> > We didnt make code changes - but did you read the cover letter and the
> > extended commentary in this patch's commit log? We should have
> > mentioned it in the changes log. It did respond to your comments.
> > There's text that says "the filter manages the lifetime of the
> > pipeline" - which in the future could include not only tc but XDP but
> > also the hardware path (in the form of a file that gets loaded). I am
> > not sure if that message is clear. Your angle being this is layer
> > violation. In the last discussion i asked you for suggestions and we
> > went the tcx route, which didnt make sense, and  then you didnt
> > respond.
> [...]
>
> >> Also as mentioned earlier I don't think tc should hold references on
> >> XDP programs in here. It doesn't make any sense aside from the fact
> >> that the cls_p4 is also not doing anything with it. This is something
> >> that a user space control plane should be doing i.e. managing a XDP
> >> link on the target device.
> >
> > This is the same argument about layer violation that you made earlier.
> > The filter manages the p4 pipeline - i.e it's not just about the ebpf
> > blob(s) but for example in the future (discussions are still ongoing
> > with vendors who have P4 NICs) a filter could be loaded to also
> > specify the location of the hardware blob.
>
> Ah, so there is a plan to eventually add HW offload support for cls_p4?
> Or is this only specifiying a location of a blob through some opaque
> cookie value from user space?

Current thought process is it will be something along these lines (the
commit provides more details):

tc filter add block 22 ingress protocol all prio 1 p4 pname simple_l3 \
   prog type hw filename "mypnameprog.o" ... \
   prog type xdp obj $PARSER.o section parser/xdp pinned_link
/sys/fs/bpf/mylink \
   action bpf obj $PROGNAME.o section prog/tc-ingress

These discussions are still ongoing - but that is the current
consensus. Note: we are not pushing any code for that, but hope it
paints the bigger picture....
The idea is the cls p4 owns the lifetime of the pipeline. Installing
the filter instantiates the p4 pipeline "simple_l3" and triggers a lot
of the refcounts to make sure the pipeline and its components stays
alive.
There could be multiple such filters - when someone deletes the last
filter, then it is safe to delete the pipeline.
Essentially the filter manages the lifetime of the pipeline.

> > I would be happy with a suggestion that gets us moving forward with
> > that context in mind.
>
> My question on the above is mainly what does it bring you to hold a
> reference on the XDP program? There is no guarantee that something else
> will get loaded onto XDP, and then eventually the cls_p4 is the only
> entity holding the reference but w/o 'purpose'. We do have BPF links
> and the user space component orchestrating all this needs to create
> and pin the BPF link in BPF fs, for example. An artificial reference
> on XDP prog feels similar as if you'd hold a reference on an inode
> out of tc.. Again, that should be delegated to the control plane you
> have running interacting with the compiler which then manages and
> loads its artifacts. What if you would also need to set up some
> netfilter rules for the SW pipeline, would you then embed this too?

Sorry, a slight tangent first:
P4 is self-contained, there are a handful of objects that are defined
by the spec (externs, actions, tables, etc) and we model them in the
patchset, so that part is self-contained. For the extra richness such
as the netfilter example you quoted - based on my many years of
experience deploying SDN - using daemons(sorry if i am reading too
much in what I think you are implying) for control is not the best
option i.e you need all kinds of coordination - for example where do
you store state, what happens when the daemon dies, how do you
graceful restarts etc. Based on that, if i can put things in the
kernel (which is essentially a "perpetual daemon", unless the kernel
crashes) it's a lot simpler to manage as a source of truth especially
when there is not that much info. There is a limit when there are
multiple pieces (to use your netfilter example) because you need
another layer to coordinate things.

Re: the XDP part - our key reason is mostly managerial, in that the
filter is the lifetime manager of the pipeline; and that if i dump
that filter i can see all the details in regards to the pipeline(tc,
XDP and in future hw, etc) in one spot. You are right, the link
pinning is our protection from someone replacing the XDP prog (this
was a tip from Toke in the early days) and the comparison of tc
holding inode is apropos.
There's some history: in the early days we were also using metadata
which comes from the XDP program at the tc layer if more processing
was to be done (and there was extra metadata which told us which XDP
prog produced it which we would vet before trusting the metadata).
Given all the above, we should still be able to hold this info without
necessarily holding the extra refcount and be able to see this detail.
So we can remove the refcounting.

cheers,
jamal

> Thanks,
> Daniel

