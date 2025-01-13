Return-Path: <bpf+bounces-48706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016CFA0BE25
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 17:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735E1188823E
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A71F2297F4;
	Mon, 13 Jan 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="UUXsPsJj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSSyPd+J"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F920F096
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787524; cv=none; b=QfF0rEZRA+1cW1qc6gI4z+J8yc29JXxyGnMuDWCLFGg/usXUx1vCDNW8DZblCdb5mByvx2pbZIRH9MBsMaWIl2OALNM0A7EZuBXzp/R8qa8TfXqSJHVNYKThxK++sWdZ/mVLVH3j1WyofxoP8sD/8w8LH7VT89qZoFKDipKMnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787524; c=relaxed/simple;
	bh=yXD+k+D8yp0A2njrD8UaUidlCIGLETn/rMPZJ9l+zmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEal9WPZ7wH4BdqRVYBHqBQKcUGyU3vO0Ps9tFLMRkzu47eeVsC/XrFzuHCJxG2Xi9ONpVCjHsVhTDYYghVmb6XXg6JLS5utAizUH6IuhOWGcwBY3u8XtHGvwvWYvLLiLhi0+Kw8moC4lwy5/RpNCu/gnHlCQPhfxJTQJY7++dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=UUXsPsJj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSSyPd+J; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D94511401D2;
	Mon, 13 Jan 2025 11:58:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 13 Jan 2025 11:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736787521; x=1736873921; bh=rTf7OhjPBq
	cz6LXvRiTedV2f+sgP6kzLwvStfogEBLE=; b=UUXsPsJjbYFdd8tNDQBrU+8T8z
	riHVViudkuXC0WMmvOhTDT7hGWCyKeXjOwuoMUFyMvRsqFvZmU6rOFR0h0mcE005
	jlPtzCOxg+IUlL33UREgyCd5kTVeZPLpAwmr95Rz6Oh9/9unv2slrvbwrmDX8bDn
	borfc5KA1+MKEz3zkThVb8zdq7ZgTvhATHJ3cdzeH8rXWOc4mAjlkNYcsU0QPjtl
	QsNJ57FF5XX6oHVlcenr6vVBfgq20XGf/NhFQoYpwJPZFT0QgGqainCF6k2EsQDq
	TBFZPeoZbSIi+nB6utolDLRD2N9QPrvBac/BgChJxv/PVc+9CS2q8onwtPcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736787521; x=1736873921; bh=rTf7OhjPBqcz6LXvRiTedV2f+sgP6kzLwvS
	tfogEBLE=; b=CSSyPd+JF5YbE1RqOxl8dwChyDXXwLucMnk4uM4Fn54B5Ouw/o2
	vMH5VvoQ7ia3hhHBXY2BzPmFAtJohqxjnNTLAmvWvaPX5fBBY9bnBiraOOSqbEu8
	Url1NASSknO2iGp+9B7Nxkg/fVm5MF7jGzMvZGcKhCg/XsA8hpmZGjyD0AOz7tA6
	Mw8W1EyyzQOHB5s1Q+rt0paUvWYnRno2wVe5MtG5GfZAclU7pxcxxX+LqfK282o3
	PHRG4D6QvK62Bt3TFMUiuaiWco3lzHAon3yfD91P5s05KowktawKdyG6bSYp5Xqx
	H7hqrDIyvdK6BAKXMg9yxJP2xN23KqkUlMQ==
X-ME-Sender: <xms:QEaFZ4wwcd8DIAu8jvVaK8cNoEJk07anz-9zapElYCHZJ-PecnTP2w>
    <xme:QEaFZ8SP1UUWLnDt86WU-Qfr1tsiRhwGJE1g801G1Qa63xY5GOeWfVITZWaxeHpwD
    JZC6uK0b2Z2bXQFng>
X-ME-Received: <xmr:QEaFZ6WmKBM4LhO8VE864aGwlWtueZ8GxD9E0IOr8Bx7ZslUHU_YNFjgXXkSsvbJmMNH96qmJUdhWlp2nQOC0Gyno_kVIhr-HNJK-9oiuZIIbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesug
    iguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffek
    uedukeehudffudfffffggeeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvohhnrdhhfigrnh
    hgsehlihhnuhigrdguvghvpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurg
    hnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugi
    druggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehkvghrnhgvlhdqphgrth
    gthhgvshdqsghothesfhgsrdgtohhm
X-ME-Proxy: <xmx:QEaFZ2ieBqkjgYo5fVtLOwWFhLPNACzfiBK1SlwVu8Jgh6lHqd6lxA>
    <xmx:QEaFZ6CmRl6F2i2qEnxuzIb8FQfnoZ6YaaZ-XvkQZV851N2rjp2Imw>
    <xmx:QEaFZ3JOL3rkq85F0Qbs7gyJvzBNYBSxslAmPfMIZ59dQYyY6tOyRw>
    <xmx:QEaFZxBkVCbk-yjrJDmTnATNy0tYGncieAX4Waz-cDUmKtcA39dLyA>
    <xmx:QUaFZyspINwn8dxqXYYl0ue83GAatNZQxKR2Ys826coBbU8i6IUK5uQq>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 11:58:39 -0500 (EST)
Date: Mon, 13 Jan 2025 09:58:38 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com, 
	kernel-patches-bot@fb.com
Subject: Re: [RFC PATCH bpf-next 0/2] bpf: Introduce global percpu data
Message-ID: <jfo4cgmk76zibxylkclgw4u7j47phg2ic4ogilhgz52ddilsui@gc3hiffnezkc>
References: <20250113152437.67196-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113152437.67196-1-leon.hwang@linux.dev>

Hi Leon,

On Mon, Jan 13, 2025 at 11:24:35PM +0800, Leon Hwang wrote:
> This patch set introduces global per-CPU data, similar to commit
> 6316f78306c1 ("Merge branch 'support-global-data'"), to reduce restrictions
> in C for BPF programs.
> 
> With this enhancement, it becomes possible to define and use global per-CPU
> variables, much like the DEFINE_PER_CPU() macro in the kernel[0].
> 
> The idea stems from the bpflbr project[1], which itself was inspired by
> retsnoop[2]. During testing of bpflbr on the v6.6 kernel, two LBR
> (Last Branch Record) entries were observed related to the
> bpf_get_smp_processor_id() helper.
> 
> Since commit 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper"),
> the bpf_get_smp_processor_id() helper has been inlined on x86_64, reducing
> the overhead and consequently minimizing these two LBR records.
> 
> However, the introduction of global per-CPU data offers a more robust
> solution. By leveraging the percpu_array map and percpu instructions,
> global per-CPU data can be implemented intrinsically.
> 
> This feature also facilitates sharing per-CPU information between tail
> callers and callees or between freplace callers and callees through a
> shared global per-CPU variable. Previously, this was achieved using a
> 1-entry percpu map, which this patch set aims to improve upon.

I think this would be great to have. bpftrace would've liked to use this
for its recent big string support, but instead had to simulate a percpu
global through regular globals.

Thanks,
Daniel

