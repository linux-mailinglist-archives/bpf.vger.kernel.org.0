Return-Path: <bpf+bounces-48155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48228A04943
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010693A547D
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACBB1F2C3F;
	Tue,  7 Jan 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="lPWWJopS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wrqdwHQ+"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99A1E0B77;
	Tue,  7 Jan 2025 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274760; cv=none; b=p2m3wWn3MzCeMZgFkXF0iU3wNtwFh0DOI4i+gnpLAqMGb1hIjWuLtTiaQu0JhraLbit1FsfJKFNbabrWpjGgQRvn4R+fTToRgc0qGkxOiqbKRs14JfxJmzBY2aZJaQ/LwPG1kTAMVyU9docVbitsn58woH7qS/3lJOhf8eMRFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274760; c=relaxed/simple;
	bh=EKM782amI9vYUxgRTf6vOkF88UA86p7NXMqsaSs5hJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjmbRzt8swOCgQ+lUsvqSAUw0KozBgcCcC9T/akKLmCnw+YlqgDTx/jkNoZfp8utXJtQNWYRhh1tEsHEJ6trr2MoOfa2u3BteefLn029Ugdu+gUoHJ1hgzHbkCsuc/wI9WhZcSyC5pDQnHuS4Yt93BI9YRQqr0E1bjnqJjJUYiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=lPWWJopS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wrqdwHQ+; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6FB0E2540194;
	Tue,  7 Jan 2025 13:32:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jan 2025 13:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736274757;
	 x=1736361157; bh=ero0bhVYss78rXpvpY8mLLVNO1z/zuMVleAPzC3cnTw=; b=
	lPWWJopStweVsx2WgcwyMQHnYgvRVR5P5QQ/+cdBLpx/cxnkpVoU1c5wQQXrAONE
	+F6UnitZk+FkmAjnNTYEgOdV3xhGdJRFiJrIBO1jrRV7xurh8FBJwGJfxR+fo9fb
	mgLoc/qyfu94wvvHRuQcuw4mnqlcd6Ny675dSw1yvlXm6iJIcn57x/NgjG6UB3gb
	wsYYz8EDCBlgW/bCHe5rV9Wr7gC/Rv/l6H+n2K52u91l/b/I/YktQEbuWdw4Pz9o
	ak41/lLEyF19yBIrj6aRxKAK6nu5MVvDLtK/RquRihGHL4DiayhjlBwihW+g1t5j
	NlEHAGbv8ySLwT8ENppnFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736274757; x=
	1736361157; bh=ero0bhVYss78rXpvpY8mLLVNO1z/zuMVleAPzC3cnTw=; b=w
	rqdwHQ+vvbAX9dtgUKdOJGnlGwzFyzirwn68hESXWA5zyOBa+i8214Vf3HCxlfhO
	W53V2IbsldY0Xoe72nv0u3wYK49rNDr4bYIZK8IPldusfmIfuMlNA9qG05rXQFN8
	p61cW6QngcvqaIXPaI8FZobjgcMvPBNfrL4V+1M1vjhAa2vLde0RVdzSmcBr019L
	Azitq7cJeJYL999HsX8Mw2sadpxoQL6WV+4Euw5jGx7s/0cs/EcL0dI9JJEBtNvT
	G23j6tNdgZhPg09U3maprFDD6zWVLk+h0NbJQlY0znN5/JndKsh4jZUD7MovCT09
	xLFTDqRcWRdqGRo8OvDHg==
X-ME-Sender: <xms:RXN9Z9wOYRW5QfHLpXOCaDJpubwiR7-Qwejn12m77Y0_ML_ww55aOA>
    <xme:RXN9Z9QXcxDQ54Q5zHfQm-gnYRMovbL2DPF_KwupcWVpGxjeNwk34NdyF-5tOG-MC
    2saXcKgxJ5EllK9oQ>
X-ME-Received: <xmr:RXN9Z3X1OS86i-thIenAvdYgH7Z1vma56PesTNS3W2NyturqjYM5v-hUFbF-QxMnkXC0leDxruL5NMxcgf-Gllvnjp014oSDZpW5W1V-4TD3tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffk
    fhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueek
    ffelteekkeekgeegffevtddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrghorghrrd
    hshhgrohesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgvgigvihdrshhtrghrohhv
    ohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphht
    thhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhogh
    gvrghrsghogidrnhgvthdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidr
    uggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephi
    honhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:RXN9Z_gM9DAfLgQQbsHPJASqwtANhqsCGPubn7Ye1UkSXhHwFrKeHQ>
    <xmx:RXN9Z_AZdFzT2Rfpivm5s9w9fE0rjnq5qnP93JK1iocgzr0djfPQ-w>
    <xmx:RXN9Z4JH4zaAD2D3mYk_nZO85KVvaCIhzj2Rkunibc_HElbnBLqFlw>
    <xmx:RXN9Z-DPeavk7KQU4Kddc_51yREJO-hfhSl6ZFB1XZ9jrlsRvktJpw>
    <xmx:RXN9Z71TZLpkT0ejvU7CUfVskcD2boI8Aa-v4po8ElPIsszL_-X60Tvz>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 13:32:35 -0500 (EST)
