Return-Path: <bpf+bounces-35658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B393C875
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 20:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B979B283241
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2780847A60;
	Thu, 25 Jul 2024 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6e8sGMu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080039AD5;
	Thu, 25 Jul 2024 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932842; cv=none; b=pF2WujRm2KFvXzZnMhrmwnMIiANYY7IFRifpwN39k3iqlJ22SSGPDOZQKtBbDt5uMyR4lgYu8h0KGNx5IiNy0GgvULc4acA7Dw0FPHMGODRWjjwQAYdo+LqJPf71+FcCvpcbt3iEaRHBuUsouuB5zqRsguX0C9Jd5cBx/l3sEwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932842; c=relaxed/simple;
	bh=ti9OgG1fket+Vo/GzksXCs7kfWJxrTXjBuZDRW6tBfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSYk9TPWTyBjsfE8l2szTUrDlxf4xSmFTAnwJMwDkv4FRuWsUgtr8A8Qzvdytifugmg3Cdtd+sCYHdaQjnaVqJB3WhfH7MrfdhcVPzB5AvQWUTAmmSO0qO5F+Z0ghD9Nu5kOMcNhq22UrnRKAWZhp9it7w8eTC4+bkesVwWlB3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6e8sGMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85118C116B1;
	Thu, 25 Jul 2024 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721932842;
	bh=ti9OgG1fket+Vo/GzksXCs7kfWJxrTXjBuZDRW6tBfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p6e8sGMuFNg3VBdLLFuf8mZ1FZT6qSWbFZOLV1GCNPpjn0GDEFfnya1Ie5zGCBkJb
	 vH9OmoZ21CsaO3A4PiCoZeVIXnSUd/KjzdV0YD2i2ggqJSQLeQX0AAIHy3/dYeSClc
	 auEs7fIrkM351YOMOfwd6nj/FDQfOHy0C4zLQbXDpI+yYcVdPrWYn3DiT/NOLkPsMy
	 WUJJv/6Ex/mFArIPxCdTSaz3bOZVMkwmP1h5PraqXVD71Tp2KPf1ZNGsUmTaoE2Rhy
	 oWdB/MKM1Iulz3g03ipszwIvK1pedRJPK5AUiYmGcCQt4a5Gs1oKaaxfAX4+ZveqGP
	 ISDhZOLp0Tdhg==
Date: Thu, 25 Jul 2024 11:40:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Manu Bretelle <chantra@meta.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: pull-request: bpf 2024-07-25
Message-ID: <20240725114040.26c1f483@kernel.org>
In-Reply-To: <76460C8C-42B3-454F-BD5D-2815E6FB598A@meta.com>
References: <20240725114312.32197-1-daniel@iogearbox.net>
	<20240725063054.0f82cff5@kernel.org>
	<ce07f53f-bbe3-77d1-df59-ab5ce9e750d2@iogearbox.net>
	<20240725071600.2b9c0f62@kernel.org>
	<76460C8C-42B3-454F-BD5D-2815E6FB598A@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 18:30:22 +0000 Manu Bretelle wrote:
> I did not play with llvm19 yet.
> 
> Checking the BPF CI netdev builds that went red yesterday 8pm PST leads to 
> https://github.com/kernel-patches/bpf/actions/runs/10087416772
> 
> BPF selftests build is failing with:
> 
>     CC bench_local_storage_create.o 
> 3298 CC bench_htab_mem.o 
> 3299 CC bench_bpf_crypto.o 
> 3300 BINARY xskxceiver 
> 3301 <command-line>: error: "_GNU_SOURCE" redefined [-Werror] 
> 3302 <command-line>: note: this is the location of the previous definition 
> 3303 BINARY xdp_hw_metadata 
> 3304 BINARY xdp_features 
> 3305 TEST-OBJ [test_maps] htab_map_batch_ops.test.o 
> 3306 TEST-OBJ [test_maps] lpm_trie_map_batch_ops.test.o 
> 3307 TEST-OBJ [test_maps] sk_storage_map.test.o 
> 3308 TEST-OBJ [test_maps] map_percpu_stats.test.o
> 
> across all combos or architectures/compilers. I did not see anything related to LLVM19 though.
> 
> last failing build was today 5:17 am PST https://github.com/kernel-patches/bpf/actions/runs/10093925751
> with the same symptoms.
> 
> First successful at 8:02am: https://github.com/kernel-patches/bpf/actions/runs/10096557745

Ugh, seems like the GitHub UI messes up Firefox's ability to search :(
I see it now, and it makes sense. Linus ended up with cc937dad85aea
which was supposed to never make it upstream.

On the LLVM19 I see this in all outputs:
ar: libLLVM.so.19.0: cannot open shared object file: No such file or directory

But presumably that's harmless, then.

