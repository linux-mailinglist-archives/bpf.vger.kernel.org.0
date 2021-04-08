Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3B9359002
	for <lists+bpf@lfdr.de>; Fri,  9 Apr 2021 00:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhDHWxF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 18:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWxF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Apr 2021 18:53:05 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63863C061760
        for <bpf@vger.kernel.org>; Thu,  8 Apr 2021 15:52:53 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id 6so3177570ilt.9
        for <bpf@vger.kernel.org>; Thu, 08 Apr 2021 15:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EQ3h5xe8+jzukdzUQlxZOE8rskbjPlCZ9sPf83nXZbY=;
        b=MksMSZzbF0wh0wGQauFOyixOl0KDvpK82upbH62f/+ZzgHeGh5TON4vIVc6EIDrIC1
         t8Y0dOJItALo2y2BKuAzhj6rufQi50ZiFkfErR+80UiqMdrZL3CN7bgKCL1RkRrtm+zc
         NC3PQH902awbjcNgZkezBJz0gpziuWp2xqXXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQ3h5xe8+jzukdzUQlxZOE8rskbjPlCZ9sPf83nXZbY=;
        b=uFW8JmV9Vo/zhDmElV9OthVp0S1W1muoxZXnf6P+XRxIeCRecxjA1U3NclQFzT8fqR
         jwfqwrwSJQwN+6ICu3ew0CMK0UcHbADqOswrMWtJ4FzDFgG+9rJ5WIjrJER21cxuDHTj
         lkWXJu+T5TUFFLLaM8mtVWReDnm6eeDyIo+fllYKP+0P5CWVGnZkXNeVfl2dUtSpzx1M
         jJwPLyUX2HRoEH+KCrzjTD6o99RV6sLRSLnLl+N2DnLZ9gTpq8UyVrYNCC/ZbMDwf7Yb
         IcvfLTz3iYT4iiPk6veq0tgPXVefyiCbq/EyKgxqGKft62NCdPmJE+EV4D1Tl0LII27J
         thOg==
X-Gm-Message-State: AOAM530yTqOSsnl28JM7uj7BL+7gDtTVXUTs4hK/ED7r65JsJMV9v/1G
        u7RxnXXjNjDjv70BG6CIaFa8TLvYTOn8XYuSWwzYsw==
X-Google-Smtp-Source: ABdhPJxTy9YlfM8nAj2pVgKVh4ITSdl1VcxrEFOjdhkWmnModLyGTvOJQ5oOrg8tgGSHztvBAmNYdZ1QqWOdZ+6YneQ=
X-Received: by 2002:a05:6e02:5a2:: with SMTP id k2mr9099221ils.177.1617922372817;
 Thu, 08 Apr 2021 15:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-2-revest@chromium.org>
 <CAEf4BzZP6uK_ZcKJZsESWrMHG5kEG_swRYJwqsaiD95CEOdJ5g@mail.gmail.com>
 <CAEf4BzYVTHm5Zrr7RPoRB7EL9nsE5kUzciHEv5fPipbMoEtQxA@mail.gmail.com>
 <CABRcYmJpRyqbeZmMT=SxAg95p8ndtEbTR9EUWK0CfSNhSF3egw@mail.gmail.com> <CAEf4BzZVEGM4esi-Rz67_xX_RTDrgxViy0gHfpeauECR5bmRNA@mail.gmail.com>
