Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D362B1307
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 01:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgKMAIO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 19:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKMAIN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 19:08:13 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23BBC0613D1;
        Thu, 12 Nov 2020 16:08:13 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id t33so7120712ybd.0;
        Thu, 12 Nov 2020 16:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6kRy7LEKcHN3YVb/VIkB22zjflXMXfF/UI6knjlop0=;
        b=Vw+qdF/1dHoogHMTN3uimHGpghjU8UINqiM+Y3/ognLbCZ3l/HRFbclohUrT0mvzbb
         0aLcr2/IP4qiO+t24buC2/6sRdeKEAEmv7lYbZjXfoeUhRKkcEGd11d6g4Jnv2IbN2Bn
         LN5VbSbfZ+b6K1N7JthFZxk48ZjIv+xECTdxifPFzGPHqmLjT4LzvasaG9msHAjTesAW
         Zi34mT1lc8gQxoFOMRwjsUV1vpoLSrql4cd0gfsAZa8LyyfveASxN8D0p7hPSz3iVrQM
         rQCdVXbvnE9b7PDYOw7AR5zb6Iq4w39PjC5pV7bEw0bqRuPYzBEmwWant5y3SpTKtR+s
         Bseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6kRy7LEKcHN3YVb/VIkB22zjflXMXfF/UI6knjlop0=;
        b=P0Y1+1Q0Hd11EOLeQK/vWJQ3YcDDTt5rX7eBkw+SrEwz9tL+XXl2xXeUhxcnKwqkN4
         1nbHCsxm7lVNq0WtzZK11CSE3CEbA2HczBlddbSq5PyoFtIvEYHZaCYvjOkeZ2a9yTAz
         G/1N7K5OmWBkkOymOupnuHyO9tlJfYxg9U9jLHTW3oHk0XonQGPTpTT/ni5/hy8aw/lo
         6k+hiMXpA4xJ1KVbPr8VAXLd+yM5B+f15jX4LWO6DEziZLvRwHW9OsjO+bBKHhw+Kw3a
         SN7j4Jd1k4+D6CMOWomKTOP7nwaywkYP61hUFSL1fRmCgQufb2e5SoUj95liaJvDnJA2
         M7ZA==
X-Gm-Message-State: AOAM532gaA/r79iAqly08lOkjr6xg4raF4iQ1Ji9qCgqAoOVAmxotDBx
        GU2Za+qXkGwlHRwWPTbdCwNeLlNe14ch1K1X9aI=
X-Google-Smtp-Source: ABdhPJylTFfsNbm5HWKGFuJGhiaHHER5wvVCr+7DbtEmVNm0qEkMsP2xptbLzrUf2tuBR/YpGzmor4IIaTm8bOxw6vI=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr3330088ybd.27.1605226093004;
 Thu, 12 Nov 2020 16:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20201112150506.705430-1-jolsa@kernel.org> <20201112150506.705430-4-jolsa@kernel.org>
 <CAEf4BzbhojeSdASwt4y4XEtgAF1caYx=-AuwzWJZv7qKgzkroA@mail.gmail.com> <20201112211413.GA733055@krava>
In-Reply-To: <20201112211413.GA733055@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Nov 2020 16:08:02 -0800
Message-ID: <CAEf4BzbePw8gksT0MH=hwp4Pv1EV1-MOeiwfoFVR64XWFccTHw@mail.gmail.com>
Subject: Re: [RFC/PATCH 3/3] btf_encoder: Func generation fix
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 1:14 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Nov 12, 2020 at 11:54:41AM -0800, Andrii Nakryiko wrote:
>
> SNIP
>
> > > @@ -624,32 +644,46 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > >                 has_index_type = true;
> > >         }
> > >
> > > -       cu__for_each_function(cu, core_id, fn) {
> > > -               /*
> > > -                * The functions_cnt != 0 means we parsed all necessary
> > > -                * kernel symbols and we are using ftrace location filter
> > > -                * for functions. If it's not available keep the current
> > > -                * dwarf declaration check.
> > > -                */
> > > -               if (functions_cnt) {
> > > +       /*
> > > +        * The functions_cnt != 0 means we parsed all necessary
> > > +        * kernel symbols and we are using ftrace location filter
> > > +        * for functions. If it's not available keep the current
> > > +        * dwarf declaration check.
> > > +        */
> > > +       if (functions_cnt) {
> > > +               cu__for_each_function(cu, core_id, fn) {
> > > +                       struct elf_function *p;
> > > +                       struct elf_function key = { .name = function__name(fn, cu) };
> > > +                       int args_cnt = 0;
> > > +
> > >                         /*
> > > -                        * We check following conditions:
> > > -                        *   - argument names are defined
> > > -                        *   - there's symbol and address defined for the function
> > > -                        *   - function address belongs to ftrace locations
> > > -                        *   - function is generated only once
> > > +                        * Collect functions that match ftrace filter
> > > +                        * and pick the one with proper argument names.
> > > +                        * The BTF generation happens at the end in
> > > +                        * btf_encoder__encode function.
> > >                          */
> > > -                       if (!has_arg_names(cu, &fn->proto))
> > > +                       p = bsearch(&key, functions, functions_cnt,
> > > +                                   sizeof(functions[0]), functions_cmp);
> > > +                       if (!p)
> > >                                 continue;
> > > -                       if (!should_generate_function(btfe, function__name(fn, cu)))
> > > +
> > > +                       if (!has_arg_names(cu, &fn->proto, &args_cnt))
> >
> > So I can't unfortunately reproduce that GCC bug with DWARF info. What
> > was exactly the symptom? Maybe you can also share readelf -wi dump for
> > your problematic vmlinux?
>
> hum, can't see -wi working for readelf, however I placed my vmlinux
> in here:
>   http://people.redhat.com/~jolsa/vmlinux.gz
>
> the symptom is that resolve_btfids will fail kernel build:
>
>   BTFIDS  vmlinux
> FAILED unresolved symbol vfs_getattr
>
> because BTF data contains multiple FUNC records for same function
>
> and the problem is that declaration tag itself is missing:
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060
> so pahole won't skip them
>
> the first workaround was to workaround that and go for function
> records that have code address attached, but that's buggy as well:
>   https://bugzilla.redhat.com/show_bug.cgi?id=1890107
>
> then after some discussions we ended up using ftrace addresses
> as filter for what we want to display.. plus we got static functions
> as well
>
> however for this way we failed to get proper arguments ;-)

Right, I followed along overall, but forgot the details of the initial
problem. Thanks for the refresher. See below for my current thoughts
on dealing with all this.

>
> >
> > The reason I'm asking is because I wonder if we should still ignore
> > functions if fn->declaration is set. E.g., for the issue we
> > investigated yesterday, the function with no arguments has declaration
> > set to 1, so just ignoring it would solve the problem. I'm wondering
> > if it's enough to do just that instead of doing this whole delayed
> > function collection/processing.
> >
> > Also, I'd imagine the only expected cases where we can override  the
> > function (args_cnt > p->args_cnt) would be if p->args_cnt == 0, no?
>
> I don't know, because originally I'd expect that we would not see
> function record with zero args when it actualy has some
>
> > All other cases are either newly discovered "bogusness" of DWARF (and
> > would be good to know about this) or it's a name collision for
> > functions. Basically, before we go all the way to rework this again,
> > let's see if just skipping declarations would be enough?
>
> so there's actualy new developement today in:
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060#c14
>
> gcc might actualy get fixed, so I think we could go back to
> using declaration tag and use ftrace as additional filter..
> at least this exercise gave us static functions ;-)
>
> however we still have fedora with disabled disabled CONFIG_DEBUG_INFO_BTF
> and will need to wait for that fix to enable that back

Right, we better have a more robust approach not relying on
not-yet-released GCC.

>
> >
> > >                                 continue;
> > > -               } else {
> > > +
> > > +                       if (!p->fn || args_cnt > p->args_cnt) {
> > > +                               p->fn = fn;
> > > +                               p->cu = cu;
> > > +                               p->args_cnt = args_cnt;
> > > +                               p->type_id_off = type_id_off;
> > > +                       }
> > > +               }
> > > +       } else {
> > > +               cu__for_each_function(cu, core_id, fn) {
> > >                         if (fn->declaration || !fn->external)
> > >                                 continue;
> > > +                       if (generate_func(btfe, cu, fn, type_id_off))
> > > +                               goto out;
> > >                 }
> >
> > I'm trending towards disliking this completely different fallback
> > mechanism. It saved bpf-next accidentally, but otherwise obscured the
> > issue and generally makes testing pahole with artificial binary BTFs
> > (from test programs) harder. How about we unify approaches, but just
> > use mcount symbols opportunistically, as an additional filter, if it's
> > available?
>
> ok
>
> >
> > With that, testing that we still handle functions with duplicate names
> > properly would be trivial (which I suspect we don't and we'll just
> > keep the one with more args now, right?) And it makes static functions
> > available for non-vmlinux binaries automatically (might be good or
> > bad, but still...).
>
> if we keep just the ftrace filter and rely on declaration tag,
> the args checking will go away right?

So I looked at your vmlinux image. I think we should just keep
everything mostly as it it right now (without changes in this patch),
but add just two simple checks:

1. Skip if fn->declaration (ignore correctly marked func declarations)
2. Skip if DW_AT_inline: 1 (ignore inlined functions).

I'd keep the named arguments check as is, I think it's helpful. 1)
will skip stuff that's explicitly marked as declaration. 2) inline
check will partially mitigate dropping of fn->external check (and we
can't really attach to inlined functions). So will the named args
check as well. Then we should do mcount checks, **if** mcount symbols
are present (which should always be the case for any reasonable
vmlinux image that's supposed to be used with BPF, I think).

So together, it should cover all known issues, I think. And then we'll
just have to watch out for any new ones. GCC bugfix is good, but it's
too late: the harm is done and there are compilers out there that we
should deal with.

>
> jirka
>
