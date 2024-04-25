Return-Path: <bpf+bounces-27815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA458B238B
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 16:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAE81C208E3
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9DE14A4D2;
	Thu, 25 Apr 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls9ZQDKY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0414A08B;
	Thu, 25 Apr 2024 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054066; cv=none; b=u4Ac+VzVz5ohrRPxT/NcEy07VmLJR523AF3wd1oNzSnNaKi+so51gc5RHZaO7Z9XYcxshiIM7k6GmQQor7M68iLtXp4ChD1RFFOQEaEBQgJTKUvZUr+TcPAv5wqGBm+y7V+RfvLyvhW4lujOcpyHuWC3T2tmKfkZh0BCmgugAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054066; c=relaxed/simple;
	bh=f912mfReOheDjns3RC7abWLfrtnapEajcYOVlQgNpps=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iDLDyhxjvNBM3RBnIYZF38FEYzgnWusi8mpGOF7YUF9o+wXlnhQFU9Gp4gpkiQ9ViI59bNF/msL5OAA0UT5LUIPuIB10aTQP5CfmzIwteZbGcdMAcEES4fNyjynNqeeOsqa2SHLS7ib/xcNsS3URjxiKfaT/TNMGSKYyPrksl+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls9ZQDKY; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b10c9cdf4so4136106d6.1;
        Thu, 25 Apr 2024 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714054064; x=1714658864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajyInVtzAAqe0l9PhKTduxRwaK1ASztz36ZB//OXaoc=;
        b=ls9ZQDKYg+XF4Jv811AwPVATF5JlgNUR1s5mhXokGMOSEr1JdkOXtg5r5JpNx1OFYe
         Ze4Ci/gdb7khOdTo0xN7L4InflfGyiuX/zwazG8oLXXgiPF47O4CL3lIrE3f5yc7edXF
         5Wzib+e8xkehe4QOW6irkSP0tNYp9lw6EWzv33FvHplaC8UIsBJAyHhS0xlAX6mD5HYv
         c/84xXOclDN/0JlJGdXiXORWgFXW1bB3sn3cAKQDO8gyXS+UZIOvnWEZxSEzrU63HCE5
         1WgYzVOr354lJjnPjCOfWq0a1eUVG1l3HK0FFXIZob7bqtsXj1q8oNvlIiPlKGv2o+/T
         vZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714054064; x=1714658864;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ajyInVtzAAqe0l9PhKTduxRwaK1ASztz36ZB//OXaoc=;
        b=rfN0d4KTA8Ex21Hk/oDCUnnPGorKvYXi6awbZfMcWD6ZURdR/P2R+jXEce2P0PPpjb
         doXVgDsLPl4guud4j5LYpEBBPsAICjJAbL62UZDUdmrGqeGyyTUOaehC3r39khp13sCM
         q4I/acJZGbBYPtE3+GM9NxKckTZIuV/LQOyRiPr9ZyvHUNHoVYZfwWsE+k6OCMEl6XqQ
         xogT0ThzFg67jM6fG1o8epNqYonTwKh719eEiRnWHFH+6H7zAvd3V93RqEw+pi6qFmTn
         7FwxdtYCUH5OYmd32MKQcD4Oc86prff2R2wJeMPDDcjXqGm5cAp7n71fsKt7Hahu/7az
         xtWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUC/St5zjIlASJeG72KF9icgbdlQlq7a8aC+F0b1mzO1P43mmaKU9Bc5kaIxTQKizwjK9qkgDkF26hhWqrYL5sixf8gCjHXxBBdkm/1Y4lhcR5Cdt/1WlzybOz
X-Gm-Message-State: AOJu0YwWPvIRbyIq+dEaoaGvnwfDf4zWwhAdiY8gUD7In7DVJdw/qaR/
	hR2AA4PA3YI4f0EwUwugoJSdIs0T8G7iPgQR0P6BZm0NOSwnYuRA
X-Google-Smtp-Source: AGHT+IEKQevdcF25H22KzEMeaVqYeb/Og5tSvrWKvAI7d6NJxvHnnoiJFq/p1ER0DWGbvizxwWlYyw==
X-Received: by 2002:a0c:9b12:0:b0:69b:6375:43f8 with SMTP id b18-20020a0c9b12000000b0069b637543f8mr6011430qve.13.1714054063582;
        Thu, 25 Apr 2024 07:07:43 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id g2-20020a0cdf02000000b0069b447066bbsm6963515qvl.78.2024.04.25.07.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:07:43 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:07:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
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
Message-ID: <662a63aeee385_1de39b294fd@willemb.c.googlers.com.notmuch>
In-Reply-To: <c28a5c635f38a47f1be266c4328e5fbba44ff084.camel@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
 <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
 <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
 <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
 <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
 <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch>
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
Content-Transfer-Encoding: 7bit

