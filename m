Return-Path: <bpf+bounces-16748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130808059E6
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E6D1C211DD
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2E675A7;
	Tue,  5 Dec 2023 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="v16FblpM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFFC129
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 08:23:48 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5d3758fdd2eso56964227b3.0
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 08:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701793428; x=1702398228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAbXwpRgDFgfs4oKyWehmC86yPoHD7aoYIYc9vhsGuc=;
        b=v16FblpMlnghhmAoFp37wip+fj4EJXSPnuopCx9DjCarAAIbRvFCtBlMRvlNqAYlWO
         1L6jTFYsVz7xHmSm5Ws+OvaK4hlcD5L38UG+qIA1NNkd1u6pl9fMH2lKn/pGwmwuJ3d/
         rqEv0SVZiWr0XAecp8RJ2depfk4PZyTEAb169UgqNhnAyIf7fxTDBFxCPvvTj6KbgAGC
         aRI996Eaf6QYnS0LxUJSqDmJzxKllKSJ4RJAQv517QEtko2F9hVOhMtPlB/Enu9IR8QD
         ZxWa8ldj0/vn2Roe6M4bM9r9y3Ix8eLEsTt7hH7TOkb4zV26WZrC5A1MEokwOX3Xxo6Z
         R25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793428; x=1702398228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAbXwpRgDFgfs4oKyWehmC86yPoHD7aoYIYc9vhsGuc=;
        b=XgEP4KnuP+ERDNkgZswr4fGlgDibysAIISiP8SGhJTVOszqWWVD3tkSJDn2ZnWZtEY
         LdhdlbgMsgbEZwVOc9N2/7rOs+QeL3CL6ovZ/VQqwEUu+JWTZNzWbyN/LOIfHdxP0rI0
         L93r7AHry4S4TnkcLxdr8WdgrkplgI8UmYZUX+TgiV4Jma474hWYCS0CpM9mHcP3z7yx
         SOOF6lg91ZLrwndr7SfeiEnouaXR1Mo77ZPPsmrLfCBymPmvvVTHDuzA6kn9wWGGDkb6
         PJ5vvqS/RjTyQulmc+DRn01E2USQjIBVWOPXbNVaKdz/NZJQMlrCIHTTHeggvpNn8WQh
         9vxw==
X-Gm-Message-State: AOJu0YzpoZOOw9Li/caPqb+uHd+mZwX1esexrBzB4zy8YT9TF+qRD11J
	x22qk7cTEBPxItSG+T997bjIf4eNaf/QP5+Q9KZBVA==
X-Google-Smtp-Source: AGHT+IG2RqlRgezYi6QCtZRukN9VkP1Ymuig7H0dBKCFX+KQG4RnHn8xpB0giKFOz6sYzbMcRSiF11JZMTLUsqpAvm8=
X-Received: by 2002:a0d:e881:0:b0:5d9:1524:e315 with SMTP id
 r123-20020a0de881000000b005d91524e315mr2642283ywe.17.1701793427715; Tue, 05
 Dec 2023 08:23:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201182904.532825-1-jhs@mojatatu.com> <20231201182904.532825-16-jhs@mojatatu.com>
 <656e6f8d7c99f_207cb2087c@john.notmuch> <2eb488f9-af4a-4e28-0de0-d4dbc1e166f5@iogearbox.net>
In-Reply-To: <2eb488f9-af4a-4e28-0de0-d4dbc1e166f5@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 5 Dec 2023 11:23:36 -0500
Message-ID: <CAM0EoM=MJJH9zNdiEHYpkYYQ_7WqobGv_v8wp04R7HhdPW8TxA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 15/15] p4tc: add P4 classifier
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	deb.chatterjee@intel.com, anjali.singhai@intel.com, namrata.limaye@intel.com, 
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, 
	horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 8:43=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 12/5/23 1:32 AM, John Fastabend wrote:
> > Jamal Hadi Salim wrote:
> >> Introduce P4 tc classifier. A tc filter instantiated on this classifie=
r
> >> is used to bind a P4 pipeline to one or more netdev ports. To use P4
> >> classifier you must specify a pipeline name that will be associated to
> >> this filter, a s/w parser and datapath ebpf program. The pipeline must=
 have
> >> already been created via a template.
> >> For example, if we were to add a filter to ingress of network interfac=
e
> >> device $P0 and associate it to P4 pipeline simple_l3 we'd issue the
> >> following command:
> >
> > In addition to my comments from last iteration.
> >
> >> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple=
_l3 \
> >>      action bpf obj $PARSER.o section prog/tc-parser \
> >>      action bpf obj $PROGNAME.o section prog/tc-ingress
> >
> > Having multiple object files is a mistake IMO and will cost
> > performance. Have a single object file avoid stitching together
> > metadata and run to completion. And then run entirely from XDP
> > this is how we have been getting good performance numbers.
>
> +1, fully agree.

As I stated earlier: while performance is important it is not the
highest priority for what we are doing, rather correctness is. We dont
want to be wrestling with the verifier or some other limitation like
tail call limits to gain some increase in a few kkps. We are taking a
gamble with the parser which is not using any kfuncs at the moment.
Putting them all in one program will increase the risk.

