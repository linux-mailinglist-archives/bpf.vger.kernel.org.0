Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7013E58E40D
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 02:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiHJAZY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 20:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHJAZW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 20:25:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F52213CD0
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 17:25:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z2so17158323edc.1
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 17:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=E/lCz4ZCxvFi5PXoAutXpSVyL5CrahHA+y48BqkMvgQ=;
        b=edWBA89pI2MDXXqNZvsK7EeTmksPO/CL2Q5x1WM0WJ+ZnRZvGTwQpIix7kTAX2nrnw
         K9Nwy/MiYkP6Y28Cvs7/CvDQ1iWRzJbZ4xg1xVMd4JuVEaQOql3UwtLKUfEBhXGi+RKu
         VRFbe7clapIsImliNmt+48yvWSjCKkHXeVH+MGGQ84ShyGKuABqrb7sNbDSE/i2f7L+J
         HhkPpYr3Nr9+/kGK4DG99Rz7JwzyDkrucTZZnGhY45IV3/LZRF5fzlNpe0n3DE1OSADj
         emZwJy2niiWxA0p0uwl/6uTj3Kbwnv7TI6RS3FkbeGoJU3M5QBE3+c37gbdszUgSXsYk
         yPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=E/lCz4ZCxvFi5PXoAutXpSVyL5CrahHA+y48BqkMvgQ=;
        b=Ii6B/K0YNyqoD/YMhaBFuksE9zjesfqt4n0+jojrRK/NmZElToxG98zBbkUs43yZw7
         zhy4Ppj/nwxzBWCAuuRW53TRhOU7V2Hi5LLAAdbOLv9/75ZJkBc6epFYpXVLIduoN+uC
         99HpkRUBGbA0YnjYgYpDaTgs4qhdl8G5eAvHZQHhlniLRlmb1as3aHw30bm/CY8/kQUK
         dYkGVdSYayvYrpFcSAID/iGe3JdQ0NQcwP+lR2YuVaNNlPXX8TQ+4vJxl/d0B7TcMXld
         RR0gi1SnqVREsvrjn8Z4TldA+vKxKgfaJsF+YIzEx0Nv5uylqYpA6nnSiYppgKOJCuBX
         Ovkw==
X-Gm-Message-State: ACgBeo01g0KQnCIPaS+iHmTUMtcs1DMtk1Fk2r2YmoKGDQjxux+fWuQM
        nFPtnHEOHUzMnABuIb/gLDJ6EORzvZclN2zPZ4cAXhuS
X-Google-Smtp-Source: AA6agR531mD9HoG135V/iEIj71ur3srAJEl2ddOB2rgJxTL4+npWjKYIjgOnDU0JKQ9A2rOPpdnKyYAltxMLKYJXTQA=
X-Received: by 2002:a50:ed82:0:b0:43d:5334:9d19 with SMTP id
 h2-20020a50ed82000000b0043d53349d19mr23443887edr.232.1660091119401; Tue, 09
 Aug 2022 17:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220726171129.708371-1-yhs@fb.com> <20220726171140.710070-1-yhs@fb.com>
 <CAEf4Bza1TfpRSZa48Y9zJEi+VBTo9Y7u2YmtEYQZSOnuyJRiHA@mail.gmail.com> <489a8ba8-8c9d-62fa-fec8-de7f6bc241ad@fb.com>
In-Reply-To: <489a8ba8-8c9d-62fa-fec8-de7f6bc241ad@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Aug 2022 17:25:08 -0700
Message-ID: <CAEf4BzaRu5pBV5LNYZhJ+HUus16PdrcXDXzJ2oOy+6SUdSFtjA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/7] bpf: Add struct argument info in btf_func_model
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
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