In-Reply-To: <CAEf4BzZVEGM4esi-Rz67_xX_RTDrgxViy0gHfpeauECR5bmRNA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 9 Apr 2021 00:52:42 +0200
Message-ID: <CABRcYm+QsJA_aN9dDaVByL_h72YF_3Z4hEVgJ6vfkLkfjUSz_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Factorize bpf_trace_printk and bpf_seq_printf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 7, 2021 at 11:54 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Apr 6, 2021 at 8:35 AM Florent Revest <revest@chromium.org> wrote:
> > On Fri, Mar 26, 2021 at 11:51 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Fri, Mar 26, 2021 at 2:53 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
> > > > > +/* Horrid workaround for getting va_list handling working with different
> > > > > + * argument type combinations generically for 32 and 64 bit archs.
> > > > > + */
> > > > > +#define BPF_CAST_FMT_ARG(arg_nb, args, mod)                            \
> > > > > +       ((mod[arg_nb] == BPF_PRINTF_LONG_LONG ||                        \
> > > > > +        (mod[arg_nb] == BPF_PRINTF_LONG && __BITS_PER_LONG == 64))     \
> > > > > +         ? args[arg_nb]                                                \
> > > > > +         : ((mod[arg_nb] == BPF_PRINTF_LONG ||                         \
> > > > > +            (mod[arg_nb] == BPF_PRINTF_INT && __BITS_PER_LONG == 32))  \
> > > >
> > > > is this right? INT is always 32-bit, it's only LONG that differs.
> > > > Shouldn't the rule be
> > > >
> > > > (LONG_LONG || LONG && __BITS_PER_LONG) -> (__u64)args[args_nb]
> > > > (INT || LONG && __BITS_PER_LONG == 32) -> (__u32)args[args_nb]
> > > >
> > > > Does (long) cast do anything fancy when casting from u64? Sorry, maybe
> > > > I'm confused.
> >
> > To be honest, I am also confused by that logic... :p My patch tries to
> > conserve exactly the same logic as "88a5c690b6 bpf: fix
> > bpf_trace_printk on 32 bit archs" because I was also afraid of missing
> > something and could not test it on 32 bit arches. From that commit
> > description, it is unclear to me what "u32 and long are passed
> > differently to u64, since the result of C conditional operators
> > follows the "usual arithmetic conversions" rules" means. Maybe Daniel
> > can comment on this ?
>
> Yeah, no idea. Seems like the code above should work fine for 32 and
> 64 bitness and both little- and big-endianness.

Yeah, looks good to me as well. I'll use it in v3.

> > > > > +int bpf_printf_preamble(char *fmt, u32 fmt_size, const u64 *raw_args,
> > > > > +                       u64 *final_args, enum bpf_printf_mod_type *mod,
> > > > > +                       u32 num_args)
> > > > > +{
> > > > > +       struct bpf_printf_buf *bufs = this_cpu_ptr(&bpf_printf_buf);
> > > > > +       int err, i, fmt_cnt = 0, copy_size, used;
> > > > > +       char *unsafe_ptr = NULL, *tmp_buf = NULL;
> > > > > +       bool prepare_args = final_args && mod;
> > > >
> > > > probably better to enforce that both or none are specified, otherwise
> > > > return error
> >
> > Fair :)
> >
> > > it's actually three of them: raw_args, mod, and num_args, right? All
> > > three are either NULL or non-NULL.
> >
> > It is a bit tricky to see from that patch but in "3/6 bpf: Add a
> > bpf_snprintf helper" the verifier code calls this function with
> > num_args != 0 to check whether the number of arguments is correct
> > without actually converting anything.
> >
> > Also when the helper gets called, raw_args can come from the BPF
> > program and be NULL but in that case we will also have num_args = 0
> > guaranteed by the helper so the loop will bail out if it encounters a
> > format specifier.
>
> ok, but at least final_args and mod are locked together, so should be
> enforced to be either null or not, right?

Yes :) will do.

> > > > > +       enum bpf_printf_mod_type current_mod;
> > > > > +       size_t tmp_buf_len;
> > > > > +       u64 current_arg;
> > > > > +       char fmt_ptype;
> > > > > +
> > > > > +       for (i = 0; i < fmt_size && fmt[i] != '\0'; i++) {
> > > >
> > > > Can we say that if the last character is not '\0' then it's a bad
> > > > format string and return -EINVAL? And if \0 is inside the format
> > > > string, then it's also a bad format string? I wonder what others think
> > > > about this?... I think sanity should prevail.
> >
> > Overall, there are two situations:
> > - bpf_seq_printf, bpf_trace_printk: we have a pointer and size but we
> > are not guaranteed zero-termination
> > - bpf_snprintf: we have a pointer, no size but it's guaranteed to be
> > zero-terminated (by ARG_PTR_TO_CONST_STR)
> >
> > Currently, in the bpf_snprintf helper, I set fmt_size to UINT_MAX and
> > the terminating condition will be fmt[i] == '\0'.
> > As you pointed out a bit further, I got a bit carried away with the
> > refactoring and dropped the zero-termination checks for the existing
> > helpers !
> >
> > So I see two possibilities:
> > - either we check fmt[last] == '\0', add a bail out condition in the
> > loop if we encounter another `\0` and set fmt_size to sprintf(fmt) in
> > the bpf_snprintf verifier and helper code.
> > - or we unconditionally call strnlen(fmt, fmt_size) in
> > bpf_printf_preamble. If no 0 is found, we return an error, if there is
> > one we treat it as the NULL terminating character.
>
> I was thinking about the second one. It is clearly acceptable on BPF
> verifier side, though one might argue that we are doing extra work on
> the BPF helper side. I don't think it matters in practice, so I'll be
> fine with that, if that makes code cleaner and simpler.

I also prefer that option, yes.

> > > > > +               if ((!isprint(fmt[i]) && !isspace(fmt[i])) ||
> > > > > +                   !isascii(fmt[i])) {
> > > >
> > > > && always binds tighter than ||, so you can omit extra (). I'd put
> > > > this on a single line as well, but that's a total nit.
> >
> > Neat! :)
>
> I just got a compilation warning in a similar situation yesterday when
> I dropped unnecessary parentheses, so some versions of compilers might
> think it is not a good practice. Just keep that in mind. I don't think
> I care enough.

Yes, I noticed the same compilation warning and it bothers me. I'll
keep the parentheses but make it one line.

> > > > > +               while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
> > > > > +                      fmt[i] == ' ')
> > > > > +                       i++;
> > > > > +               if (fmt[i] >= '1' && fmt[i] <= '9') {
> > > > >                         i++;
> > > >
> > > > Are we worried about integer overflow here? %123123123123123d
> > > > hopefully won't crash anything, right?
> >
> > I expect that this should be handled gracefully by the subsequent call
> > to snprintf(). Our parsing logic does not guarantee that the format
> > string is 100% legit but it guarantees that it's safe to call
> > vsnprintf with arguments coming from BPF. If the output buffer is too
> > small to hold the output, the output will be truncated.
> >
> > Note that this is already how bpf_seq_printf already works.
>
> Ok, but let's not hope and add the test for this.

Ok

> > > > > -               } else if (fmt[i] == 'p') {
> > > > > -                       mod[fmt_cnt]++;
> > > > > -                       if ((fmt[i + 1] == 'k' ||
> > > > > -                            fmt[i + 1] == 'u') &&
> > > > > +                       while (fmt[i] >= '0' && fmt[i] <= '9')
> > > > > +                               i++;
> > > >
> > > > whoa, fmt_size shouldn't be ignored
> >
> > Oh no, I'll attach the stone of shame! It all made sense with
> > bpf_snprintf() in mind because, there, we are guaranteed to have a
> > NULL terminated string already but in an excess of refactoring
> > enthusiasm I dropped the zero-termination check for the other helpers.
> >
> > But if we implement either of the options discussed above, then we do
> > not need to constantly check fmt_size.
>
> let's see when we get to the next version ;) I don't remember code
> enough by now, but I'll keep that in mind for the next revision
> anyways

Sure, I'll send v3 asap.

> > > > >                                 fmt_ptype = fmt[i + 1];
> > > > >                                 i += 2;
> > > > >                                 goto fmt_str;
> > > > >                         }
> > > > >
> > > > > -                       if (fmt[i + 1] == 'B') {
> > > > > -                               i++;
> > > > > +                       if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
> > > > > +                           ispunct(fmt[i + 1]) || fmt[i + 1] == 'K' ||
> > > > > +                           fmt[i + 1] == 'x' || fmt[i + 1] == 'B' ||
> > > > > +                           fmt[i + 1] == 's' || fmt[i + 1] == 'S') {
> > > > > +                               /* just kernel pointers */
> > > > > +                               if (prepare_args)
> > > > > +                                       current_arg = raw_args[fmt_cnt];
> > > >
> > > > fmt_cnt is not the best name, imo. arg_cnt makes more sense
> >
> > Mh, we already have "num_args" that can make it confusing. The way I see it:
> > - the number of format specifiers is the number of %d %s... in the format string
> > - the number of arguments is the number of values given in the raw_args array.
> >
>
> Well, if you read "fmt_cnt" as "number of formatters" then yeah, I
> suppose it's fine. Never mind. Just fmt_cnt and fmt_size refers to
> slightly different "fmt"s, which confused me for a bit, but that's ok.
> You use different naming conventions, which is inconsistent, so maybe
> adjust that for purists (i.e., if you have num_args, then you should
> have num_fmts; or, alternatively, arg_cnt and fmt_cnt). But I'm just
> nitpicking, obviously.

I agree, I'll see if I can clean this up a bit.

> > > > > +       if (data_len & 7 || data_len > MAX_SEQ_PRINTF_VARARGS * 8 ||
> > > > > +           (data_len && !data))
> > > >
> > > > data && !data_len is also an error, no?
> >
> > Isn't that checked by the verifier ?
>
> data_len is ARG_CONST_SIZE_OR_ZERO, so data_len == 0 is allowed by
> verifier. But it's probably no harm either to allow data != NULL and
> data_len = 0. Might simplify some more dynamic use of snprintf(),
> actually.

Agree
