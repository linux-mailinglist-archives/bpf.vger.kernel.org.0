Return-Path: <bpf+bounces-57142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F377AAA632F
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 20:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE873B6E76
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 18:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38D6223DF4;
	Thu,  1 May 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SqIMwacW"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE41C1F22
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125491; cv=none; b=nfoup7Bxc1vRpFWgCtoKEw6HE0AVunC4erZfrO4lgMEwVTEaYh/PsLM/df6NeXCYZYv6sQ3Hw2aqcfTtK06K1J5+PXC81uicQqdsX+eH0u0lbxqiYNFVaBM2mF9+yLCxR99JO+gPVV32h4Ln5yViRG9xueUipl7+xgdtAtiJgWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125491; c=relaxed/simple;
	bh=vlX16ahkrnRI+fWtzG96SrbEd+czSy19gNPyq2adnA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJZd9TKVcXyH5XAYFZ5Wb58TuvMYD5DCICOk0xSd4Ed2sru97O7pXM4tmJce2Ft5p6/ptZFQg3wUQFG5VKWfz9GUA4yCJRzpB/uBrlIi4iqYpwRoob3ddmE9uVyp/oQa6f3oe0AlExkpw1vVl6uoMFXfw6cZsJTr/5G6ZS60umQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SqIMwacW; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44fa2bcd-d35e-44bc-b782-ed1b9a8ba8b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746125486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnVuHYefkb7SdggBx989aGc4OzbcRVqXDi+q644JknA=;
	b=SqIMwacW8o+PjCRmb+WSVTH3LiTuv8WoQUTUm+nvthePrPtyIU0xERZ+253VIVooRWUB1w
	TzCgeyWz6QiItvCMomL60Rf+I47vumzoZbjtJEA9sAEhcGus+FZSmknscUys39qC6NymBm
	JWhDBtzik0KwSoMm7rylDsVt5ddFTD0=
Date: Thu, 1 May 2025 11:51:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 bpf-next 5/7] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250428180036.369192-1-jordan@jrife.io>
 <20250428180036.369192-6-jordan@jrife.io>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250428180036.369192-6-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/28/25 11:00 AM, Jordan Rife wrote:
> @@ -3895,6 +3922,8 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
>   	if (ret)
>   		bpf_iter_fini_seq_net(priv_data);
>   
> +	iter->state.bucket = -1;

ah. I think this can be moved to patch 3.

> +
>   	return ret;
>   }
>   


