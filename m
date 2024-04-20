Return-Path: <bpf+bounces-27274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120998AB8A5
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 04:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443FA1C20AA0
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 02:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9495CB5;
	Sat, 20 Apr 2024 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JQpEzjTA"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0AAA32;
	Sat, 20 Apr 2024 02:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713578471; cv=none; b=gmrFCWFHJq9DpeSB4yR4+Ne5tSgR534XCKPMSI2cJ8RRzAxzIT2d5pgEY1CeqMKUhTLEvg4n2p2iVyZDkXqRt5qh6+f2L5bSHjlmTWKNy2AZMqvpjUcBHOxMZI5cF8HDuRg3sos6SnvEp4WkHnBa++wqdR/v+/mCKjbZpyD5uDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713578471; c=relaxed/simple;
	bh=zorbSQlE5749d0vty79LbC3XwYvWyxxgta/O5WCEh6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rs8lIsSmjicdiKmBv11/Ph/4ciVD9i81iXoiQfFndItRCM/cVoFwEIqS+DMfxXT/bpLE8W2wv3ILh/JZJloy6mKJOMA6/anLtF3gg7zrCKPID6Dl7y8gBZvS0rNDRQbS7xm+hGCqngpuOp4ZL2n1lp2q3ATpd28EfEWMGA8X6Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JQpEzjTA; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7938afa-fb2f-4872-b449-6ecaf5e29360@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713578465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccFENnNsdmZqiLVK2Dokx+yQ1pI/ODFWTmbw5AgyjK8=;
	b=JQpEzjTAD+B5hHb8MuhOtD3bC4xmKeUZM5Fz3VNbUgXXAsT8GtOjuQunlQyYfpc3J2wIer
	kS8uP/rUVL/dR4X7zYnPxSD0U6B4rtkwk1mE+Vg460zl0n5RtPXieTiXTw6DiZdDJLIXqA
	TzQqPklle2+hEgmQmZS5F4FrptxuU0c=
Date: Fri, 19 Apr 2024 19:00:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] xdp: use flags field to disambiguate broadcast
 redirect
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240418071840.156411-1-toke@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240418071840.156411-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/18/24 12:18 AM, Toke Høiland-Jørgensen wrote:
> When redirecting a packet using XDP, the bpf_redirect_map() helper will set
> up the redirect destination information in struct bpf_redirect_info (using
> the __bpf_xdp_redirect_map() helper function), and the xdp_do_redirect()
> function will read this information after the XDP program returns and pass
> the frame on to the right redirect destination.
> 
> When using the BPF_F_BROADCAST flag to do multicast redirect to a whole
> map, __bpf_xdp_redirect_map() sets the 'map' pointer in struct
> bpf_redirect_info to point to the destination map to be broadcast. And
> xdp_do_redirect() reacts to the value of this map pointer to decide whether
> it's dealing with a broadcast or a single-value redirect. However, if the
> destination map is being destroyed before xdp_do_redirect() is called, the
> map pointer will be cleared out (by bpf_clear_redirect_map()) without
> waiting for any XDP programs to stop running. This causes xdp_do_redirect()
> to think that the redirect was to a single target, but the target pointer
> is also NULL (since broadcast redirects don't have a single target), so
> this causes a crash when a NULL pointer is passed to dev_map_enqueue().
> 
> To fix this, change xdp_do_redirect() to react directly to the presence of
> the BPF_F_BROADCAST flag in the 'flags' value in struct bpf_redirect_info
> to disambiguate between a single-target and a broadcast redirect. And only
> read the 'map' pointer if the broadcast flag is set, aborting if that has
> been cleared out in the meantime. This prevents the crash, while keeping
> the atomic (cmpxchg-based) clearing of the map pointer itself, and without
> adding any more checks in the non-broadcast fast path.
> 
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
> Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>   net/core/filter.c | 42 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 786d792ac816..8120c3dddf5e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4363,10 +4363,12 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
>   	enum bpf_map_type map_type = ri->map_type;
>   	void *fwd = ri->tgt_value;
>   	u32 map_id = ri->map_id;
> +	u32 flags = ri->flags;
>   	struct bpf_map *map;
>   	int err;
>   
>   	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
> +	ri->flags = 0;
>   	ri->map_type = BPF_MAP_TYPE_UNSPEC;
>   
>   	if (unlikely(!xdpf)) {
> @@ -4378,11 +4380,20 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
>   	case BPF_MAP_TYPE_DEVMAP:
>   		fallthrough;
>   	case BPF_MAP_TYPE_DEVMAP_HASH:
> -		map = READ_ONCE(ri->map);
> -		if (unlikely(map)) {
> +		if (unlikely(flags & BPF_F_BROADCAST)) {
> +			map = READ_ONCE(ri->map);
> +
> +			/* The map pointer is cleared when the map is being torn
> +			 * down by bpf_clear_redirect_map()

Thanks for the details explanation in the commit message. All make sense.

It could be a dumb question.

 From reading the "waits for...NAPI being the relevant context here..." comment 
in dev_map_free(), I wonder if moving synchronize_rcu() before 
bpf_clear_redirect_map() would also work? Actually, does it need to call 
bpf_clear_redirect_map(). The on-going xdp_do_redirect() should be the last one 
using the map in ri->map anyway and no xdp prog can set it again to ri->map.

> +			 */
> +			if (unlikely(!map)) {
> +				err = -ENOENT;
> +				break;
> +			}
> +
>   			WRITE_ONCE(ri->map, NULL);
>   			err = dev_map_enqueue_multi(xdpf, dev, map,
> -						    ri->flags & BPF_F_EXCLUDE_INGRESS);
> +						    flags & BPF_F_EXCLUDE_INGRESS);
>   		} else {
>   			err = dev_map_enqueue(fwd, xdpf, dev);
>   		}


