Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0765F7CF
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 00:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjAEXm7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 18:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbjAEXml (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 18:42:41 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F89C6D514
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 15:41:06 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id e21so16943215pfl.1
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 15:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=igut5By295ohhbEPdn0DgsM5vVo3aXkJJjZjswdn8UY=;
        b=qs7RYzkrlMT2Nl3hQIAyrmGqJrH24pdSDWZlzwhTjCY6nATSPnjRz6EfHi3wfuetnN
         s60wR3yXY1JTF3+3oy0LRNs2OCgvBKmrI8RAuy/+Pz9om7nxUUri4oTIYe33DCI328W1
         7ryeq28hbWdZ9/1juDX2pd2fmLoVn8kc1Nm6Mo4clL6dwVGc2jbU3ExkwTEn8R/+5WaM
         ykrs8HgNXaOE8vMgwYRm8WLtugNefPG006dIHMsyK2sB0yIsckEdT87Q6QpGOyVE+/Cm
         6at3ZsZixNLe0txQl5RwwBd5hKe1AE9P3mwZ3oKcyFoU0sCdEjBli4T3/7L2lA/qAmr1
         nBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igut5By295ohhbEPdn0DgsM5vVo3aXkJJjZjswdn8UY=;
        b=ZkX+BaxEZveliCswzE3vvV1SKpOetW9aDYoZTbuB0W1/lop3/WlqS6xta5q5E/47p5
         9GKOkXOJ/n4aYK6Y9LQ816FIcKyErNaCJjh71ZAjMnJFJovzJL9IZdiFaFnl0LCAFAc8
         ewPP1PDuEb54VTkPeP5y0ZP5mgJdzTtJtTf6M94gVSkm9otGroTq/c1y2/hP5a23QCWb
         7x+Z0FZwLy0qi7yCMeInue9+1obbDMqykD8fg7xyc3wDr2ogP2A1Jx+mXIoYlGpJHewZ
         Bt1EigH8vY8InCveIjcsBRSApMSEWxfFUbYw9hLg5xNKyvxNncjLszhlDfBduYJaei5B
         NNqw==
X-Gm-Message-State: AFqh2ko3FZxft2c561PyUuLjs1sp0lYUq/pYr3hOawj3AG2Il1xdLL4q
        J5SaKSNprDRP9/IW4CepETngcKhbB6AeBSDiMJgtkQ==
X-Google-Smtp-Source: AMrXdXugDzcPRw8akQUnimNieQGXT5vrbET6KMq++smBmLsoX9gB0xzfMyGylK18zzLyJ6rGdGEZw7/yCqdVpyI1R+I=
X-Received: by 2002:a63:5241:0:b0:4a3:9414:d667 with SMTP id
 s1-20020a635241000000b004a39414d667mr881249pgl.573.1672962053655; Thu, 05 Jan
 2023 15:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20230105172243.7238-1-mike.leach@linaro.org> <CAP-5=fVbPVE4rxJ2s8phhJ5RRH4EnKaWrF2kaT0oCmK6kvhP2g@mail.gmail.com>
In-Reply-To: <CAP-5=fVbPVE4rxJ2s8phhJ5RRH4EnKaWrF2kaT0oCmK6kvhP2g@mail.gmail.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 5 Jan 2023 23:40:42 +0000
Message-ID: <CAJ9a7Vi7cB2t3wao9d78j3G9v4zpO8_hHf8DB4vKOzgT9O+j6g@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix build error when NO_LIBBPF=1
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Thu, 5 Jan 2023 at 19:03, Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Jan 5, 2023 at 9:22 AM Mike Leach <mike.leach@linaro.org> wrote:
> >
> > Recent updates to perf build result in the following output when cross
> > compiling to aarch64, with libelf unavailable, and therefore
> > NO_LIBBPF=1 set.
> >
> > ```
> >   $make -C tools/perf
> >
> >   <cut>
> >
> >   Makefile.config:428: No libelf found. Disables 'probe' tool, jvmti
> >   and BPF support in 'perf record'. Please install libelf-dev,
> >   libelf-devel or elfutils-libelf-devel
> >
> >   <cut>
> >
> >   libbpf.c:46:10: fatal error: libelf.h: No such file or directory
> >       46 | #include <libelf.h>
> >          |          ^~~~~~~~~~
> >   compilation terminated.
> >
> >   ./tools/build/Makefile.build:96: recipe for target
> >   '.tools/perf/libbpf/staticobjs/libbpf.o' failed
> >
> > ```
> >
> > plus one other include error for <gelf.h>
>
> Ouch, apologies for the breakage. You wouldn't happen to have
> something like a way with say a docker image to repro the problem? The
> make line above is somewhat minimal.
>

Unfortunately not - I was cross compiling on my main workstation.
However, in theory
$make -C tools/perf NO_LIBBPF=1
should explicitly exclude the library from the build - which without
the fix it does not.

> > The issue is that the commit noted below adds libbpf to the prepare:
> > target but no longer accounts for the NO_LIBBPF define. Additionally
> > changing the include directories means that even if the libbpf target
> > build is prevented, bpf headers are missing in other parts of the build.
> >
> > This patch ensures that in the case of NO_LIBBPF=1, the build target is
> > changed to a header only target, and the headers are installed, without
> > attempting to build the libbpf.a target.
> >
> > Applies to perf/core
> >
> > Fixes: 746bd29e348f ("perf build: Use tools/lib headers from install path")
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >  tools/perf/Makefile.perf | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 13e7d26e77f0..ee08ecf469f6 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -305,7 +305,11 @@ else
> >  endif
> >  LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
> >  LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
> > +ifndef NO_LIBBPF
> >  LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
> > +else
> > +LIBBPF = $(LIBBPF_INCLUDE)/bpf/bpf.h
>
> This seems strange, don't we want to avoid libbpf targets?
>

This is a header only target - see my continuation comment below....

> > +endif
> >  CFLAGS += -I$(LIBBPF_OUTPUT)/include
> >
> >  ifneq ($(OUTPUT),)
> > @@ -826,10 +830,16 @@ $(LIBAPI)-clean:
> >         $(call QUIET_CLEAN, libapi)
> >         $(Q)$(RM) -r -- $(LIBAPI_OUTPUT)
> >
> > +ifndef NO_LIBBPF
> >  $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
> >         $(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
> >                 O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
> >                 $@ install_headers
> > +else
> > +$(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
> > +       $(Q)$(MAKE) -C $(LIBBPF_DIR) OUTPUT=$(LIBBPF_OUTPUT)/ \
> > +               DESTDIR=$(LIBBPF_DESTDIR) prefix= install_headers
> > +endif
>
> Shouldn't we just be able to conditionalize having $(LIBBPF) as a
> dependency for the perf binary? If there is no dependency then the
> targets won't be built and we shouldn't need to conditionalize here.
>

I did try doing just that, but the build process does two things when
building libbpf
a) builds the library
b) installs the bpf headers in the libbpf output location.

Now what the original patch  - "perf build: Use tools/lib headers from
install path"  - does is to also change the include paths to the
compiler to pick up the headers,
removing the line:

INC_FLAGS += -I$(srctree)/tools/lib/

from tools/perf/Makefile.config and adding the line

CFLAGS += -I$(LIBBPF_OUTPUT)/include

in tools/perf/Makefile.perf (along with similar lines for libperf, libapi etc)

The result of this is that if you only remove the library build, the
headers are not installed and other compilation units fail as the
headers are still included even if the library is not in use.
These were originally satisfied by the now removed INC_FLAGS +=
-I$(srctree)/tools/lib.

Thus when NO_LIBBPF=1 even though we do not build the library - we
still need to install the headers to retain the consistency - hence a
"header only" target, that only installs the headers without building
the library.

This avoids restoring the original -I$(srctree)/tools/lib/, which
would potentially mess up the oher library builds that have changed
their header include paths.

Regards

Mike


> Thanks!
> Ian
>
> >  $(LIBBPF)-clean:
> >         $(call QUIET_CLEAN, libbpf)
> > --
> > 2.17.1
> >



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
