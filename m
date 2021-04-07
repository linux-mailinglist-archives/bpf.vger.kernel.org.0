Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8216D35774E
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 00:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhDGWEK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 18:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhDGWEK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Apr 2021 18:04:10 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5617C061760;
        Wed,  7 Apr 2021 15:03:59 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id l9so441244ybm.0;
        Wed, 07 Apr 2021 15:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8RptQ+5dbbOnoj82Wc9yFBjeciaToNnjyluawSljZBY=;
        b=h/ItTBbX0dQ9/CfFMRBTuFwnxxjeAX5YBCqsbhtxNlrhIXeZqNIlJXdaumYPFuJHd1
         oH7FBTmo0awBZSiyFHi3TMYjT0rvk1d3a90yXBaXo6edkOpTi6rJRxNT71HVkcUA0WMJ
         BonKyqopiA+QUWHPHS4v1FUssyw6n6peG0XwMmKxtjo5MTjYrXV7pQTnIKbQF2wfFdZL
         q8+T+cNMrQxQe4hrNYyWdn7ux5Zkj71J2isZo7Z1h1VQCmTmdToNIIWuVjRFmA0nPQBy
         u3A6xCM6rVOh3tUrF8WGoa6bvNlwHYqcQX76aQhInz9EnvL1MqVZ2b8EMXBdWl8AZDmq
         cxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8RptQ+5dbbOnoj82Wc9yFBjeciaToNnjyluawSljZBY=;
        b=fa0p8P9pSxfOxL/VtUzYYiT1G3o+0woc8N3NZAi0dwkELlvqmhXYEMcVels3SM9sjh
         ZzggBawe4yoaVd2ZGqe9Wklgd2a6lclLbzq/HsidiOCD30GxpFJWHj5vCvGUkBZ+wcNe
         rbhfsqcnU5LrNIggM4+96S/ydD/XrJvFFXGLLug4zsCxMid3zkcO3TlCPRr794lGPhYs
         DF2T0kGtoZF2UDxhNJPNCg6HGDeRg5sILkYJBfqiLPKwtcCmpuPxkB7J+gWypGHfXcd5
         5Fn+RTmWT/U2RnaigbfXGH9o0sZTUeNWjWvxPCIDr3pdgxdf46OkqiYc5ty0ecuiENKY
         dD4Q==
X-Gm-Message-State: AOAM530H4dMf4oGc9yQ3pR0v0bCofCfxWd5m0CnK6r9zgU6mCNxu4aXV
        eZ4Jthwbk/D87dbVYyfso5RsUSHh9IDxCCvgPG8gfWwfBzo=
X-Google-Smtp-Source: ABdhPJylNGwAi9gm5uZaJR0kVTamxFe1pkziARuHZU8+lEOXuCpCnfDEyUZmx34bHBJp3oe0HIBU7L04G1nSTmrR1Sw=
X-Received: by 2002:a05:6902:6a3:: with SMTP id j3mr7283642ybt.403.1617833039127;
 Wed, 07 Apr 2021 15:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-4-revest@chromium.org>
 <CAEf4Bzbfyd7r4cx8Lcjx7gm8beKxuf=wYW5StM1ZFaVaNL9U-g@mail.gmail.com> <CABRcYm+3q7a64heRVHLUu+S6xqmTGg2TuyB=JwD6V8pFiFpz_g@mail.gmail.com>
In-Reply-To: <CABRcYm+3q7a64heRVHLUu+S6xqmTGg2TuyB=JwD6V8pFiFpz_g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Apr 2021 15:03:48 -0700
Message-ID: <CAEf4BzbKJ9msu5Y5y_wvAfzeykkBxXp606YFv32iE2DoN=ZVXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Add a bpf_snprintf helper
To:     Florent Revest <revest@chromium.org>
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

On Tue, Apr 6, 2021 at 9:06 AM Florent Revest <revest@chromium.org> wrote:
>
> On Fri, Mar 26, 2021 at 11:55 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
> > > The implementation takes inspiration from the existing bpf_trace_printk
> > > helper but there are a few differences:
> > >
> > > To allow for a large number of format-specifiers, parameters are
> > > provided in an array, like in bpf_seq_printf.
> > >
> > > Because the output string takes two arguments and the array of
> > > parameters also takes two arguments, the format string needs to fit in
> > > one argument. But because ARG_PTR_TO_CONST_STR guarantees to point to a
> > > NULL-terminated read-only map, we don't need a format string length arg.
> > >
> > > Because the format-string is known at verification time, we also move
> > > most of the format string validation, currently done in formatting
> > > helper calls, into the verifier logic. This makes debugging easier and
> > > also slightly improves the runtime performance.
> > >
> > > Signed-off-by: Florent Revest <revest@chromium.org>
> > > ---
> > >  include/linux/bpf.h            |  6 ++++
> > >  include/uapi/linux/bpf.h       | 28 ++++++++++++++++++
> > >  kernel/bpf/helpers.c           |  2 ++
> > >  kernel/bpf/verifier.c          | 41 +++++++++++++++++++++++++++
> > >  kernel/trace/bpf_trace.c       | 52 ++++++++++++++++++++++++++++++++++
> > >  tools/include/uapi/linux/bpf.h | 28 ++++++++++++++++++
> > >  6 files changed, 157 insertions(+)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 7b5319d75b3e..f3d9c8fa60b3 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1893,6 +1893,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
> > >  extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
> > >  extern const struct bpf_func_proto bpf_copy_from_user_proto;
> > >  extern const struct bpf_func_proto bpf_snprintf_btf_proto;
> > > +extern const struct bpf_func_proto bpf_snprintf_proto;
> > >  extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
> > >  extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
> > >  extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
> > > @@ -2018,4 +2019,9 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
> > >  struct btf_id_set;
> > >  bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
> > >
> > > +enum bpf_printf_mod_type;
> > > +int bpf_printf_preamble(char *fmt, u32 fmt_size, const u64 *raw_args,
> > > +                       u64 *final_args, enum bpf_printf_mod_type *mod,
> > > +                       u32 num_args);
> > > +
> > >  #endif /* _LINUX_BPF_H */
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 2d3036e292a9..86af61e912c6 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -4660,6 +4660,33 @@ union bpf_attr {
> > >   *     Return
> > >   *             The number of traversed map elements for success, **-EINVAL** for
> > >   *             invalid **flags**.
> > > + *
> > > + * long bpf_snprintf(char *str, u32 str_size, const char *fmt, u64 *data, u32 data_len)
> > > + *     Description
> > > + *             Outputs a string into the **str** buffer of size **str_size**
> > > + *             based on a format string stored in a read-only map pointed by
> > > + *             **fmt**.
> > > + *
> > > + *             Each format specifier in **fmt** corresponds to one u64 element
> > > + *             in the **data** array. For strings and pointers where pointees
> > > + *             are accessed, only the pointer values are stored in the *data*
> > > + *             array. The *data_len* is the size of *data* in bytes.
> > > + *
> > > + *             Formats **%s** and **%p{i,I}{4,6}** require to read kernel
> > > + *             memory. Reading kernel memory may fail due to either invalid
> > > + *             address or valid address but requiring a major memory fault. If
> > > + *             reading kernel memory fails, the string for **%s** will be an
> > > + *             empty string, and the ip address for **%p{i,I}{4,6}** will be 0.
> >
> > would it make sense for sleepable programs to allow memory fault when
> > reading memory?
>
> Probably yes. How would you do that ? I'm guessing that in
> bpf_trace_copy_string you would call either strncpy_from_X_nofault or
> strncpy_from_X depending on a condition but I'm not sure which one.

So you'd have different bpf_snprintf_proto definitions for sleepable
and non-sleepable programs. And each implementation would call
bpf_printf_prepare() with a flag specifying which copy_string variant
to use (sleepable or not). So for BPF users it would be the same
bpf_snprintf() helper, but it would transparently be doing different
things depending on which BPF program it is being called from. That's
how we do bpf_get_stack(), for example, see
bpf_get_stack_proto_pe/bpf_get_stack_proto_raw_tp/bpf_get_stack_proto_tp.

But consider that for a follow up, no need to address right now.

>
> > > + *             Not returning error to bpf program is consistent with what
> > > + *             **bpf_trace_printk**\ () does for now.
> > > + *
> > > + *     Return
> > > + *             The strictly positive length of the formatted string, including
> > > + *             the trailing zero character. If the return value is greater than
> > > + *             **str_size**, **str** contains a truncated string, guaranteed to
> > > + *             be zero-terminated.
> >
> > Except when str_size == 0.
>
> Right
>

So I assume you'll adjust the comment? I always find it confusing when
zero case is allowed but it is not specified what's the behavior is.

> > > + *
> > > + *             Or **-EBUSY** if the per-CPU memory copy buffer is busy.
> > >   */

[...]

> > > +       err = snprintf(str, str_size, fmt, BPF_CAST_FMT_ARG(0, args, mod),
> > > +               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod),
> > > +               BPF_CAST_FMT_ARG(3, args, mod), BPF_CAST_FMT_ARG(4, args, mod),
> > > +               BPF_CAST_FMT_ARG(5, args, mod), BPF_CAST_FMT_ARG(6, args, mod),
> > > +               BPF_CAST_FMT_ARG(7, args, mod), BPF_CAST_FMT_ARG(8, args, mod),
> > > +               BPF_CAST_FMT_ARG(9, args, mod), BPF_CAST_FMT_ARG(10, args, mod),
> > > +               BPF_CAST_FMT_ARG(11, args, mod));
> > > +       if (str_size)
> > > +               str[str_size - 1] = '\0';
> >
> > hm... what if err < str_size ?
>
> Then there would be two zeroes, one set by snprintf in the middle and
> one set by us at the end. :| I was a bit lazy there, I agree it would
> be nicer if we'd do if (err >= str_size) instead.
>

snprintf() seems to be always zero-terminating the string if str_size
> 0, and does nothing if str_size == 0, which is exactly what you
want, so you can just drop that zero termination logic.

> Also makes me wonder what if str == NULL and str_size != 0. I just
> assumed that the verifier would prevent that from happening but
> discussions in the other patches make me unsure now.


ARG_CONST_SIZE_OR_ZERO should make sure that ARG_PTR_TO_MEM before
that is a valid initialized memory. But please double-check, of
course.
