Return-Path: <bpf+bounces-45588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864CD9D8E38
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 22:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB261692F6
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 21:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853F1CB53D;
	Mon, 25 Nov 2024 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="YloAeGJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1CZkeMGg"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258514F9CF;
	Mon, 25 Nov 2024 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732571625; cv=none; b=WeaXiU89NGR/cTGeH3IH1Tc3ju+Vf4soyEg+4lYQqN9GlE/fOZhlFfcwHouOh/heewsxV5Jo/ECXMKZCerPls+xtpBkO8XtJPpVkVehWOHt6boUZS64s8eierYgJNXew+QxqKVtmeNg+BtzghMxSVaMtAV0DIV+IH+KD1Dr2YXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732571625; c=relaxed/simple;
	bh=9x6VMRSVJ50P1RsKBnG3BY3PF9r70a190ET17O/dxQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKL5JJOddeGp0vxHUr93DF4aex2qU2zj5NVsomEr/JzsyBicT9EiIxOMWTCRp8k24GW8KjsDcgLc0yeksSNq3FxM9gZq5feMSgJKoR1jg2+Q4mGuejybz8QMnTa4ANAmrNmJKsvBZwY53277qSPQp7N89OO0Nluzd3pdF/jZh7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=YloAeGJk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1CZkeMGg; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6764C2540194;
	Mon, 25 Nov 2024 16:53:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 16:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1732571621; x=1732658021; bh=JL/cMK59FQ
	CyoR4ZcakYyeoNMFfW0LAs9lWKxt/ya/8=; b=YloAeGJkhbRs+JXYd4OjxjwDCa
	P5IV5P3dmAb+GqUeNehKFCeImjjh1mI7EAbULPqt8EhdpeDW2qCFgACxAg1fxjOX
	VmloQ5W3wvoSNd/SzBxoqP0gP9fI/cHiBxaH6YJ+SlCNgpbQpFD3xex8RefXWYHB
	ajVHWFo50N8SSsrwxo77d40y0xfnO+hEJvtbma2D19Tp6v7AYh/I+J2/0KpeyJIO
	M2EeAASK+XXgXxAyKStxonDxLhxBUbDm6ZFHBMRW9QOlUgkx3U+Py8rH0B3znaR5
	9A9hCf/+uvqZ/oFFLslF3X+poJYuXegOf6i62fmTDjYO7KD4At3rzMizy2Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732571621; x=1732658021; bh=JL/cMK59FQCyoR4ZcakYyeoNMFfW0LAs9lW
	Kxt/ya/8=; b=1CZkeMGgmfHr6Z7UuI+CVBIsvxYc/rdn3OIFYg0Ten04ScTt5rF
	B6xUW4BXaEI27TsoPQxeDdsyC6I4htSiZIzbWUpqtT6pNYVR/fnMhiB9edwQMfsA
	iq13gRTpakVyYVwhUzT+VnfftsunaQTpLaZZ5bPXXKatjeA8FkNdv1PD6xo4CDIA
	lT+vbv7jHmqdbCZxnHZaVXITGqr8KgubTtzXpMtJlIkV9obaBDKPAfWFXUofOXdB
	1q7LCKB3ujcVyWIC1Ww+GM7cNDvVHnhGWpR+kiSRjPouLfLWIVAuJBbhjLdv2YgR
	+6r1nN2RgVbrKHyqDpnkTd+ODrAMP7koFdg==
X-ME-Sender: <xms:5PFEZzv61CUcwCo2jIuliHki_EeqirtfzG37rncFvwjwOQxOG0Soug>
    <xme:5PFEZ0ep2ZSDJjFkuxtIdA58OGERI9Yd36OWgPA7HHyKIYU17CW-riHoubYs0UGMm
    jS6xqM5GmettubvjA>
