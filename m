Return-Path: <bpf+bounces-5970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4B77639CD
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 17:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B401C2133A
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD09BA23;
	Wed, 26 Jul 2023 15:01:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1EC12E
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 15:01:10 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A4D19A0
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 08:01:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso5664683f8f.0
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690383665; x=1690988465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zM+YG+vsWbtMUD6XdWA2JUgtaWQiytdCsuMze1m6/k=;
        b=xN+/DtpXH07sL2bRF9VUZv/uyejUHbIwAWXONp9i6bShF/IthrYdyTZLT21dJM/qr8
         I5ew8CLX5YeZDjgGUd0yCTtM771EB4OKUZjDuYcLHEaWfVdyDLZGq/VJCmjTyislOOH7
         /bdLpRikQFGNfjB9iskGIEUSrPpeNj2QJIV9AGMxkZ1jJVqVEtpT9G2eBVLNr+aJGdEj
         1eTC3DrbPKi9DAuK/CaO6tyHt6309JGswVakuEOJv5B2n9LzhB8lGoll4rZFuKDZc+Jj
         6zJ1a1mF6OY1s5ZHeY+fsVt7T9UdyA65pK+Zijy+e6VHka5DD7sHx0yTUV0npYpashkR
         8RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383665; x=1690988465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zM+YG+vsWbtMUD6XdWA2JUgtaWQiytdCsuMze1m6/k=;
        b=jSsoFPFEp9kiBs+ktb0g37/P2CGUyuId/tptimZZKRhdwmiD2iZHinVmlGRq81VMVa
         mxP7XXI4WQ1MssHuxpHO7qUdbq0DYotNl7wZG1Jq1PMrd+K8JZ8TYbbBmh7pPVZwIvGn
         JCDlgAbTjaEn4QpO5N0E5UdJ578Rc3MO50BuO1fQcbo6oj5+9Akb1e7Tep1XXwi4eYrA
         B54OoEPGglTjqQjQr7ublcqu0EkmoOEi4nxxox0JGEBeKvUk4kBBySf8AZUt+0Xq9oeo
         +LcAPLX3v7XKfjKLUyxVeckyFJeGdry9vrszW118IGQPasFkRZwp6yoPLEXUj3A1e3Gh
         P6sg==
X-Gm-Message-State: ABy/qLZZ8yHqZuQJZNtPF/T+1vIbr8opU9QTtwoTihDQMZzWwxHdsqoo
	laGw/bhL1K+dv3ZuiTiWEKAKSA==
X-Google-Smtp-Source: APBJJlEaZJPaPa+6TPkoJHqPWeFXbl2DaYbcmbJ8WCzC3KLHfm3d4h9pKWO+0VMCv16cBZiIKuONVw==
X-Received: by 2002:adf:f786:0:b0:317:49e9:c57 with SMTP id q6-20020adff786000000b0031749e90c57mr1591410wrp.43.1690383664792;
        Wed, 26 Jul 2023 08:01:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o20-20020a5d58d4000000b0031433443265sm20096799wrf.53.2023.07.26.08.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:01:03 -0700 (PDT)
Date: Wed, 26 Jul 2023 18:01:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <bc3ec02d-4d4e-477a-b8a5-5245425326c6@kadam.mountain>
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
 <a76b300a-e472-4568-b734-37115927621d@moroto.mountain>
 <ZMEqYOOBc1ZNcEER@debian.debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMEqYOOBc1ZNcEER@debian.debian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 07:14:56AM -0700, Yan Zhai wrote:
