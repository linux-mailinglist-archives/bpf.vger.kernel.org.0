Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4505A63C7E9
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 20:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiK2TQI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 14:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiK2TQG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 14:16:06 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4892F663FA
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:16:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m19so19898203edj.8
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=dwsQzcBdlmI4KU3eGwWFX7d4xF2xW2v1ajXtD5reG0o=;
        b=pZ89gKFj5tEtphwmaAp2ST/mZOHsblyS5BwqbMkPSC9QjDNdUz1ZnLjtSsmeqYkqXm
         eMY+jLOYTadXAEIGqadM9VU1gHLMDgMhdszV5tuULC/TejIkPDeB/8tikEmD3dXgtkCo
         uHQkl6DeYIdsEUZoWUe8pQxWUg5m0PVkZJshg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwsQzcBdlmI4KU3eGwWFX7d4xF2xW2v1ajXtD5reG0o=;
        b=NZblxdXCOR05wjCfm+ddCUK0Ma/i2w5Q13Q9gGXMlz1oeYLneVx2bE5JRWyh9gLE2f
         qjV2ksN0+e6gHjspcy3wywSLhwagveHcEuarQiVzLUGokfAkTvnPEadx33yZMqTkXL7/
         DHiPmp1i6i681coIIjCaRx2oNf3+f3wNjRlY8+oIWv2xtxp8fSbDAq8X8XZ8xYlzcpm2
         SY/cAhPwKKXnjd9ELk4mMsZMX2lbqSCrN7ypU176XqbOgrMhrnvjlu8y3PVyZ89CUeDB
         5C6IUGbzlRUU1/oq4Ss9ZrjtgpvQhHH8ZXw09YrBzxIt4Il0Menoc5hyuipLoFiPgNRl
         r9XQ==
X-Gm-Message-State: ANoB5pkgeDKkAdZDDmfu6s+kZUshdWyVspZbtqWf09Jt8xeWzHeV/Lsk
        RgJQyWRVtrVUk0x4MecM4lPdcw==
X-Google-Smtp-Source: AA0mqf57Zfsxv7Yntq1v7DjQpEFTnIFLzUIHYLDtFw9BF/CCjxFSVtFtrF+07RnpP6R3oIy6i7uMPQ==
X-Received: by 2002:aa7:cb09:0:b0:463:ff10:4ff with SMTP id s9-20020aa7cb09000000b00463ff1004ffmr42371180edt.290.1669749362627;
        Tue, 29 Nov 2022 11:16:02 -0800 (PST)
Received: from cloudflare.com (79.184.216.98.ipv4.supernova.orange.pl. [79.184.216.98])
        by smtp.gmail.com with ESMTPSA id gw15-20020a170906f14f00b0073c8d4c9f38sm6479143ejb.177.2022.11.29.11.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:16:02 -0800 (PST)
References: <1669718441-2654-1-git-send-email-yangpc@wangsu.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Pengcheng Yang <yangpc@wangsu.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [PATCH bpf v3 0/4] bpf, sockmap: Fix some issues with using
 apply_bytes
Date:   Tue, 29 Nov 2022 20:14:45 +0100
In-reply-to: <1669718441-2654-1-git-send-email-yangpc@wangsu.com>
Message-ID: <87v8mxa7wv.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 06:40 PM +08, Pengcheng Yang wrote:
> Patch 1~3 fixes three issues with using apply_bytes when redirecting.
> Patch 4 adds ingress tests for txmsg with apply_bytes in selftests.
>
> Thanks to John Fastabend and Jakub Sitnicki for correct solution.
>
> ---
> Changes in v3:
> *Patch 2: Rename 'flags', modify based on Jakub Sitnicki's patch
>
> Changes in v2:
> *Patch 2: Clear psock->flags explicitly before releasing the sock lock
>
> Pengcheng Yang (4):
>   bpf, sockmap: Fix repeated calls to sock_put() when msg has more_data
>   bpf, sockmap: Fix missing BPF_F_INGRESS flag when using apply_bytes
>   bpf, sockmap: Fix data loss caused by using apply_bytes on ingress
>     redirect
>   selftests/bpf: Add ingress tests for txmsg with apply_bytes
>
>  include/linux/skmsg.h                      |  1 +
>  include/net/tcp.h                          |  4 ++--
>  net/core/skmsg.c                           |  9 ++++++---
>  net/ipv4/tcp_bpf.c                         | 19 ++++++++++++-------
>  net/tls/tls_sw.c                           |  6 ++++--
>  tools/testing/selftests/bpf/test_sockmap.c | 18 ++++++++++++++++++
>  6 files changed, 43 insertions(+), 14 deletions(-)

Thanks for the fixes, Pengcheng.

For the series:

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
