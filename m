Return-Path: <bpf+bounces-32107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE069078CE
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 18:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF6FB22C0F
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6F01494AB;
	Thu, 13 Jun 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="lTsxvmiz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IpY+OqHQ"
X-Original-To: bpf@vger.kernel.org
Received: from flow2-smtp.messagingengine.com (flow2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC612F386;
	Thu, 13 Jun 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297653; cv=none; b=mjuj+Oljs9w43mZij5/DYvltGT09RzLgqvgMhgLKezCUKik1bz4ElMAqFyWTYCldlxOz33+Bgr+HOEB84TgRm4BcN2V7ivKtFfY3eaHPh4oE4kKRAXtOFa4IujnTV5L+k1RBdOcfEaKIxVQr0/mvF2Xtm5kW6jEXjczcNllkIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297653; c=relaxed/simple;
	bh=feHgD4FXC0XFfMqq5BOhmdqi9oHY+Zs0DNRW46P786A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0VZf4AMuwWPKxdUktAYYQ8+IKRbSTN7X5ukuK93z6+WvV0Wd6vUNXMEqIoMPzz9x++YdDsIsgPzLkIEpx7qmJbobyAypMnCqQUSPZ8rotqiZAoZsE2TuaFJT1bSX3tbXtGiVTVrmvZsRBMdAh2c4M1QRVmUpXNetUwuawKC7xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=lTsxvmiz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IpY+OqHQ; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.nyi.internal (Postfix) with ESMTP id 05EBC2001AF;
	Thu, 13 Jun 2024 12:54:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 13 Jun 2024 12:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718297650; x=1718304850; bh=fGEXUP5WR/
	qD1NGLHUvT64tThGjebLT8VP2XMiyvIUc=; b=lTsxvmizx4PE/wTa2kUa9KiE9H
	k21pHfPE26N4HnW6RD/mtZqLxqi1OciquLYmotYXy2sjhvrmiFurv/55fYVe0Okf
	ugjukoUUjydPb3TK2SLgH/IzfSJFF99l1kMJDKmZwsFvjnXvAovtALJi71Hk9iby
	lWMWt+xvwwqH8zJhI34I3u5o67DFJOejhqcJLkD8Q995Bg/P+vr1wwsmg+BSTkDI
	bErtTkndoiYnWjVHHjVj9BtjfeSK+RF28HlqO+WkBIB8EUlk7SzdSqJqIlAfMl1i
	uVTGane4n5w+MY8Cu0sTAvdFg+MfnwUhE7dIUzf7Ftg5uMUxZsSGUpyv5sXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718297650; x=1718304850; bh=fGEXUP5WR/qD1NGLHUvT64tThGje
	bLT8VP2XMiyvIUc=; b=IpY+OqHQJvkNevwh/hoAdHQmHvQo/j65mLMjxNU6dK3F
	rLG0R6KKUdnQT8I6tw+lArnTH6QDJlhnhTeJ7NuFPPlu3bh/0bWiTXcxod1y/FCm
	0E5j9EjUIdpxz5Qp2MKN5didpGjeHS4QthqCDwBDsQRHFR7thC9WUggWdtafz5g7
	3s155qU5vW9yxL6AGFG77uVUDqnpo9WekMyhdV5DkLq1Q1KvP616tSnaS2WlJFXr
	454vGqOocOMmxkKgvW3x/v0hH9CpXEW/X1TX88mHNH5dDJ0hdfjrnPNLYVkeXZR2
	GhF4uJVbmPKDeBfDbOej8sTHOBSxsDeCv+pX59dCow==
X-ME-Sender: <xms:MiRrZgIfTRkRzYeJ-vpaIOZRoy0HRjE1Z9JTnlNVCRyA3MySIy7tcg>
    <xme:MiRrZgIcgKkcWvMv9BWu7NLShucJt7Vr9ejIMpGdmDI8uhfvbQUBf9eY9eadbSH5R
    HCg7yL5AEBEoMol0A>
X-ME-Received: <xmr:MiRrZgsR7sl3mzwuzxaHSZcWi6LghoQVHXl7lTUKeCTdqHNhThhbDG07pNLzTMtRaySTYvaQXsHv-FWRTJfei3o2YbqIaMOOyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdt
    tddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtjeekudelieetvdefgedvgeejhefhvdfggfejudeutdeg
    veeivedthfehfeelkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdr
    giihii
X-ME-Proxy: <xmx:MiRrZtaPtGLn3jqO_OclomnP4auuTGGUw8wyGKAjpiUEAUZR8oCzxg>
    <xmx:MiRrZnZGp6lLALmdMc0-yhs_BED91frK7K0aSuKXyuxJpV-Ykb6TLQ>
    <xmx:MiRrZpCgNU8NiSYmms4KbawpQznYsm9eG9LxXKaZmbB5DYseRHuiog>
    <xmx:MiRrZtZOdD8YqeIL5566qA3aAYD92oCh0Y6IYI4sEFh2wFY8EAkA9Q>
    <xmx:MiRrZrNi12GFpf7t29CQuwFG4mpEPtBhauaQ07lWuc9RsJBtBtjP60-9>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 12:54:08 -0400 (EDT)
Date: Thu, 13 Jun 2024 10:54:07 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, 
	pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netfilter-devel@vger.kernel.org, 
	netdev@vger.kernel.org, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de, 
	hawk@kernel.org, horms@kernel.org, donhunte@redhat.com, memxor@gmail.com
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: Add selftest for
 bpf_xdp_flow_lookup kfunc
Message-ID: <hwdaubyz7kjei5pmp72c4opxz3pk3syso22kafm2j7m3t3ffgl@g6ncqcqfe6bi>
References: <cover.1716987534.git.lorenzo@kernel.org>
 <21f41edcad0897e3a849b17392796b32215ae8ca.1716987535.git.lorenzo@kernel.org>
 <95f8897c-a20b-fa5f-84ab-8204e2654a9e@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f8897c-a20b-fa5f-84ab-8204e2654a9e@iogearbox.net>

On Thu, Jun 13, 2024 at 06:06:29PM GMT, Daniel Borkmann wrote:
> On 5/29/24 3:04 PM, Lorenzo Bianconi wrote:
> > Introduce e2e selftest for bpf_xdp_flow_lookup kfunc through
> > xdp_flowtable utility.
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> [...]
> > +struct flow_offload_tuple_rhash *
> > +bpf_xdp_flow_lookup(struct xdp_md *, struct bpf_fib_lookup *,
> > +		    struct bpf_flowtable_opts___local *, u32) __ksym;
> 
> Btw, this fails CI build :
> 
> https://github.com/kernel-patches/bpf/actions/runs/9499749947/job/26190382116
> 
>   [...]
>   progs/xdp_flowtable.c:20:1: error: conflicting types for 'bpf_xdp_flow_lookup'
>      20 | bpf_xdp_flow_lookup(struct xdp_md *, struct bpf_fib_lookup *,
>         | ^
>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:106755:41: note: previous declaration is here
>    106755 | extern struct flow_offload_tuple_rhash *bpf_xdp_flow_lookup(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tuple, struct bpf_flowtable_opts *opts, u32 opts_len) __weak __ksym;
>           |                                         ^
>   progs/xdp_flowtable.c:134:47: error: incompatible pointer types passing 'struct bpf_flowtable_opts___local *' to parameter of type 'struct bpf_flowtable_opts *' [-Werror,-Wincompatible-pointer-types]
>     134 |         tuplehash = bpf_xdp_flow_lookup(ctx, &tuple, &opts, sizeof(opts));
>         |                                                      ^~~~~
>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:106755:142: note: passing argument to parameter 'opts' here
>    106755 | extern struct flow_offload_tuple_rhash *bpf_xdp_flow_lookup(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tuple, struct bpf_flowtable_opts *opts, u32 opts_len) __weak __ksym;
>           |                                                                                                                                              ^
>   2 errors generated.
>     CLNG-BPF [test_maps] kprobe_multi_override.bpf.o
>     CLNG-BPF [test_maps] tailcall_bpf2bpf1.bpf.o
>   make: *** [Makefile:654: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/xdp_flowtable.bpf.o] Error 1
>   make: *** Waiting for unfinished jobs....
>   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
>   Error: Process completed with exit code 2.
> 

We'll probably want to do the same thing as in f709124dd72f ("bpf:
selftests: nf: Opt out of using generated kfunc prototypes").

Daniel

