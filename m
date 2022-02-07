Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585F24ACB75
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 22:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbiBGVl5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 16:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241431AbiBGVl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 16:41:57 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C68EC0612A4
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 13:41:56 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id m8so5757676ilg.7
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 13:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9gNAESMliUKAedjJq5OJ4VsZdvjyIrDDUhly4jEJRA=;
        b=Ql0xf/Q4p6mTnV15kdF0HrJkNJmekoDoQB5m6DMU9uS3i1/TfJm2seogcQbIIEUDv6
         qk8WbMT9MfP5WngrZwbvQ+HkShIjdvrk+xOHje8GpzNXtK2ZGtI2JtoiyKZqlmJwhQ8F
         a+lSBxxt61CXuuvQUE1cJglc4eRl5lfeYH/sU54irek287t7u/armTcOlw0BE2/2LluO
         Pa09vbx9xdOmBNR8kiFZNbyXLANjumZsF55vWpqCD/Ei6Zz48ELtIScB0uH+4Tcthy9P
         rYsitAHjLAgJUbNtZkQfiVyaIyerPf1IZFyeWdCmYqrsY0YL2q6XnVle10HTyohOvUfr
         /iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9gNAESMliUKAedjJq5OJ4VsZdvjyIrDDUhly4jEJRA=;
        b=xXg6ngqwdP2T1uP6ISPK9w8phPxvFZLy54tr/YAW9VIZRPuSX0TCet1JpmRkKJu4sb
         r0V3bmZ4u52IGUpv+M7b/OMPzkHDpOUpzdu+qeCeW3z0aA3tlycpMsrcaMUKDo0rDiiH
         jaAzujwcHWCZFCH/PKjcVkjiixPQKYyNEuiNvB88q0rvE99MrMpP6NFZchXfK4/Gsuyv
         3llWUlkdEHiLzdT8iQCQhpv94kvviNBA489r5ulfe7VEkN+FBkH3J3E95Boxl4fdQMun
         pEURPT3FPIru5kunLXFRRjeJsM2gCrkWI0WUON6uJcl+Q2DcDkicgOoF01gUJSuyjrvX
         qpcw==
X-Gm-Message-State: AOAM531pzPkcxI+PCJ4Ub1awLiP49rWAHuwnnj3/9MUlubv1WPAX3VgU
        HE62Jz1w4Q6VCKnPjzAFryf7KMnj9l8Fbw3b0jc=
X-Google-Smtp-Source: ABdhPJxbfcriL9+Z673u8630VkySMtb8g0p7h/o4x/rfZFT0jeGIG6UKMmVsbn4yDSHm3DuYEqheP5XMi5qOGbCPYG4=
X-Received: by 2002:a05:6e02:1bcd:: with SMTP id x13mr717585ilv.98.1644270115985;
 Mon, 07 Feb 2022 13:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20220205012705.1077708-1-andrii@kernel.org> <20220205012705.1077708-4-andrii@kernel.org>
 <alpine.LRH.2.23.451.2202071222170.9037@MyRouter>
In-Reply-To: <alpine.LRH.2.23.451.2202071222170.9037@MyRouter>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Feb 2022 13:41:44 -0800
Message-ID: <CAEf4Bzbx30RrZ_EAMWYvstsGfuCv5Ggeatfxw3hM+sGg60TgzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: support custom SEC() handlers
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, Feb 7, 2022 at 5:57 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Sat, 5 Feb 2022, Andrii Nakryiko wrote:
>
> > Allow registering and unregistering custom handlers for BPF program.
> > This allows user applications and libraries to plug into libbpf's
> > declarative SEC() definition handling logic. This allows to offload
> > complex and intricate custom logic into external libraries, but still
> > provide a great user experience.
> >
> > One such example is USDT handling library, which has a lot of code and
> > complexity which doesn't make sense to put into libbpf directly, but it
> > would be really great for users to be able to specify BPF programs with
> > something like SEC("usdt/<path-to-binary>:<usdt_provider>:<usdt_name>")
> > and have correct BPF program type set (BPF_PROGRAM_TYPE_KPROBE, as it is
> > uprobe) and even support BPF skeleton's auto-attach logic.
> >
> > In some cases, it might be even good idea to override libbpf's default
> > handling, like for SEC("perf_event") programs. With custom library, it's
> > possible to extend logic to support specifying perf event specification
> > right there in SEC() definition without burdening libbpf with lots of
> > custom logic or extra library dependecies (e.g., libpfm4). With current
> > patch it's possible to override libbpf's SEC("perf_event") handling and
> > specify a completely custom ones.
> >
> > Further, it's possible to specify a generic fallback handling for any
> > SEC() that doesn't match any other custom or standard libbpf handlers.
> > This allows to accommodate whatever legacy use cases there might be, if
> > necessary.
> >
> > See doc comments for libbpf_register_prog_handler() and
> > libbpf_unregister_prog_handler() for detailed semantics.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c   | 201 +++++++++++++++++++++++++++++----------
> >  tools/lib/bpf/libbpf.h   |  81 ++++++++++++++++
> >  tools/lib/bpf/libbpf.map |   2 +
> >  3 files changed, 232 insertions(+), 52 deletions(-)
> >

