Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46579617CCA
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 13:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKCMj1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 08:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKCMjF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 08:39:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4707210B2
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 05:38:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x2so2804872edd.2
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 05:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=2VY7sFA4LK0fSpDvLUr8PlNvYnUkzd8VOGwY5TsOs4g=;
        b=RK4j9eEBaoOfPvdQtUYIK4NQ683/DcFToP4KLqXWTZxtuhcJ6HC4tmP51FN6l/wbnJ
         G3C+n+E7ElXJ/M/smxjuvB4TXypnNUOj2HaRNkFho92zYaybKjhoTwXCjaZmcXnk3oks
         YulFL2fDyPX5vBsJzjDqdvp6iiBcmXpgj1uCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VY7sFA4LK0fSpDvLUr8PlNvYnUkzd8VOGwY5TsOs4g=;
        b=KkJkyBKUTdSbXlD95DZ7kcxX7inyLrDDsRYQS+IBk6Vupjye5ZdvksHR57tIhVOZoY
         +OaMCnZrfChbWfzZfojG97kjkJXACoAWrGd7mLHBHcjEONeocJl8L+6iMFIT+I67WBp6
         izeo1D3quVDzAJQusVp00bOWr06zf7pd3U+lGc7TutE0rXOM0CVxMT+MrDa0jwHxwr+R
         fJZu4fjc0HS+VUM1c3enGoHCZ0Q23RgcyPzVdvo+6hv4bscnqSCa1b22PfkPUHq7cm9l
         z1tiKZpAW5vpuEI6Y3Zmcs6mfvCIBK9qEGjnGogpNivev5z8bP+p5irbQODSsNuQJDqN
         zhCg==
X-Gm-Message-State: ACrzQf3itPHA6gmS+clYdzuQSenpG78TKYc3h/d7xg2wjA/jEl1KxFA5
        koHqr4cH7wPWiLdNchaZMWrBsQ==
X-Google-Smtp-Source: AMsMyM4uePu0vqDFZG1pG+eQ5qDjD2TClEJQZRPczZKit6N+gXLNU7Bt6QVhWCRRUR0ICvhav7RUuQ==
X-Received: by 2002:aa7:d996:0:b0:461:88b8:c581 with SMTP id u22-20020aa7d996000000b0046188b8c581mr29963174eds.111.1667479107738;
        Thu, 03 Nov 2022 05:38:27 -0700 (PDT)
Received: from cloudflare.com (79.191.56.44.ipv4.supernova.orange.pl. [79.191.56.44])
        by smtp.gmail.com with ESMTPSA id x26-20020aa7d39a000000b00463c475684csm458979edq.73.2022.11.03.05.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:38:27 -0700 (PDT)
References: <20221102043417.279409-1-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>,
        Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [Patch bpf v2] sock_map: move cancel_work_sync() out of sock lock
Date:   Thu, 03 Nov 2022 13:37:36 +0100
In-reply-to: <20221102043417.279409-1-xiyou.wangcong@gmail.com>
Message-ID: <87eduk43i5.fsf@cloudflare.com>
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

On Tue, Nov 01, 2022 at 09:34 PM -07, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> Stanislav reported a lockdep warning, which is caused by the
> cancel_work_sync() called inside sock_map_close(), as analyzed
> below by Jakub:
>
> psock->work.func = sk_psock_backlog()
>   ACQUIRE psock->work_mutex
>     sk_psock_handle_skb()
>       skb_send_sock()
>         __skb_send_sock()
>           sendpage_unlocked()
>             kernel_sendpage()
>               sock->ops->sendpage = inet_sendpage()
>                 sk->sk_prot->sendpage = tcp_sendpage()
>                   ACQUIRE sk->sk_lock
>                     tcp_sendpage_locked()
>                   RELEASE sk->sk_lock
>   RELEASE psock->work_mutex
>
> sock_map_close()
>   ACQUIRE sk->sk_lock
>   sk_psock_stop()
>     sk_psock_clear_state(psock, SK_PSOCK_TX_ENABLED)
>     cancel_work_sync()
>       __cancel_work_timer()
>         __flush_work()
>           // wait for psock->work to finish
>   RELEASE sk->sk_lock
>
> We can move the cancel_work_sync() out of the sock lock protection,
> but still before saved_close() was called.
>
> Fixes: 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()")
> Reported-by: Stanislav Fomichev <sdf@google.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

[...]

Thanks!

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
