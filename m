Return-Path: <bpf+bounces-5963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950E87638CA
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 16:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B795D1C203D7
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 14:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3501253B4;
	Wed, 26 Jul 2023 14:15:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB89453
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 14:15:36 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D53F30F7
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 07:15:13 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-768197bad1cso689535085a.1
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690380899; x=1690985699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pkT7MMdb9UBp/NLJEI4W0DlkPyX5NSU+s0eXsj5hKk4=;
        b=ArqoWPeAyncX4vD74ueZ5Js2tYqx0nA4v2zayia01BhK4FXcrSsDaORXb7e/OUEIip
         4koEGH7ywBK8hSNYR0G2pR0BpUajVfz4DXKEiEwAcPq0Fm3UubKlGIOQv3zTmxpvbuCN
         KxbB2jgQ59Oa+0WN0ov8gk9koKANE2QuzG75Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380899; x=1690985699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkT7MMdb9UBp/NLJEI4W0DlkPyX5NSU+s0eXsj5hKk4=;
        b=IkVu24tDStTu5C7VLZs2/eDiSuuFlb964/jmymdIm4gw3Gd/mhvwGiFXR+ZsTM18ny
         FZl7GqCufo3xUoruwG5HNCRnSCtpeRKvQhbRSxP3JM7YBLepn7kXlo5lBXx67GigIQLS
         OoBf0DpCij5xGj+RNaP5/xZyZsZrnJEOPt26KFPZqZ+b/2ymoz1DDEQLPFBzoS0tkD6P
         OJ/xYEjF0LVk/r1fLFov+bz4ltVOBfaZ4JX7V4s1TI9IRgcXC5pWB9XXGHiQKEjU5Y+g
         dZUMYr/9liAAMbtptQjK7TaomK8nbq9vZTvod2QvzhclCR8bqeW/BpM1Zsbp2ianWevp
         XykQ==
X-Gm-Message-State: ABy/qLZICjyC0Fk/7SiwXm0jKH6Sl5hRYJ4KXWFpVkppLNhVmhZwhdnj
	ePZCe/O4cj/hbCkwbDDEcWJixw==
X-Google-Smtp-Source: APBJJlHDKfiHrxrJlUQB/01vzgVpNRZ51nZL7np3HYytRP6PbdM40X7VtRY//Id8IKHB1T0qoHBLPQ==
X-Received: by 2002:a05:620a:2a01:b0:76c:4d4c:7942 with SMTP id o1-20020a05620a2a0100b0076c4d4c7942mr2763882qkp.21.1690380899352;
        Wed, 26 Jul 2023 07:14:59 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id t4-20020a05620a004400b00767c8308329sm1160072qkt.25.2023.07.26.07.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:14:58 -0700 (PDT)
Date: Wed, 26 Jul 2023 07:14:56 -0700
From: Yan Zhai <yan@cloudflare.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yan Zhai <yan@cloudflare.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
	Jordan Griege <jgriege@cloudflare.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
Message-ID: <ZMEqYOOBc1ZNcEER@debian.debian>
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
 <a76b300a-e472-4568-b734-37115927621d@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76b300a-e472-4568-b734-37115927621d@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 04:39:08PM +0300, Dan Carpenter wrote:
> I'm not positive I understand the code in ip_finish_output2().  I think
> instead of looking for LWTUNNEL_XMIT_DONE it should instead look for
> != LWTUNNEL_XMIT_CONTINUE.  It's unfortunate that NET_XMIT_DROP and
> LWTUNNEL_XMIT_CONTINUE are the both 0x1.  Why don't we just change that
> instead?
> 
I considered about changing lwt side logic. But it would bring larger
impact since there are multiple types of encaps on this hook, not just
bpf redirect. Changing bpf return values is a minimum change on the
other hand. In addition, returning value of NET_RX_DROP and
NET_XMIT_CN are the same, so if we don't do something in bpf redirect,
there is no way to distinguish them later: the former is considered as
an error, while "CN" is considered as non-error.

> Also there seems to be a leak in lwtunnel_xmit().  Should that return
> LWTUNNEL_XMIT_CONTINUE or should it call kfree_skb() before returning?
> 
> Something like the following?
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 11652e464f5d..375790b672bc 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -112,6 +112,9 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev);
>  #define NET_XMIT_CN		0x02	/* congestion notification	*/
>  #define NET_XMIT_MASK		0x0f	/* qdisc flags in net/sch_generic.h */
>  
> +#define LWTUNNEL_XMIT_DONE NET_XMIT_SUCCESS
> +#define LWTUNNEL_XMIT_CONTINUE 0x3
> +
>  /* NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
>   * indicates that the device will soon be dropping packets, or already drops
>   * some packets of the same priority; prompting us to send less aggressively. */
> diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
> index 6f15e6fa154e..8ab032ee04d0 100644
> --- a/include/net/lwtunnel.h
> +++ b/include/net/lwtunnel.h
> @@ -16,12 +16,6 @@
>  #define LWTUNNEL_STATE_INPUT_REDIRECT	BIT(1)
>  #define LWTUNNEL_STATE_XMIT_REDIRECT	BIT(2)
>  
> -enum {
> -	LWTUNNEL_XMIT_DONE,
> -	LWTUNNEL_XMIT_CONTINUE,
> -};
> -
> -
>  struct lwtunnel_state {
>  	__u16		type;
>  	__u16		flags;
> diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
> index 711cd3b4347a..732415d1287d 100644
> --- a/net/core/lwtunnel.c
> +++ b/net/core/lwtunnel.c
> @@ -371,7 +371,7 @@ int lwtunnel_xmit(struct sk_buff *skb)
>  
>  	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
>  	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
> -		return 0;
> +		return LWTUNNEL_XMIT_CONTINUE;

You are correct this path would leak skb. Return continue (or drop)
would avoid the leak. Personally I'd prefer drop instead to signal the
error setup. Since this is a separate issue, do you want to send a
separate patch on this? Or I am happy to do it if you prefer.

>  
>  	ret = -EOPNOTSUPP;
>  	rcu_read_lock();
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 6e70839257f7..4be50a211b14 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -216,7 +216,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
>  	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
>  		int res = lwtunnel_xmit(skb);
>  
> -		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
> +		if (res != LWTUNNEL_XMIT_CONTINUE)
>  			return res;

Unfortunately we cannot return res directly here when res > 0. This is
the final reason why I didn't patch here. Return values here can be
propagated back to sendmsg syscall, so returning a positive value
would break the syscall convention.


best,
Yan

>  	}
>  
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 1e8c90e97608..016b0a513259 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -113,7 +113,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
>  	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
>  		int res = lwtunnel_xmit(skb);
>  
> -		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
> +		if (res != LWTUNNEL_XMIT_CONTINUE)
>  			return res;
>  	}
>  

