Return-Path: <bpf+bounces-6856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A8B76EB7A
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF51282217
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441FB200BB;
	Thu,  3 Aug 2023 14:00:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE91F938;
	Thu,  3 Aug 2023 14:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E263DC433C7;
	Thu,  3 Aug 2023 13:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691071200;
	bh=bB4kuwYyVEPnJET93UTEzG9t1o+35wwo6x4/XLGcjHg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jGXINRn5i9ezVIQxBLaDxH+WULQSJQH9mrSHQsQnVgNoFgFOMU7SEZBmSmWWs2Rt3
	 gSo6oQ5TZtg6gVJRxcoriCKofMgF9fIWLKhhLp7OR7wA6iuATE+XoKjAb109i71AM1
	 mTbHlg4qKKY8eTtD3hNoD8M9AwjKoPO5UWdraX6/xIa5xXmxjNsAq9G2ntp37Nsl2E
	 a6rbDVoF3uu/FeqNQ0scyXsZJQsDyXduwy5A3NmVPrWSO6q5cN8Mi67fAkjp4IwGxO
	 JOPcgQ34MarRD64EgOJMwRZYVAF9EkjLWdH4z1CmEH50Ttn7uD9zMb0mlpWVBaqsXO
	 UJVOjF6VVZjhQ==
Message-ID: <bac02af2-755c-a338-52f1-35ae51841b9f@kernel.org>
Date: Thu, 3 Aug 2023 15:59:54 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 3/3] net: invert the netdevice.h vs xdp.h
 dependency
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, amritha.nambiar@intel.com,
 aleksander.lobakin@intel.com, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, ast@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20230803010230.1755386-1-kuba@kernel.org>
 <20230803010230.1755386-4-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230803010230.1755386-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/08/2023 03.02, Jakub Kicinski wrote:
> xdp.h is far more specific and is included in only 67 other
> files vs netdevice.h's 1538 include sites.
> Make xdp.h include netdevice.h, instead of the other way around.
> This decreases the incremental allmodconfig builds size when
> xdp.h is touched from 5947 to 662 objects.
> 
> Move bpf_prog_run_xdp() to xdp.h, seems appropriate and filter.h
> is a mega-header in its own right so it's nice to avoid xdp.h
> getting included there as well.
> 
> The only unfortunate part is that the typedef for xdp_features_t
> has to move to netdevice.h, since its embedded in struct netdevice.
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
> CC:ast@kernel.org
> CC:daniel@iogearbox.net
> CC:john.fastabend@gmail.com
> CC:andrii@kernel.org
> CC:martin.lau@linux.dev
> CC:song@kernel.org
> CC:yonghong.song@linux.dev
> CC:kpsingh@kernel.org
> CC:sdf@google.com
> CC:haoluo@google.com
> CC:jolsa@kernel.org
> CC:hawk@kernel.org
> CC:bpf@vger.kernel.org
> ---
>   include/linux/filter.h           | 17 -----------------
>   include/linux/netdevice.h        | 11 ++++-------
>   include/net/busy_poll.h          |  1 +
>   include/net/xdp.h                | 29 +++++++++++++++++++++++++----
>   include/trace/events/xdp.h       |  1 +
>   kernel/bpf/btf.c                 |  1 +
>   kernel/bpf/offload.c             |  1 +
>   kernel/bpf/verifier.c            |  1 +
>   net/netfilter/nf_conntrack_bpf.c |  1 +
>   9 files changed, 35 insertions(+), 28 deletions(-)

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


