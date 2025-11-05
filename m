Return-Path: <bpf+bounces-73729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33372C37C4D
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0FD94EC66F
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C526347FD1;
	Wed,  5 Nov 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZCqg35Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90C334C0C;
	Wed,  5 Nov 2025 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762375327; cv=none; b=KDs6VXKwB3hG8/EaPPMMP5Pk8jkZ0TvehAu0j2xOI95hx+cREzHPuAnT8k795a1XHdna5Dyq5SEOkdDdXRqzXbLpZVSIJwMUGrVbcxaHJedKkHmeg9XcJsgS+6nG+B1JXbT9sLrirAlngSscuHOylXdNNhvCccB7+y0CXHWBiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762375327; c=relaxed/simple;
	bh=Im3+M6VEUShgjHFS90zF37R75xXfZRG+1vjn785jgQ0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WiEZ+MX60ZH6R88+N0oEnG+GZaBL2xdb17iBeNC7LvRpoQJzVL/ecam+zxqpLZWKCaQ7DLtM0RsJHjQiQWMhqlJXLyZYHVexfMQ6BJfL+dS63TmrpYcGFo6mX0nJSW1+042uT+72Fxm9ldDtQ0q0O/ONyMpqX9wHPJ8Y26RHUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZCqg35Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72490C4CEF5;
	Wed,  5 Nov 2025 20:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762375323;
	bh=Im3+M6VEUShgjHFS90zF37R75xXfZRG+1vjn785jgQ0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FZCqg35Y7S1+biHYJX9eFhRDxC6ccF/x9qz1yaEJL35BeVph6kuF0FFDJdzmcmKSJ
	 efUkT9cWBRhrXA6//sTPzH7S3e44ZhZ7TMAEvGSTS6Xfl2VviiUqjcl9Yqk3BXultF
	 FPpaIF8aOEVowV50evpK06yjK+bx/09o3ruV6n6p30z6nTXlr66InWStfK4NIDUq2T
	 WINnQN2kDMDr0/JlAom8LXm805gO7V5idTZEnQFJFo3li9P6bZWXUiz8OIYVXWnmNZ
	 MAxSEdAs0rqCxIiE8cs2DJg4XKik77xdOeAfAnezCjVmiwaqJnCq/BcK0vjoUmHSX4
	 B4p5Hg0uVspZw==
Content-Type: multipart/mixed; boundary="===============8991984138108816200=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9b3ca8c01aac5510f1ff8738b3856e5e2bbe43075333c27642eb69a6847a50ef@mail.kernel.org>
In-Reply-To: <20251105-skb-meta-rx-path-v4-7-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-7-5ceb08a9b37b@cloudflare.com>
Subject: Re: [PATCH bpf-next v4 07/16] bpf: Make bpf_skb_adjust_room metadata-safe
From: bot+bpf-ci@kernel.org
To: jakub@cloudflare.com,bpf@vger.kernel.org
Cc: davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,martin.lau@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,arthur@arthurfabre.com,hawk@kernel.org,netdev@vger.kernel.org,kernel-team@cloudflare.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Nov 2025 20:42:03 +0000 (UTC)

--===============8991984138108816200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 96714eab9..370ddc61b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3260,11 +3260,11 @@ static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
>
>  static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
>  {
> -	/* Caller already did skb_cow() with len as headroom,
> +	/* Caller already did skb_cow() with meta_len+len as headroom,
>  	 * so no need to do it here.
>  	 */
>  	skb_push(skb, len);
> -	memmove(skb->data, skb->data + len, off);
> +	skb_postpush_data_move(skb, len, off);
>  	memset(skb->data + off, 0, len);

The comment update says callers provide meta_len+len as headroom, but
is this true for all callers?

bpf_skb_proto_4_to_6() calls skb_cow(skb, len_diff) then calls
bpf_skb_net_hdr_push()->bpf_skb_generic_push(). Similarly,
bpf_lwt_seg6_adjust_srh() calls skb_cow_head(skb, len) then calls
bpf_skb_net_hdr_push()->bpf_skb_generic_push().

Neither accounts for meta_len in their headroom calculation. When
skb_postpush_data_move()->skb_data_move() runs, if meta_len >
skb_headroom(skb) after the push, the metadata gets silently cleared
(see the WARN_ON_ONCE check in skb_data_move() at skbuff.h).

Can the metadata be lost when these functions are called on skbs with
metadata?

> @@ -3496,6 +3496,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  	u8 inner_mac_len = flags >> BPF_ADJ_ROOM_ENCAP_L2_SHIFT;
>  	bool encap = flags & BPF_F_ADJ_ROOM_ENCAP_L3_MASK;
>  	u16 mac_len = 0, inner_net = 0, inner_trans = 0;
> +	const u8 meta_len = skb_metadata_len(skb);
>  	unsigned int gso_type = SKB_GSO_DODGY;
>  	int ret;
>
> @@ -3506,7 +3507,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  			return -ENOTSUPP;
>  	}
>
> -	ret = skb_cow_head(skb, len_diff);
> +	ret = skb_cow_head(skb, meta_len + len_diff);
>  	if (unlikely(ret < 0))
>  		return ret;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19115341225

--===============8991984138108816200==--

