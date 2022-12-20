Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15766517F8
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 02:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiLTBXp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 20:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiLTBWT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 20:22:19 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4013713F0E
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 17:21:40 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id k79so7508177pfd.7
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 17:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h8Zl3OLJvmj+VW1Nm9v7BDlSntkj5cpurC3AlErukc4=;
        b=Zy0YMXr7CEHnnetLQf1CPx67LtkIWMv7seOF/pTnYGnI4Ttq+fDdrZdm/YWNbVakTw
         PfIWEQrrLJEs6erJTL80SvRkyUawc97Z6ZhJAn9p1xP21PpuVVNoOlsZMCyiEOX2XvyS
         aih7f9HYiSeFM1+1IggYsZoF++MsOq6/zNpmVXaWXZZDpcsa1BisYmxykQNtsYm0Fjss
         1fg/Zi5shAuZRSV2sTcZjovYWXNLw9OpgZd9y7HA2On4sTeH7zDBny7wwAkwMmiSEnWB
         wYasoCq2f4+fL/zfk07OVdw+mKsglfLF5bJAv1iTxgHUHtIFzNyg/g4fl6Fv7yHb5RET
         PKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8Zl3OLJvmj+VW1Nm9v7BDlSntkj5cpurC3AlErukc4=;
        b=ir/7BRfHC/Sa30wvheM1/HKxTpxAbHZckseUGM/arXTOLsXBasLYHd56hMvBO+tPtH
         f/Sy72WM7JB18NkpeOVZWjh5pDK0TVRuR8dvjbvSppb84/PgmjQzF2hRa+rqSUswQDm2
         QM79QD4n6lv5nT2Zt9oMmuFQp8jWyk4p8KjX3G1KIXnWOwxvLafU+anQhmRQjgC6LJpx
         zYlj1/MPvdnypHwmhHykQnLLLUQyhqEIohSnM3MA+IgXJwAzlfDhKBIGDhOUPd+8Hg48
         5JoykwirKb2nN0XhoAKk1pG7rS/KvYB6SSASMH0Jc5uCqiYvTmvyjZ00sSAM/l0EqpqP
         I7tQ==
X-Gm-Message-State: ANoB5pnp1GjUJBEtzeSd/8/PJI8UvkAeunTge/49OTqScrLmbRl7X1wv
        qFHkrmWXCjTkABUXorDqfiuKo524Ofa9zX2BwPFiYQ==
X-Google-Smtp-Source: AA0mqf59zxigJnrnk593w8QlMqgZuyWE4somP5HkxcRMcS43wi6NdcUh5LFI7QtfQAjYIp8QtK5eqCgqPTc6n1G6/vs=
X-Received: by 2002:aa7:9006:0:b0:578:8d57:12ce with SMTP id
 m6-20020aa79006000000b005788d5712cemr1938999pfo.42.1671499299407; Mon, 19 Dec
 2022 17:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20221220004701.402165-1-kuba@kernel.org>
In-Reply-To: <20221220004701.402165-1-kuba@kernel.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 19 Dec 2022 17:21:27 -0800
Message-ID: <CAKH8qBvVTHXsgVLHuCmdFM1dnYEiDFovOFfXNq1=8igPCCO7jQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: pull before calling skb_postpull_rcsum()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        Anand Parthasarathy <anpartha@meta.com>, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com
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

On Mon, Dec 19, 2022 at 4:47 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Anand hit a BUG() when pulling off headers on egress to a SW tunnel.
> We get to skb_checksum_help() with an invalid checksum offset
> (commit d7ea0d9df2a6 ("net: remove two BUG() from skb_checksum_help()")
> converted those BUGs to WARN_ONs()).
> He points out oddness in how skb_postpull_rcsum() gets used.
> Indeed looks like we should pull before "postpull", otherwise
> the CHECKSUM_PARTIAL fixup from skb_postpull_rcsum() will not
> be able to do its job:
>
>         if (skb->ip_summed == CHECKSUM_PARTIAL &&
>             skb_checksum_start_offset(skb) < 0)
>                 skb->ip_summed = CHECKSUM_NONE;
>
> Reported-by: Anand Parthasarathy <anpartha@meta.com>
> Fixes: 6578171a7ff0 ("bpf: add bpf_skb_change_proto helper")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: daniel@iogearbox.net
> CC: martin.lau@linux.dev
> CC: song@kernel.org
> CC: john.fastabend@gmail.com
> CC: sdf@google.com
> CC: bpf@vger.kernel.org
> ---
>  net/core/filter.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 929358677183..43cc1fe58a2c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3180,15 +3180,18 @@ static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
>
>  static int bpf_skb_generic_pop(struct sk_buff *skb, u32 off, u32 len)
>  {
> +       void *old_data;
> +
>         /* skb_ensure_writable() is not needed here, as we're
>          * already working on an uncloned skb.
>          */
>         if (unlikely(!pskb_may_pull(skb, off + len)))
>                 return -ENOMEM;
>
> -       skb_postpull_rcsum(skb, skb->data + off, len);
> -       memmove(skb->data + len, skb->data, off);
> +       old_data = skb->data;
>         __skb_pull(skb, len);

[..]

> +       skb_postpull_rcsum(skb, old_data + off, len);

Are you sure about the 'old_data + off' part here (for
CHECKSUM_COMPLETE)? Shouldn't it be old_data?
I'm assuming we need to negate the old parts that we've pulled?

Maybe safer/more correct to do the following?

skb_pull_rcsum(skb, off);
memmove(skb->data, skb->data-off, off);


> +       memmove(skb->data, old_data, off);
>
>         return 0;
>  }
> --
> 2.38.1
>
