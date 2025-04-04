Return-Path: <bpf+bounces-55334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AA5A7C041
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 17:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50453BA72C
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 15:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D777D1EFF9D;
	Fri,  4 Apr 2025 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLI13ioW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5E1F4613;
	Fri,  4 Apr 2025 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779293; cv=none; b=uxKzlCVLbqPY1bGkO7mw9j2XTXUJNN1bZ4nbbWUgC+dc+bDVIc4eKKdILBMhz1abUDDNCvj2X/D/ym3or6cs5U8agPXyElJ9xhFhbFhkLnqafQshYPIjDitGN2sO9mZfnH2RszoYSYzJjNoZATOJjLz1xhumb6kljjP02HZ84Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779293; c=relaxed/simple;
	bh=vq9GbgjstfoqPsa+7hy6y/9oAq0Am4jb89bAY1I73Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/7bU8fUwobQ6vXrWr8LvGGJKldLsEGxo3TMo7cUON/N6xWJvOp4d5BL6p0U54XyNH7gMWiwJUzPy9/Lx7gXmt9wZ0DlMAsDkWQqafpirzR+sar4ZbcUA6B/0iKJpP1NppvAl+zosFeHT5GjJbhQJn4RgnlA9eVDiMDUw3AjSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLI13ioW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30332dfc820so2126090a91.2;
        Fri, 04 Apr 2025 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743779291; x=1744384091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s6n5YGLWlsOwS5VueoZaIIIIcpHRH9mcMIwh+Iq5scc=;
        b=SLI13ioWFk2px1l0olgLQgmUiPu5k19p2R9NbtCUaCrHr7TTwTyQVcRqXTvJ/fvBE4
         GAEfw06kBcP0b+tNpVjWhmv5uiiGL9jVG9dK6JUpx0L44hYGbHWJwcCUbJkrA33vuXcw
         BQ1U0+ckqqHf7CW7eNmnzvxVRqqv55d33F3knq2D5dqjdSXAKbNfPKOGHjENKk7/e9Oe
         RSjL4Wjkj/jX6Gnyz2++ojAx6U2GeIFnuANAtHWWwB6JVAaBOSk9zbXVqhBw/NCjpM5g
         Vc0pcQ2tNzBQxhIr+T7QsxjggYcrknnGgq4GxgYlnx2Dqi4VZKeU7p496xcLnqAU0Evi
         8uWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743779291; x=1744384091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6n5YGLWlsOwS5VueoZaIIIIcpHRH9mcMIwh+Iq5scc=;
        b=Xmxpp0o86rW9g4LiIMDcI/jIF/3dJAjd/y9Y1tJtdMS+nPipw8iRfL3eQ4MiczTUSH
         xrFmnjuZqwu77qRs5QntuH38oTPTMAjzKPCVxLTnvi2GYNJG/Vjby+lZX2RrL678djGE
         Q4yCmIdsnhRPGd6iLKqiAlz/WjU07JprzmznjK5eF4GGkzl1L1sli9GBwZ562apfsgzL
         /LAFLpSxMGkO8BgXOK8xEWv9r1vhn+mTbCFhLATWU4fMoj3pBtgX0Ucs9+0aSpo8M/l2
         Pmpvlh9jLN6g8wv2RDqctSO1ugOvJCltU5jzNyvd3kE+T0azP9e9hk53C52zp3YDwzaY
         Snjw==
X-Forwarded-Encrypted: i=1; AJvYcCUqK2YvsQGiRSoj82A6VPAQg0UyyGwUZCpj7+E+YHC9WbVlTiSougOHezSD5kylEnnn/Ff9L18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQi4moKlm1smCL+t6p/I6OnQ5Lnshtm6x7QHpogkyxDxTkGQA
	qkkvH4AHUQxHSpgTZ1bGWMCpHakBjaBjxgt4qqQtStjWl/B4eEI=
X-Gm-Gg: ASbGncsQgTDXqvqiWyr5MA9gwE0oPjXzsRBRxTsbIej2X3+3frPN1KySCSsVAwCh8T/
	xxsAd6Esi2Hetkv9TAKM22oHQqHuY9bIZylNsDxEfuUaSWdepmOa0nw4YmCGqMkWoFWNkGUgd8c
	AB1l8eGjHMKaLenDPM7mo9QX/ZgFK0fT6rxEFmKUAAZ2yR2XN2GYchNVSBQccuUeOcNNxJ/MXQK
	4M1RHLm5Bv1Ja6UV8Dy18o3aer/tuwT3cyqLnu1mvU4ca584lQQ7eGf0neLrcP4N86GtGE7dfTH
	tShwiwhmlfSdo0LZwNWWjvGwWAJGBewpW0d3HNrfm4ot
X-Google-Smtp-Source: AGHT+IFAZMS7vsIpttL8Jucjx8QTP0oGAAMB/Lk6xoxKyITT1i7d+cbXE2MPxqrNDmmNdLPdpUqHsg==
X-Received: by 2002:a17:90a:d88f:b0:2ff:53ad:a0ec with SMTP id 98e67ed59e1d1-306a48ac4f1mr4761779a91.21.1743779290994;
        Fri, 04 Apr 2025 08:08:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-305840b460asm3586102a91.11.2025.04.04.08.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 08:08:10 -0700 (PDT)
Date: Fri, 4 Apr 2025 08:08:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Matt Moeller <moeller.matt@gmail.com>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on
 skb frags
Message-ID: <Z-_12YMLYnXVO1u5@mini-arch>
References: <20250404142633.1955847-1-willemdebruijn.kernel@gmail.com>
 <20250404142633.1955847-2-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250404142633.1955847-2-willemdebruijn.kernel@gmail.com>

On 04/04, Willem de Bruijn wrote:
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
> v1->v2
>   - introduce bfp_skb_load_helper_convert_offset to avoid open coding

Thank you!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

