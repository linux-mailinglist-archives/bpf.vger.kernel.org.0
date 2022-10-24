Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5151960B5BD
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 20:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJXSjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 14:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiJXSie (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 14:38:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26199A4842
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 10:20:51 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b185so3313990pfb.9
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nFqzug1qReCclcy0s2v1uqC0j6meegqqyIjhsE40A7s=;
        b=ZM9VL9oBJQY3ue5EoOdP7pStNO4OS9trjbA7+Gr3oVwhSX5RnBFNay9q0PYxpPZia+
         FrDYBWrsXf/EcL1v3MFT0HTatciZwhAccnnYdL+9EhPCe+LvWHMMvGe2jpmwauJey52U
         u9iW3HU5HfmbNIkUOSjmbBZT8fSmIKhrjLpR8TR9rzmTEEZvrb+LBAJl53twhau16STc
         pAx4UsYE2hwzWcH0uA/aVWoozRHs1lkSscdYBAB4AWmHm1RL8hNkvuQLxmUgxHeGJ5m1
         9On6K14XcT8hXwbKmDT/IfVvh2Px3j2yucC2pxWprSCdKTy+BRQzv4eAYvDvvtE6X5Xo
         dnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFqzug1qReCclcy0s2v1uqC0j6meegqqyIjhsE40A7s=;
        b=P7NwrIpnKTgq+TFQZLEmI6AqiFxEx6tbHGyfwh3HwCglORfByk7W7M1CNkSXzZ9ZRa
         BSF/eXTF/IaYssNX6+Q/A2snK1pMALWMu2huoGVP+4C8n7dAPlbyeVAvWI37skDGbKZH
         K3ty9ZdmqV+41F2rypmaLS8/zkE6TDA8d87+OZIunBSUSWNbtCowcZCTlo8L1TS+9P3U
         /FFiz5mhIYOcz/6H4YrvPOjEViBTQn2r1az1/PfLMfOCLupK7hVrw+6kFDPaclgpZ16C
         4SI6QSHZcQE4r+49TQLdORevO4NRsGsawtWyrmFrrXEjPc35WC0VguzS0YkT57tdJHW7
         O5NQ==
X-Gm-Message-State: ACrzQf2gOO1U14o9sJz3PQtZxwyWzN7YdC5QBSsLtfM1Yx3W49QTD2p5
        gxCHBT8ojg6eYSuVFdXUTHKfPsOPxOTiG/ZSgJa+H/oSgS/ojA==
X-Google-Smtp-Source: AMsMyM4tB3XO187E0WrH4615JwFsPW8ME4WSWZ95UANtQAx3FtJD1/Li+L5nYbN04yyBJVlpyDIKcuGDeRK9hv0cZIY=
X-Received: by 2002:a05:6e02:1bc4:b0:2fc:2d47:9abf with SMTP id
 x4-20020a056e021bc400b002fc2d479abfmr21104378ilv.246.1666630446909; Mon, 24
 Oct 2022 09:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221021084058.223823-1-shaozhengchao@huawei.com> <20221022001308.17778-1-kuniyu@amazon.com>
In-Reply-To: <20221022001308.17778-1-kuniyu@amazon.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 24 Oct 2022 09:53:55 -0700
Message-ID: <CAKH8qBtypd=h_+CuzUX3Uy6-fyWWcs8Xt-eFYM2e0H3yZUtUNw@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: fq_codel: fix null-ptr-deref issue in fq_codel_enqueue()
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     shaozhengchao@huawei.com, davem@davemloft.net, edumazet@google.com,
        jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, weiyongjun1@huawei.com,
        xiyou.wangcong@gmail.com, yuehaibing@huawei.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 5:13 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> +Stanislav, bpf
>
> From:   Zhengchao Shao <shaozhengchao@huawei.com>
> Date:   Fri, 21 Oct 2022 16:40:58 +0800
> > As [0] see, it will cause null-ptr-deref issue.
> > The following is the process of triggering the problem:
> > fq_codel_enqueue()
> >       ...
> >       idx = fq_codel_classify()        --->if idx != 0
> >       flow = &q->flows[idx];
> >       flow_queue_add(flow, skb);       --->add skb to flow[idex]
> >       q->backlogs[idx] += qdisc_pkt_len(skb); --->backlogs = 0
> >       ...
> >       fq_codel_drop()          --->set sch->limit = 0, always
> >                                    drop packets
> >               ...
> >               idx = i          --->because backlogs in every
> >                                    flows is 0, so idx = 0
> >               ...
> >               flow = &q->flows[idx];   --->get idx=0 flow
> >               ...
> >               dequeue_head()
> >                       skb = flow->head; --->flow->head = NULL
> >                       flow->head = skb->next; --->cause null-ptr-deref
> >
> > So, only need to discard the packets whose len is 0 on dropping path of
> > enqueue. Then, the correct flow id can be obtained by fq_codel_drop() on
> > next enqueuing.
> >
> > [0]: https://syzkaller.appspot.com/bug?id=0b84da80c2917757915afa89f7738a9d16ec96c5
>
> This can be caused by BPF, but there seems to be no consensus yet.
> https://lore.kernel.org/netdev/CAKH8qBsOMxVaemF0Oy=vE1V0vKO8ORUcVGB5YANS3HdKOhVjjw@mail.gmail.com/
>
> """
> I think the consensus here is that the stack, in general, doesn't
> expect the packets like this. So there are probably more broken things
> besides fq_codel. Thus, it's better if we remove the ability to
> generate them from the bpf side instead of fixing the individual users
> like fq_codel.
> """

That shouldn't happen after commit fd1894224407 ("bpf: Don't redirect
packets with invalid pkt_len"), so not sure why this patch is needed
at all?

> > Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
> > Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> > ---
> >  net/sched/sch_fq_codel.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> > index 99d318b60568..3bbe7f69dfb5 100644
> > --- a/net/sched/sch_fq_codel.c
> > +++ b/net/sched/sch_fq_codel.c
> > @@ -187,6 +187,7 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> >       struct fq_codel_sched_data *q = qdisc_priv(sch);
> >       unsigned int idx, prev_backlog, prev_qlen;
> >       struct fq_codel_flow *flow;
> > +     struct sk_buff *drop_skb;
>
> We can move this into the if-block below or remove.
>
>
> >       int ret;
> >       unsigned int pkt_len;
> >       bool memory_limited;
> > @@ -222,6 +223,13 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> >
> >       /* save this packet length as it might be dropped by fq_codel_drop() */
> >       pkt_len = qdisc_pkt_len(skb);
> > +
> > +     /* drop skb if len = 0, so fq_codel_drop could get the right flow idx*/
> > +     if (unlikely(!pkt_len)) {
> > +             drop_skb = dequeue_head(flow);
> > +             __qdisc_drop(drop_skb, to_free);
>
> just            __qdisc_drop(dequeue_head(flow), to_free);
>
>
> > +             return NET_XMIT_SUCCESS;
> > +     }
> >       /* fq_codel_drop() is quite expensive, as it performs a linear search
> >        * in q->backlogs[] to find a fat flow.
> >        * So instead of dropping a single packet, drop half of its backlog
> > --
> > 2.17.1
>