On Tue, Aug 9, 2022 at 10:38 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/8/22 5:02 PM, Andrii Nakryiko wrote:
> > On Tue, Jul 26, 2022 at 10:11 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Add struct argument information in btf_func_model and such information
> >> will be used in arch specific function arch_prepare_bpf_trampoline()
> >> to prepare argument access properly in trampoline.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   include/linux/bpf.h | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 20c26aed7896..173b42cf3940 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -726,10 +726,19 @@ enum bpf_cgroup_storage_type {
> >>    */
> >>   #define MAX_BPF_FUNC_REG_ARGS 5
> >>
> >> +/* The maximum number of struct arguments a single function may have. */
> >> +#define MAX_BPF_FUNC_STRUCT_ARGS 2
> >> +
> >>   struct btf_func_model {
> >>          u8 ret_size;
> >>          u8 nr_args;
> >>          u8 arg_size[MAX_BPF_FUNC_ARGS];
> >> +       /* The struct_arg_idx should be in increasing order like (0, 2, ...).
> >> +        * The struct_arg_bsize encodes the struct field byte size
> >> +        * for the corresponding struct argument index.
> >> +        */
> >> +       u8 struct_arg_idx[MAX_BPF_FUNC_STRUCT_ARGS];
> >> +       u8 struct_arg_bsize[MAX_BPF_FUNC_STRUCT_ARGS];
> >
> > Few questions here. It might be a bad idea, but I thought I'd bring it
> > up anyway.
> >
> > So, is there any benefit into having these separate struct_arg_idx and
> > struct_arg_bsize fields and then processing arg_size completely
> > separate from struct_arg_idx/struct_arg_bsize in patch #4? Reading
> > patch #4 it felt like it would be much easier to keep track of things
> > if we had a single loop going over all the arguments, and then if some
> > argument is a struct -- do some extra step to copy up to 16 bytes onto
> > stack and store the pointer there (and skip up to one extra argument).
> > And if it's not a struct arg -- do what we do right now.
> >
> > What if instead we keep btf_func_mode definition as is, but for struct
> > argument we add extra flag to arg_size[struct_arg_idx] value to mark
> > that it is a struct argument. This limits arg_size to 128 bytes, but I
> > think it's more than enough for both struct and non-struct cases,
> > right? Distill function would make sure that nr_args matches number of
> > logical arguments and not number of registers.
> >
> > Would that work? Would that make anything harder to implement in
> > arch-specific code? I don't see what, but I haven't grokked all the
> > details of patch #4, so I'm sorry if I missed something obvious. The
> > way I see it, it will make overall logic for saving/restoring
> > registers more uniform, roughly:
> >
> > for (int arg_idx = 0; arg_idx < model->arg_size; arg_idx++) {
> >    if (arg & BTF_FMODEL_STRUCT_ARG) {
> >      /* handle struct, calc extra registers "consumed" from
> > arg_size[arg_idx] ~BTF_FMODEL_STRUCT_ARG */
> >    } else {
> >      /* just a normal register */
> >    }
> > }
>
> Your suggestion sounds good to me. Yes, we already have
> arg_size array. We can add a
>         bool is_struct_arg[MAX_BPF_FUNC_ARGS];
> to indicate whether the argument is a struct or not.
> In this case, we can avoid duplication between
> arg_size and struct_arg_bsize.
>

I was imagining that we'll just use the existing arg_size and define
that the upper bit is a struct/non-struct bit. But if that's too
confusing and cryptic, I wonder if it's better to have

u8 arg_flags[MAX_BPF_FUNC_ARGS];

instead and define the BPF_FNARG_STRUCT flag.

For what you did in your other patch set (u8/u16 handling for func
result), we can then define ret_flags and have a flag whether the
argument is integer and whether it's signed in such flags (instead of
bit fields).

This way we have a unified and more extendable "size+flags" approach
both for input arguments and return result.

WDYT?

> >
> >
> > If we do stick to current approach, though, let's please
> > s/struct_arg_bsize/struct_arg_size/. Isn't arg_size also and already
> > in bytes? It will keep naming and meaning consistent across struct and
> > non-struct args.
> >
> > BTW, by not having btf_func_model encode register indices in
> > struct_arg_idx we keep btf_func_model pretty architecture-agnostic,
> > right? It will be per each architecture specific implementation to
> > perform mapping this *model* into actual registers used?
> >
> >
> >
> >
> >>   };
> >>
> >>   /* Restore arguments before returning from trampoline to let original function
> >> --
> >> 2.30.2
> >>
