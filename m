Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0ED4ACB5F
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 22:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbiBGVcZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 16:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiBGVcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 16:32:25 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94252C061355
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 13:32:24 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e8so12241288ilm.13
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 13:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9TlPQGwub+GgET581xKIkxrS8RD+Zw3OTcnE7P6Tzc=;
        b=CcQLceAT4jf/WUbhm7y/klfe9rEcoqoV4Qxfzhy591BG7DP22ZoC8Nj3VbczpRmP6Q
         J1cQwbLAvzgMguk4fK9j9i8yO38I9Oorge3eN1H+XxjQo4kfB23ELJPKSbUvbYWhXw4m
         VaCpoMmT9yJ6Waukvxm8Y+8h+Y79hEfb0aLe8mpY/WdqQTec9CC+qcbEDH1VI49dfwaU
         HCaPaPiX8qE8EdYZj+fKo55Y/DgSdjZeQeGiMTFJMStxWzQhMp3kjh9Oznp60S6xKPAJ
         BIYjl5vitAorIxOs5vWfvR9BStNiC0Vn954wXx+Bojeec8pYKnrOEIdhRmddolFJDDsR
         pD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9TlPQGwub+GgET581xKIkxrS8RD+Zw3OTcnE7P6Tzc=;
        b=g5bpRU7J5zKnvVqhEN9jaqBNFodQBI8r8KmdkoBt6k1jhyDNPQCB4TIpkpqvtYEk3Q
         6rIAE9mza+81Ql+Na4f6tULp5/IzcTyVSA3i1OI7YY4uq+YYnM5QUtYzssYYTNoTdv7S
         nSgK3wpaP2D1N8K/eFdhm8dAakzi3hn4ZDfR/dSvQpJzF6/RH3wzyGkLWhihQI2P2Fy4
         MZvQSA9fxK681mtVl+aNfoK4JtLA9IhCkcYk0ftI6qbiu8rMmkNZiTV27iZdfAB2G+NS
         jwG0Bsl21ISrjBwuWmULfebdUUuA4iv3faRUWtsiGCB4Jrv0WaYlUnIJCGkw3KvYlFub
         9Qjw==
X-Gm-Message-State: AOAM531ayTZ0xE+5Y23BfLcT44ZWUel+VRhlS8tTk8y+JVTfj+6eJzHm
        hV9RJHcbJjHVMk1/JsFrkUOE+kdHUOhvqgZoAqU=
X-Google-Smtp-Source: ABdhPJzv31cUamnBRXHFJG6ZptzJJpvkXmgLeQVoyF9soBxxeD8xNUdaYY8k36wU+hqJ9vSpkAmcQKasjYhcyPjzWJ0=
X-Received: by 2002:a05:6e02:1b81:: with SMTP id h1mr716529ili.239.1644269543731;
 Mon, 07 Feb 2022 13:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20220205012705.1077708-1-andrii@kernel.org> <20220205012705.1077708-2-andrii@kernel.org>
 <alpine.LRH.2.23.451.2202071054010.9037@MyRouter>
In-Reply-To: <alpine.LRH.2.23.451.2202071054010.9037@MyRouter>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Feb 2022 13:32:12 -0800
Message-ID: <CAEf4BzY9zu28fFo4sRm+KZiQ_7x07b5J6xNAP5X725BSx6f78w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: allow BPF program auto-attach
 handlers to bail out
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

On Mon, Feb 7, 2022 at 4:17 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Sat, 5 Feb 2022, Andrii Nakryiko wrote:
>
> > Allow some BPF program types to support auto-attach only in subste of
> > cases. Currently, if some BPF program type specifies attach callback, it
> > is assumed that during skeleton attach operation all such programs
> > either successfully attach or entire skeleton attachment fails. If some
> > program doesn't support auto-attachment from skeleton, such BPF program
> > types shouldn't have attach callback specified.
> >
>
> This is a great feature! I've had cases where I had to
> implement custom section-specific handling before, so this
> will make that process much easier!
>
> > This is limiting for cases when, depending on how full the SEC("")
> > definition is, there could either be enough details to support
> > auto-attach or there might not be and user has to use some specific API
> > to provide more details at runtime.
> >
> > One specific example of such desired behavior might be SEC("uprobe"). If
> > it's specified as just uprobe auto-attach isn't possible. But if it's
> > SEC("uprobe/<some_binary>:<some_func>") then there are enough details to
> > support auto-attach.
>
> Would be good to describe the different handling for explicit
> bpf_program__attach() (which fails when auto-attach is supported
> but does not return a non-NULL link) vs bpf_object__attach_skeleton()
> (which skips the NULL link case) here I think; it's all clarified in
> comments below but no harm to reiterate at the top-level I think.


