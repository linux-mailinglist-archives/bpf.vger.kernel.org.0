Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED40F30E632
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 23:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhBCWm5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 17:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbhBCWm4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 17:42:56 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1BFC0613ED
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 14:42:05 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s18so1011297ljg.7
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 14:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FumwaWvzHZWVNE5DDIsNdn258CZK4DlZwzfhawRHFFU=;
        b=BKh7HWRt5QJP2ZHOVPSFF1wrdrwqUM37KNsTjNzom5tGNnPIJ9vw2p0eKaZW9IlCGj
         PRQAlgqXV+HlNMYI+NXDD4iUgxVBON3yb1Gb7JvZ7Qh7f5vcNjvMQbyHbIbrbLHDsDQK
         F8FxKVZ0QMQBKcXhm9xzGbFs25ys7XxOURSKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FumwaWvzHZWVNE5DDIsNdn258CZK4DlZwzfhawRHFFU=;
        b=qD+AA6AiQQTiTorSbs4V98QU1TloyJBSNHHuqNWlgpz+VSD+DTHouhfOirOQLBWe7X
         uTDnj6mumzqACAMrBzRnq84jVLKGJbbnJKnD7DZNbjsQ8FILKH+/rxp7IXDLaY/pzdFM
         1rG898e1//olLKzB8pmot1SfU2XQW+50xH87hFPg/sTT8VgEwvcmfJt+A8vkpntn2NIs
         KhuCZrjev7pNCPz5/8nJUZ4twLL5HMJDqjSLLTDo5gSQXU+51Z2DvwbHbRJC4mi+sJag
         Gqq6LiC7OWadE77b2ud6Mchw8dsTxKllSvtgD3BJV86vCKIXHkco/tI8pgW+Bdd0w0Pc
         jEgg==
X-Gm-Message-State: AOAM533hTtJjL3QJ/8fWxUivON6BHHyvPc9yh69Q0asrHHxSotvZMo2a
        eO1HrhbLvPGca/SpfSGwS1/qPxb/h+/NvaZcHXWi2g==
X-Google-Smtp-Source: ABdhPJwKhpR8sbJ8ZrHXrXvTED9hh5AbNkWxJFB2AjnN5UiHsFQgc7BNpiMd7cHW6zHpZnnJ9JFHzJh6we9lf652od8=
X-Received: by 2002:a2e:3a18:: with SMTP id h24mr2987085lja.170.1612392124007;
 Wed, 03 Feb 2021 14:42:04 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi3HjduhY-nQXzy2ezGbiMB1Vk9cnhW2pMypUa+P1OjtzQ@mail.gmail.com>
 <CABWYdi27baYc3ShHcZExmmXVmxOQXo9sGO+iFhfZLq78k8iaAg@mail.gmail.com>
 <YBrTaVVfWu2R0Hgw@hirez.programming.kicks-ass.net> <CABWYdi2ephz57BA8bns3reMGjvs5m0hYp82+jBLZ6KD3Ba6zdQ@mail.gmail.com>
 <20210203190518.nlwghesq75enas6n@treble>
In-Reply-To: <20210203190518.nlwghesq75enas6n@treble>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Wed, 3 Feb 2021 14:41:53 -0800
Message-ID: <CABWYdi1ya41Ju9SsHMtRQaFQ=s8N23D3ADn6OV6iBwWM6H8=Zw@mail.gmail.com>
Subject: Re: BUG: KASAN: stack-out-of-bounds in unwind_next_frame+0x1df5/0x2650
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        Hailong liu <liu.hailong6@zte.com.cn>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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

On Wed, Feb 3, 2021 at 11:05 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Feb 03, 2021 at 09:46:55AM -0800, Ivan Babrou wrote:
> > > Can you pretty please not line-wrap console output? It's unreadable.
> >
> > GMail doesn't make it easy, I'll send a link to a pastebin next time.
> > Let me know if you'd like me to regenerate the decoded stack.
> >
> > > > edfd9b7838ba5e47f19ad8466d0565aba5c59bf0 is the first bad commit
> > > > commit edfd9b7838ba5e47f19ad8466d0565aba5c59bf0
> > >
> > > Not sure what tree you're on, but that's not the upstream commit.
> >
> > I mentioned that it's a rebased core-static_call-2020-10-12 tag and
> > added a link to the upstream hash right below.
> >
> > > > Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > > Date:   Tue Aug 18 15:57:52 2020 +0200
> > > >
> > > >     tracepoint: Optimize using static_call()
> > > >
> > >
> > > There's a known issue with that patch, can you try:
> > >
> > >   http://lkml.kernel.org/r/20210202220121.435051654@goodmis.org
> >
> > I've tried it on top of core-static_call-2020-10-12 tag rebased on top
> > of v5.9 (to make it reproducible), and the patch did not help. Do I
> > need to apply the whole series or something else?
>
> Can you recreate with this patch, and add "unwind_debug" to the cmdline?
> It will spit out a bunch of stack data.

Here's the three I'm building:

* https://github.com/bobrik/linux/tree/ivan/static-call-5.9

It contains:

* v5.9 tag as the base
* static_call-2020-10-12 tag
* dm-crypt patches to reproduce the issue with KASAN
* x86/unwind: Add 'unwind_debug' cmdline option
* tracepoint: Fix race between tracing and removing tracepoint

The very same issue can be reproduced on 5.10.11 with no patches,
but I'm going with 5.9, since it boils down to static call changes.

Here's the decoded stack from the kernel with unwind debug enabled:

* https://gist.github.com/bobrik/ed052ac0ae44c880f3170299ad4af56b

See my first email for the exact commands that trigger this.
