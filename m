Return-Path: <bpf+bounces-4005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A2B747A33
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 00:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B01C2093B
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A59B46AF;
	Tue,  4 Jul 2023 22:38:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D138A5D
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 22:38:34 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6E310DC
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 15:38:33 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5728df0a7d9so75626927b3.1
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 15:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688510313; x=1691102313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/e4JJTVHswxvjfZXbpQpx9dCJSwcFyknc+AVMyZBss=;
        b=gMoKyx27IRD/+z/WEmzBQo3Px1+Uh204PhTcyQdIFGQCUlkrHbP1aCOmxyOoM6s9TY
         gkqZ+4UAmd+de0XrWb4vSQsUmTU19k7JK1DLD4lefQ7riR+3Gr1+DXsQy/j3zxg1OoKd
         BPBq/gCHm//MJ4X/QIna150TcnvfagqmlctHCdiaTfPIpgv5UKVQPTfkI+tcr8ZB94Ot
         ORhdXTFZ4W206gs6CM3lDMye75i5XEj8aqa27qRR2laQMGE7i3tNRiOQaIgEctwi2eCW
         NDITqQMc7kpHdXFcfgRZLub6GLfhI8GoX4WkpMO7C1jsZYJVUK5GUr+EagYkjzCGYZFq
         GryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688510313; x=1691102313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/e4JJTVHswxvjfZXbpQpx9dCJSwcFyknc+AVMyZBss=;
        b=GcmfPW5vgJCcW6bXGEfK7c/b3DMgh7hPnJ6Vkp4wCy7yXXXmGABs7+NB+tzC/+Wlmu
         M34RQCvwhd8HeBZ6lAI2rRvkUYtg1JdB/qM8Dqw4nBVxP6mCj7Et3fu8x+W6xw+hxm9Q
         zHBcyf5u0cJftTozkORC0G7i6FWfRRhUuBOvFOsVIhHReVdXl2WEwiFfsOr4Z2x3VcAK
         3ykcsastlOsGPCLv/t4PCBLLduZmTXOxhmaGFR9Haoig/GtTVg1OIc6N5JVnMH9nTzpb
         7cV9PmyR1lrPeP+MGuGle3EandYsXrrrPKSCfHDgxk+abi+ZL54/zV4BJ9bol42mMkmD
         q+Ig==
X-Gm-Message-State: ABy/qLZewFr49dV6pPlurlKWjgITzBnBY8gJ/73yaGVMg3j8v1BKXeVW
	bAO5jhoYjJJcn0OQqGfe3CWIo026WCdKQDZIeGGCrg==
X-Google-Smtp-Source: APBJJlFM2Xpbt3Byo1on7MbwbgEouJ0Revocwi475nVMRGpERJTm4jDMozEL4TO6WczSOdYD26lydpGc++ME6x62jOQ=
X-Received: by 2002:a0d:f006:0:b0:56d:2d82:63dc with SMTP id
 z6-20020a0df006000000b0056d2d8263dcmr15637729ywe.10.1688510312814; Tue, 04
 Jul 2023 15:38:32 -0700 (PDT)
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
 <CAM0EoM=SeFagzNMWLHqM7LRXt71pWz7BJax_4rvCnLyARDyWig@mail.gmail.com> <15ab0ba7-abf7-b9c3-eb5e-7a6b9fd79977@iogearbox.net>
In-Reply-To: <15ab0ba7-abf7-b9c3-eb5e-7a6b9fd79977@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 4 Jul 2023 18:38:21 -0400
Message-ID: <CAM0EoMndiP6c20Q9g+dSFMh+XPJCdCAUzjHPXm6-4mmNJtAH3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: Add fd-based tcx multi-prog infra
 with link support
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, razor@blackwall.org, sdf@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, 
	toke@kernel.org, davem@davemloft.net, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 4, 2023 at 6:01=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 7/4/23 11:36 PM, Jamal Hadi Salim wrote:
> > On Thu, Jun 8, 2023 at 5:25=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Thu, Jun 8, 2023 at 12:46=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> >>> On Thu, Jun 8, 2023 at 6:12=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >>>> On 6/8/23 3:25 AM, Jamal Hadi Salim wrote:
> [...]
> >>>> BPF links are supported for XDP today, just tc BPF is one of the few
> >>>> remainders where it is not the case, hence the work of this series. =
What
> >>>> XDP lacks today however is multi-prog support. With the bpf_mprog co=
ncept
> >>>> that could be addressed with that common/uniform api (and Andrii exp=
ressed
> >>>> interest in integrating this also for cgroup progs), so yes, various=
 hook
> >>>> points/program types could benefit from it.
> >>>
> >>> Is there some sample XDP related i could look at?  Let me describe ou=
r
> >>> use case: lets say we load an ebpf program foo attached to XDP of a
> >>> netdev  and then something further upstream in the stack is consuming
> >>> the results of that ebpf XDP program. For some reason someone, at som=
e
> >>> point, decides to replace the XDP prog with a different one - and the
> >>> new prog does a very different thing. Could we stop the replacement
> >>> with the link mechanism you describe? i.e the program is still loaded
> >>> but is no longer attached to the netdev.
> >>
> >> If you initially attached an XDP program using BPF link api
> >> (LINK_CREATE command in bpf() syscall), then subsequent attachment to
> >> the same interface (of a new link or program with BPF_PROG_ATTACH)
> >> will fail until the current BPF link is detached through closing its
> >> last fd.
> >
> > So this works as advertised. The problem is however not totally solved
> > because it seems we need a process that's alive to hold the ownership.
> > If we had a daemon then that would solve it i think (we dont).
> > Alternatively,  you pin the link. The pinning part can be
> > circumvented, unless i misunderstood i,e anybody with the right
> > permissions can remove it.
> >
> > Am I missing something?
>
> It would be either of those depending on the use case, and for pinning
> removal, it would require right permissions/acls. Keep in mind that for
> your application you can also use your own bpffs mount, so you don't
> need to use the default /sys/fs/bpf one in hostns.

This helps for sure - doesnt 100% solve it. It would really be nice if
we could tie in a kerberos-like ticketing system for ownership of the
mount or something even more fine grained like a link. Doesnt have to
be kerberos but anything that would allow a digest of some verifiable
credentials/token to be handed to the kernel for authorization...

cheers,
jamal

> Thanks,
> Daniel