X-ME-Received: <xmr:5PFEZ2w1l4WmGPD2fTfn8jyejUvd3uxKlUwgCYJz1LAXFYPdsuP8Qax9gXq4l_gRLX0poWTKT_h3kvKyNTAg4O1pJy7GmLUtM6o5kRMZkrp2Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesug
    iguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffek
    uedukeehudffudfffffggeeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghp
    thhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrgifkheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghlvghkshgrnhguvghrrdhlohgsrghkihhnsehi
    nhhtvghlrdgtohhmpdhrtghpthhtoheplhhorhgvnhiioheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthht
    oheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrsh
    htrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:5PFEZyMz1OcgPfkGvfThJfF_vVMk7pLJxAN5aU3mrFN7gsM-eJHbIA>
    <xmx:5PFEZz_80hWzv-aUWrryztvf802f7n5B-RzCrbABIrHdoUxTr4_FGA>
    <xmx:5PFEZyWdcIbs5NOS6AR9lkhfVK_LlpOhhSN9dGWpTVjDkvFIitgU3Q>
    <xmx:5PFEZ0e429HyKjGX0Janwf-juoAN33c448aZ7eicRvOhMy5H_amI_w>
    <xmx:5fFEZwgtmjL1B498EKYPVzdm9MkoDkvizaiqK8Ey6hhNbueqza6ogSg2>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 16:53:39 -0500 (EST)
Date: Mon, 25 Nov 2024 14:53:37 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, kernel-team <kernel-team@cloudflare.com>, 
	mfleming@cloudflare.com
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Message-ID: <25ujrqfgfkyek2mxh2c2kuuvyt5dyx2e6uysujgv3q43ezab4s@aedwgrlhnvft>
References: <ZwZe6Bg5ZrXLkDGW@lore-desk>
 <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk>
 <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <fcaae4c8-4083-4eef-8cfe-3d1f7e340079@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcaae4c8-4083-4eef-8cfe-3d1f7e340079@kernel.org>

Hi Jesper,

On Mon, Nov 25, 2024 at 07:50:41PM GMT, Jesper Dangaard Brouer wrote:
> 
> 
> On 25/11/2024 16.12, Alexander Lobakin wrote:
> > From: Daniel Xu <dxu@dxuuu.xyz>
> > Date: Fri, 22 Nov 2024 17:10:06 -0700
> > 
> > > Hi Olek,
> > > 
> > > Here are the results.
> > > 
> > > On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
> > > > 
> > > > 
> > > > On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
> > 
> > [...]
> > 
> > > Baseline (again)
> > > 
> > > 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
> > > Run 1	3169917	        0.00007295	0.00007871	0.00009343		Run 1	21749.43
> > > Run 2	3228290	        0.00007103	0.00007679	0.00009215		Run 2	21897.17
> > > Run 3	3226746	        0.00007231	0.00007871	0.00009087		Run 3	21906.82
> > > Run 4	3191258	        0.00007231	0.00007743	0.00009087		Run 4	21155.15
> > > Run 5	3235653	        0.00007231	0.00007743	0.00008703		Run 5	21397.06
> > > Average	3210372.8	0.000072182	0.000077814	0.00009087		Average	21621.126
> > > 
> 
> We need to talk about what we are measuring, and how to control the
> experiment setup to get reproducible results.
> Especially controlling on what CPU cores our code paths are executing.
> 
> In above "baseline" case, we have two processes/tasks executing:
>  (1) RX-napi softirq/thread (until napi_gro_receive deliver to socket)
>  (2) Userspace netserver process TCP receiving data from socket.

"baseline" in this case is still cpumap, just without these GRO patches.

> 
> My experience is that you will see two noticeable different
> throughput performance results depending on whether (1) and (2) is
> executing on the *same* CPU (multi-tasking context-switching),
> or executing in parallel (e.g. pinned) on two different CPU cores.
> 
> The netperf command have an option
> 
>  -T lcpu,remcpu
>       Request that netperf be bound to local CPU lcpu and/or netserver be
> bound to remote CPU rcpu.
> 
> Verify setting by listing pinning like this:
>   for PID in $(pidof netserver); do taskset -pc $PID ; done
> 
> You can also set pinning runtime like this:
>  export CPU=2; for PID in $(pidof netserver); do sudo taskset -pc $CPU $PID;
> done
> 
> For troubleshooting, I like to use the periodic 1 sec (netperf -D1)
> output and adjust pinning runtime to observe the effect quickly.
> 
> My experience is unfortunately that TCP results have a lot of variation
> (thanks for incliding 5 runs in your benchmarks), as it depends on tasks
> timing, that can get affected by CPU sleep states. The systems CPU
> latency setting can be seen in /dev/cpu_dma_latency, which can be read
> like this:
> 
>  sudo hexdump --format '"%d\n"' /dev/cpu_dma_latency
> 
> For playing with changing /dev/cpu_dma_latency I choose to use tuned-adm
> as it requires holding the file open. E.g I play with these profiles:
> 
>  sudo tuned-adm profile throughput-performance
>  sudo tuned-adm profile latency-performance
>  sudo tuned-adm profile network-latency

