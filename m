Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06E23BA4B1
	for <lists+bpf@lfdr.de>; Fri,  2 Jul 2021 22:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhGBUed (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Jul 2021 16:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhGBUed (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Jul 2021 16:34:33 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A712BC061765
        for <bpf@vger.kernel.org>; Fri,  2 Jul 2021 13:32:00 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id k20so4292006uao.8
        for <bpf@vger.kernel.org>; Fri, 02 Jul 2021 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGOVo0v3XCUiMjAb3ZKMCET9+F7mgGvVi8d4kWAB/nQ=;
        b=PIFD2PkAcBtdfGneD9rdOJGSbRlyUuSajHo5rEdUXjADsabsK9eaOyFu3SMjmK39Fs
         MYrFqCKI2Kd4ntd9AaXV8eU9jGb+yNTC9Ku5Qxr0uNu2sboax8qlfTjSn/Lmx+xndcXD
         WNQg85BnCQ55UBKyglFn2HSsvvbLEEozt5WIjhlPlFsgzopHUNiXv/A9mOlJZkJPwv5G
         fWGxW7MifwodbKAKIly274PrM3e2FWqdiz/YcZ644HkCHK88cGVrftnRUIe1tHBK8tUx
         ENvkbjIC3xpUgG5SZbZvGlS5n2oB19kmyL+Du1wgrdbBysCAj+KHsV9I+KrkT7JCM5LW
         Allg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGOVo0v3XCUiMjAb3ZKMCET9+F7mgGvVi8d4kWAB/nQ=;
        b=L3TydPd5xnFe6gx5DnBkIhd1Mq6onzzoCGcgwIga6BMvZE9aJWXGfsRJAJVaThi+g/
         hAX2pHmbdRegoa3TLZo0USbl//hvIXwLVwX4n2Vr8rrBcj86nLTT1KGDjDbTOGXGvcBc
         insu9p0dr15F/342hkwhGOMcvnSC2fHiGvaIATKwcVjbjBHLzHXEaeRAfAp5F+/XApEN
         u9DpwFHxJGFqJiwuB/OC/WEHmay0HeSNK0Kcr4TSQQjji+eSguLYftrSKsc6O5z9LQYZ
         W+Ua2iDywCjZP0s42svd5GX0LMsF1i41EuUT4/uDItypFyMZWZ/KqjGrweZMyiO2n7nQ
         vEQg==
X-Gm-Message-State: AOAM533PvXG+O+hEmsWwnK1QATvoSeXnxdcgM64ShOu8AWs+PEB5j09U
        4eS6jny2wszGE2gPQJiDP3SbsOISYqEhQIUYjARx8A==
X-Google-Smtp-Source: ABdhPJz4axXxYgNaw6qv30zYaVckpnHi/S38bZVet4scjqfWTYa4pK51kVkcebfSQ3hnZ/OxwnV3PR1gwx3ni/HCqUw=
X-Received: by 2002:ab0:77d0:: with SMTP id y16mr2408304uar.46.1625257919512;
 Fri, 02 Jul 2021 13:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210702194033.1370634-1-phind.uet@gmail.com>
In-Reply-To: <20210702194033.1370634-1-phind.uet@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Fri, 2 Jul 2021 16:31:42 -0400
Message-ID: <CADVnQynvWsD2qWfw4qJsNhyyPXbFGfhZmhMzaggfJ8JtUUt9VA@mail.gmail.com>
Subject: Re: [PATCH v2] tcp: fix tcp_init_transfer() to not reset icsk_ca_initialized
To:     Nguyen Dinh Phi <phind.uet@gmail.com>
Cc:     edumazet@google.com, davem@davemloft.net, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f1e24a0594d4e3a895d3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 2, 2021 at 3:41 PM Nguyen Dinh Phi <phind.uet@gmail.com> wrote:
>
> This commit fixes a bug (found by syzkaller) that could cause spurious
> double-initializations for congestion control modules, which could cause
> memory leaks orother problems for congestion control modules (like CDG)
> that allocate memory in their init functions.
>
> The buggy scenario constructed by syzkaller was something like:
>
> (1) create a TCP socket
> (2) initiate a TFO connect via sendto()
> (3) while socket is in TCP_SYN_SENT, call setsockopt(TCP_CONGESTION),
>     which calls:
>        tcp_set_congestion_control() ->
>          tcp_reinit_congestion_control() ->
>            tcp_init_congestion_control()
> (4) receive ACK, connection is established, call tcp_init_transfer(),
>     set icsk_ca_initialized=0 (without first calling cc->release()),
>     call tcp_init_congestion_control() again.
>
> Note that in this sequence tcp_init_congestion_control() is called
> twice without a cc->release() call in between. Thus, for CC modules
> that allocate memory in their init() function, e.g, CDG, a memory leak
> may occur. The syzkaller tool managed to find a reproducer that
> triggered such a leak in CDG.
>
> The bug was introduced when that commit 8919a9b31eb4 ("tcp: Only init
> congestion control if not initialized already")
> introduced icsk_ca_initialized and set icsk_ca_initialized to 0 in
> tcp_init_transfer(), missing the possibility for a sequence like the
> one above, where a process could call setsockopt(TCP_CONGESTION) in
> state TCP_SYN_SENT (i.e. after the connect() or TFO open sendmsg()),
> which would call tcp_init_congestion_control(). It did not intend to
> reset any initialization that the user had already explicitly made;
> it just missed the possibility of that particular sequence (which
> syzkaller managed to find).
>
> Fixes: commit 8919a9b31eb4 ("tcp: Only init congestion control if not
> initialized already")

Please note that the patchwork tools have found a style/formatting
issue with your Fixes tag:

You can find them at:
https://patchwork.kernel.org/project/netdevbpf/list/
 ->
 https://patchwork.kernel.org/project/netdevbpf/patch/20210702194033.1370634-1-phind.uet@gmail.com/
  ->
   https://patchwork.hopto.org/static/nipa/510221/12356435/verify_fixes/stdout

The error is:
---
Fixes tag: Fixes: commit 8919a9b31eb4 ("tcp: Only init congestion control if not
Has these problem(s):
- leading word 'commit' unexpected
- Subject has leading but no trailing parentheses
- Subject has leading but no trailing quotes
---

Basically, please omit the "commit" and don't wrap the text (it's OK
if it's longer than 80 or 100 characters).

thanks,
neal
