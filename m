Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E7B4DC0E0
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 09:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiCQIWP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 04:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiCQIWO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 04:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E78A21C64A3
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 01:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647505258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=apHcZiQ7AQHXjSjCW9qiu7kfylkRV2CxCIqXD/cKZaw=;
        b=GP2HCgy4WdgE8Ay4NxERgHQXRSsw1YoRJinxEdDNVZQMTtpAKljJtE1kxGEzPkJNR8bizv
        W6+n4g47+qSDaVXwQyHckAsk/atZ9LDqZ89dJdZn3q/uuoiantXt6ScEUHtzTnywetJ4iY
        z8u5OjnZfmmxYsrRomJVKjr76roVS2k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-rGNCrSOiOdSBtpgEAKHolg-1; Thu, 17 Mar 2022 04:20:56 -0400
X-MC-Unique: rGNCrSOiOdSBtpgEAKHolg-1
Received: by mail-wm1-f71.google.com with SMTP id l1-20020a1c2501000000b00389c7b9254cso2946912wml.1
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 01:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=apHcZiQ7AQHXjSjCW9qiu7kfylkRV2CxCIqXD/cKZaw=;
        b=ugRTGh0rkDIgzbyPJC2UyBfo8KLMN9B7IwumCzp1fLfVBQTQDxy7S1NzQxFPHd8RQ4
         F3Mqe8XaJwTtE2v3sniCdqZpRbK3Dve4xHcoMM6W6tJHak6dgJ7FXZj/raw2uHUXy0iA
         ZYYUs/Dya/nGkMhi2JjisiqlfqlGJsjUfs7GwxH6gN+TiyK/hu6j1VDwdorAeym6TgND
         Of3aSWKJI/4FB8eTXhhkKb4ZyQw49vqz/aFz+z6ziFwvPxMcrVJCqiI4RWdpAE1/J45b
         jQ+PqD/4T0d8NCaccK7NxX/FDacxHIm6VzdfgqSF1HUps8DmP/7xv5ESs1GXyf4mOjME
         5u0w==
X-Gm-Message-State: AOAM533o2AJTZJLxHPMCzUwZtbVGHqgDqSpVFZfW5hboB7YTldSHlWD0
        G6UQTsU/6DuDRpb14QZOrHhcOX/WqBXJDPqnqPk+JCd1Jlx+91wjXSRDHgdqtJ6fV+33GVsg71t
        bHakxOeIUu3zG
X-Received: by 2002:a5d:40ca:0:b0:203:e037:cd0e with SMTP id b10-20020a5d40ca000000b00203e037cd0emr2892786wrq.534.1647505255557;
        Thu, 17 Mar 2022 01:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJli7t+bcPWrhBXMZKE3sqfMBsKweJ6JoetyKGmaH4oDoKo5yuVcRb0muA7PRorDLM4On6Ug==
X-Received: by 2002:a5d:40ca:0:b0:203:e037:cd0e with SMTP id b10-20020a5d40ca000000b00203e037cd0emr2892760wrq.534.1647505255249;
        Thu, 17 Mar 2022 01:20:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b00387369f380bsm7740776wmq.41.2022.03.17.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 01:20:54 -0700 (PDT)
Message-ID: <7d4b0c51460dec351bbbaf9be85c4a25cb6cec4f.camel@redhat.com>
Subject: Re: [net-next v10 1/2] net: sched: use queue_mapping to pick tx
 queue
From:   Paolo Abeni <pabeni@redhat.com>
To:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Talal Ahmad <talalahmad@google.com>,
        Kevin Hao <haokexin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Date:   Thu, 17 Mar 2022 09:20:53 +0100
In-Reply-To: <CAMDZJNUO9k8xmrJwrXnj+LVG=bEv5Zwe=YkjOqSBrDS348OQfA@mail.gmail.com>
References: <20220314141508.39952-1-xiangxia.m.yue@gmail.com>
         <20220314141508.39952-2-xiangxia.m.yue@gmail.com>
         <015e903a-f4b4-a905-1cd2-11d10aefec8a@iogearbox.net>
         <CAMDZJNUO9k8xmrJwrXnj+LVG=bEv5Zwe=YkjOqSBrDS348OQfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-03-15 at 20:48 +0800, Tonghao Zhang wrote:
