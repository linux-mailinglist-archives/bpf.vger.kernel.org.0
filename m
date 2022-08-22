Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6838259C9FB
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 22:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiHVU3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 16:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbiHVU3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 16:29:36 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BF351A12
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 13:29:35 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-33387bf0c4aso325837607b3.11
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3ghqxlUVpYAPvNZ/Fd381BfRXG/4offmxhbYt9HADrc=;
        b=s47Dap0xMD0o0a7vVi9aMnbkj5ze1IHKpyOsoauBFgvtF0z8zE1Gq6jXk0ySkQ8li6
         tQXecAxQMOGmHlrmGoA8gNudrsQE9/klv6tpAeDw+uN9buGwppEP7D1BOAJL8sOU1WWs
         ChlWSnE00t7Pe2mRhadRJ7oaLER0hFNVmWZd+dVB9mUNzaHHOG9t6aMrWevepzsdim+q
         vdpEwlujfgeQImmGBidsNDOHp9CHmgAaKrBsqq/CrCjJXo4YkrR9RGaKZvvlmFq+nyCg
         BZORUkg1qYa8r4dbhqAZg/jv0iZz/B8dKdULef7T9H/mmpYaildEgimt3zXTw7rfCKoN
         MhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3ghqxlUVpYAPvNZ/Fd381BfRXG/4offmxhbYt9HADrc=;
        b=Ci6yPy76wl96FS0ko1gmpG8SmeukiiVByyGK0f/mamjtOEpwMws3yV4lEZZQQeglc8
         xO1cMHdzyXdlr6uzYuNqHetBvR5jvhtHzl8QugttqiYiiYLKAjm2dwkqGqFfJjYrXtpS
         dHE3NmDhxAf7F2racOxMKJIU6E35mVCo4wqLD2LYisM5dnUZ5dV2Zqgmzjmw54aYBhNs
         3lm5To+Q04phobdfgeVHRDipLjYGXEtnS2Sm19cua+gEdByO7utsTygMfP/12KCYKt+h
         XTGipHe1AWA7oijwt8+XfHlI90tVhvx6vpXgXQWOVn5sXBhqhkuYA8//QKUUQOMWVRCD
         NRzA==
X-Gm-Message-State: ACgBeo0gV8tzaIla69u5XJ3kJK44ZTdnxaRJw35Fur7HyPoAf1s+IH8B
        5NPz/HpnRZ5mYQGDY5fl6AEioiLj8QFVKFSX9vxkUg==
X-Google-Smtp-Source: AA6agR5M/3KtnGznrm02DeFRvjK+3D9/NBjPkCtgRvg6VLE0oHYqb9h6gxSAs4N48Rq27P88TkmF8eeFYBdb9b3f6PM=
X-Received: by 2002:a25:b083:0:b0:695:9a91:317d with SMTP id
 f3-20020a25b083000000b006959a91317dmr7417640ybj.387.1661200174730; Mon, 22
 Aug 2022 13:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220822103130.3466-1-sunshouxin@chinatelecom.cn>
In-Reply-To: <20220822103130.3466-1-sunshouxin@chinatelecom.cn>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 22 Aug 2022 13:29:23 -0700
Message-ID: <CANn89i+MPc6bJe_nfyrksgYipY0Mqeey=05Ctj8B4S_j5bYOvA@mail.gmail.com>
Subject: Re: [PATCH] bonding: Remove unnecessary check
To:     Sun Shouxin <sunshouxin@chinatelecom.cn>
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        huyd12@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 22, 2022 at 3:33 AM Sun Shouxin <sunshouxin@chinatelecom.cn> wrote:
>
> This check is not necessary since the commit d5410ac7b0ba
> ("net:bonding:support balance-alb interface with vlan to bridge").

Please provide more details. I fail to see the relation between d5410ac7b0ba
and this patch, thanks.

>
> Suggested-by: Hu Yadi <huyd12@chinatelecom.cn>
> Signed-off-by: Sun Shouxin <sunshouxin@chinatelecom.cn>
> ---
>  drivers/net/bonding/bond_main.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 50e60843020c..6b0f0ce9b9a1 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1578,19 +1578,6 @@ static rx_handler_result_t bond_handle_frame(struct sk_buff **pskb)
>
>         skb->dev = bond->dev;
>
> -       if (BOND_MODE(bond) == BOND_MODE_ALB &&
> -           netif_is_bridge_port(bond->dev) &&
> -           skb->pkt_type == PACKET_HOST) {
> -
> -               if (unlikely(skb_cow_head(skb,
> -                                         skb->data - skb_mac_header(skb)))) {
> -                       kfree_skb(skb);
> -                       return RX_HANDLER_CONSUMED;
> -               }
> -               bond_hw_addr_copy(eth_hdr(skb)->h_dest, bond->dev->dev_addr,
> -                                 bond->dev->addr_len);
> -       }
> -
>         return ret;
>  }
>
> --
> 2.27.0
>
