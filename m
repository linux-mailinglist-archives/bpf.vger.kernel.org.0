Return-Path: <bpf+bounces-21979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC4854DC4
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F45F285CDE
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDA5FF04;
	Wed, 14 Feb 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="Tpv+90Ek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dxhMlzuH"
X-Original-To: bpf@vger.kernel.org
Received: from wflow1-smtp.messagingengine.com (wflow1-smtp.messagingengine.com [64.147.123.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51A5D756;
	Wed, 14 Feb 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927058; cv=none; b=J4NwiRUL7uljVrOjr2pNw0m+z166+bZPsJnrV/OOR+vM0Udch+OUgGOPf1TGfqdx4CwULHm7MtScKoH6C4Q63Ntk4nhuHTGjDUvyvMUrtHr0Hg1XC3R2Gm4rrGsdnG55rP21dgR07U1CPN5G8MBl/fUk+Uxiei+PCJcxnRe9xMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927058; c=relaxed/simple;
	bh=BJ8Y8fUdQ1xOtt2jp/NbPlc+IjOdmH4pyylKU6FtVhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTzrnq+AaFoeqZwWOwY6PiLKgAYohE8slzpRuovGiOk3WTnBiWlyhwHo4D5Z8dXE9KEzbMgkQMBMKkEs+8v0lr5WblLD3p2D3FUCdP42uYtmjs/5pZthmdqqwjr3J6tP2Lxj1AQPWmXkQ9P5zHsuKGTb/vWANkD2fTlQzvhu3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=Tpv+90Ek; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dxhMlzuH; arc=none smtp.client-ip=64.147.123.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.west.internal (Postfix) with ESMTP id 49EDA2CC02DB;
	Wed, 14 Feb 2024 11:10:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 14 Feb 2024 11:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1707927051;
	 x=1707930651; bh=7LuzJ5QzAz/5BlqTwKiwRs+lnWNPOrkb3Emw0YAjd84=; b=
	Tpv+90EkPlHZetaXFhuzepSMszyB0SEbqWYhQLjagTC7kzoMxgp8U8TBPInR8Kge
	gXRayGn4OT3M3hvMIkjYGtq1KaQ6x1a9G+5Pdy932ZLDdYtEmrcNNamIvTikOniB
	0OKB58dFnTSWoY1FSHovh04f1qCONXs1v8iwaVcLjwtJlWq36S3O191vqyo3mS22
	PaInIxY+R41dgFiK01TCYbnVz+0uhibXrdoi+2MbKN1vtJzfnB5TCpqb0y+kQadl
	C+5JcZcvEq4pCPNE7NKwxP7OHTJQvUeAuxjWz7iOcpJCPxIzn8ss/RyaB5lciJqs
	p7jrz7TksFxPWvVLnRnYtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707927051; x=
	1707930651; bh=7LuzJ5QzAz/5BlqTwKiwRs+lnWNPOrkb3Emw0YAjd84=; b=d
	xhMlzuHuyAQE69JjIpIs9uFpteR4CGHdcSBAgfs8DP+QUF1pdXsKVQXy56Lsbacl
	90UJipFGL6QqzkcajQ2mCoHsVrcBkqEHKzF+jGGlkMq4qEGgU4Z854GeG1131LJF
	pX5IoutBLP/M8KafPHE0eBkqhS3g5lF1FqizuwCmy/sM60cGaXAxGkFnhN9d2xFL
	wPwxYD+yrZIhOX0poovM5lzEoyCbC17p8PHR0u2DXIWC47jRwqGXVe1YS5rH+Ff8
	kT9fSX4fJu+4NFGIM4PRoCfQ5sVSc9J++t0ogB4jJSndP4AEiZE+jxupWavAIsf9
	XXKBGCWCD+EW98T1DVh0A==
X-ME-Sender: <xms:CubMZQnwm0A9SR_5uw25O2n-8D_yFoZyIfTtIGINCgQqJl4-T67l2Q>
    <xme:CubMZf1lT_pkuRzw-FSv4wpT9LnmxspsQH1bjvxXAlgi3xXgsblrGlxvIDrH8X5q2
    YkRn4RRsuZYeivG3L0>
X-ME-Received: <xmr:CubMZeoSDEwY6pBOZKmhRv_AN8epLLXvd9wTH2F4W8QSNe1PUFXji6qkvYq154paQq1uEm_OXohN-x3MWgghqoIEy0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtje
    ertddtvdejnecuhfhrohhmpefsuhgvnhhtihhnucffvghslhgrnhguvghsuceoqhguvges
    nhgrtggthidruggvqeenucggtffrrghtthgvrhhnpeehfeegiefggefhvefffeeluddtud
    eiieefgeelhffffedvfefgjeegieeljeeuteenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehquggvsehnrggttgihrdguvg
X-ME-Proxy: <xmx:CubMZcm1vdrp0IMJLQ3eKGRhivHOS_RMN7wa4W4Bd8w84a70tRUgBA>
    <xmx:CubMZe3AqLMpDEjgWZekx7eiVMhuDTg3VX51nPEPJihEnlzK6yENqA>
    <xmx:CubMZTuvkf078HQDnBhQROcxxyAnaI3c7KT4Iue0nrTZmoiD22f1AQ>
    <xmx:C-bMZR3x1H1-cW0B28A3B1WAazcbAtOzZnAdr0XOy9qALPa-KEsujA7eq09I3lb2>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 11:10:49 -0500 (EST)
Message-ID: <70114fff-43bd-4e27-9abf-45345624042c@naccy.de>
Date: Wed, 14 Feb 2024 17:10:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC nf-next v5 0/2] netfilter: bpf: support prog update
Content-Language: en-US
To: "D. Wythe" <alibuda@linux.alibaba.com>, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, coreteam@netfilter.org,
 netfilter-devel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org
References: <1704175877-28298-1-git-send-email-alibuda@linux.alibaba.com>
From: Quentin Deslandes <qde@naccy.de>
In-Reply-To: <1704175877-28298-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-02 07:11, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patches attempt to implements updating of progs within
> bpf netfilter link, allowing user update their ebpf netfilter
> prog in hot update manner.
> 
> Besides, a corresponding test case has been added to verify
> whether the update works.
> --
> v1:
> 1. remove unnecessary context, access the prog directly via rcu.
> 2. remove synchronize_rcu(), dealloc the nf_link via kfree_rcu.
> 3. check the dead flag during the update.
> --
> v1->v2:
> 1. remove unnecessary nf_prog, accessing nf_link->link.prog in direct.
> --
> v2->v3:
> 1. access nf_link->link.prog via rcu_dereference_raw to avoid warning.
> --
> v3->v4:
> 1. remove mutex for link update, as it is unnecessary and can be replaced
> by atomic operations.
> --
> v4->v5:
> 1. fix error retval check on cmpxhcg
> 
> D. Wythe (2):
>   netfilter: bpf: support prog update
>   selftests/bpf: Add netfilter link prog update test
> 
>  net/netfilter/nf_bpf_link.c                        | 50 ++++++++-----
>  .../bpf/prog_tests/netfilter_link_update_prog.c    | 83 ++++++++++++++++++++++
>  .../bpf/progs/test_netfilter_link_update_prog.c    | 24 +++++++
>  3 files changed, 141 insertions(+), 16 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_update_prog.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_update_prog.c
> 

It seems this patch has been forgotten, hopefully this answer
will give it more visibility.

I've applied this change on 6.8.0-rc4 and tested BPF_LINK_UPDATE
with bpfilter and everything seems alright.

Thanks,
Quentin

