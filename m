Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D902598EA7
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346435AbiHRVCD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346336AbiHRVA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 17:00:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED1BD3ECE;
        Thu, 18 Aug 2022 14:00:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a7so5472747ejp.2;
        Thu, 18 Aug 2022 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=A32HPAP5Od3KT+F9QIsj7jmUdN0RqSZ7BrLG62V5DEQ=;
        b=EiftZ2/VM3oMS8+3i8v5hmQJ7gd+jj9Nf4+FG1BUSy1bOtagUF0gdo7NXGpTDkTiV4
         krvqNoexSpttqYfC2DiaUJbkZiavbyqRJWAwcwjAvcGuNBGgSlpQfJ96GtYq81176VNh
         zty2bVEkWJyGMMt6MxgqI4tJXq0/mkCnlHQlTnECgC5C0OHS4zbw7JE6BE2/HzkcKSRj
         oLKKYFMwEFlk1p2K9MQ7ebeEqci6tLIgJ3LgPDKDrUG1/82fMnvJ9TiEHgTs4DCvVoii
         /mLKKcEFlJhRRLEknCVTDHajSGUZJ58XWqj0GCdgTK3r9CmhEjrfVsupepMKXI+i6rW6
         BFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=A32HPAP5Od3KT+F9QIsj7jmUdN0RqSZ7BrLG62V5DEQ=;
        b=aTDtIBxeRSKRa7oa6Idj+1w+FMOgQ0sAS8+g9rQwEzMY0VRY2iqobB1jX/PAjcs+hM
         VBhDgq6RlYIy62BjuUsfSEO6/DAVJ3XWIn1seqzQyNK7n1qa9N49Zn4UqdWWVUAN6Wtq
         hdNWPGY8uFogtx0t8JtbvSeaAe53Oa2oho0p4l5v4TYojp4Ir4eZ9pm+PrEyl5/I+yIh
         gL1C7mxBT2eQHjpT3gz8m3dNOfbfMlSJGsvGIgTXhEBU//0cjJKX1LsNku3BvmYfaI86
         AcyyC4Z88l7i6uQAK6kO53c2K0vbJ/B+BoxJc6ccFGg20YLij7TfZQ67NwMM7iiOuYXa
         OgYw==
X-Gm-Message-State: ACgBeo3ip/55BczYjCnw1ik/8uHWb7k6zzDjsuONvXHW3HrULQfETVTJ
        X+LoQBlmr2jRVqoVDrU1rN45bZZAM1rQgL5pn+LooIrPy/k=
X-Google-Smtp-Source: AA6agR7aQiGzTiYfENEZTzgyWjIg+8U1NkzkYo7M9PDX9EYfCqoeF8HY7s/XnhGCss7xqrObq8l/Ir8cbgHuZaJKfDk=
X-Received: by 2002:a17:906:a089:b0:72f:826b:e084 with SMTP id
 q9-20020a170906a08900b0072f826be084mr3061943ejy.708.1660856432758; Thu, 18
 Aug 2022 14:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net>
 <YvoVgMzMuQbAEayk@krava> <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
 <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
 <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net> <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net> <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net> <YvppJ7TjMXD3cSdZ@worktop.programming.kicks-ass.net>
 <Yv6gm09CMdZ/HMr5@krava> <20220818165024.433f56fd@gandalf.local.home>
In-Reply-To: <20220818165024.433f56fd@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 18 Aug 2022 14:00:21 -0700
Message-ID: <CAADnVQ+n=x=CuBk23UNnD9CHVXjrXLUofbockh-SWaLwH3H9fw@mail.gmail.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Thu, Aug 18, 2022 at 1:50 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 18 Aug 2022 22:27:07 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
>
> > ok, so the problem with __attribute__((patchable_function_entry(5))) is that
> > it puts function address into __patchable_function_entries section, which is
> > one of ftrace locations source:
> >
> >   #define MCOUNT_REC()    . = ALIGN(8);     \
> >     __start_mcount_loc = .;                 \
> >     KEEP(*(__mcount_loc))                   \
> >     KEEP(*(__patchable_function_entries))   \
> >     __stop_mcount_loc = .;                  \
> >    ...
> >
> >
> > it looks like __patchable_function_entries is used for other than x86 archs,
> > so we perhaps we could have x86 specific MCOUNT_REC macro just with
> > __mcount_loc section?
>
> So something like this:
>
> #ifdef CONFIG_X86
> # define NON_MCOUNT_PATCHABLE KEEP(*(__patchable_function_entries))
> # define MCOUNT_PATCHABLE
> #else
> # define NON_MCOUNT_PATCHABLE
> # define MCOUNT_PATCHABLE  KEEP(*(__patchable_function_entries))
> #endif
>
>   #define MCOUNT_REC()    . = ALIGN(8);     \
>     __start_mcount_loc = .;                 \
>     KEEP(*(__mcount_loc))                   \
>     MCOUNT_PATCHABLE                        \
>     __stop_mcount_loc = .;                  \
>     NON_MCOUNT_PATCHABLE                    \
>    ...
>
> ??

That's what more or less Peter's patch is doing:
Here it is again for reference:
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=8d075bdf11193f1d276bf19fa56b4b8dfe24df9e
