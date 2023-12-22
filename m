Return-Path: <bpf+bounces-18624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EDA81CF5E
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 21:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577CA1C22A75
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 20:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6224C1EA7E;
	Fri, 22 Dec 2023 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="BNPZ9wsz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lcH1fKdK"
X-Original-To: bpf@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2381E500
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 54E1E5C03A4;
	Fri, 22 Dec 2023 15:50:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 22 Dec 2023 15:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1703278249;
	 x=1703364649; bh=ab5JpuVpz4NqvmzM2PazrAqbArBAhRXtM9OW6O/wI6g=; b=
	BNPZ9wszG+90WpD9L6j/4qouhZ6gceY0OFddW/mKFSSjJQ89RPQuhL2E+BZOUyiz
	UCBoq44LfnViX2fjL5mSXaCCLRqi4gXfwXe4pCXY2yfnJge4W7p4QujWDfgcXIjg
	1iXUHpRUrGrKBOj48OMlctygFgsqw/3+sgbiblSC0EZkO4VIBQ1eTeuiC6C//Ulf
	jpiBVxa5OvbOd03SPO1915kyA7skJLGl1DO6HcwDU/gxugMCWBFdi5V/RPi8vzJf
	tA9w5m+phdCaE/m0qwKx7NLP4fzeyNQqR3NBCR3rAgNhBDf/4a6LqcW40iPEz/Zk
	DipW613G+PtT9pOiQ9UEGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703278249; x=
	1703364649; bh=ab5JpuVpz4NqvmzM2PazrAqbArBAhRXtM9OW6O/wI6g=; b=l
	cH1fKdKAgCz/6FZXtGKx+094UxfMkKOs/+rxLoOeef8vcGydvJUM84Q/7l2Ot+kK
	zG7oRDs7Q0YJZZzZCxuITGo12vdgmwqpYZwqd2Hy4mTrD6CxloluowVoqEuRV6XZ
	OJ/RHYwz+5oej4tLxNtgfR9lH9xZW7DVWjGEDqJHYvo0y+J+xovSZi2CqRl96jRa
	gBAmroamYmbf/L7OhGFT3PTHSP82U0l79ZjqhbiWiJMZdcWPVUW8Bxn5+fl4FKII
	6kFwj/700+p06nOfJwZN5AWXIftH59zqYFo+2vH9u/2nLecfE4wRH6ogA/VHvL4+
	gh4Xa22sUYf0Dmdzz30qg==
X-ME-Sender: <xms:qPaFZUGH6pnro6_iaevRHZ6xb0RMBjcrJuYL7VuLe7WxmbVnHAZAIw>
    <xme:qPaFZdUYQpQAuCcQogMrjxRbugsltmbkAgYwC0kIifna4FZhbQ-GcRXNhzQ-8RbBo
    dWy6WgO8qEf7J-c9Q>
X-ME-Received: <xmr:qPaFZeJIMBT3qXGS4xdA0iiytw0pYEmNEAcsybIgxE0mf23S923lXHGYKDjssiq6rwniHJx1syYUcktfSNM7XX47gIwiDhkI_bd1K0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddujedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:qPaFZWGARWtaWlpXiTf0j95mp8Udb1LNnFG7tp1mI7hqdD0YTA87mQ>
    <xmx:qPaFZaWTntH6ql6b70pi1wMEUprlD9GIw79od_B0qt45TtwPTAronw>
    <xmx:qPaFZZO3LWzs2s2fOVl9hjRQUSmUkUlZXBGmMj1e0uI41VAuWL92wA>
    <xmx:qfaFZVGC5zsXI3A358G1-J3Y_CyXbQhbr4Ibt70UsafpvVNJvKM-Hg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Dec 2023 15:50:47 -0500 (EST)
