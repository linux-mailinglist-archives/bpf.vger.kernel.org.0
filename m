Return-Path: <bpf+bounces-18625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4326A81CF64
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 21:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE871C21181
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 20:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41E320B09;
	Fri, 22 Dec 2023 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="aHyrWKUc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="9F4cSBua"
X-Original-To: bpf@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943381E519
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 71A9B5C024D;
	Fri, 22 Dec 2023 15:55:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 22 Dec 2023 15:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1703278515;
	 x=1703364915; bh=s6SWW12V0tyQwcm4rfFsJIVSEVwA0BE38tFsOsLRZRQ=; b=
	aHyrWKUcHDZItzF1dNVt9L2kHxugAAhcdkVMx5tsFnk+3kJlzhcgbIFdCPgwa/pl
	klRWOlv6mvQZRGRQBKsAzkrLaAtr4c3IAS7vpykrn2huaY7NMSZPS4/c0l+xeDoI
	cP0wC+6Dtvv8c1TKfF1GkJLAkWgg9NCp08ezeH7XzAoXTujExI9aL0Ywf8w3QTgZ
	hdCwEfpXkP57i7wQ5HDWPvf56zEczU3UR0SDxLF878gk66mVSIms9scnADX84kFM
	dt0QI0aVksfyHEr6r4ejiV52mgWHBmRStLYHAoyG+DRMFJ3SST4LpvUrm1c+i79K
	0l//69nv6h+Y3a7YBrubYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703278515; x=
	1703364915; bh=s6SWW12V0tyQwcm4rfFsJIVSEVwA0BE38tFsOsLRZRQ=; b=9
	F4cSBua978bB1KBacBC0vz2VajKkKCvjUrYxnU/NtYdyOzF1XNKZQH74MkhdmfAp
	0ciN0izuOVp4Q7OWXeUSBDHWwI357TUpUkPSE3+jriEuHiuceOtbit6rrFE5BhJd
	G5GTku4IljxAEUUqVuYAdk9K9Hd8Dt+KU++Zy7Qj/tw4wawDFovb1l48ou/1xS9P
	RkygfRusZNBKdDZN4Yqeni4NwzIoZzlrFvV6MkKZIsxA1XI83Ryrzxdqq84lUtU4
	DC7mtIApo4lvENBo+I4buw5ZhIEF+swaapb02cqo32azfuJmzzjQks5FKXv8rKHb
	hAg6KNazpCIa+oa98zmqg==
X-ME-Sender: <xms:s_eFZRppuyhuRdZfC3GgtoKuU0VIPZjoZ7DzSWv7wXGSzBjBBaq3Vw>
    <xme:s_eFZTo4J3Dzev7Th3nX4EuitgCCf2sgWxyHr2Z9c1NF2MEl-BJIMJoLR9ZrxLd-l
    _4w-9ChhLtejzlFRQ>
X-ME-Received: <xmr:s_eFZeNkDxZOuD1WcMgw1OQGZeenzy9Rt5H4U1pi3bvy9eK-JTVH5uAGRHhYAXWKjo-mrSINf-X6bDRig7eIr9DgPi5808pnqwaI_E4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddujedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:s_eFZc5SWVkYXqymkpLxJQKqUwmjN8hhEcdj3IGVFhkOP7DR03ykgQ>
    <xmx:s_eFZQ4amYEM_fPclCGUq2YYReACdgsXvlIKRDDJ9Jbg9boZVKXriA>
    <xmx:s_eFZUhIZ2UqV6-CD2EJk3o8V8ufWr5sN3P4XWnK-kDQ2_GwEqrlWQ>
    <xmx:s_eFZfZEF_VCHWzOvp7b7EOdiTz6IpVVdMnc7O3I0k8PSR4NmGUkDQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Dec 2023 15:55:14 -0500 (EST)
