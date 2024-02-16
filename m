Return-Path: <bpf+bounces-22183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AAA8587DA
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 22:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391FD1F22ABC
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 21:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F5145FE5;
	Fri, 16 Feb 2024 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="uCwC4LRW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691C12BEA5
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118326; cv=none; b=kKTFR0sLDSP/6fk0cAbjZ5MdezBczIhtfZsc1uJdysrD0Y7Mc+fohTOxk0x/32jUnrOKDK5eyCalgsb8bpeQcIsyyuzLXaxzjfCRpceFgJ5ML6gpb+CtRoYnrjQuMmZn7JlFvZny4f/lA0VYDZb6IdLaGD/2+QALoTG7WZukPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118326; c=relaxed/simple;
	bh=R5J9/38m4huGVzj6VnbfWK8LZpvdu5bP507wckFn6vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAIjbnnS2Dj08jKNVv/57TWd1saFCY11i/nS9Nypw1tigt0RpCB093l3msahad1sgNxT5HMfKWMy5/si4yCiu0KyL3DRAjhpnbLyGh+NZaFwawwNuzDVpGwcZti6s1Bc6cDVr1hlHHTIt+XV2sbkdBOwRJA1vNCyDH0LXVdjeus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=uCwC4LRW; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6080a19ea1cso4241347b3.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 13:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708118323; x=1708723123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0ALIyLJQOD7Y1oSXLJGwwO+HUyvfSbunY9m+pRm/cs=;
        b=uCwC4LRWWkfp6XCpKk2r+GSMXUdJf2rE8wxsLUQYCHh93xDWvZTbITiTW9RV6Y403/
         1hab6/Wre95g3mgTFa5XwqfxaSaVq4wq4srjSV+t4OVvWcXvycnUmba9beLRHauS4fMh
         OfM2RUbHAMscAM/MwH2BYuTnuAlBaddNOovIx0PX7igTtzV/OKp/DnHblxdo5nYE8vrW
         q4u/ZJ/UaaEBlOGSZ5Y0UIeHbt1AgVGpbfaa1ZNp5/y5pK9j0vlnUofKqxEKOG6DysL1
         +qas8DcyZAVnlw6oNQn5Z8K+nfHnUAWXi6kdw+AJStROs9s/i5U4O3VXO7AbHiXEWk1A
         nwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708118323; x=1708723123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0ALIyLJQOD7Y1oSXLJGwwO+HUyvfSbunY9m+pRm/cs=;
        b=iOW7vSwtdlkdnj3D4NT1VhJ5uiHGDO558lR8uKMsbdaJkxe7xJr2yDYZ4d33bvJOaG
         Jw9DIrpIZAfNTjSJs4ixJ4JogDPTnZEIAAJvrZ4n46sUeU82k/9/UGbM08Qr2VlHiufq
         D0VXNNdKEhA2aa4bcGYygwKziWnA4CWBaFgLNr6hd2KPhnize77+xLE35pUarHI9zN0O
         5pS1xspNsLVSsCQF4NRFsfeNv6blK2AAuD1GnNA/tIwWsWZ1sd2VO4umiukrk2Jdpq0B
         dYNGypUQ29niOhgFUsJEywSRbio5wQGd+/TmUshcnKVeUvv5nowvYsRIcm/FaAQvV12w
         lnaw==
X-Forwarded-Encrypted: i=1; AJvYcCUTT+Iz2lTHVPSbB/N3Ku6MpqpoUyO4yTwkcpWoObSGFpOpvZBGDkTEmpvQOIqOwTDcghE8UmrUcj5R4hW7aXkxOZcr
X-Gm-Message-State: AOJu0YyEh1JwDyD/kyBTITS4ax6e5t3Y/USxj9yD/JO5g/YVgnlvl7lT
	ZgnPy2aJndvSNkmG5KfCNVV0PMaS3eoG07CIvx20OC/gN+lTRAcvxxUKyiWAUmjP5o8yu7/NiNi
	25rl9pAdIggaPOl8rUepxtoxCy472+24oq9ch
X-Google-Smtp-Source: AGHT+IEWv6uh5bOVz9Y/JJpHWRPR9H86cGzqsIav8/KYbYNZDCULR1sXVJhtTaXjNLWlN1c4KpFkWgXITxioJ+mau6I=
X-Received: by 2002:a81:4902:0:b0:607:ce8e:fe26 with SMTP id
 w2-20020a814902000000b00607ce8efe26mr6050567ywa.14.1708118321976; Fri, 16 Feb
 2024 13:18:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-16-jhs@mojatatu.com>
 <6841ee07-40c6-9a67-a1a7-c04cbff84757@iogearbox.net> <CAM0EoMnjEpZrajgfKLQhsJjDANsdsZf3z2W8CT9FTMQDw2hGMw@mail.gmail.com>
 <a567ac93-2564-2235-b65f-d0940da076a5@iogearbox.net> <CAM0EoM=XPJ96s3Y=ivrjH-crGb6hRu4hi90WB-O_SkxvLZNYpQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=XPJ96s3Y=ivrjH-crGb6hRu4hi90WB-O_SkxvLZNYpQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 16 Feb 2024 16:18:30 -0500
