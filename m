Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7DA30E169
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 18:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhBCRsK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 12:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhBCRsE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 12:48:04 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3412C061788
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 09:47:08 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a17so76928ljq.2
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 09:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Sd7lpuzzYzAe84omnrWYz0GYPR/9/jZDwcpOZKoCos=;
        b=rAHCkrSCSvsO3i942zxFGAk0xb59fBgQ9tJbci20Qr8DGAfbkfFqUS0o0lV+OAJMgn
         JOSqWMGKZzFwQMVac947lcIMwL6Tc5F0tVcjRhUHs9tzA6STcT7JKCU3wT2IirVckFFg
         v7A4WB7VsSJXr/haxcAPud+QTaGWwMHaudZig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Sd7lpuzzYzAe84omnrWYz0GYPR/9/jZDwcpOZKoCos=;
        b=tLJIibUiP/FY0sa4JomQ63Le1M2qtAsXp0OJzSi01DpQZB4LRkX9etvSZY5vTTX/P/
         dC8KEasQJTyZnf1XCUo3DPLJP98XSENLHHkQxf+ZNB8tdPXIu55zkuUh+JSBSZTxITPx
         jRKfux32PNrfMdf4Vu/uqxdgiMHoOSSUOYzDhMs5iHedhCWrwKu6XjC78WpryHF5eOX3
         c1aqstb1BeMZ/aYfYmTgK3HPzm/8pmCH3LpkYNB9dr8ttWokUj1ps64d9RMBAsNNMqcs
         Zs9tjSgi/cSt/m5a3Dv5fYHZVS+b319PYD1vEQ/jDYIV32Pa4MwNENsiyz3h8CoOqWoH
         1oRw==
X-Gm-Message-State: AOAM532fJVwuwDN7ezApKIsjrC1tNLB7klj+fw44ybT2/a1pBTpI5ono
        kOdwYMOLTa5ohBNyzhqlrSR4YfxsAFGhHVYtGP3FAQ==
X-Google-Smtp-Source: ABdhPJzdVb3Jed1F5NgGdDtfAd5oNibLzyOzFOWG4eVNHu9dYMCxEE44x+nn5372HQ8P/nr1dxBBfvSeiQCWg8NBeQU=
X-Received: by 2002:a2e:9cc8:: with SMTP id g8mr2376414ljj.479.1612374426835;
 Wed, 03 Feb 2021 09:47:06 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi3HjduhY-nQXzy2ezGbiMB1Vk9cnhW2pMypUa+P1OjtzQ@mail.gmail.com>
 <CABWYdi27baYc3ShHcZExmmXVmxOQXo9sGO+iFhfZLq78k8iaAg@mail.gmail.com> <YBrTaVVfWu2R0Hgw@hirez.programming.kicks-ass.net>
In-Reply-To: <YBrTaVVfWu2R0Hgw@hirez.programming.kicks-ass.net>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Wed, 3 Feb 2021 09:46:55 -0800
Message-ID: <CABWYdi2ephz57BA8bns3reMGjvs5m0hYp82+jBLZ6KD3Ba6zdQ@mail.gmail.com>
Subject: Re: BUG: KASAN: stack-out-of-bounds in unwind_next_frame+0x1df5/0x2650
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        Hailong liu <liu.hailong6@zte.com.cn>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Robert Richter <rric@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Can you pretty please not line-wrap console output? It's unreadable.

GMail doesn't make it easy, I'll send a link to a pastebin next time.
Let me know if you'd like me to regenerate the decoded stack.

> > edfd9b7838ba5e47f19ad8466d0565aba5c59bf0 is the first bad commit
> > commit edfd9b7838ba5e47f19ad8466d0565aba5c59bf0
>
> Not sure what tree you're on, but that's not the upstream commit.

I mentioned that it's a rebased core-static_call-2020-10-12 tag and
added a link to the upstream hash right below.

> > Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Date:   Tue Aug 18 15:57:52 2020 +0200
> >
> >     tracepoint: Optimize using static_call()
> >
>
> There's a known issue with that patch, can you try:
>
>   http://lkml.kernel.org/r/20210202220121.435051654@goodmis.org

I've tried it on top of core-static_call-2020-10-12 tag rebased on top
of v5.9 (to make it reproducible), and the patch did not help. Do I
need to apply the whole series or something else?
