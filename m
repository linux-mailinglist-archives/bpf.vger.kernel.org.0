Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F5A4D3DF0
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 01:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbiCJAPw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 19:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiCJAPw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 19:15:52 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A518895A1F;
        Wed,  9 Mar 2022 16:14:52 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id c23so4719197ioi.4;
        Wed, 09 Mar 2022 16:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kbyu1uV2m5L+XViR0pijhS8ZvG9cenw+nQ5Pce/Gws0=;
        b=jNHnk1p3lsp8D75iQ5td/UI+9hJs6S2nDoXsByISshOK6JQ9Uaw/BgkvqjGoAiAu/s
         m8ccXIoueZ9XCyB+byyS4YMxEaSrcGeHBVsyGkDAuSXl9Veiej8P19533SwfH+MC3W3L
         s9xd+NWtD+kjcqWQN8fDSXjvQ2wfiJ6cKQyp3uoqGA1P7D8+MtqGBElggkmMr4IkV1Z1
         fcyoXNRCOJ1goDSWlieu3i4Zn8nbigbtzXpRj53bwWqlVGuwg0cN8y+V+y90BBc9LCTb
         Y7JHDwF6Bd40hfmLqXbsiJ6GW5Fik2suEOqnVrqPUep57PNyUDB8HNg7+1xBXQICnHWZ
         J+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kbyu1uV2m5L+XViR0pijhS8ZvG9cenw+nQ5Pce/Gws0=;
        b=k4r3iPAq4ndt1khKbj/H4khZ9jblQNNh8DCzJFVhS/hWlwSnYh2W0TUbzzhJwaR9ca
         KHzzlmYvncW629uz0a7TRcavSGINZfraIfh99sG0+lgqvLuXIxs55V4LXQP+Y/iKMUpC
         8mQAiYQpYowuB0GyfhCXc8cKaYENckWb4Ba8eg216SR2XmX0bMUgIGe0tcnhKNNNucXc
         5B//uuMGQ1gfqNk6UhvApnfNmtei2CCSHCboDmuVi5CaaBmukmssfeZA9YUQw59pAuMw
         X4gbHfPvKiZcNtKyfvlMdaCAa7etSN/yIEj0hVcEDE0A0GKdKPFfJYBccOkIK4t/JG3V
         qtUw==
X-Gm-Message-State: AOAM532MTG4O43LgZ1g5UiOMnYbz6EiXLb4ZO3odJTRKAo7NEni2vluE
        IH1RK4JZnW4csAMB5MdQ4gGgAMafYp04GOGXKH4=
X-Google-Smtp-Source: ABdhPJxc2sxMIPiw6e0zkV+IuuN3xEGMPaAjBr+ZSSQAEH7APjlOcJYAauNTuiUBG6qKf94E2Z8VvdTKL5Oor7vo/Ys=
X-Received: by 2002:a05:6638:22c3:b0:30a:2226:e601 with SMTP id
 j3-20020a05663822c300b0030a2226e601mr1713401jat.237.1646871291688; Wed, 09
 Mar 2022 16:14:51 -0800 (PST)
MIME-Version: 1.0
References: <20220126192039.2840752-1-kuifeng@fb.com> <20220126192039.2840752-2-kuifeng@fb.com>
 <CAEf4BzarN4L8U+hLnvZrNg0CR-oQr25OFs_W_tfW3aAHGAVFWw@mail.gmail.com>
 <YfJudZmSS1yTkeP/@kernel.org> <CAEf4Bza8xB+yFb4qGPvM7YwvHCb1zQ8yosGbKj63vcRM7d9aLg@mail.gmail.com>
 <Yij/BSPgMl8/HEhg@kernel.org>
In-Reply-To: <Yij/BSPgMl8/HEhg@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Mar 2022 16:14:40 -0800
Message-ID: <CAEf4BzZX8Q5MPt62+68nRoQNPe=3jnVkcEMMJwPzoU51YCBszg@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 1/4] dwarf_loader: Receive per-thread data on
 worker threads.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kui-Feng Lee <kuifeng@fb.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
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

