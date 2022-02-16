Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771104B8ECC
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 18:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbiBPRFQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 12:05:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiBPRFP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 12:05:15 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F423D2A5981
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 09:05:02 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2d66f95f1d1so5848037b3.0
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 09:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2juVayWDeDNiMOSl5byAk4ZO9Dz6MyJWtuklD1EzHsc=;
        b=Me2QFmo170zKETlbtKN8PcGm3z91iWxBm8JFCZl0dLPpr6c2h9bTwnU4y756hvisXL
         5skvfAhbQ2/kJsqmTfAtDcdB2tYVqSahp9S0T1oiUckh4F3vEepLix+KRHxWdi0DNzVj
         HZMXcz4rL+rZujczwWkcbsXz76D1YlZkdz72pxcoMXGmQDrdom3WJgEgrU9Nr/mWLL/t
         o9rHyGG8/Nl40QSN7F+QKxdDpTZdqHqs5LfMY1oZQEfP0oBFZIbX8e1cRux3TIC0SDx7
         iwkZ4dOMenFdBk2po2X52T8QtHb7spTFl/9korrlnMv80YKkorD3O3NDiiQOqGosBOZI
         NQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2juVayWDeDNiMOSl5byAk4ZO9Dz6MyJWtuklD1EzHsc=;
        b=KQrNvHv7/oEhRwrkaoyS9Y8o6b5VmRP5j61ur6xrm2XR7Kva1ohqL6/EBWo+anBixY
         jUxRavbyChRWFtzIVMQuleGKNWhfYeYDmGQI/YxqKeYfB4gU+Pp6+BCGtnYs5GPS1T4p
         QASvDjx9iOa/mummtT/stwvaXe1phIiKn+wkVPvYREfkgxvLdT9/BHvAaDpUV4HCwQpr
         3SREgRuO2zB7HDSuQTG9JrNsgBQUUajovqoGUigtxM91b8nKZpxiQsNob9niP99+3ohL
         19cQeveOHMZ9rZoYAaWTCFtIvVab2JvPuPNhjPiT7vEazmrdpaQKtXneHZvApvGv2MJn
         QAQw==
X-Gm-Message-State: AOAM530HAUnBI+5MgCAJV/NVLmECdepwthpIokYYcCb+sQztB/rCxkaH
        G9xyyvpTNE0ULTHJOdmFbcr+UsKdyr881AECG61u1A==
X-Google-Smtp-Source: ABdhPJzPZKpp/lmdiJbf1hd+uHL0HzVvyEzxKNLXdYq/W8oDUygcnnrBqzIk0QsOwf5SNcKoOsImPBIsfNXO10j6SmM=
X-Received: by 2002:a81:993:0:b0:2d6:15f5:b392 with SMTP id
 141-20020a810993000000b002d615f5b392mr3246691ywj.489.1645031101716; Wed, 16
 Feb 2022 09:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20220216035426.2233808-1-imagedong@tencent.com>
In-Reply-To: <20220216035426.2233808-1-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 16 Feb 2022 09:04:50 -0800
Message-ID: <CANn89i+gBxse3zf2gSvm5AU3D_2MSztGArKQxF4B2rTpWNUSwA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/9] net: add skb drop reasons to TCP packet receive
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        Talal Ahmad <talalahmad@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yajun Deng <yajun.deng@linux.dev>,
        Roopa Prabhu <roopa@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        flyingpeng@tencent.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 15, 2022 at 7:54 PM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> In this series patches, reasons for skb drops are added to TCP layer, and
> both TCPv4 and TCPv6 are considered.
>
> in this series patches, the process of packet ingress in TCP layer is
> considered, as skb drops hardly happens in the egress path.
>
> However, it's a little complex for TCP state processing, as I find that
> it's hard to report skb drop reasons to where it is freed. For example,
> when skb is dropped in tcp_rcv_state_process(), the reason can be caused
> by the call of tcp_v4_conn_request(), and it's hard to return a drop
> reason from tcp_v4_conn_request(). So I just skip such case for this
> moment.
>

I think you should add at least in this cover letter, or better in a
document that can be amended,
how this can be used on a typical TCP session.
For someone who is having issues with TCP flows, what would they need to do.
Think of something that we (kernel dev) could copy paste to future
email replies.
It might be mostly clear for some of us reviewing patches at this
moment, but in one year we will all forget about the details.


>
> Menglong Dong (9):
>   net: tcp: introduce tcp_drop_reason()
>   net: tcp: add skb drop reasons to tcp_v4_rcv()
>   net: tcp: use kfree_skb_reason() for tcp_v6_rcv()
>   net: tcp: add skb drop reasons to tcp_v{4,6}_inbound_md5_hash()
>   net: tcp: add skb drop reasons to tcp_add_backlog()
>   net: tcp: use kfree_skb_reason() for tcp_v{4,6}_do_rcv()
>   net: tcp: use tcp_drop_reason() for tcp_rcv_established()
>   net: tcp: use tcp_drop_reason() for tcp_data_queue()
>   net: tcp: use tcp_drop_reason() for tcp_data_queue_ofo()
>
>  include/linux/skbuff.h     | 28 +++++++++++++++++++++++++
>  include/net/tcp.h          |  3 ++-
>  include/trace/events/skb.h | 10 +++++++++
>  net/ipv4/tcp_input.c       | 42 +++++++++++++++++++++++++++++---------
>  net/ipv4/tcp_ipv4.c        | 36 ++++++++++++++++++++++++--------
>  net/ipv6/tcp_ipv6.c        | 42 +++++++++++++++++++++++++++++---------
>  6 files changed, 131 insertions(+), 30 deletions(-)
>
> --
> 2.34.1
>
