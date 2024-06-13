Return-Path: <bpf+bounces-32101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 407249077D0
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 18:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D951F23B88
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F323B1311A1;
	Thu, 13 Jun 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QbkfydBZ"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D87AA23;
	Thu, 13 Jun 2024 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294798; cv=none; b=OiWnLaaFeed8NrTmfectVqWkBjrdIp5K+7VZEYM79UX9FeH6s3DBSlJoJGjJx/mU3C6A/fEWnIS4Nx6OTZ8zu4Bgvz+8wLoaNJS+nJaHggnwuXNJw5pdYgi6BXguPrd+RDUyv3M4fFiGNiia52Qoj9/AcAIGYnKy3IcxlLQc2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294798; c=relaxed/simple;
	bh=Pb3EEjAGN0nezQ9jSkjeRX/Hq+KcFqJc+RoeI8vNR68=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RCMyIGCu+ewgPxqNXqa1Gkiu2Y9FfmVkOHFf+0x3dEUrlIoYBmHvtGm9l6Hqfpe/Ga2jdZ9aNgN6Mio6rMUp+AXmogo75UzGhUBLRz78iw7H5Hl4v2bU1EmXqrHM4Tbae/FyqOq7Vh0DBmoaDn7Jde+5qPtLFkY20LU64gY6oFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QbkfydBZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1Hk2u8/hNJ9Bp9zo2zLPHyEXs50hagFI4OBYQq7GwbY=; b=QbkfydBZx6yw5ebaS47RT0ABr7
	FhXgPL1iOHq+Ob3F/FT6Pm274TKjYQAJtyvszypuNvqAqOksymTS0GRbCFCxRzI9AL2aKeh4DSq8u
	BGQNzOmqDqCLDEOSEpH95qTz0mEXtr9mlFUm9kQ0EE5C2C1VDVIQOl5jvSWez2UvVyJXA+EKXV3/0
	nW9hjnZC931b0C0U5oagvHWSN2Lw7UtkAIudRpB5x4K14kHYHwCAlo1TYf1iiXV6g4BkSR5zvCYw2
	KGCS1IOE/ecIHUSe34jZ6ChFREqJU4Z1+kYQ5I23uIIQevyGQfRuHmiofKG7QRVyImjT/vh2OeXTH
	Yrx7hnmA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sHmy7-000JbR-Vz; Thu, 13 Jun 2024 18:06:32 +0200
Received: from [178.197.249.34] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sHmy7-000G4z-0p;
	Thu, 13 Jun 2024 18:06:30 +0200
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: Add selftest for
 bpf_xdp_flow_lookup kfunc
To: Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
Cc: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de, hawk@kernel.org,
 horms@kernel.org, donhunte@redhat.com, memxor@gmail.com
References: <cover.1716987534.git.lorenzo@kernel.org>
 <21f41edcad0897e3a849b17392796b32215ae8ca.1716987535.git.lorenzo@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <95f8897c-a20b-fa5f-84ab-8204e2654a9e@iogearbox.net>
Date: Thu, 13 Jun 2024 18:06:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <21f41edcad0897e3a849b17392796b32215ae8ca.1716987535.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27305/Thu Jun 13 10:33:25 2024)

On 5/29/24 3:04 PM, Lorenzo Bianconi wrote:
> Introduce e2e selftest for bpf_xdp_flow_lookup kfunc through
> xdp_flowtable utility.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
[...]
> +struct flow_offload_tuple_rhash *
> +bpf_xdp_flow_lookup(struct xdp_md *, struct bpf_fib_lookup *,
> +		    struct bpf_flowtable_opts___local *, u32) __ksym;

Btw, this fails CI build :

https://github.com/kernel-patches/bpf/actions/runs/9499749947/job/26190382116

   [...]
   progs/xdp_flowtable.c:20:1: error: conflicting types for 'bpf_xdp_flow_lookup'
      20 | bpf_xdp_flow_lookup(struct xdp_md *, struct bpf_fib_lookup *,
         | ^
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:106755:41: note: previous declaration is here
    106755 | extern struct flow_offload_tuple_rhash *bpf_xdp_flow_lookup(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tuple, struct bpf_flowtable_opts *opts, u32 opts_len) __weak __ksym;
           |                                         ^
   progs/xdp_flowtable.c:134:47: error: incompatible pointer types passing 'struct bpf_flowtable_opts___local *' to parameter of type 'struct bpf_flowtable_opts *' [-Werror,-Wincompatible-pointer-types]
     134 |         tuplehash = bpf_xdp_flow_lookup(ctx, &tuple, &opts, sizeof(opts));
         |                                                      ^~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:106755:142: note: passing argument to parameter 'opts' here
    106755 | extern struct flow_offload_tuple_rhash *bpf_xdp_flow_lookup(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tuple, struct bpf_flowtable_opts *opts, u32 opts_len) __weak __ksym;
           |                                                                                                                                              ^
   2 errors generated.
     CLNG-BPF [test_maps] kprobe_multi_override.bpf.o
     CLNG-BPF [test_maps] tailcall_bpf2bpf1.bpf.o
   make: *** [Makefile:654: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/xdp_flowtable.bpf.o] Error 1
   make: *** Waiting for unfinished jobs....
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.

