Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72D8496CCF
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 16:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiAVPc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Jan 2022 10:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiAVPcz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Jan 2022 10:32:55 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA676C06173B
        for <bpf@vger.kernel.org>; Sat, 22 Jan 2022 07:32:54 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id y4so22553046uad.1
        for <bpf@vger.kernel.org>; Sat, 22 Jan 2022 07:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ajnk2pCYaAWt4fTLFRp3nCyf05VftFBuQlso4UaDqqE=;
        b=JCyFtgGvycs1DyFhg7br3ZC3L1xcjPIWn85d03PVcZafZCuEue4zKXkCaCpZpnftt4
         fV7wyca8TsAbglx6VuPBV2cZgbheepCx2eLHc6vqwiko4GwjLafaWhK9ly6V3PF+Dphy
         oRMwGus+xFlbY+cA3f25N4hkYCy6MfpO60vPJ4fllle3dAvdZsqtGCY176ddSMbVAbkK
         3uVd3Oz0Z7bS2f2ONSD1UxUvKZVEHBSyNby/MtCqAJJHx/APyToe3+Y8b8adqeZT8Yub
         YbE93GbMD9sVZuyeBIrt8tB8wJhd0E89xDHFTwU3pc9YsVr5gnZX5WxO/Q/2WJHtBo8u
         FiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ajnk2pCYaAWt4fTLFRp3nCyf05VftFBuQlso4UaDqqE=;
        b=Q37oA6gEchsQKpWkMtnRK3Hh6w7SFAE7rV/nL5wnOueTOcUJ/5y79sKt8XfJbOiQb/
         2DJ+sbe3ACLpUpydfwaCcohOgHay1nhWiW8goo7n1SqbuNi9fNrDjNhvbBiiLpd3XoLc
         +PSj5e9EOcnQQT0jE35sWte1IYueCG7oPq7kOf5/XzWOlt+ybDipYBSQQHMegnikwX+x
         SJTgcreWy1FmOz/jwnCtnXOE9vXq2mtJZRadThp0sXJ9l9JONEMcqvrItU2/4BhcnE8P
         ToJ35ncL89J0w3TRZUOROEhloJ0iekdzpysxHqVW/641+C4rZnOpyPu0/svb69Gcq8tT
         HGXA==
X-Gm-Message-State: AOAM531/8LeR87ZRzUNkCuQ66hcoZoF7O3LvMOvSU5dkzCOS/ubRzz4F
        GJgQ8QCZS/REA/kf2GV/Bsfuck1d+rE=
X-Google-Smtp-Source: ABdhPJxcvx3NRYOiwltzSdCCeBXzDamm+2MWrFnpjExuM0Eg2VPwG4pGUBNomRM+paob4qJ2XroU6g==
X-Received: by 2002:a05:6102:3581:: with SMTP id h1mr3503469vsu.5.1642865573750;
        Sat, 22 Jan 2022 07:32:53 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id p2sm2378935uao.1.2022.01.22.07.32.52
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jan 2022 07:32:52 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id v192so7395884vkv.4
        for <bpf@vger.kernel.org>; Sat, 22 Jan 2022 07:32:52 -0800 (PST)
X-Received: by 2002:ac5:cda4:: with SMTP id l4mr3577855vka.10.1642865572000;
 Sat, 22 Jan 2022 07:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20220121073026.4173996-1-kafai@fb.com> <20220121073032.4176877-1-kafai@fb.com>
