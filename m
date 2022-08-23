Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E62159EBA1
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 20:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiHWS5W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 14:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiHWS5F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 14:57:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6666EF30;
        Tue, 23 Aug 2022 10:25:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ce26so13074213ejb.11;
        Tue, 23 Aug 2022 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=s5YL+cREap/8qMQrXcLy0WIJHLLNBWOlnWc9n2wcNzY=;
        b=kmIYwPupPRJOHeVk+r/U7RsD9Kta5Gv7p8v8U907Rj3NJPy+SHmJvAwKbpkqEYmY5w
         +Jkz0fD3ADZMmf/XdBES5TNDQmLhrCA+CHlRM8ZZQLu3v/tWJo02J5etjxue0yUfoBYi
         ubWw3fi62Iu0+Vq2Yn14OSmy1YHvXwrO/s5DhMNhxvs7tNyV4sYl6SYJ+m3C1/DvUnJT
         FiuQgcRyT8uMK2w3lHX83eSBIEnD5XPygnrQRRHiJfyE0u2SDxFyINEDa9a+Pg9u2lVk
         YI/Y8PFOnuhkYUzGBGYDY+7QcfIw06hFf2iAQ6/pr/Avyy5eo9LfVfIIG34rCwtLt4gB
         BKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=s5YL+cREap/8qMQrXcLy0WIJHLLNBWOlnWc9n2wcNzY=;
        b=B2RUWkWGLH1Pt0vpRI97Hpr4OwVkVUp2HQJUbuJJsb8cwj2+B+xOiumM9TM7OzuBlE
         zz5AUoZeyg2cdugeq2Ncppw56KD52cehBgRTibNBzMTEyXhZpBV1iy41F25/3soH8jTB
         1awgAU4B1FCG/1ynXJQlNUYzSw8FLN4sVrTMprdklFNi9Xp73FFLUxnjeZysjBhk31Wp
         0lYO+3v/iBApn3NkROM/BQg9g/jJRYXdiDhoeCT3CzzqRUJhqAsrAN/Lw9YJIEUu0fug
         E3mvMFir5AOJve5exQVYOt0kSQnev3ozwtl12CFVlMXFDi8w319INRY5Gkosaw6EQV+E
         yDog==
X-Gm-Message-State: ACgBeo0hoAvLxORWNfTYdmlnZlgv3QKAV0p8Ug9Z7lUo1LD0qThB3y/f
        wggO7F+XTA3Ikg1wdNpO+RpuU/6ithOmN2BkUtQb3soi
X-Google-Smtp-Source: AA6agR4o7uLBEYQ+8Tu/6E+ARNhyulOVliiRmEbULZnSN9c18L/jtJ2vM9z4Oi4fM6LRPppZnxRAx53qhxWF16OwQFA=
X-Received: by 2002:a17:907:2896:b0:730:983c:4621 with SMTP id
 em22-20020a170907289600b00730983c4621mr420949ejc.502.1661275415564; Tue, 23
 Aug 2022 10:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
 <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net> <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net> <YvppJ7TjMXD3cSdZ@worktop.programming.kicks-ass.net>
 <Yv6gm09CMdZ/HMr5@krava> <20220818165024.433f56fd@gandalf.local.home>
 <CAADnVQ+n=x=CuBk23UNnD9CHVXjrXLUofbockh-SWaLwH3H9fw@mail.gmail.com>
 <Yv6wB4El4iueJtwX@krava> <Yv933mq/DTIz5g7q@krava>
In-Reply-To: <Yv933mq/DTIz5g7q@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 23 Aug 2022 10:23:24 -0700
Message-ID: <CAADnVQK=kbCRuj9ZF9oV0YGf0pN-am3vFXYBMQ6m2ze5--nqtQ@mail.gmail.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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

On Fri, Aug 19, 2022 at 4:45 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Aug 18, 2022 at 11:32:55PM +0200, Jiri Olsa wrote:
> > On Thu, Aug 18, 2022 at 02:00:21PM -0700, Alexei Starovoitov wrote:
> > > On Thu, Aug 18, 2022 at 1:50 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Thu, 18 Aug 2022 22:27:07 +0200
> > > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > > ok, so the problem with __attribute__((patchable_function_entry(5))) is that
> > > > > it puts function address into __patchable_function_entries section, which is
> > > > > one of ftrace locations source:
> > > > >
> > > > >   #define MCOUNT_REC()    . = ALIGN(8);     \
> > > > >     __start_mcount_loc = .;                 \
> > > > >     KEEP(*(__mcount_loc))                   \
> > > > >     KEEP(*(__patchable_function_entries))   \
> > > > >     __stop_mcount_loc = .;                  \
> > > > >    ...
> > > > >
> > > > >
> > > > > it looks like __patchable_function_entries is used for other than x86 archs,
> > > > > so we perhaps we could have x86 specific MCOUNT_REC macro just with
> > > > > __mcount_loc section?
> > > >
> > > > So something like this:
> > > >
> > > > #ifdef CONFIG_X86
> > > > # define NON_MCOUNT_PATCHABLE KEEP(*(__patchable_function_entries))
> > > > # define MCOUNT_PATCHABLE
> > > > #else
> > > > # define NON_MCOUNT_PATCHABLE
> > > > # define MCOUNT_PATCHABLE  KEEP(*(__patchable_function_entries))
> > > > #endif
> > > >
> > > >   #define MCOUNT_REC()    . = ALIGN(8);     \
> > > >     __start_mcount_loc = .;                 \
> > > >     KEEP(*(__mcount_loc))                   \
> > > >     MCOUNT_PATCHABLE                        \
> > > >     __stop_mcount_loc = .;                  \
> > > >     NON_MCOUNT_PATCHABLE                    \
> > > >    ...
> > > >
> > > > ??
> > >
> > > That's what more or less Peter's patch is doing:
> > > Here it is again for reference:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=8d075bdf11193f1d276bf19fa56b4b8dfe24df9e
> >
> > ah nice, and discards the __patchable_function_entries section, great
> >
>
> tested change below with Peter's change above and it seems to work,
> once it get merged I'll send full patch

Peter,
what is the ETA to land your changes?
That particular commit is detached in your git tree.
Did you move it to a different branch?

Just trying to figure out the logistics to land Jiri's fix below.
We can take it into bpf-next, since it's harmless as-is,
but it won't have an effect until your change lands.
Sounds like they both will get in during the next merge window?

> thanks,
> jirka
>
>
> ---
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 39bd36359c1e..39b6807058e9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -924,6 +924,8 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
>  }
>
>  #define DEFINE_BPF_DISPATCHER(name)                                    \
> +       __attribute__((__no_instrument_function__))                     \
> +       __attribute__((patchable_function_entry(5)))                    \
>         noinline __nocfi unsigned int bpf_dispatcher_##name##_func(     \
>                 const void *ctx,                                        \
>                 const struct bpf_insn *insnsi,                          \
