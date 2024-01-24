Return-Path: <bpf+bounces-20234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F983ACB2
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 16:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD46B34D87
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805F5BE61;
	Wed, 24 Jan 2024 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="R4h3Thrt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C929A1
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107269; cv=none; b=D+T5xfb85OR6g9eJMZcquiA0SkMSMoEzCvzIqi6YBGfXP2kYAuA1fOKOWlryLax7zfS5u26+K6uB3wym/6J9Tai01LzkbCZSrDj8NuZl9mu1dFsu9FWxCz+p++WHRdJ5agZVOvBYfckzYajtPIJzsFyLLVejhFNf18tXO3NNdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107269; c=relaxed/simple;
	bh=y/FqdTWqgZOgZWrffLEyBx68VgyiWbZyoy6lWe/hIIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb/q3uJLtuschQ5CXR7HYENMqDDSv74fjJmfkNady3zgpIoU5lYJ0OJl80miuCaO0cHc9t7yTzu1Cw6o53+bOGrALPd95pTdHlKY5wK7RV63VMUUVbvlvz6avNbwvZG7YhGNzMDPKoVStaHOIwMZ9XedCTKdj7IUn3Fy/cy92ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=R4h3Thrt; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dae7cc31151so4224278276.3
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 06:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706107266; x=1706712066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPbMCu2NffU5jmsnNil1b7MljpjcuhldjvXZtzxkZZ8=;
        b=R4h3ThrtNceOKZ3clxuVxl1N3V+Nt0wkBlzvalgKBNBd7mQYq9cO9QznQVJAicpp6a
         VWo8reCR2SvrnWrnPPhM2hByXHgnMPVPrF2fGSgmg8ab7OSfPy2qQajkAb3EZW1YMA/5
         N4RrU9jClM9ARzS1PZqlHJ/Oha8s0VMHRwsup0havfGCMtuoM4JHOKtDTiZdJ6zCre15
         TJAqFV/z5LhksOAXN5DqnoVqXBGHBGKeXhQQcRsDM3DFpY/J0Ejx+3qNj2nKBHnL/zfJ
         V5L/rMCy4Ai/C/dQvFEktaT+/R2/FcfUOSuwnIt+8x279ePgh5OPQr46gtq+cmFTWj2E
         +bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706107266; x=1706712066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPbMCu2NffU5jmsnNil1b7MljpjcuhldjvXZtzxkZZ8=;
        b=G0is/vHkm+7XNZjRQFtDgkQS2ZbTo6ydFevJQ6W1yFTSynxae2xJj+1Z1uM3Ha2SU6
         TSEA9h3mesqbtSeELrsfiZdjDtzQTcSrjxUicVdA1+kYsJ+cHkMdDv7AIyKewZoungMt
         kTX49ovDkwuqQ3RLsGvQT6+I/L7/dNs9pUw9NoVE/NcpUbics2qbN503F2LWA53wSVpw
         J0DyBrLPNgFvN2GE25QBAqc9vXhX9g0eJ/ZmEwo20zrt4yS+otlzHwKZRsLhxlE67LOa
         kJUNs9Ntg2qHBbgqXrxNK5HJiWna0lTXfHKEnIi73yTu5g7ehqEECaQax22JiiCQEw+x
         YhzA==
X-Gm-Message-State: AOJu0YzWa256C6lIpGIssImSrF7SuvU4g34Z4ie6veJ+58YIBdY63GEj
	IlLvvtqZULzo5UFqOBUTqKXiiqQCjs3IMuFiuK3fkIDFJbgtgb8TYT9VcXvRW9Xzi0EuhQ2jjva
	AE9QvgK+AMiZzVpdh3JYdTqNyi6icN/JHJqe7
X-Google-Smtp-Source: AGHT+IEpZjts2WQT2YvdyCLA8sNV2c3GfGJBy2BrjHyFbW3vaZylEUaFedqN6uQMDG/AMe1gp8udnpDRqPoxAU9+lDA=
X-Received: by 2002:a05:6902:561:b0:dc2:66f8:1890 with SMTP id
 a1-20020a056902056100b00dc266f81890mr774961ybt.113.1706107265779; Wed, 24 Jan
 2024 06:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-16-jhs@mojatatu.com>
 <6841ee07-40c6-9a67-a1a7-c04cbff84757@iogearbox.net>