> On Tue, Mar 15, 2022 at 5:59 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > 
> > On 3/14/22 3:15 PM, xiangxia.m.yue@gmail.com wrote:
> > [...]
> > >   include/linux/netdevice.h |  3 +++
> > >   include/linux/rtnetlink.h |  1 +
> > >   net/core/dev.c            | 31 +++++++++++++++++++++++++++++--
> > >   net/sched/act_skbedit.c   |  6 +++++-
> > >   4 files changed, 38 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 0d994710b335..f33fb2d6712a 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -3065,6 +3065,9 @@ struct softnet_data {
> > >       struct {
> > >               u16 recursion;
> > >               u8  more;
> > > +#ifdef CONFIG_NET_EGRESS
> > > +             u8  skip_txqueue;
> > > +#endif
> > >       } xmit;
> > >   #ifdef CONFIG_RPS
> > >       /* input_queue_head should be written by cpu owning this struct,
> > > diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> > > index 7f970b16da3a..ae2c6a3cec5d 100644
> > > --- a/include/linux/rtnetlink.h
> > > +++ b/include/linux/rtnetlink.h
> > > @@ -100,6 +100,7 @@ void net_dec_ingress_queue(void);
> > >   #ifdef CONFIG_NET_EGRESS
> > >   void net_inc_egress_queue(void);
> > >   void net_dec_egress_queue(void);
> > > +void netdev_xmit_skip_txqueue(bool skip);
> > >   #endif
> > > 
> > >   void rtnetlink_init(void);
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 75bab5b0dbae..8e83b7099977 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -3908,6 +3908,25 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
> > > 
> > >       return skb;
> > >   }
> > > +
> > > +static struct netdev_queue *
> > > +netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
> > > +{
> > > +     int qm = skb_get_queue_mapping(skb);
> > > +
> > > +     return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
> > > +}
> > > +
> > > +static bool netdev_xmit_txqueue_skipped(void)
> > > +{
> > > +     return __this_cpu_read(softnet_data.xmit.skip_txqueue);
> > > +}
> > > +
> > > +void netdev_xmit_skip_txqueue(bool skip)
> > > +{
> > > +     __this_cpu_write(softnet_data.xmit.skip_txqueue, skip);
> > > +}
> > > +EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
> > >   #endif /* CONFIG_NET_EGRESS */
> > > 
> > >   #ifdef CONFIG_XPS
> > > @@ -4078,7 +4097,7 @@ struct netdev_queue *netdev_core_pick_tx(struct net_device *dev,
> > >   static int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> > >   {
> > >       struct net_device *dev = skb->dev;
> > > -     struct netdev_queue *txq;
> > > +     struct netdev_queue *txq = NULL;
> > >       struct Qdisc *q;
> > >       int rc = -ENOMEM;
> > >       bool again = false;
> > > @@ -4106,11 +4125,17 @@ static int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> > >                       if (!skb)
> > >                               goto out;
> > >               }
> > > +
> > > +             netdev_xmit_skip_txqueue(false);
> > > +
> > >               nf_skip_egress(skb, true);
> > >               skb = sch_handle_egress(skb, &rc, dev);
> > >               if (!skb)
> > >                       goto out;
> > >               nf_skip_egress(skb, false);
> > > +
> > > +             if (netdev_xmit_txqueue_skipped())
> > > +                     txq = netdev_tx_queue_mapping(dev, skb);
> > >       }
> > >   #endif
> > >       /* If device/qdisc don't need skb->dst, release it right now while
> > > @@ -4121,7 +4146,9 @@ static int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> > >       else
> > >               skb_dst_force(skb);
> > > 
> > > -     txq = netdev_core_pick_tx(dev, skb, sb_dev);
> > > +     if (likely(!txq))
> > 
> > nit: Drop likely(). If the feature is used from sch_handle_egress(), then this would always be the case.
> Hi Daniel
> I think in most case, we don't use skbedit queue_mapping in the
> sch_handle_egress() , so I add likely in fast path.
> > > +             txq = netdev_core_pick_tx(dev, skb, sb_dev);
> > > +
> > >       q = rcu_dereference_bh(txq->qdisc);
> > 
> > How will the `netdev_xmit_skip_txqueue(true)` be usable from BPF side (see bpf_convert_ctx_access() ->
> > queue_mapping)?
> Good questions, In other patch, I introduce the
> bpf_netdev_skip_txqueue, so we can use netdev_xmit_skip_txqueue in bpf
> side

@Daniel: are you ok with the above explaination?

Thanks!

Paolo

