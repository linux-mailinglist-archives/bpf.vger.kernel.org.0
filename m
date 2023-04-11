Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5386DE32D
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 19:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDKRy0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 13:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDKRyZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 13:54:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD84A4EEE
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 10:54:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sg7so33906036ejc.9
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1681235663;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=yrryeHhnkLhdBjI+IiusBoHSwY8FqBR49EYLQoRG9uU=;
        b=n+kducnI/HClkrEboojcGSrYYB8Mnuq6RXm196HIJ0/TbxqSV+dm4z8FHEqqZ54aWh
         9LZI91xy7CUgc+9vzHaSJoWiDHTry9sM4wrK1vf9Kcu9QcbFpfpRAz+2bbMELEihU+s+
         Lnft+S+8ZWudzOgs+G01c/biuTccGvxpJ3KKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235663;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrryeHhnkLhdBjI+IiusBoHSwY8FqBR49EYLQoRG9uU=;
        b=571j7Uk7TMfOSRjv1Sfhv2QY/2xuCC8WTFeQWnibQQ9nK8PPQ/ROyJy0bhGwJY3AJT
         Vkz7lhKdRZSM79VeLqWcAJEwh4vQ1LWwhtN3+FJZiL79NNsVJRA8zwjLlX4rTZuDkBjF
         x6W12BzjA2rXH9bxsu+COgu6l61M95c0ZW9nxMQMSSL4M5tpxVL3NwVoZCvp8k8F0Hr2
         4k+gPzQdAzDSGklLOUA9pG8rqMAbHEDUEsfuGgC3XQ4x2EqaV3U4pfxBBTLp7GavQok+
         H0Ik9Bmm9wdzZm23LCEH0Q0RXPKvN6FV/FfHBKhNrfhch+03vE0vRNOKGFulDzXNCGV9
         JqZA==
X-Gm-Message-State: AAQBX9eonvkbsXiRtq4Y4GOs+LRUaX8TgARy1hiWgCtKOKMOHwgNVLez
        bsy6YbGpQhpQvxZsFt4AW4fMFA==
X-Google-Smtp-Source: AKy350ZkrQtWh3QgEm99IhZQZPqghsII8d36Ewx7T3FrSf6cSnQ3JD6OuM+d8IUz+12tfWA/5LIfUw==
X-Received: by 2002:a17:907:7b06:b0:94c:548f:f81d with SMTP id mn6-20020a1709077b0600b0094c548ff81dmr5369385ejc.71.1681235663251;
        Tue, 11 Apr 2023 10:54:23 -0700 (PDT)
Received: from cloudflare.com (79.191.181.173.ipv4.supernova.orange.pl. [79.191.181.173])
        by smtp.gmail.com with ESMTPSA id jg7-20020a170907970700b0094bb4c75695sm1690515ejc.194.2023.04.11.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:54:22 -0700 (PDT)
References: <20230407171654.107311-1-john.fastabend@gmail.com>
 <20230407171654.107311-4-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     daniel@iogearbox.net, lmb@isovalent.com, edumazet@google.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v6 03/12] bpf: sockmap, improved check for empty queue
Date:   Tue, 11 Apr 2023 19:53:51 +0200
In-reply-to: <20230407171654.107311-4-john.fastabend@gmail.com>
Message-ID: <87pm8agv8y.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 07, 2023 at 10:16 AM -07, John Fastabend wrote:
> We noticed some rare sk_buffs were stepping past the queue when system was
> under memory pressure. The general theory is to skip enqueueing
> sk_buffs when its not necessary which is the normal case with a system
> that is properly provisioned for the task, no memory pressure and enough
> cpu assigned.
>
> But, if we can't allocate memory due to an ENOMEM error when enqueueing
> the sk_buff into the sockmap receive queue we push it onto a delayed
> workqueue to retry later. When a new sk_buff is received we then check
> if that queue is empty. However, there is a problem with simply checking
> the queue length. When a sk_buff is being processed from the ingress queue
> but not yet on the sockmap msg receive queue its possible to also recv
> a sk_buff through normal path. It will check the ingress queue which is
> zero and then skip ahead of the pkt being processed.
>
> Previously we used sock lock from both contexts which made the problem
> harder to hit, but not impossible.
>
> To fix also check the 'state' variable where we would cache partially
> processed sk_buff. This catches the majority of cases. But, we also
> need to use the mutex lock around this check because we can't have both
> codes running and check sensibly. We could perhaps do this with atomic
> bit checks, but we are already here due to memory pressure so slowing
> things down a bit seems OK and simpler to just grab a lock.
>
> To reproduce issue we run NGINX compliance test with sockmap running and
> observe some flakes in our testing that we attributed to this issue.
>
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Tested-by: William Findlay <will@isovalent.com>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