As i responded to you earlier,  we just dont want to lose
functionality, some sample space:
- we could have multiple pipelines with different priorities - and
each pipeline may have its own logic with many tables etc (and the
choice to iterate the next one is essentially encoded in the tc action
codes)
- we want to be able to split the pipeline into parts that can run _in
unison_ in h/w, xdp, and tc
- we use tc block to map groups of ports heavily
- we use netlink as our control API

> >> $PROGNAME.o and $PARSER.o is a compilation of the eBPF programs genera=
ted
> >> by the P4 compiler and will be the representation of the P4 program.
> >> Note that filter understands that $PARSER.o is a parser to be loaded
> >> at the tc level. The datapath program is merely an eBPF action.
> >>
> >> Note we do support a distinct way of loading the parser as opposed to
> >> making it be an action, the above example would be:
> >>
> >> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple=
_l3 \
> >>      prog type tc obj $PARSER.o ... \
> >>      action bpf obj $PROGNAME.o section prog/tc-ingress
> >>
> >> We support two types of loadings of these initial programs in the pipe=
line
> >> and differentiate between what gets loaded at tc vs xdp by using synta=
x of
> >>
> >> either "prog type tc obj" or "prog type xdp obj"
> >>
> >> For XDP:
> >>
> >> tc filter add dev $P0 ingress protocol all prio 1 p4 pname simple_l3 \
> >>      prog type xdp obj $PARSER.o section parser/xdp \
> >>      pinned_link /sys/fs/bpf/mylink \
> >>      action bpf obj $PROGNAME.o section prog/tc-ingress
> >
> > I don't think tc should be loading xdp programs. XDP is not 'tc'.
>
> For XDP, we do have a separate attach API, for BPF links we have bpf_xdp_=
link_attach()
> via bpf(2) and regular progs we have the classic way via dev_change_xdp_f=
d() with
> IFLA_XDP_* attributes. Mid-term we'll also add bpf_mprog support for XDP =
to allow
> multi-user attachment. tc kernel code should not add yet another way of a=
ttaching XDP,
> this should just reuse existing uapi infra instead from userspace control=
 plane side.

I am probably missing something. We are not loading the XDP program -
it is preloaded, the only thing the filter does above is grabbing a
reference to it. The P4 pipeline in this case is split into a piece
(the parser) that runs on XDP and some that runs on tc. And as i
mentioned earlier we could go further another piece which is part of
the pipeline may run in hw. And infact in the future a compiler will
be able to generate code that is split across machines. For our s/w
datapath on the same node the only split is between tc and XDP.


> >> The theory of operations is as follows:
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D1. PARSING=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> The packet first encounters the parser.
> >> The parser is implemented in ebpf residing either at the TC or XDP
> >> level. The parsed header values are stored in a shared eBPF map.
> >> When the parser runs at XDP level, we load it into XDP using tc filter
> >> command and pin it to a file.
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D2. ACTIONS=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> In the above example, the P4 program (minus the parser) is encoded in =
an
> >> action($PROGNAME.o). It should be noted that classical tc actions
> >> continue to work:
> >> IOW, someone could decide to add a mirred action to mirror all packets
> >> after or before the ebpf action.
> >>
> >> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple=
_l3 \
> >>      prog type tc obj $PARSER.o section parser/tc-ingress \
> >>      action bpf obj $PROGNAME.o section prog/tc-ingress \
> >>      action mirred egress mirror index 1 dev $P1 \
> >>      action bpf obj $ANOTHERPROG.o section mysect/section-1
> >>
> >> It should also be noted that it is feasible to split some of the ingre=
ss
> >> datapath into XDP first and more into TC later (as was shown above for
> >> example where the parser runs at XDP level). YMMV.
> >
> > Is there any performance value in partial XDP and partial TC? The main
> > wins we see in XDP are when we can drop, redirect, etc the packet
> > entirely in XDP and avoid skb altogether.
> >
> >>
> >> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> >> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> >> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> >> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> The cls_p4 is roughly a copy of {cls,act}_bpf, and from a BPF community s=
ide
> we moved away from this some time ago for the benefit of a better managem=
ent
> API for tc BPF programs via bpf(2) through bpf_mprog (see libbpf and BPF =
selftests
> around this), as mentioned earlier. Please use this instead for your user=
space
> control plane, otherwise we are repeating the same mistakes from the past=
 again
> that were already fixed.

Sorry, that is your use case for kubernetes and not ours. We want to
use the tc infra. We want to use netlink. I could be misreading what
you are saying but it seems that you are suggesting that tc infra is
now obsolete as far as ebpf is concerned? Overall: It is a bit selfish
to say your use case dictates how other people use ebpf. ebpf is just
a means to an end for us and _is not the end goal_ - just an infra
toolset. We spent a long time compromising to meet you somewhere when
you asked us to use ebpf but you are pushing it now .

If you feel we should unify the P4 classifier with the tc ebpf
classifier etc then we are going to need some changes that are not
going to be useful for other people. And i dont see the point in that.

cheers,
jamal

> Therefore, from BPF side:
>
> Nacked-by: Daniel Borkmann <daniel@iogearbox.net>
>
> Cheers,
> Daniel

