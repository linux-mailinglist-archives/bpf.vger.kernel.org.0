Return-Path: <bpf+bounces-22409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C6885E04A
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 15:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B80C1C23D47
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF88062E;
	Wed, 21 Feb 2024 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KJEbC7a/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BD7FBCA
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527105; cv=none; b=b9fOZVZdzQAEF+nK9bcwtNaAkMQ8k6jDlyv6Tkj+ld0jP7RlvozrAvQPCL7y/arSivxv84bfm4G/usDxM9FygBMvhwaj7c4JLAZtqBwhUhEQnDTNT5CrfHhK/Hyg5wsGLhNC2F5CCSgb3b98bDGANqnMkTn+lLjOrJjaJjwdtVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527105; c=relaxed/simple;
	bh=/amYi4ftTnu4K67R4oU/ykDMmcFYXwoCOLLp3c1TsLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpARneSy577lnTJXSqGtV30yjAE8bYd7Fadb2NRSBRHaCPJ2lNMv3bkxF/PAuyFfvxUVVEAXXCOC61aWnTNOLRvKokbgdjgWfy/1mXqekAx7/E6c4DLiEFv2oWMtk1ndR/4YMFWUQAT5H/FuMSQyig1HIvrLp9JLg7kpRSidjJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=KJEbC7a/; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso6487657276.0
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 06:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708527101; x=1709131901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5gELUjIx4hdb+gDszF0Y2DyWEanHjBQPydFeoNv+g0=;
        b=KJEbC7a/bUkAEHTkNyCz57iRA2p6tg5IR2yv89CS/ca4nPlC0GtVNRe6TZhe16wSc5
         zbFWZPjamrxnkBIWIBulxixqRi/FAwWyNYG/ge/hkldgbT66w2qe+fKvNb+o67HDrEyQ
         k6zegMIrjZAUwIksuq5X0KVTDoKnBF3W+FWHtD9J3VcNo//di1X+xwR25xMeL0jC8S8m
         s+dnwIFxpMK2ZeXIerRMAI8yjw/M1iNHeAVKqvMLmMcPD2MSbq5rOvG04LJPtEEhefdt
         sP4sAvbhO5/p1XqMvw/CodAsiATXEbbBmJyBH9bupVhuCH0ouq7kYqJFj4gepYoK7YjU
         c3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708527101; x=1709131901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5gELUjIx4hdb+gDszF0Y2DyWEanHjBQPydFeoNv+g0=;
        b=ZmNCRODARKxgUj2hcprZ2Yjrx4MbH/SIoy3HqFefYnNadDmzYTCoTarVEV1IU2LVBJ
         JfN3b4BmctyLMc+7AadnkJg030ISVunYMq3dPtHEtz8XI+4xN/xh1axCtJLo5c0Q9LA3
         +yKt05rHzv2rEUKeWqV+qTv94/v1XYN6uIalpAZKBg4bhqufl/WY5RlHTgs2w+NEmPBa
         Nr+OcmoaLIAZ45Lwerjjy9kQhuGgIogCBlExyPafSXVBsXzBTdJqHrJra4RcQlEFCSzh
         vqmoNd0lbgba0qSkPkdezbuyzruRKdK1Wwl9jxysOnWvK5rzP08hUnFiVFjCK7vCE2mk
         NajA==
X-Forwarded-Encrypted: i=1; AJvYcCUydSt+dFbeDwEL0IeDGWLUE/3IblT/UuqKWL74OMBa689CNM82X/tYk95xzSaesW32Uei9xUF1bX399SHUUCXaDSZf
X-Gm-Message-State: AOJu0YxidqWoKDkxb+YUbc6Ya4ryRJxqI64rWpqG+hx89nsabKdTu1Ek
	wKumeDthIAtwuHCcNWqyhwvznPRTUz4tyS8iUdquesgUqpmlcgoEkZ+uBT6xF8iiKgG9p0ZMkBK
	yr/M1VKQpjMNaSRMIGmjp6WTYTIR/7vgvJnaL
