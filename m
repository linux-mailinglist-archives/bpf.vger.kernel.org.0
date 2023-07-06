Return-Path: <bpf+bounces-4244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DDB749DC5
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA687280C9D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790EA9448;
	Thu,  6 Jul 2023 13:32:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294659440
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 13:32:04 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A61BF3
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 06:31:55 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-57688a146ecso8754547b3.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 06:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688650314; x=1691242314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs28WbKYsMm2vLZxQF77zj7bC7bw0228Itc8NTTGeZc=;
        b=ARRrOgrgJGqnRZW3Vg720V9D3aPE0/GlJWhXriFyTRq1pwWbfs25w3aqoRFEOLlKcQ
         UTGXRpMlLVc9poIIk3YzM2yRPnJY1ItvYwGUGlJjwErdWVJkeIeP4P4DL+45acYdGG6m
         M5kQ0liDRnZcp7oVopiqaRQKSmQUZ4fpAKdESiyzURAKe3o7WS72GEyMZ2fsnMV3MWdh
         KzxJN+kTk7pU2YrN/kPXc5XvxeyLSHWscjaeo4VY5RuJh+AHSSSMBV6mn/KcMQmVFgBV
         WW2T9Q2MMBADsKpHu+H3wCR7KdvlvH1I3z7pFxB5DBkfelHYT3jWZ6gP6nVEXI4fEsAD
         XMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688650314; x=1691242314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs28WbKYsMm2vLZxQF77zj7bC7bw0228Itc8NTTGeZc=;
        b=JhjHLcfYBwNfcQaUWOu2PQ5m5AnGl5B9b7gyVIqi+IgoiZ4+XcRfyV6RQzpDwzpo2u
         NcUYLbHu1qwhIqf2eLcEmVwWwOt8eucxK+eIjnAmdL/M7/DbI49As+XE83l7HWS1rhdA
         jXYNwK1cN8mf1mIhV/ZcjCXTjL1JN+y7tCW18fl69X+SNC43gZbF77mITZSgxqDchDEL
         B5dTibNM+4dLkZYLKX5G6ZGED2Y1uKJyPn7b4362MI299llJAF0ALciEWmdb/q3oQ2Fp
         lUcSu/YXD+iAhzMTPFU9KPgNHSiVzfuKz4pM98zsPpDF5ZJWhqzFGtGfI4xA/1UEDzTS
         T/Zw==
X-Gm-Message-State: ABy/qLZbxzQI//MzTh4ASoeI1x4y8OSOSSvRbwpMTJBjWIZREl4IiGGg
	MHxJTq2HjyWFCPIz142qPbHvlr6eBGQUCo02zbyHdtam/6iJzh9M
X-Google-Smtp-Source: APBJJlFCJgcWbeMcCv0C1c5vMp3tfhSGDw/QLrravDt+kVw6krLNNlkgp/WL3fdJGV5EIgxVtraZ2PErwHqRLTEFVYY=
X-Received: by 2002:a81:4f58:0:b0:576:93f1:d118 with SMTP id
 d85-20020a814f58000000b0057693f1d118mr2085102ywb.2.1688650314074; Thu, 06 Jul
 2023 06:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607192625.22641-1-daniel@iogearbox.net> <20230607192625.22641-3-daniel@iogearbox.net>
 <CAM0EoMm25tdjxp+7Mq4fowGfCJzFRhbThHhaO7T_46vNJ9y-NQ@mail.gmail.com>
 <fe2e13a6-1fb6-c160-1d6f-31c09264911b@iogearbox.net> <CAM0EoM=FFsTNNKaMbRtuRxc8ieJgDFsBifBmZZ2_67u5=+-3BQ@mail.gmail.com>
 <CAEf4BzbuzNw4gRXSSDoHTwGH82moaSWtaX1nvmUAVx4+OgaEyw@mail.gmail.com>
 <CAM0EoM=SeFagzNMWLHqM7LRXt71pWz7BJax_4rvCnLyARDyWig@mail.gmail.com>
 <15ab0ba7-abf7-b9c3-eb5e-7a6b9fd79977@iogearbox.net> <CAM0EoMndiP6c20Q9g+dSFMh+XPJCdCAUzjHPXm6-4mmNJtAH3A@mail.gmail.com>
 <b147aa2d-6aa5-6336-1484-41c7c1032ecd@iogearbox.net>
In-Reply-To: <b147aa2d-6aa5-6336-1484-41c7c1032ecd@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 6 Jul 2023 09:31:42 -0400
Message-ID: <CAM0EoM=-Kk1K04wYgsiARPfqLx1a2kkq92haU9dZPP7P2mgh8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: Add fd-based tcx multi-prog infra
 with link support
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, razor@blackwall.org, sdf@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, 
	toke@kernel.org, davem@davemloft.net, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, lmb@isovalent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 3:34=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 7/5/23 12:38 AM, Jamal Hadi Salim wrote:
