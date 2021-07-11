Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2983C3D6F
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 16:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhGKOvf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 10:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233473AbhGKOvf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 11 Jul 2021 10:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626014928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZELnrKJVBGNx6wxd3yY5U2LdTh0ylxyvqNslHbnINcw=;
        b=Sr+7XzCdFqmDrhyxKos6P6uVoRe/kMWyO3idMngfdhFmvhCIjY6PKdn+8GiMiw6ojic1f+
        ZrYO9VLTv6QXIJMPFPgj7mTY17JOvsz/uZ906kn4akd+YNtKFXNUOz1adDEQX5A3BpDNDE
        nF5+3PtjCEX7bc9+FBFHR0Ei0OxK9eQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-uFWoxd3mPB6KK_dzhZ-P5Q-1; Sun, 11 Jul 2021 10:48:47 -0400
X-MC-Unique: uFWoxd3mPB6KK_dzhZ-P5Q-1
Received: by mail-ed1-f72.google.com with SMTP id bx13-20020a0564020b4db02903a02214fad8so6187732edb.1
        for <bpf@vger.kernel.org>; Sun, 11 Jul 2021 07:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZELnrKJVBGNx6wxd3yY5U2LdTh0ylxyvqNslHbnINcw=;
        b=PrKZmPdg/iziDeZW02XJNcwOilq7A3bhcZNCVRSsUHNpK1eCW4ua+P4KQShfGZqoBM
         xiUyEqT2vl9fk+TMZOQTR1EFiFmTxrqyBCzPpqnR8yIeQheTJvhb9U88VIdOTdElj7E0
         1KdSt0hUdkJ77mxTUNi9fbYPELoX5qN5lzdPJCXeEG3QtTtxtW/tOf1IhY37yt4/75MZ
         QVKmHieOdMjCkOuixIfHtATsNhiVszx80C6+F0ahlKnjVYUCOYRH60rUEOKtdpvl5inZ
         gzR/7TH4DtCOnif3VfUgBusNZAOc11fOYrPRIEs60ttG0xaAcpoolUr3n9UGhH5zITp9
         llYw==
X-Gm-Message-State: AOAM533cIxNZBKnlZEe+zVfkcEjatsm1TrS1t5kSRjB0+rZMInbBedvy
        NBAfmqdYHapCPkL0avzp09IirQEUdG4gcsmrESICkbASoeQy8b58vcxcLN5kzNktPF5iLYimDjz
        Iy/pTHmG1MW6+
X-Received: by 2002:a17:907:2d0a:: with SMTP id gs10mr48067161ejc.207.1626014926046;
        Sun, 11 Jul 2021 07:48:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeIhUhM/RTo9XOQB45I05Fu6x+0BB6/xj84NS+GNlkUkEEcnMkLaUYPeeX8BtS/vcZKwrzPA==
X-Received: by 2002:a17:907:2d0a:: with SMTP id gs10mr48067149ejc.207.1626014925891;
        Sun, 11 Jul 2021 07:48:45 -0700 (PDT)
Received: from krava ([5.171.250.127])
        by smtp.gmail.com with ESMTPSA id ch27sm4491068edb.57.2021.07.11.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 07:48:45 -0700 (PDT)
Date:   Sun, 11 Jul 2021 16:48:42 +0200
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
Subject: Re: [PATCHv3 bpf-next 6/7] libbpf: allow specification of
 "kprobe/function+offset"
Message-ID: <YOsEysoNkEOgEny2@krava>
References: <20210707214751.159713-1-jolsa@kernel.org>
 <20210707214751.159713-7-jolsa@kernel.org>
 <CAEf4BzbBk+0OHawjkCQdr2PNntEnfU-uov0fr=hk7jYokNrSDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbBk+0OHawjkCQdr2PNntEnfU-uov0fr=hk7jYokNrSDA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 07, 2021 at 05:14:20PM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 7, 2021 at 2:54 PM Jiri Olsa <jolsa@redhat.com> wrote:
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
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 1e04ce724240..60c9e3e77684 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10309,11 +10309,25 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
> >                                             const char *func_name)
> 
> I think we should add bpf_program__attach_kprobe_opts instead for the
> programmatic API instead of parsing it here from func_name. It's a
> cumbersome API.
> 
> Parsing SEC() is fine, of course, but then it has to call into
> bpf_program__attach_kprobe_opts() internally.

ok, Alan, will you make the change, or should I do that?

thanks,
jirka

> 
> >  {
> >         char errmsg[STRERR_BUFSIZE];
> > +       char func[BPF_OBJ_NAME_LEN];
> > +       unsigned long offset = 0;
> >         struct bpf_link *link;
> > -       int pfd, err;
> > +       int pfd, err, n;
> > +
> > +       n = sscanf(func_name, "%[a-zA-Z0-9_.]+%lx", func, &offset);
> > +       if (n < 1) {
> > +               err = -EINVAL;
> > +               pr_warn("kprobe name is invalid: %s\n", func_name);
> > +               return libbpf_err_ptr(err);
> > +       }
> > +       if (retprobe && offset != 0) {
> > +               err = -EINVAL;
> > +               pr_warn("kretprobes do not support offset specification\n");
> > +               return libbpf_err_ptr(err);
> > +       }
> >
> > -       pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
> > -                                   0 /* offset */, -1 /* pid */);
> > +       pfd = perf_event_open_probe(false /* uprobe */, retprobe, func,
> > +                                   offset, -1 /* pid */);
> >         if (pfd < 0) {
> >                 pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
> >                         prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
> > --
> > 2.31.1
> >
> 