X-Google-Smtp-Source: AGHT+IEpmKKB/nzi2Ybz2mwM8lig/3B93/zbmEDdTYbyYcqxtV44YXU81wptyJdBZe6UuGZFHTNlMCtFxv3aDXf9rIE=
X-Received: by 2002:a25:b20f:0:b0:dc6:4b5a:410a with SMTP id
 i15-20020a25b20f000000b00dc64b5a410amr17229302ybj.12.1708527101096; Wed, 21
 Feb 2024 06:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-16-jhs@mojatatu.com>
 <6841ee07-40c6-9a67-a1a7-c04cbff84757@iogearbox.net> <CAM0EoMnjEpZrajgfKLQhsJjDANsdsZf3z2W8CT9FTMQDw2hGMw@mail.gmail.com>
 <a567ac93-2564-2235-b65f-d0940da076a5@iogearbox.net> <CAM0EoM=XPJ96s3Y=ivrjH-crGb6hRu4hi90WB-O_SkxvLZNYpQ@mail.gmail.com>
 <CAM0EoM=TfDESv=Ewsf_HM3aN+p+718DXoVm-vvmz+5+7-9z3dQ@mail.gmail.com> <c44e2c3f-06dd-4709-6799-3ab8f85a7265@iogearbox.net>
In-Reply-To: <c44e2c3f-06dd-4709-6799-3ab8f85a7265@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 21 Feb 2024 09:51:29 -0500
Message-ID: <CAM0EoMkzjomkpYQ5XZQLsrhuT2ZDhJy_GwiMJmnxL4eJ-s+v1g@mail.gmail.com>
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

