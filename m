Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA99D575C9C
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 09:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiGOHpm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 03:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGOHpl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 03:45:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7054976E87
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 00:45:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y8so5265732eda.3
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 00:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9+Ucx57weP/RdugWAhxdjLOeZIW6tozYKThqxG6kIxs=;
        b=gsT/PU0lIAyde9nK23uotfB35nXOhbAXXWBn3nZ6M2xjSB0ksNj+CQM4i2Y4mXoq4U
         S/aUadgMZXm1mUXMaw/QfT9uLILsR5q0UybnsAX3Rx59GcxWVOaw0E2c8sz8eqCIkPZD
         dSUpULkIkNSuhg1ujEkCxq492o8LFgCAvmhEi73cL2+1Tk1BYDu56mQq0MtmkO978I+W
         q3c0ziezzYf5KF/hf24Nyo03NkFoJsVazoZlCGbdp7OKZYuPQYQj5wBHYggD/19tFHcY
         onGJZH6YCz6NYrq8YjLRxVchYGkLcW3a/2nxAZTsrnZlL9Rj6yBCrKwyB/nI73y61uYL
         9JQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9+Ucx57weP/RdugWAhxdjLOeZIW6tozYKThqxG6kIxs=;
        b=HKUzCDzCIqtSor8ZIDigSDa/w7j89NXpretMDREK0yv83ZDTlrd1pBkIvngMZCyZhx
         wq2K8Ewavqf5dsn5fbwwfw1/Ztred34RnbeHzRlo6Pi0iHQiML4X9c6UPJ0Xb0AoL5rg
         AOM4A0CLTc1RUCTm4du06K/co4BXTaTfEhYsQO8mFfVhmGop9JAIn9mapsKr4v+Fqp+f
         afr/x9uom1zZ1Hp3l8oW2jDWxbjP0QXPda/05/OjlLs6UtuDuw0qASZQ3eqsf9IdQd7e
         qROjYmVuDoNU518lS960Sdrni/sGg24bneBOaX7D7Pmk2JTjKavYKVI1g4nq3opnVet6
         2Opg==
X-Gm-Message-State: AJIora9rDHEqrEheFsASvKbeAVFrMeHOCdy6O/MgnJ+cD8cIzGdXuPPA
        ix5IwsGy+QVm3F64lslrxsc=
X-Google-Smtp-Source: AGRyM1vxc9V46EIkePDq4LvF8fmT4iwCQdYSPeQK1pcUNub6/4TmHZ6dP9pLbJ3YkkO7GyKQ2pKlyQ==
X-Received: by 2002:a05:6402:c48:b0:437:d938:9691 with SMTP id cs8-20020a0564020c4800b00437d9389691mr16978612edb.254.1657871138927;
        Fri, 15 Jul 2022 00:45:38 -0700 (PDT)
Received: from krava (net-37-179-156-241.cust.vodafonedsl.it. [37.179.156.241])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090632d000b0072b2cb1e22csm1685430ejk.104.2022.07.15.00.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 00:45:38 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 15 Jul 2022 09:45:35 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: Do not attach kprobe_multi bench to
 bpf_dispatcher_xdp_func
Message-ID: <YtEbHxNWVW9yUJqR@krava>
References: <20220714082316.479181-1-jolsa@kernel.org>
 <444b10eb-506a-583f-82f1-9c8ca4539542@fb.com>
 <CAEf4BzbOUQgzRt-nb9n-pfAJY48i60yc=rKT-4JE+7X_W3kx0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbOUQgzRt-nb9n-pfAJY48i60yc=rKT-4JE+7X_W3kx0A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 10:36:07PM -0700, Andrii Nakryiko wrote:
> On Thu, Jul 14, 2022 at 1:01 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 7/14/22 1:23 AM, Jiri Olsa wrote:
> > > Alexei reported crash by running test_progs -j on system
> > > with 32 cpus.
> > >
> > > It turned out the kprobe_multi bench test that attaches all
> > > ftrace-able functions will race with bpf_dispatcher_update,
> > > that calls bpf_arch_text_poke on bpf_dispatcher_xdp_func,
> > > which is ftrace-able function.
> > >
> > > Ftrace is not aware of this update so this will cause
> > > ftrace_bug with:
> > >
> > >    WARNING: CPU: 6 PID: 1985 at
> > >    arch/x86/kernel/ftrace.c:94 ftrace_verify_code+0x27/0x50
> > >    ...
> > >    ftrace_replace_code+0xa3/0x170
> > >    ftrace_modify_all_code+0xbd/0x150
> > >    ftrace_startup_enable+0x3f/0x50
> > >    ftrace_startup+0x98/0xf0
> > >    register_ftrace_function+0x20/0x60
> > >    register_fprobe_ips+0xbb/0xd0
> > >    bpf_kprobe_multi_link_attach+0x179/0x430
> > >    __sys_bpf+0x18a1/0x2440
> > >    ...
> > >    ------------[ ftrace bug ]------------
> > >    ftrace failed to modify
> > >    [<ffffffff818d9380>] bpf_dispatcher_xdp_func+0x0/0x10
> > >     actual:   ffffffe9:7b:ffffff9c:77:1e
> > >    Setting ftrace call site to call ftrace function
> > >
> > > It looks like we need some way to way to hide some functions
> >
> > need some way to hide some functions ...
> >
> > > from ftrace, but meanwhile we workaround this by skipping
> > > bpf_dispatcher_xdp_func from kprobe_multi bench test.
> > >
> > > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >
> > I tried with 32cpus on my local qemu/vm but cannot reproduce the crash.
> > But look at the code, your should seem okay as bpf_dispatcher_xdp_func
> > indeed could be poked and simplified. So with a few nits,
> >
> > Acked-by: Yonghong Song <yhs@fb.com>
> >
> 
> Fixed typo and changed strncmp to strcmp, pushed to bpf-next.

thanks,
jirka

> 
> > > ---
> > >   tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > > index 5b93d5d0bd93..8c442051f312 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > > @@ -364,6 +364,8 @@ static int get_syms(char ***symsp, size_t *cntp)
> > >                       continue;
> > >               if (!strncmp(name, "rcu_", 4))
> > >                       continue;
> > > +             if (!strncmp(name, "bpf_dispatcher_xdp_func", 23))
> >
> > ffffffff81b17a90 T bpf_dispatcher_xdp_func
> >
> > bpf_dispatcher_xdp_func is a full name, you can just use strcmp here.
> > Further,
> >
> > linux/bpf.h:#define BPF_DISPATCHER_FUNC(name) bpf_dispatcher_##name##_func
> >
> > Currently, bpf_dispatcher_xdp_func is the ONLY BPF_DISPATCHER_FUNC.
> > So comparing bpf_dispatcher_xdp_func is enough. It would be good
> > to add a comment to explain why not comparing to bpf_dispatcher_*_func.
> >
> > > +                     continue;
> > >               if (!strncmp(name, "__ftrace_invalid_address__",
> > >                            sizeof("__ftrace_invalid_address__") - 1))
> > >                       continue;
