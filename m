Return-Path: <bpf+bounces-46220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1899E625B
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDE2167382
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D72A21A0B;
	Fri,  6 Dec 2024 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="hQH8j92O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4bRuXdmE"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CAC256E;
	Fri,  6 Dec 2024 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445698; cv=none; b=EQXWPtNgKgM0j9fi9tkIbRug36JzU+sPMhylz5jbVPqRIyGAMWeFjHYHF1TWBNYBkUIdiI+selvwwgdHWZgxva0newd3rCnQryTZUufduGoWu9vl+2oQVsHRP/Mw8f+SLOVjsL0+4mk+dWAf0630BVLoZN+vSw7wyHNRbeMZnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445698; c=relaxed/simple;
	bh=4YRaRkNCs1Ym8aYWpQiGRC/nKo6caLq1UTaqW7/CRu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfAChlw2rztW5OMFCC95vciCgARjzvKALE7XffJMzniW5vSd8wWHGxwfJRzZZrP+yEcva2LOoMvgF8VL0hg9TiA2+bOcs9FN1oWM5SXI5CSJNqsCEf7TQULjuma4L1s8hnZyI6IeZbh7scPb7/B182qoo087qcmbfWbZNOGueCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=hQH8j92O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4bRuXdmE; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 88870114019B;
	Thu,  5 Dec 2024 19:41:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 05 Dec 2024 19:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733445694; x=1733532094; bh=6i3rNGjHty
	SObRTQF69DECslsTBY5WLVg+C35NqYBIc=; b=hQH8j92OVJPrjJghUWSuPt8EKX
	gXrdRrIkT1FkmXfaFmDKhra7LVQolAF356XAKY8ekajaO/aGgkV3wLa8FbkCmnqm
	kMKSNYt7IT2BHkpByFsdkojCSEIvNHRhMAsdrgmznhr7ei5Heb4nEM/zKzF3QDIE
	P5YIvixlUZdNHnZ9osn8JQQzWr8nahLa74gN+07uCkeG69eN84yqQCDUqg6WTUmp
	wfa3L3HuQRByk1tXcoiOS/b87hWzbZHERn8hNQQagyiRFDndK9tkTCEMnHXTjuRY
	nWixsVMak/AGXBG+D+anI3bnd4AmatmRviFbyDeTFBMOGLT6+sskawt2b2dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733445694; x=1733532094; bh=6i3rNGjHtySObRTQF69DECslsTBY5WLVg+C
	35NqYBIc=; b=4bRuXdmE6CKj2mmDSx1z4b+Cxyfc/vFUJKfv5jEKFXWxXXLBl2W
	z7U4t8jfRCZXgWGsjE+i+FWYGCUloM3lBnr/vU8+uLGrj7/fkgpBYypTOudDyKHW
	5kbqrqjwT4ET+mCZqz2swhq8Otjnic7A0WtHBLbWJ7WUp+05I4UNPfGspN2DauBn
	8quNkimlvU0EBXKYPFATp64tsRCxQUk6UP3BaHGM4rdKTfyu0M+12wLuXJU2L9Dp
	kIyEVrkUgeYyXc5fHytPdTjffmQ1Nlu961U3bzQ7vzyMBJhxBYk1F6n2uxq9H2Eo
	MRfycqTx9QIrRpK2EYu+vd/qTZZC0SD+I3A==
X-ME-Sender: <xms:PUhSZ8LgLO-pkqtrQg02ztMgtc4ZDcbCvJxa4NI0rOU3MUCCtxT2rg>
    <xme:PUhSZ8Ia2N77Y3yAaj-nYlxpB72EZ40t3qRCr-tkaejTKyj_bHxC9BV9lkDdS8tnu
    e6dTbQmCAAmAzjUZA>
X-ME-Received: <xmr:PUhSZ8sIRuj5R_KSaBXhIfhQGsWLpcOQ5USxXTSMc9wjSxxiI3racvJk3SY_SuC4JBmDXXJHIf6SqYC7ZlnTCV2bd_yp92L7E3bCKfRK8w5EBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugi
    huuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeu
    udekheduffduffffgfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgtphht
    thhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvghkshgrnhguvg
    hrrdhlohgsrghkihhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlohhrvghniihordgsihgrnhgtohhnihesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhorhgvnhiioheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrsh
    htsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsgho
    gidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:PUhSZ5aMvztSkyeN3CtpioEPUSq0fpToNW9X4gV_xkvncjDRKNoSjw>
    <xmx:PUhSZzZkaXPdqIWoVwmHOHbgbjFX4Ej9MNjSuU66qNrcsI99RdHFeg>
    <xmx:PUhSZ1DLlopfkrG7xk8wGPyJNN6rGBXuKhXxqtVHxDxNssDxZdBT2Q>
    <xmx:PUhSZ5YCPL0Cdcmboq6nP03ez45WLVDx531WR7tL3iKGHuUmZVceDg>
    <xmx:PkhSZ0JXSv-lDPUHX-G2CaiFPl7nocSGJ2acbGT8dWIcD6IJIJ2oARmI>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 19:41:29 -0500 (EST)
