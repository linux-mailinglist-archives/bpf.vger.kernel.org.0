Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2FB436C4A
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 22:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhJUUnO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 16:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhJUUnO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 16:43:14 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2099CC0613B9
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 13:40:58 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id w2so1757560qtn.0
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtfuqbWRubAkNJb/Ji9fqYFzDNLlB/8GCYwd4CC82Jg=;
        b=lDkwGDG//rxPiV+Dz8vtU3V75pHyQ0OQMu1zUU5GuzjQGzW/Oy8hDRQpc0TwKZqugG
         sjgaztZfThSeLp98LvTmgQlmkvbBO90rwchYSQ0A4Zxc1NqrCvvWbQ3d15uHqQtNmx/r
         azLmC9ayb4p8DkXMqnIByCNbgfwChprhkd7Oee+wW9fhvK+z4/6IxtWpMic3P4Ve315X
         fNxaua2YSCv+ytNn0sau+kJx/4nkkixRc7kvgTVOLAIMPA1ukZzwBVQH6iZikw4sX+iY
         REi2UwQjPO3TMcqY5oN1l+Tq4irdwhtS6j0eo5cMh6kpYc6oBHYc3AXdF4zJjdGt4H/g
         IEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtfuqbWRubAkNJb/Ji9fqYFzDNLlB/8GCYwd4CC82Jg=;
        b=AOh0H7xdurKD6eJqazND/+pG5zUpOn4QZI1ZFymxYBrnhkuRNZoaQ14SAwDtv6NKG0
         PvEuM9OXrbWQCPh/OzErJ3AM48N52ZJxcbOdP6f+NCUw3Q8cF7Fe7gOfqyVrPijR+f0M
         IJWmu2ZcOfV10X0oJi90YVV70/5wyEFCwZ2+n1IDz6fPuzbXYfVzqmgu0zL+qQQnBj7l
         Y1bC6V74SGoZRMqlCLzJ/MCHAb/oJe8ZuLuNoj5LX/EQMNKO58/L+ztndTJAJtTWvsb3
         G2+w4Q9M1u5s1wljrUCJcagxgo5pWh0FOfB2qbmRUnWdtyEQCiVsMbbzpfbhQzN4EXHK
         A5HA==
X-Gm-Message-State: AOAM532+0K1U3tgyN7vOMsC1sjVLm1Hj3lECakEuoJgxaoi4nRFHXvYa
        NI3/QGtUDCmNEwtc+J6j6dXLTSozyEJqp3LmOqXdVg==
X-Google-Smtp-Source: ABdhPJw35A8cCQ7MgQBb+LihU21lorvv1rQc9/q4gj8FBFSTgD7FMEDcwUIez92lRuqEL3aqD3xQCLOb+QfsrQnJrG4=
X-Received: by 2002:ac8:5cd0:: with SMTP id s16mr8555269qta.287.1634848856961;
 Thu, 21 Oct 2021 13:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211021165618.178352-1-sdf@google.com> <20211021165618.178352-3-sdf@google.com>
 <2f2fd146-222a-ecdb-7fe1-d9f67f5ac1de@isovalent.com>
In-Reply-To: <2f2fd146-222a-ecdb-7fe1-d9f67f5ac1de@isovalent.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 21 Oct 2021 13:40:46 -0700
Message-ID: <CAKH8qBvMMX9BfzRwLZqYquzes=TO=eya17BmO0BDZKX9Pg1b=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpftool: conditionally append / to the progtype
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 12:55 PM Quentin Monnet <quentin@isovalent.com> wrote:
>
> 2021-10-21 09:56 UTC-0700 ~ Stanislav Fomichev <sdf@google.com>
> > Otherwise, attaching with bpftool doesn't work with strict section names.
> >
> > Also, switch to libbpf strict mode to use the latest conventions
> > (note, I don't think we have any cli api guarantees?).
> >
> > Cc: Quentin Monnet <quentin@isovalent.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  tools/bpf/bpftool/main.c | 4 ++++
> >  tools/bpf/bpftool/prog.c | 9 +++++++--
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> > index 02eaaf065f65..8223bac1e401 100644
> > --- a/tools/bpf/bpftool/main.c
> > +++ b/tools/bpf/bpftool/main.c
> > @@ -409,6 +409,10 @@ int main(int argc, char **argv)
> >       block_mount = false;
> >       bin_name = argv[0];
> >
> > +     ret = libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
> > +     if (ret)
> > +             p_err("failed to enable libbpf strict mode: %d", ret);
> > +
> >       hash_init(prog_table.table);
> >       hash_init(map_table.table);
> >       hash_init(link_table.table);
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index 277d51c4c5d9..b04990588ccf 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -1420,8 +1420,13 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
> >                       err = get_prog_type_by_name(type, &common_prog_type,
> >                                                   &expected_attach_type);
> >                       free(type);
> > -                     if (err < 0)
> > -                             goto err_free_reuse_maps;
>
> Thanks a lot for the change! Can you please test it for e.g. an XDP
> program? You should see that "bpftool prog load prog.o <path> type xdp"
> prints a debug message from libbpf about the first attempt (above)
> failing, before the second attempt (below) succeeds.
>
> We need to get rid of this message. I think it should be easy, because
> we explicitly "ask" for that message in get_prog_type_by_name(), in the
> same file, if it fails to load in the first place.
>
> Could you please update get_prog_type_by_name() to take an additional
> switch as an argument, to tell if the debug-info should be retrieved
> (then first attempt here would skip it, second would keep it)?
> An alternative could be to move all the '/' and retries handling to that
> function, and I think it would end up in bpftool keeping support for the
> legacy object files with the former convention - but that would somewhat
> defeat the objectives of the strict mode, so maybe not the best option.

How about we call libbpf_prog_type_by_name with the provided argv
first and then, if it doesn't work, we fallback to appending '\' and
using get_prog_type_by_name ?

> > +                     if (err < 0) {
>
> We could run the second attempt only on libbpf returning -ESRCH, maybe?

Not sure it matters here, why not always retry on error?

> > +                             err = get_prog_type_by_name(*argv, &common_prog_type,
> > +                                                         &expected_attach_type);
> > +                             if (err < 0)
> > +
> > +                                     goto err_free_reuse_maps;
> > +                     }
> >
> >                       NEXT_ARG();
> >               } else if (is_prefix(*argv, "map")) {
> >
>
