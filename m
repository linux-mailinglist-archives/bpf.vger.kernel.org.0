Return-Path: <bpf+bounces-45581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8682B9D8AE9
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 18:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF0C2895B3
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C861B6CFE;
	Mon, 25 Nov 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="iPiSsJIC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PVN4m1nM"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758FE1E48A;
	Mon, 25 Nov 2024 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554220; cv=none; b=LD4bP7jTtP0Gom4gRuRuQ35NxeAgfFdGOknpy9/y4o4PcHg1JIZxzAZpvwvRgoqS6DzEHL5YtZVSH6d4W8+VVXB8/g0lY8V/MMhjQDn2ZHeUA0HgbnvvL/zsM+lZCZGwd9UtKmALmLLfA2B1B091tsKxZwIy74i8ErqkB2gAW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554220; c=relaxed/simple;
	bh=tvx2+dddCua1RIHYiN/bk4phpUGsIfMLdciy141RWgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWwSnpStR3xAL91MLyJ4cVdtydmGoqGfuIsU4aaWuYIw1YMQYnaazKAjMCh5+j0y9RuG9A20DdWvkK2+rpNt58ZODwCj/tGEPA9v5Zj0jUnTFApiHvMWbcdR307fM941gSe2yilra0tdjTEbOEQSFdCQnDcFem35nEA5OemIOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=iPiSsJIC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PVN4m1nM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4EE801140194;
	Mon, 25 Nov 2024 12:03:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 25 Nov 2024 12:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1732554216; x=1732640616; bh=3opjGAU9QR
	QBmipUhTbClawhanaHRmChf076z90vHYU=; b=iPiSsJIC6qob8vajiMHx3xDkDz
	XyTHQkPxgcmzMof4NZbtjDVvtrW2vWgDNfjQb4vzxSBqZd3lTZHJmTHdlOC9/wH4
	akhzv79bQLA9tHcAmexpWz4CeJ/p/jDSte8RDtRqBtUR2yA+Cpc2zcuKla9IfLKy
	1I4InWNRgsZO9qrK7qWbaNJbDh2woEbqe6LVWburV32p04fmb+jptrDGg5Z3/XYd
	CSvZqmr0Wh+Wtm7Vv+8gugRaFit5vNFQ1FyP9r+QsbN+aalqKEw2xQ5djz98z4/M
	Wk/rtCKBeIyCjtpJdx4HTk+dK8mRDKnW3VNf+MZw16MI0b0Z+E8v16Tw9YPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732554216; x=1732640616; bh=3opjGAU9QRQBmipUhTbClawhanaHRmChf07
	6z90vHYU=; b=PVN4m1nMT6jnhVBOi0erdw6Zo+sEvs2f8arg1IwMhgPWnieks36
	SQaFMlnvjiPoRVb5LVk//O/r/t5ysGqgXLwFKVg3NpOIEK2WuVeleB9JWBEIfidc
	W6TQ1TX3/BKHkNQXswD04wOoIDazDltvjNz33W6fX6FYChOtquKzkybDLvlSH7VA
	f0h5ru39+qYofRKRLSxbqtHOOiO8B5iObya+HOGp1bDZnSGhjEE1uMZUo43xfIDa
	PGiad6SLutAohEQ4So68LGUSxPwK0k0ObRimROhhCvk93mjHJRtDeVjLxwtsNvFx
	4CZ1rq/vRjo6boWfg3N2Bo+RyofkND20+aw==
X-ME-Sender: <xms:561EZ_Fl9Otahpa_PCWs5XVYzTJqkkluCwou2gbnSiUQstVBuQWMkg>
    <xme:561EZ8UJyEonkKtpnEdiW2nxBsdPOR_3BMggYDzbxQelmEewB9R_4JLuOlHiygMJN
    t7FU_myiDOOAdziCg>
