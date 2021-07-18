Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9683CCA68
	for <lists+bpf@lfdr.de>; Sun, 18 Jul 2021 21:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhGRTfH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Jul 2021 15:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29433 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230324AbhGRTfH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 18 Jul 2021 15:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626636728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyZcIVod7cdW84KhhpNZDvdJDIPNl5OvVdbjX4Ic2xE=;
        b=fCpw1EkEDhQpA41cUKMDfEMwo0nqRjGaNX4Q6Gqz1vxYQfE/R62Q/CLrV7mxc1VAh8uVxE
        KLj8PNGfRSGAo0hSyr2ExbZFohOzuL88CzpNQqLHv7c676UfWBUe0U5JJK2TxOr1bxz2f4
        jZA0wMZuU0UaPc1CYRVkUn5Fs0YQ70M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-tZuLjEQON-60G0s74IKlVQ-1; Sun, 18 Jul 2021 15:32:06 -0400
X-MC-Unique: tZuLjEQON-60G0s74IKlVQ-1
Received: by mail-ed1-f69.google.com with SMTP id v14-20020a056402184eb029039994f9cab9so7338467edy.22
        for <bpf@vger.kernel.org>; Sun, 18 Jul 2021 12:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CyZcIVod7cdW84KhhpNZDvdJDIPNl5OvVdbjX4Ic2xE=;
        b=T8UTaux2mx0CakRAfnEx1vlNHlkObZlBoFlW+M+srA3rndWNOu1Oj6Y+4aQH9ee1Py
         f3uGRNXFgObrqIkrhbsqHMxm1VsO+z24PwZeq/GO1g7YQ0bP9ujOoM2UXyTOpgo2OqKj
         pwYG4yfFYUXBoB6Y4V7b48SNdwEjJ9GuwO2xJBNzgGsb8EpPbVvoVSU9oK4Kc+Tt7D7p
         a97e3/3kMMWugomtFfVgTDp3s/+H2ZBiXvqVFlZ9VmZkPv/lDRKfndm7pmN4Mvc4Nqu6
         mc0sEeWMMiaspIAM02s9KsS+vBTogiW2tfA84o+tnpL4+vSW6nivYrAv6KtFYN8RqpTE
         niag==
X-Gm-Message-State: AOAM533pXN6P/9uEBWibFW8JxiYisV7RXMaHs6mPTNHE6Xh0TFpxOyQn
        QITTpGguUzG+ZzoH5Ez68h4804lAgutwKqUFpd0yEH8upbQrgS83jyWoDdgN6jsyLjkLIrPaPvz
        2qrBJ5KMZM9zS
X-Received: by 2002:a05:6402:18de:: with SMTP id x30mr30561736edy.351.1626636725868;
        Sun, 18 Jul 2021 12:32:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNpOXTpk0iHmNrW3fnPsuuHKTIXu+GevSMOyP+swg3XWPwhH1nhXLCAVgX3iaLMdTR8YI34w==
X-Received: by 2002:a05:6402:18de:: with SMTP id x30mr30561715edy.351.1626636725731;
        Sun, 18 Jul 2021 12:32:05 -0700 (PDT)
Received: from krava ([83.240.60.59])
        by smtp.gmail.com with ESMTPSA id w24sm6769141edv.59.2021.07.18.12.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 12:32:05 -0700 (PDT)
Date:   Sun, 18 Jul 2021 21:32:03 +0200
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
Subject: Re: [PATCHv4 bpf-next 6/8] libbpf: Add
 bpf_program__attach_kprobe_opts function
Message-ID: <YPSBs51JR5cWVuc1@krava>
References: <20210714094400.396467-1-jolsa@kernel.org>
 <20210714094400.396467-7-jolsa@kernel.org>
 <CAEf4Bzbk-nyenpc86jtEShset_ZSkapvpy3fG2gYKZEOY7uAQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbk-nyenpc86jtEShset_ZSkapvpy3fG2gYKZEOY7uAQg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 16, 2021 at 06:41:59PM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 14, 2021 at 2:45 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Adding bpf_program__attach_kprobe_opts that does the same
> > as bpf_program__attach_kprobe, but takes opts argument.
> >
> > Currently opts struct holds just retprobe bool, but we will
> > add new field in following patch.
> >
> > The function is not exported, so there's no need to add
> > size to the struct bpf_program_attach_kprobe_opts for now.
> 
> Why not exported? Please use a proper _opts struct just like others
> (e.g., bpf_object_open_opts) and add is as a public API, it's a useful
> addition. We are going to have a similar structure for attach_uprobe,
> btw. Please send a follow up patch.

there's no outside user.. ok

> 
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 34 +++++++++++++++++++++++++---------
> >  1 file changed, 25 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 88b99401040c..d93a6f9408d1 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10346,19 +10346,24 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
> >         return pfd;
> >  }
> >
> > -struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
> > -                                           bool retprobe,
> > -                                           const char *func_name)
> > +struct bpf_program_attach_kprobe_opts {
> 
> when you make it part of libbpf API, let's call it something shorter,
> like bpf_kprobe_opts, maybe? And later we'll have bpf_uprobe_opts for
> uprobes. Short and unambiguous.

ok

jirka

> 
> > +       bool retprobe;
> > +};
> > +
> > +static struct bpf_link*
> > +bpf_program__attach_kprobe_opts(struct bpf_program *prog,
> > +                               const char *func_name,
> > +                               struct bpf_program_attach_kprobe_opts *opts)
> >  {
> >         char errmsg[STRERR_BUFSIZE];
> >         struct bpf_link *link;
> >         int pfd, err;
> >
> 
> [...]
> 