On Wed, Mar 9, 2022 at 11:24 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Mar 08, 2022 at 03:45:03PM -0800, Andrii Nakryiko escreveu:
> > On Thu, Jan 27, 2022 at 11:22 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Wed, Jan 26, 2022 at 11:55:25AM -0800, Andrii Nakryiko escreveu:
> > > > On Wed, Jan 26, 2022 at 11:20 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > > > >
> > > > > Add arguments to steal and thread_exit callbacks of conf_load to
> > > > > receive per-thread data.
> > > > >
> > > > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > > > ---
> > > >
> > > > Please carry over acks you got on previous revisions, unless you did
> > > > some drastic changes to already acked patches.
> > >
> > > Yes, please do so.
> > >
> > > I'll collect them this time, no need to resend.
> > >
> >
> > Hey, Arnaldo!
> >
> > Any idea when these patches will make it into master branch? I see
> > they are in tmp.master right now.
>
> I did some minor fixups to the cset comment and to the code in the
> 'pahole --compile' new feature at the head of it and pushed all up,
> please check.
>

I did check locally with latest pahole master, and it seems like
something is wrong with generated BTF. I get three selftests failure
if I use latest pahole compiled from master.

Kui-Feng, please take a look when you get a chance. Arnaldo, please
hold off from releasing a new version for now.