Date: Fri, 22 Dec 2023 13:50:46 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Quentin Monnet <quentin@isovalent.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Message-ID: <dbn34ltpbgycyzszhgdnuetdlnkw6uqitceowrstmuyw2awinp@zegyhaxhugvi>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
 <ZYP40EN9U9GKOu7x@krava>
 <CAADnVQJL7Yodi67f2A79Pah-Uek+WX66CVs=tAFAoYsh+t+3_Q@mail.gmail.com>
 <fecae4fe-b804-c7f5-1854-66af2f16a44a@oracle.com>
 <CAADnVQ+9PZvTc034oHa=7yQFPtyV=Yvjqef2+r97SyKFOgV=RA@mail.gmail.com>
 <yx7o3e4lep5fonxw26kltlbzysos3e5t4y54xwx6oiafggwfpg@b4kpw72xyhch>
 <CAADnVQL=8q_SxXkpUcwzkNzT8dqM0xufDLAeUojuHD9PBF4CkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL=8q_SxXkpUcwzkNzT8dqM0xufDLAeUojuHD9PBF4CkA@mail.gmail.com>

On Thu, Dec 21, 2023 at 04:52:54PM -0800, Alexei Starovoitov wrote:
> On Thu, Dec 21, 2023 at 10:18 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Hi Alexei,
> >
> > On Thu, Dec 21, 2023 at 10:07:33AM -0800, Alexei Starovoitov wrote:
> > > On Thu, Dec 21, 2023 at 9:43 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > >
> > > > On 21/12/2023 17:05, Alexei Starovoitov wrote:
> > > > > On Thu, Dec 21, 2023 at 12:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >> you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 lists,
> > > > >> which are bounded by __BTF_ID__set8__<name> symbols, which also provide size
> > > > >
> > > > > +1
> > > > >
> > > > >>>
> > > > >>> Maybe we need a codemod from:
> > > > >>>
> > > > >>>         BTF_ID(func, ...
> > > > >>>
> > > > >>> to:
> > > > >>>
> > > > >>>         BTF_ID(kfunc, ...
> > > > >>
> > > > >> I think it's better to keep just 'func' and not to do anything special for
> > > > >> kfuncs in resolve_btfids logic to keep it simple
> > > > >>
> > > > >> also it's going to be already in pahole so if we want to make a fix in future
> > > > >> you need to change pahole, resolve_btfids and possibly also kernel
> > > > >
> > > > > I still don't understand why you guys want to add it to vmlinux BTF.
> > > > > The kernel has no use in this additional data.
> > > > > It already knows about all kfuncs.
> > > > > This extra memory is a waste of space from kernel pov.
> > > > > Unless I am missing something.
> > > > >
> > > > > imo this logic belongs in bpftool only.
> > > > > It can dump vmlinux BTF and emit __ksym protos into vmlinux.h
> > > > >
> > > >
> > > > If the goal is to have bpftool detect all kfuncs, would having a BPF
> > > > kfunc iterator that bpftool could use to iterate over registered kfuncs
> > > > work perhaps?
> > >
> > > The kernel code ? Why ?
> > > bpftool can do the same thing as this patch. Iterate over set8 in vmlinux elf.
> >
> > I think you're right for vmlinux -- bpftool can look at the elf file on
> > a running system. But I'm not sure it works for modules.
> >
> > IIUC, the actual module ELF can go away while the kernel holds onto the
> > memory (as with initramfs). And even if that wasn't the case, in
> > containerized environments you may not be able to always see
> > /lib/modules or similar.
> 
> Indeed. Access to .ko files may be difficult even for full root
> without containers.
> 
> What is vmlinux BTF before/after for our current set of kfuncs ?

Before:

        $ pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlinux.btf
        $ ls -l .tmp_vmlinux.btf
        -rwxr-xr-x 1 dxu dxu 1159241688 Dec 22 13:44 .tmp_vmlinux.btf*


After:

        $ /home/dxu/dev/pahole/build/pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlinux.btf
        $ ls -l .tmp_vmlinux.btf
        -rwxr-xr-x 1 dxu dxu 1159248104 Dec 22 13:47 .tmp_vmlinux.btf*

1159248104 - 1159241688 = 6416, so ~17B per kfunc (although we are
currently overcounting kfuncs by a bit).

Btw, for some reason the file size is not quite reproducible. I'm seeing
~500B deltas every time I rerun the same command. Maybe I'm doing
something wrong? Not sure. 

Thanks,
Daniel

