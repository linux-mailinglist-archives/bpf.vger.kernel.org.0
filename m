Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5291149D2DF
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 20:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiAZTzi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 14:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiAZTzh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 14:55:37 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A90C06161C;
        Wed, 26 Jan 2022 11:55:37 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p63so77048iod.11;
        Wed, 26 Jan 2022 11:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCcmxFpU45CVJaKqVqEZ5RigfSTDPZSXSs6SLwCWSc8=;
        b=e1fjksAv0rMm+3yGNhg1rzBWl0q1wfZ9qiFXdI19KrlLjJVu5aIxUWLJzR1n4yq1rA
         DvizfYzWIla6/YF8pwwbLy5bRWdw6oIQCak4584/lXcXpRB0GjP5xZoQ/VyCvo3i2pe2
         obdS5ums9VcP36N320MuNZnQ1ZtBAkNz8qY9IQeIBXgibbc92wJ0TTO2e1edPVOXnM7y
         +NRy12OQBUQVYaUiLX4FBhthf70aAQwbKlMVZD7qmlpJoBy2rwKNpfxNMf4tvhpSBWQj
         +2xLogpbPsCQ/gMz84yE5JOD4kK8XhFnwReXw9xEUFMe6umF/Qg3Heuv+8QuqJ6dqNYH
         Q8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCcmxFpU45CVJaKqVqEZ5RigfSTDPZSXSs6SLwCWSc8=;
        b=6JMOV1k1Qgoed1HtHxjENbAlqkvDg1r/TuXic4YGriBLzMn/3v/0bqhaw7R9/+ENoK
         3g/5CIFJaQ9D4RR/aP+gV+HM9U8SyhuUk8ql/E8lf+kezst/6+OJ3Qm7BxoCEshvuH8Y
         L2EzYz+pIKdBDhIivIw8QS3D9Nim4jHmprdzumUq8mweR2hgqk0FN4RXlR3l2LsKURid
         ZpXZdd87f9atJF3sixpO75IYQTismyhuvrJv7mhMaDZk2o1AME8u9WGB0Y6sKrNZyyS+
         pZiHvYlKhmlS6wpc2GomN7DJZW9ePrEs4f35blv7Nw+5IFTCx+dLgs/ViTZ/+mfRtj+m
         CuAw==
X-Gm-Message-State: AOAM533V7C0NbZRIFjoPYbyvKqBNnzKr1+9g1Etr0Lm1y9armFSq5AbZ
        UKw5fQAGKoFSgeTKEJiW9XynNgobQa//rxO9KRQ=
X-Google-Smtp-Source: ABdhPJwFvwgOlncZo7cKeCd8cfzLIBNmtpwi3miI/1WqBc3GTdL4/3Ygf4ULNtCKut2ZGaPXqpKVA6fKE4sIQ2QuOoY=
X-Received: by 2002:a02:2422:: with SMTP id f34mr92251jaa.237.1643226936465;
 Wed, 26 Jan 2022 11:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20220126192039.2840752-1-kuifeng@fb.com> <20220126192039.2840752-2-kuifeng@fb.com>
In-Reply-To: <20220126192039.2840752-2-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Jan 2022 11:55:25 -0800
Message-ID: <CAEf4BzarN4L8U+hLnvZrNg0CR-oQr25OFs_W_tfW3aAHGAVFWw@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 1/4] dwarf_loader: Receive per-thread data on
 worker threads.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 26, 2022 at 11:20 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Add arguments to steal and thread_exit callbacks of conf_load to
> receive per-thread data.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

