Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DA6631CEB
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 10:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKUJf7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 04:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKUJf6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 04:35:58 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD98108D
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 01:35:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n21so27063709ejb.9
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 01:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=IyooFSLHyzBVtDODdJTSmVvlmW1AmledHA60alrj2cU=;
        b=xvxzO7ApTWWEjpNekFxXdD/x7q5Z7RnNvqBX9v2pX+BBXQAT5sDvTa5mo5Sc4prg1c
         JeJJ5TVKqi7Isr30jzH//v/TNEY1eA1YkQ+9KtvMkvTFJ4HKeZj3c+7G/Ujob78/qKu2
         InV4rh/cl6Vd18+KGNrWpJWr9dPeju2XuCZ6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyooFSLHyzBVtDODdJTSmVvlmW1AmledHA60alrj2cU=;
        b=dwsng4FpPun/wfQgqyKrt6Foj6nkJzZChQf+RSa/dKarvukZPQleyNiWyRrfzfs7aG
         3lrVuP/oJmBfVQkirCHeN80VSOaMVCCcb+SewXLkSLykoUZvBM0yEZQcvBpEf/vEn4hK
         VNKW8+oHsRItGdwsz4lJ8OcGTms0Pr+lrnpdi8hhRfv8p+qsE5zHiyQVm1Ibo0Piv/e2
         XJccL9Fv0S1e37BPBB4xfEmFKijx5cXZoSBC8dcfnydD/Bmo0bxWqkdJaLerI+sCyPJ/
         qUcJ4vIFiSnE9coPOc76ZK5FtUBR/PhjE3SaPEwA1pDiOk7hva8KQ27R3+yBa/X00bJU
         ewWA==
X-Gm-Message-State: ANoB5pkt626YEp5lDSXVMPj9wqvgijqAlM8yBJ+69UAjxmuTJiPm6NWr
        OivnONkNUDJTvaC5hqSV9FAqVSCv40d3sg==
X-Google-Smtp-Source: AA0mqf5XZ/fvk4UKrjocbkxMTT0FxICvnHmzqJGXP6tF1+hGsjdnuaJ3JDy9syVNTGG9zJo+VZ04hw==
X-Received: by 2002:a17:906:d797:b0:7ae:37a9:b8f2 with SMTP id pj23-20020a170906d79700b007ae37a9b8f2mr8921800ejb.398.1669023356052;
        Mon, 21 Nov 2022 01:35:56 -0800 (PST)
Received: from cloudflare.com (79.184.204.15.ipv4.supernova.orange.pl. [79.184.204.15])
        by smtp.gmail.com with ESMTPSA id eg51-20020a05640228b300b0045b4b67156fsm5014377edb.45.2022.11.21.01.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 01:35:55 -0800 (PST)
References: <1668598161-15455-1-git-send-email-yangpc@wangsu.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Pengcheng Yang <yangpc@wangsu.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf 0/4] bpf, sockmap: Fix some issues with using
 apply_bytes
Date:   Mon, 21 Nov 2022 10:35:34 +0100
In-reply-to: <1668598161-15455-1-git-send-email-yangpc@wangsu.com>
Message-ID: <87k03o7ipx.fsf@cloudflare.com>
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

On Wed, Nov 16, 2022 at 07:29 PM +08, Pengcheng Yang wrote:
> Patch 0001~0003 fixes three issues with using apply_bytes when redirecting.
> Patch 0004 adds ingress tests for txmsg with apply_bytes in selftests.
>
> Pengcheng Yang (4):
>   bpf, sockmap: Fix repeated calls to sock_put() when msg has more_data
>   bpf, sockmap: Fix missing BPF_F_INGRESS flag when using apply_bytes
>   bpf, sockmap: Fix data loss caused by using apply_bytes on ingress
>     redirect
>   selftests/bpf: Add ingress tests for txmsg with apply_bytes
>
>  include/linux/skmsg.h                      |  1 +
>  net/core/skmsg.c                           |  1 +
>  net/ipv4/tcp_bpf.c                         |  9 +++++++--
>  net/tls/tls_sw.c                           |  1 +
>  tools/testing/selftests/bpf/test_sockmap.c | 18 ++++++++++++++++++
>  5 files changed, 28 insertions(+), 2 deletions(-)

Thanks for the patches. I need a bit more time to review them.