Message-ID: <CAM0EoM=TfDESv=Ewsf_HM3aN+p+718DXoVm-vvmz+5+7-9z3dQ@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 15/15] p4tc: add P4 classifier
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com, bpf@vger.kernel.org, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:59=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Jan 25, 2024 at 10:47=E2=80=AFAM Daniel Borkmann <daniel@iogearbo=
x.net> wrote:
> >
> > On 1/24/24 3:40 PM, Jamal Hadi Salim wrote:
> > > On Wed, Jan 24, 2024 at 8:59=E2=80=AFAM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> > >> On 1/22/24 8:48 PM, Jamal Hadi Salim wrote:
> > [...]
> > >>>
> > >>> It should also be noted that it is feasible to split some of the in=
gress
> > >>> datapath into XDP first and more into TC later (as was shown above =
for
> > >>> example where the parser runs at XDP level). YMMV.
> > >>> Regardless of choice of which scheme to use, none of these will aff=
ect
> > >>> UAPI. It will all depend on whether you generate code to load on XD=
P vs
> > >>> tc, etc.
> > >>>
> > >>> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > >>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > >>> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> > >>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > >>
> > >> My objections from last iterations still stand, and I also added a n=
ak,
> > >> so please do not just drop it with new revisions.. from the v10 as y=
ou
> > >> wrote you added further code but despite the various community feedb=
ack
> > >> the design still stands as before, therefore:
> > >>
> > >> Nacked-by: Daniel Borkmann <daniel@iogearbox.net>
> > >
> > > We didnt make code changes - but did you read the cover letter and th=
e
> > > extended commentary in this patch's commit log? We should have
> > > mentioned it in the changes log. It did respond to your comments.
> > > There's text that says "the filter manages the lifetime of the
> > > pipeline" - which in the future could include not only tc but XDP but
> > > also the hardware path (in the form of a file that gets loaded). I am
> > > not sure if that message is clear. Your angle being this is layer
> > > violation. In the last discussion i asked you for suggestions and we
> > > went the tcx route, which didnt make sense, and  then you didnt
> > > respond.
> > [...]
> >
> > >> Also as mentioned earlier I don't think tc should hold references on
> > >> XDP programs in here. It doesn't make any sense aside from the fact
> > >> that the cls_p4 is also not doing anything with it. This is somethin=
g
> > >> that a user space control plane should be doing i.e. managing a XDP
> > >> link on the target device.
> > >
> > > This is the same argument about layer violation that you made earlier=
.
> > > The filter manages the p4 pipeline - i.e it's not just about the ebpf
> > > blob(s) but for example in the future (discussions are still ongoing
> > > with vendors who have P4 NICs) a filter could be loaded to also
> > > specify the location of the hardware blob.
> >
> > Ah, so there is a plan to eventually add HW offload support for cls_p4?
> > Or is this only specifiying a location of a blob through some opaque
> > cookie value from user space?
>
> Current thought process is it will be something along these lines (the
> commit provides more details):
>
> tc filter add block 22 ingress protocol all prio 1 p4 pname simple_l3 \
>    prog type hw filename "mypnameprog.o" ... \
>    prog type xdp obj $PARSER.o section parser/xdp pinned_link
> /sys/fs/bpf/mylink \
>    action bpf obj $PROGNAME.o section prog/tc-ingress
>
> These discussions are still ongoing - but that is the current
> consensus. Note: we are not pushing any code for that, but hope it
> paints the bigger picture....
> The idea is the cls p4 owns the lifetime of the pipeline. Installing
> the filter instantiates the p4 pipeline "simple_l3" and triggers a lot
> of the refcounts to make sure the pipeline and its components stays
> alive.
> There could be multiple such filters - when someone deletes the last
> filter, then it is safe to delete the pipeline.
> Essentially the filter manages the lifetime of the pipeline.
>
> > > I would be happy with a suggestion that gets us moving forward with
> > > that context in mind.
> >
> > My question on the above is mainly what does it bring you to hold a
> > reference on the XDP program? There is no guarantee that something else
> > will get loaded onto XDP, and then eventually the cls_p4 is the only
> > entity holding the reference but w/o 'purpose'. We do have BPF links
> > and the user space component orchestrating all this needs to create
> > and pin the BPF link in BPF fs, for example. An artificial reference
> > on XDP prog feels similar as if you'd hold a reference on an inode
> > out of tc.. Again, that should be delegated to the control plane you
> > have running interacting with the compiler which then manages and
> > loads its artifacts. What if you would also need to set up some
> > netfilter rules for the SW pipeline, would you then embed this too?
>
> Sorry, a slight tangent first:
> P4 is self-contained, there are a handful of objects that are defined
> by the spec (externs, actions, tables, etc) and we model them in the
> patchset, so that part is self-contained. For the extra richness such
> as the netfilter example you quoted - based on my many years of
> experience deploying SDN - using daemons(sorry if i am reading too
> much in what I think you are implying) for control is not the best
> option i.e you need all kinds of coordination - for example where do
> you store state, what happens when the daemon dies, how do you
> graceful restarts etc. Based on that, if i can put things in the
> kernel (which is essentially a "perpetual daemon", unless the kernel
> crashes) it's a lot simpler to manage as a source of truth especially
> when there is not that much info. There is a limit when there are
> multiple pieces (to use your netfilter example) because you need
> another layer to coordinate things.
>
> Re: the XDP part - our key reason is mostly managerial, in that the
> filter is the lifetime manager of the pipeline; and that if i dump
> that filter i can see all the details in regards to the pipeline(tc,
> XDP and in future hw, etc) in one spot. You are right, the link
> pinning is our protection from someone replacing the XDP prog (this
> was a tip from Toke in the early days) and the comparison of tc
> holding inode is apropos.
> There's some history: in the early days we were also using metadata
> which comes from the XDP program at the tc layer if more processing
> was to be done (and there was extra metadata which told us which XDP
> prog produced it which we would vet before trusting the metadata).
> Given all the above, we should still be able to hold this info without
> necessarily holding the extra refcount and be able to see this detail.
> So we can remove the refcounting.
>

Daniel?

cheers,
jamal


> cheers,
> jamal
>
> > Thanks,
> > Daniel

