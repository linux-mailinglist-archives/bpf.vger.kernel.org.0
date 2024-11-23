Return-Path: <bpf+bounces-45487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6269D66A0
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 01:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B433516131C
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 00:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5222F46;
	Sat, 23 Nov 2024 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="RCsIxjg+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VljpZ3TF"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E9195;
	Sat, 23 Nov 2024 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732320614; cv=none; b=fEYQ9V1RZLgQf++I+BDlo9AeWjnbH1J8k1xiw3QlnHtIwagb3DuyIEcz6T2UlC94Sq1LM0P4ZV5Y3jxbwoigoJj1fE3nJf3dLJTGXDnBw+jS8nwIogaveQ+pKWf7mGHoI9VfLabXeUU7c9aXmd9Ni/Ap2ZJOpLffWmzzHePgjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732320614; c=relaxed/simple;
	bh=CDuy1w4CRDMKyzlLTFKuYNMg9d95zdO9t8plFqXqpl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0DpjSRin9Qx8dKwdu+KALHmHtUDt0E6POddIPJa+sfpQIIXCSg/93wIVE6aIsjttKIuLuI4oSA90iRVv6GLuep7OKtgFmo30bUnYgkPP4YR/h48Px2dphJyJukjZOUEtm1lTNUAspAUrA8aDrsvcy85Ry3kPyZREvsRd2BlTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=RCsIxjg+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VljpZ3TF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F2D19138028F;
	Fri, 22 Nov 2024 19:10:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 22 Nov 2024 19:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1732320610; x=1732407010; bh=h3ntGGpmQz
	DLrzbvspLwg+vfXkK482jNt/833ll3F+k=; b=RCsIxjg+OOiW3X+AaS7K6Ea9xI
	1pfblAfhSFLQLUMawu3nxtoJ2q1ZUrFuw0bmp3ZF2g8dXuMEZEsyjOtshI3qPWT6
	caa13oVUOVZMaISpH7VPMLG6kDMszUSo6Gs8q+Hk0z1EY1mSaWK+55VwoPqdPQXd
	7adY5RprdnLZ0qVKheSpoAa1Xmv1jrpSpQPEJ4QwdFyIP6BBEB0RBgb0rWdy+Hcw
	7ckCFnVq7gbFMQxYRx41US3R6HV3cYhJZr97PrPBy9KwyPG8tIOkkAOKW44y9cpd
	40RMnOnh9Igtc5g+jdSK4qlxZROi8Dp9mBeYXCPwAGeAvE9noxn43kE6SEFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732320610; x=1732407010; bh=h3ntGGpmQzDLrzbvspLwg+vfXkK482jNt/8
	33ll3F+k=; b=VljpZ3TFaugFuLXPIphWLiePUKktNz3E9RxKbBXdBaAQRhWPcyi
	SNb4gWkyRMXbS7zZ/UdXPGxCuPD4ClkQ4g6ZtxJve4Ml0CoHNoOmyzKzMVAcgALu
	rZTRBjoUgo+YQn/7gQz67YMJNmqtwXCMDyE5mNhVIrdPVJLZtyJEC/ep5lT2aBBk
	rF0rAVRi75ZWJt6pfDAvItVY9mBbHWXT1MQJQSmHMhWGHG9ggzd680iWtfuDFWIl
	NxChJg2X0jE1DRcpSMMXVOALYG2GLHTK9gzrrD9B1wLudeT0tmsFyqCo4l3njzqf
	Znoy431ONCFAhoGIp27S98si0rCBI8EPqOg==
X-ME-Sender: <xms:Yh1BZw6cioD0zuHwzFgJrCHMotEtaoavbbrbAguqeTtY1h3QZ8Jw1A>
    <xme:Yh1BZx4iF4xLbafzC6ldDcR7RKvZV3xMozju1cIHj52nEtyA5t8Cw3NG89CQq0MXV
    C_I7bBv5AFz49bWmQ>
