Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C6156AAE8
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiGGSgb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 14:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbiGGSgb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 14:36:31 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247B521A
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 11:36:30 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-317a66d62dfso178822427b3.7
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BF9Ehrqmqwiz/UrcKcS0L4NTo9GZL+bOvT6TqkmWqQM=;
        b=tb78a9qaXnOSPeZkQcyyD2qL2ELQmx8XXelsLSi50pbCOTEZzjvYlZY+dcoc9evhqa
         V61AStNiH6OD6Efruct1Gocd6ls3sYIO7ROL8xIFN7yHwNVvy4ihMvEf5EgstQKt2ZS9
         ocT7vVhz0FCl9LXCaviOcuqwRb+8amN+DvMoz9Lt7DI/1VFZALXrkaYr42vCFbxdasXf
         KWIZCh8ciYhomFlJomjN32hLc6R0yQ+oPGp/ZCUiAxRQckK2LP1hDoFOK8cHFOTMkVWD
         xsasU1y0HOdMkM2T1iANsaW2k7reC0W9N0bupp7BgvWWgZtxlXTO3J3AAcw9i4A7oOTM
         EZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BF9Ehrqmqwiz/UrcKcS0L4NTo9GZL+bOvT6TqkmWqQM=;
        b=2r1IOXo6vTQBkJrXbhoH8a2po3jeOdXml3I7QNeuh8brsxg4R0YiaMDdFFEqbhLVWM
         /EoeydPSGM3IgU9Dlprh4Ry3Xd0tqD6e41/b9D0gZd/FUXimbuj86MUPbmFq8ZQnfF9S
         3q0L8Zs/WU1Ov+kRxKvkhEi2e4Wg6Joc85s4/TwwbTTcJ8ESi3hdUlPlOX5RzX1pi4tK
         qt5ODLaPZqWRwPYOeyBaTx8N21Zy/ItqqZpVHMd7atrsS9zdTi4q+iMFFPrA3ADIoIAp
         TwUonaDM3y2pW5SInXwKmXI3Uq5LRwg65yDoQzUpm8OoQuMIqylQVt1j3/YiluVh1KqE
         s6Pw==
X-Gm-Message-State: AJIora/IEpJv15vO4lX73XtSsfAC5/ZxQSnNY16LG1bTYbqCsHGJYnv6
        nuwKE95fpmwBAnKOkkybD6oHO9ivL48NdtXasi+k+w==
X-Google-Smtp-Source: AGRyM1tvPAS4rzsHJXr4lPYjvNrlT2DRnE4AVoMJp8xgQgeQEugCFqqO07pK9nrmCASgPmwYoRCaAMDK8DrHmzi8aPA=
X-Received: by 2002:a81:4994:0:b0:31c:d036:d0b1 with SMTP id
 w142-20020a814994000000b0031cd036d0b1mr17247785ywa.255.1657218989053; Thu, 07
 Jul 2022 11:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220707123900.945305-1-edumazet@google.com> <165721801302.2116.12763817658962623961.git-patchwork-notify@kernel.org>
 <CAADnVQLoMzN8icCenQh7OHNRHAHMhQhujQYwSXH3Kmw6sAGOGA@mail.gmail.com>
In-Reply-To: <CAADnVQLoMzN8icCenQh7OHNRHAHMhQhujQYwSXH3Kmw6sAGOGA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Jul 2022 20:36:17 +0200
Message-ID: <CANn89iLarMJeMUivaPnYHUh3MYjEZ91USq0ncGbLFp1JNjEiaA@mail.gmail.com>
Subject: Re: [PATCH] bpf: make sure mac_header was set before using it
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>
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

On Thu, Jul 7, 2022 at 8:31 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 7, 2022 at 11:20 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
> >
> > Hello:
> >
> > This patch was applied to bpf/bpf.git (master)
>
> Are we sure it's bpf tree material?
> The fixes tag points to net-next tree.

Fix is generic and should not harm bpf tree, or any tree if that matters.

Sorry for not adding the net-next tag in the [PATCH].

>
> > by Daniel Borkmann <daniel@iogearbox.net>:
> >
> > On Thu,  7 Jul 2022 12:39:00 +0000 you wrote:
> > > Classic BPF has a way to load bytes starting from the mac header.
> > >
> > > Some skbs do not have a mac header, and skb_mac_header()
> > > in this case is returning a pointer that 65535 bytes after
> > > skb->head.
> > >
> > > Existing range check in bpf_internal_load_pointer_neg_helper()
> > > was properly kicking and no illegal access was happening.
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - bpf: make sure mac_header was set before using it
> >     https://git.kernel.org/bpf/bpf/c/0326195f523a
> >
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> >
