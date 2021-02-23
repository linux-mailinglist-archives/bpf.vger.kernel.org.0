Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710C33230DF
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 19:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhBWShr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 13:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhBWShq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 13:37:46 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60383C06174A
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 10:37:01 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id o16so59633738ljj.11
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 10:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=E50IIg6QS1J2ekVIp5/vZr8iPYB5YAAkcwkaRyVEjlw=;
        b=KNFRMmB/Z5Tju36hdgxttb+OUUJliAVQkukoSiGrQtYpt5B9CTSndjFWLGfsY7HgYK
         X4DmzoK8Gi52qtISLcaEHfGI2AIglNWaxxKMs79G86B/XbpWTscSx6WhPkjcLbAp9dL2
         CPbiW2HC4ULdpR2HIf8OSiF2taqPTIH2e3RzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=E50IIg6QS1J2ekVIp5/vZr8iPYB5YAAkcwkaRyVEjlw=;
        b=eBWOHWmHi+/lf1Ma30D5KDPUzHvtJSiqsEmUdx4KgulLhWTHajWwFIRNsk75WQlTGk
         zd9OHlNpSC2A/9iZsxH61GXaAsfWvEcooTmEH4ZW2I5Ipi3Q0WfaMiFFNaLsUxiMrc3U
         tIwLTtNK0ly4OilgvePxIsmyR6WfUK/ogfrII1skOYfDVlD5AyZ/Ic0PfkvMMiJgINms
         FntzxPEZLTXvL9PtyRdHhwkDssVifd1H1Sq6zKCc07vCnPlqpAO/5XJHzwYE3gM5SSjA
         JEokCfpFeA986t7+3dbwfUYi+YMzh6O7oKS0mcvzDH7FRNQnAO5A1upiHLfSaTzsWY5g
         1PTw==
X-Gm-Message-State: AOAM5320PbkOt0yYn7shUhdc7xTLY2ROYOZW/jt9icNYRA17/eoyegRH
        cdvCBI5YjQ1R4IwBcJQSUOWDQA==
X-Google-Smtp-Source: ABdhPJzKXVfDVKLrrungZLuAcIvsB6BN1qWck9v7Qz+EHNz5OzMtGHlBXUh+hs8m8Ep1742DpF3qhQ==
X-Received: by 2002:a2e:8691:: with SMTP id l17mr5612536lji.297.1614105419695;
        Tue, 23 Feb 2021 10:36:59 -0800 (PST)
Received: from cloudflare.com (79.184.34.53.ipv4.supernova.orange.pl. [79.184.34.53])
        by smtp.gmail.com with ESMTPSA id g4sm2779368lfu.283.2021.02.23.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 10:36:59 -0800 (PST)
References: <20210220052924.106599-1-xiyou.wangcong@gmail.com>
 <20210220052924.106599-5-xiyou.wangcong@gmail.com>
 <87eeh847ko.fsf@cloudflare.com>
 <CAM_iQpVS_sJy=sM31pHZVi6njZEAa7Hv_Bkt2sB7JcAjFw3guw@mail.gmail.com>
 <875z2i4qo5.fsf@cloudflare.com>
 <CAM_iQpWofNM=erfyP8b_qrezJN6d51UDW5bfgo2LHkPOTXqm8Q@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, duanxiongchun@bytedance.com,
        Dongdong Wang <wangdongdong.6@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [Patch bpf-next v6 4/8] skmsg: move sk_redir from TCP_SKB_CB to
 skb
In-reply-to: <CAM_iQpWofNM=erfyP8b_qrezJN6d51UDW5bfgo2LHkPOTXqm8Q@mail.gmail.com>
Date:   Tue, 23 Feb 2021 19:36:57 +0100
Message-ID: <874ki24omu.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 23, 2021 at 07:04 PM CET, Cong Wang wrote:
> On Tue, Feb 23, 2021 at 9:53 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> Based on what I've seen around, mask for sanitizing tagged pointers is
>> usually derived from the flag(s). For instance:
>>
>> #define SKB_DST_NOREF   1UL
>> #define SKB_DST_PTRMASK ~(SKB_DST_NOREF)
>>
>> #define SK_USER_DATA_NOCOPY     1UL
>> #define SK_USER_DATA_BPF        2UL     /* Managed by BPF */
>> #define SK_USER_DATA_PTRMASK    ~(SK_USER_DATA_NOCOPY | SK_USER_DATA_BPF)
>>
>> Using ~(BPF_F_INGRESS) expression would be like substituting mask
>> definition.
>
> Yes, that is why I said we need a mask.

OK

>
>>
>> Alternatively we could clear _skb_refdest after clone, but before
>> enqueuing the skb in ingress_skb. And only for when we're redirecting.
>>
>> I believe that would be in sk_psock_skb_redirect, right before skb_queue_tail.
>
> Hmm? We definitely cannot clear skb->_sk_redir there, as it is used after
> enqueued in ingress_skb, that is in sk_psock_backlog().

You're right. I focused on the sk pointer and forgot it also carries the
ingress flag.
