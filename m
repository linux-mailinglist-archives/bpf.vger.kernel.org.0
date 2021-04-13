Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F48135D981
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 09:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241597AbhDMH56 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 03:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhDMH55 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 03:57:57 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1554FC061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 00:57:38 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o5so17030458qkb.0
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 00:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5+J2bw3iz0Zd+e+lzu2Qo4E0AM0dkQGDSzLnSvZvy8=;
        b=UeZk+RiCWOC7JzxfKx3yG2cydgBtlZe/1uejtnF2xNqDmGDcNuEZ7EWdrLLtf952pZ
         TMknEiK+XX8+TDgABXQ0W6jCrHb38B53AGoe0RygEiyoUfy29wB5i0e3K2jT8rQDIl8l
         ZbMe/h14O6lherBFHDwEXREbR05vy7VITvEdWkKpHFS7+rKoiehzsm//anB/UGwZIT/Z
         +rtrJmxi9XEmTshzP4Lb0KxSZyS74VXC/v0zZVombQRZKV/pKCcKZ+vJL/jEl4X3sMwT
         EhnMDchYe2NHaL8A0OI+NDCW4n6vcl5gXg4DQ1gtZvXw2gS4l1S0KThEfPZCB6NMouT+
         TMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5+J2bw3iz0Zd+e+lzu2Qo4E0AM0dkQGDSzLnSvZvy8=;
        b=CnZ8e6wdblrRKx7L5+qPq9uKVHa96psNMnohWwpxEVO/yrqmLAnxX4eJxmOz9UtfGY
         Gcb0bmP86G6pWtNQ5WMLgeUoAUtBGDQE8KFUr80ePSR9Vb64t78pivb9Gx5sWgRpGTRQ
         pNgCm7WbtbH5qDADfU1Rb96Rfum/GpodbSuQaVmRBr3+nkrVCnZw4EaDQD/gtbJ5p4V+
         vXopRyZLKHyONFMMAWQ8Ct9TtrQznV+nwwXYpqqJFtqZ2DEcBz/FLlIRObfSetwdFEpA
         VT9Y4LyTx0wuMPq3gVLjOYx7xNYJ1EJQs4A1l8DmOdxnHfLyJXzTD0j/WP4rjTJKMUYU
         gu5g==
X-Gm-Message-State: AOAM531wh+zBlpiacESrcw+iJ6lINyEZw5SErHCT+UHwrKouB2Loe9zl
        gRvipK94jfFJzLcTazqcsRrYsEtAVqut7ojXfX3POQ==
X-Google-Smtp-Source: ABdhPJwmtYlYZsMa2hF3X+4S3UYYT7bEmTeyHKp2IMqH7S4yesxoBZaPruLYG7pF0rHfjIIruZRgYqgIQzZGzlPSX08=
X-Received: by 2002:a05:620a:243:: with SMTP id q3mr11958116qkn.501.1618300657089;
 Tue, 13 Apr 2021 00:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000680f2905afd0649c@google.com> <000000000000043f2c05beed04d8@google.com>
In-Reply-To: <000000000000043f2c05beed04d8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 09:57:26 +0200
Message-ID: <CACT4Y+YEE1g-_+3VWS=+tsv9vMOFi3P3rbTj2b2ivbb=+=UeaA@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in bpf_trace_run2
To:     syzbot <syzbot+cc36fd07553c0512f5f7@syzkaller.appspotmail.com>
Cc:     andrii@kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@chromium.org>, kpsingh@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        mmullins@mmlx.us, netdev <netdev@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 1, 2021 at 8:01 PM syzbot
<syzbot+cc36fd07553c0512f5f7@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit befe6d946551d65cddbd32b9cb0170b0249fd5ed
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Wed Nov 18 14:34:05 2020 +0000
>
>     tracepoint: Do not fail unregistering a probe due to memory failure
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f0260ed00000
> start commit:   12450081 libbpf: Fix native endian assumption when parsing..
> git tree:       bpf
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5ac0d21536db480b
> dashboard link: https://syzkaller.appspot.com/bug?extid=cc36fd07553c0512f5f7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1365d2c3900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d5f08d900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: tracepoint: Do not fail unregistering a probe due to memory failure
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix:
tracepoint: Do not fail unregistering a probe due to memory failure
