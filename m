Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3718739BDF0
	for <lists+bpf@lfdr.de>; Fri,  4 Jun 2021 19:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFDREq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 13:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDREp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Jun 2021 13:04:45 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78B6C061766
        for <bpf@vger.kernel.org>; Fri,  4 Jun 2021 10:02:49 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id f84so14719380ybg.0
        for <bpf@vger.kernel.org>; Fri, 04 Jun 2021 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0Ces95DChkuTY000b6T4B0zBaDBXKJduclduHnTD+Q=;
        b=rO+2lf8IUh2g6VZP3zDmasza+1h+65d0vaf3rlTB9GMPJM1FpCf62W+3gO1NhDSc17
         /V1o4RdVfQhE1wQe1urxN3ZfhgLEMNP4TyTuQ/+CqWAQ4OqJ+nWH4L9eYq9/goq9wDJy
         Xl+0Ej5fzjzIM6NnXUCPICPgaogJBku/xkT7DsHA6YQ0Ao4VF7m5tiy3Wwbh6Blgj5l5
         KJuOiE3MX/yEBxb2SD40LwEzPh3yHZSorS6vwasaEuYcKo8gS3IVbPztYVQQOhziGwQH
         znpUxYRXg0JjvaQOqZxPp8gph7nwJmYfxu43FCaIJAxTmQ+o47o28rHGvRXpW/lC15p3
         ED2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0Ces95DChkuTY000b6T4B0zBaDBXKJduclduHnTD+Q=;
        b=cAB53QAJStN6OiFgp+OaevzWsz46rZDF4OB/RFeDYgha9Tkxs0hrKRSLS8M37HGWbn
         3MwujjW1of5/hYykLZqhMUZMA7R0wvDPPCOOXuCz33b1w9XPRsTDeu52WjglYHWINSfK
         AQDvoM4tc32y8TBwOqFy8bY1Zd5Q+U+lcsNqfbxhJ+wdGEu05O6RoCWEnzXWJNIf2X9P
         WWABzDhyyHMRtaKuXcpqeoypgqNzdSl0kmH2fHigGVhqnPXz3jxLZetRUO9a/M8i3jnq
         mZqhGECSrq0c4x6ZhS7ZGhmWPSWSEQQSbIOh0wjbKh+0Jfknoyh7TQ3H8pBPSouxn8s8
         BYRA==
X-Gm-Message-State: AOAM53012Z7kqc59xHP9tdLmcqylbP3MnVvQOo548e6QercupMmSfJgy
        7tjb3J+hvpviIPgypyhCBvqoK2sYG55trUzGGY4=
X-Google-Smtp-Source: ABdhPJxSqZJbBuqM15uMKe9TphEHxUNYq542+SIw26yN9OA/MkthWRfrv72e2nGiRBYuroapW7dMGAoHmxJsWgoInZk=
X-Received: by 2002:a25:6612:: with SMTP id a18mr6478142ybc.347.1622826164291;
 Fri, 04 Jun 2021 10:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210603170515.1854642-1-jean-philippe@linaro.org>
 <CAEf4BzZqNjBhMVk7T_XZt2NTtDsajECGmHX-n71GBRjK6TmSWA@mail.gmail.com> <YLnbXzlEGuyAYh/0@myrica>
In-Reply-To: <YLnbXzlEGuyAYh/0@myrica>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Jun 2021 10:02:33 -0700
Message-ID: <CAEf4BzbqqxEDQSmd5oF7NuE2OGtvF1_cJVAUxviFGi8FbZSPXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools/bpftool: Fix cross-build
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 4, 2021 at 12:51 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Thu, Jun 03, 2021 at 10:50:08AM -0700, Andrii Nakryiko wrote:
> > On Thu, Jun 3, 2021 at 10:06 AM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > When the bootstrap and final bpftool have different architectures, we
> > > need to build two distinct disasm.o objects. Add a recipe for the
> > > bootstrap disasm.o
> > >
> > > Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
> >
> > Did this commit break something specifically?
>
> Yes, cross-building bpftool doesn't work anymore, because the bootstrap
> bpftool is linked using objects from different architectures:
>
> $ make O=/tmp/bpftool ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/bpf/bpftool/ V=1
>
>   aarch64-linux-gnu-gcc ... -c -MMD -o /tmp/bpftool/disasm.o /home/z/src/linux/kernel/bpf/disasm.c
>   gcc ... -c -MMD -o /tmp/bpftool//bootstrap/main.o main.c
>   gcc ... -o /tmp/bpftool//bootstrap/bpftool /tmp/bpftool//bootstrap/main.o ... /tmp/bpftool/disasm.o
> /usr/bin/ld: /tmp/bpftool/disasm.o: Relocations in generic ELF (EM: 183)
> /usr/bin/ld: /tmp/bpftool/disasm.o: Relocations in generic ELF (EM: 183)
> /usr/bin/ld: /tmp/bpftool/disasm.o: Relocations in generic ELF (EM: 183)
> /usr/bin/ld: /tmp/bpftool/disasm.o: error adding symbols: file in wrong format
> collect2: error: ld returned 1 exit status
>
> The final bpftool is built for arm64, while the bootstrap bpftool,
> executed on the host, is built for x86. The problem here is that disasm.o
> linked into the bootstrap bpftool is arm64 rather than x86. With my fix we
> build two disasm.o, one for the target bpftool in arm64, and one for the
> bootstrap bpftool in x86.

Oh, ok, that commit added disasm.o into bootstrap version of bpftool, thanks.

>
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > ---
> > >  tools/bpf/bpftool/Makefile | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > > index d16d289ade7a..d73232be1e99 100644
> > > --- a/tools/bpf/bpftool/Makefile
> > > +++ b/tools/bpf/bpftool/Makefile
> > > @@ -136,7 +136,7 @@ endif
> > >
> > >  BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
> > >
> > > -BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o) $(OUTPUT)disasm.o
> > > +BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o disasm.o)
> > >  OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
> > >
> > >  VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)                           \
> > > @@ -180,6 +180,9 @@ endif
> > >
> > >  CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
> > >
> > > +$(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
> > > +       $(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD -o $@ $<
> > > +
> > >  $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
> >
> > maybe just do
> >
> > $(BOOTSTRAP_OUTPUT)disasm.o $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
>
> They need two different recipes. The bootstrap disasm.o needs to be built
> with $(HOSTCC) rather than $(CC) (CC=aarch64-linux-gnu-gcc and HOSTCC=gcc)
>

My bad, missed HOSTCC vs CC in the rule. At a first glance they
appeared to be identical.

Your patch makes sense:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Thanks,
> Jean
>
> > ?
> >
> > >         $(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
> > >
> > > --
> > > 2.31.1
> > >
