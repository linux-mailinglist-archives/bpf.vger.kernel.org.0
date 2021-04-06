Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ADA35581A
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 17:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbhDFPg1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 11:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhDFPf6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 11:35:58 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFAAC0613E4
        for <bpf@vger.kernel.org>; Tue,  6 Apr 2021 08:35:37 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k25so9091181iob.6
        for <bpf@vger.kernel.org>; Tue, 06 Apr 2021 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJBP9c6jtK9nIGXJAzvF2mHBFNFWRCA66u35ltClKZ4=;
        b=YNeFHW9mZ03y/+jsZvvcrkLG1Av/jiy5BIzm05IgtbkcnuYpshkXnxUdQTNGEqOaiU
         SrvaeuVqje9lh76kkst+CwfyjwidgTrgc1mskhZKeqk2CTfkoOSKzZHDd1YnptqAjJvg
         0ArHGDSa72w+NsPTjYjeX7A9LpqN5JLFE0AuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJBP9c6jtK9nIGXJAzvF2mHBFNFWRCA66u35ltClKZ4=;
        b=R09XmEfAXRpfl+id5zEqSDz1QuVXf6mp+dhwFA45R0oGDJgrJ1eERF2zFHtmVLepaM
         jS9zQPRB7jwckUf4BCGIFUztS7CLY8oDljyncaB6YL/bmRBDjvFT0WRf6FkFZX/gmGjc
         h1shSeZFikkcX41zhGcAgb83Ifre0rJCqsF5F23r4yU2ZKRHZZqDWwcUx8Y21Wn+1AMW
         DkVUIaDJKUN1fe5yRqSC8B9hTkm4VXqWMdDWKAr1jiN/lU0knzMsfAYO1yVXAf7oZ+Je
         kCi17ljs7fKwd8KqGCu8YNNTmm6EzY9cCpnpBMJrx+F8G/Wl0EOQ4+Lec5XbFDjwAlT0
         MEHA==
X-Gm-Message-State: AOAM531vK1hEQhQK1dkQkiCoG0kcR5dDe6KeLO8L1WYRgYCsaRWW102U
        8s4veFHf2O5gguCAxBokwQQn0PG/acn75WeTDwtdrA==
X-Google-Smtp-Source: ABdhPJwQ1mlqPXrFVYDP6WKT6EdcEIpyqRxKwSygp6NgiVfUbHrrYAxJqgqwyFMANlVGsmUNvcwSqGmHaFzLQTRiJoc=
X-Received: by 2002:a05:6638:606:: with SMTP id g6mr29764689jar.52.1617723337000;
 Tue, 06 Apr 2021 08:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-2-revest@chromium.org>
 <CAEf4BzZP6uK_ZcKJZsESWrMHG5kEG_swRYJwqsaiD95CEOdJ5g@mail.gmail.com> <CAEf4BzYVTHm5Zrr7RPoRB7EL9nsE5kUzciHEv5fPipbMoEtQxA@mail.gmail.com>
In-Reply-To: <CAEf4BzYVTHm5Zrr7RPoRB7EL9nsE5kUzciHEv5fPipbMoEtQxA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 6 Apr 2021 17:35:26 +0200
Message-ID: <CABRcYmJpRyqbeZmMT=SxAg95p8ndtEbTR9EUWK0CfSNhSF3egw@mail.gmail.com>
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

