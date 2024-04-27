Return-Path: <bpf+bounces-28027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F228B4672
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B98B286097
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160D4F1FE;
	Sat, 27 Apr 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlAWlG+U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B338397;
	Sat, 27 Apr 2024 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714224497; cv=none; b=Q7e41NOcYb9KlNcGQLWFiYycqILtBt3iCqNxjz2Xm4D+kEtVvYS8EKufhKL2kslBIAd3vASKhJ7KbbHmONRAdwG2FOmOe3ayr7UkJLoKkD/S2PxIukqw/xOwjVlQXto/RoGHs8gQ8uaCdjp8Kqq2iZMHlFE4k2XCDTXHYVWpWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714224497; c=relaxed/simple;
	bh=0FgFVHBHqvmikkQgM66wEuM22PKjvHpLmK1Cvquaq6E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BlI1Ka9bTAoxa3/jTFXTcngbHEvDVnVpdhLfPBXid7mnsTZy0xntIpxa3nQ3IpAz9d0dj9cpxSb3FMMwVIKnwNDl/w9IXZ1/zLh+ODy+BKXq82vh1Ho5o3PHUf587Xj/I7PPs2HDHzEh++P3uIsWAe0NTL0EMYdHt+OP5wjvkjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlAWlG+U; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de5acdb3838so1664530276.1;
        Sat, 27 Apr 2024 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714224495; x=1714829295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87LQxMCFzcObveqzBmlgM5j0KC2+n+pWj0Kx+HOfrrw=;
        b=JlAWlG+UNhAvU4CUmkJdckFDhkto5zc0q+8QWOHBPLnpsdXVXVeoRDwDdp01afpeJn
         HhZMtP/wis3ZRQAq8KBla078yzwL+VhWDInC4AeiTdDmVjsvNZ7xBFI/uMVvNCa/AapF
         +Ms+b0zqd287+zb7PKUoapqWVf8Qhis0LFEcr0J4pqecLX9aCPwUJuWjqR2qf4ckkbsh
         EbtA7rci0qGwI57eTW5IGv4172+Xl83lb2g9bfEJRAJdD/MBw6XqDCHuEoHXvT2Zf1tU
         vfTZ8m2213hHqtQVp1CtJkCPq//aM6JKIfNjpQo3msekBnSw5ky6u9ZF6SXn4ic1Ddu5
         M7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714224495; x=1714829295;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=87LQxMCFzcObveqzBmlgM5j0KC2+n+pWj0Kx+HOfrrw=;
        b=k76tGg9d0s7LRpKrHlO8HoSirEi2/KNXWCbfyblGrzzfTHe4Pjuost/Qb8tDPfhqIv
         9XSDP6msNscFVLQ6AHPNKAl4Mho6zNSjiO/DPTYrAsjGEt5oUYKDXOTvnvx/yYlfSnUC
         m58ap3HHgSbUPR8yF7YOFZr0sOYrf4EeYbVbWQw7SqbBn7L/046PglzsQcctdplc1098
         sZJ0/Gt3kPaRW/1qJF9Gcja0bocW4nHRa9j6uiB7R0R993aPn8oMxbNZg2AAsndAHzi/
         kX71dpcYy+3tG2Fsi09KCbRgSIYvCZczkzXeCvnDv3Fbda0ZZbcbc+rNT0Ul4eDeBztJ
         zdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpM5jDNNc8FPg0X1HvfOSscsLSbtXP8Hg7okRPsCzqBtDBVcelvEykvc/RR3dP5bMfuSHKNLMLNIVTMO0yjcA52/mg+i4V0vetnUzDFYIvEn9mURsvk7+9h4Zb
X-Gm-Message-State: AOJu0YywksESSVuVbQsEidQSBOW7Vxi9H74JBEdXrehOMgCzYmOaFZus
	X60qi0ZNEIm9HsoUquELuoPsKIr4YfFxQ0NhIqUfBez711bXVhpl