X-ME-Received: <xmr:561EZxJ_717LbZvJsHPoETXgwvfpQRQjUVqpXxA7x9HaWLHcWh5Z2ZVotlHAJedsO4iHowzoLi_7lLxV-Lfl9MlK_jMoMRxj-vlqWG3Pf9dzjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugi
    huuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeu
    udekheduffduffffgfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgtphht
    thhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvghkshgrnhguvg
    hrrdhlohgsrghkihhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghs
    theskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsoh
    igrdhnvghtpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhope
    hhrgifkheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:561EZ9Gynp2h_cINdeQKccecTVBlG7GGE4N_ta2cfdhWWB9DWfyuhw>
    <xmx:561EZ1WtKQTXT-N7XK2Ls6q12nem5aaeMA4NkVZgRVz5qgP5yxLGlQ>
    <xmx:561EZ4PHuzi1s8psExljuVZwEWaa0cSzjBSSdWO9RJOoyYAHeuKv_w>
    <xmx:561EZ002ldYIlHwFH4aRgTbGReL4a6SeRzw708NEKgdCHt2zRMvxqg>
    <xmx:6K1EZ2XiOSfpBcc7rzGmicqEUkLbiV1R640Dva6YV5ZhX9LtXr7pt5S8>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 12:03:33 -0500 (EST)
Date: Mon, 25 Nov 2024 10:03:31 -0700
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
Message-ID: <22h2giilfzjsof2ncuzaogzrgj4kzieqyhnufmyctwealrueum@fiytwllolnja>
References: <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk>
 <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk>
 <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>

On Mon, Nov 25, 2024 at 04:12:24PM GMT, Alexander Lobakin wrote:
> From: Daniel Xu <dxu@dxuuu.xyz>
> Date: Fri, 22 Nov 2024 17:10:06 -0700
> 
> > Hi Olek,
> > 
> > Here are the results.
> > 
> > On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
> >>
> >>
> >> On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
> 
> [...]
> 
> > Baseline (again)
> > 
> > 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
> > Run 1	3169917	        0.00007295	0.00007871	0.00009343		Run 1	21749.43
> > Run 2	3228290	        0.00007103	0.00007679	0.00009215		Run 2	21897.17
> > Run 3	3226746	        0.00007231	0.00007871	0.00009087		Run 3	21906.82
> > Run 4	3191258	        0.00007231	0.00007743	0.00009087		Run 4	21155.15
> > Run 5	3235653	        0.00007231	0.00007743	0.00008703		Run 5	21397.06
> > Average	3210372.8	0.000072182	0.000077814	0.00009087		Average	21621.126
> > 
> > cpumap v2 Olek
> > 
> > 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
> > Run 1	3253651	        0.00007167	0.00007807	0.00009343		Run 1	13497.57
> > Run 2	3221492	        0.00007231	0.00007743	0.00009087		Run 2	12115.53
> > Run 3	3296453	        0.00007039	0.00007807	0.00009087		Run 3	12323.38
> > Run 4	3254460	        0.00007167	0.00007807	0.00009087		Run 4	12901.88
> > Run 5	3173327	        0.00007295	0.00007871	0.00009215		Run 5	12593.22
> > Average	3239876.6	0.000071798	0.00007807	0.000091638		Average	12686.316
> > Delta	0.92%	        -0.53%	        0.33%	        0.85%			        -41.32%
> > 
> > 
> > It's very interesting that we see -40% tput w/ the patches. I went back
> 
> Oh no, I messed up something =\
> 
> Could you please also test not the whole series, but patches 1-3 (up to
> "bpf:cpumap: switch to GRO...") and 1-4 (up to "bpf: cpumap: reuse skb
> array...")? Would be great to see whether this implementation works
> worse right from the start or I just broke something later on.

Will do.

> 
> > and double checked and it seems the numbers are right. Here's the
> > some output from some profiles I took with:
> > 
> >     perf record -e cycles:k -a -- sleep 10
> >     perf --no-pager diff perf.data.baseline perf.data.withpatches > ...
> > 
> >     # Event 'cycles:k'
> >     # Baseline  Delta Abs  Shared Object                                                    Symbol
> >          6.13%     -3.60%  [kernel.kallsyms]                                                [k] _copy_to_iter
> 
> BTW, what CONFIG_HZ do you have on the kernel you're testing with?

# zgrep CONFIG_HZ /proc/config.gz
# CONFIG_HZ_PERIODIC is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000

Just curious - why do you ask?

Thanks,
Daniel