[Sorry for the late replies, I'm just back from a long easter break :)]

On Fri, Mar 26, 2021 at 11:51 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Fri, Mar 26, 2021 at 2:53 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
> > > Unfortunately, the implementation of the two existing helpers already
> > > drifted quite a bit and unifying them entailed a lot of changes:
> >
> > "Unfortunately" as in a lot of extra work for you? I think overall
> > though it was very fortunate that you ended up doing it, all
> > implementations are more feature-complete and saner now, no? Thanks a
> > lot for your hard work!

Ahah, "unfortunately" a bit of extra work for me, indeed. But I find
this kind of refactoring patches even harder to review than to write
so thank you too!

> > > - bpf_trace_printk always expected fmt[fmt_size] to be the terminating
> > >   NULL character, this is no longer true, the first 0 is terminating.
> >
> > You mean if you had bpf_trace_printk("bla bla\0some more bla\0", 24)
> > it would emit that zero character? If yes, I don't think it was a sane
> > behavior anyways.

The call to snprintf in bpf_do_trace_printk would eventually ignore
"some more bla" but the parsing done in bpf_trace_printk would indeed
read the whole string.

> > This is great, you already saved some lines of code! I suspect I'll
> > have some complaints about mods (it feels like this preample should
> > provide extra information about which arguments have to be read from
> > kernel/user memory, but I'll see next patches first.
>
> Disregard the last part (at least for now). I had a mental model that
> it should be possible to parse a format string once and then remember
> "instructions" (i.e., arg1 is long, arg2 is string, and so on). But
> that's too complicated, so I think re-parsing the format string is
> much simpler.

I also wanted to do that originally but realized it would keep a lot
of the complexity in the helpers themselves and not really move the
needle.

> > > +/* Horrid workaround for getting va_list handling working with different
> > > + * argument type combinations generically for 32 and 64 bit archs.
> > > + */
> > > +#define BPF_CAST_FMT_ARG(arg_nb, args, mod)                            \
> > > +       ((mod[arg_nb] == BPF_PRINTF_LONG_LONG ||                        \
> > > +        (mod[arg_nb] == BPF_PRINTF_LONG && __BITS_PER_LONG == 64))     \
> > > +         ? args[arg_nb]                                                \
> > > +         : ((mod[arg_nb] == BPF_PRINTF_LONG ||                         \
> > > +            (mod[arg_nb] == BPF_PRINTF_INT && __BITS_PER_LONG == 32))  \
> >
> > is this right? INT is always 32-bit, it's only LONG that differs.
> > Shouldn't the rule be
> >
> > (LONG_LONG || LONG && __BITS_PER_LONG) -> (__u64)args[args_nb]
> > (INT || LONG && __BITS_PER_LONG == 32) -> (__u32)args[args_nb]
> >
> > Does (long) cast do anything fancy when casting from u64? Sorry, maybe
> > I'm confused.

To be honest, I am also confused by that logic... :p My patch tries to
conserve exactly the same logic as "88a5c690b6 bpf: fix
bpf_trace_printk on 32 bit archs" because I was also afraid of missing
something and could not test it on 32 bit arches. From that commit
description, it is unclear to me what "u32 and long are passed
differently to u64, since the result of C conditional operators
follows the "usual arithmetic conversions" rules" means. Maybe Daniel
can comment on this ?

> > > +int bpf_printf_preamble(char *fmt, u32 fmt_size, const u64 *raw_args,
> > > +                       u64 *final_args, enum bpf_printf_mod_type *mod,
> > > +                       u32 num_args)
> > > +{
> > > +       struct bpf_printf_buf *bufs = this_cpu_ptr(&bpf_printf_buf);
> > > +       int err, i, fmt_cnt = 0, copy_size, used;
> > > +       char *unsafe_ptr = NULL, *tmp_buf = NULL;
> > > +       bool prepare_args = final_args && mod;
> >
> > probably better to enforce that both or none are specified, otherwise
> > return error

Fair :)

> it's actually three of them: raw_args, mod, and num_args, right? All
> three are either NULL or non-NULL.

It is a bit tricky to see from that patch but in "3/6 bpf: Add a
bpf_snprintf helper" the verifier code calls this function with
num_args != 0 to check whether the number of arguments is correct
without actually converting anything.

Also when the helper gets called, raw_args can come from the BPF
program and be NULL but in that case we will also have num_args = 0
guaranteed by the helper so the loop will bail out if it encounters a
format specifier.

> > > +       enum bpf_printf_mod_type current_mod;
> > > +       size_t tmp_buf_len;
> > > +       u64 current_arg;
> > > +       char fmt_ptype;
> > > +
> > > +       for (i = 0; i < fmt_size && fmt[i] != '\0'; i++) {
> >
> > Can we say that if the last character is not '\0' then it's a bad
> > format string and return -EINVAL? And if \0 is inside the format
> > string, then it's also a bad format string? I wonder what others think
> > about this?... I think sanity should prevail.

Overall, there are two situations:
- bpf_seq_printf, bpf_trace_printk: we have a pointer and size but we
are not guaranteed zero-termination
- bpf_snprintf: we have a pointer, no size but it's guaranteed to be
zero-terminated (by ARG_PTR_TO_CONST_STR)

Currently, in the bpf_snprintf helper, I set fmt_size to UINT_MAX and
the terminating condition will be fmt[i] == '\0'.
As you pointed out a bit further, I got a bit carried away with the
refactoring and dropped the zero-termination checks for the existing
helpers !

So I see two possibilities:
- either we check fmt[last] == '\0', add a bail out condition in the
loop if we encounter another `\0` and set fmt_size to sprintf(fmt) in
the bpf_snprintf verifier and helper code.
- or we unconditionally call strnlen(fmt, fmt_size) in
bpf_printf_preamble. If no 0 is found, we return an error, if there is
one we treat it as the NULL terminating character.

> > > +               if ((!isprint(fmt[i]) && !isspace(fmt[i])) ||
> > > +                   !isascii(fmt[i])) {
> >
> > && always binds tighter than ||, so you can omit extra (). I'd put
> > this on a single line as well, but that's a total nit.

Neat! :)

> > > +                       err = -EINVAL;
> > > +                       goto out;
> > > +               }
> > >
> > >                 if (fmt[i] != '%')
> > >                         continue;
> > >
> > > -               if (fmt_cnt >= 3)
> > > -                       return -EINVAL;
> > > +               if (fmt[i + 1] == '%') {
> > > +                       i++;
> > > +                       continue;
> > > +               }
> > > +
> > > +               if (fmt_cnt >= num_args) {
> > > +                       err = -EINVAL;
> > > +                       goto out;
> > > +               }
> > >
> > >                 /* fmt[i] != 0 && fmt[last] == 0, so we can access fmt[i + 1] */
> > >                 i++;
> > > -               if (fmt[i] == 'l') {
> > > -                       mod[fmt_cnt]++;
> > > +
> > > +               /* skip optional "[0 +-][num]" width formating field */
> >
> > typo: formatting

Fixed

> > > +               while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
> > > +                      fmt[i] == ' ')
> > > +                       i++;
> > > +               if (fmt[i] >= '1' && fmt[i] <= '9') {
> > >                         i++;
> >
> > Are we worried about integer overflow here? %123123123123123d
> > hopefully won't crash anything, right?

I expect that this should be handled gracefully by the subsequent call
to snprintf(). Our parsing logic does not guarantee that the format
string is 100% legit but it guarantees that it's safe to call
vsnprintf with arguments coming from BPF. If the output buffer is too
small to hold the output, the output will be truncated.

Note that this is already how bpf_seq_printf already works.

> > > -               } else if (fmt[i] == 'p') {
> > > -                       mod[fmt_cnt]++;
> > > -                       if ((fmt[i + 1] == 'k' ||
> > > -                            fmt[i + 1] == 'u') &&
> > > +                       while (fmt[i] >= '0' && fmt[i] <= '9')
> > > +                               i++;
> >
> > whoa, fmt_size shouldn't be ignored

Oh no, I'll attach the stone of shame! It all made sense with
bpf_snprintf() in mind because, there, we are guaranteed to have a
NULL terminated string already but in an excess of refactoring
enthusiasm I dropped the zero-termination check for the other helpers.

But if we implement either of the options discussed above, then we do
not need to constantly check fmt_size.

> > > +               }
> > > +
> >
> > and here if we exhausted all format string but haven't gotten to
> > format specified, we should -EINVAL
> >
> > if (i >= fmt_size) return -EINVAL?

Same comment as above, if we are already guaranteed zero-termination
by a prior check, we don't need that.

> > > +               if (fmt[i] == 'p') {
> > > +                       current_mod = BPF_PRINTF_LONG;
> > > +
> > > +                       if ((fmt[i + 1] == 'k' || fmt[i + 1] == 'u') &&
> > >                             fmt[i + 2] == 's') {
> >
> > right, if i + 2 is ok to access? always be remembering about fmt_size

Same.

> > >                                 fmt_ptype = fmt[i + 1];
> > >                                 i += 2;
> > >                                 goto fmt_str;
> > >                         }
> > >
> > > -                       if (fmt[i + 1] == 'B') {
> > > -                               i++;
> > > +                       if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
> > > +                           ispunct(fmt[i + 1]) || fmt[i + 1] == 'K' ||
> > > +                           fmt[i + 1] == 'x' || fmt[i + 1] == 'B' ||
> > > +                           fmt[i + 1] == 's' || fmt[i + 1] == 'S') {
> > > +                               /* just kernel pointers */
> > > +                               if (prepare_args)
> > > +                                       current_arg = raw_args[fmt_cnt];
> >
> > fmt_cnt is not the best name, imo. arg_cnt makes more sense

Mh, we already have "num_args" that can make it confusing. The way I see it:
- the number of format specifiers is the number of %d %s... in the format string
- the number of arguments is the number of values given in the raw_args array.

Potentially, the number of arguments can be higher than the number of
format specifiers, for example printf("%d\n", i, j); so calling them
differently sorta makes sense.
But to be honest I don't have a strong opinion about this and this is
mainly just a remaining from the current bpf_seq_printf
implementation.

> > > +                       if (!tmp_buf) {
> > > +                               used = this_cpu_inc_return(bpf_printf_buf_used);
> > > +                               if (WARN_ON_ONCE(used > 1)) {
> > > +                                       this_cpu_dec(bpf_printf_buf_used);
> > > +                                       return -EBUSY;
> > > +                               }
> > > +                               preempt_disable();
> >
> > shouldn't we preempt_disable before we got bpf_printf_buf_used? if we
> > get preempted after incrementing counter, buffer will be unusable for
> > a while, potentially, right?

Good catch :)

> > > +                       if (!tmp_buf) {
> > > +                               used = this_cpu_inc_return(bpf_printf_buf_used);
> > > +                               if (WARN_ON_ONCE(used > 1)) {
> > > +                                       this_cpu_dec(bpf_printf_buf_used);
> > > +                                       return -EBUSY;
> > > +                               }
> > > +                               preempt_disable();
> > > +                               tmp_buf = bufs->tmp_buf;
> > > +                               tmp_buf_len = MAX_PRINTF_BUF_LEN;
> > > +                       }
> >
> > how about helper used like this:
> >
> > if (try_get_fmt_tmp_buf(&tmp_buf, &tmp_buf_len))
> >    return -EBUSY;
> >
> > which will do nothing if tmp_buf != NULL?

Yep, I quite like that. :)

> > >  fmt_next:
> > > +               if (prepare_args) {
> >
> > I'd ditch prepare_args variable and just check final_args (and that
> > check to ensure both mods and final_args are specified I suggested
> > above)

Agreed.

> > > +                       mod[fmt_cnt] = current_mod;
> > > +                       final_args[fmt_cnt] = current_arg;
> > > +               }
> > >                 fmt_cnt++;
> > >         }
> >
> > [...]
> >
> > > -
> > > -       return __BPF_TP_EMIT();
> > > +       err = 0;
> > > +out:
> > > +       bpf_printf_postamble();
> >
> > naming is hard, but preamble and postamble reads way too fancy :)
> > bpf_printf_prepare() and bpf_printf_cleanup() or something like that
> > is a bit more to the point, no?

Haha, you're totally right.

> > > +       if (data_len & 7 || data_len > MAX_SEQ_PRINTF_VARARGS * 8 ||
> > > +           (data_len && !data))
> >
> > data && !data_len is also an error, no?

Isn't that checked by the verifier ?

I don't mind adding an explicit check for it (data_len ^ data or two
clearer conditions ?) but I think that even if this were to happen,
this would not be a problem: if we encounter a format specifier,
num_args will be zero so bpf_printf_preamble will bail out before it
tries to access data.
