Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48A257E4DF
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 18:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiGVQxr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 12:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiGVQxq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 12:53:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F72A714
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:53:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j22so9574213ejs.2
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4eknCubD/5RYLxnWpQT8svVefXtyrhoz/l+RxLEhyE=;
        b=qFqg8mwL2JtGXw2DkwMhMkTvp1dopxENzEFKyS5aoPLtRCaCz/k82BzsJmAxLb9ZOg
         ph2BWJQTnM7Fp49Zy3ll7rpkRCSycIsQVnxGSDWzcwPAPN4l4073PJRbX+7qGTeMekjh
         73Nd8hlasUf535blrbgT2IJEaXN2BZgzN/qkHnJ8binjBvFJrpVs52sbJ0T5ikE8RUL2
         UpqIb0vfkf7W9pcGfB1qtaZL9m21Z6uvHd1wmbO8MgirXSGy/mO1wlaIvuTpglhopTdr
         oxEYAJqGwQfJpg6mCfD3HXBPUFymPnq7ZgePXfbS2d9/QxJzj6pif9BhQnT/5Upc2Z8g
         ZGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4eknCubD/5RYLxnWpQT8svVefXtyrhoz/l+RxLEhyE=;
        b=1DvjQ4/PN+9r2x3rjeDRR4hZHCWKYVoDSzxHwcrIk1lBJxK4g6IJnFhrNwvCtHJXqu
         KimQy1zgUyHg4Dp51o/DbzQx55LdSRav+zopzU7T2OEooXbaOJ4y1bT+nUubJYLHzFkP
         yb5YS/bLBS6qznyb2l8ij7H4rz/DtkgEtZ+VC3v5wjMjP5tw4VkOARt0Zd0ywT32qMK0
         YIfh21lGvkFN6h8Bzkc606W217NTgs2KRA7K/8D52B+mF0u5nIRvvtYtCh/gI6R4qPYR
         pZd3l1CVC5G+8Gv9NQH3GnTLnMcSFTdqcsoIx3/LN0UTqySBoQjRbh/xaebjc22llYW/
         YU1g==
X-Gm-Message-State: AJIora8RLVc7e1mzdV6BPyMikZirngNxNorMGAbkaenv4uily5lRY6qa
        jEVlOlUdgG+Pk/oSObfMX+eFbX9jynbQymKWkF8=
X-Google-Smtp-Source: AGRyM1shTYQkKrMbXuIQRnEyOZt2bDRC27BHHkIQlMwfF7X3yyuSsl0qL4fd5OaMplPthhfltNgC4enV6YxwHIGPt5g=
X-Received: by 2002:a17:906:9bdd:b0:72b:3cab:eade with SMTP id
 de29-20020a1709069bdd00b0072b3cabeademr633686ejc.58.1658508823634; Fri, 22
 Jul 2022 09:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220722110811.124515-1-jolsa@kernel.org> <20220722072608.17ef543f@rorschach.local.home>
 <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home> <20220722122548.2db543ca@gandalf.local.home>
In-Reply-To: <20220722122548.2db543ca@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 22 Jul 2022 09:53:32 -0700
Message-ID: <CAADnVQJTT7h3MniVqdBEU=eLwvJhEKNLSjbUAK4sOrhN=zggCQ@mail.gmail.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
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

On Fri, Jul 22, 2022 at 9:25 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 22 Jul 2022 12:08:54 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Fri, 22 Jul 2022 09:04:29 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > ftrace must not peek into bpf specific functions.
> > > Currently ftrace is causing the kernel to crash.
> > > What Jiri is proposing is to fix ftrace bug.
> > > And you're saying nack? let ftrace be broken ?
>
> Sounds like a BPF bug to me. Ftrace did nothing to cause this breakage. It
> was something BPF must have done. What exactly is BPF doing to ftrace
> locations anyway?

ftrace location?
fentry != ftrace.
nop5 in the beginning of the function or in the middle of it
doesn't mean that it's safe for ftrace to attach there.
In some cases bpf has custom calling convention
like it preserves %rax.
In other cases there will be multiple nop5 locations
through the function where special care needs to be taken
to attach.

> > >
> > > If you don't like Jiri's approach please propose something else.
> >
> > So, why not mark it as notrace? That will prevent ftrace from looking at it.
> >
>
> And if for some strange reason you need the mcount/fentry on some internal
> BPF infrastructure, the work around is to register two ftrace_ops() that
> have filters to that function. In which case ftrace will force the call to
> the ftrace iterator loop, and any more ops attached will simply be added to
> that loop, and ftrace will no longer touch that location.
>
> Then you can do whatever you want to it without fear of racing with ftrace.

Jiri,
that sounds like a workable solution.
wdyt?

> But other than that, we don't need infrastructure to hide any mcount/fentry
> locations from ftrace. Those were add *for* ftrace.

fentry != ftrace.
