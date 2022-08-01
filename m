Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEC85873B0
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiHAWDA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiHAWC7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:02:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE1D3DBEF
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:02:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i13so15433951edj.11
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qGRAIo4IE+W9S0nxWZDufiR9kzlBtwcOAnoReRIyTHQ=;
        b=mgRZ54SjEJj1KTwED6fNRCj6SLlSvXByt4PN8fgrI28k5BZ8WAxXinz2wQZcjgbL1Z
         4qA0xhSUNuKBmc54BUjqY7kyWs0qHedX3hebo8vnLLR4RgokyOoko+jSDyQ4fxK12OrC
         uh+OVpjcuL2+iVEMAwAXfrx/aeaMW4yQ+L5pTUw06Q9scpnXEhDC67aKYobDyaiTHnbg
         Na1DVWfAZ6NS4qJo/yKOSpi+FtiVYF7gRZm5VhRXIv1m1iTKDQIJ5fLG6fCcpY6FmODZ
         PZONZ9LMr2mk4jWBa/OCnFPELQq+LCZZ9ThWnxeKaDvi2JJ9eR12G1wH6ZCVm2ZVltRl
         iAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qGRAIo4IE+W9S0nxWZDufiR9kzlBtwcOAnoReRIyTHQ=;
        b=Mf6xhHSPiaV08+Tl24ObAjrlJVRTXIodzhkIm7J/R1SBXafMUbGHl73QbH5CETwKMC
         IK7Pydqo/R4LN6R0mSAFGKzKZ9TFLjbatC5ibcRJnoQSUqBtfvJ1TpedcBljYGszhhCM
         K9Cu6V461C7IEbs425uIGrgdlf/BKBf8zzO2Z9J+cmrdi6Z4OMpnVu/XLNpleiu6WikL
         kHyD419m2pywPeKqgoP+xabqiGaeaDPHPnMY1vvsS7tkXuqlCEorh0es+7KraOzALYF0
         Q1cWDEXEUEniuQA8xpJDhll5oftWqa6LiteH4f1wg2wjPsyXnV+uORcNlANLDumu677V
         c2fg==
X-Gm-Message-State: ACgBeo39M/ug4BC/Ktm6bP8RE7rsK5Nbq/KDBQEu8SGDzi9R3hj7qp5R
        t9TvDn4+zBsfJn46xQkrNRWw7B5u0Et9uUvoU3o=
X-Google-Smtp-Source: AA6agR7zszloYwT41X3z7ADMXwmqb7FkRAB1hznQ6rICyGmyj1QvTI2yrCIVPTNxG6/3usTGFEwk1qSKIZTWo5+SXRk=
X-Received: by 2002:a50:ed82:0:b0:43d:5334:9d19 with SMTP id
 h2-20020a50ed82000000b0043d53349d19mr12134184edr.232.1659391377291; Mon, 01
 Aug 2022 15:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220724212146.383680-1-jolsa@kernel.org> <CAEf4Bzbrqrg-wuNNWNJ1GSQQzLOF7azzM8B17ti1TBz_D7irKg@mail.gmail.com>
 <YubvPcHwPrcc1CD0@krava>
In-Reply-To: <YubvPcHwPrcc1CD0@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Aug 2022 15:02:46 -0700
Message-ID: <CAEf4Bzbo+kT9sThxqjMkTM9xQ_AEE9Z2sckh8AwbS6Dq-J9fHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Fixes for CONFIG_X86_KERNEL_IBT
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 31, 2022 at 2:08 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Fri, Jul 29, 2022 at 03:18:54PM -0700, Andrii Nakryiko wrote:
> > On Sun, Jul 24, 2022 at 2:21 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > hi,
> > > Martynas reported bpf_get_func_ip returning +4 address when
> > > CONFIG_X86_KERNEL_IBT option is enabled and I found there are
> > > some failing bpf tests when this option is enabled.
> > >
> > > The CONFIG_X86_KERNEL_IBT option adds endbr instruction at the
> > > function entry, so the idea is to 'fix' entry ip for kprobe_multi
> > > and trampoline probes, because they are placed on the function
> > > entry.
> > >
> > > For kprobes I only fixed the bpf test program to adjust ip based
> > > on CONFIG_X86_KERNEL_IBT option. I'm not sure what the right fix
> > > should be in here, because I think user should be aware where the
> >
> > user can't be aware of this when using multi-kprobe attach by symbolic
> > name of the function. So I think bpf_get_func_ip() at least in that
> > case should be compensating for KERNEL_IBT.
>
> sorry I said kprobes, but that does not include kprobe multi link,
> I meant what you call general kprobe below
>
> I do the adjustment for kprobe multi version of bpf_get_func_ip,
> so that should be fine

I'd strive for multi-kprobe and kprobe to not have such differences,
at least for common function entry (which also means kretprobe, btw)
case. Ideally multi-kprobe is just a more efficient (in terms of
mass-attachment) version of kprobe with no difference in BPF helpers.

So yeah, I totally support your idea of handling that in a helper.

>
> >
> > BTW, given in general kprobe can be placed in them middle of the
> > function, should bpf_get_func_ip() return zero or something for such
> > cases instead of wrong value somewhere in the middle of kprobe? If
> > user cares about current IP, they can get it with PT_REGS_IP(ctx),
> > right?
>
> true.. we could add flag to 'struct kprobe' to indicate it's placed
> on function's entry and check on endbr instruction for IBT config,
> and return 0 for anything else
>
> jirka
>
> > > kprobe is placed, on the other hand we move the kprobe address if
> > > its placed on top of endbr instruction.
> > >
> > > v1 changes:
> > >   - read previous instruction in kprobe_multi link handler
> > >     and adjust entry_ip for CONFIG_X86_KERNEL_IBT option
> > >   - split first patch into 2 separate changes
> > >   - update changelogs
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > ---
> > > Jiri Olsa (5):
> > >       ftrace: Keep the resolved addr in kallsyms_callback
> > >       bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
> > >       bpf: Use given function address for trampoline ip arg
> > >       selftests/bpf: Disable kprobe attach test with offset for CONFIG_X86_KERNEL_IBT
> > >       selftests/bpf: Fix kprobe get_func_ip tests for CONFIG_X86_KERNEL_IBT
> > >
> > >  arch/x86/net/bpf_jit_comp.c                               |  9 ++++-----
> > >  kernel/trace/bpf_trace.c                                  |  4 ++++
> > >  kernel/trace/ftrace.c                                     |  3 +--
> > >  tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c | 25 ++++++++++++++++++++-----
> > >  tools/testing/selftests/bpf/progs/get_func_ip_test.c      |  7 +++++--
> > >  tools/testing/selftests/bpf/progs/kprobe_multi.c          |  2 +-
> > >  6 files changed, 35 insertions(+), 15 deletions(-)
