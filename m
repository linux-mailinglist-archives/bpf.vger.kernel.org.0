Return-Path: <bpf+bounces-16047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D17FBADB
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 14:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1A42828E7
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577F56467;
	Tue, 28 Nov 2023 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvYNdZHg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A514EB53;
	Tue, 28 Nov 2023 13:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6731CC433C8;
	Tue, 28 Nov 2023 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701176769;
	bh=sB6nnXseb4vS54Ltf3FQgeR5XtgXTZIPgI2r1cbcbL4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=LvYNdZHgz3HVR/h8i9gktgedwbEr0DL/Bd/VsEAzfNATZtK/Ix901ujA2gIdNZ0HU
	 Zyou4afNP7s1XnBkZ9tYVp5hYWBhndDuQBFjhEbykxNI7y0LiRawuCXyPqKLkEQm4i
	 cH1PvOXeNfEBTUg2a7aYpuiavg+jtkkt6pvbczI8zY9tqKl5CVK7iqqosHhz0RB/XO
	 BC4HERQzgIQvhB5Bx2Yv5O68WU339fCtfZy250L0GXOdEgn1AW0ETxD7SIuKGncfBd
	 jAEpNAriIpeQrtJHFYXRixzaNQ3z2XAWGmN7NKv5sGNjL1GOApad0cFTcYYoJEnjQ5
	 xztG7bRcKQqXQ==
Message-ID: <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org>
Date: Tue, 28 Nov 2023 14:06:05 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Does skb_metadata_differs really need to stop GRO aggregation?
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Yan Zhai <yan@cloudflare.com>, Stanislav Fomichev <sdf@google.com>,
 Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, kernel-team
 <kernel-team@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
In-Reply-To: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/28/23 13:37, Jesper Dangaard Brouer wrote:
> Hi Daniel,
> 
> I'm trying to understand why skb_metadata_differs() needed to block GRO ?
> 
> I was looking at XDP storing information in metadata area that also
> survives into SKBs layer.  E.g. the RX timestamp.
> 
> Then I noticed that GRO code (gro_list_prepare) will not allow
> aggregating if metadata isn't the same in all packets via
> skb_metadata_differs().  Is this really needed?
> Can we lift/remove this limitation?
> 

(Answering myself)
I understand/see now, that when an SKB gets GRO aggregated, I will
"lose" access to the metadata information and only have access to the
metadata in the "first" SKB.
Thus, GRO layer still needs this check and it cannot know if the info
was important or not.

I wonder if there is a BPF hook, prior to GRO step, that could allow me
to extract variable metadata and zero it out before GRO step.


> E.g. if I want to store a timestamp, then it will differ per packet.
> 
> --Jesper
> 
> Git history says it dates back to the original commit that added meta
> pointer de8f3a83b0a0 ("bpf: add meta pointer for direct access") (author
> Daniel).
> 
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 0759277dc14e..7fb6a6a24288 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -341,7 +341,7 @@ static void gro_list_prepare(const struct list_head 
> *head,
> 
>                  diffs = (unsigned long)p->dev ^ (unsigned long)skb->dev;
>                  diffs |= p->vlan_all ^ skb->vlan_all;
> -               diffs |= skb_metadata_differs(p, skb);
> +               diffs |= skb_metadata_differs(p, skb); // Why?
>                  if (maclen == ETH_HLEN)
>                          diffs |= compare_ether_header(skb_mac_header(p),

