Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB61670E65
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 01:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjARAIC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 19:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjARAHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 19:07:43 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF34A6CCC6
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 15:20:51 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso300403wms.3
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 15:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wdNV2FR4hnXWIMBBxcsFSzsqX2FCul/r2qCos1KeHcM=;
        b=XuK6YF0KKbfzucFCrwkHMoNMM+miRvxE5AejKyv5FQUNIsCUkSS/zQ6DoVtCUkI6jo
         JuDMgnayppjfSUX7c8LlLOhmiru/YoBiyBMGFbAnh+V7CH/dug9WwqyanhSvdl4EuUH5
         R/ehasZ6ygNDGGI7wAndG9Lrm04fDUaH0bYgZD6FUGkiYeIcObWeTr0kEEbwdYBwWmvc
         ZnNSirXXw0nNA3t3kfYuoX+Ce2U+dCf1iLHbLzNRlmuJA+STYmvFReTbSqmu6tXfiqzE
         2Wc4ETVQWS1jMEV/7GY0ytntQxXgf+VgfEWM5xSVYZduMl0DNE9c99a3cBzfjcW5Ddiz
         41jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdNV2FR4hnXWIMBBxcsFSzsqX2FCul/r2qCos1KeHcM=;
        b=YhMKlrdx0Q42MhVJ8I2joxFcRHMsTvhKrT5KgKtjShwfWTfuZgs+LUAZhAVlpDxlWF
         bxrDBOWR+bwiDpkZYkT87Fd081VJ1InkiFASrQouyH93dJOEvRbOdNvcye60WlOcm01N
         AitqWT8EAWqg741DAKWefXATMXgLlHrsEpVDPl/Bv+A8O39c2fOzqSr1bj/q1ZUOLqMR
         1owwoisQ1VYc+TJexfWM/2WcoyjhVQqJLojLfquN2bmJXJDbsNwwpyF+DNuLo+3/gwMX
         kYnzYbY9TaKoPpa3dshCsC23IP46E4aIuQb0fhYPnHbrt0XOXhA5Fr9WSy5aBQiK0+9z
         5BkQ==
X-Gm-Message-State: AFqh2kouyitSf01W4h4C8Zvw730OK9MuOFizLvSkTLno7l14gfJWRbCo
        ypNg5HukvQlNKJrYgnvJ+QKD5UoxlZYGLTBpoO5cpg==
X-Google-Smtp-Source: AMrXdXvKSsoT3S4sKll4NhicB3YTnPH8QUSuxVuARPL+6mJghsZX4UAtA3dzLXpkw8RiKx6pTIPbT7U0+o0/7XP/EjM=
X-Received: by 2002:a1c:7404:0:b0:3da:b40f:c734 with SMTP id
 p4-20020a1c7404000000b003dab40fc734mr406100wmc.115.1673997650192; Tue, 17 Jan
 2023 15:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20230116215751.633675-1-irogers@google.com> <20230116215751.633675-2-irogers@google.com>
 <Y8ccM3pkCsp1XAnw@krava>
In-Reply-To: <Y8ccM3pkCsp1XAnw@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 17 Jan 2023 15:20:38 -0800
Message-ID: <CAP-5=fVbSO14rVQEnXMiEw5pf+UUc_oPWc4=ouw2L+UYiP0+YA@mail.gmail.com>
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

On Tue, Jan 17, 2023 at 2:07 PM Jiri Olsa <olsajiri@gmail.com> wrote:
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
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> lgtm did you try cross build and build with clang?

Hmm.. I don't have a cross build but I checked clang. Any chance you
could check the cross build?

Thanks,
Ian

> jirka
>
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
> > +HOST_OVERRIDES := AR=$(HOSTAR) CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
> > +               ARCH=$(HOSTARCH) EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
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