X-ME-Received: <xmr:Yh1BZ_fSiN2j310NyR_Iw8kRGgYZtuoEjrd_DhhtLm0p6GK-wNpBaMQpfCNhiR_rxcZFmhif8-zDF5un7JX6ZtHp_Ixm-kKd14AQNH1qXurutg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgedtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugi
    huuhhurdighiiiqeenucggtffrrghtthgvrhhnpedtjeekudelieetvdefgedvgeejhefh
    vdfggfejudeutdegveeivedthfehfeelkeenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugig
    uhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegrlhgvkhhsrghnuggvrhdrlhhosggrkhhinhesihhnthgvlhdr
    tghomhdprhgtphhtthhopehlohhrvghniihosehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgu
    rhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnh
    gusehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Yh1BZ1IpYzOyGQPKAEQRz9mpBXjM3d-OKVqtRAIffmxS8pV6604xfQ>
    <xmx:Yh1BZ0IINGi9SQQmvKZHDZUQAzzi47L-H53a4FT3atH99qy-0ujCxA>
    <xmx:Yh1BZ2xsUXe-Q1RDJYjoW70iEy9YfXNqKjKIa6cWh7Zcls_97U1vyg>
    <xmx:Yh1BZ4LDQQNs4NAVSJ5kvgTaxAbWeIXWMrrBqhVMBaQFmzrAP9MQ4g>
    <xmx:Yh1BZx7dq0XcEOfuIF1i9pG2FxSEYLzLlckmEUTAkf02qkGTrDiVkL6C>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Nov 2024 19:10:08 -0500 (EST)
Date: Fri, 22 Nov 2024 17:10:06 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Message-ID: <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk>
 <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk>
 <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>

Hi Olek,

Here are the results.