Appreciate the tips - I should keep this saved somewhere.

> 
> 
> > > cpumap v2 Olek
> > > 
> > > 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
> > > Run 1	3253651	        0.00007167	0.00007807	0.00009343		Run 1	13497.57
> > > Run 2	3221492	        0.00007231	0.00007743	0.00009087		Run 2	12115.53
> > > Run 3	3296453	        0.00007039	0.00007807	0.00009087		Run 3	12323.38
> > > Run 4	3254460	        0.00007167	0.00007807	0.00009087		Run 4	12901.88
> > > Run 5	3173327	        0.00007295	0.00007871	0.00009215		Run 5	12593.22
> > > Average	3239876.6	0.000071798	0.00007807	0.000091638		Average	12686.316
> > > Delta	0.92%	        -0.53%	        0.33%	        0.85%			        -41.32%
> > > 
> > > 
> 
> 
> We now three processes/tasks executing:
>  (1) RX-napi softirq/thread (doing XDP_REDIRECT into cpumap)
>  (2) CPUmap kthread (until gro_receive_skb/gro_flush deliver to socket)
>  (3) Userspace netserver process TCP receiving data from socket.
> 
> Again, now the performance is going to depend on depending on which CPU
> cores the processes/tasks are running and whether some are sharing the
> same CPU. (There are both wakeup timing and cache-line effects).
> 
> There are now more combinations to test...
> 
> CPUmap is a CPU scaling facility, and you will likely also see different
> CPU utilization on the difference cores one you start to pin these to
> control the scenarios.
> 
> > > It's very interesting that we see -40% tput w/ the patches. I went back
> > 
> 
> Sad that we see -40% throughput...  but do we know what CPU cores the
> now three different tasks/processes run on(?)
> 

Roughly, yes. For context, my primary use case for cpumap is to provide
some degree of isolation between colocated containers on a single host.
In particular, colocation occurs on AMD Bergamo. And containers are
CPU pinned to their own CCX (roughly). My RX steering program ensures
RX packets destined to a specific container are cpumap redirected to any
of the container's pinned CPUs. It not only provides a good measure of
isolation but ensures resources are properly accounted.

So to answer your question of which CPUs the 3 things run on: cpumap
kthread and application run on the same set of cores. More than that,
they share the same L3 cache by design. irq/softirq is effectively
random given default RSS config and IRQ affinities.


> 
> > Oh no, I messed up something =\
> >  > Could you please also test not the whole series, but patches 1-3 (up to
> > "bpf:cpumap: switch to GRO...") and 1-4 (up to "bpf: cpumap: reuse skb
> > array...")? Would be great to see whether this implementation works
> > worse right from the start or I just broke something later on.
> > 
> > > and double checked and it seems the numbers are right. Here's the
> > > some output from some profiles I took with:
> > > 
> > >      perf record -e cycles:k -a -- sleep 10
> > >      perf --no-pager diff perf.data.baseline perf.data.withpatches > ...
> > > 
> > >      # Event 'cycles:k'
> > >      # Baseline  Delta Abs  Shared Object                                                    Symbol
> > >           6.13%     -3.60%  [kernel.kallsyms]                                                [k] _copy_to_iter
> > 
> 
> I really appreciate that you provide perf data and perf diff, but as
> described above, we need data and information on what CPU cores are
> running which workload.
> 
> Fortunately perf diff (and perf report) support doing like this:
>  perf diff --sort=cpu,symbol
> 
> But then you also need to control the CPUs used in experiment for the
> diff to work.
> 
> I hope I made sense as these kind of CPU scaling benchmarks are tricky,

Indeed, sounds quite tricky.

My understanding with GRO is that it's a powerful general purpose
optimization. Enough that it should rise above the usual noise on a
reasonably configured system (which mine is).

Maybe we can consider decoupling the cpumap GRO enablement with the
later optimizations?

So in Olek's above series, patches 1-3 seem like they would still
benefit from an simpler testbed. But the more targetted optimizations in
patch 4+ would probably justify a de-noised setup.  Possibly single host
with xdp-trafficgen or something.

Procedurally speaking, maybe it would save some wasted effort if
everyone agreed on the general approach before investing more time into
finer optimizations built on top of the basic GRO support?

Thanks,
Daniel

