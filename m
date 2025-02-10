Return-Path: <bpf+bounces-51059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B42A2FCFD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D1318881C2
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 22:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DD8250BE0;
	Mon, 10 Feb 2025 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhoEDTaB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A7024C69B;
	Mon, 10 Feb 2025 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739226497; cv=none; b=sDkfnOLnX3uuCTuTvx1PFbjLl7bnr4OH/1QyVcWn7Rg49p2kISVLqUIs1+JAmGb8SvXGwV3INdeCyzbVpRD6tX+9B4VIvaoyS6yzWz2ACMxFC6dhsIKeJndYRQ0/zIS+Runc2dw1cJ+BI42c95HPcGt+qT+QDzyHo15nXGQfzSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739226497; c=relaxed/simple;
	bh=ndLubKwFBHWtlTDCPdx1r2RbDgFfGS3iAmUDE2AS1Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKXA1OaXbhjq+JD3dYhGK24FidqAkQvtwxFP7NeZu2vwslz+0quOrwMVZmc10adrYvRnKzmsj8kH9+NGhSH5f9OSUWJ1fCiQY/ZU+xCxpDyhN7I0AH2Ucg9+FSAdyVgBF6YVSdN8G0+Dpnmlb2nxZ/E6Q9MnCNNDe+759wiTB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhoEDTaB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436345cc17bso33993285e9.0;
        Mon, 10 Feb 2025 14:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739226494; x=1739831294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkWWMjBJ1/YRt3lwgOfr2tNA5D2acLgDBlTp/Ye7Oa8=;
        b=ZhoEDTaBXqehH8mcLxQAJ+MlyetSpm6uDuUpb+RX7HFB7qOCdZZv4uvK6GPaDYCeQp
         2mSEo/6ok3aDLG9+DuWNZQSHqFibw0N+HY/VlJco1VVnPcM5UFxuGbsXbUHTJz5EE0X4
         eIlvskZCxsCzK4tOzWS7KmEjFVK2nTe9mx6hubyal4PqJVdZSEqVW7OSeKd9NyJT2ijZ
         MzJRNOpepCZQ1868xWtE5rLFBrb6/8Wp/VlP5KaNDSRSECDrEKkcKNnFZjVNnOpor+kU
         xOgiXYtRuhfmhC2vL0nMoHB18Jq9soqo8o4MC1YgUhzu6oES/+mByRdUIsGjOhAHSFWg
         /tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739226494; x=1739831294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkWWMjBJ1/YRt3lwgOfr2tNA5D2acLgDBlTp/Ye7Oa8=;
        b=Q2RqAuTJTW7dRtu/fgwUJemHOZdePj6xVrI0k7GfyCh9SAgyHtVjFVFr2IT6Uuj6yH
         h5kBbG5eZY0nbfLBQkfSeZDSieTjNJ2/pElMPYMczGDagiUfX/dUO8J2Fo3uMEDH3wzG
         rZK/01uzQkVgXMQDrlbB3eszId+mKqbAJr7W62NRmYMJ0jgtmp4YaZD1NGJf4ykvkcQH
         ziMYnBmoe4g7wxt/Xyrq4e9/mv7u98M4EWm2KptsjB4AVsL7wbHH777I6uTgDwgKZ4qr
         VAxN/x6+s8JtlK5s/5a+3k/xBVmeDrLbn1w6gO3Y1951WKxIuYxKZKQ++tLy+CX+a85n
         45pA==
X-Forwarded-Encrypted: i=1; AJvYcCVtHYv6+1ERM5iWfoFfGi5gru7V2dRbVoHuLNIiX+F3e70cg/I1SnEWEVh0P7bJ68z/JCQ=@vger.kernel.org, AJvYcCXeMhqmgulTOWQUxUcwSo9uf9CggIsyFQjpxf7zwVf8KuoMu5xNZlD/FExlFx75ZyhuWd9q1lYy@vger.kernel.org, AJvYcCXzC6vzdXgh1Q7szSLg6GiIg2HgjCvLqxq+qbw8bljMTb1J06nI7rVu395PNsLNpXnyjBexdeCb8NlrHMH6@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2nOOni+76oB1qFqns6f4pZ5N0nfK8JF9LFhn9TAn1+jT4wSk
	H7w87V9fYJyLn0Ipe0C/UFapOU8VihU5jIRlkqhPsK22Mceskl2QUMrW/Q==