On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
>
>
> On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
> > From: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Date: Tue, 22 Oct 2024 17:51:43 +0200
> >
> >> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> >> Date: Wed, 9 Oct 2024 14:50:42 +0200
> >>
> >>> From: Lorenzo Bianconi <lorenzo@kernel.org>
> >>> Date: Wed, 9 Oct 2024 14:47:58 +0200
> >>>
> >>>>> From: Lorenzo Bianconi <lorenzo@kernel.org>
> >>>>> Date: Wed, 9 Oct 2024 12:46:00 +0200
> >>>>>
> >>>>>>> Hi Lorenzo,
> >>>>>>>
> >>>>>>> On Mon, Sep 16, 2024 at 12:13:42PM GMT, Lorenzo Bianconi wrote:
> >>>>>>>> Add GRO support to cpumap codebase moving the cpu_map_entry kthread to a
> >>>>>>>> NAPI-kthread pinned on the selected cpu.
> >>>>>>>>
> >>>>>>>> Changes in rfc v2:
> >>>>>>>> - get rid of dummy netdev dependency
> >>>>>>>>
> >>>>>>>> Lorenzo Bianconi (3):
> >>>>>>>>   net: Add napi_init_for_gro routine
> >>>>>>>>   net: add napi_threaded_poll to netdevice.h
> >>>>>>>>   bpf: cpumap: Add gro support
> >>>>>>>>
> >>>>>>>>  include/linux/netdevice.h |   3 +
> >>>>>>>>  kernel/bpf/cpumap.c       | 123 ++++++++++++++++----------------------
> >>>>>>>>  net/core/dev.c            |  27 ++++++---
> >>>>>>>>  3 files changed, 73 insertions(+), 80 deletions(-)
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> 2.46.0
> >>>>>>>>
> >>>>>>>
> >>>>>>> Sorry about the long delay - finally caught up to everything after
> >>>>>>> conferences.
> >>>>>>>
> >>>>>>> I re-ran my synthetic tests (including baseline). v2 is somehow showing
> >>>>>>> 2x bigger gains than v1 (~30% vs ~14%) for tcp_stream. Again, the only
> >>>>>>> variable I changed is kernel version - steering prog is active for both.
> >>>>>>>
> >>>>>>>
> >>>>>>> Baseline (again)
> >>>>>>>
> >>>>>>> ./tcp_rr -c -H $TASK_IP -p 50,90,99 -T4 -F8 -l30			        ./tcp_stream -c -H $TASK_IP -T8 -F16 -l30
> >>>>>>>
> >>>>>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
> >>>>>>> Run 1	2560252	        0.00009087	0.00010495	0.00011647		Run 1	15479.31
> >>>>>>> Run 2	2665517	        0.00008575	0.00010239	0.00013311		Run 2	15162.48
> >>>>>>> Run 3	2755939	        0.00008191	0.00010367	0.00012287		Run 3	14709.04
> >>>>>>> Run 4	2595680	        0.00008575	0.00011263	0.00012671		Run 4	15373.06
> >>>>>>> Run 5	2841865	        0.00007999	0.00009471	0.00012799		Run 5	15234.91
> >>>>>>> Average	2683850.6	0.000084854	0.00010367	0.00012543		Average	15191.76
> >>>>>>>
> >>>>>>> cpumap NAPI patches v2
> >>>>>>>
> >>>>>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
> >>>>>>> Run 1	2577838	        0.00008575	0.00012031	0.00013695		Run 1	19914.56
> >>>>>>> Run 2	2729237	        0.00007551	0.00013311	0.00017663		Run 2	20140.92
> >>>>>>> Run 3	2689442	        0.00008319	0.00010495	0.00013311		Run 3	19887.48
> >>>>>>> Run 4	2862366	        0.00008127	0.00009471	0.00010623		Run 4	19374.49
> >>>>>>> Run 5	2700538	        0.00008319	0.00010367	0.00012799		Run 5	19784.49
> >>>>>>> Average	2711884.2	0.000081782	0.00011135	0.000136182		Average	19820.388
> >>>>>>> Delta	1.04%	        -3.62%	        7.41%	        8.57%			        30.47%
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Daniel
> >>>>>>
> >>>>>> Hi Daniel,
> >>>>>>
> >>>>>> cool, thx for testing it.
> >>>>>>
> >>>>>> @Olek: how do we want to proceed on it? Are you still working on it or do you want me
> >>>>>> to send a regular patch for it?
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> I had a small vacation, sorry. I'm starting working on it again today.
> >>>>
> >>>> ack, no worries. Are you going to rebase the other patches on top of it
> >>>> or are you going to try a different approach?
> >>>
> >>> I'll try the approach without NAPI as Kuba asks and let Daniel test it,
> >>> then we'll see.
> >>
> >> For now, I have the same results without NAPI as with your series, so
> >> I'll push it soon and let Daniel test.
> >>
> >> (I simply decoupled GRO and NAPI and used the former in cpumap, but the
> >>  kthread logic didn't change)
> >>
> >>>
> >>> BTW I'm curious how he got this boost on v2, from what I see you didn't
> >>> change the implementation that much?
> >
> > Hi Daniel,
> >
> > Sorry for the delay. Please test [0].
> >
> > [0] https://github.com/alobakin/linux/commits/cpumap-old
> >
> > Thanks,
> > Olek
>
> Ack. Will do probably early next week.
>

Baseline (again)

	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
Run 1	3169917	        0.00007295	0.00007871	0.00009343		Run 1	21749.43
Run 2	3228290	        0.00007103	0.00007679	0.00009215		Run 2	21897.17
Run 3	3226746	        0.00007231	0.00007871	0.00009087		Run 3	21906.82
Run 4	3191258	        0.00007231	0.00007743	0.00009087		Run 4	21155.15
Run 5	3235653	        0.00007231	0.00007743	0.00008703		Run 5	21397.06
Average	3210372.8	0.000072182	0.000077814	0.00009087		Average	21621.126

cpumap v2 Olek

	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
Run 1	3253651	        0.00007167	0.00007807	0.00009343		Run 1	13497.57
Run 2	3221492	        0.00007231	0.00007743	0.00009087		Run 2	12115.53
Run 3	3296453	        0.00007039	0.00007807	0.00009087		Run 3	12323.38
Run 4	3254460	        0.00007167	0.00007807	0.00009087		Run 4	12901.88
Run 5	3173327	        0.00007295	0.00007871	0.00009215		Run 5	12593.22
Average	3239876.6	0.000071798	0.00007807	0.000091638		Average	12686.316
Delta	0.92%	        -0.53%	        0.33%	        0.85%			        -41.32%


It's very interesting that we see -40% tput w/ the patches. I went back
and double checked and it seems the numbers are right. Here's the
some output from some profiles I took with:

    perf record -e cycles:k -a -- sleep 10
    perf --no-pager diff perf.data.baseline perf.data.withpatches > ...

    # Event 'cycles:k'
    # Baseline  Delta Abs  Shared Object                                                    Symbol
         6.13%     -3.60%  [kernel.kallsyms]                                                [k] _copy_to_iter
     3.57%     -2.56%  bpf_prog_954ab9c8c8b5e42f_latency                                [k] bpf_prog_954ab9c8c8b5e42f_latency
               +2.22%  bpf_prog_5c74b34eb24d5c9b_steering                               [k] bpf_prog_5c74b34eb24d5c9b_steering
     2.61%     -1.88%  [kernel.kallsyms]                                                [k] __skb_datagram_iter
     0.55%     +1.53%  [kernel.kallsyms]                                                [k] acpi_processor_ffh_cstate_enter
     4.52%     -1.46%  [kernel.kallsyms]                                                [k] read_tsc
     0.34%     +1.42%  [kernel.kallsyms]                                                [k] __slab_free
     0.97%     +1.18%  [kernel.kallsyms]                                                [k] do_idle
     1.35%     +1.17%  [kernel.kallsyms]                                                [k] cpuidle_enter_state
     1.89%     -1.15%  [kernel.kallsyms]                                                [k] tcp_ack
     2.08%     +1.14%  [kernel.kallsyms]                                                [k] _raw_spin_lock
               +1.13%  <redacted>
     0.22%     +1.02%  [kernel.kallsyms]                                                [k] __sock_wfree
     2.23%     -1.02%  [kernel.kallsyms]                                                [k] bpf_dynptr_slice
     0.00%     +0.98%  [kernel.kallsyms]                                                [k] tcp6_gro_receive
     2.91%     -0.98%  [kernel.kallsyms]                                                [k] csum_partial
     0.62%     +0.94%  [kernel.kallsyms]                                                [k] skb_release_data
               +0.81%  [kernel.kallsyms]                                                [k] memset
     0.16%     +0.74%  [kernel.kallsyms]                                                [k] bnxt_tx_int
     0.00%     +0.74%  [kernel.kallsyms]                                                [k] dev_gro_receive
     0.36%     +0.74%  [kernel.kallsyms]                                                [k] __tcp_transmit_skb
               +0.72%  [kernel.kallsyms]                                                [k] tcp_gro_receive
     1.10%     -0.66%  [kernel.kallsyms]                                                [k] ep_poll_callback
     1.52%     -0.65%  [kernel.kallsyms]                                                [k] page_pool_put_unrefed_netmem
     0.75%     -0.57%  [kernel.kallsyms]                                                [k] bnxt_rx_pkt
     1.10%     +0.56%  [kernel.kallsyms]                                                [k] native_sched_clock
     0.16%     +0.53%  <redacted>
     0.83%     -0.53%  [kernel.kallsyms]                                                [k] skb_try_coalesce
     0.60%     +0.53%  [kernel.kallsyms]                                                [k] eth_type_trans
     1.65%     -0.51%  [kernel.kallsyms]                                                [k] _raw_spin_lock_irqsave
     0.14%     +0.50%  [kernel.kallsyms]                                                [k] bnxt_start_xmit
     0.54%     -0.48%  [kernel.kallsyms]                                                [k] __skb_frag_unref
     0.91%     +0.48%  [cls_bpf]                                                        [k] 0x0000000000000010
     0.00%     +0.47%  [kernel.kallsyms]                                                [k] ipv6_gro_receive
     0.76%     -0.45%  [kernel.kallsyms]                                                [k] tcp_rcv_established
     0.94%     -0.45%  [kernel.kallsyms]                                                [k] __inet6_lookup_established
     0.31%     +0.43%  [kernel.kallsyms]                                                [k] __sched_text_start
     0.21%     +0.43%  [kernel.kallsyms]                                                [k] poll_idle
     0.91%     -0.42%  [kernel.kallsyms]                                                [k] tcp_try_coalesce
     0.91%     -0.42%  [kernel.kallsyms]                                                [k] kmem_cache_free
     1.13%     +0.42%  [kernel.kallsyms]                                                [k] __bnxt_poll_work
     0.48%     -0.41%  [kernel.kallsyms]                                                [k] tcp_urg
               +0.39%  [kernel.kallsyms]                                                [k] memcpy
     0.51%     -0.38%  [kernel.kallsyms]                                                [k] _raw_read_unlock_irqrestore
               +0.38%  [kernel.kallsyms]                                                [k] __skb_gro_checksum_complete
               +0.37%  [kernel.kallsyms]                                                [k] irq_entries_start
     0.16%     +0.36%  [kernel.kallsyms]                                                [k] bpf_sk_storage_get
     0.62%     -0.36%  [kernel.kallsyms]                                                [k] page_pool_refill_alloc_cache
     0.08%     +0.35%  [kernel.kallsyms]                                                [k] ip6_finish_output2
     0.14%     +0.34%  [kernel.kallsyms]                                                [k] bnxt_poll_p5
     0.06%     +0.33%  [sch_fq]                                                         [k] 0x0000000000000020
     0.04%     +0.32%  [kernel.kallsyms]                                                [k] __dev_queue_xmit
     0.75%     -0.32%  [kernel.kallsyms]                                                [k] __xdp_build_skb_from_frame
     0.67%     -0.31%  [kernel.kallsyms]                                                [k] sock_def_readable
     0.05%     +0.31%  [kernel.kallsyms]                                                [k] netif_skb_features
               +0.30%  [kernel.kallsyms]                                                [k] tcp_gro_pull_header
     0.49%     -0.29%  [kernel.kallsyms]                                                [k] napi_pp_put_page
     0.18%     +0.29%  [kernel.kallsyms]                                                [k] call_function_single_prep_ipi
     0.40%     -0.28%  [kernel.kallsyms]                                                [k] _raw_read_lock_irqsave
     0.11%     +0.27%  [kernel.kallsyms]                                                [k] raw6_local_deliver
     0.18%     +0.26%  [kernel.kallsyms]                                                [k] ip6_dst_check
     0.42%     -0.26%  [kernel.kallsyms]                                                [k] netif_receive_skb_list_internal
     0.05%     +0.26%  [kernel.kallsyms]                                                [k] __qdisc_run
     0.75%     +0.25%  [kernel.kallsyms]                                                [k] __build_skb_around
     0.05%     +0.25%  [kernel.kallsyms]                                                [k] htab_map_hash
     0.09%     +0.24%  [kernel.kallsyms]                                                [k] net_rx_action
     0.07%     +0.23%  <redacted>
     0.45%     -0.23%  [kernel.kallsyms]                                                [k] migrate_enable
     0.48%     -0.23%  [kernel.kallsyms]                                                [k] mem_cgroup_charge_skmem
     0.26%     +0.23%  [kernel.kallsyms]                                                [k] __switch_to
     0.15%     +0.22%  [kernel.kallsyms]                                                [k] sock_rfree
     0.30%     -0.22%  [kernel.kallsyms]                                                [k] tcp_add_backlog

     <snip>

     5.68%             bpf_prog_17fea1bb6503ed98_steering                               [k] bpf_prog_17fea1bb6503ed98_steering
     2.10%             [kernel.kallsyms]                                                [k] __skb_checksum_complete
     0.71%             [kernel.kallsyms]                                                [k] __memset
     0.54%             [kernel.kallsyms]                                                [k] __memcpy
     0.18%             [kernel.kallsyms]                                                [k] __irqentry_text_start

     <snip>

Please let me know if you want me to collect any other data.

Thanks,
Daniel

