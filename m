Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD3B575C89
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 09:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiGOHll (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 03:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGOHlk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 03:41:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479D07C19C
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 00:41:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sz17so7514090ejc.9
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 00:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Y5nVI+iA9dem0ueMlmUye25tYXNBKiDnfgA+EVt2qk=;
        b=qTr5OumdK7JXicUJMCok6ACjn0rE0ULDnctPz9iG2iSLyRatBcK2HsL6hgp1NXrDZQ
         miGW4EINlDwDtfetQw9ETkI2Pam4E9w3XqABVDYRGwUpaSs3RtSwjKgr4m5B10sOo5/6
         ljqo4dnDKsYwfUY/B57A5NZfVIf0QQQQGT9jjsYTXxFv3+hlhbKVG6Il0V0cWLvc13xO
         wwM6KZ+KBqMZ/6s1zt20nAXZ16c6Jk8f6WL00tx6XkjQdHvhK8xc1gp95wY95i2gKUwA
         QzWqdV5GWv5ustbdZakVr7zaMzjPvv2xLDsRJh1ci/AL25O8IkEGHA0f1b6zs4bYby9Z
         A7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Y5nVI+iA9dem0ueMlmUye25tYXNBKiDnfgA+EVt2qk=;
        b=v4LzEO6kmSeT0stjP99Qoe1mm91aBK1TKeVKCL+HVfWKnoS4GtsqHcd0N8AMS8i71Z
         DbZo00jzsgT+CZXBygViPy1/1qGvT5/OF2NTJo9rnsN8AoE54kaQBeLZ6CNG4EiGv+s6
         NqV9UTtO8QEWmptzZQuJR3TZzVcVomqKAHqKPasybEB4BUiMk/odFisdZ9nnch+e66dh
         cOZWtLf7WwxpZhQxZbddectzh+c8iag13CIhDgJqcVIuRh90R6JFBaNmK6gBjnpvJx2L
         b6HEqA7/NvBAFwclLfSJ+jlxOBqY+E+728oCMFafhDHhx5P5VDEUOd9Qp09PLigW4Qjn
         wFGA==
X-Gm-Message-State: AJIora8k637SueFUiFrsq7+SiVQADe+R8mc0tTmLCY6YJQsRP7puEGxo
        yptFilU/lDgoUi2NBHoZ0RU=
X-Google-Smtp-Source: AGRyM1thQilNUo5kfLK1TvZxgnxu3+R/WkJQHtEzFrSF0shRXV6y3K2WLvPMvb6W7fKPeGLXU/YZYw==
X-Received: by 2002:a17:906:216:b0:711:f623:8bb0 with SMTP id 22-20020a170906021600b00711f6238bb0mr12842647ejd.174.1657870897644;
        Fri, 15 Jul 2022 00:41:37 -0700 (PDT)
Received: from krava (net-37-179-156-241.cust.vodafonedsl.it. [37.179.156.241])
        by smtp.gmail.com with ESMTPSA id p5-20020a170906b20500b0072af4af2f46sm1693257ejz.74.2022.07.15.00.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 00:41:36 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 15 Jul 2022 09:41:33 +0200
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: Do not attach kprobe_multi bench to
 bpf_dispatcher_xdp_func
Message-ID: <YtEaLf8j2DcIkU+o@krava>
References: <20220714082316.479181-1-jolsa@kernel.org>
 <CAKH8qBu+sNi8_004Hfz7rff14UfS0Js20ogLPGUfnxs7WfqMXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBu+sNi8_004Hfz7rff14UfS0Js20ogLPGUfnxs7WfqMXw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 09:59:38AM -0700, Stanislav Fomichev wrote:
> On Thu, Jul 14, 2022 at 1:23 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
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
> >   WARNING: CPU: 6 PID: 1985 at
> >   arch/x86/kernel/ftrace.c:94 ftrace_verify_code+0x27/0x50
> >   ...
> >   ftrace_replace_code+0xa3/0x170
> >   ftrace_modify_all_code+0xbd/0x150
> >   ftrace_startup_enable+0x3f/0x50
> >   ftrace_startup+0x98/0xf0
> >   register_ftrace_function+0x20/0x60
> >   register_fprobe_ips+0xbb/0xd0
> >   bpf_kprobe_multi_link_attach+0x179/0x430
> >   __sys_bpf+0x18a1/0x2440
> >   ...
> >   ------------[ ftrace bug ]------------
> >   ftrace failed to modify
> >   [<ffffffff818d9380>] bpf_dispatcher_xdp_func+0x0/0x10
> >    actual:   ffffffe9:7b:ffffff9c:77:1e
> >   Setting ftrace call site to call ftrace function
> >
> > It looks like we need some way to way to hide some functions
> > from ftrace, but meanwhile we workaround this by skipping
> > bpf_dispatcher_xdp_func from kprobe_multi bench test.
> 
> Tangential: I've seen the same happen on our internal kernel, I
> thought it's just due to our older ftrace subtree, but now looking at
> the bpf-next tree I'm not sure. Maybe you can clarify for me?
> 
> I think what happens is: we attach a bpf program that uses text_poke
> and enable ftrace graph and ftrace fails with the same
> ftrace_verify_code.
> I see that on the bpf side, we try to play nicely and use text_poke or
> modify_ftrace_direct if the location is ftrace-managed, but I don't
> see something similar on the ftrace side?

so ftrace keeps track of all the ftrace-able locations and assumes
it's the only one that changes them, so when you change some of them
with text_poke ftrace won't see expected value there and will think
it's a bug

> How is it supposed to work? Do we have some way to signal to ftrace
> that we've text_poke'd the location and ftrace shouldn't try to touch
> it?

we discussed to have a way to exclude some functions from ftrace,
starting with bpf_dispatcher_xdp_func, I'll send some rfc to start
discussion

jirka

> 
> 
> 
> > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > index 5b93d5d0bd93..8c442051f312 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > @@ -364,6 +364,8 @@ static int get_syms(char ***symsp, size_t *cntp)
> >                         continue;
> >                 if (!strncmp(name, "rcu_", 4))
> >                         continue;
> > +               if (!strncmp(name, "bpf_dispatcher_xdp_func", 23))
> > +                       continue;
> >                 if (!strncmp(name, "__ftrace_invalid_address__",
> >                              sizeof("__ftrace_invalid_address__") - 1))
> >                         continue;
> > --
> > 2.35.3
> >
