Return-Path: <bpf+bounces-39842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E49786A0
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49451C20EFE
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DBC80BEC;
	Fri, 13 Sep 2024 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yk6uccGY"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF35EBE68
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248265; cv=none; b=I1/LM3vrYPjBVrOLM4/cD0iZ9ViepW6YiH1Z+zlYDndQjDIyDLfW5ruuO0y1PpnGeqGDpc2j5bmVis+n6xx3IbuvbagD1o4YAASjrVLL6klvqkdD8fzW9K4OO4GFaUjbsBdgvm1Q/V3ToBjngZM0NkfR866M9pvtMQW+v5avgYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248265; c=relaxed/simple;
	bh=sllu2LtMOhcdH/FD8wUSmEhJWjy45HTpNiNXgVAUspU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mM4UftBdfIDzfSFq6tM4/QKPL0cPdbxYdmc0hv23AuVf5JQWnJhnyPMPbRomtZJldKCfexRcdPDcmAl3Ha8t75fOpZhQClKcev4zHe9+meWgGKSaXYRrHDzVCF/6pqd2nVXkRtnQibqnybhK6IZ6viPenpuwLbWHyaDeXkYBU+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yk6uccGY; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e1435276-d106-411f-9c0f-c98abd2bce08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726248260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUlMI/VUG0tbtBW/0vyoiiaa/eRH5yrftzcJDI7pfa4=;
	b=Yk6uccGYN6b+Y8rna0u6tXJc1FyRwl3xoyTZX3NS+dAPIOwIqURDELqvdltb8saVILHLKL
	7PBy7oqaLuG2UqwAsSfCyCvkQrO2/FVD+0bJ2DQDaFpSTgZdACLrpjp96GU8e8GHJWLCxP
	bVc3vdUJ6gUo+6M8+OEDHunEIIMXq48=
Date: Fri, 13 Sep 2024 10:24:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] netkit: Assign missing bpf_net_context
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 vadim.fedorenko@linux.dev, andrii@kernel.org,
 "open list:BPF [NETKIT] (BPF-programmable network device)"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240912155620.1334587-1-leitao@debian.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240912155620.1334587-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/12/24 8:56 AM, Breno Leitao wrote:
> During the introduction of struct bpf_net_context handling for
> XDP-redirect, the netkit driver has been missed, which also requires it
> because NETKIT_REDIRECT invokes skb_do_redirect() which is accessing the
> per-CPU variables. Otherwise we see the following crash:
> 
> 	BUG: kernel NULL pointer dereference, address: 0000000000000038
> 	bpf_redirect()
> 	netkit_xmit()
> 	dev_hard_start_xmit()
> 
> Set the bpf_net_context before invoking netkit_xmit() program within the
> netkit driver.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


