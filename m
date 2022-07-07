Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E865696C2
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 02:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiGGAOf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 20:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiGGAOe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 20:14:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA822CE20
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 17:14:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g1so13556300edb.12
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 17:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RhqfdQ1GQrT/2BgJcOYLTDt5L8saJLJldEnPN/oVRn8=;
        b=lYczNUyQqvRub5qM0GUekOlqFauwqn8uv9veIZ+NE2tHfXLhLF/nakPGXZomsbYigP
         N7uyQpaf6c3HlpileS5CtvUbcNsew2LwWmn9H2fbn62fVWo42ohjcrjfnGjVzR3ErvU2
         3fgkkfhZD0OVV5OH7zXUwrh0tVDC/kUD6cdpQGBaKyM2JWN7FnUT3qmLuPLxcLuu7KEC
         69is13h2lGwp8xkgglCHUtRnxXJtxAWcAACm8U2BmJdtJDqNQ+mnaaiTu9PygE5O/LEy
         LjUNwDUUt2TjuwqKW3IAAzTR6XbMuSzNUoV3p3PCoagssSfn+IdecFRDXckOxzHV6cJr
         BwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhqfdQ1GQrT/2BgJcOYLTDt5L8saJLJldEnPN/oVRn8=;
        b=pMoatVW9GslMR6w2kDrTD1hi2r+GR81ecOijg8wFMKA9uDQ6kc5zqL87GHMe/1fInU
         S40RHGkiJ6we1imxV5q2sXhEpXvWkv+dGFpD+QXmgd1caC4aCgIrrGYcz9PPQz3Tdk4/
         nu5d82SWCLHuDxDQDw6kWdtDtTNfYg8Nvc1cbVm9lZEmqvieg1QoZg9CuBKTiE1JTPQF
         7WsM0O+xGPSZtXiI9HOY0dcZXp/mMcdK9dfepiYbJLyDVCUyzV8khU9gMjc/LQWAZHNF
         J8mWxphX7DGpRQYcdM5ZmEUa0pkZDdQ0ByLUTgxolvYS/OO3sxZiigL4lZALQC4ctpp5
         i73Q==
X-Gm-Message-State: AJIora/AXmqfwa5etjbAYU8aBzIOcrfQ8/Et2Sp4M5y3R5YcI/EqoALf
        ze+0M9H2lcKSyl2y62Y6uTB8XI16CXLa8VvfdN0=
X-Google-Smtp-Source: AGRyM1se9bqXHb2Y/esnhTkTILruwuH0g3RNUzHq6vV87P5qW6rFXcD3rsvFRkFTV8FlSMqPAfGGLF4qSPnnw8mfDmM=
X-Received: by 2002:a05:6402:2cd:b0:43a:70f7:1af2 with SMTP id
 b13-20020a05640202cd00b0043a70f71af2mr20383723edx.357.1657152871644; Wed, 06
 Jul 2022 17:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-2-laoar.shao@gmail.com>
 <20220707000721.dtl356trspb23ctp@google.com>
In-Reply-To: <20220707000721.dtl356trspb23ctp@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 6 Jul 2022 17:14:20 -0700
Message-ID: <CAADnVQLr=ELkgFX2uotfF6KoogqM1DSWdBhvB4J6Pzo9vRypKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make non-preallocated allocation low priority
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 6, 2022 at 5:07 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Jul 06, 2022 at 03:58:47PM +0000, Yafang Shao wrote:
> > GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> > if we allocate too much GFP_ATOMIC memory. For example, when we set the
> > memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> > easily break the memcg limit by force charge. So it is very dangerous to
> > use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> > remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> > __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> > too much memory.
>
> Please use GFP_NOWAIT instead of (__GFP_ATOMIC | __GFP_KSWAPD_RECLAIM).
> There is already a plan to completely remove __GFP_ATOMIC and mm-tree
> already have a patch for that.

hmm. ok. reverted.
