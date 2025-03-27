Return-Path: <bpf+bounces-54839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D9AA73FFC
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 22:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6B0171C44
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A661DC197;
	Thu, 27 Mar 2025 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP3oo9ty"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61EB1CAA82;
	Thu, 27 Mar 2025 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109696; cv=none; b=b5JyKJfI6WRRz5lwa5uqpRbVD8/lT9RrqR4awdiOhGLBWgCTKldlC6T39bGc4FLaXRPhQ1U/tEibDCVxydlu8Tgzfc+TQmcVBiLjMSQD9CePk+AB5N1VkXnFMWmEhBDz5M00b4oNwgogTFKJ32/frzI29aITm+j4Jv5rTcztbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109696; c=relaxed/simple;
	bh=77EkUVszkmEbzEqLes/Nu+IUfijxLgcQ8T1ZcfYFY7U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GnmHrC9HI7o0Hul1wSOlZFwdAgj/1UmSqU2J+LmF4H78IhU7tz4QFQzbz3+9tSiINSPjSqpWlmUdEY4BpTEgc17DxQGLxY8PFZy7PDwBxwB+N1dHmWmnWB6+g+qO5W0SOR74kAD1xdgM+shB53ujx91Rys/cbtV1Zzijb6U7kZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gP3oo9ty; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5c815f8efso140548885a.2;
        Thu, 27 Mar 2025 14:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743109693; x=1743714493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeu2JB+mx0KaM2uQS9V3X+ku0XSSDucc01lT5oToDO8=;
        b=gP3oo9ty4TFP+UspnqsJydjriYdfe+LbvqH6E1q9uPQ8v2WlY/+iE6JFfZ4ywHSYdr
         YmVWg/1Xzv9GnyTCtyjLmdEgQyJ7+cz5ewJyrYeXOwECdSBuatBbh63YWavDyInRns7z
         GvPXNvJd+4qTZKiwStGkWRZJ15i2GNLmkvkIK3XXfsByrLsqjdOtbQ9jpJ7h6idqlxqF
         B8G1FId07s7AbjZIVKaBpOfrHHRccq9Bv6iDf1u46Wh6RRun6VZd8j4El5PRLwryjEgT
         IrkB2AYQXTAZMsAPK/lBdnng5+CbR+hC8h9gL1Q2meNJ9FBAJn70dEhO1PQGNesvvAiV
         iitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743109693; x=1743714493;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oeu2JB+mx0KaM2uQS9V3X+ku0XSSDucc01lT5oToDO8=;
        b=t4zG7fMo+WQCG8JenCweaQ6dCtyV/ABdZ5rlrGjUtlE5oijGi8DFNbDelkqvPnc/7U
         FR2QnsByPhww5eUTWWESdSpt2iGSsm2Iak9K4npCQPjN2QgOR2w2CfWPAaBr2UeAU8UK
         +toS65AOlf8rcVPL+SXe3fShWzPo22uIKfTuYac2BkxnCpGPg4jPyiU7pKRXwNW+lVDz
         qAjf1dcwIjbG5cdkddQZeLUzsyMDKIQKxPTJBIKtYozs1V9DiO3F+/EqEZKzn/5Nspgk
         R9Ijs35LQCo3y5lIl+N/XxrFqrmuq5vvgf9Al0usIGTHi2bG+53auCJHSGUPsT9mtMu7
         RGqA==
X-Forwarded-Encrypted: i=1; AJvYcCUI3RXLEQkrn1vVxyClySNkev0eALxmxywtWpkvk37E062nl4sUhinEPVH4CwtVadZN8n8mMu/5@vger.kernel.org, AJvYcCUX3pND8KU6MB2SEqrMMixzWLGKlyUaoaqBMVqRAsHcuWke9NFZ6s3tx5QmFNRzwQI+QA2VULj3+y97oO2i@vger.kernel.org, AJvYcCVsIO08x5k3NH2RQpSUaxLoXxbq+oWKayzc0DBHBE+8fqh5LJeRk3cHN608kAW5GCoMNOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0VjIhohcR/77w3sJBIMQ6ttRZqAyaxfrLrGszaWaJC3fASnN
	kJiYDQ1rA4KQJ80CiuQiHiRErdc2E+feCOOLmTJwxuC4hbpFWYTn
