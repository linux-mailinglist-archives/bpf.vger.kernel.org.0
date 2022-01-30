Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9964A3635
	for <lists+bpf@lfdr.de>; Sun, 30 Jan 2022 13:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354775AbiA3MZk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 Jan 2022 07:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354767AbiA3MZj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 Jan 2022 07:25:39 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35320C061741
        for <bpf@vger.kernel.org>; Sun, 30 Jan 2022 04:25:38 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k25so33832012ejp.5
        for <bpf@vger.kernel.org>; Sun, 30 Jan 2022 04:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=PMTYH8vYxJzYzIKQ4wJ1Cn/QVbnABT43BbzXgdJrWQI=;
        b=apo0H/0Dyl2t3hk8E0D2z85aDd6iOJNXpJKyEbBY7/JTNGPCdkbdnzGkICjahHHvdg
         ikbaCSmfvGWZBU6IZXUhNElfru0/txxioJdYFDH5e/cXST9poMaEGPF58kTHE38lu4h0
         h8EdekFT0o5IRjk4tqQ0MYnPW0lGioEBYLaYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=PMTYH8vYxJzYzIKQ4wJ1Cn/QVbnABT43BbzXgdJrWQI=;
        b=NgD/HVvHks+OAsCJgOw3JaX95zwWSeTmmgEZjsrVGGdc81khBU68o5HANAGzQHz1a9
         dufCJtDmqphQ56B8xD2VBXV8FRZEb9K/8wMtHGm441ZENjonYqsvXmz38UyZrpfxeA1q
         AkWpHuzBoTcG2v5k643jee0fmuVYBn/lvju6JCCuhiAyoi9v2Zq1iKWorSajpXyhW4sC
         qms3k5pwTb6ewEn7t7aovipfIOYQtefB+oeDltTkNMzZXGhgWxZ6N6W5K14Yecotkvl4
         rov2MB5tt8arY9Ux6YBpeUpvM0xBTR4jgHxU8jMV2b1tsCwXnf8dYKg15U0ABFRKaYPS
         A6/A==
X-Gm-Message-State: AOAM532Oz37SsK+TH4ntePlZRbC9DjV4FqsbaiHpLzd8QbtUCqKw/wU/
        g3A1cDlOPdTyRcg79kEkW360YQ==
X-Google-Smtp-Source: ABdhPJy3rWsVAeaHCILbvxyPLUIcCktog468JC/fPRiLCOsjiBYoYIRU/3dSm2dhcMilSbKwZrs6iA==
X-Received: by 2002:a17:906:730a:: with SMTP id di10mr13618818ejc.489.1643545536662;
        Sun, 30 Jan 2022 04:25:36 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id s19sm13891576edr.23.2022.01.30.04.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 04:25:36 -0800 (PST)
References: <20220130030352.2710479-1-hefengqing@huawei.com>
 <CAADnVQLsom4MQq2oonzfCqrHbhfg9y7YMPCk6Wg6r4bp3Su03g@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     He Fengqing <hefengqing@huawei.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [bpf-next] bpf: Add CAP_NET_ADMIN for sk_lookup program type
In-reply-to: <CAADnVQLsom4MQq2oonzfCqrHbhfg9y7YMPCk6Wg6r4bp3Su03g@mail.gmail.com>
Date:   Sun, 30 Jan 2022 13:25:35 +0100
Message-ID: <87zgndqukg.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 30, 2022 at 04:24 AM CET, Alexei Starovoitov wrote:
> On Sat, Jan 29, 2022 at 6:16 PM He Fengqing <hefengqing@huawei.com> wrote:
>>
>> SK_LOOKUP program type was introduced in commit e9ddbb7707ff
>> ("bpf: Introduce SK_LOOKUP program type with a dedicated attach point"),
>> but the commit did not add SK_LOOKUP program type in net admin prog type.
>> I think SK_LOOKUP program type should need CAP_NET_ADMIN, so add SK_LOOKUP
>> program type in net_admin_prog_type.
>
> I'm afraid it's too late to change.
>
> Jakub, Marek, wdyt?

That's definitely an oversight on my side, considering that CAP_BPF came
in 5.8, and sk_lookup program first appeared in 5.9.

Today it's possible to build a usable sk_lookup program without
CAP_NET_ADMIN if you go for REUSEPORT_SOCKARRAY map instead of
SOCKMAP/HASH.

Best I can come up is a "phase it out" approach. Put the CAP_NET_ADMIN
load-time check behind a config option, defaulting to true?, and wait
for it to become obsolete.
