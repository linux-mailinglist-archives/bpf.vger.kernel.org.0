Return-Path: <bpf+bounces-5979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A7B763C0A
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 18:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21569281E92
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD9379AA;
	Wed, 26 Jul 2023 16:10:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8AE57F
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 16:10:27 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E96A1BC1
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 09:10:24 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-403a840dc64so49854481cf.1
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690387823; x=1690992623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7viDi95/DtqS7YumhA/QRcfR2/DcATgamUSnc6vM2A=;
        b=sxj07bNcg5678Si4gdEEp+WW40Oh8OI/eqiNU57JICAoq/E0Moh1ql4Pa0rJCD5mXQ
         owdUb7eyP+YcKFu9dUnu4PnUQ1PmNYO06AVBi6/Nq1AJjmy0x9dpbxtZCwdMGx8tDzkR
         u9NWYslhaCMLBzgQIrcdD92wnxlUg+s93/lZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690387823; x=1690992623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7viDi95/DtqS7YumhA/QRcfR2/DcATgamUSnc6vM2A=;
        b=Ao2wySZi5kEl7s98NylMEA6AWkFi60DIZkzEqdpPa0lGuLqrtopTBOgvTt8IjKXsrm
         uiGzgpLBfqKndqVs/sM2zCvm+1XGwLQ9LrWbLViMejV8DOILt5OUJ23DgyMYzUHGHb3x
         ppk8ysMEbGTmlxoDR29EWOZK9UdOlS9QqAsdzFcpEpoJBLup8UA8tD77whTPMSz/3tlf
         WjeUYaG3jTA/ymk0a3bHYJPzM/3XHs+FLltkiLD46Vc/cjty+BRr5nvPABpQ+xN2Km3I
         TxBXOl8QwCS4wyXsvq0sUv4UIT3spfGQoZNuED22DfAgjvDllnx56fwmpJ3lEqIWcP/F
         sFXg==
X-Gm-Message-State: ABy/qLZqdPWOsv5vkmDvQLSclrUZ0EuLMu4WsI2ZsOSL6zyPFMJ0Skq3
	QO9cZYUbjt0KIKnWdXMAWUFo0Q==
X-Google-Smtp-Source: APBJJlFVm/mD0dcIslde2+vo1h0MzL3tM9Znqz5P9eLlBAcDjqJloXRDQy5GwhCsjZ2SScRq8TUP2A==
X-Received: by 2002:ac8:5c02:0:b0:403:a63d:9a2e with SMTP id i2-20020ac85c02000000b00403a63d9a2emr3018341qti.10.1690387823149;
        Wed, 26 Jul 2023 09:10:23 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id fb14-20020a05622a480e00b003f7fd3ce69fsm4902747qtb.59.2023.07.26.09.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:10:22 -0700 (PDT)
Date: Wed, 26 Jul 2023 09:10:20 -0700
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
Message-ID: <ZMFFbChK/66/8XZd@debian.debian>
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
 <a76b300a-e472-4568-b734-37115927621d@moroto.mountain>
 <ZMEqYOOBc1ZNcEER@debian.debian>
 <bc3ec02d-4d4e-477a-b8a5-5245425326c6@kadam.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc3ec02d-4d4e-477a-b8a5-5245425326c6@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 06:01:00PM +0300, Dan Carpenter wrote:
> On Wed, Jul 26, 2023 at 07:14:56AM -0700, Yan Zhai wrote:
> > On Wed, Jul 26, 2023 at 04:39:08PM +0300, Dan Carpenter wrote:
> > > I'm not positive I understand the code in ip_finish_output2().  I think
> > > instead of looking for LWTUNNEL_XMIT_DONE it should instead look for
> > > != LWTUNNEL_XMIT_CONTINUE.  It's unfortunate that NET_XMIT_DROP and
> > > LWTUNNEL_XMIT_CONTINUE are the both 0x1.  Why don't we just change that
> > > instead?
> > > 
> > I considered about changing lwt side logic. But it would bring larger
> > impact since there are multiple types of encaps on this hook, not just
> > bpf redirect. Changing bpf return values is a minimum change on the
> > other hand. In addition, returning value of NET_RX_DROP and
> > NET_XMIT_CN are the same, so if we don't do something in bpf redirect,
> > there is no way to distinguish them later: the former is considered as
> > an error, while "CN" is considered as non-error.
> 
> Uh, NET_RX/XMIT_DROP values are 1.  NET_XMIT_CN is 2.
> 
> I'm not an expert but I think what happens is that we treat NET_XMIT_CN
> as success so that it takes a while for the resend to happen.
> Eventually the TCP layer will detect it as a dropped packet.
> 
My eyes slipped lines. CN is 2. But the fact RX return value can be
returned on a TX path still makes me feel unclean. Odds are low that
we will have new statuses in future, it is a risk. I'd hope to contain
these values only inside BPF redirect code as they are the reason why
such rx values can show up there. Meanwhile, your argument do make
good sense to me that the same problem may occur for other stuff. It
is true. In fact, I just re-examined BPF-REROUTE path, it has the
exact same issue by directly sending dst_output value back.