> On Wed, Jul 26, 2023 at 04:39:08PM +0300, Dan Carpenter wrote:
> > I'm not positive I understand the code in ip_finish_output2().  I think
> > instead of looking for LWTUNNEL_XMIT_DONE it should instead look for
> > != LWTUNNEL_XMIT_CONTINUE.  It's unfortunate that NET_XMIT_DROP and
> > LWTUNNEL_XMIT_CONTINUE are the both 0x1.  Why don't we just change that
> > instead?
> > 
> I considered about changing lwt side logic. But it would bring larger
> impact since there are multiple types of encaps on this hook, not just
> bpf redirect. Changing bpf return values is a minimum change on the
> other hand. In addition, returning value of NET_RX_DROP and
> NET_XMIT_CN are the same, so if we don't do something in bpf redirect,
> there is no way to distinguish them later: the former is considered as
> an error, while "CN" is considered as non-error.

Uh, NET_RX/XMIT_DROP values are 1.  NET_XMIT_CN is 2.

I'm not an expert but I think what happens is that we treat NET_XMIT_CN
as success so that it takes a while for the resend to happen.
Eventually the TCP layer will detect it as a dropped packet.

> 
> > Also there seems to be a leak in lwtunnel_xmit().  Should that return
> > LWTUNNEL_XMIT_CONTINUE or should it call kfree_skb() before returning?
> > 
> > Something like the following?
> > 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 11652e464f5d..375790b672bc 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -112,6 +112,9 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev);
> >  #define NET_XMIT_CN		0x02	/* congestion notification	*/
> >  #define NET_XMIT_MASK		0x0f	/* qdisc flags in net/sch_generic.h */
> >  
> > +#define LWTUNNEL_XMIT_DONE NET_XMIT_SUCCESS
> > +#define LWTUNNEL_XMIT_CONTINUE 0x3
> > +
> >  /* NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
> >   * indicates that the device will soon be dropping packets, or already drops
> >   * some packets of the same priority; prompting us to send less aggressively. */
> > diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
> > index 6f15e6fa154e..8ab032ee04d0 100644
> > --- a/include/net/lwtunnel.h
> > +++ b/include/net/lwtunnel.h
> > @@ -16,12 +16,6 @@
> >  #define LWTUNNEL_STATE_INPUT_REDIRECT	BIT(1)
> >  #define LWTUNNEL_STATE_XMIT_REDIRECT	BIT(2)
> >  
> > -enum {
> > -	LWTUNNEL_XMIT_DONE,
> > -	LWTUNNEL_XMIT_CONTINUE,
> > -};
> > -
> > -
> >  struct lwtunnel_state {
> >  	__u16		type;
> >  	__u16		flags;
> > diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
> > index 711cd3b4347a..732415d1287d 100644
> > --- a/net/core/lwtunnel.c
> > +++ b/net/core/lwtunnel.c
> > @@ -371,7 +371,7 @@ int lwtunnel_xmit(struct sk_buff *skb)
> >  
> >  	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
> >  	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
> > -		return 0;
> > +		return LWTUNNEL_XMIT_CONTINUE;
> 
> You are correct this path would leak skb. Return continue (or drop)
> would avoid the leak. Personally I'd prefer drop instead to signal the
> error setup. Since this is a separate issue, do you want to send a
> separate patch on this? Or I am happy to do it if you prefer.
> 

I don't know which makes sense so I'll leave that up to you.

> >  
> >  	ret = -EOPNOTSUPP;
> >  	rcu_read_lock();
> > diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> > index 6e70839257f7..4be50a211b14 100644
> > --- a/net/ipv4/ip_output.c
> > +++ b/net/ipv4/ip_output.c
> > @@ -216,7 +216,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
> >  	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
> >  		int res = lwtunnel_xmit(skb);
> >  
> > -		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
> > +		if (res != LWTUNNEL_XMIT_CONTINUE)
> >  			return res;
> 
> Unfortunately we cannot return res directly here when res > 0. This is
> the final reason why I didn't patch here. Return values here can be
> propagated back to sendmsg syscall, so returning a positive value
> would break the syscall convention.

The neigh_output() function is going to return NET_XMIT_DROP so this
already happens.  Is that not what we want to happen?

I guess my concern is that eventually people will eventually new
introduce bugs.  Fixing incorrect error codes is something that I do
several times per week.  :P

regards,
dan carpenter



