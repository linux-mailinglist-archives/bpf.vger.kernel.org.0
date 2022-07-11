Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069E956D4EA
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 08:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiGKGtU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 02:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGKGtU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 02:49:20 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1D36144
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 23:49:19 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id o185so4081338vsc.7
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 23:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HM30YiM9pQyDXmYdcEyIYm/O7MQh9WDuXiJXjN1Po/c=;
        b=kOB5AXL+FfElHAGeNd+SHXoky92ZmYO7DpVDBUcARq56dLUyoFpy/ZtwZ5WfH7k4uy
         Tjb12A22uXbe7ouWzLC4LrlHRv4AJwciWp8enMbbXF4BpZiqkcYZYeJkPbimiqE2WaVC
         PC0MMgcxEuoIlRZmbwJFYwgW6JwG3L5ogdC95zt1leBtB+YS676RCbfCqAak8GjfCJ3H
         k6GSn0vyO16SFntjo7RsecYS6A/4QYbM6yx5+9zkwGCMmabhnbPRW1TmbWbHakHsUo8o
         YzJ5GLQE2gKx6aoxROtrM9t5LMKvk0/wzlVfhSNO01OO6CXP7hu/sb0cE04dW3qAdJEC
         wJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HM30YiM9pQyDXmYdcEyIYm/O7MQh9WDuXiJXjN1Po/c=;
        b=aKzp4StnD476zd163awQIanXuWuxBjlpjf/dqkJzP1wKS+RSycNLk+P4eI7gydv0ei
         7VO+2doK5ZjgYDCzdTl8JV/VhV5u/xPOTsUfwbx42R7TNYJzG9KID7zAGMrAo7+tpd3/
         9516bS6Q6uh18rzVASI34N7DzMMWw1C8ZCx7L8RfkZkhgnxhS6H0S14zdOXp4QiUaTwX
         J2xJHM45ao5EwEGSVCoJt3+kxQoUug2lYYg54Jjgs9fMlONDpW/QMZLig2GrLqrgrR7r
         a/5c5kr3QIaRB/ysewgAkHNCjjZEF2wBPusXSoPeQFwq5tHaJ7vFrVmeJEXjCtlSUkrI
         S/bw==
X-Gm-Message-State: AJIora+gxgNRf2AdfGXylTVeOCdFFdE8lNjrRn7iCuCEqDE1mwFPcIGW
        sQg6K5/USc+0aJBE/cfh7Lq1h0Z2lglGLgZ+udY=
X-Google-Smtp-Source: AGRyM1tetmQuMCf339/rDXTiJF/6uxrGBJ8TjG8IHt1tFgKBAWSsPbWi+EdTHRTuJM8A8E4w6yKMw7D93DUgX6kRvD4=
X-Received: by 2002:a67:af11:0:b0:357:5b18:d7b9 with SMTP id
 v17-20020a67af11000000b003575b18d7b9mr1253200vsl.35.1657522158605; Sun, 10
 Jul 2022 23:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220709154457.57379-1-laoar.shao@gmail.com> <20220709154457.57379-3-laoar.shao@gmail.com>
 <05e5931e-98a7-d7b4-4775-7c17fad57450@fb.com>
In-Reply-To: <05e5931e-98a7-d7b4-4775-7c17fad57450@fb.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 11 Jul 2022 14:48:42 +0800
Message-ID: <CALOAHbB__jK-MpzZw6nz8fr5yxM9vtWAsQ0d714BPys7qGqC-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Warn on non-preallocated case for
 missed trace types
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hao Luo <haoluo@google.com>,
        Shakeel Butt <shakeelb@google.com>, bpf <bpf@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
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

On Mon, Jul 11, 2022 at 1:51 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/9/22 8:44 AM, Yafang Shao wrote:
> > The raw tracepoint may cause unexpected memory allocation if we set
> > BPF_F_NO_PREALLOC. So let's warn on it.
>
> Please extend raw_tracepoint to other attach types which
> may cause runtime map allocations.
>

Per my understanding, it is safe to allocate memory in a non-process
context as long as we don't allow blocking it.
So this issue doesn't matter with whether it causes runtime map
allocations or not, while it really matters with the tracepoint or
kprobe.
Regarding the tracepoint or kprobe, if we don't use non-preallocated
maps, it may allocate other extra memory besides the map element
itself.
I have verified that it is safe to use non-preallocated maps in
BPF_TRACE_ITER or BPF_TRACE_FENTRY.
So filtering out BPF_TRACE_RAW_TP only is enough.

> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >   kernel/bpf/verifier.c | 18 +++++++++++++-----
> >   1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e3cf6194c24f..3cd8260827e0 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12574,14 +12574,20 @@ static int check_map_prealloc(struct bpf_map *map)
> >               !(map->map_flags & BPF_F_NO_PREALLOC);
> >   }
> >
> > -static bool is_tracing_prog_type(enum bpf_prog_type type)
> > +static bool is_tracing_prog_type(enum bpf_prog_type prog_type,
> > +                              enum bpf_attach_type attach_type)
> >   {
> > -     switch (type) {
> > +     switch (prog_type) {
> >       case BPF_PROG_TYPE_KPROBE:
> >       case BPF_PROG_TYPE_TRACEPOINT:
> >       case BPF_PROG_TYPE_PERF_EVENT:
> >       case BPF_PROG_TYPE_RAW_TRACEPOINT:
> > +     case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
> >               return true;
> > +     case BPF_PROG_TYPE_TRACING:
> > +             if (attach_type == BPF_TRACE_RAW_TP)
> > +                     return true;
>
> As Alexei mentioned earlier, here we should have
>                 if (attach_type != BPF_TRACE_ITER)
>                         return true;

That will break selftests/bpf/progs/timer.c, because it uses timer in fentry.

> For attach types with BPF_PROG_TYPE_TRACING programs,
> BPF_TRACE_ITER attach type can only appear in process context.
> All other attach types may appear in non-process context.
>

Thanks for the explanation.

> > +             return false;
> >       default:
> >               return false;
> >       }
> > @@ -12601,7 +12607,9 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
> >                                       struct bpf_prog *prog)
> >
> >   {
> > +     enum bpf_attach_type attach_type = prog->expected_attach_type;
> >       enum bpf_prog_type prog_type = resolve_prog_type(prog);
> > +
> [...]



-- 
Regards
Yafang
