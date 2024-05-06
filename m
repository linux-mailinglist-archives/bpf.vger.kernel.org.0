Return-Path: <bpf+bounces-28700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A78BD4E6
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 20:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636A01C2262A
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 18:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1609158DA7;
	Mon,  6 May 2024 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfHVYz/1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6615886A;
	Mon,  6 May 2024 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021498; cv=none; b=aRm/iU0mghxYuHtG78Wyn8cVyDPKBAH00JX0yjRN7suYwbeXHMA/LZD/CYHopwKNlNDLYoXdi5QHzuU5uBQCYJh6hD7xfQaEw3uxOgIC5ClgdLb5ZKG3xVLfckkqD5C1iGuYn5PeyvgwBQsNEs0l+2dWX2lORPGYOFeDn1sE2tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021498; c=relaxed/simple;
	bh=8R4ZPMsVAW+UX7HqHWTfTC7cyZevPvFz9AU2FQlodBI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SL2wFRH2XTWQVnwjJQQBWAeACCfw6FO0lo9YYn3AVAhXM0NGhvvBK1S/XxAJB32p8CglD/uf3mDqqjy0FQT+ZnYvGpR+hfmFHmkdXSQO06uDxajze27f7XKq37qhFClt1q/ao7mpqW0/4QqNSD5fEnqbzgC2AbVM1xpB8Xnmgmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfHVYz/1; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9691e1e78so972929b6e.3;
        Mon, 06 May 2024 11:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715021496; x=1715626296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV6bIWj1XAD1mDEysW3PzxfMR0Aa4OzBGgrUMASIDvU=;
        b=YfHVYz/1PhBHOBu35FkuMhydcdJJGEA30s4oObg1HoTeXMqATCLWww9Hmfukg5Pyy0
         ZrSw46zFFevA0M2GBEZ8RQ/YH/mpQqfx1uR/cSJLuG51VLsPNQKzgx38rn4DBZCBs9nl
         MJzHKbdFGVS7oASgJeBCylufFlKpqjLr+LYAjtlIDYZaOjOaSvF2rI4OKcNv/PRxvSq/
         My36degVJT9wCFOuY50LvruhPB46iDfMQInI6LnLhTKhruc302vxajndUtNcuNvcsLr4
         pFX/vk1F0sr3cnjutyCwiYTycJlaOA0brY1wHApGNxYqsFIojx2RLK7rTOamvbVGKlXE
         aF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715021496; x=1715626296;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cV6bIWj1XAD1mDEysW3PzxfMR0Aa4OzBGgrUMASIDvU=;
        b=bw4jnjwPRab4zDhxmoDguwVw/Eql3iULJNOkL+28jBY8gSZbAKD3eIYkDkY8JqPSWL
         NIQrb+A+t/Z0JI+JqEmTXMP1AnPAS7VHI86sM2hLXDYtFvgHdGTl16oWuGHsxztnfC4x
         WH66cpuWBHENfyEgr/QGWjJhNU3Xs9ynEIjNRwr1RpzevGQNNYFH8UOAVwKaqVowrpYe
         GD4PgFkBTb8Kjt6jAT+sJtYhAXmzhH4tiOYtn1g1iTSC8OtfesRYzlMRu+fI6tN4v3RH
         9E28dbtsiZjLW4fO8fv2IT5YQlprjN3DerOVud1mxS7tX8ty6iWgNJIP+Inw7+V+ljhg
         NoYg==
X-Forwarded-Encrypted: i=1; AJvYcCUHc1IQY4jrt0TmwTeUjbijsHc8NHVOofFFNToE2S9hfFQm6DNwNdYtryMIFX3TK3DtmESACPPUc72iE4Ya0T07224weo4g7ZMoei1lLtXHl/SoNiJvczh5o+bsXxwtkojvgm7oVF9tXNI66lINjqyhyHLIYPE/3mfA
X-Gm-Message-State: AOJu0YyZ+vuTHcjEpqJekKK873MLzxQFAvSVcNS9SO1FrZZ88ZKB05vi
	evVLQ2HU7N9asduSq5tvjlNNqj6afBBJtfPFTkhzoSM8JVr9JK0s
X-Google-Smtp-Source: AGHT+IHshUHD7rX/miFmKb49aF7IGeRm84VGByYTEoXu41Q3MLA0lnEG6e4eefO5gUEkXOkxr4vDeQ==
X-Received: by 2002:a05:6808:1b23:b0:3c9:64ad:da93 with SMTP id bx35-20020a0568081b2300b003c964adda93mr8466950oib.29.1715021495815;
        Mon, 06 May 2024 11:51:35 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id de17-20020ad45851000000b006a0f3c93325sm3958744qvb.84.2024.05.06.11.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 11:51:35 -0700 (PDT)
Date: Mon, 06 May 2024 14:51:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Message-ID: <663926b74cbbd_516de29466@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240504031331.2737365-2-quic_abchauha@quicinc.com>
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
 <20240504031331.2737365-2-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v6 1/3] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan wrote:
> mono_delivery_time was added to check if skb->tstamp has delivery
> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
> timestamp in ingress and delivery_time at egress.
> 
> Renaming the bitfield from mono_delivery_time to tstamp_type is for
> extensibilty for other timestamps such as userspace timestamp
> (i.e. SO_TXTIME) set via sock opts.
> 
> As we are renaming the mono_delivery_time to tstamp_type, it makes
> sense to start assigning tstamp_type based on enum defined
> in this commit.
> 
> Earlier we used bool arg flag to check if the tstamp is mono in
> function skb_set_delivery_time, Now the signature of the functions
> accepts tstamp_type to distinguish between mono and real time.
> 
> Also skb_set_delivery_type_by_clockid is a new function which accepts
> clockid to determine the tstamp_type.
> 
> In future tstamp_type:1 can be extended to support userspace timestamp
> by increasing the bitfield.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Changes since v5
> - Avoided using garble function names as mentioned by
>   Willem.
> - Implemented a conversion function stead of duplicating 
>   the same logic as mentioned by Willem.
> - Fixed indentation problems and minor documentation issues
>   which mentions tstamp_type as a whole instead of bitfield
>   notations. (Mentioned both by Willem and Martin)
>   
> Changes since v4
> - Introduce new function to directly delivery_time and
>   another to set tstamp_type based on clockid. 
> - Removed un-necessary comments in skbuff.h as 
>   enums were obvious and understood.
> 
> Changes since v3
> - Fixed inconsistent capitalization in skbuff.h
> - remove reference to MONO_DELIVERY_TIME_MASK in skbuff.h
>   and point it to skb_tstamp_type now.
> - Explicitely setting SKB_CLOCK_MONO if valid transmit_time
>   ip_send_unicast_reply 
> - Keeping skb_tstamp inline with skb_clear_tstamp. 
> - skb_set_delivery_time checks if timstamp is 0 and 
>   sets the tstamp_type to SKB_CLOCK_REAL.
> - Above comments are given by Willem 
> - Found out that skbuff.h has access to uapi/linux/time.h
>   So now instead of using  CLOCK_REAL/CLOCK_MONO 
>   i am checking actual clockid_t directly to set tstamp_type 
>   example:- CLOCK_REALTIME/CLOCK_MONOTONIC 
> - Compilation error fixed in 
>   net/ieee802154/6lowpan/reassembly.c
> 
> Changes since v2
> - Minor changes to commit subject
> 
> Changes since v1
> - Squashed the two commits into one as mentioned by Willem.
> - Introduced switch in skb_set_delivery_time.
> - Renamed and removed directionality aspects w.r.t tstamp_type 
>   as mentioned by Willem.
> 
>  include/linux/skbuff.h                     | 53 ++++++++++++++++------
>  include/net/inet_frag.h                    |  4 +-
>  net/bridge/netfilter/nf_conntrack_bridge.c |  6 +--
>  net/core/dev.c                             |  2 +-
>  net/core/filter.c                          | 10 ++--
>  net/ieee802154/6lowpan/reassembly.c        |  2 +-
>  net/ipv4/inet_fragment.c                   |  2 +-
>  net/ipv4/ip_fragment.c                     |  2 +-
>  net/ipv4/ip_output.c                       |  9 ++--
>  net/ipv4/tcp_output.c                      | 16 +++----
>  net/ipv6/ip6_output.c                      |  6 +--
>  net/ipv6/netfilter.c                       |  6 +--
>  net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
>  net/ipv6/reassembly.c                      |  2 +-
>  net/ipv6/tcp_ipv6.c                        |  2 +-
>  net/sched/act_bpf.c                        |  4 +-
>  net/sched/cls_bpf.c                        |  4 +-
>  17 files changed, 80 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 1c2902eaebd3..de3915e2bfdb 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -706,6 +706,11 @@ typedef unsigned int sk_buff_data_t;
>  typedef unsigned char *sk_buff_data_t;
>  #endif
>  
> +enum skb_tstamp_type {
> +	SKB_CLOCK_REALTIME,
> +	SKB_CLOCK_MONOTONIC,
> +};
> +
>  /**
>   * DOC: Basic sk_buff geometry
>   *
> @@ -823,10 +828,9 @@ typedef unsigned char *sk_buff_data_t;
>   *	@dst_pending_confirm: need to confirm neighbour
>   *	@decrypted: Decrypted SKB
>   *	@slow_gro: state present at GRO time, slower prepare step required
> - *	@mono_delivery_time: When set, skb->tstamp has the
> - *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
> - *		skb->tstamp has the (rcv) timestamp at ingress and
> - *		delivery_time at egress.
> + *	@tstamp_type: When set, skb->tstamp has the
> + *		delivery_time in mono clock base Otherwise, the
> + *		timestamp is considered real clock base.

Missing period. More importantly, no longer conditional. It always
captures the type of skb->tstamp.

> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1301,7 +1301,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
>  	tp = tcp_sk(sk);
>  	prior_wstamp = tp->tcp_wstamp_ns;
>  	tp->tcp_wstamp_ns = max(tp->tcp_wstamp_ns, tp->tcp_clock_cache);
> -	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
> +	skb_set_delivery_type_by_clockid(skb, tp->tcp_wstamp_ns, CLOCK_MONOTONIC);
>  	if (clone_it) {
>  		oskb = skb;
>  
> @@ -1655,7 +1655,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
>  
>  	skb_split(skb, buff, len);
>  
> -	skb_set_delivery_time(buff, skb->tstamp, true);
> +	skb_set_delivery_type_by_clockid(buff, skb->tstamp, CLOCK_MONOTONIC);
>  	tcp_fragment_tstamp(skb, buff);

All these hardcoded monotonic calls in TCP can be the shorter version

    skb_set_delivery_type(.., SKB_CLOCK_MONOTONIC);
  

