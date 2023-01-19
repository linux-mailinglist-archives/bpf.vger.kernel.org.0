Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEADB6740A7
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 19:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjASSOO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 13:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjASSOC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 13:14:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8552D90B27
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 10:14:00 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q10so2706072wrs.2
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 10:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CTjaq4NJj+o3gOe98XEHdekO9Q0PwCoOsoTblJCwYoc=;
        b=grCb9Ts4cX4YOVle/uQPR+Fc2itoXnMocKb/H9CPEyeXTBZ2TDEGjAxObVMRadq3X0
         Ek6950qpjUAGlafb/5ywHJvTRuBI/A6rli031niU+autoHZmBc62UeD65lWw6LTlZw3w
         cI9J+ES9rTHUZ1Ug6JC6UpQFe9MJ0+FfI/5hlfsocYPy+/+mq/WJhoHhnlmzpUeQ1QIb
         N6JeDp1zMjmRS/CwaWsNaL4qId86rYcsk1EF8Kv02lQdYwe2NyQt/d5cCgNHVB+0xnJZ
         pM3NYuLPFf+hfFvXNHjv9N8vSdZXIwIyEmhOIDc6WzyIPcZvVIWU7rgSAcls0pEPr+HQ
         aEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTjaq4NJj+o3gOe98XEHdekO9Q0PwCoOsoTblJCwYoc=;
        b=XDfYqTnf75HkJMWHw3Dw6G7/3amkqQLdnZNE0Ov3CTaqWAvBUsL8amxWGjmtb+n+RA
         J0Dfn0en5oup84pQSja4RFLBHglEPGmcKh+S7stK/3r4JCwmirF9hpVIY8pW5RpNhaSA
         HMAogbtueltOYwdDBYx1PO51a6JiTKmvxA6qEJhkVO4sSRTQqX9lEANKeypVPakBKQJA
         LXykDcJfvrbumt8qexr37HGDfonITqnOTmuYbbkEU3AyiikK1sI9p0aM3ZFFLnwp9Aol
         1tCJFEJUz06VxRqRTcxhA+yQxJRFNd1egpYHDiG+7svkaUc5pS4pnNajgaXKNKApb7Vy
         WOlw==
X-Gm-Message-State: AFqh2kqY+Uu/ghzSBJRbm0p4g9Sta4xWAcfXpyqD/0v/Qf+tZz1yyruI
        59VhY0Sk3oRcV3c9O3Hds+4ECQ7wr6PDa/zGXhQWAA==
X-Google-Smtp-Source: AMrXdXubzuRwFMdAKUWWKApxAavsA2MmoeCnhtYTwND98+IZTwX1MxXMkR95iIORdfwU8jxy4lD1xAGEGmn3zIybtVs=
X-Received: by 2002:a05:6000:1d9b:b0:2bc:aa47:bf7a with SMTP id
 bk27-20020a0560001d9b00b002bcaa47bf7amr340047wrb.343.1674152038872; Thu, 19
 Jan 2023 10:13:58 -0800 (PST)
MIME-Version: 1.0
References: <20230116215751.633675-1-irogers@google.com> <20230116215751.633675-2-irogers@google.com>
 <Y8lY6r0g6AvVwcQq@krava>
In-Reply-To: <Y8lY6r0g6AvVwcQq@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Jan 2023 10:13:46 -0800
Message-ID: <CAP-5=fVoWZUAVne0q46Z6w89yyh8DL_u2L6ugs0d5yqF0Ngkig@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tools/resolve_btfids: Alter how HOSTCC is forced
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 6:51 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jan 16, 2023 at 01:57:51PM -0800, Ian Rogers wrote:
> > HOSTCC is always wanted when building. Setting CC to HOSTCC happens
> > after tools/scripts/Makefile.include is included, meaning flags are
> > set assuming say CC is gcc, but then it can be later set to HOSTCC
> > which may be clang. tools/scripts/Makefile.include is needed for host
> > set up and common macros in objtool's Makefile. Rather than override
> > CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the libsubcmd
> > builds and the linkage step. This means the Makefiles don't see things
> > like CC changing and tool flag determination, and similar, work
> > properly.
> >
> > Also, clear the passed subdir as otherwise an outer build may break by
> > inadvertently passing an inappropriate value.
>
> I tested with cross builds for s390/ppc/arm64 and it was ok
>
> some comments below
>
> thanks,
> jirka
>
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/bpf/resolve_btfids/Makefile | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > index 76b737b2560d..515d87b32fb8 100644
> > --- a/tools/bpf/resolve_btfids/Makefile
> > +++ b/tools/bpf/resolve_btfids/Makefile
> > @@ -18,14 +18,11 @@ else
> >  endif
> >
> >  # always use the host compiler
> > -AR       = $(HOSTAR)
> > -CC       = $(HOSTCC)
> > -LD       = $(HOSTLD)
> > -ARCH     = $(HOSTARCH)
>
> I wonder all the tools should use HOSTCC in the first place?
> seems more clear than forcing it from other makefiles
>
> subcmd even has:
>
> CC ?= $(CROSS_COMPILE)gcc
> LD ?= $(CROSS_COMPILE)ld
> AR ?= $(CROSS_COMPILE)ar
>
> which seems wrong unless I'm missing something.. should be always
> the host compiler, right?

Hmm.. it seems like a feature to be able to cross compile things like
the perf tool.

I agree the way this is all done is muddling and we should try to keep
the way it is done consistent. The pattern of always early including
Makefile.include, that sets flags based on CC, but then overriding CC
was what I was after cleaning up here. Let's work on migrating to
something better.

> > +HOST_OVERRIDES := AR=$(HOSTAR) CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
> > +               ARCH=$(HOSTARCH) EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
>
> there's extra AR set and ARCH value is not in ""

Ack. Will fix in v3.

Thanks,
Ian


> > +
> >  RM      ?= rm
> >  CROSS_COMPILE =
> > -CFLAGS  := $(KBUILD_HOSTCFLAGS)
> > -LDFLAGS := $(KBUILD_HOSTLDFLAGS)
> >
> >  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> >
> > @@ -56,12 +53,12 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
> >
> >  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
> >       $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
> > -                 DESTDIR=$(SUBCMD_DESTDIR) prefix= \
> > +                 DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
> >                   $(abspath $@) install_headers
> >
> >  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
> >       $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
> > -                 DESTDIR=$(LIBBPF_DESTDIR) prefix= EXTRA_CFLAGS="$(CFLAGS)" \
> > +                 DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
> >                   $(abspath $@) install_headers
> >
> >  CFLAGS += -g \
> > @@ -76,11 +73,11 @@ export srctree OUTPUT CFLAGS Q
> >  include $(srctree)/tools/build/Makefile.include
> >
> >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> > -     $(Q)$(MAKE) $(build)=resolve_btfids
> > +     $(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
> >
> >  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
> >       $(call msg,LINK,$@)
> > -     $(Q)$(CC) $(BINARY_IN) $(LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
> > +     $(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
> >
> >  clean_objects := $(wildcard $(OUTPUT)/*.o                \
> >                              $(OUTPUT)/.*.o.cmd           \
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
