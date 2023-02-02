Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E896889A0
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 23:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjBBWUp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 17:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjBBWUo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 17:20:44 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D88466F92
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 14:20:43 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mc11so10204540ejb.10
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 14:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zhKP9YiXZMYpDGl1JnBKmQMwpeHpPkEKiyd3rkB/Pzg=;
        b=DIe9HOYKuvrsI7LYIzNtA5ir9bm+QFJVaW5NnWc6gD4vVdgh0kE7PZXp3s5zl4Nky1
         PUiwEEHWW8dD55KzV2ilxOLTa8dhr8ej3B2BRSY6BCDG4XGGiluHkbBnvP+hd/MyGPw6
         m+rJUeZZX/WaG91lMglYDf/hFP3GYUQqSnaqTsPFxYn10C4cqHmfaMsSJz8kv/Y8aE9b
         4iGL6CT0Fr7wd9fiEZ0tVCVNmPC+ja7S0IKcDFX7Gu/PZCbquyGTd0hbzhq+i04Gmm56
         fZx0OgG7csaYLD8RhD/IZktBoP8VdQuvFWOxK//ydYO5pREVQZReGNi+BUwZ/1suQTYi
         KrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhKP9YiXZMYpDGl1JnBKmQMwpeHpPkEKiyd3rkB/Pzg=;
        b=oC015TikcnmxT4w1gwAueJv+95aCZfxKJroxQ6qHGGg6pX1UZbJTTQsuyO/ZJ2eLop
         KG5O1hWoOjjV9Wraed9XrrOVmQNQLLeriQtnA64Zy0hL18XAdNr8mHNZcwKZwRrzJMe6
         pyiw+zwdGKXVL7JSocO3/NI4osmj1DVkDkJX9n/p+mbi5HMPDVlCoonFheZG9gVrdcpT
         iACGy3zzFn6/jxie4vEotgjQ7BhPiXbBriI1lqpu5P3jRPL9KHI7Q8S99XL2MhpfzPQ4
         ThF7MbqIWcP2KM8hbt61BO9vGmVa9r0FUHcltH38LXJlz8K+V+CdFiP9n5CWO3FI3IJI
         spVA==
X-Gm-Message-State: AO0yUKVGuXw8jlZdTyDsyxiPfNe4dDanrFphNSJreFy4lGIQDlFQgeYG
        FjVe2m0QsrmS6AnFpAwRk7E=
X-Google-Smtp-Source: AK7set9iBgYjJZPgugegnoZ4Ej5PYixVUPRv8rbNscd/XyIyKrSWVQ7ZzpHwYZ2PxNwt26VaGf+yIQ==
X-Received: by 2002:a17:907:6eab:b0:88d:ba89:182f with SMTP id sh43-20020a1709076eab00b0088dba89182fmr3776743ejc.0.1675376441562;
        Thu, 02 Feb 2023 14:20:41 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id en14-20020a056402528e00b0049622a61f8fsm292033edb.30.2023.02.02.14.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:20:41 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 2 Feb 2023 23:20:39 +0100
To:     Ian Rogers <irogers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Compile resolve_btfids as
 host program
Message-ID: <Y9w3N4GHxipREEoO@krava>
References: <20230202112839.1131892-1-jolsa@kernel.org>
 <Y9vxFLA6Xj/zPjQu@dev-arch.thelio-3990X>
 <CAP-5=fXy0wArjfXTQHD6nXZ=8dxb6ypRMef=-M1+uTTvbdfH0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXy0wArjfXTQHD6nXZ=8dxb6ypRMef=-M1+uTTvbdfH0A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 12:14:14PM -0800, Ian Rogers wrote:
> On Thu, Feb 2, 2023 at 9:21 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Thu, Feb 02, 2023 at 12:28:39PM +0100, Jiri Olsa wrote:
> > > Making resolve_btfids to be compiled as host program so
> > > we can avoid cross compile issues as reported by Nathan.
> > >
> > > Also we no longer need HOST_OVERRIDES for BINARY target,
> > > just for 'prepare' targets.
> > >
> > > Cc: Ian Rogers <irogers@google.com>
> > > Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> >
> 
> This change has my,
> Acked-by: Ian Rogers <irogers@google.com>

thanks

> but I wonder about cleaning HOST_OVERRIDES. From the patch I sent,
> would it be worth adding:
> ```
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -17,9 +17,9 @@ else
>   MAKEFLAGS=--no-print-directory
> endif
> 
> -# always use the host compiler
> +# Overrides for the prepare step libraries.
> HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)"
> ARCH="$(HOSTARCH)" \
> -                 EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> +                 CROSS_COMPILE=""
> 
> RM      ?= rm
> HOSTCC  ?= gcc
> ```
> It seems odd passing HOSTCFLAGS this way and mixing HOSTCC as CC with
> CROSS_COMPILE set seems open to failure. Perhaps we should just get
> rid of this, add something like a HOST=1 option for building the
> library and then in the library code do the right thing. That would
> fix the issue that libsubcmd and libbpf here are being built reporting
> CC rather than HOSTCC, make the build flags in general more sane.

could you send separate patch with that?

also I'll try to check if we could make prepare libs as hostprogs,
because I think the changes you suggest might depend on that

jirka

> 
> Thanks,
> Ian
> 
> > > ---
> > >  tools/bpf/resolve_btfids/Build    | 4 +++-
> > >  tools/bpf/resolve_btfids/Makefile | 9 ++++++---
> > >  2 files changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
> > > index ae82da03f9bf..077de3829c72 100644
> > > --- a/tools/bpf/resolve_btfids/Build
> > > +++ b/tools/bpf/resolve_btfids/Build
> > > @@ -1,3 +1,5 @@
> > > +hostprogs := resolve_btfids
> > > +
> > >  resolve_btfids-y += main.o
> > >  resolve_btfids-y += rbtree.o
> > >  resolve_btfids-y += zalloc.o
> > > @@ -7,4 +9,4 @@ resolve_btfids-y += str_error_r.o
> > >
> > >  $(OUTPUT)%.o: ../../lib/%.c FORCE
> > >       $(call rule_mkdir)
> > > -     $(call if_changed_dep,cc_o_c)
> > > +     $(call if_changed_dep,host_cc_o_c)
> > > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > > index daed388aa5d7..abdd68ac08f4 100644
> > > --- a/tools/bpf/resolve_btfids/Makefile
> > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > @@ -22,6 +22,9 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
> > >                 EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> > >
> > >  RM      ?= rm
> > > +HOSTCC  ?= gcc
> > > +HOSTLD  ?= ld
> > > +HOSTAR  ?= ar
> > >  CROSS_COMPILE =
> > >
> > >  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> > > @@ -64,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
> > >  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> > >  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> > >
> > > -CFLAGS += -g \
> > > +HOSTCFLAGS += -g \
> > >            -I$(srctree)/tools/include \
> > >            -I$(srctree)/tools/include/uapi \
> > >            -I$(LIBBPF_INCLUDE) \
> > > @@ -73,11 +76,11 @@ CFLAGS += -g \
> > >
> > >  LIBS = $(LIBELF_LIBS) -lz
> > >
> > > -export srctree OUTPUT CFLAGS Q
> > > +export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
> > >  include $(srctree)/tools/build/Makefile.include
> > >
> > >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> > > -     $(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
> > > +     $(Q)$(MAKE) $(build)=resolve_btfids
> > >
> > >  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
> > >       $(call msg,LINK,$@)
> > > --
> > > 2.39.1
> > >
