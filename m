Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7F368881D
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 21:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjBBUOa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 15:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjBBUO3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 15:14:29 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2963C4A22D
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 12:14:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m14so2742130wrg.13
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 12:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H2Sm+srffVa/bWbuBY8DFLL8/hTuLtKAVOyj/q7LSGk=;
        b=kid3uXCaby0KvWyO2/F2i9i/uBvcGgAw/yO3rlfqM7D1ZI6aCjGPLUeHHayC/QwVYw
         zl2uygt2CMAlMD8/ZocldvOHeDfBlq7atpmr9JmRRDAod7+7DC+oJasyfC64N0V7I7ms
         /rEt5jxXJ4Sy9TU7G8MmGuxSOi11sSlmj1uXc9HmsQHO0JQ8t/Dc9us6+7t3YRogeShO
         nGnqqUF+gDzxqDsJft6uMUVXiZSyB5+1Cn1B9MzmaPUxVNU+/fRyIVUtWiLuswGsMAAP
         apirGUJVNy2JDDmKdsPCI2DIr4Lr9VjP6HEZ93ErUbrfIfq0nnLy/kyR/0lbwv68R1tz
         3XpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2Sm+srffVa/bWbuBY8DFLL8/hTuLtKAVOyj/q7LSGk=;
        b=jL0EXIE0v3OfJ3CiWrcKESE6VANP4YZBchiyelViACu74G/Vj6WSSnmkLtxuxvORcK
         93qyL2zPd4I0TrDa3Wcj/oIjuSWi5O0HV+/omQiyXcxnG81ii2hDSM0J68q9+Ct8SbO4
         ExaTft/JHDfsIPbWPVG6kveDGY3zlzYnvr+N0y+62TEYroDqpPb2lzcCRs1CWXodbL3j
         eYkCwR1+R8pwTd+hJm+OAS71dKWX+CPMB0+GzfXcSA2V+cPWx4tUFtcRLcWRPjNwK5UC
         xFIPDugSkGU4PBlv2zRMc/xzQU75AicrLbxBX8qRkNNfXrO/zGmA56kz+cJ7MU7XOZIt
         h2EQ==
X-Gm-Message-State: AO0yUKW2Z6brZ4V/bh76cwYHeoebbRAu2WBCtcRX71gWsqX7Iru6WkaT
        t+AOqkGePShqggqcDVkZv7NBvxpICd9/SP3H0b6CoA==
X-Google-Smtp-Source: AK7set9sr3b05QV9TKVRp3Tg4zooaH4c7HKY5TH384D9N7usy4nUGBQt/RWkDYodr9ZYZZjoBNMTf6EolB9SIadOZfE=
X-Received: by 2002:adf:e351:0:b0:2bf:eba5:b652 with SMTP id
 n17-20020adfe351000000b002bfeba5b652mr180693wrj.19.1675368866471; Thu, 02 Feb
 2023 12:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20230202112839.1131892-1-jolsa@kernel.org> <Y9vxFLA6Xj/zPjQu@dev-arch.thelio-3990X>
In-Reply-To: <Y9vxFLA6Xj/zPjQu@dev-arch.thelio-3990X>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Feb 2023 12:14:14 -0800
Message-ID: <CAP-5=fXy0wArjfXTQHD6nXZ=8dxb6ypRMef=-M1+uTTvbdfH0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Compile resolve_btfids as
 host program
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
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

On Thu, Feb 2, 2023 at 9:21 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Feb 02, 2023 at 12:28:39PM +0100, Jiri Olsa wrote:
> > Making resolve_btfids to be compiled as host program so
> > we can avoid cross compile issues as reported by Nathan.
> >
> > Also we no longer need HOST_OVERRIDES for BINARY target,
> > just for 'prepare' targets.
> >
> > Cc: Ian Rogers <irogers@google.com>
> > Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>

This change has my,
Acked-by: Ian Rogers <irogers@google.com>
but I wonder about cleaning HOST_OVERRIDES. From the patch I sent,
would it be worth adding:
```
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -17,9 +17,9 @@ else
  MAKEFLAGS=--no-print-directory
endif

-# always use the host compiler
+# Overrides for the prepare step libraries.
HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)"
ARCH="$(HOSTARCH)" \
-                 EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
+                 CROSS_COMPILE=""

RM      ?= rm
HOSTCC  ?= gcc
```
It seems odd passing HOSTCFLAGS this way and mixing HOSTCC as CC with
CROSS_COMPILE set seems open to failure. Perhaps we should just get
rid of this, add something like a HOST=1 option for building the
library and then in the library code do the right thing. That would
fix the issue that libsubcmd and libbpf here are being built reporting
CC rather than HOSTCC, make the build flags in general more sane.

Thanks,
Ian

> > ---
> >  tools/bpf/resolve_btfids/Build    | 4 +++-
> >  tools/bpf/resolve_btfids/Makefile | 9 ++++++---
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
> > index ae82da03f9bf..077de3829c72 100644
> > --- a/tools/bpf/resolve_btfids/Build
> > +++ b/tools/bpf/resolve_btfids/Build
> > @@ -1,3 +1,5 @@
> > +hostprogs := resolve_btfids
> > +
> >  resolve_btfids-y += main.o
> >  resolve_btfids-y += rbtree.o
> >  resolve_btfids-y += zalloc.o
> > @@ -7,4 +9,4 @@ resolve_btfids-y += str_error_r.o
> >
> >  $(OUTPUT)%.o: ../../lib/%.c FORCE
> >       $(call rule_mkdir)
> > -     $(call if_changed_dep,cc_o_c)
> > +     $(call if_changed_dep,host_cc_o_c)
> > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > index daed388aa5d7..abdd68ac08f4 100644
> > --- a/tools/bpf/resolve_btfids/Makefile
> > +++ b/tools/bpf/resolve_btfids/Makefile
> > @@ -22,6 +22,9 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
> >                 EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> >
> >  RM      ?= rm
> > +HOSTCC  ?= gcc
> > +HOSTLD  ?= ld
> > +HOSTAR  ?= ar
> >  CROSS_COMPILE =
> >
> >  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> > @@ -64,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
> >  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> >  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> >
> > -CFLAGS += -g \
> > +HOSTCFLAGS += -g \
> >            -I$(srctree)/tools/include \
> >            -I$(srctree)/tools/include/uapi \
> >            -I$(LIBBPF_INCLUDE) \
> > @@ -73,11 +76,11 @@ CFLAGS += -g \
> >
> >  LIBS = $(LIBELF_LIBS) -lz
> >
> > -export srctree OUTPUT CFLAGS Q
> > +export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
> >  include $(srctree)/tools/build/Makefile.include
> >
> >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> > -     $(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
> > +     $(Q)$(MAKE) $(build)=resolve_btfids
> >
> >  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
> >       $(call msg,LINK,$@)
> > --
> > 2.39.1
> >
