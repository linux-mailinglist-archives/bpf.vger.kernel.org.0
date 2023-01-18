Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C64672B52
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 23:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjARWbE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 17:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjARWak (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 17:30:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A1E47EE2;
        Wed, 18 Jan 2023 14:30:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v5so705654edc.3;
        Wed, 18 Jan 2023 14:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWvijKrwl15jXFb6uDYvZYZZ8XxHXT0j0cKpcyIGLvk=;
        b=l7aEfFt1G8GYjFlzRJIqYxt0RJUQu/e65DksD7Ojn7ZuRA9tIGndtVq+ZzzAnanqEm
         6ogJFxc4/nbK2clLPr2x65vJEMvCtq0vsVFN+bN/ZuXWOQO2y+0FPU2kLUURuoOPasCb
         gq9p3dykBCpF+SC893gsGUxoEx+uatygY0zArD44JGmvNA+2k1T9bQ7s49kw7ijHwYxX
         Mh5J9mZVZQHZ2NElP9fwTjjhCL0akN/UdjhjhuC3RYysPXDkRyyu9LAbPSHhGOKG9lV4
         f0tG79ttGChzBDGHBMICeEliS8lRmIZ5mVkKutJSf4RqXoEG3k9bvuOftU7tsW8C9rLk
         /r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWvijKrwl15jXFb6uDYvZYZZ8XxHXT0j0cKpcyIGLvk=;
        b=nI7gOFoOjiBGs8TT2v85L/A70wcmJ9kqjSIDkkPWI2BgwFHMAIRXnUuJNE5mFJzS4D
         KyvVBQBHPnsUta+mxR5LEW0thJv37b0Rh/ehhJJOqLTfa0sVofx3einPXQxByj85Mefh
         5bkAA70r02lno9sXXvaqPW9Z452XP4Qssx16MII7ExOYOIW+TZ/LG6T81R3BYOy4ZXGX
         K9SS6t2aYjbjqWw5ohMBbLTgK+RlSCLcU/as1PTp49N/ZvMjakGVYySCK7kUikiN2GWd
         LdiwHbn1vW4aB7xF+qlLNUKaqH732AucFUSdlxSmO1L15pwYziKhwkSJNtu0zi89O4eI
         FBEA==
X-Gm-Message-State: AFqh2kqa4pg3b+s8CH9Syg6ZJzhCd0d0vb/g1tMhX2mls1J/Lhz/OMIH
        BXYxDrC8DHWP6ecwr7hWQ3g=
X-Google-Smtp-Source: AMrXdXs0OokmHe/PAUTK5rdyllEbS1BeTwrvCqj/QhTr7TFFHglfRaI6NxkB1T4Pqa5hbQvDiM7F6Q==
X-Received: by 2002:a05:6402:547:b0:499:bec8:4d with SMTP id i7-20020a056402054700b00499bec8004dmr19963057edx.32.1674081037205;
        Wed, 18 Jan 2023 14:30:37 -0800 (PST)
Received: from krava ([83.240.63.129])
        by smtp.gmail.com with ESMTPSA id en6-20020a056402528600b00499b3d09bd2sm12535862edb.91.2023.01.18.14.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 14:30:36 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 18 Jan 2023 23:30:33 +0100
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
Subject: Re: [PATCH v2 2/2] tools/resolve_btfids: Alter how HOSTCC is forced
Message-ID: <Y8hzCYtip9Q6BD7m@krava>
References: <20230116215751.633675-1-irogers@google.com>
 <20230116215751.633675-2-irogers@google.com>
 <Y8ccM3pkCsp1XAnw@krava>
 <CAP-5=fVbSO14rVQEnXMiEw5pf+UUc_oPWc4=ouw2L+UYiP0+YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVbSO14rVQEnXMiEw5pf+UUc_oPWc4=ouw2L+UYiP0+YA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 03:20:38PM -0800, Ian Rogers wrote:
> On Tue, Jan 17, 2023 at 2:07 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Jan 16, 2023 at 01:57:51PM -0800, Ian Rogers wrote:
> > > HOSTCC is always wanted when building. Setting CC to HOSTCC happens
> > > after tools/scripts/Makefile.include is included, meaning flags are
> > > set assuming say CC is gcc, but then it can be later set to HOSTCC
> > > which may be clang. tools/scripts/Makefile.include is needed for host
> > > set up and common macros in objtool's Makefile. Rather than override
> > > CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the libsubcmd
> > > builds and the linkage step. This means the Makefiles don't see things
> > > like CC changing and tool flag determination, and similar, work
> > > properly.
> > >
> > > Also, clear the passed subdir as otherwise an outer build may break by
> > > inadvertently passing an inappropriate value.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > lgtm did you try cross build and build with clang?
> 
> Hmm.. I don't have a cross build but I checked clang. Any chance you
> could check the cross build?

ok, I'll try tomorrow

jirka

> 
> Thanks,
> Ian
> 
> > jirka
> >
> > > ---
> > >  tools/bpf/resolve_btfids/Makefile | 17 +++++++----------
> > >  1 file changed, 7 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > > index 76b737b2560d..515d87b32fb8 100644
> > > --- a/tools/bpf/resolve_btfids/Makefile
> > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > @@ -18,14 +18,11 @@ else
> > >  endif
> > >
> > >  # always use the host compiler
> > > -AR       = $(HOSTAR)
> > > -CC       = $(HOSTCC)
> > > -LD       = $(HOSTLD)
> > > -ARCH     = $(HOSTARCH)
> > > +HOST_OVERRIDES := AR=$(HOSTAR) CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
> > > +               ARCH=$(HOSTARCH) EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> > > +
> > >  RM      ?= rm
> > >  CROSS_COMPILE =
> > > -CFLAGS  := $(KBUILD_HOSTCFLAGS)
> > > -LDFLAGS := $(KBUILD_HOSTLDFLAGS)
> > >
> > >  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> > >
> > > @@ -56,12 +53,12 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
> > >
> > >  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
> > >       $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
> > > -                 DESTDIR=$(SUBCMD_DESTDIR) prefix= \
> > > +                 DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
> > >                   $(abspath $@) install_headers
> > >
> > >  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
> > >       $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
> > > -                 DESTDIR=$(LIBBPF_DESTDIR) prefix= EXTRA_CFLAGS="$(CFLAGS)" \
> > > +                 DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
> > >                   $(abspath $@) install_headers
> > >
> > >  CFLAGS += -g \
> > > @@ -76,11 +73,11 @@ export srctree OUTPUT CFLAGS Q
> > >  include $(srctree)/tools/build/Makefile.include
> > >
> > >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> > > -     $(Q)$(MAKE) $(build)=resolve_btfids
> > > +     $(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
> > >
> > >  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
> > >       $(call msg,LINK,$@)
> > > -     $(Q)$(CC) $(BINARY_IN) $(LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
> > > +     $(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
> > >
> > >  clean_objects := $(wildcard $(OUTPUT)/*.o                \
> > >                              $(OUTPUT)/.*.o.cmd           \
> > > --
> > > 2.39.0.314.g84b9a713c41-goog
> > >