[...]

> > -             /* "type+" means it can be either exact SEC("type") or
> > -              * well-formed SEC("type/extras") with proper '/' separator
> > -              */
> > -             if (sec_def->sec[len - 1] == '+') {
> > -                     len--;
> > -                     /* not even a prefix */
> > -                     if (strncmp(sec_name, sec_def->sec, len) != 0)
> > -                             continue;
> > -                     /* exact match or has '/' separator */
> > -                     if (sec_name[len] == '\0' || sec_name[len] == '/')
> > -                             return sec_def;
> > -                     continue;
> > -             }
> > +             custom_sec_defs = sec_def;
> > +             sec_def = &custom_sec_defs[custom_sec_def_cnt];
> > +     } else {
> > +             if (has_custom_fallback_def)
> > +                     return libbpf_err(-EBUSY);

this disallows two fallback handlers

> >
> > -             /* SEC_SLOPPY_PFX definitions are allowed to be just prefix
> > -              * matches, unless strict section name mode
> > -              * (LIBBPF_STRICT_SEC_NAME) is enabled, in which case the
> > -              * match has to be exact.
> > -              */
> > -             if ((sec_flags & SEC_SLOPPY_PFX) && !strict)  {
> > -                     if (str_has_pfx(sec_name, sec_def->sec))
> > -                             return sec_def;
> > -                     continue;
> > -             }
> > +             sec_def = &custom_fallback_def;
> > +     }
> >
> > -             /* Definitions not marked SEC_SLOPPY_PFX (e.g.,
> > -              * SEC("syscall")) are exact matches in both modes.
> > -              */
> > -             if (strcmp(sec_name, sec_def->sec) == 0)
> > +     sec_def->sec = sec ? strdup(sec) : NULL;
> > +     if (sec && !sec_def->sec)
> > +             return libbpf_err(-ENOMEM);
> > +
> > +     sec_def->prog_type = prog_type;
> > +     sec_def->expected_attach_type = exp_attach_type;
> > +     sec_def->cookie = cookie;
> > +
> > +     sec_def->init_fn = prog_init_fn;
> > +     sec_def->preload_fn = prog_preload_fn;
> > +     sec_def->attach_fn = prog_attach_fn;
> > +
> > +     sec_def->handler_id = ++last_custom_sec_def_handler_id;
> > +
> > +     if (sec)
> > +             custom_sec_def_cnt++;
> > +     else
> > +             has_custom_fallback_def = true;
> > +
>
> should we try and deal with the (unlikely) case that multiple
> fallback definitions are supplied, since only the first will
> be used? i.e
>
> if (!sec && has_custom_fallback_def)
>         return -EEXIST;
>
> ?
>

I do that slightly earlier, see comment above

> > +     return sec_def->handler_id;
> > +}
> > +
> > +int libbpf_unregister_prog_handler(int handler_id)
> > +{
> > +     int i;
> > +
> > +     if (handler_id <= 0)
> > +             return libbpf_err(-EINVAL);
> > +
> > +     if (has_custom_fallback_def && custom_fallback_def.handler_id == handler_id) {
> > +             memset(&custom_fallback_def, 0, sizeof(custom_fallback_def));
> > +             has_custom_fallback_def = false;
> > +             return 0;
> > +     }
> > +
> > +     for (i = 0; i < custom_sec_def_cnt; i++) {
> > +             if (custom_sec_defs[i].handler_id == handler_id)
> > +                     break;
> > +     }
> > +
> > +     if (i == custom_sec_def_cnt)
> > +             return libbpf_err(-ENOENT);
> > +
> > +     free(custom_sec_defs[i].sec);
> > +     for (i = i + 1; i < custom_sec_def_cnt; i++)
> > +             custom_sec_defs[i - 1] = custom_sec_defs[i];
> > +     custom_sec_def_cnt--;
>
> We're leaking a custom table entry each time we register/deregister.
> We could libbpf_reallocarray() to trim here I think.

It's not leaking, we just don't downsize the array. If there are
subsequent registrations we'll just reuse those slots, so it's not a
leak. It doesn't seem likely that applications will add thousands of
custom handlers, then unregister all of them and never add any new
ones (and even in that case we are talking about a few kilobytes of
memory). So it felt unnecessary to try to trim anything.

But if you feel it's important, I can add libbpf_reallocarray() as
well, no big deal.

>
> > +
> > +     return 0;
> > +}
> > +

