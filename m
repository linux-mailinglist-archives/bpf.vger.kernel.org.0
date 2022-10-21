Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB818607CAC
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 18:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJUQt7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 12:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiJUQtz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 12:49:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177A6E09DB
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 09:49:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l4so2861181plb.8
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/veItqXlMJIQTcpDjM5JBzQqgSWpElwpdVZBwKN6hJc=;
        b=II+6tRfI3o4IWM6bK4CLHQMdChvkiK85yyUuB33AlvXPnQlJOzyfUurZ9ghhEh4Bcp
         hK5caeuJ7efRWUGlErbXOLzT/G5qtuLcOjUS2UwGz9qG0IEhT1Rem3kQkeE9vE+VvDAo
         2qn+M6JzvenfZRqzI6B1y+kW4+qXWJYeQzJuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/veItqXlMJIQTcpDjM5JBzQqgSWpElwpdVZBwKN6hJc=;
        b=a8Otmkp1sOaRKsY4etISXuF0nFqaJafmD2DBgbB3eR4u7k9iXcYBN6Ab5rPNwOyDub
         M5NVx7UonrqsTYOYky1oJ4hXsH64CU2YO7Jb/mSOXeGwB2970ly2XE+Yiw3gHj5pfCqW
         yi5efqUhubiNvCmru1WPEXXGqvrIiIq18H0JZBbfimxcL0fuTMPAtA1hIhj9fN04cOe5
         eYtpx2hY7t+WyXNjcdzni21ayiMkavAy8eZBzLiJDBtsz7TRcOpvomfM5MIreuHF8kJS
         qPP7+iWmkKKPlJKpCTIHxy+diI/Y+wLyxYYNNpl99CGaRi7X7lE5a6avFJO9RF+E90tI
         a7Sw==
X-Gm-Message-State: ACrzQf0fhI8h00ZnGpj3cgSe/1SXijV3Nyuc/Th8N+QBsg2+sJ97mXau
        NvRqkNSY9ze84P+FzeRZGXBnZFLtTxo0HQwdEXjHcg==
X-Google-Smtp-Source: AMsMyM492XaifRbV0Xp7jrZHgBHM2zCIypWIvrKBrEXC2Ld4rwIq+kUfF1WZv/Xcr9iHc3ynJsuZUvoHdq/WuuH47xA=
X-Received: by 2002:a17:902:f1cc:b0:186:6670:e3da with SMTP id
 e12-20020a170902f1cc00b001866670e3damr8654642plc.41.1666370990207; Fri, 21
 Oct 2022 09:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
 <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net> <YzG51Jyd5zhvygtK@arm.com>
 <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N> <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
 <YzR5WSLux4mmFIXg@FVFF77S0Q05N> <2cb606b4-aa8b-e259-cdfd-1bfc61fd7c44@huawei.com>
 <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
 <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com> <20221005110707.55bd9354@gandalf.local.home>
 <CABRcYmJGY6fp0CtUBYN8BjEDN=r42BPLSBcrxqu491bTRmfm7g@mail.gmail.com>
 <20221005113019.18aeda76@gandalf.local.home> <CABRcYmL0bDkgYP3tSwhZYaGUSbsUR3Gq85QCRiUAdXt65czzmg@mail.gmail.com>
 <20221006122922.53802a5c@gandalf.local.home> <CABRcYm+d=xY9nBCJo-6JW_=F41g4X32QM9WOPChaOTfs6d6KCA@mail.gmail.com>
 <20221021203158.4464ac19d8b19b6da6a40852@kernel.org>