In-Reply-To: <20220121073032.4176877-1-kafai@fb.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 22 Jan 2022 10:32:16 -0500
X-Gmail-Original-Message-ID: <CA+FuTSe1d91JC_bQvFGdoAaAEG4fur6KfzkNheA-ymnnMharXQ@mail.gmail.com>
Message-ID: <CA+FuTSe1d91JC_bQvFGdoAaAEG4fur6KfzkNheA-ymnnMharXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 net-next 1/4] net: Add skb->mono_delivery_time to
 distinguish mono delivery_time from (rcv) timestamp
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 2:30 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> skb->tstamp was first used as the (rcv) timestamp in real time clock base.
> The major usage is to report it to the user (e.g. SO_TIMESTAMP).
>
> Later, skb->tstamp is also set as the (future) delivery_time (e.g. EDT in TCP)
> during egress and used by the qdisc (e.g. sch_fq) to make decision on when
> the skb can be passed to the dev.
>
> Currently, there is no way to tell skb->tstamp having the (rcv) timestamp
> or the delivery_time, so it is always reset to 0 whenever forwarded
> between egress and ingress.
>
> While it makes sense to always clear the (rcv) timestamp in skb->tstamp
> to avoid confusing sch_fq that expects the delivery_time, it is a
> performance issue [0] to clear the delivery_time if the skb finally
> egress to a fq@phy-dev.  For example, when forwarding from egress to
> ingress and then finally back to egress:
>
>             tcp-sender => veth@netns => veth@hostns => fq@eth0@hostns
>                                      ^              ^
>                                      reset          rest
>
> [0] (slide 22): https://linuxplumbersconf.org/event/11/contributions/953/attachments/867/1658/LPC_2021_BPF_Datapath_Extensions.pdf
>
> This patch adds one bit skb->mono_delivery_time to flag the skb->tstamp
> is storing the mono delivery_time instead of the (rcv) timestamp.
>
> The current use case is to keep the TCP mono delivery_time (EDT) and
> to be used with sch_fq.  The later patch will also allow tc-bpf to read
> and change the mono delivery_time.
>
> In the future, another bit (e.g. skb->user_delivery_time) can be added
> for the SCM_TXTIME where the clock base is tracked by sk->sk_clockid.
>
> [ This patch is a prep work.  The following patch will
>   get the other parts of the stack ready first.  Then another patch
>   after that will finally set the skb->mono_delivery_time. ]
>
> skb_set_delivery_time() function is added.  It is used by the tcp_output.c
> and during ip[6] fragmentation to assign the delivery_time to
> the skb->tstamp and also set the skb->mono_delivery_time.
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  include/linux/skbuff.h                     | 13 +++++++++++++
>  net/bridge/netfilter/nf_conntrack_bridge.c |  5 +++--
>  net/ipv4/ip_output.c                       |  5 +++--
>  net/ipv4/tcp_output.c                      | 16 +++++++++-------
>  net/ipv6/ip6_output.c                      |  5 +++--
>  net/ipv6/netfilter.c                       |  5 +++--
>  6 files changed, 34 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bf11e1fbd69b..b9e20187242a 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -720,6 +720,10 @@ typedef unsigned char *sk_buff_data_t;
>   *     @dst_pending_confirm: need to confirm neighbour
>   *     @decrypted: Decrypted SKB
>   *     @slow_gro: state present at GRO time, slower prepare step required
> + *     @mono_delivery_time: When set, skb->tstamap has the

tstamp

> + *             delivery_time in mono clock base (i.e. EDT).  Otherwise, the
> + *             skb->tstamp has the (rcv) timestamp at ingress and
> + *             delivery_time at egress.
>   *     @napi_id: id of the NAPI struct this skb came from
>   *     @sender_cpu: (aka @napi_id) source CPU in XPS
>   *     @secmark: security marking
> @@ -890,6 +894,7 @@ struct sk_buff {
>         __u8                    decrypted:1;
>  #endif
>         __u8                    slow_gro:1;
> +       __u8                    mono_delivery_time:1;

This bit fills a hole, does not change sk_buff size, right?

>
>  #ifdef CONFIG_NET_SCHED
>         __u16                   tc_index;       /* traffic control index */
> @@ -3903,6 +3908,14 @@ static inline ktime_t net_invalid_timestamp(void)
>         return 0;
>  }
>
> +static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
> +                                        bool mono)
> +{
> +       skb->tstamp = kt;
> +       /* Setting mono_delivery_time will be enabled later */
> +       /* skb->mono_delivery_time = kt && mono; */
> +}
> +
>  static inline u8 skb_metadata_len(const struct sk_buff *skb)
>  {
>         return skb_shinfo(skb)->meta_len;
> diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
> index fdbed3158555..ebfb2a5c59e4 100644
> --- a/net/bridge/netfilter/nf_conntrack_bridge.c
> +++ b/net/bridge/netfilter/nf_conntrack_bridge.c
> @@ -32,6 +32,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
>                                            struct sk_buff *))
>  {
>         int frag_max_size = BR_INPUT_SKB_CB(skb)->frag_max_size;
> +       bool mono_delivery_time = skb->mono_delivery_time;

This use of a local variable is just a style choice, not needed for
correctness, correct?