X-Google-Smtp-Source: AGHT+IGXFM4gWf5+K2XYLC8ek2tJ389je6mbC7rg/XViC/wdLIAaqQ2vAt4nF1veEVyAws7ZuK1ccQ==
X-Received: by 2002:a25:d888:0:b0:dcf:464d:8ec3 with SMTP id p130-20020a25d888000000b00dcf464d8ec3mr6349090ybg.3.1714224494788;
        Sat, 27 Apr 2024 06:28:14 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id t23-20020ac865d7000000b00437794a29aesm8789638qto.71.2024.04.27.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 06:28:14 -0700 (PDT)
Date: Sat, 27 Apr 2024 09:28:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
 "maze@google.com" <maze@google.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "yan@cloudflare.com" <yan@cloudflare.com>
Message-ID: <662cfd6db06df_28b9852949a@willemb.c.googlers.com.notmuch>
In-Reply-To: <ae0ba22a-049a-49c1-d791-d0e953625904@iogearbox.net>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
 <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch>
 <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
 <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
 <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
 <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
 <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
 <6622acdd22168_122c5b2945@willemb.c.googlers.com.notmuch>
 <9f097bcafc5bacead23c769df4c3f63a80dcbad5.camel@mediatek.com>
 <6627ff5432c3a_1759e929467@willemb.c.googlers.com.notmuch>
 <274c7e9837e5bbe468d19aba7718cc1cf0f9a6eb.camel@mediatek.com>
 <66291716bcaed_1a760729446@willemb.c.googlers.com.notmuch>
 <c28a5c635f38a47f1be266c4328e5fbba44ff084.camel@mediatek.com>
 <662a63aeee385_1de39b294fd@willemb.c.googlers.com.notmuch>
 <752468b66d2f5766ea16381a0c5d7b82ab77c5c4.camel@mediatek.com>
 <ae0ba22a-049a-49c1-d791-d0e953625904@iogearbox.net>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann wrote:
> On 4/26/24 11:52 AM, Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> [...]
> >>>  From 301da5c9d65652bac6091d4cd64b751b3338f8bb Mon Sep 17 00:00:00
> >> 2001
> >>> From: Shiming Cheng <shiming.cheng@mediatek.com>
> >>> Date: Wed, 24 Apr 2024 13:42:35 +0800
> >>> Subject: [PATCH net] net: prevent BPF pulling SKB_GSO_FRAGLIST skb
> >>>
> >>> A SKB_GSO_FRAGLIST skb can't be pulled data
> >>> from its fraglist as it may result an invalid
> >>> segmentation or kernel exception.
> >>>
> >>> For such structured skb we limit the BPF pulling
> >>> data length smaller than skb_headlen() and return
> >>> error if exceeding.
> >>>
> >>> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> >>> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> >>> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> >>> ---
> >>>   net/core/filter.c | 5 +++++
> >>>   1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/net/core/filter.c b/net/core/filter.c
> >>> index 8adf95765cdd..8ed4d5d87167 100644
> >>> --- a/net/core/filter.c
> >>> +++ b/net/core/filter.c
> >>> @@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad,=

> >>> bpf_sp);
> >>>   static inline int __bpf_try_make_writable(struct sk_buff *skb,
> >>>     unsigned int write_len)
> >>>   {
> >>> +if (skb_is_gso(skb) &&
> >>> +    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
> >>> +     write_len > skb_headlen(skb)) {
> >>> +return -ENOMEM;
> >>> +}
> >>>   return skb_ensure_writable(skb, write_len);
> =

> Dumb question, but should this guard be more generically part of skb_en=
sure_writable()
> internals, presumably that would be inside pskb_may_pull_reason(), or o=
nly if we ever
> see more code instances similar to this?

Good point. Most callers of skb_ensure_writable correctly pull only
headers, so wouldn't cause this problem. But it also adds coverage to
things like tc pedit.