In-Reply-To: <20221021203158.4464ac19d8b19b6da6a40852@kernel.org>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 21 Oct 2022 18:49:38 +0200
Message-ID: <CABRcYmKzwAFr_0NOxeWhXcCiT5wwi_qkm5Czc0C4CVCAs8stFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 1:32 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Mon, 17 Oct 2022 19:55:06 +0200
> Florent Revest <revest@chromium.org> wrote:
> > Mark finished an implementation of his per-callsite-ops and min-args
> > branches (meaning that we can now skip the expensive ftrace's saving
> > of all registers and iteration over all ops if only one is attached)
> > - https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64-ftrace-call-ops-20221017
> >
> > And Masami wrote similar patches to what I had originally done to
> > fprobe in my branch:
> > - https://github.com/mhiramat/linux/commits/kprobes/fprobe-update
> >
> > So I could rebase my previous "bpf on fprobe" branch on top of these:
> > (as before, it's just good enough for benchmarking and to give a
> > general sense of the idea, not for a thorough code review):
> > - https://github.com/FlorentRevest/linux/commits/fprobe-min-args-3
> >
> > And I could run the benchmarks against my rpi4. I have different
> > baseline numbers as Xu so I ran everything again and tried to keep the
> > format the same. "indirect call" refers to my branch I just linked and
> > "direct call" refers to the series this is a reply to (Xu's work)
>
> Thanks for sharing the measurement results. Yes, fprobes/rethook
> implementation is just porting the kretprobes implementation, thus
> it may not be so optimized.
>
> BTW, I remember Wuqiang's patch for kretprobes.
>
> https://lore.kernel.org/all/20210830173324.32507-1-wuqiang.matt@bytedance.com/T/#u

Oh that's a great idea, thanks for pointing it out Masami!

> This is for the scalability fixing, but may possible to improve
> the performance a bit. It is not hard to port to the recent kernel.
> Can you try it too?

I rebased it on my branch
https://github.com/FlorentRevest/linux/commits/fprobe-min-args-3

And I got measurements again. Unfortunately it looks like this does not help :/

New benchmark results: https://paste.debian.net/1257856/
New perf report: https://paste.debian.net/1257859/

The fprobe based approach is still significantly slower than the
direct call approach.

> Anyway, eventually, I would like to remove the current kretprobe
> based implementation and unify fexit hook with function-graph
> tracer. It should make more better perfromance on it.

That makes sense. :) How do you imagine the unified solution ?
Would both the fgraph and fprobe APIs keep existing but under the hood
one would be implemented on the other ? (or would one be gone ?) Would
we replace the rethook freelist with the function graph's per-task
shadow stacks ? (or the other way around ?))

> > Note that I can't really make sense of the perf report with indirect
> > calls. it always reports it spent 12% of the time in
> > rethook_trampoline_handler but I verified with both a WARN in that
> > function and a breakpoint with a debugger, this function does *not*
> > get called when running this "bench trig-fentry" benchmark. Also it
> > wouldn't make sense for fprobe_handler to call it so I'm quite
> > confused why perf would report this call and such a long time spent
> > there. Anyone know what I could be missing here ?

I made slight progress on this. If I put the vmlinux file in the cwd
where I run perf report, the reports no longer contain references to
rethook_trampoline_handler. Instead, they have a few
0xffff800008xxxxxx addresses under fprobe_handler. (like in the
pastebin I just linked)

It's still pretty weird because that range is the vmalloc area on
arm64 and I don't understand why anything under fprobe_handler would
execute there. However, I'm also definitely sure that these 12% are
actually spent getting buffers from the rethook memory pool because if
I replace rethook_try_get and rethook_recycle calls with the usage of
a dummy static bss buffer (for the sake of benchmarking the
"theoretical best case scenario") these weird perf report traces are
gone and the 12% are saved. https://paste.debian.net/1257862/

This is why I would be interested in seeing rethook's memory pool
reimplemented on top of something like
https://lwn.net/Articles/788923/ If we get closer to the performance
of the the theoretical best case scenario where getting a blob of
memory is ~free (and I think it could be the case with a per task
shadow stack like fgraph's), then a bpf on fprobe implementation would
start to approach the performances of a direct called trampoline on
arm64: https://paste.debian.net/1257863/