> - Arnaldo
>
> > > - Arnaldo
> > >
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > >
> > > > >  btf_loader.c   | 2 +-
> > > > >  ctf_loader.c   | 2 +-
> > > > >  dwarf_loader.c | 4 ++--
> > > > >  dwarves.h      | 5 +++--
> > > > >  pahole.c       | 3 ++-
> > > > >  pdwtags.c      | 3 ++-
> > > > >  pfunct.c       | 4 +++-
> > > > >  7 files changed, 14 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/btf_loader.c b/btf_loader.c
> > > > > index 7a5b16ff393e..b61cadd55127 100644
> > > > > --- a/btf_loader.c
> > > > > +++ b/btf_loader.c
> > > > > @@ -624,7 +624,7 @@ static int cus__load_btf(struct cus *cus, struct conf_load *conf, const char *fi
> > > > >          * The app stole this cu, possibly deleting it,
> > > > >          * so forget about it
> > > > >          */
> > > > > -       if (conf && conf->steal && conf->steal(cu, conf))
> > > > > +       if (conf && conf->steal && conf->steal(cu, conf, NULL))
> > > > >                 return 0;
> > > > >
> > > > >         cus__add(cus, cu);
> > > > > diff --git a/ctf_loader.c b/ctf_loader.c
> > > > > index 7c34739afdce..de6d4dbfce97 100644
> > > > > --- a/ctf_loader.c
> > > > > +++ b/ctf_loader.c
> > > > > @@ -722,7 +722,7 @@ int ctf__load_file(struct cus *cus, struct conf_load *conf,
> > > > >          * The app stole this cu, possibly deleting it,
> > > > >          * so forget about it
> > > > >          */
> > > > > -       if (conf && conf->steal && conf->steal(cu, conf))
> > > > > +       if (conf && conf->steal && conf->steal(cu, conf, NULL))
> > > > >                 return 0;
> > > > >
> > > > >         cus__add(cus, cu);
> > > > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > > > index e30b03c1c541..bf9ea3765419 100644
> > > > > --- a/dwarf_loader.c
> > > > > +++ b/dwarf_loader.c
> > > > > @@ -2686,7 +2686,7 @@ static int cu__finalize(struct cu *cu, struct conf_load *conf)
> > > > >  {
> > > > >         cu__for_all_tags(cu, class_member__cache_byte_size, conf);
> > > > >         if (conf && conf->steal) {
> > > > > -               return conf->steal(cu, conf);
> > > > > +               return conf->steal(cu, conf, NULL);
> > > > >         }
> > > > >         return LSK__KEEPIT;
> > > > >  }
> > > > > @@ -2930,7 +2930,7 @@ static void *dwarf_cus__process_cu_thread(void *arg)
> > > > >                         goto out_abort;
> > > > >         }
> > > > >
> > > > > -       if (dcus->conf->thread_exit && dcus->conf->thread_exit() != 0)
> > > > > +       if (dcus->conf->thread_exit && dcus->conf->thread_exit(dcus->conf, NULL) != 0)
> > > > >                 goto out_abort;
> > > > >
> > > > >         return (void *)DWARF_CB_OK;
> > > > > diff --git a/dwarves.h b/dwarves.h
> > > > > index 52d162d67456..9a8e4de8843a 100644
> > > > > --- a/dwarves.h
> > > > > +++ b/dwarves.h
> > > > > @@ -48,8 +48,9 @@ struct conf_fprintf;
> > > > >   */
> > > > >  struct conf_load {
> > > > >         enum load_steal_kind    (*steal)(struct cu *cu,
> > > > > -                                        struct conf_load *conf);
> > > > > -       int                     (*thread_exit)(void);
> > > > > +                                        struct conf_load *conf,
> > > > > +                                        void *thr_data);
> > > > > +       int                     (*thread_exit)(struct conf_load *conf, void *thr_data);
> > > > >         void                    *cookie;
> > > > >         char                    *format_path;
> > > > >         int                     nr_jobs;
> > > > > diff --git a/pahole.c b/pahole.c
> > > > > index f3a51cb2fe74..f3eeaaca4cdf 100644
> > > > > --- a/pahole.c
> > > > > +++ b/pahole.c
> > > > > @@ -2799,7 +2799,8 @@ out:
> > > > >  static struct type_instance *header;
> > > > >
> > > > >  static enum load_steal_kind pahole_stealer(struct cu *cu,
> > > > > -                                          struct conf_load *conf_load)
> > > > > +                                          struct conf_load *conf_load,
> > > > > +                                          void *thr_data)
> > > > >  {
> > > > >         int ret = LSK__DELETE;
> > > > >
> > > > > diff --git a/pdwtags.c b/pdwtags.c
> > > > > index 2b5ba1bf6745..8b1d6f1c96cb 100644
> > > > > --- a/pdwtags.c
> > > > > +++ b/pdwtags.c
> > > > > @@ -72,7 +72,8 @@ static int cu__emit_tags(struct cu *cu)
> > > > >  }
> > > > >
> > > > >  static enum load_steal_kind pdwtags_stealer(struct cu *cu,
> > > > > -                                           struct conf_load *conf_load __maybe_unused)
> > > > > +                                           struct conf_load *conf_load __maybe_unused,
> > > > > +                                           void *thr_data __maybe_unused)
> > > > >  {
> > > > >         cu__emit_tags(cu);
> > > > >         return LSK__DELETE;
> > > > > diff --git a/pfunct.c b/pfunct.c
> > > > > index 5485622e639b..314915b774f4 100644
> > > > > --- a/pfunct.c
> > > > > +++ b/pfunct.c
> > > > > @@ -489,7 +489,9 @@ int elf_symtabs__show(char *filenames[])
> > > > >         return EXIT_SUCCESS;
> > > > >  }
> > > > >
> > > > > -static enum load_steal_kind pfunct_stealer(struct cu *cu, struct conf_load *conf_load __maybe_unused)
> > > > > +static enum load_steal_kind pfunct_stealer(struct cu *cu,
> > > > > +                                          struct conf_load *conf_load __maybe_unused,
> > > > > +                                          void *thr_data __maybe_unused)
> > > > >  {
> > > > >
> > > > >         if (function_name) {
> > > > > --
> > > > > 2.30.2
> > > > >
> > >
> > > --
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo
