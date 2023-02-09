Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BA1690325
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 10:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjBIJRd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 04:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBIJRc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 04:17:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1FF32E67
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 01:17:30 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bu23so1063479wrb.8
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 01:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GkA9dDFkJRK1uxwCB8bJHoGJ1g05KbOhTCDGjfFBJ98=;
        b=ro5bSSQvYjHn4I52tOW961sMcPFGz8+j9pavImQUmqQxC5h3HKx1B6QI6d2G8DrGoL
         pJE4zxzYB5BZ8ybutuL4h5k7v4cvK2zdnimoWA3vc/kV6oo0+awzvNDeAT6YVZ97DPF5
         /z4Q/JHKn2poCDCn+5C4cDQxNe6E00NFxMToM1ErejFg2BClVQahJ6lhBynfB4nN64SW
         qxqw7xiT5Ro/brcxNnGbWPhJCXxnonUvQSff7R5A0sohbHGZBjGn6EFGKhTTZzwHOYTw
         1xZHukwf/TO530gPduaFdJZSaEDobD2I588lGS1Cc1ydW8nRUd8lXPSNVr9I4sNlLuO/
         Uy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkA9dDFkJRK1uxwCB8bJHoGJ1g05KbOhTCDGjfFBJ98=;
        b=lXgdIyuLAjdvLtbv4W7AsOmKlsQ4ekxcRfahO9tvPDij+oRm9d8CtaRG6ouwGAAdyB
         BNbWg2fGJxzBUhnmtv1yyDcAQHXfJvyMky/1RLiETUzD/KgOasuQSjJ+ESsofLLw7FgL
         cosbr5CEDhqe7si5v7XoKId67LHj5WplqnEK97kO3Hrr+A+/xzt4HfykxB9nEQd9CCOM
         l0EG3StwKZxJZnqwEUajMdWYeZ3CZeIf5EaA6TUpMN+Nrw1Y3uGTZW63Z/u/5zDhsgv0
         REVr8nJwhxn4ZpCDYq6JERydQtXVtbGbCr1+BZjS8hkU1ZJvHVCqodJNDzvT7UIHc/ng
         g27g==
X-Gm-Message-State: AO0yUKWVvXtXLwZFjgEVE2Q4nGfH8m0l+07qHs3BbUcORx9nWlZw6fzJ
        xlGCTLspHtMqYLFn+TFYq8krju3LTHqOSdY9i4LCUA==
X-Google-Smtp-Source: AK7set/tfv3q5nCFc7yV0hQQQjcBphohYA3NE1d4iWbAAD++CTZLw+0q/iwwihvBVOtg70fllS58QJMk7XIYhjoP3kM=
X-Received: by 2002:adf:dcc3:0:b0:2c3:ea92:3491 with SMTP id
 x3-20020adfdcc3000000b002c3ea923491mr316925wrm.477.1675934248985; Thu, 09 Feb
 2023 01:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20230209060642.115752-1-kuba@kernel.org>
In-Reply-To: <20230209060642.115752-1-kuba@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 9 Feb 2023 10:17:17 +0100
Message-ID: <CANn89iK2r54xfcoUT18MXTQ72mR8vVzoUyHLcBx8-7QibtsVCQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skbuff: drop the word head from skb cache
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
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

On Thu, Feb 9, 2023 at 7:06 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> skbuff_head_cache is misnamed (perhaps for historical reasons?)
> because it does not hold heads. Head is the buffer which skb->data
> points to, and also where shinfo lives. struct sk_buff is a metadata
> structure, not the head.
>
> Eric recently added skb_small_head_cache (which allocates actual
> head buffers), let that serve as an excuse to finally clean this up :)
>
> Leave the user-space visible name intact, it could possibly be uAPI.

+1

>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Lets not rename 'struct sk_buff' :)

(Packets are not necessarily tied to a socket)
