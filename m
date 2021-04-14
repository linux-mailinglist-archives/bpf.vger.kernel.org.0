Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB835FA32
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 20:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351687AbhDNSCu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 14:02:50 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:46611 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351678AbhDNSCt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 14:02:49 -0400
Received: by mail-ua1-f45.google.com with SMTP id v23so6658637uaq.13;
        Wed, 14 Apr 2021 11:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFAyc/0OnDwFm+c9BzGYO5+jcNQjjTnGY0d4m8lX60E=;
        b=Z3Z1LxlxODt8jVq/0tbLAAdWm3M0vh2hsD56eUL1CMRjfFGWnYNq3bzX0d1xAff13F
         oI8ttpbe77BcwYNZMTqhIqQl7OoKblbzcZhtg9gwd4Wq4RSeM4XSIY8bCcnrRUjzmV9/
         17/q2rgPMCJEhQgyAdzZlw08rNr2O0aUfGhL40/BQzVzm8xtObG4tqpDNgna8gHisK8d
         ffAwT8ID2IdqF8vO3Zdx9N/lDAaU4UoB7KDXAtcW0344D4DHtMoQTGl0uxKn2F3//03r
         0vAtnn45ErYTigKrFmZ9mfeLS6ZTQgtADEV3leZ87gONAotpQX+oD5ETIHBko3p6v3dl
         b8Ag==
X-Gm-Message-State: AOAM531++6x7ZIbG7rhyoYNop8fd6cHJ7E2shCJuV20AzepIxOvb6Bse
        OmrB8ZL6Gdgi+sE6l01fYg1feO9VWo0GHwqO7B0=
X-Google-Smtp-Source: ABdhPJzi+z6KrrxRcyVmBGK4K6qI0YwfFskdGKirAKIKyHt0YoKnsJ/YqTzeHbO9SQWE7CMFfV69oN8rXUt99iBlnYU=
X-Received: by 2002:ab0:3157:: with SMTP id e23mr27444457uam.106.1618423347408;
 Wed, 14 Apr 2021 11:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-4-revest@chromium.org>
 <CAEf4BzZCR2JMXwNvJikfWYnZa-CyCQTQsW+Xs_5w9zOT3kbVSA@mail.gmail.com>
In-Reply-To: <CAEf4BzZCR2JMXwNvJikfWYnZa-CyCQTQsW+Xs_5w9zOT3kbVSA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Apr 2021 20:02:15 +0200
Message-ID: <CAMuHMdUQOi8h31D_Qtnv_E1vsEu6RO8sHy-DArQ0jQt5v_JoVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add a bpf_snprintf helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

On Wed, Apr 14, 2021 at 9:41 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > The implementation takes inspiration from the existing bpf_trace_printk
> > helper but there are a few differences:
> >
> > To allow for a large number of format-specifiers, parameters are
> > provided in an array, like in bpf_seq_printf.
> >
> > Because the output string takes two arguments and the array of
> > parameters also takes two arguments, the format string needs to fit in
> > one argument. Thankfully, ARG_PTR_TO_CONST_STR is guaranteed to point to
> > a zero-terminated read-only map so we don't need a format string length
> > arg.
> >
> > Because the format-string is known at verification time, we also do
> > a first pass of format string validation in the verifier logic. This
> > makes debugging easier.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  include/linux/bpf.h            |  6 ++++
> >  include/uapi/linux/bpf.h       | 28 +++++++++++++++++++
> >  kernel/bpf/helpers.c           |  2 ++
> >  kernel/bpf/verifier.c          | 41 ++++++++++++++++++++++++++++
> >  kernel/trace/bpf_trace.c       | 50 ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 28 +++++++++++++++++++
> >  6 files changed, 155 insertions(+)
> >
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5f46dd6f3383..d4020e5f91ee 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5918,6 +5918,41 @@ static int check_reference_leak(struct bpf_verifier_env *env)
> >         return state->acquired_refs ? -EINVAL : 0;
> >  }
> >
> > +static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
> > +                                  struct bpf_reg_state *regs)
> > +{
> > +       struct bpf_reg_state *fmt_reg = &regs[BPF_REG_3];
> > +       struct bpf_reg_state *data_len_reg = &regs[BPF_REG_5];
> > +       struct bpf_map *fmt_map = fmt_reg->map_ptr;
> > +       int err, fmt_map_off, num_args;
> > +       u64 fmt_addr;
> > +       char *fmt;
> > +
> > +       /* data must be an array of u64 */
> > +       if (data_len_reg->var_off.value % 8)
> > +               return -EINVAL;
> > +       num_args = data_len_reg->var_off.value / 8;
> > +
> > +       /* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
> > +        * and map_direct_value_addr is set.
> > +        */
> > +       fmt_map_off = fmt_reg->off + fmt_reg->var_off.value;
> > +       err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
> > +                                                 fmt_map_off);
> > +       if (err)
> > +               return err;
> > +       fmt = (char *)fmt_addr + fmt_map_off;
> > +
>
> bot complained about lack of (long) cast before fmt_addr, please address

(uintptr_t), I assume?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
