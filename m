Return-Path: <bpf+bounces-55530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B766A8271A
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 16:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3BA81B672D8
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B874264FBF;
	Wed,  9 Apr 2025 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnqBEmXV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70C264633;
	Wed,  9 Apr 2025 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207541; cv=none; b=jyCM4ZYoq0n4RWlOfatC9vo5jG9MIbKfhb1P6iGDqvXCUh6+OAUY7GH+gJXEj4ar+9t2JYMlF66jQSCcVRfuRPrDa+bxBQNEZQdYpGDBkVcseRpgJ4PwFsnLOcBWXGCetOiHlD990ik7FcBjU186ye3WODg+qaaeU6ZBilKSTII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207541; c=relaxed/simple;
	bh=Y4nlV2AN0lFgFAhfE267cySd173LpD0IpSknw/6J174=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AB5goukXFImyHInkWYKIPchZ/F1XWSl3HUYEuw00QwcG4dYXXSA5so2/xyXhi4qh2qdXgwmMlTNIyQtS9ZwjtKGo9oA0lnhJ8iK1t5Tb4+AMCeiRbe29eWnqWNM50dtnXX4CQE0Qx20TteX6G/OuDYXhuvu0aKOXn796/JrD8LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnqBEmXV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2279915e06eso66547775ad.1;
        Wed, 09 Apr 2025 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744207539; x=1744812339; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7hKHx3XJS2wsDg/gzwcitJmE96oi11R3tbeKyA6IeCk=;
        b=SnqBEmXVYqLYmFff/uAHQ7Cef/AjGF/gigHHxgHmcszZRmpeSysrZL2P8vK+x+Enmr
         uRlC6fYbTFpx8c9hKuwIcFrTPrUv0Llx/PKKJ5jdU5FACRKFuIDK9M5eKAAjmXmTqfmK
         +pTzIQgBYh73pU+M8wTF+eG/2fxn0cb2odoU2bcf2YX6HhKp+0FNt3EpFXZN4cwExOVS
         6LDPwJ8j/vdJGaFlc8Wi3FUXtQTYlJROw80P6JVnI6S33fbv7GqNRNnbS+P7xu5LHEBZ
         Y2PFD4wSouNfmjCG9cxKuS79m2dbStgSMpA4/h7f6SopGK2k06/g7eeyhNSXTmCwkyAf
         l3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744207539; x=1744812339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hKHx3XJS2wsDg/gzwcitJmE96oi11R3tbeKyA6IeCk=;
        b=Y6A4j6QjZD7cLJlZ/uhhcKlY56Yk/PbuobARk4rlOzV/Nq8kd1KOT8Jbb/fa3nqfF8
         KhqEjN593DN9clzlhuogrD1Qbn+uZYg9w/XpSz2KuN/kbW6TXnjycCPoYk0UfGEkiT0w
         oDiRHoYgHyCnD55/UYSxcxS08kDpNeoxVG3NlJB2dWH4R+OobDx9Ac32RB4xHYz+XiUL
         v0GZYkBDB5HpozkUU0VUk/r243T7ieQEjRb5UcFq1t61mGAOPaWmKJNW4M1fVc6mcd2Z
         3bP/gSrbQN4OyquXBVwnDcQZAhV5l/fxr3TkpswNet+ul22tLparUTZU/BsbFeLicKw1
         CGCg==
X-Forwarded-Encrypted: i=1; AJvYcCWIo4TF8rBAOXwmTANRNX4v7AQX0J2Xt5kXJCM5OToTBKo9L/OsLM2bQXl1Lx209LexWPquckk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR717YBSwdOMOctworl2pYk2KCrddrbhNEslcnBDjrBc2ADmnx
	pWG4jC93ksNTgOMjDYIm1/xf1D3pRdeXHspFnmkdPD+fKB1CxuI=