Date: Tue, 7 Jan 2025 11:32:33 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Add support for dynamic
 tracepoint
Message-ID: <vhiptl7wtjmitacwuvtacrzfawixttl7bdblc3ozeyzskqrhid@jjev6i3z3cj7>
References: <20250105124403.991-1-laoar.shao@gmail.com>
 <20250105124403.991-2-laoar.shao@gmail.com>
 <CAADnVQ+ga1ir9XCDxPiU_-eYzKHTQsiod9Sz4_o3XeqGW2rq4A@mail.gmail.com>
 <CALOAHbD+w3niwBojP=-81Wrqj1V9ppLgTfuZjb=AxXjx51MGRA@mail.gmail.com>
 <CAADnVQ+Cbq99wpNoijyJbvtqaMTAxQF_S-n8yf9+0JGHJnShLw@mail.gmail.com>
 <CALOAHbBxDnwkXXouYRiZcRPAic4k+JE5St7yJA8Fyrd9sw1ntw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBxDnwkXXouYRiZcRPAic4k+JE5St7yJA8Fyrd9sw1ntw@mail.gmail.com>

On Tue, Jan 07, 2025 at 10:41:46AM +0800, Yafang Shao wrote:
> On Tue, Jan 7, 2025 at 6:33 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Jan 5, 2025 at 6:32 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > On Mon, Jan 6, 2025 at 8:16 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Sun, Jan 5, 2025 at 4:44 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > >
> > > > > Dynamic tracepoints can be created using debugfs. For example:
> > > > >
> > > > >    echo 'p:myprobe kernel_clone args' >> /sys/kernel/debug/tracing/kprobe_events
> > > > >
> > > > > This command creates a new tracepoint under debugfs:
> > > > >
> > > > >   $ ls /sys/kernel/debug/tracing/events/kprobes/myprobe/
> > > > >   enable  filter  format  hist  id  trigger
> > > > >
> > > > > Although this dynamic tracepoint appears as a tracepoint, it is internally
> > > > > implemented as a kprobe. However, it must be attached as a tracepoint to
> > > > > function correctly in certain contexts.
> > > >
> > > > Nack.
> > > > There are multiple mechanisms to create kprobe/tp via text interfaces.
> > > > We're not going to mix them with the programmatic libbpf api.
> > >
> > > It appears that bpftrace still lacks support for adding a kprobe/tp
> > > and then attaching to it directly. Is that correct?
> >
> > what do you mean?
> 
> Take the inlined kernel function tcp_listendrop() as an example:
> 
> $ perf probe -a 'tcp_listendrop sk'
> Added new events:
>   probe:tcp_listendrop (on tcp_listendrop with sk)
>   probe:tcp_listendrop (on tcp_listendrop with sk)
>   probe:tcp_listendrop (on tcp_listendrop with sk)
>   probe:tcp_listendrop (on tcp_listendrop with sk)
>   probe:tcp_listendrop (on tcp_listendrop with sk)
>   probe:tcp_listendrop (on tcp_listendrop with sk)
>   probe:tcp_listendrop (on tcp_listendrop with sk)
>   probe:tcp_listendrop (on tcp_listendrop with sk)
> 
> You can now use it in all perf tools, such as:
> 
>         perf record -e probe:tcp_listendrop -aR sleep 1

Cool, I'm guessing perf-probe can speak DWARF and will parse all the
inline information.

> 
> Similarly, we can also use bpftrace to trace inlined kernel functions.
> For example:
> 
> - add a dynamic tracepoint
>   $ bpftrace probe -a 'tcp_listendrop sk'
> 
> - trace the dynamic tracepoint
>   $ bpftrace probe -e 'probe:tcp_listendrop {print(args->sk)}'
> 
> > bpftrace supports both kprobe attaching and tp too.
> 
> The dynamic tracepoint is not supported yet.
> 
> >
> > > What do you think about introducing this mechanism into bpftrace? With
> > > such a feature, we could easily attach to inlined kernel functions
> > > using bpftrace.
> >
> > Attaching to inlined funcs also sort-of works. It relies on dwarf,
> > and there is work in progress to add a special section to vmlinux
> > to annotate inlined sites, so it can work without dwarf.
> 
> What’s the benefit of doing this? Why not simply read the DWARF
> information directly from vmlinux?
> 
> $ readelf -S /boot/vmlinux  | grep debug_info
>   [63] .debug_info       PROGBITS         0000000000000000  03e2bc20
> 
> The DWARF information embedded in vmlinux makes it straightforward to
> trace inlined functions without requiring any kernel modifications.
> This approach allows all existing kernel releases to immediately take
> advantage of the functionality, eliminating the need for kernel
> recompilation or patching.

I'd disagree that this approach works with all existing kernels. Kernel
debuginfo is usually not available by default. On some distros, it's not
available at all.

This is particularly relevant for partial inlining - where compiler
inlines some callsites but leaves the symbol in. In these cases, users
trying to probe a symbol will succeed in attaching but then silently
lose events. There is no obvious way for user to know to install
debuginfo. Or to create dynamic tracepoints.

This is the motivation for always-available metadata. Something small
enough where distros can leave it on by default. Similar to motivation
for BTF. There's also overhead involved w/ parsing DWARF. A more compact
representation helps reduce overhead.

