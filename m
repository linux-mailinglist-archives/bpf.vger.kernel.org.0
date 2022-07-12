Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D52571477
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiGLI0n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiGLI0l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 04:26:41 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7AF8C742
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 01:26:39 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id a184so7144520vsa.1
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0Z4vxArFrtPl1OZaeTk/GWzOczAj8yegl1UmLNk3fA=;
        b=mgzUm+wL6rBKcHmQIlyKp7WQA4JtH54DKPQDilTeabjFdd4SkIUcH3NiR9R2f4gX1t
         Ntt4NiUxrku7htqSfrNcx+zyoRKgLatwE6ukBtS2mDw3L0A0PIIIgS5Lnsz0VnYP0t+F
         aHUaDDiOBtkjvWBJR+wCoZvfpK5kaeZfzjE107ZfgALbY15mnN9TyPmqcZdJINCklecW
         p5ABuYh0YSG1NvcePpVabJcjleBgbKy0XyUMV7PHT2KCAM/TaN0TheqYeZ/kk7dsOz1G
         n/6vuFeYExE0oompVOk2jbWtqPpryTorNKlf6ez5lYnckcUBkM28Fph78Tp4KA6ZI9EW
         vPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0Z4vxArFrtPl1OZaeTk/GWzOczAj8yegl1UmLNk3fA=;
        b=J5bg0sHHviVS2HbncijhVxb4QTKpJldqnuhiKuhiIT44LhR4ABX1WexswhjXC7OVAG
         QO7LDGQCYt9hs5SyR3Nz2LlM5biBZEdonZUlkc6f93BKbG5Oa3reC1vOX3PW97E321HP
         3JoBUQU76ufVVY2bq+PSbPr0vlrt8oPVV6/6jJw7WRLK5ZxV2AKS6W4tgZpYXPYPEQ9p
         l9FuJyHY/X9USTaqQp/fyGn3JnMjLlUZi/1PO+pe+JjK9NRhuIQqVG2Ej0RsHcL3dB8s
         WGpRJmANagmJ+/tTwFIWomTR7wQ0aogoUk9hON5ZVxmk+etFhqHHA3uhXcgxlZO9F+Ld
         z/gg==
X-Gm-Message-State: AJIora/jbGQEHwbRTs3iH8UICc6cO/eM/17Iln//JSjJyCxbeb7+kyh4
        drDrqHHUPbbBlSC/W7Ru494Zbyl6zn2hOn5yDnU=
X-Google-Smtp-Source: AGRyM1usqPhc15zIZPmpyOUraReWLoqzvUkw8yv0HyEHextWjJTOxHdOnFhlRU5y5A6vrft1dq+l4vSb41AGKgJ5qUo=
X-Received: by 2002:a67:af11:0:b0:357:5b18:d7b9 with SMTP id
 v17-20020a67af11000000b003575b18d7b9mr3412309vsl.35.1657614398185; Tue, 12
 Jul 2022 01:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220709154457.57379-1-laoar.shao@gmail.com> <20220709154457.57379-3-laoar.shao@gmail.com>
 <05e5931e-98a7-d7b4-4775-7c17fad57450@fb.com> <CALOAHbB__jK-MpzZw6nz8fr5yxM9vtWAsQ0d714BPys7qGqC-Q@mail.gmail.com>
 <a1c2eb2b-e5d4-d27b-53e9-ab6b51fdc9bf@fb.com>
In-Reply-To: <a1c2eb2b-e5d4-d27b-53e9-ab6b51fdc9bf@fb.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 12 Jul 2022 16:26:01 +0800
Message-ID: <CALOAHbAQ7AKNPrkawGKHarkB5CGkWXTC8P=+EJP3DAPNEf=Ayw@mail.gmail.com>
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

On Tue, Jul 12, 2022 at 3:04 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/10/22 11:48 PM, Yafang Shao wrote:
> > On Mon, Jul 11, 2022 at 1:51 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 7/9/22 8:44 AM, Yafang Shao wrote:
> >>> The raw tracepoint may cause unexpected memory allocation if we set
> >>> BPF_F_NO_PREALLOC. So let's warn on it.
> >>
> >> Please extend raw_tracepoint to other attach types which
> >> may cause runtime map allocations.
> >>
> >
> > Per my understanding, it is safe to allocate memory in a non-process
> > context as long as we don't allow blocking it.
> > So this issue doesn't matter with whether it causes runtime map
> > allocations or not, while it really matters with the tracepoint or
> > kprobe.
> > Regarding the tracepoint or kprobe, if we don't use non-preallocated
> > maps, it may allocate other extra memory besides the map element
> > itself.
> > I have verified that it is safe to use non-preallocated maps in
> > BPF_TRACE_ITER or BPF_TRACE_FENTRY.
> > So filtering out BPF_TRACE_RAW_TP only is enough. >
> >>>
> >>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>> ---
> >>>    kernel/bpf/verifier.c | 18 +++++++++++++-----
> >>>    1 file changed, 13 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> index e3cf6194c24f..3cd8260827e0 100644
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>> @@ -12574,14 +12574,20 @@ static int check_map_prealloc(struct bpf_map *map)
> >>>                !(map->map_flags & BPF_F_NO_PREALLOC);
> >>>    }
> >>>
> >>> -static bool is_tracing_prog_type(enum bpf_prog_type type)
> >>> +static bool is_tracing_prog_type(enum bpf_prog_type prog_type,
> >>> +                              enum bpf_attach_type attach_type)
> >>>    {
> >>> -     switch (type) {
> >>> +     switch (prog_type) {
> >>>        case BPF_PROG_TYPE_KPROBE:
> >>>        case BPF_PROG_TYPE_TRACEPOINT:
> >>>        case BPF_PROG_TYPE_PERF_EVENT:
> >>>        case BPF_PROG_TYPE_RAW_TRACEPOINT:
> >>> +     case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
> >>>                return true;
> >>> +     case BPF_PROG_TYPE_TRACING:
> >>> +             if (attach_type == BPF_TRACE_RAW_TP)
> >>> +                     return true;
> >>
> >> As Alexei mentioned earlier, here we should have
> >>                  if (attach_type != BPF_TRACE_ITER)
> >>                          return true;
> >
> > That will break selftests/bpf/progs/timer.c, because it uses timer in fentry.
>
> Okay. Let us remove BPF_PROG_TYPE_TRACING from this patch for now.
> fentry/fexit/fmod may attach any kallsyms functions and many of them
> are called in process context and non-preallocated hashmap totally fine.
> It is not good to prohibit non-preallocated hashmap for any
> fentry/fexit/fmod bpf programs.
>

Got it. I will do it.

-- 
Regards
Yafang