X-Gm-Gg: ASbGncsB4gEGDEvu55rhkL2NcbX/kDcgBY5KIVhTnkoPNC2vrWXlR0bWL1KA0dFENGh
	0NIA5gx5a6A6zo0KjUPr3vOGmDB89gIrN7szYpGthHWRm2aE71ze0a5qkk6YRIh1r4qqkpZchgF
	uYC2HOAKkNz1A5gCiwhA5Rug9e3v4PcB6wx1JnF1xK4Wp6BTPHWNy8F4UHg6BOdTUGKE+n3GKWt
	jC0hKmRWqpXeLEnbsXi4kmGlex2REtc/NScKMsqMbIqWSQFSEsiC4sb9nroJizisZbmh80uCD/q
	Ps6rSWhStiHgQckNdxH9KM6nVpaFxB/kNdrC5uQ/Uk6NyApLJQE=
X-Google-Smtp-Source: AGHT+IGDhoiAR6+SPV6l9gkJ9GqgbKuUfr+Ypx6yiSboEhAsPD7KOlm0W1MtjLNRdGCriZbrdVQ0lQ==
X-Received: by 2002:a17:902:ccc8:b0:227:e7c7:d451 with SMTP id d9443c01a7336-22ac3f9a8fcmr47578945ad.29.1744207539384;
        Wed, 09 Apr 2025 07:05:39 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22ac7c95cf3sm12080135ad.156.2025.04.09.07.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:05:38 -0700 (PDT)
Date: Wed, 9 Apr 2025 07:05:37 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
	Willem de Bruijn <willemb@google.com>,
	Matt Moeller <moeller.matt@gmail.com>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on
 skb frags
Message-ID: <Z_Z-sYHC9VkwIgs3@mini-arch>
References: <20250408132833.195491-1-willemdebruijn.kernel@gmail.com>
 <20250408132833.195491-2-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408132833.195491-2-willemdebruijn.kernel@gmail.com>

On 04/08, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Classic BPF socket filters with SKB_NET_OFF and SKB_LL_OFF fail to
> read when these offsets extend into frags.
> 
> This has been observed with iwlwifi and reproduced with tun with
> IFF_NAPI_FRAGS. The below straightforward socket filter on UDP port,
> applied to a RAW socket, will silently miss matching packets.
> 
>     const int offset_proto = offsetof(struct ip6_hdr, ip6_nxt);
>     const int offset_dport = sizeof(struct ip6_hdr) + offsetof(struct udphdr, dest);
>     struct sock_filter filter_code[] = {
>             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + SKF_AD_PKTTYPE),
>             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
>             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_NET_OFF + offset_proto),
>             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_UDP, 0, 2),
>             BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, SKF_NET_OFF + offset_dport),
> 
> This is unexpected behavior. Socket filter programs should be
> consistent regardless of environment. Silent misses are
> particularly concerning as hard to detect.
> 
> Use skb_copy_bits for offsets outside linear, same as done for
> non-SKF_(LL|NET) offsets.
> 
> Offset is always positive after subtracting the reference threshold
> SKB_(LL|NET)_OFF, so is always >= skb_(mac|network)_offset. The sum of
> the two is an offset against skb->data, and may be negative, but it
> cannot point before skb->head, as skb_(mac|network)_offset would too.
> 
> This appears to go back to when frag support was introduced to
> sk_run_filter in linux-2.4.4, before the introduction of git.
> 
> The amount of code change and 8/16/32 bit duplication are unfortunate.
> But any attempt I made to be smarter saved very few LoC while
> complicating the code.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/netdev/20250122200402.3461154-1-maze@google.com/
> Link: https://elixir.bootlin.com/linux/2.4.4/source/net/core/filter.c#L244
> Reported-by: Matt Moeller <moeller.matt@gmail.com>
> Co-developed-by: Maciej Żenczykowski <maze@google.com>
> Signed-off-by: Maciej Żenczykowski <maze@google.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> v2->v3
>   - do not remove bpf_internal_load_pointer_neg_helper, because it is
>     still used in the sparc32 JIT
> v1->v2
>   - introduce bfp_skb_load_helper_convert_offset to avoid open coding

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

