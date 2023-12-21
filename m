Return-Path: <bpf+bounces-18556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3B681BE04
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 19:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356181F22BA8
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DF763509;
	Thu, 21 Dec 2023 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ZtLZgkNv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYmiZOVE"
X-Original-To: bpf@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD75634F7
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 031075C017E;
	Thu, 21 Dec 2023 13:18:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 21 Dec 2023 13:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1703182736;
	 x=1703269136; bh=lYrvnAbrM2F82W5CTtQ8RKyB0HWIa4V/fPN1RHcXdXI=; b=
	ZtLZgkNv81GJJhNyG+metiEvgOqsQnw4EYa2LHmopZusTVMSYV3uKyQWMFUwmEzD
	IS2aPY9x2TqM6tfwZmIaC/JaWBOp98XGv8Ai94a2f7+ipVUIQs3WQT/ya1QvelaH
	7ZVKxlMwdIRc9cWe06esJSTePjm2PZ2DFnGNn3jeU4HJesOX6Pr3YSsVxSm2bfrp
	CaPzqmrs0CJ7vHqZQj5Jmk/KQYEwQ0frlt6FlwbBjMLSOCyOUb1KaBOgXM+NKh8O
	OUcO5yzDYvG9/8KfWMbYOefQF5ndr4b5glauBwbt7kNh3BUbkPDSl5aCAECIIWtR
	a4X28YMzLGDFRwfoEFQi6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703182736; x=
	1703269136; bh=lYrvnAbrM2F82W5CTtQ8RKyB0HWIa4V/fPN1RHcXdXI=; b=e
	YmiZOVEUBveljQ2jpgxLcp5BupuU+LoFaQWOSDFyapJR3oEXZh/XUzGRu+9qjE2c
	CSVafQRkzNFlr0u56sSDBHgn7L88h446WWZqdEyBZjS1F4JV41/UqbSz/g9BkATW
	qNNE8njV5if1xNeUmEaHDz6LKdtf4QQoSSnYlameATkq1bIOCZm/A205mfwt1bBF
	A/x6+To4EZfevVLEtNWTg5Auk7t4l8QX/uHE2/bes/x3hATjKrSXfywPAd3fbTqt
	qOm7rqfNYNaQpdz6WIbn+rxmB+ggZFPnns/76MdMjnN78OVRrOIVJlmW2T3YZHlv
	3Y9ZCxG7bypHzYiWC4vLA==
X-ME-Sender: <xms:kIGEZcQPAdSKeFMFHuz3GWeTCggmU2cZLN7GlfLBzMAo_RXQ5MA1zA>
    <xme:kIGEZZzqQwEnTI88FdNpdYqGbbcdSKZYrJeJb7gE5uwS4vQfj2WnSMi7IEQy14gkn
    U9j7Wd579mTAD-cnw>
X-ME-Received: <xmr:kIGEZZ1k4xU8F7atw7L7B2YOq-3KOAhqYO0FmO03r8DrIWOUZvmDgseJMiplFJe7cqkWYMIt1UbiHq8Be8sw_gibsulkf0OIIKHwOhs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:kIGEZQBR1sm4xPN1qzbzhc0Sg0nmdx1deTu_QVtYctnOdWCqzKBVLQ>
    <xmx:kIGEZVhBSmW6aK_OhNxLySlvZwY0LacTGr9DQeyP2fvK48NvFBDRDA>
    <xmx:kIGEZcp-WeUhM_QYHH9WMLJ41M-TJrPDdUYj1Hv3C9yy-eRzVd24xA>
    <xmx:kIGEZdhTLZuA8gcdmwEQmeJCBfv9KgMGWfTtPkLckz9mwz-B_iMGTA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 13:18:55 -0500 (EST)
Date: Thu, 21 Dec 2023 11:18:54 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Quentin Monnet <quentin@isovalent.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Message-ID: <yx7o3e4lep5fonxw26kltlbzysos3e5t4y54xwx6oiafggwfpg@b4kpw72xyhch>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
 <ZYP40EN9U9GKOu7x@krava>
 <CAADnVQJL7Yodi67f2A79Pah-Uek+WX66CVs=tAFAoYsh+t+3_Q@mail.gmail.com>
 <fecae4fe-b804-c7f5-1854-66af2f16a44a@oracle.com>
 <CAADnVQ+9PZvTc034oHa=7yQFPtyV=Yvjqef2+r97SyKFOgV=RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+9PZvTc034oHa=7yQFPtyV=Yvjqef2+r97SyKFOgV=RA@mail.gmail.com>

Hi Alexei,

On Thu, Dec 21, 2023 at 10:07:33AM -0800, Alexei Starovoitov wrote:
> On Thu, Dec 21, 2023 at 9:43 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On 21/12/2023 17:05, Alexei Starovoitov wrote:
> > > On Thu, Dec 21, 2023 at 12:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >> you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 lists,
> > >> which are bounded by __BTF_ID__set8__<name> symbols, which also provide size
> > >
> > > +1
> > >
> > >>>
> > >>> Maybe we need a codemod from:
> > >>>
> > >>>         BTF_ID(func, ...
> > >>>
> > >>> to:
> > >>>
> > >>>         BTF_ID(kfunc, ...
> > >>
> > >> I think it's better to keep just 'func' and not to do anything special for
> > >> kfuncs in resolve_btfids logic to keep it simple
> > >>
> > >> also it's going to be already in pahole so if we want to make a fix in future
> > >> you need to change pahole, resolve_btfids and possibly also kernel
> > >
> > > I still don't understand why you guys want to add it to vmlinux BTF.
> > > The kernel has no use in this additional data.
> > > It already knows about all kfuncs.
> > > This extra memory is a waste of space from kernel pov.
> > > Unless I am missing something.
> > >
> > > imo this logic belongs in bpftool only.
> > > It can dump vmlinux BTF and emit __ksym protos into vmlinux.h
> > >
> >
> > If the goal is to have bpftool detect all kfuncs, would having a BPF
> > kfunc iterator that bpftool could use to iterate over registered kfuncs
> > work perhaps?
> 
> The kernel code ? Why ?
> bpftool can do the same thing as this patch. Iterate over set8 in vmlinux elf.

I think you're right for vmlinux -- bpftool can look at the elf file on
a running system. But I'm not sure it works for modules. 

IIUC, the actual module ELF can go away while the kernel holds onto the
memory (as with initramfs). And even if that wasn't the case, in
containerized environments you may not be able to always see
/lib/modules or similar. That's assuming there's not a way to get the
module as with vmlinux /proc/kcore that I don't know about.

Looking at the tree, there's about 20k export symbols:

        $ rg EXPORT_SYMBOL_GPL | wc -l
        19471

Assuming kfuncs get there, that's about 312K of memory:

        >>> (20000 * (12 + 4)) >> 10
        312

So maybe a worthwhile tradeoff?

In general though, I kinda like having it in BTF cuz it's a structured
way to export metadata. IMO the link between kfuncs and BTF_ID_set8 is
kinda weak and might best be left as an implementation detail that
kernel devs can keep an eye on.

Thanks,
Daniel

