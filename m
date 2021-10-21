Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266CC436C76
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 23:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhJUVNQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 17:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhJUVNP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 17:13:15 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8E5C0613B9
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 14:10:58 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id h19so3840941uax.5
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 14:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/J/ZanEOS2SfTaF+68+8gdnohV/x0hrcerAAUwO6+so=;
        b=qzZ8XBBaNd0mcJkEhzj2fG60FOKjWAatFI3sZoe4IA0p9h+XoOC969iMBUck0rYB2x
         O8/LvzepUEU3Y/N/MPi+0pMc0I8AZPvFX/7u7K8Bdk3jJyeUF65+9sIFoo1o4jspuGDT
         ad9PTAY83CVyg8kHWN6XH/4ztaiqidka9Fct7WEr9CFVd7j9QawQ4/+a7uWhkMKDjv97
         tcYQlE3kkJTChNX6NNVxrVwBmMXLfK5sCEB+Th7H1nyVJ9cfCfVkRGWXDh3fe8Tm/9hi
         JzHWMopbkLaMWa5k7fPWu/TTveV+WGVZi98yCldNa8iV4G/6XU7Jut+gCtGtK22NaO+p
         TaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/J/ZanEOS2SfTaF+68+8gdnohV/x0hrcerAAUwO6+so=;
        b=mmUsjy8ntYk6bILaBdO4NKW3c/un3ELIBvm4OUFGhk6C6wUU7hwqa65qNgwzPOsjQ9
         dJ7REQB5t09r1kexkPp3oEujkXYBA8VJkmV3+ZeL8ULTV9jSYPyNordj6dXGyzpUWHJE
         y7oJ4UkzpsMzJL3OhSsSc7TGH170qIGz/q9tTv7Pjbq+DjAXfO2sh1Z6Gunba9MCqQ0L
         lks4L7JlMHzfB+xnlFkl73mxgcI4goLda7O6oMfc+hK4pJM6f+cK0+U8dVwKBAp0E23d
         V8MkR8W7fi7hwcQDfE+P9o35qfxDifeoA+fBP0kLNAO537+KrfB3O2y8Unqv8xt9a1Qz
         P2uQ==
X-Gm-Message-State: AOAM533bP/2wL+l4i7TBXkY06OxpfZUNLNKk/DyGFyuautxCvnWrDF6s
        Kg7UIXiy1ALJnSSK5LXImZVdr1IfzarlDiw7+rDqxQ==
X-Google-Smtp-Source: ABdhPJxILFZNXedxFo3nNZbvYFilg06NPbjGfwLF6P55r2ffdpz/3WuXga60Qh5pRbA/JlhU+780MKA9uyI+mTLn/rg=
X-Received: by 2002:ab0:494a:: with SMTP id a10mr9272526uad.90.1634850657962;
 Thu, 21 Oct 2021 14:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211021165618.178352-1-sdf@google.com> <20211021165618.178352-3-sdf@google.com>
 <2f2fd146-222a-ecdb-7fe1-d9f67f5ac1de@isovalent.com> <CAKH8qBvMMX9BfzRwLZqYquzes=TO=eya17BmO0BDZKX9Pg1b=g@mail.gmail.com>
In-Reply-To: <CAKH8qBvMMX9BfzRwLZqYquzes=TO=eya17BmO0BDZKX9Pg1b=g@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Thu, 21 Oct 2021 22:10:46 +0100
Message-ID: <CACdoK4Lhf41pf9JsQnSatJrR57M+Fwmawve3mKA9Ss8ikQfaoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpftool: conditionally append / to the progtype
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 21 Oct 2021 at 21:40, Stanislav Fomichev <sdf@google.com> wrote:
>
> On Thu, Oct 21, 2021 at 12:55 PM Quentin Monnet <quentin@isovalent.com> wrote:
> >
> > 2021-10-21 09:56 UTC-0700 ~ Stanislav Fomichev <sdf@google.com>
> > > Otherwise, attaching with bpftool doesn't work with strict section names.
> > >
> > > Also, switch to libbpf strict mode to use the latest conventions
> > > (note, I don't think we have any cli api guarantees?).
> > >
> > > Cc: Quentin Monnet <quentin@isovalent.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >  tools/bpf/bpftool/main.c | 4 ++++
> > >  tools/bpf/bpftool/prog.c | 9 +++++++--
> > >  2 files changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> > > index 02eaaf065f65..8223bac1e401 100644
> > > --- a/tools/bpf/bpftool/main.c
> > > +++ b/tools/bpf/bpftool/main.c
> > > @@ -409,6 +409,10 @@ int main(int argc, char **argv)
> > >       block_mount = false;
> > >       bin_name = argv[0];
> > >
> > > +     ret = libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
> > > +     if (ret)
> > > +             p_err("failed to enable libbpf strict mode: %d", ret);
> > > +
> > >       hash_init(prog_table.table);
> > >       hash_init(map_table.table);
> > >       hash_init(link_table.table);
> > > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > > index 277d51c4c5d9..b04990588ccf 100644
> > > --- a/tools/bpf/bpftool/prog.c
> > > +++ b/tools/bpf/bpftool/prog.c
> > > @@ -1420,8 +1420,13 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
> > >                       err = get_prog_type_by_name(type, &common_prog_type,
> > >                                                   &expected_attach_type);
> > >                       free(type);
> > > -                     if (err < 0)
> > > -                             goto err_free_reuse_maps;
> >
> > Thanks a lot for the change! Can you please test it for e.g. an XDP
> > program? You should see that "bpftool prog load prog.o <path> type xdp"
> > prints a debug message from libbpf about the first attempt (above)
> > failing, before the second attempt (below) succeeds.
> >
> > We need to get rid of this message. I think it should be easy, because
> > we explicitly "ask" for that message in get_prog_type_by_name(), in the
> > same file, if it fails to load in the first place.
> >
> > Could you please update get_prog_type_by_name() to take an additional
> > switch as an argument, to tell if the debug-info should be retrieved
> > (then first attempt here would skip it, second would keep it)?
> > An alternative could be to move all the '/' and retries handling to that
> > function, and I think it would end up in bpftool keeping support for the
> > legacy object files with the former convention - but that would somewhat
> > defeat the objectives of the strict mode, so maybe not the best option.
>
> How about we call libbpf_prog_type_by_name with the provided argv
> first and then, if it doesn't work, we fallback to appending '\' and
> using get_prog_type_by_name ?

Yes it should work, too. Not sure of the order, maybe best to run
_with_ the '/' first, so that the debug message from libbpf (if
neither attempt succeeds) doesn't have the added slash? But that
doesn't matter much anyway.

>
> > > +                     if (err < 0) {
> >
> > We could run the second attempt only on libbpf returning -ESRCH, maybe?
>
> Not sure it matters here, why not always retry on error?

In case the function failed for some other reason and we knew that
retrying with a '/' wouldn't work any better. But in practice that's
only if the name is NULL, and this wouldn't happen because we would
not reach that point, so right, doesn't matter much.
