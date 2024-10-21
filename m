Return-Path: <bpf+bounces-42701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE629A933E
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 00:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391831C21B73
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 22:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09D41FEFD6;
	Mon, 21 Oct 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bc8T3bDn"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77B1E22FB
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549550; cv=none; b=Wfor71K7uzuw4fpKyWLamD16BOzz3lu4eSW13N3jOSAsf9UV91g+ohy4RboxxzCA2g/N2lL4Q5zIe1GKM6mLNHXREZ6RTLuXVAhM7eXSOM32D1H6/IXR/UvoWvfaPhTvYHwQ2vkug9NYbP1os3LA1qk/y80KyNQdu22JrpsjZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549550; c=relaxed/simple;
	bh=kbSWV7WYy6Hw26ZhpOM9b2Ymm2PpDWHZpJ4ll0Zidxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Enyd6qxc5zydivXytFMu1IRgX0k1iigNvAjaJIIsNprvmszkgkq8qLmprWF54FK/cuBrTyFoHemHkFhgvYnG7BKHX7rBQQHKbD7wTkfn5bWqWXytZzjcmqRtzWT7qFf8LVQzw267tOujecUcq6m8SMuEhCK3ENMpkBmWi8Xgkto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bc8T3bDn; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c7d0503b-e20d-4a6d-aecf-2bd7e1c7a450@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729549544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QWlVeZK0mzFq8Syz3jh9cSrVTMw6VdFMuwprJIetTs=;
	b=bc8T3bDn1bM253UvdXcCdKl1phP9sdN92ABL3VlaUpo8+wHg5OTc0sObm5ULagzYkezpx+
	d1IxoIW+1poLjCsjUfk770bB0QN2eQYe7I2vv04r/sLmf5sufjkaRik7zBWSfXxYEOgetM
	bDUyJwWHlMVqwtg3iNLQFBNVuHEC89A=
Date: Mon, 21 Oct 2024 15:25:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] Drop packets with invalid headers to prevent KMSAN
 infoleak
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <bpf@vger.kernel.org>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
References: <20241019071149.81696-1-danielyangkang@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241019071149.81696-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/19/24 12:11 AM, Daniel Yang wrote:
> KMSAN detects uninitialized memory stored to memory by
> bpf_clone_redirect(). Adding a check to the transmission path to find
> malformed headers prevents this issue. Specifically, we check if the length
> of the data stored in skb is less than the minimum device header length.
> If so, drop the packet since the skb cannot contain a valid device header.
> Also check if mac_header_len(skb) is outside the range provided of valid
> device header lengths.
> 
> Testing this patch with syzbot removes the bug.
> 
> Fixes: 88264981f208 ("Merge tag 'sched_ext-for-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext")

I am pretty sure this is the wrong tag.

A test in selftests/bpf is needed to reproduce and better understand this. Only 
bpf_clone_redirect() is needed to reproduce or other bpf_skb_*() helpers calls 
are needed to reproduce?


> Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
>   net/core/filter.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index cd3524cb3..92d8f2098 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2191,6 +2191,13 @@ static int __bpf_redirect_common(struct sk_buff *skb, struct net_device *dev,
>   		return -ERANGE;
>   	}
>   
> +	if (unlikely(skb->len < dev->min_header_len ||
> +		     skb_mac_header_len(skb) < dev->min_header_len ||
> +		     skb_mac_header_len(skb) > dev->hard_header_len)) {
> +		kfree_skb(skb);
> +		return -ERANGE;
> +	}
> +
>   	bpf_push_mac_rcsum(skb);
>   	return flags & BPF_F_INGRESS ?
>   	       __bpf_rx_skb(dev, skb) : __bpf_tx_skb(dev, skb);