> > On Tue, Jul 4, 2023 at 6:01=E2=80=AFPM Daniel Borkmann <daniel@iogearbo=
x.net> wrote:
> >> On 7/4/23 11:36 PM, Jamal Hadi Salim wrote:
> >>> On Thu, Jun 8, 2023 at 5:25=E2=80=AFPM Andrii Nakryiko
> >>> <andrii.nakryiko@gmail.com> wrote:
> >>>> On Thu, Jun 8, 2023 at 12:46=E2=80=AFPM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> >>>>> On Thu, Jun 8, 2023 at 6:12=E2=80=AFAM Daniel Borkmann <daniel@ioge=
arbox.net> wrote:
> >>>>>> On 6/8/23 3:25 AM, Jamal Hadi Salim wrote:
> >> [...]
> >>>>>> BPF links are supported for XDP today, just tc BPF is one of the f=
ew
> >>>>>> remainders where it is not the case, hence the work of this series=
. What
> >>>>>> XDP lacks today however is multi-prog support. With the bpf_mprog =
concept
> >>>>>> that could be addressed with that common/uniform api (and Andrii e=
xpressed
> >>>>>> interest in integrating this also for cgroup progs), so yes, vario=
us hook
> >>>>>> points/program types could benefit from it.
> >>>>>
> >>>>> Is there some sample XDP related i could look at?  Let me describe =
our
> >>>>> use case: lets say we load an ebpf program foo attached to XDP of a
> >>>>> netdev  and then something further upstream in the stack is consumi=
ng
> >>>>> the results of that ebpf XDP program. For some reason someone, at s=
ome
> >>>>> point, decides to replace the XDP prog with a different one - and t=
he
> >>>>> new prog does a very different thing. Could we stop the replacement
> >>>>> with the link mechanism you describe? i.e the program is still load=
ed
> >>>>> but is no longer attached to the netdev.
> >>>>
> >>>> If you initially attached an XDP program using BPF link api
> >>>> (LINK_CREATE command in bpf() syscall), then subsequent attachment t=
o
> >>>> the same interface (of a new link or program with BPF_PROG_ATTACH)
> >>>> will fail until the current BPF link is detached through closing its
> >>>> last fd.
> >>>
> >>> So this works as advertised. The problem is however not totally solve=
d
> >>> because it seems we need a process that's alive to hold the ownership=
.
> >>> If we had a daemon then that would solve it i think (we dont).
> >>> Alternatively,  you pin the link. The pinning part can be
> >>> circumvented, unless i misunderstood i,e anybody with the right
> >>> permissions can remove it.
> >>>
> >>> Am I missing something?
> >>
> >> It would be either of those depending on the use case, and for pinning
> >> removal, it would require right permissions/acls. Keep in mind that fo=
r
> >> your application you can also use your own bpffs mount, so you don't
> >> need to use the default /sys/fs/bpf one in hostns.
> >
> > This helps for sure - doesnt 100% solve it. It would really be nice if
> > we could tie in a kerberos-like ticketing system for ownership of the
> > mount or something even more fine grained like a link. Doesnt have to
> > be kerberos but anything that would allow a digest of some verifiable
> > credentials/token to be handed to the kernel for authorization...
>
> What is your use-case, you don't want anyone except your own orchestratio=
n
> application to access it, so any kind of ACLs, LSM policies or making the
> mount only available to your container are not enough in this scenario yo=
u
> have in mind?

It should work - it's not even a shared environment (unlike the
situation you have to deal with). I think i got overly paranoid
because we  have gone through a couple of debug cases where an
installed parser (using ip) in  XDP (with a tc prog consuming the
results) was accidentally replaced (and the tc side had expectations
built on the removed prog). i.e end goal is two or more programs, in
this case, one running in XDP and another at TC are interdependent; if
you touch one you affect the other.
In a shared environment it could be problematic because all you need
is root access to remove things.
If you have a second factor authentication etc then someone has to be
both root and has more secret knowledge to displace things.

But: I do have some ulterior motive where the authentication could be
used at policy level as well. Example someone can read-only a tc rule
whereas someone else can read, update or even delete the rule.

> I think the closest to that is probably the prototype which Lorenz recent=
ly
> built where the user space application's digest is validated via IMA [0].

This may be sufficient for the atomicity requirement if we can lock
things into our own ebpf fs. I will take a look - thanks.

cheers,
jamal
>    [0] http://vger.kernel.org/bpfconf2023_material/Lorenz_Bauer_-_BPF_sig=
ning_using_fsverity_and_LSM_gatekeeper.pdf
>        https://github.com/isovalent/bpf-verity