Please carry over acks you got on previous revisions, unless you did
some drastic changes to already acked patches.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  btf_loader.c   | 2 +-
>  ctf_loader.c   | 2 +-
>  dwarf_loader.c | 4 ++--
>  dwarves.h      | 5 +++--
>  pahole.c       | 3 ++-
>  pdwtags.c      | 3 ++-
>  pfunct.c       | 4 +++-
>  7 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/btf_loader.c b/btf_loader.c
> index 7a5b16ff393e..b61cadd55127 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -624,7 +624,7 @@ static int cus__load_btf(struct cus *cus, struct conf_load *conf, const char *fi
>          * The app stole this cu, possibly deleting it,
>          * so forget about it
>          */
> -       if (conf && conf->steal && conf->steal(cu, conf))
> +       if (conf && conf->steal && conf->steal(cu, conf, NULL))
>                 return 0;
>
>         cus__add(cus, cu);
> diff --git a/ctf_loader.c b/ctf_loader.c
> index 7c34739afdce..de6d4dbfce97 100644
> --- a/ctf_loader.c
> +++ b/ctf_loader.c
> @@ -722,7 +722,7 @@ int ctf__load_file(struct cus *cus, struct conf_load *conf,
>          * The app stole this cu, possibly deleting it,
>          * so forget about it
>          */
> -       if (conf && conf->steal && conf->steal(cu, conf))
> +       if (conf && conf->steal && conf->steal(cu, conf, NULL))
>                 return 0;
>
>         cus__add(cus, cu);
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index e30b03c1c541..bf9ea3765419 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2686,7 +2686,7 @@ static int cu__finalize(struct cu *cu, struct conf_load *conf)
>  {
>         cu__for_all_tags(cu, class_member__cache_byte_size, conf);
>         if (conf && conf->steal) {
> -               return conf->steal(cu, conf);
> +               return conf->steal(cu, conf, NULL);
>         }
>         return LSK__KEEPIT;
>  }
> @@ -2930,7 +2930,7 @@ static void *dwarf_cus__process_cu_thread(void *arg)
>                         goto out_abort;
>         }
>
> -       if (dcus->conf->thread_exit && dcus->conf->thread_exit() != 0)
> +       if (dcus->conf->thread_exit && dcus->conf->thread_exit(dcus->conf, NULL) != 0)
>                 goto out_abort;
>
>         return (void *)DWARF_CB_OK;
> diff --git a/dwarves.h b/dwarves.h
> index 52d162d67456..9a8e4de8843a 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -48,8 +48,9 @@ struct conf_fprintf;
>   */
>  struct conf_load {
>         enum load_steal_kind    (*steal)(struct cu *cu,
> -                                        struct conf_load *conf);
> -       int                     (*thread_exit)(void);
> +                                        struct conf_load *conf,
> +                                        void *thr_data);
> +       int                     (*thread_exit)(struct conf_load *conf, void *thr_data);
>         void                    *cookie;
>         char                    *format_path;
>         int                     nr_jobs;
> diff --git a/pahole.c b/pahole.c
> index f3a51cb2fe74..f3eeaaca4cdf 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -2799,7 +2799,8 @@ out:
>  static struct type_instance *header;
>
>  static enum load_steal_kind pahole_stealer(struct cu *cu,
> -                                          struct conf_load *conf_load)
> +                                          struct conf_load *conf_load,
> +                                          void *thr_data)
>  {
>         int ret = LSK__DELETE;
>
> diff --git a/pdwtags.c b/pdwtags.c
> index 2b5ba1bf6745..8b1d6f1c96cb 100644
> --- a/pdwtags.c
> +++ b/pdwtags.c
> @@ -72,7 +72,8 @@ static int cu__emit_tags(struct cu *cu)
>  }
>
>  static enum load_steal_kind pdwtags_stealer(struct cu *cu,
> -                                           struct conf_load *conf_load __maybe_unused)
> +                                           struct conf_load *conf_load __maybe_unused,
> +                                           void *thr_data __maybe_unused)
>  {
>         cu__emit_tags(cu);
>         return LSK__DELETE;
> diff --git a/pfunct.c b/pfunct.c
> index 5485622e639b..314915b774f4 100644
> --- a/pfunct.c
> +++ b/pfunct.c
> @@ -489,7 +489,9 @@ int elf_symtabs__show(char *filenames[])
>         return EXIT_SUCCESS;
>  }
>
> -static enum load_steal_kind pfunct_stealer(struct cu *cu, struct conf_load *conf_load __maybe_unused)
> +static enum load_steal_kind pfunct_stealer(struct cu *cu,
> +                                          struct conf_load *conf_load __maybe_unused,
> +                                          void *thr_data __maybe_unused)
>  {
>
>         if (function_name) {
> --
> 2.30.2
>