Date: Fri, 22 Dec 2023 13:55:13 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Message-ID: <bzmrkewfmwfjp5zq2ct6s3hgnf74q463fxpyphkk7ai7cyki5c@eknreyedyeaf>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
 <ZYP40EN9U9GKOu7x@krava>
 <CAADnVQJL7Yodi67f2A79Pah-Uek+WX66CVs=tAFAoYsh+t+3_Q@mail.gmail.com>
 <fecae4fe-b804-c7f5-1854-66af2f16a44a@oracle.com>
 <CAADnVQ+9PZvTc034oHa=7yQFPtyV=Yvjqef2+r97SyKFOgV=RA@mail.gmail.com>
 <64f6db18-ebd5-501b-2457-a8abe6187a0f@oracle.com>
 <ZYWFQ62dASM5InBZ@krava>
 <00df5193-bde2-fc03-0d88-313cf6ac71b6@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00df5193-bde2-fc03-0d88-313cf6ac71b6@oracle.com>

On Fri, Dec 22, 2023 at 04:24:35PM +0000, Alan Maguire wrote:
> On 22/12/2023 12:46, Jiri Olsa wrote:
> > On Fri, Dec 22, 2023 at 09:55:09AM +0000, Alan Maguire wrote:
> >> On 21/12/2023 18:07, Alexei Starovoitov wrote:
> >>> On Thu, Dec 21, 2023 at 9:43 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>>>
> >>>> On 21/12/2023 17:05, Alexei Starovoitov wrote:
> >>>>> On Thu, Dec 21, 2023 at 12:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >>>>>> you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 lists,
> >>>>>> which are bounded by __BTF_ID__set8__<name> symbols, which also provide size
> >>>>>
> >>>>> +1
> >>>>>
> >>>>>>>
> >>>>>>> Maybe we need a codemod from:
> >>>>>>>
> >>>>>>>         BTF_ID(func, ...
> >>>>>>>
> >>>>>>> to:
> >>>>>>>
> >>>>>>>         BTF_ID(kfunc, ...
> >>>>>>
> >>>>>> I think it's better to keep just 'func' and not to do anything special for
> >>>>>> kfuncs in resolve_btfids logic to keep it simple
> >>>>>>
> >>>>>> also it's going to be already in pahole so if we want to make a fix in future
> >>>>>> you need to change pahole, resolve_btfids and possibly also kernel
> >>>>>
> >>>>> I still don't understand why you guys want to add it to vmlinux BTF.
> >>>>> The kernel has no use in this additional data.
> >>>>> It already knows about all kfuncs.
> >>>>> This extra memory is a waste of space from kernel pov.
> >>>>> Unless I am missing something.
> >>>>>
> >>>>> imo this logic belongs in bpftool only.
> >>>>> It can dump vmlinux BTF and emit __ksym protos into vmlinux.h
> >>>>>
> >>>>
> >>>> If the goal is to have bpftool detect all kfuncs, would having a BPF
> >>>> kfunc iterator that bpftool could use to iterate over registered kfuncs
> >>>> work perhaps?
> >>>
> >>> The kernel code ? Why ?
> >>> bpftool can do the same thing as this patch. Iterate over set8 in vmlinux elf.
> >>
> >> Most distros don't have the vmlinux binary easily available; it needs to
> >> be either downloaded as part of debuginfo packages or uncompressed from
> >> vmlinuz.
> > 
> > would reading the /proc/kcore be an option? I'm under impression it's
> > default for distros but I might be wrong
> >
> 
> Good idea, I think it would be an option alright.

Yeah, /proc/kcore would work, but only for vmlinux. I mentioned in the
other thread about how it probably wouldn't work for kfuncs defined in
modules.


> From a user
> perspective though can we always assume the BTF id sets of kfuncs always
> match the set of available kfuncs? If the goal of this feature is to see
> which kfuncs are available to be used, we'd need some form of active
> participation by the kernel in producing the registered list I think.
> But again, depends what the goal is here.

The goal is to query for available kfuncs. I also mentioned in the other
thread the link between BTF id sets and available kfuncs is not super
obvious. It might be ok for now. But I'll defer to people more familiar
with it.

BPF iterator would probably work, but it feels a bit complex for what is
mostly static data. And for data that doesn't really need to be
introspected (just BTF IDs). So I'm not sure it's the most ergonomic
approach for userspace to consume. Maybe some kind fo sysfs file would
be better? Could be as simple as a space separated list of BTF IDs that
reference kfuncs.

Thanks,
Daniel