On Tue, Feb 20, 2024 at 10:49=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 2/16/24 10:18 PM, Jamal Hadi Salim wrote:
> > On Thu, Jan 25, 2024 at 12:59=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> >> On Thu, Jan 25, 2024 at 10:47=E2=80=AFAM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> >>> On 1/24/24 3:40 PM, Jamal Hadi Salim wrote:
> >>>> On Wed, Jan 24, 2024 at 8:59=E2=80=AFAM Daniel Borkmann <daniel@ioge=
arbox.net> wrote:
> >>>>> On 1/22/24 8:48 PM, Jamal Hadi Salim wrote:
> >>> [...]
> >>>>>>
> >>>>>> It should also be noted that it is feasible to split some of the i=
ngress
> >>>>>> datapath into XDP first and more into TC later (as was shown above=
 for
> >>>>>> example where the parser runs at XDP level). YMMV.
> >>>>>> Regardless of choice of which scheme to use, none of these will af=
fect
> >>>>>> UAPI. It will all depend on whether you generate code to load on X=
DP vs
> >>>>>> tc, etc.
> >>>>>>
> >>>>>> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> >>>>>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >>>>>> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> >>>>>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> >>>>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>>>>
> >>>>> My objections from last iterations still stand, and I also added a =
nak,
> >>>>> so please do not just drop it with new revisions.. from the v10 as =
you
> >>>>> wrote you added further code but despite the various community feed=
back
> >>>>> the design still stands as before, therefore:
> >>>>>
> >>>>> Nacked-by: Daniel Borkmann <daniel@iogearbox.net>
> >>>>
> >>>> We didnt make code changes - but did you read the cover letter and t=
he
> >>>> extended commentary in this patch's commit log? We should have
> >>>> mentioned it in the changes log. It did respond to your comments.
> >>>> There's text that says "the filter manages the lifetime of the
> >>>> pipeline" - which in the future could include not only tc but XDP bu=
t
> >>>> also the hardware path (in the form of a file that gets loaded). I a=
m
> >>>> not sure if that message is clear. Your angle being this is layer
> >>>> violation. In the last discussion i asked you for suggestions and we
> >>>> went the tcx route, which didnt make sense, and  then you didnt
> >>>> respond.
> >>> [...]
> >>>
> >>>>> Also as mentioned earlier I don't think tc should hold references o=
n
> >>>>> XDP programs in here. It doesn't make any sense aside from the fact
> >>>>> that the cls_p4 is also not doing anything with it. This is somethi=
ng
> >>>>> that a user space control plane should be doing i.e. managing a XDP
> >>>>> link on the target device.
> >>>>
> >>>> This is the same argument about layer violation that you made earlie=
r.
> >>>> The filter manages the p4 pipeline - i.e it's not just about the ebp=
f
> >>>> blob(s) but for example in the future (discussions are still ongoing
> >>>> with vendors who have P4 NICs) a filter could be loaded to also
> >>>> specify the location of the hardware blob.
> >>>
> >>> Ah, so there is a plan to eventually add HW offload support for cls_p=
4?
> >>> Or is this only specifiying a location of a blob through some opaque
> >>> cookie value from user space?
> >>
> >> Current thought process is it will be something along these lines (the
> >> commit provides more details):
> >>
> >> tc filter add block 22 ingress protocol all prio 1 p4 pname simple_l3 =
\
> >>     prog type hw filename "mypnameprog.o" ... \
> >>     prog type xdp obj $PARSER.o section parser/xdp pinned_link
> >> /sys/fs/bpf/mylink \
> >>     action bpf obj $PROGNAME.o section prog/tc-ingress
> >>
> >> These discussions are still ongoing - but that is the current
> >> consensus. Note: we are not pushing any code for that, but hope it
> >> paints the bigger picture....
> >> The idea is the cls p4 owns the lifetime of the pipeline. Installing
> >> the filter instantiates the p4 pipeline "simple_l3" and triggers a lot
> >> of the refcounts to make sure the pipeline and its components stays
> >> alive.
> >> There could be multiple such filters - when someone deletes the last
> >> filter, then it is safe to delete the pipeline.
> >> Essentially the filter manages the lifetime of the pipeline.
> >>
> >>>> I would be happy with a suggestion that gets us moving forward with
> >>>> that context in mind.
> >>>
> >>> My question on the above is mainly what does it bring you to hold a
> >>> reference on the XDP program? There is no guarantee that something el=
se
> >>> will get loaded onto XDP, and then eventually the cls_p4 is the only
> >>> entity holding the reference but w/o 'purpose'. We do have BPF links
> >>> and the user space component orchestrating all this needs to create
> >>> and pin the BPF link in BPF fs, for example. An artificial reference
> >>> on XDP prog feels similar as if you'd hold a reference on an inode
> >>> out of tc.. Again, that should be delegated to the control plane you
> >>> have running interacting with the compiler which then manages and
> >>> loads its artifacts. What if you would also need to set up some
> >>> netfilter rules for the SW pipeline, would you then embed this too?
> >>
> >> Sorry, a slight tangent first:
> >> P4 is self-contained, there are a handful of objects that are defined
> >> by the spec (externs, actions, tables, etc) and we model them in the
> >> patchset, so that part is self-contained. For the extra richness such
> >> as the netfilter example you quoted - based on my many years of
> >> experience deploying SDN - using daemons(sorry if i am reading too
> >> much in what I think you are implying) for control is not the best
> >> option i.e you need all kinds of coordination - for example where do
> >> you store state, what happens when the daemon dies, how do you
> >> graceful restarts etc. Based on that, if i can put things in the
> >> kernel (which is essentially a "perpetual daemon", unless the kernel
> >> crashes) it's a lot simpler to manage as a source of truth especially
> >> when there is not that much info. There is a limit when there are
> >> multiple pieces (to use your netfilter example) because you need
> >> another layer to coordinate things.
>
> 'source of truth' for the various attach points or BPF links, yes, but in
> this case here it is not, since the source of truth on what is attached
> is not in cls_p4 but rather on the XDP link. How do you handle the case
> when cls_p4 says something different to what is /actually/ attached? Why
> is it not enough to establish some convention in user space, to pin the
> link and retrieve/update from there when needed? Like everyone else does.
> ... even if you consider iproute2 your "control plane" (which I have the
> feeling you do)?
>
> >> Re: the XDP part - our key reason is mostly managerial, in that the
> >> filter is the lifetime manager of the pipeline; and that if i dump
>
> This is imho the problematic part which feels like square peg in round
> hole, trying to fit this whole lifetime manager of the pipeline into
> the cls_p4 filter. We agree to disagree here. Instead of reusing
> individual building blocks from user space, this tries to cramp control
> plane parts into the kernel for which its not a great fit with what is
> build here as-is.
>
> >> that filter i can see all the details in regards to the pipeline(tc,
> >> XDP and in future hw, etc) in one spot. You are right, the link
> >> pinning is our protection from someone replacing the XDP prog (this
> >> was a tip from Toke in the early days) and the comparison of tc
> >> holding inode is apropos.
> >> There's some history: in the early days we were also using metadata
> >> which comes from the XDP program at the tc layer if more processing
> >> was to be done (and there was extra metadata which told us which XDP
> >> prog produced it which we would vet before trusting the metadata).
> >> Given all the above, we should still be able to hold this info without
> >> necessarily holding the extra refcount and be able to see this detail.
> >> So we can remove the refcounting.
> >
> > Daniel?
>
> The refcount should definitely be removed, but then again, see the point
> above in that it is inconsistent information. Why can't this be done in
> user space with some convention in your user space control plane - if you
> take iproute2, then why it cannot pin the link in a bpf fs instance and
> retrieve it from there?

Ok, Daniel - let's do this so we can move forward. I am getting
exhausted, we've been going at this for a year now. As a compromise: I
will remove the support for XDP altogether from the filter. We will
still reference the XDP program in the CLI and infact load and pin it
that way but the filter will not be adding a refcount in the kernel as
in the posted patch.

cheers,
jamal