So I would propose to do two things:
1. still convert BPF redirect ingress code to contain the propagation
of mixed return. Return only TX side value instead, which is also what
majority of those local senders are expecting. (I was wrong about
positive values returned to sendmsg below btw, they are not).

2. change LWTUNNEL_XMIT_CONTINUE and check for this at xmit hook.

> > 
> > > Also there seems to be a leak in lwtunnel_xmit().  Should that return
> > > LWTUNNEL_XMIT_CONTINUE or should it call kfree_skb() before returning?
> > > 
> > > Something like the following?
> > > 
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 11652e464f5d..375790b672bc 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -112,6 +112,9 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev);
> > >  #define NET_XMIT_CN		0x02	/* congestion notification	*/
> > >  #define NET_XMIT_MASK		0x0f	/* qdisc flags in net/sch_generic.h */
> > >  
> > > +#define LWTUNNEL_XMIT_DONE NET_XMIT_SUCCESS
> > > +#define LWTUNNEL_XMIT_CONTINUE 0x3
> > > +
> > >  /* NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
> > >   * indicates that the device will soon be dropping packets, or already drops
> > >   * some packets of the same priority; prompting us to send less aggressively. */
> > > diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
> > > index 6f15e6fa154e..8ab032ee04d0 100644
> > > --- a/include/net/lwtunnel.h
> > > +++ b/include/net/lwtunnel.h
> > > @@ -16,12 +16,6 @@
> > >  #define LWTUNNEL_STATE_INPUT_REDIRECT	BIT(1)
> > >  #define LWTUNNEL_STATE_XMIT_REDIRECT	BIT(2)
> > >  
> > > -enum {
> > > -	LWTUNNEL_XMIT_DONE,
> > > -	LWTUNNEL_XMIT_CONTINUE,
> > > -};
> > > -
> > > -
> > >  struct lwtunnel_state {
> > >  	__u16		type;
> > >  	__u16		flags;
> > > diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
> > > index 711cd3b4347a..732415d1287d 100644
> > > --- a/net/core/lwtunnel.c
> > > +++ b/net/core/lwtunnel.c
> > > @@ -371,7 +371,7 @@ int lwtunnel_xmit(struct sk_buff *skb)
> > >  
> > >  	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
> > >  	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
> > > -		return 0;
> > > +		return LWTUNNEL_XMIT_CONTINUE;
> > 
> > You are correct this path would leak skb. Return continue (or drop)
> > would avoid the leak. Personally I'd prefer drop instead to signal the
> > error setup. Since this is a separate issue, do you want to send a
> > separate patch on this? Or I am happy to do it if you prefer.
> > 
> 
> I don't know which makes sense so I'll leave that up to you.
> 
This conversation is juicy, I think we discovered two potential new
problem sites (the leak here and the reroute path) :)

> > >  
> > >  	ret = -EOPNOTSUPP;
> > >  	rcu_read_lock();
> > > diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> > > index 6e70839257f7..4be50a211b14 100644
> > > --- a/net/ipv4/ip_output.c
> > > +++ b/net/ipv4/ip_output.c
> > > @@ -216,7 +216,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
> > >  	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
> > >  		int res = lwtunnel_xmit(skb);
> > >  
> > > -		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
> > > +		if (res != LWTUNNEL_XMIT_CONTINUE)
> > >  			return res;
> > 
> > Unfortunately we cannot return res directly here when res > 0. This is
> > the final reason why I didn't patch here. Return values here can be
> > propagated back to sendmsg syscall, so returning a positive value
> > would break the syscall convention.
> 
> The neigh_output() function is going to return NET_XMIT_DROP so this
> already happens.  Is that not what we want to happen?
> 
My bad, those return values are processed at ip_send_skb etc, while I
was staring only at ip_local_out and beneath with my sleepy eyes.

> I guess my concern is that eventually people will eventually new
> introduce bugs.  Fixing incorrect error codes is something that I do
> several times per week.  :P
> 
> regards,
> dan carpenter
> 
> 

