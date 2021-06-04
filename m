Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAF539B44D
	for <lists+bpf@lfdr.de>; Fri,  4 Jun 2021 09:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFDHxD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 03:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhFDHxC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Jun 2021 03:53:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9AC06174A
        for <bpf@vger.kernel.org>; Fri,  4 Jun 2021 00:51:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so10019905edt.13
        for <bpf@vger.kernel.org>; Fri, 04 Jun 2021 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c6O3KETJybAv3EcHwaqClUWBG02L9KTl1SYGJ6XpiUc=;
        b=s7L67OAqqK5mtutFqFgyLFdWPS7tUb9AfycqkvtILl5z0dKx2pYAcJfcCy9pxEmirg
         8gMe8LATF7oQKj6dKnziNeUMwMgK0HIgo1Kfxaw34H7d5OHI4ZTCs7FLIjPLw5AvlIsQ
         CDA/MvMAALL/adcRAmu7JuxyUHj8ooIOLw8Sl0awnCIJ3AhtJmUZ1JLNZNb8CPNr/odB
         g5TdQ3ZqmzoF0YoMNVPu8RET9WSRCQMg1mVK7PabfkJp5W+EVaxoT5lrlN8uCxc68Uxl
         f2VlKM250kS9fGUAhHRUGascb6ku8QvoWmsnwSTd9QJAkIOUcuQ9JRmhwnqkDoEPJqhY
         3LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c6O3KETJybAv3EcHwaqClUWBG02L9KTl1SYGJ6XpiUc=;
        b=X9YKmim9EqvIG6HpIgMqpTaRFuC7QiGZYW3/DPIE8Uq2bW+aAAjaaah44+IBHr0jPc
         slJzFFKofBsKIOY0d0IrA3liW628n9o2Nlbrq701AVnAsCaZdczTzJWdCHJ4pSAj7t2e
         tL2WgVIvLYBcGPen6fmOiDFSvM3D6U/lFvZEUhnXLQGkLRqXZGeduMVGVIm5jtOosi95
         yfFPVce6Eu5mOSAbXBvY/IipzcFddKE1lmF8vMUBJx1Nclspb7bHjeIuYkufTcs2BL+W
         HNgNcKAQ1sON8nxjXunI3MfsTCWHG4x39g1Vg4UQ8qwb2AlPQ7KACDm9Jw2DV7gDRvkE
         mxmQ==
X-Gm-Message-State: AOAM533hvqsNHIp7aYG7KbVVcixLmt3eS1qYZ75llKIVPvXegH4n4ZA5
        g6YwAlIgM3QPzL2NNgu0eBSSJg==
X-Google-Smtp-Source: ABdhPJz/d9G69MYF1ZodlOERBJAH8Pkv5n1IKCkzwGmwiqVjDPdjw3smdbmIEIJtnOydEpsQUW4rrw==
X-Received: by 2002:aa7:c7c7:: with SMTP id o7mr3421959eds.231.1622793075214;
        Fri, 04 Jun 2021 00:51:15 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id b15sm2767046ede.66.2021.06.04.00.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 00:51:14 -0700 (PDT)
Date:   Fri, 4 Jun 2021 09:50:55 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] tools/bpftool: Fix cross-build
Message-ID: <YLnbXzlEGuyAYh/0@myrica>
References: <20210603170515.1854642-1-jean-philippe@linaro.org>
 <CAEf4BzZqNjBhMVk7T_XZt2NTtDsajECGmHX-n71GBRjK6TmSWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZqNjBhMVk7T_XZt2NTtDsajECGmHX-n71GBRjK6TmSWA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 03, 2021 at 10:50:08AM -0700, Andrii Nakryiko wrote:
> On Thu, Jun 3, 2021 at 10:06 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > When the bootstrap and final bpftool have different architectures, we
> > need to build two distinct disasm.o objects. Add a recipe for the
> > bootstrap disasm.o
> >
> > Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
> 
> Did this commit break something specifically?

Yes, cross-building bpftool doesn't work anymore, because the bootstrap
bpftool is linked using objects from different architectures:

$ make O=/tmp/bpftool ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/bpf/bpftool/ V=1

  aarch64-linux-gnu-gcc ... -c -MMD -o /tmp/bpftool/disasm.o /home/z/src/linux/kernel/bpf/disasm.c
  gcc ... -c -MMD -o /tmp/bpftool//bootstrap/main.o main.c
  gcc ... -o /tmp/bpftool//bootstrap/bpftool /tmp/bpftool//bootstrap/main.o ... /tmp/bpftool/disasm.o
/usr/bin/ld: /tmp/bpftool/disasm.o: Relocations in generic ELF (EM: 183)
/usr/bin/ld: /tmp/bpftool/disasm.o: Relocations in generic ELF (EM: 183)
/usr/bin/ld: /tmp/bpftool/disasm.o: Relocations in generic ELF (EM: 183)
/usr/bin/ld: /tmp/bpftool/disasm.o: error adding symbols: file in wrong format
collect2: error: ld returned 1 exit status

The final bpftool is built for arm64, while the bootstrap bpftool,
executed on the host, is built for x86. The problem here is that disasm.o
linked into the bootstrap bpftool is arm64 rather than x86. With my fix we
build two disasm.o, one for the target bpftool in arm64, and one for the
bootstrap bpftool in x86.

> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  tools/bpf/bpftool/Makefile | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index d16d289ade7a..d73232be1e99 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -136,7 +136,7 @@ endif
> >
> >  BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
> >
> > -BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o) $(OUTPUT)disasm.o
> > +BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o disasm.o)
> >  OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
> >
> >  VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)                           \
> > @@ -180,6 +180,9 @@ endif
> >
> >  CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
> >
> > +$(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
> > +       $(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD -o $@ $<
> > +
> >  $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
> 
> maybe just do
> 
> $(BOOTSTRAP_OUTPUT)disasm.o $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c

They need two different recipes. The bootstrap disasm.o needs to be built
with $(HOSTCC) rather than $(CC) (CC=aarch64-linux-gnu-gcc and HOSTCC=gcc)

Thanks,
Jean

> ?
> 
> >         $(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
> >
> > --
> > 2.31.1
> >