X-Gm-Gg: ASbGncukutCckL10DbZEdCCKhCSOnrlb40IJwQ7qli7uXgvaaMzO+XingGYCwU2ZNGI
	IDwYVA8k3O6QwdIw7LYNeE4+7MygVsZ80LFX/SbItA3TDHqGpmtc4IIoADd/skabSAJiKQsfdS/
	E6gMccQoid0pEwAFPK0BJy4kwHWXGPDtOgVXvHhtEB751GfndhBu5ld94GAIbEjau0+Bn/8T6as
	3hc0o2sYUiu2XR2jrnvpwaeDQPE8j0vm1/3TeprNC3wk1WN0vrDTwCiGK1Gvm19IONmplu3bkkn
	zVzsECY4Zbw8sbktoIzd4A7FxtJmhP6KxIF4TVJRsa/Tp1ZC+ZnYQj0Z6kamdQqYRa22r7OR7/y
	gcCjNH7CzqjfW54vT6ML9cQ==
X-Google-Smtp-Source: AGHT+IGnG+gkYq6LUwDQr86gdBbLjdQ0dJkNas97bDnCLuL3B3wsSnncWxC+52muYTlWqmYhefrvbw==
X-Received: by 2002:a05:620a:2492:b0:7c5:ad3c:8478 with SMTP id af79cd13be357-7c5ed9f4f9cmr685043085a.16.1743109693366;
        Thu, 27 Mar 2025 14:08:13 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f76aacf9sm33654685a.54.2025.03.27.14.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 14:08:12 -0700 (PDT)
Date: Thu, 27 Mar 2025 17:08:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 linux-kernel@vger.kernel.org, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com, 
 bpf@vger.kernel.org
Message-ID: <67e5be3c65de3_10636329488@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250327134122.399874-1-jiayuan.chen@linux.dev>
References: <20250327134122.399874-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH net v1] net: Fix tuntap uninitialized value
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jiayuan Chen wrote:
> Then tun/tap allocates an skb, it additionally allocates a prepad size
> (usually equal to NET_SKB_PAD) but leaves it uninitialized.
> 
> bpf_xdp_adjust_head() may move skb->data forward, which may lead to an
> issue.
> 
> Since the linear address is likely to be allocated from kmem_cache, it's
> unlikely to trigger a KMSAN warning. We need some tricks, such as forcing
> kmem_cache_shrink in __do_kmalloc_node, to reproduce the issue and trigger
> a KMSAN warning.
> 
> Reported-by: syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/00000000000067f65105edbd295d@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  drivers/net/tun.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index f75f912a0225..111f83668b5e 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1463,6 +1463,7 @@ static struct sk_buff *tun_alloc_skb(struct tun_file *tfile,
>  	if (!skb)
>  		return ERR_PTR(err);
>  
> +	memset(skb->data, 0, prepad);
>  	skb_reserve(skb, prepad);
>  	skb_put(skb, linear);
>  	skb->data_len = len - linear;

Is this specific to the tun device?

This happens in generic (skb) xdp.

The stackdump shows a napi poll call stack

    bpf_prog_run_generic_xdp+0x13ff/0x1a30 net/core/dev.c:4782
    netif_receive_generic_xdp+0x639/0x910 net/core/dev.c:4845
    do_xdp_generic net/core/dev.c:4904 [inline]
    __netif_receive_skb_core+0x290f/0x6360 net/core/dev.c:5310
    __netif_receive_skb_one_core net/core/dev.c:5487 [inline]
    __netif_receive_skb+0xc8/0x5d0 net/core/dev.c:5603
    process_backlog+0x45a/0x890 net/core/dev.c:5931

Since this is syzbot, the skb will have come from a tun device,
seemingly with IFF_NAPI, and maybe IFF_NAPI_FRAGS.

But relevant to bpf_xdp_adjust_head is how the xdp metadata
was setup with xdp_prepare_buff, which here is called from
bpf_prog_run_generic_xdp:

        /* The XDP program wants to see the packet starting at the MAC
         * header.
         */
        mac_len = skb->data - skb_mac_header(skb);
        hard_start = skb->data - skb_headroom(skb);

        /* SKB "head" area always have tailroom for skb_shared_info */
        frame_sz = (void *)skb_end_pointer(skb) - hard_start;
        frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));

        rxqueue = netif_get_rxqueue(skb);
        xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
        xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
                         skb_headlen(skb) + mac_len, true);

> @@ -1621,6 +1622,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  		return ERR_PTR(-ENOMEM);
>  
>  	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
> +	memset(buf, 0, pad);
>  	copied = copy_page_from_iter(alloc_frag->page,
>  				     alloc_frag->offset + pad,
>  				     len, from);
> -- 
> 2.47.1
> 