In-Reply-To: <6841ee07-40c6-9a67-a1a7-c04cbff84757@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 24 Jan 2024 09:40:54 -0500
Message-ID: <CAM0EoMnjEpZrajgfKLQhsJjDANsdsZf3z2W8CT9FTMQDw2hGMw@mail.gmail.com>
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

On Wed, Jan 24, 2024 at 8:59=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 1/22/24 8:48 PM, Jamal Hadi Salim wrote:
> > Introduce P4 tc classifier. The main task of this classifier is to mana=
ge
> > the lifetime of pipeline instances across one or more netdev ports.
> > Note a pipeline may be instantiated multiple times across one or more t=
c chains
> > and different priorities.
> >
> > Note that part or whole of the P4 pipeline could reside in tc, XDP or e=
ven
> > hardware depending on how the P4 program was compiled.
> > To use the P4 classifier you must specify a pipeline name that will be
> > associated to the filter instance, a s/w parser (eBPF) and datapath P4
> > control block program (eBPF) program. Although this patchset does not d=
eal
> > with offloads, it is also possible to load the h/w part using this filt=
er.
> > We will illustrate a few examples further below to clarify. Please trea=
t
> > the illustrated split as an example - there are probably more pragmatic
> > approaches to splitting the pipeline; however, regardless of where the =
different
> > pieces of the pipeline are placed (tc, XDP, HW) and what each layer wil=
l
> > implement (what part of the pipeline) - these examples are merely showi=
ng
> > what is possible.
> >
> > The pipeline is assumed to have already been created via a template.
> >
> > For example, if we were to add a filter to ingress of a group of netdev=
s
> > (tc block 22) and associate it to P4 pipeline simple_l3 we could issue =
the
> > following command:
> >
> > tc filter add block 22 parent ffff: protocol all prio 6 p4 pname simple=
_l3 \
> >      action bpf obj $PARSER.o ... \
> >      action bpf obj $PROGNAME.o section prog/tc-ingress
> >
> > The above uses the classical tc action mechanism in which the first act=
ion
> > runs the P4 parser and if that goes well then the P4 control block is
> > executed. Note, although not shown above, one could also append the com=
mand
> > line with other traditional tc actions.
> >
> > In these patches, we also support two types of loadings of the pipeline
> > programs and differentiate between what gets loaded at say tc vs xdp by=
 using
> > syntax which specifies location as either "prog type tc obj" or
> > "prog type xdp obj". There is an ongoing discussion in the P4TC communi=
ty
> > biweekly meetings which is likely going to have us add another location
> > definition "prog type hw" which will specify the hardware object file n=
ame
> > and other related attributes.
> >
> > An example using tc:
> >
> > tc filter add block 22 parent ffff: protocol all prio 6 p4 pname simple=
_l3 \
> >      prog type tc obj $PARSER.o ... \
> >      action bpf obj $PROGNAME.o section prog/tc-ingress
> >
> > For XDP, to illustrate an example:
> >
> > tc filter add dev $P0 ingress protocol all prio 1 p4 pname simple_l3 \
> >      prog type xdp obj $PARSER.o section parser/xdp \
> >      pinned_link /sys/fs/bpf/mylink \
> >      action bpf obj $PROGNAME.o section prog/tc-ingress
> >
> > In this case, the parser will be executed in the XDP layer and the rest=
 of