Ok, I'll mention the difference here as well.

>
> >
> > Another improvement to the way libbpf is handling SEC()s would be to not
> > require providing dummy kernel function name for kprobe. Currently,
> > SEC("kprobe/whatever") is necessary even if actual kernel function is
> > determined by user at runtime and bpf_program__attach_kprobe() is used
> > to specify it. With changes in this patch, it's possible to support both
> > SEC("kprobe") and SEC("kprobe/<actual_kernel_function"), while only in
> > the latter case auto-attach will be performed. In the former one, such
> > kprobe will be skipped during skeleton attach operation.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> A few nits and suggestions for future, but this looks great!

Thanks for review!

>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> > ---
> >  tools/lib/bpf/libbpf.c | 110 +++++++++++++++++++++++++----------------
> >  1 file changed, 67 insertions(+), 43 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 904cdf83002b..2902534def2c 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -209,11 +209,12 @@ struct reloc_desc {
> >       };
> >  };
> >
> > -struct bpf_sec_def;
> > -
> > -typedef int (*init_fn_t)(struct bpf_program *prog, long cookie);
> > -typedef int (*preload_fn_t)(struct bpf_program *prog, struct bpf_prog_load_opts *opts, long cookie);
> > -typedef struct bpf_link *(*attach_fn_t)(const struct bpf_program *prog, long cookie);
> > +typedef int (*libbpf_prog_init_fn_t)(struct bpf_program *prog, long cookie);
> > +typedef int (*libbpf_prog_preload_fn_t)(struct bpf_program *prog,
> > +                                     struct bpf_prog_load_opts *opts, long cookie);
> > +/* If auto-attach is not supported, callback should return 0 and set link to NULL */
> > +typedef int (*libbpf_prog_attach_fn_t)(const struct bpf_program *prog, long cookie,
> > +                                    struct bpf_link **link);
> >
> >  /* stored as sec_def->cookie for all libbpf-supported SEC()s */
> >  enum sec_def_flags {
> > @@ -247,9 +248,9 @@ struct bpf_sec_def {
> >       enum bpf_attach_type expected_attach_type;
> >       long cookie;
> >
> > -     init_fn_t init_fn;
> > -     preload_fn_t preload_fn;
> > -     attach_fn_t attach_fn;
> > +     libbpf_prog_init_fn_t init_fn;
> > +     libbpf_prog_preload_fn_t preload_fn;
> > +     libbpf_prog_attach_fn_t attach_fn;
> >  };
> >
> >  /*
> > @@ -8589,12 +8590,12 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
> >       __VA_ARGS__                                                         \
> >  }
> >
> > -static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cookie);
> > -static struct bpf_link *attach_tp(const struct bpf_program *prog, long cookie);
> > -static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cookie);
> > -static struct bpf_link *attach_trace(const struct bpf_program *prog, long cookie);
> > -static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie);
> > -static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie);
> > +static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> > +static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> > +static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> > +static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> > +static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> > +static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >
>
> One thought here - in the future it might be useful to export
> these internal auto-attach functions.  The reason I suggest this
> is some use-cases of auto-attach might involve pre-processing of
> the section name, and once the required info is extracted the
> auto-attach function could use the original auto-attach functionality.
> That could be done separately to what you're doing here of course.
>
> One concrete example of this: I had a BPF program which consisted
> of BPF programs containing required attachments to top-level protocol
> module functions along with a set of optional attachments to
> transport-specific module functions.  Since multiple transports were
> possible, it was always possible that module A wouldn't be loaded
> while module B was, or vice versa.  To deal with this, I used the
> "o" prefix (optional) for the associated kprobe/kretprobe section
> definitions; an "okprobe" might not attach, but a "kprobe" should.
>
> Using the mechanisms in this patch set, this could be easily
> implemented by a custom auto-attach which looked for the "o"
> then passed the rest of the section string into the default
> auto-attach function for kprobes, handling attach errors for
> optional sections while passing them through for required ones.
> Tracers might find such pre-processing combined with the default
> mechanisms useful too; we could even potentially implement
> support for ":" separators this way too (convert instances
> of ":" to "/" and then call default auto-attach)!

I'd really like to avoid exposing internal libbpf code as much as
possible. If someone has some complicated use case, they should be
ready to redo some of libbpf parsing, if necessary. Gutting libbpf
internals more than necessary for the convenience of few advanced
users isn't the right trade off from my POV. In the end, there are all
the bpf_program__attach_xxx() APIs, so it's mostly about parsing
"kprobe/<func>", which usually is not big of a deal.

>
> >  static const struct bpf_sec_def section_defs[] = {
> >       SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE | SEC_SLOPPY_PFX),
> > @@ -10101,14 +10102,13 @@ struct bpf_link *bpf_program__attach_kprobe(const struct bpf_program *prog,
> >       return bpf_program__attach_kprobe_opts(prog, func_name, &opts);
> >  }
> >
> > -static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cookie)
> > +static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> >  {
> >       DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
> >       unsigned long offset = 0;
> > -     struct bpf_link *link;
> >       const char *func_name;
> >       char *func;
> > -     int n, err;
> > +     int n;
> >
> >       opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe/");
> >       if (opts.retprobe)

[...]

> > @@ -10646,17 +10646,31 @@ bpf_program__attach_iter(const struct bpf_program *prog,
> >       return link;
> >  }
> >
> > -static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie)
> > +static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> >  {
> > -     return bpf_program__attach_iter(prog, NULL);
> > +     *link = bpf_program__attach_iter(prog, NULL);
> > +     return libbpf_get_error(*link);
> >  }
> >
> >  struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
> >  {
> > +     struct bpf_link *link;
>
> might be no harm to initialize link to NULL; we could imagine
> a user-supplied auto-attach function bailing early and not
> remembering to set it explicitly.

Sure, will do in v2.

>
> > +     int err;
> > +
> >       if (!prog->sec_def || !prog->sec_def->attach_fn)
> > -             return libbpf_err_ptr(-ESRCH);
> > +             return libbpf_err_ptr(-EOPNOTSUPP);
> > +
> > +     err = prog->sec_def->attach_fn(prog, prog->sec_def->cookie, &link);
> > +     if (err)
> > +             return libbpf_err_ptr(err);
> > +
> > +     /* auto-attach support is optional (see also comment in
> > +      * bpf_object__attach_skeleton()), but when explicitly expected by
> > +      * user it's an error if it's not */
>
> nit: checkpatch wants the closing "*/" on the next line.

yep, missed during reformatting

> Also I think it would be good to clarify along the lines
> of "when calling bpf_program__attach() explicitly, auto-attach
> support is expected to work, and a NULL link is considered as
> an error.  See comment in bpf_object__attach_skeleton() which
> describes different handling of the 0 return value/NULL link
> there."

Ok, I'll adjust the comment.

>
> > +     if (!link)
> > +             return libbpf_err_ptr(-EOPNOTSUPP);
> >
> > -     return prog->sec_def->attach_fn(prog, prog->sec_def->cookie);
> > +     return link;
> >  }
> >
> >  static int bpf_link__detach_struct_ops(struct bpf_link *link)
> > @@ -11800,13 +11814,23 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
> >               if (!prog->sec_def || !prog->sec_def->attach_fn)
> >                       continue;
> >
> > -             *link = bpf_program__attach(prog);
> > -             err = libbpf_get_error(*link);
> > +             err = prog->sec_def->attach_fn(prog, prog->sec_def->cookie, link);
> >               if (err) {
> > -                     pr_warn("failed to auto-attach program '%s': %d\n",
> > +                     pr_warn("prog '%s': failed to auto-attach: %d\n",
> >                               bpf_program__name(prog), err);
> >                       return libbpf_err(err);
> >               }
> > +
> > +             /* It's possible that for some SEC() definitions auto-attach
> > +              * is supported in some cases (e.g., if definition completely
> > +              * specifies target information), but is not in other cases.
> > +              * SEC("uprobe") is one such case. If user specified target
> > +              * binary and function name, such BPF program can be
> > +              * auto-attached. But if not, it shouldn't trigger skeleton's
> > +              * attach to fail. It should just be skipped.
> > +              * attach_fn signals such case with returning 0 (no error) and
> > +              * setting link to NULL.
> > +              */
> >       }
> >
> >       return 0;
> > --
> > 2.30.2
> >
> >