X-Gm-Gg: ASbGncvNPdJXUAsQMMg4o1pZ0JdaWfCbL6SPyF51Bm92HltlDEHjAK68YmtMlWm+Wre
	j02oye2vSG2H1brr2pNqVTfbckBR1X4ruOZOIIc9LhtiSXak7lsbj5sV9CEFRFL6o/BXVGc44T+
	+WPBSO8w3KCsD6XyLgge0h/+kDGblioj3eA2vSOmgpkqY0QNZ5WiT12lVxNgRFqFzZodf5ab4Hi
	6k8tYZdjc2FvlTIKiTIo2A4mWZTZ/l3oLn8lh5/uojv3Ei47jNSEJowbmt46jcvcFn2iJumX0xe
	tbZZdVBQJ+J1sDyKnb6dtmtYYEJfb4J9RaSUjSuYuB0FA+WRQxa1/w==
X-Google-Smtp-Source: AGHT+IHN7gLlSgITrNkUYlErBuW/66QbgQ6hSOX+j8FGt+/mR40pZI3bKrEQ0DY8izu56Um9ILmDrg==
X-Received: by 2002:a05:600c:cce:b0:434:f131:1e64 with SMTP id 5b1f17b1804b1-4394c815898mr12942205e9.9.1739226493939;
        Mon, 10 Feb 2025 14:28:13 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc0c5a894sm12940620f8f.95.2025.02.10.14.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:28:13 -0800 (PST)
Date: Mon, 10 Feb 2025 22:28:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, "Jose E.
 Marchesi" <jose.marchesi@oracle.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, Casey
 Schaufler <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] i40e: use generic unrolled_count() macro
Message-ID: <20250210222812.1d0479a4@pumpkin>
In-Reply-To: <20250206182630.3914318-3-aleksander.lobakin@intel.com>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
	<20250206182630.3914318-3-aleksander.lobakin@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 19:26:27 +0100
Alexander Lobakin <aleksander.lobakin@intel.com> wrote:

> i40e, as well as ice, has a custom loop unrolling macro for unrolling
> Tx descriptors filling on XSk xmit.
> Replace i40e defs with generic unrolled_count(), which is also more
> convenient as it allows passing defines as its argument, not hardcoded
> values, while the loop declaration will still be a usual for-loop.
..
>  #define PKTS_PER_BATCH 4
>  
> -#ifdef __clang__
> -#define loop_unrolled_for _Pragma("clang loop unroll_count(4)") for
> -#elif __GNUC__ >= 8
> -#define loop_unrolled_for _Pragma("GCC unroll 4") for
> -#else
> -#define loop_unrolled_for for
> -#endif
...
> @@ -529,7 +530,8 @@ static void i40e_xmit_pkt_batch(struct i40e_ring *xdp_ring, struct xdp_desc *des
>  	dma_addr_t dma;
>  	u32 i;
>  
> -	loop_unrolled_for(i = 0; i < PKTS_PER_BATCH; i++) {
> +	unrolled_count(PKTS_PER_BATCH)
> +	for (i = 0; i < PKTS_PER_BATCH; i++) {
>  		u32 cmd = I40E_TX_DESC_CMD_ICRC | xsk_is_eop_desc(&desc[i]);
>  
>  		dma = xsk_buff_raw_get_dma(xdp_ring->xsk_pool, desc[i].addr);

The rest of that code is:


		tx_desc = I40E_TX_DESC(xdp_ring, ntu++);
		tx_desc->buffer_addr = cpu_to_le64(dma);
		tx_desc->cmd_type_offset_bsz = build_ctob(cmd, 0, desc[i].len, 0);

		*total_bytes += desc[i].len;
	}

	xdp_ring->next_to_use = ntu;
}

static void i40e_fill_tx_hw_ring(struct i40e_ring *xdp_ring, struct xdp_desc *descs, u32 nb_pkts,
				 unsigned int *total_bytes)
{
	u32 batched, leftover, i;

	batched = nb_pkts & ~(PKTS_PER_BATCH - 1);
	leftover = nb_pkts & (PKTS_PER_BATCH - 1);
	for (i = 0; i < batched; i += PKTS_PER_BATCH)
		i40e_xmit_pkt_batch(xdp_ring, &descs[i], total_bytes);
	for (i = batched; i < batched + leftover; i++)
		i40e_xmit_pkt(xdp_ring, &descs[i], total_bytes);
}

If it isn't a silly question why all the faffing with unrolling?
It isn't as though the loop body is trivial - it contains real function calls.
Unrolling loops is so 1980s - unless you are trying to get the absolute
max performance from a very short loop and need to unroll once (maybe twice)
to get enough spare instruction execution slots to run the loop control
code in parallel with the body.

In this case it looks like the 'batched' loop contains an inlined copy of
the function called for the remainder.
I can't see anything else.
You'd probably gain more by getting rid of the 'int *total bytes' and using
the function return value - that is what it is fot.

	David


