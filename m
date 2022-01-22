Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D9F496CD1
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 16:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiAVPog (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Jan 2022 10:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiAVPof (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Jan 2022 10:44:35 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A4C06173B
        for <bpf@vger.kernel.org>; Sat, 22 Jan 2022 07:44:35 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id b37so4826318uad.12
        for <bpf@vger.kernel.org>; Sat, 22 Jan 2022 07:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKHNtClKUhbwQyylwxNg9fvZ9bh5uQ3MmBsM/8No1e0=;
        b=PqJah3TikQXL0fyUcqlI2ZR/83rYihjbck2ib+0DB9QZTgw7d1XUU7pYObrgHPw2DW
         pE4bRtq/4GifzoEcP7VJtzKuVYSLilX0FBPImCI0mah3o5ZKbzWrVcQj+MLAjpXjjYLz
         xqzFrIB5znkp/XLoy12dtpgJDfQNQ5XSaoWHs/2vC5jItuX3jULn9x+zHOBTYoxoEZwG
         TSjTQN2mtdtg+Jp0oghU0QeZHiG3EmHtRNmKQ1Z4fxu/ZcpI2rWlwSDP8gciOiL1E8GO
         q/DppZMf/eLTuJJ+P0jMzO4PMJdIS7v4PNdzBuOg4mcuQUSFeAHBpdO4YJRfRqb9Y+sw
         rW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKHNtClKUhbwQyylwxNg9fvZ9bh5uQ3MmBsM/8No1e0=;
        b=M3EcR+TbLL+iX5mh9sDNOr5hDI9mrrKmAB/nbwoTtHhdXhbDjfSZyzyX83tQO4AExz
         EBKz6BUaUuhuC4o/mZdCAbEMbjsvuD8mVMTvfjj8/XU6K5G2tbKu1D6oILCkvRbtAIxg
         jOsWI5LtB7+1J6kZ/LN8HwixOA4rPxYp7aFWGS+Wv9dsOT0c/x/yiUm/DrHAge9wDe4f
         pB8uWypMiYZI9aEWtWfXvITVl8JhlzW6US7ZlsWpDkkHQgK+Yl9fZWbIwLUCXL0Hot14
         BYVnGhGPKQO7pRyKtvR1j1OD1UBj/L3cOlhmyMR++QWk5Zky+7w1gwep0EPV4W8Fuwsc
         mBjQ==
X-Gm-Message-State: AOAM532wt1fd5MA/F6PT7aKJvRu9RKUXtH5FIOjAhv7W2yXSvxxjEW7a
        ig/JEkPaxi1XGt8mRem+n9UfM5oqpZQ=
X-Google-Smtp-Source: ABdhPJxSvJNRZRDCC65jv+KTP0fQLVrZ9F3Cjg2pD0dqbAY6Fhfp+cfqcz6z+Q7a0GUvi2ovSVDe1Q==
X-Received: by 2002:a05:6130:411:: with SMTP id ba17mr4109617uab.70.1642866274486;
        Sat, 22 Jan 2022 07:44:34 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id v24sm2147955vkn.38.2022.01.22.07.44.33
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jan 2022 07:44:34 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id d189so7431055vkg.3
        for <bpf@vger.kernel.org>; Sat, 22 Jan 2022 07:44:33 -0800 (PST)
X-Received: by 2002:a05:6122:2091:: with SMTP id i17mr94847vkd.2.1642866273648;
 Sat, 22 Jan 2022 07:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20220121073026.4173996-1-kafai@fb.com>
In-Reply-To: <20220121073026.4173996-1-kafai@fb.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 22 Jan 2022 10:43:57 -0500
X-Gmail-Original-Message-ID: <CA+FuTSe83TdzkvYLdfbZDZrW3BGq74_KmmksrCjDKKua7pE1jA@mail.gmail.com>
Message-ID: <CA+FuTSe83TdzkvYLdfbZDZrW3BGq74_KmmksrCjDKKua7pE1jA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 net-next 0/4] Preserve mono delivery time (EDT) in skb->tstamp
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
> egress to a fq@phy-dev.
>
> v3:
> - Feedback from v2 is using shinfo(skb)->tx_flags could be racy.
> - Considered to reuse a few bits in skb->tstamp to represent
>   different semantics, other than more code churns, it will break
>   the bpf usecase which currently can write and then read back
>   the skb->tstamp.
> - Went back to v1 idea on adding a bit to skb and address the
>   feedbacks on v1:
> - Added one bit skb->mono_delivery_time to flag that
>   the skb->tstamp has the mono delivery_time (EDT), instead
>   of adding a bit to flag if the skb->tstamp has been forwarded or not.
> - Instead of resetting the delivery_time back to the (rcv) timestamp
>   during recvmsg syscall which may be too late and not useful,
>   the delivery_time reset in v3 happens earlier once the stack
>   knows that the skb will be delivered locally.
> - Handled the tapping@ingress case by af_packet
> - No need to change the (rcv) timestamp to mono clock base as in v1.
>   The added one bit to flag skb->mono_delivery_time is enough
>   to keep the EDT delivery_time during forward.
> - Added logic to the bpf side to make the existing bpf
>   running at ingress can still get the (rcv) timestamp
>   when reading the __sk_buff->tstamp.  New __sk_buff->mono_delivery_time
>   is also added.  Test is still needed to test this piece.
>
> Martin KaFai Lau (4):
>   net: Add skb->mono_delivery_time to distinguish mono delivery_time
>     from (rcv) timestamp
>   net: Add skb_clear_tstamp() to keep the mono delivery_time
>   net: Set skb->mono_delivery_time and clear it when delivering locally
>   bpf: Add __sk_buff->mono_delivery_time and handle __sk_buff->tstamp
>     based on tc_at_ingress
>
>  drivers/net/loopback.c                     |   2 +-
>  include/linux/filter.h                     |  31 ++++-
>  include/linux/skbuff.h                     |  64 ++++++++--
>  include/uapi/linux/bpf.h                   |   1 +
>  net/bridge/br_forward.c                    |   2 +-
>  net/bridge/netfilter/nf_conntrack_bridge.c |   5 +-
>  net/core/dev.c                             |   4 +-
>  net/core/filter.c                          | 140 +++++++++++++++++++--
>  net/core/skbuff.c                          |   8 +-
>  net/ipv4/ip_forward.c                      |   2 +-
>  net/ipv4/ip_input.c                        |   1 +
>  net/ipv4/ip_output.c                       |   5 +-
>  net/ipv4/tcp_output.c                      |  16 +--
>  net/ipv6/ip6_input.c                       |   1 +
>  net/ipv6/ip6_output.c                      |   7 +-
>  net/ipv6/netfilter.c                       |   5 +-
>  net/netfilter/ipvs/ip_vs_xmit.c            |   6 +-
>  net/netfilter/nf_dup_netdev.c              |   2 +-
>  net/netfilter/nf_flow_table_ip.c           |   4 +-
>  net/netfilter/nft_fwd_netdev.c             |   2 +-
>  net/openvswitch/vport.c                    |   2 +-
>  net/packet/af_packet.c                     |   4 +-
>  net/sched/act_bpf.c                        |   5 +-
>  net/sched/cls_bpf.c                        |   6 +-
>  net/xfrm/xfrm_interface.c                  |   2 +-
>  tools/include/uapi/linux/bpf.h             |   1 +
>  26 files changed, 265 insertions(+), 63 deletions(-)
>
> --

This overall looks great to me.

The only effect on timestamping is slightly delayed receive timestamp
for packets arriving over a virtual loop (loopback, veth, ..)
interface, as the timestamp is now captured at the network protocol
input.

Actually, while writing that: timestamping is a socket level option,
not specific to IP. Might this break receive timestamping over such
interfaces for other protocols?
