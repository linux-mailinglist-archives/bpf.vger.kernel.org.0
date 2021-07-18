Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC39A3CCA6A
	for <lists+bpf@lfdr.de>; Sun, 18 Jul 2021 21:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhGRTgJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Jul 2021 15:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229615AbhGRTgJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 18 Jul 2021 15:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626636790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/GrYYadeTs6MdEkFViKFW9Xwl9HcFSkKEjq78eNlmk=;
        b=aeTPxPPkrypLmaBQYP1vQ9Qkm5jcrmVGDU7XOQTfrnbdG7rr/1NXkU7r5rxfcPsnPuA+4y
        Kypxf2Pl/jkoZVuJGbmFE4soHL8xkpuVoPtvgbQXQb9T+RTq2Xkupw9CkMxoQ+DMgFSX+r
        lSgd1xh4fZHpOQmS8pl+RDWRDnoxsUk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-R6OnXLtBNGmQO_rl67DbmQ-1; Sun, 18 Jul 2021 15:33:09 -0400
X-MC-Unique: R6OnXLtBNGmQO_rl67DbmQ-1
Received: by mail-lj1-f197.google.com with SMTP id v10-20020a2ea60a0000b029017fd05dc0aaso8268149ljp.1
        for <bpf@vger.kernel.org>; Sun, 18 Jul 2021 12:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3/GrYYadeTs6MdEkFViKFW9Xwl9HcFSkKEjq78eNlmk=;
        b=asR2oYVDTt+sBT67oaw5PHBlPCsezih5lTIy8ufYOwqYj9YsxOJ/4madcozgULW/Dd
         ldNMm56jhyE4YtYd6BEUGj9p9K0JJp8a4kwpbQ3KBzpApmyiXLUxuYh4D0C9H543NgWJ
         0RVAra+5rI+mogsXB4USlHOCV1rFqisyFR0Ed4/ZXKuBo8lQg2LPE2DGJcLXl7AlId6r
         E7g+rYumWaJXGZTRAvQDgfUlDBV1KWRaLANUrESnK+PCS6SbkZbWBhlKVEWw2JpHcpu7
         vZQVw6kkNEEXQyn/fZluen4bX5751KNipvZJnLmrzaId3mH7RG3pKHeRU4t8ZiTtKQih
         uZkA==
X-Gm-Message-State: AOAM532smQ8qrNwU8FpIUXLhJd4mqHpgnYqtY9h8z3i2Ct+XDkjf9DyN
        XxVDmLXHAETZ6bl4hDvKL+9fUmaANb/+2h+SXWTRA7reCpw2rtW5mS+lutD6eCR9CdXGihXU5Bh
        BV8+bxy9FM4d9
X-Received: by 2002:a05:6512:3482:: with SMTP id v2mr15616095lfr.240.1626636787370;
        Sun, 18 Jul 2021 12:33:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6bLVux8W87Ip0LpRFxqexUmG0T61xfnZkMHBkkfAjpA+yKlK2c1zTGZtWuVYJOrIRw8hSxA==
X-Received: by 2002:a17:907:2d8a:: with SMTP id gt10mr24039949ejc.10.1626636776890;
        Sun, 18 Jul 2021 12:32:56 -0700 (PDT)
Received: from krava ([83.240.60.59])
        by smtp.gmail.com with ESMTPSA id d10sm6652579edh.62.2021.07.18.12.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 12:32:56 -0700 (PDT)
Date:   Sun, 18 Jul 2021 21:32:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCHv4 bpf-next 7/8] libbpf: Allow specification of
 "kprobe/function+offset"
Message-ID: <YPSB5ot0iK57kkA6@krava>
References: <20210714094400.396467-1-jolsa@kernel.org>
 <20210714094400.396467-8-jolsa@kernel.org>
 <CAEf4BzYELMgTv_RhW7qWNgOYc_mCyh8-VX0FUYabi_TU3OiGKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYELMgTv_RhW7qWNgOYc_mCyh8-VX0FUYabi_TU3OiGKw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 16, 2021 at 06:42:05PM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 14, 2021 at 2:45 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > From: Alan Maguire <alan.maguire@oracle.com>
> >
> > kprobes can be placed on most instructions in a function, not
> > just entry, and ftrace and bpftrace support the function+offset
> > notification for probe placement.  Adding parsing of func_name
> > into func+offset to bpf_program__attach_kprobe() allows the
> > user to specify
> >
> > SEC("kprobe/bpf_fentry_test5+0x6")
> >
> > ...for example, and the offset can be passed to perf_event_open_probe()
> > to support kprobe attachment.
> >
> > [jolsa: changed original code to use bpf_program__attach_kprobe_opts
> > and use dynamic allocation in sscanf]
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index d93a6f9408d1..abe6d4842bb0 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10348,6 +10348,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
> >
> >  struct bpf_program_attach_kprobe_opts {
> >         bool retprobe;
> > +       unsigned long offset;
> >  };
> >
> >  static struct bpf_link*
> > @@ -10360,7 +10361,7 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
> >         int pfd, err;
> >
> >         pfd = perf_event_open_probe(false /* uprobe */, opts->retprobe, func_name,
> > -                                   0 /* offset */, -1 /* pid */);
> > +                                   opts->offset, -1 /* pid */);
> >         if (pfd < 0) {
> >                 pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
> >                         prog->name, opts->retprobe ? "kretprobe" : "kprobe", func_name,
> > @@ -10394,12 +10395,31 @@ static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
> >                                       struct bpf_program *prog)
> >  {
> >         struct bpf_program_attach_kprobe_opts opts;
> > +       unsigned long offset = 0;
> > +       struct bpf_link *link;
> >         const char *func_name;
> > +       char *func;
> > +       int n, err;
> >
> >         func_name = prog->sec_name + sec->len;
> >         opts.retprobe = strcmp(sec->sec, "kretprobe/") == 0;
> >
> > -       return bpf_program__attach_kprobe_opts(prog, func_name, &opts);
> > +       n = sscanf(func_name, "%m[a-zA-Z0-9_.]+%lx", &func, &offset);
> 
> could have used %li here to support both +0xabc and +123 forms

ok

> 
> > +       if (n < 1) {
> > +               err = -EINVAL;
> > +               pr_warn("kprobe name is invalid: %s\n", func_name);
> > +               return libbpf_err_ptr(err);
> > +       }
> > +       if (opts.retprobe && offset != 0) {
> > +               err = -EINVAL;
> 
> leaking func here

ugh.. thanks

jirka

> 
> 
> > +               pr_warn("kretprobes do not support offset specification\n");
> > +               return libbpf_err_ptr(err);
> > +       }
> > +
> > +       opts.offset = offset;
> > +       link = bpf_program__attach_kprobe_opts(prog, func, &opts);
> > +       free(func);
> > +       return link;
> >  }
> >
> >  struct bpf_link *bpf_program__attach_uprobe(struct bpf_program *prog,
> > --
> > 2.31.1
> >
> 

