Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667F849EAF8
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 20:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbiA0TWO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 14:22:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50032 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiA0TWO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 14:22:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D07ABB8234B;
        Thu, 27 Jan 2022 19:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A88C340E4;
        Thu, 27 Jan 2022 19:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643311331;
        bh=G0W1gkFLQ1WPXxiPGFlbFbWH1HHtaM5GRw62C6zgmnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFHtN82TtA0xq+6rrktzS8p8HeVLrhnQ9oZsI0Da3DJFLx2mW9GX86vjamzU8Lppm
         wQJZIx7P6JbNbSEvrcJynMhwagNTZRdi4JQl9/xW3g9zyLWFNeboEtp/v1nZXlHdEV
         jcqflkPMY4wOPRPTbWX5kZZu/+Rwte32Fl/y6Fjk+ZcpGq6+UT60L5a90Ed1XlaUhZ
         pwzV3pMDzTJ9AlSiSJowVPGrqLigLQtGaHvuAe8F0eUkAPyQSL8JNnrqVsWxiX4vaU
         BsL6T2RVSxM+YU4bAThnhp53V4taGpAvOn7/7xq6NgJ02Jp0eThAdJ66VMPoCeZIjs
         C2+YKQB8fVkZg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF1AD40D0E; Thu, 27 Jan 2022 07:05:41 -0300 (-03)
Date:   Thu, 27 Jan 2022 07:05:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves v4 1/4] dwarf_loader: Receive per-thread data on
 worker threads.
Message-ID: <YfJudZmSS1yTkeP/@kernel.org>
References: <20220126192039.2840752-1-kuifeng@fb.com>
 <20220126192039.2840752-2-kuifeng@fb.com>
 <CAEf4BzarN4L8U+hLnvZrNg0CR-oQr25OFs_W_tfW3aAHGAVFWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzarN4L8U+hLnvZrNg0CR-oQr25OFs_W_tfW3aAHGAVFWw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jan 26, 2022 at 11:55:25AM -0800, Andrii Nakryiko escreveu:
> On Wed, Jan 26, 2022 at 11:20 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
> >
> > Add arguments to steal and thread_exit callbacks of conf_load to
> > receive per-thread data.
> >
> > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > ---
> 
> Please carry over acks you got on previous revisions, unless you did
> some drastic changes to already acked patches.

Yes, please do so.

I'll collect them this time, no need to resend.

- Arnaldo
 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> >  btf_loader.c   | 2 +-
> >  ctf_loader.c   | 2 +-
> >  dwarf_loader.c | 4 ++--
> >  dwarves.h      | 5 +++--
> >  pahole.c       | 3 ++-
> >  pdwtags.c      | 3 ++-
> >  pfunct.c       | 4 +++-
> >  7 files changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/btf_loader.c b/btf_loader.c
> > index 7a5b16ff393e..b61cadd55127 100644
> > --- a/btf_loader.c
> > +++ b/btf_loader.c
> > @@ -624,7 +624,7 @@ static int cus__load_btf(struct cus *cus, struct conf_load *conf, const char *fi
> >          * The app stole this cu, possibly deleting it,
> >          * so forget about it
> >          */
> > -       if (conf && conf->steal && conf->steal(cu, conf))
> > +       if (conf && conf->steal && conf->steal(cu, conf, NULL))
> >                 return 0;
> >
> >         cus__add(cus, cu);
> > diff --git a/ctf_loader.c b/ctf_loader.c
> > index 7c34739afdce..de6d4dbfce97 100644
> > --- a/ctf_loader.c
> > +++ b/ctf_loader.c
> > @@ -722,7 +722,7 @@ int ctf__load_file(struct cus *cus, struct conf_load *conf,
> >          * The app stole this cu, possibly deleting it,
> >          * so forget about it
> >          */
> > -       if (conf && conf->steal && conf->steal(cu, conf))
> > +       if (conf && conf->steal && conf->steal(cu, conf, NULL))
> >                 return 0;
> >
> >         cus__add(cus, cu);
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index e30b03c1c541..bf9ea3765419 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -2686,7 +2686,7 @@ static int cu__finalize(struct cu *cu, struct conf_load *conf)
> >  {
> >         cu__for_all_tags(cu, class_member__cache_byte_size, conf);
> >         if (conf && conf->steal) {
> > -               return conf->steal(cu, conf);
> > +               return conf->steal(cu, conf, NULL);
> >         }
> >         return LSK__KEEPIT;
> >  }
> > @@ -2930,7 +2930,7 @@ static void *dwarf_cus__process_cu_thread(void *arg)
> >                         goto out_abort;
> >         }
> >
> > -       if (dcus->conf->thread_exit && dcus->conf->thread_exit() != 0)
> > +       if (dcus->conf->thread_exit && dcus->conf->thread_exit(dcus->conf, NULL) != 0)
> >                 goto out_abort;
> >
> >         return (void *)DWARF_CB_OK;
> > diff --git a/dwarves.h b/dwarves.h
> > index 52d162d67456..9a8e4de8843a 100644
> > --- a/dwarves.h
> > +++ b/dwarves.h
> > @@ -48,8 +48,9 @@ struct conf_fprintf;
> >   */
> >  struct conf_load {
> >         enum load_steal_kind    (*steal)(struct cu *cu,
> > -                                        struct conf_load *conf);
> > -       int                     (*thread_exit)(void);
> > +                                        struct conf_load *conf,
> > +                                        void *thr_data);
> > +       int                     (*thread_exit)(struct conf_load *conf, void *thr_data);
> >         void                    *cookie;
> >         char                    *format_path;
> >         int                     nr_jobs;
> > diff --git a/pahole.c b/pahole.c
> > index f3a51cb2fe74..f3eeaaca4cdf 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -2799,7 +2799,8 @@ out:
> >  static struct type_instance *header;
> >
> >  static enum load_steal_kind pahole_stealer(struct cu *cu,
> > -                                          struct conf_load *conf_load)
> > +                                          struct conf_load *conf_load,
> > +                                          void *thr_data)
> >  {
> >         int ret = LSK__DELETE;
> >
> > diff --git a/pdwtags.c b/pdwtags.c
> > index 2b5ba1bf6745..8b1d6f1c96cb 100644
> > --- a/pdwtags.c
> > +++ b/pdwtags.c
> > @@ -72,7 +72,8 @@ static int cu__emit_tags(struct cu *cu)
> >  }
> >
> >  static enum load_steal_kind pdwtags_stealer(struct cu *cu,
> > -                                           struct conf_load *conf_load __maybe_unused)
> > +                                           struct conf_load *conf_load __maybe_unused,
> > +                                           void *thr_data __maybe_unused)
> >  {
> >         cu__emit_tags(cu);
> >         return LSK__DELETE;
> > diff --git a/pfunct.c b/pfunct.c
> > index 5485622e639b..314915b774f4 100644
> > --- a/pfunct.c
> > +++ b/pfunct.c
> > @@ -489,7 +489,9 @@ int elf_symtabs__show(char *filenames[])
> >         return EXIT_SUCCESS;
> >  }
> >
> > -static enum load_steal_kind pfunct_stealer(struct cu *cu, struct conf_load *conf_load __maybe_unused)
> > +static enum load_steal_kind pfunct_stealer(struct cu *cu,
> > +                                          struct conf_load *conf_load __maybe_unused,
> > +                                          void *thr_data __maybe_unused)
> >  {
> >
> >         if (function_name) {
> > --
> > 2.30.2
> >

-- 

- Arnaldo