[...]

> > +/**
> > + * @brief **libbpf_register_prog_handler()** registers a custom BPF program
> > + * SEC() handler.
> > + * @param sec section prefix for which custom handler is registered
> > + * @param prog_type BPF program type associated with specified section
> > + * @param exp_attach_type Expected BPF attach type associated with specified section
> > + * @param prog_init_fn BPF program initialization callback (see libbpf_prog_init_fn_t)
> > + * @param prog_preload_fn BPF program loading callback (see libbpf_prog_preload_fn_t)
> > + * @param prog_attach_fn BPF program attach callback (see libbpf_prog_attach_fn_t)
> > + * @param cookie User-provided cookie passed to each callback
> > + * @param opts reserved for future extensibility, should be NULL
> > + * @return Non-negative handler ID is returned on success. This handler ID has
> > + * to be passed to *libbpf_unregister_prog_handler()* to unregister such
> > + * custom handler. Negative error code is returned on error.
> > + *
> > + * *sec* defines which SEC() definitions are handled by this custom handler
> > + * registration. *sec* can have few different forms:
> > + *   - if *sec* is just a plain string (e.g., "abc"), it will match only
> > + *   SEC("abc"). If BPF program specifies SEC("abc/whatever") it will result
> > + *   in an error;
> > + *   - if *sec* is of the form "abc/", proper SEC() form is
> > + *   SEC("abc/something"), where acceptable "something" should be checked by
> > + *   *prog_init_fn* callback, if there are additional restrictions;
> > + *   - if *sec* is of the form "abc+", it will successfully match both
> > + *   SEC("abc") and SEC("abc/whatever") forms;
> > + *   - if *sec* is NULL, custom handler is registered for any BPF program that
> > + *   doesn't match any of the registered (custom or libbpf's own) SEC()
> > + *   handlers. There could be only one such generic custom handler registered
> > + *   at any given time.
> > + *
> > + * All custom handlers (except the one with *sec* == NULL) are processed
> > + * before libbpf's own SEC() handlers. It is allowed to "override" libbpf's
> > + * SEC() handlers by registering custom ones for the same section prefix
> > + * (i.e., it's possible to have custom SEC("perf_event/LLC-load-misses")
> > + * handler).
> > + */
>
> Nicely documented!
>

Thanks!

> > +LIBBPF_API int libbpf_register_prog_handler(const char *sec,
> > +                                         enum bpf_prog_type prog_type,
> > +                                         enum bpf_attach_type exp_attach_type,
> > +                                         libbpf_prog_init_fn_t prog_init_fn,
> > +                                         libbpf_prog_preload_fn_t prog_preload_fn,
> > +                                         libbpf_prog_attach_fn_t prog_attach_fn,
>
> Naming nit: a prog_handler sounds less specific; would
> "sec_handler" or "prog_sec_handler" be more descriptive perhaps?

Well, SEC() is used not just for BPF programs (but maps and variables
as well), so just "sec_handler" isn't even accurate.
"prog_sec_handler" also felt a bit off, as we are handling not really
a section, but BPF program in some SEC() itself.

>
> Also, would it make sense to pass the functions in as options instead?
> They can all be NULL potentially I think, and it's possible we'd
> want additional future handlers too..

Good point, I'll add opts struct and move cookie and callback into it.

>
> > +                                         long cookie,
> > +                                         const void *opts);
> > +/**
> > + * @brief *libbpf_unregister_prog_handler()* unregisters previously registered
> > + * custom BPF program SEC() handler.
> > + * @param handler_id handler ID returned by *libbpf_register_prog_handler()*
> > + * after successful registration
> > + * @return 0 on success, negative error code if handler isn't found
> > + */
> > +LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
> > +
> >  #ifdef __cplusplus
> >  } /* extern "C" */
> >  #endif
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index aef6253a90c8..4e75f06c1a00 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -438,4 +438,6 @@ LIBBPF_0.7.0 {
> >               libbpf_probe_bpf_map_type;
> >               libbpf_probe_bpf_prog_type;
> >               libbpf_set_memlock_rlim_max;
> > +             libbpf_register_prog_handler;
> > +             libbpf_unregister_prog_handler;
> >  };
> > --
> > 2.30.2
> >
> >