Date: Thu, 5 Dec 2024 17:41:27 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Message-ID: <yzda66wro5twmzpmjoxvy4si5zvkehlmgtpi6brheek3sj73tj@o7kd6nurr3o6>
References: <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
 <6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
 <20241202144739.7314172d@kernel.org>
 <4f49d319-bd12-4e81-9516-afd1f1a1d345@intel.com>
 <20241203165157.19a85915@kernel.org>
 <a0f4d9d8-86da-41f1-848d-32e53c092b34@intel.com>
 <ad43f37e-6e39-4443-9d42-61ebe8f78c54@app.fastmail.com>
 <51c6e099-b915-4597-9f5a-3c51b1a4e2c6@intel.com>
 <27b2c3d4-c866-471c-ab33-e132370751e3@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27b2c3d4-c866-471c-ab33-e132370751e3@intel.com>

On Thu, Dec 05, 2024 at 12:06:29PM GMT, Alexander Lobakin wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Thu, 5 Dec 2024 11:38:11 +0100
> 
> > From: Daniel Xu <dxu@dxuuu.xyz>
> > Date: Wed, 04 Dec 2024 13:51:08 -0800
> > 
> >>
> >>
> >> On Wed, Dec 4, 2024, at 8:42 AM, Alexander Lobakin wrote:
> >>> From: Jakub Kicinski <kuba@kernel.org>
> >>> Date: Tue, 3 Dec 2024 16:51:57 -0800
> >>>
> >>>> On Tue, 3 Dec 2024 12:01:16 +0100 Alexander Lobakin wrote:
> >>>>>>> @ Jakub,  
> >>>>>>
> >>>>>> Context? What doesn't work and why?  
> >>>>>
> >>>>> My tests show the same perf as on Lorenzo's series, but I test with UDP
> >>>>> trafficgen. Daniel tests TCP and the results are much worse than with
> >>>>> Lorenzo's implementation.
> >>>>> I suspect this is related to that how NAPI performs flushes / decides
> >>>>> whether to repoll again or exit vs how kthread does that (even though I
> >>>>> also try to flush only every 64 frames or when the ring is empty). Or
> >>>>> maybe to that part of the kthread happens in process context outside any
> >>>>> softirq, while when using NAPI, the whole loop is inside RX softirq.
> >>>>>
> >>>>> Jesper said that he'd like to see cpumap still using own kthread, so
> >>>>> that its priority can be boosted separately from the backlog. That's why
> >>>>> we asked you whether it would be fine to have cpumap as threaded NAPI in
> >>>>> regards to all this :D
> >>>>
> >>>> Certainly not without a clear understanding what the problem with 
> >>>> a kthread is.
> >>>
> >>> Yes, sure thing.
> >>>
> >>> Bad thing's that I can't reproduce Daniel's problem >_< Previously, I
> >>> was testing with the UDP trafficgen and got up to 80% improvement over
> >>> the baseline. Now I tested TCP and got up to 70% improvement, no
> >>> regressions whatsoever =\
> >>>
> >>> I don't know where this regression on Daniel's setup comes from. Is it
> >>> multi-thread or single-thread test? 
> >>
> >> 8 threads with 16 flows over them (-T8 -F16)
> >>
> >>> What app do you use: iperf, netperf,
> >>> neper, Microsoft's app (forgot the name)?
> >>
> >> neper, tcp_stream.
> > 
> > Let me recheck with neper -T8 -F16, I'll post my results soon.
> 
> kernel     direct T1    direct T8F16    cpumap    cpumap T8F16
> clean      28           51              13        9               Gbps
> GRO        28           51              26        18              Gbps
> 
> 100% gain, no regressions =\
> 
> My XDP prog is simple (upstream xdp-tools repo with no changes):
> 
> numactl -N 0 xdp-tools/xdp-bench/xdp-bench redirect-cpu -c 23 -s -p
> no-touch ens802f0np0
> 
> IOW it simply redirects everything to CPU 23 (same NUMA node) from any
> Rx queue without looking into headers or packet.
> Do you test with more sophisticated XDP prog?

Great reminder... my prog is a bit more sophisticated. I forgot we were
doing latency tracking by inserting a timestamp into frame metadata. But
not clearing it after it was read on remote CPU, which disables GRO. So
previous test was paying the penalty of fixed GRO overhead without
getting any packet merges.

Once I fixed up prog to reset metadata pointer I could see the wins.
Went from 21621.126 Mbps -> 25546.47 Mbps for a ~18% win in tput. No
latency changes.

Sorry about the churn.

Daniel