> > >  struct sk_buff *tail = NULL;
> > >  struct sk_buff *nskb, *tmp;
> > >  int len_diff, err;
> > > @@ -4504,6 +4505,9 @@ struct sk_buff *skb_segment_list(struct
> > sk_buff
> > > *skb,
> > >  if (err)
> > >  goto err_linearize;
> > >  
> > > +if (mss != GSO_BY_FRAGS && mss != skb_headlen(skb))
> > > +return ERR_PTR(-EFAULT);
> > > +
> > 
> > Do this precondition integrity check before the skb_unclone path?
> 
> After return error, the skb will enter into kfree_skb, not consume_skb.
> It may meet same crash problem which has been resolved by skb_unclone.
> 
> Or kfree_skb could well handle the cloned skb's release?

Since this is an error path it should reach kfree_skb rather than
consume_skb.

> 
> Other changes are updated as below:
> 
> From 301da5c9d65652bac6091d4cd64b751b3338f8bb Mon Sep 17 00:00:00 2001
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> Date: Wed, 24 Apr 2024 13:42:35 +0800
> Subject: [PATCH net] net: prevent BPF pulling SKB_GSO_FRAGLIST skb
> 
> A SKB_GSO_FRAGLIST skb can't be pulled data
> from its fraglist as it may result an invalid
> segmentation or kernel exception.
> 
> For such structured skb we limit the BPF pulling
> data length smaller than skb_headlen() and return
> error if exceeding.
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
>  net/core/filter.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8adf95765cdd..8ed4d5d87167 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad,
> bpf_sp);
>  static inline int __bpf_try_make_writable(struct sk_buff *skb,
>  					  unsigned int write_len)
>  {
> +	if (skb_is_gso(skb) &&
> +	    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
> +	     write_len > skb_headlen(skb)) {
> +		return -ENOMEM;
> +	}
>  	return skb_ensure_writable(skb, write_len);
>  }
>  
> -- 
> 2.18.0
> 
> 
> From 64d55392debbc90ef2e9c33441024d612075bdd7 Mon Sep 17 00:00:00 2001
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> Date: Wed, 24 Apr 2024 14:43:45 +0800
> Subject: [PATCH net] net: drop pulled SKB_GSO_FRAGLIST skb
> 
> A SKB_GSO_FRAGLIST skb without GSO_BY_FRAGS is
> expected to have all segments except the last
> to be gso_size long. If this does not hold, the
> skb has been modified and the fraglist gso integrity
> is lost. Drop the packet, as it cannot be segmented
> correctly by skb_segment_list.
> 
> The skb could be salvaged, though, right?
> By linearizing, dropping the SKB_GSO_FRAGLIST bit
> and entering the normal skb_segment path rather than
> the skb_segment_list path.

Drop the "though, right?"
> 
> That choice is currently made in the protocol caller,
> __udp_gso_segment. It's not trivial to add such a
> backup path here. So let's add this backstop against
> kernel crashes.
> 
> If the gso_size does not match skb_headlen(),
> it means part of or the entire fraglist has been pulled.
> It has been messed with and we should return error to
> free this skb.

This paragraph is now duplicative. Drop.
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
>  net/core/skbuff.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b99127712e67..4777f5fea6c3 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4491,6 +4491,7 @@ struct sk_buff *skb_segment_list(struct sk_buff
> *skb,
>  {
>  	struct sk_buff *list_skb = skb_shinfo(skb)->frag_list;
>  	unsigned int tnl_hlen = skb_tnl_header_len(skb);
> +	unsigned int mss = skb_shinfo(skb)->gso_size;
>  	unsigned int delta_truesize = 0;
>  	unsigned int delta_len = 0;
>  	struct sk_buff *tail = NULL;
> @@ -4504,6 +4505,9 @@ struct sk_buff *skb_segment_list(struct sk_buff
> *skb,
>  	if (err)
>  		goto err_linearize;
>  
> +	if (mss != GSO_BY_FRAGS && mss != skb_headlen(skb))
> +		return ERR_PTR(-EFAULT);
> +
>  	skb_shinfo(skb)->frag_list = NULL;
>  
>  	while (list_skb) {
> -- 
> 2.18.0