> > P4 control block as a tc action.
> >
> > For illustration sake, the hw one looks as follows (please note there's
> > still a lot of discussions going on in the meetings - the example is he=
re
> > merely to illustrate the tc filter functionality):
> >
> > tc filter add block 22 ingress protocol all prio 1 p4 pname simple_l3 \
> >     prog type hw filename "mypnameprog.o" ... \
> >     prog type xdp obj $PARSER.o section parser/xdp pinned_link /sys/fs/=
bpf/mylink \
> >     action bpf obj $PROGNAME.o section prog/tc-ingress
> >
> > The theory of operations is as follows:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D1. PARSING=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The packet first encounters the parser.
> > The parser is implemented in ebpf residing either at the TC or XDP
> > level. The parsed header values are stored in a shared eBPF map.
> > When the parser runs at XDP level, we load it into XDP using tc filter
> > command and pin it to a file.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D2. ACTIONS=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In the above example, the P4 program (minus the parser) is encoded in a=
n
> > action($PROGNAME.o). It should be noted that classical tc actions
> > continue to work:
> > IOW, someone could decide to add a mirred action to mirror all packets
> > after or before the ebpf action.
> >
> > tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_=
l3 \
> >      prog type tc obj $PARSER.o section parser/tc-ingress \
> >      action bpf obj $PROGNAME.o section prog/tc-ingress \
> >      action mirred egress mirror index 1 dev $P1 \
> >      action bpf obj $ANOTHERPROG.o section mysect/section-1
> >
> > It should also be noted that it is feasible to split some of the ingres=
s
> > datapath into XDP first and more into TC later (as was shown above for
> > example where the parser runs at XDP level). YMMV.
> > Regardless of choice of which scheme to use, none of these will affect
> > UAPI. It will all depend on whether you generate code to load on XDP vs
> > tc, etc.
> >
> > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> My objections from last iterations still stand, and I also added a nak,
> so please do not just drop it with new revisions.. from the v10 as you
> wrote you added further code but despite the various community feedback
> the design still stands as before, therefore:
>
> Nacked-by: Daniel Borkmann <daniel@iogearbox.net>
>

We didnt make code changes - but did you read the cover letter and the
extended commentary in this patch's commit log? We should have
mentioned it in the changes log. It did respond to your comments.
There's text that says "the filter manages the lifetime of the
pipeline" - which in the future could include not only tc but XDP but
also the hardware path (in the form of a file that gets loaded). I am
not sure if that message is clear. Your angle being this is layer
violation. In the last discussion i asked you for suggestions and we
went the tcx route, which didnt make sense, and  then you didnt
respond.

> [...]
> > +static int cls_p4_prog_from_efd(struct nlattr **tb,
> > +                             struct p4tc_bpf_prog *prog, u32 flags,
> > +                             struct netlink_ext_ack *extack)
> > +{
> > +     struct bpf_prog *fp;
> > +     u32 prog_type;
> > +     char *name;
> > +     u32 bpf_fd;
> > +
> > +     bpf_fd =3D nla_get_u32(tb[TCA_P4_PROG_FD]);
> > +     prog_type =3D nla_get_u32(tb[TCA_P4_PROG_TYPE]);
> > +
> > +     if (prog_type !=3D BPF_PROG_TYPE_XDP &&
> > +         prog_type !=3D BPF_PROG_TYPE_SCHED_ACT) {
>
> Also as mentioned earlier I don't think tc should hold references on
> XDP programs in here. It doesn't make any sense aside from the fact
> that the cls_p4 is also not doing anything with it. This is something
> that a user space control plane should be doing i.e. managing a XDP
> link on the target device.

This is the same argument about layer violation that you made earlier.
The filter manages the p4 pipeline - i.e it's not just about the ebpf
blob(s) but for example in the future (discussions are still ongoing
with vendors who have P4 NICs) a filter could be loaded to also
specify the location of the hardware blob.
I would be happy with a suggestion that gets us moving forward with
that context in mind.

cheers,
jamal

> > +             NL_SET_ERR_MSG(extack,
> > +                            "BPF prog type must be BPF_PROG_TYPE_SCHED=
_ACT or BPF_PROG_TYPE_XDP");
> > +             return -EINVAL;
> > +     }
> > +
> > +     fp =3D bpf_prog_get_type_dev(bpf_fd, prog_type, false);
> > +     if (IS_ERR(fp))
> > +             return PTR_ERR(fp);
> > +
> > +     name =3D nla_memdup(tb[TCA_P4_PROG_NAME], GFP_KERNEL);
> > +     if (!name) {
> > +             bpf_prog_put(fp);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     prog->p4_prog_name =3D name;
> > +     prog->p4_prog =3D fp;
> > +
> > +     return 0;
> > +}
> > +

