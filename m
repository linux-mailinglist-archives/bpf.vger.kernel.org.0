Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAD566D0C6
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 22:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjAPVP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 16:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjAPVP1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 16:15:27 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB121A3B
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 13:15:26 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so24482850wmb.2
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 13:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WhKvfliPWjeYRlf9KlWOibV02oeF9LVlkFGqKN45jSg=;
        b=LdqHevJ7SNQAOSKe68U1ISBc2e4FYx0CQ9DIsjjEh9Efuas3xHB5UrYyHjvrcCDMaZ
         Til4k+AjL4okkXjcpbqusd1pOlr4xCuVaZUu3dVFirrE0F44Krmg/rJCY9HKS5+sIEHC
         pvj23xGbp6PFj+Ajl5xX355zfAjdI+BjR1aKvA/7LLZNHZZNwCxKHc6GG3+IRtC0hcIw
         th36nqZmZLdphBpEg6kmQqpwMl4yYxcgIYIgdlck+v6qKfzjH1TrKW0xVubsyvL/K4re
         cGzLAGxeFRDQAcVg4J5XiWx/Kr5E6AnZ0VJ6BP9pzvmXRB2PC4p/qO/ga3fJY5VGle4t
         yjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhKvfliPWjeYRlf9KlWOibV02oeF9LVlkFGqKN45jSg=;
        b=rQPxYkFRfcLo3umxxBu6CL6Tkqi7NQNO1KP9BZZkvUl+Vd3WaHxWPVw+eUMlGvqRwc
         K0XPUkNjZwX5tuEEtgAdRGW4+BukeAV+9D3QX0ZvMauPJgSnFqw2qNy6UW+jOJEdpFVr
         JLMN1LWZShrtP3h9J10KpRuen9KfQY4iiz2CATX9yztotbS1kMvMJFlY8gS8Wbn9kjbR
         ppgMa6MbZuTKcvQkNryqceP0onq4PN2d7Ke3mRS4Idpa1Y7znvt080fG89/yMUggSxbF
         IaOIynHOS8pSXmCnFlFpAZXibhFDPP064zx0X28ggSGB+ti3yfIvcepjGYdkTaKHVIVx
         zjKg==
X-Gm-Message-State: AFqh2kpohx7Fnzc5X0SWzxW0QbEIS+JGxeW/wCYbbOkw7HYouGYdHI4X
        n7ds9Rjrrp/U4QtUYdVcv4X82uLzGhEOpXz4zHDnqg==
X-Google-Smtp-Source: AMrXdXsBdvvX9ajJKzWjK4fc0capcTkKIGnMHD2Gc+3LzuF7IBBVMW5SlcWvK/Sk8GfFV+H/2dPEqjOAlOHwRk7xhio=
X-Received: by 2002:a05:600c:2247:b0:3da:27dd:9585 with SMTP id
 a7-20020a05600c224700b003da27dd9585mr35443wmm.182.1673903724574; Mon, 16 Jan
 2023 13:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20230112004024.1934601-1-irogers@google.com> <Y8Uzet0cNtDo8kHe@krava>
 <CAP-5=fXjjnivhuVSRj7yjaea+6E-YfVKP+Tz2BsTNSqUBDvm4g@mail.gmail.com> <Y8WVVLEIkXgYvePd@krava>
In-Reply-To: <Y8WVVLEIkXgYvePd@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 16 Jan 2023 13:15:11 -0800
Message-ID: <CAP-5=fUKZwbnGA6H96w5U_-L6s7XMHvXkcQXQCrYpup_Qs4aSA@mail.gmail.com>
Subject: Re: [PATCH v1] tools/resolve_btfids: Install subcmd headers
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 16, 2023 at 10:20 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jan 16, 2023 at 09:20:39AM -0800, Ian Rogers wrote:
> > On Mon, Jan 16, 2023 at 3:22 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Wed, Jan 11, 2023 at 04:40:24PM -0800, Ian Rogers wrote:
> > > > Previously tools/lib/subcmd was added to the include path, switch to
> > > > installing the headers and then including from that directory. This
> > > > avoids dependencies on headers internal to tools/lib/subcmd. Add the
> > > > missing subcmd directory to the affected #include.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/bpf/resolve_btfids/Makefile | 19 ++++++++++++++-----
> > > >  tools/bpf/resolve_btfids/main.c   |  2 +-
> > > >  2 files changed, 15 insertions(+), 6 deletions(-)
> > >
> > > this depends on changes that went to Arnaldo's tree right?
> > > I can't apply this on bpf-next/master
> >
> > Hmm.. sorry for that. I did the work on the master branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >
> > > >
> > > > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > > > index 19a3112e271a..de7d29cf43d6 100644
> > > > --- a/tools/bpf/resolve_btfids/Makefile
> > > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > > @@ -35,21 +35,29 @@ SUBCMD_SRC := $(srctree)/tools/lib/subcmd/
> > > >  BPFOBJ     := $(OUTPUT)/libbpf/libbpf.a
> > > >  LIBBPF_OUT := $(abspath $(dir $(BPFOBJ)))/
> > > >  SUBCMDOBJ  := $(OUTPUT)/libsubcmd/libsubcmd.a
> > > > +SUBCMD_OUT := $(abspath $(dir $(SUBCMDOBJ)))/
> > > >
> > > >  LIBBPF_DESTDIR := $(LIBBPF_OUT)
> > > >  LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
> > > >
> > > > +SUBCMD_DESTDIR := $(SUBCMD_OUT)
> > > > +SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
> > > > +
> > > >  BINARY     := $(OUTPUT)/resolve_btfids
> > > >  BINARY_IN  := $(BINARY)-in.o
> > > >
> > > >  all: $(BINARY)
> > > >
> > > > +prepare: $(SUBCMDOBJ)
> > >
> > > do we need special target for that? we already have BPFOBJ dependency
> > > placed in the BINARY_IN as prereq
> >
> > BPFOBJ is $(OUTPUT)/libbpf/libbpf.a which is needed at link time. The
> > prepare step is one we have elsewhere and it creates things like the
> > header files necessary to compile the C code, so we need it earlier is
> > the answer.
> >
> > > why not place both as BINARY_IN prereq, or is there some other reason
> > > for new 'prepare' target?
> >
> > I was trying to follow the convention elsewhere in the tree of having
> > a prepare target that does things like get the necessary header files
> > ready. Having prepare is useful because if an additional dependency is
> > added, then it just needs to be added to prepare. It could be tedious
> > to list all the dependencies for every C file, although Makefile.build
>
> ok, could we maybe add the BPFOBJ in prepare target as well?

Agreed, added to v2.

> > handles most of that. It isn't clear to me why $(BPFOBJ) is a
> > dependency of $(BINARY_IN) as it is already a dependency of $(BINARY).
>
> I think that if you specify OUTPUT then we need the libbpf headers
> to be created before we go to compile resolve_btfids objects
>
> thanks,
> jirka

Yep. I also noticed that this code is doing the "CC=$(HOSTCC)" thing.
The problem with that is Makefile.include (line 2) will set things
like CFLAGS based on CC and then you change it. I sent out some
objtool build cleanup for this:
https://lore.kernel.org/lkml/20230105090155.357604-4-irogers@google.com/
I'll add a patch for this in v2.

Thanks,
Ian
