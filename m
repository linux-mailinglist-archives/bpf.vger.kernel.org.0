Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEBF575B0D
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 07:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiGOFgq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 01:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOFgW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 01:36:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07DC7A50D
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:36:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e15so4964990edj.2
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfbp+5LnKYpclL1gGCzKeL0peYZpo+Za+xcy9QD8oN4=;
        b=Phsk3khk7XYX0T2UWHF0hNC1GsXO4P1qVg8PC5pnIBdA/Gg2HOZ7cxbEnz18iTHHy1
         qD7kot0bRjOGfzgQg4RQEKaCprxKh6FIdmmhcWfoUV448T++S7Exoa08L5aIl70fWSqQ
         8dFHwyWB6v5IlvYTb/MKOdhJaRuyOaQVqjmDRGaVo7tVnPXV/AclwGJVOrMJIYPbsD8n
         XmKHRRDbme1lVPF28ueppsC42bZMy2iFH+aVtMd4oRDNuNVz1kvLZeCbGz0O5JM8kTjG
         4JvasZTXKQL3EpTB7hevLzt2UHvVR1F1Os30tXQ12ltwQyHBL1imZcEHEzoem2KlA7WS
         daVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfbp+5LnKYpclL1gGCzKeL0peYZpo+Za+xcy9QD8oN4=;
        b=x2a8wZwwl8fTqy9DFl/N1fXmSU2UQ1nioQunR8NIYwc9Q3oeT0pv8y6PYiTXGw0DFg
         LQrV0hOVSeYDOZ1mYJ3Im9uXkt2zMjx1Jd1bW9SllfvTyJ5gdzHUjf9aZL87H1w/M8w1
         2sf+z/cyxLKDV9zcaYdakNXwnw4TtX+wVYG0NaPumMY+5WMPDqXRGDjs/elP6w40cRiY
         Q5LL8N4WFqVPknLKZV0A+HfsHVOza8UslLhBPo9khxZASj+6uVpAt7rjHuHGZFixe/zI
         KLIiAP5ydD2lgZ8YvQ0VLim2lm6ekI9bkTLjxPiJMdHPo3MMXws3xbUH6ALd0uB74isc
         grMg==
X-Gm-Message-State: AJIora9Z+iagRNSRxGc1d4IEEm4Fn8Mo70htQXsf3fejqnpPu0J2/DBF
        dWly0qKBFxOdTsNlEt1akdXEsOh6jg43RiqN1tc=
X-Google-Smtp-Source: AGRyM1vhT3Hwl7JCNohF0IoIFz6eCEcg+sk8mxG19clbX3RiDzccSQ98yY3IHZgzyBIRmUf3PdNjoQmQbUiWvsEdRIk=
X-Received: by 2002:a05:6402:c92:b0:43a:7177:5be7 with SMTP id
 cm18-20020a0564020c9200b0043a71775be7mr16789095edb.224.1657863379442; Thu, 14
 Jul 2022 22:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220714082316.479181-1-jolsa@kernel.org> <444b10eb-506a-583f-82f1-9c8ca4539542@fb.com>
In-Reply-To: <444b10eb-506a-583f-82f1-9c8ca4539542@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Jul 2022 22:36:07 -0700
Message-ID: <CAEf4BzbOUQgzRt-nb9n-pfAJY48i60yc=rKT-4JE+7X_W3kx0A@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Do not attach kprobe_multi bench to bpf_dispatcher_xdp_func
To:     Yonghong Song <yhs@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
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

On Thu, Jul 14, 2022 at 1:01 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/14/22 1:23 AM, Jiri Olsa wrote:
> > Alexei reported crash by running test_progs -j on system
> > with 32 cpus.
> >
> > It turned out the kprobe_multi bench test that attaches all
> > ftrace-able functions will race with bpf_dispatcher_update,
> > that calls bpf_arch_text_poke on bpf_dispatcher_xdp_func,
> > which is ftrace-able function.
> >
> > Ftrace is not aware of this update so this will cause
> > ftrace_bug with:
> >
> >    WARNING: CPU: 6 PID: 1985 at
> >    arch/x86/kernel/ftrace.c:94 ftrace_verify_code+0x27/0x50
> >    ...
> >    ftrace_replace_code+0xa3/0x170
> >    ftrace_modify_all_code+0xbd/0x150
> >    ftrace_startup_enable+0x3f/0x50
> >    ftrace_startup+0x98/0xf0
> >    register_ftrace_function+0x20/0x60
> >    register_fprobe_ips+0xbb/0xd0
> >    bpf_kprobe_multi_link_attach+0x179/0x430
> >    __sys_bpf+0x18a1/0x2440
> >    ...
> >    ------------[ ftrace bug ]------------
> >    ftrace failed to modify
> >    [<ffffffff818d9380>] bpf_dispatcher_xdp_func+0x0/0x10
> >     actual:   ffffffe9:7b:ffffff9c:77:1e
> >    Setting ftrace call site to call ftrace function
> >
> > It looks like we need some way to way to hide some functions
>
> need some way to hide some functions ...
>
> > from ftrace, but meanwhile we workaround this by skipping
> > bpf_dispatcher_xdp_func from kprobe_multi bench test.
> >
> > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>
> I tried with 32cpus on my local qemu/vm but cannot reproduce the crash.
> But look at the code, your should seem okay as bpf_dispatcher_xdp_func
> indeed could be poked and simplified. So with a few nits,
>
> Acked-by: Yonghong Song <yhs@fb.com>
>

Fixed typo and changed strncmp to strcmp, pushed to bpf-next.

> > ---
> >   tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > index 5b93d5d0bd93..8c442051f312 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > @@ -364,6 +364,8 @@ static int get_syms(char ***symsp, size_t *cntp)
> >                       continue;
> >               if (!strncmp(name, "rcu_", 4))
> >                       continue;
> > +             if (!strncmp(name, "bpf_dispatcher_xdp_func", 23))
>
> ffffffff81b17a90 T bpf_dispatcher_xdp_func
>
> bpf_dispatcher_xdp_func is a full name, you can just use strcmp here.
> Further,
>
> linux/bpf.h:#define BPF_DISPATCHER_FUNC(name) bpf_dispatcher_##name##_func
>
> Currently, bpf_dispatcher_xdp_func is the ONLY BPF_DISPATCHER_FUNC.
> So comparing bpf_dispatcher_xdp_func is enough. It would be good
> to add a comment to explain why not comparing to bpf_dispatcher_*_func.
>
> > +                     continue;
> >               if (!strncmp(name, "__ftrace_invalid_address__",
> >                            sizeof("__ftrace_invalid_address__") - 1))
> >                       continue;
