Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5E5338B1
	for <lists+bpf@lfdr.de>; Wed, 25 May 2022 10:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbiEYIm1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 May 2022 04:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiEYIm0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 May 2022 04:42:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A3E23159
        for <bpf@vger.kernel.org>; Wed, 25 May 2022 01:42:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j28so26056796eda.13
        for <bpf@vger.kernel.org>; Wed, 25 May 2022 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=zZWt0oQg2Tvq/Js+hA7usfjkf6smsQJ+lFHWs54YrWo=;
        b=UtGfEf+1t6+caQP3+I7iCsb0EEOU5uuTX/RXhvcHaZy/PnGzJpKIo4Nmj8IyWsshHy
         EKtAG4f/YdaQTj9yY2MasfIp4br0Pd8mLH7P/aQ9SeXZmuqKfGZqMtPRfn5yKbDThQYJ
         xbnTeprdyaZyZWhGMQl2bnoagILH/D51Wdixk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=zZWt0oQg2Tvq/Js+hA7usfjkf6smsQJ+lFHWs54YrWo=;
        b=pNkQySaXvJJhnclbJB+FoH8k6Fi4ssFZ8UsORtOGx54WmcjKD1dl0KXq977qn5XXfe
         FT88y98aU2V1M8BBHK99cQnh7L259wdfUBgHb2uGp2HmKnpj2yuASSTab5PRJKGL5TmX
         xA9MtZDH0TSpqKeJr7jxOXp925NZrlI++q3lHsPQ20Z5ljJuPZFOPjTfWmKO33wfy1yr
         rJTdSmz2MQaAjgTlqwGTwPylB34zzFCI9gU8cba7KFUc4ea3R2OtFQ2vydv2BQNEh8Jy
         uyh3xSojOhT4eKsaE1l9QzDnBrlXETmKf61EykdMZxBGmSGVBM3L51I24R8N+ZSmDe59
         wE+w==
X-Gm-Message-State: AOAM533iDnYxJKhr644r2K+LzVSYV8SQaZwhUtBtKGWB+D8xNWTMNmdj
        y1zBJQzVAiLzJgPaO7irkO48B2mDzVKi0A==
X-Google-Smtp-Source: ABdhPJwUYl4N0LJ5Wa8GjgYAxPU8FUo34s5PgjcxhmuZkHegpkBTr3mQujP86tlejzofBtLE0WIhsg==
X-Received: by 2002:a05:6402:5289:b0:42b:9c88:e1db with SMTP id en9-20020a056402528900b0042b9c88e1dbmr5208970edb.284.1653468142432;
        Wed, 25 May 2022 01:42:22 -0700 (PDT)
Received: from cloudflare.com (79.184.154.234.ipv4.supernova.orange.pl. [79.184.154.234])
        by smtp.gmail.com with ESMTPSA id ga14-20020a170906b84e00b006feb20b5235sm5246823ejb.84.2022.05.25.01.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 01:42:21 -0700 (PDT)
References: <20220524075311.649153-1-wangyufen@huawei.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     ast@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
        daniel@iogearbox.net, lmb@cloudflare.com, davem@davemloft.net,
        kafai@fb.com, dsahern@kernel.org, kuba@kernel.org,
        songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf,sockmap: fix sk->sk_forward_alloc warn_on
 in sk_stream_kill_queues
Date:   Wed, 25 May 2022 10:41:00 +0200
In-reply-to: <20220524075311.649153-1-wangyufen@huawei.com>
Message-ID: <87czg2m2ab.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 24, 2022 at 03:53 PM +08, Wang Yufen wrote:
> During TCP sockmap redirect pressure test, the following warning is triggered:
> WARNING: CPU: 3 PID: 2145 at net/core/stream.c:205 sk_stream_kill_queues+0xbc/0xd0
> CPU: 3 PID: 2145 Comm: iperf Kdump: loaded Tainted: G        W         5.10.0+ #9
> Call Trace:
>  inet_csk_destroy_sock+0x55/0x110
>  inet_csk_listen_stop+0xbb/0x380
>  tcp_close+0x41b/0x480
>  inet_release+0x42/0x80
>  __sock_release+0x3d/0xa0
>  sock_close+0x11/0x20
>  __fput+0x9d/0x240
>  task_work_run+0x62/0x90
>  exit_to_user_mode_prepare+0x110/0x120
>  syscall_exit_to_user_mode+0x27/0x190
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> The reason we observed is that:
> When the listener is closing, a connection may have completed the three-way
> handshake but not accepted, and the client has sent some packets. The child
> sks in accept queue release by inet_child_forget()->inet_csk_destroy_sock(),
> but psocks of child sks have not released.
>
> To fix, add sock_map_destroy to release psocks.
>
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---

Thanks for the fix.

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
