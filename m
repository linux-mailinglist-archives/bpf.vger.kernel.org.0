Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BDB586185
	for <lists+bpf@lfdr.de>; Sun, 31 Jul 2022 23:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiGaVIU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 17:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiGaVIT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 17:08:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019CBDF59
        for <bpf@vger.kernel.org>; Sun, 31 Jul 2022 14:08:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f22so538857edc.7
        for <bpf@vger.kernel.org>; Sun, 31 Jul 2022 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=VqQ4sb4V9J76T+WwHKPB5LfSBOfTPlzm3qwF/bhChPs=;
        b=N52d6wWRtHsKpHCZfO9l+mSihzqN/RVKlJacb4TkB4Cy7l5S+BMrmtzAZShGuknKzf
         ACgb3X4ECIblAwRIHJehORfeVbLaYWu0RdYbZ2zVTGURfp097z9cEe/RSeztu/X8TOlM
         89LSSAEAgWjAygvNCfcB+9RGwxGlYwTtFiY03hwuHLJJPKbcGLWyXOLnEAJ5P6tpEk0I
         3CUawqBUaIDLEa5BZaZck59GSARDX83+1tOUqFT57r9HWXCqSrpDK1KQUAApan3nYUnS
         4olxWbATbRKaWTITasWRQeLw4HHHkJGVgu+IJ1ptfMkhZ0Vno454/xnpLbOLq6SpUjN3
         H21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=VqQ4sb4V9J76T+WwHKPB5LfSBOfTPlzm3qwF/bhChPs=;
        b=bkgG8eLipek54lJNcLHJAiQ59466qEQcpqyu40LgZOBsXKIkbf/liwVv3c+h3V8Yh3
         82cgnga+Zbc4bJn+L1oQ+mHH0+DyS5V14A+bKzUqpb8fTqUtpbKXZp7cGckvkUOcoAEp
         77koDSxHcYV1qysKwjNw1hjQWiU7kwNQrtTONYxQzDbXuIH0hOfwl73KkigLkkiYx0NO
         ZBAt8ILPV/CysNOBJSrAu0ECcYVTodhDMwBWVVbI3PCcl0UpTR27h9SBqXIPI5Qx8m8d
         0HPwnvMDERWOJkPzIlIdDmhGFRRxu2Kp26/5swPFvteePXBU6E3TJeDqJE5+fPi97sXN
         NUHg==
X-Gm-Message-State: AJIora+sOPPIphbfIX+PEUR2zL7OzTW7cpbMOe+XXeqF0ZDguIr8Io+9
        IdVfyZR5QbdLEZjQTVlMkOk=
X-Google-Smtp-Source: AGRyM1tGBHVq3VupnSVGsPikAOwRM5rHkicbaqKtlGAqNrDQKNQ6vO+faasFi0n4cbf2TXTM6KIKog==
X-Received: by 2002:a05:6402:5412:b0:435:5997:ccb5 with SMTP id ev18-20020a056402541200b004355997ccb5mr12326355edb.167.1659301696576;
        Sun, 31 Jul 2022 14:08:16 -0700 (PDT)
Received: from krava ([83.240.61.175])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090653c600b007307c557e31sm769942ejo.106.2022.07.31.14.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 14:08:16 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 31 Jul 2022 23:08:13 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH bpf-next 0/5] bpf: Fixes for CONFIG_X86_KERNEL_IBT
Message-ID: <YubvPcHwPrcc1CD0@krava>
References: <20220724212146.383680-1-jolsa@kernel.org>
 <CAEf4Bzbrqrg-wuNNWNJ1GSQQzLOF7azzM8B17ti1TBz_D7irKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbrqrg-wuNNWNJ1GSQQzLOF7azzM8B17ti1TBz_D7irKg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 29, 2022 at 03:18:54PM -0700, Andrii Nakryiko wrote:
> On Sun, Jul 24, 2022 at 2:21 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > Martynas reported bpf_get_func_ip returning +4 address when
> > CONFIG_X86_KERNEL_IBT option is enabled and I found there are
> > some failing bpf tests when this option is enabled.
> >
> > The CONFIG_X86_KERNEL_IBT option adds endbr instruction at the
> > function entry, so the idea is to 'fix' entry ip for kprobe_multi
> > and trampoline probes, because they are placed on the function
> > entry.
> >
> > For kprobes I only fixed the bpf test program to adjust ip based
> > on CONFIG_X86_KERNEL_IBT option. I'm not sure what the right fix
> > should be in here, because I think user should be aware where the
> 
> user can't be aware of this when using multi-kprobe attach by symbolic
> name of the function. So I think bpf_get_func_ip() at least in that
> case should be compensating for KERNEL_IBT.

sorry I said kprobes, but that does not include kprobe multi link,
I meant what you call general kprobe below

I do the adjustment for kprobe multi version of bpf_get_func_ip,
so that should be fine

> 
> BTW, given in general kprobe can be placed in them middle of the
> function, should bpf_get_func_ip() return zero or something for such
> cases instead of wrong value somewhere in the middle of kprobe? If
> user cares about current IP, they can get it with PT_REGS_IP(ctx),
> right?

true.. we could add flag to 'struct kprobe' to indicate it's placed
on function's entry and check on endbr instruction for IBT config,
and return 0 for anything else

jirka

> > kprobe is placed, on the other hand we move the kprobe address if
> > its placed on top of endbr instruction.
> >
> > v1 changes:
> >   - read previous instruction in kprobe_multi link handler
> >     and adjust entry_ip for CONFIG_X86_KERNEL_IBT option
> >   - split first patch into 2 separate changes
> >   - update changelogs
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > Jiri Olsa (5):
> >       ftrace: Keep the resolved addr in kallsyms_callback
> >       bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
> >       bpf: Use given function address for trampoline ip arg
> >       selftests/bpf: Disable kprobe attach test with offset for CONFIG_X86_KERNEL_IBT
> >       selftests/bpf: Fix kprobe get_func_ip tests for CONFIG_X86_KERNEL_IBT
> >
> >  arch/x86/net/bpf_jit_comp.c                               |  9 ++++-----
> >  kernel/trace/bpf_trace.c                                  |  4 ++++
> >  kernel/trace/ftrace.c                                     |  3 +--
> >  tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c | 25 ++++++++++++++++++++-----
> >  tools/testing/selftests/bpf/progs/get_func_ip_test.c      |  7 +++++--
> >  tools/testing/selftests/bpf/progs/kprobe_multi.c          |  2 +-
> >  6 files changed, 35 insertions(+), 15 deletions(-)
