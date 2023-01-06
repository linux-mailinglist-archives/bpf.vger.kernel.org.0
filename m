Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA0565FB68
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 07:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjAFGYu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 01:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjAFGYf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 01:24:35 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4026CFE9
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 22:24:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so2908235wma.1
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 22:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DV1t0rzqIB6z+X/yrkwUe3maiIiJ2Fcpdq7MxWlVXGk=;
        b=gQmQGmhfaKEWO6GLxj+xZcZl0OEJwClA+m7G0rYT/qnum8Gestw+8StAQKNHtNQov+
         czRWH3Oz1pf3C7KUYcqd0yxO1Xi82BF1CN0qdAVba2gK9JuumugjU3kjL1dxrVrg0mQI
         bwVmdG17+ESfUMrq16/2pWqOxzPauw2s2C2AfEqaghVXIqdvyQQ3eZ1uihm9Ayth6KbM
         6szgn/uYpXUzJKUjt93P0SCQNeqO5VGgaaMVdJtmSWKtuaVKFADjmNCH4nVerGq9+1zb
         CBAKp8uva+jOjjuk5IHEhrSSVJXahSfU+Oli7jpFddxZG6a34v23xbLv3JpH76BsU+wY
         yIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DV1t0rzqIB6z+X/yrkwUe3maiIiJ2Fcpdq7MxWlVXGk=;
        b=1Zp4Yv56HG77A8/Z5adYbPkmNyXutCD9KHc+yaxyTGkwgjh4wDtzM9TGMx82BjB87t
         6t18IJW+FKjuh2mmgkY/KqjAb7/xhZ9YqLgkfTkuWnpb1BCfhgzzrN2Bo9xwTUJNbjWs
         5Z28qM479aLV3V6gsK0EeOAd6lem8KWkGJaHHdoCt/lhPijt1lwNPrPIiVkIOsRtlnLB
         BVZv9kR/UzTmrDuqUjzhv1k/IZXuNnemkc/LtSPLfmcXrIygQsqSD5zHC4gXoqaup4Ea
         /+KnHwd0nmKv5EaRGUc5VIhUtCBAMivAN/pJ6L/LXpi3m28elryXtp6cFuRbAWvWwky+
         idTg==
X-Gm-Message-State: AFqh2kqH0p+56ZRKWBmkXSSR2G2i3bvKNlM9RcHV00WQQlBxAT7gMUfd
        7VthP0ldGW/PtNdzEyimzMef3ObVATnrGXwjn08ezQ==
X-Google-Smtp-Source: AMrXdXvyfLhh52MCe7324YaZzZlNKssK5gq1cKgT7/lg+HimYUwMTBr476xcjRM7156hhU1/e5t7qVZ6t1CbMCiuECc=
X-Received: by 2002:a05:600c:5d5:b0:3cf:6a4c:af8b with SMTP id
 p21-20020a05600c05d500b003cf6a4caf8bmr3969518wmd.115.1672986271093; Thu, 05
 Jan 2023 22:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20230105172243.7238-1-mike.leach@linaro.org> <CAP-5=fVbPVE4rxJ2s8phhJ5RRH4EnKaWrF2kaT0oCmK6kvhP2g@mail.gmail.com>
 <CAJ9a7Vi7cB2t3wao9d78j3G9v4zpO8_hHf8DB4vKOzgT9O+j6g@mail.gmail.com>
In-Reply-To: <CAJ9a7Vi7cB2t3wao9d78j3G9v4zpO8_hHf8DB4vKOzgT9O+j6g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 Jan 2023 22:24:18 -0800
Message-ID: <CAP-5=fV5tiKNyJRUKC0gD_2Y=RgN=NrAtee4k1ZT1tynyJpL6w@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix build error when NO_LIBBPF=1
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
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

On Thu, Jan 5, 2023 at 3:40 PM Mike Leach <mike.leach@linaro.org> wrote:
>
> Hi,
>
> On Thu, 5 Jan 2023 at 19:03, Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Jan 5, 2023 at 9:22 AM Mike Leach <mike.leach@linaro.org> wrote:
> > >
> > > Recent updates to perf build result in the following output when cross
> > > compiling to aarch64, with libelf unavailable, and therefore
> > > NO_LIBBPF=1 set.
> > >
> > > ```
> > >   $make -C tools/perf
> > >
> > >   <cut>
> > >
> > >   Makefile.config:428: No libelf found. Disables 'probe' tool, jvmti
> > >   and BPF support in 'perf record'. Please install libelf-dev,
> > >   libelf-devel or elfutils-libelf-devel
> > >
> > >   <cut>
> > >
> > >   libbpf.c:46:10: fatal error: libelf.h: No such file or directory
> > >       46 | #include <libelf.h>
> > >          |          ^~~~~~~~~~
> > >   compilation terminated.
> > >
> > >   ./tools/build/Makefile.build:96: recipe for target
> > >   '.tools/perf/libbpf/staticobjs/libbpf.o' failed
> > >
> > > ```
> > >
> > > plus one other include error for <gelf.h>
> >
> > Ouch, apologies for the breakage. You wouldn't happen to have
> > something like a way with say a docker image to repro the problem? The
> > make line above is somewhat minimal.
> >
>
> Unfortunately not - I was cross compiling on my main workstation.
> However, in theory
> $make -C tools/perf NO_LIBBPF=1
> should explicitly exclude the library from the build - which without
> the fix it does not.
>
> > > The issue is that the commit noted below adds libbpf to the prepare:
> > > target but no longer accounts for the NO_LIBBPF define. Additionally
> > > changing the include directories means that even if the libbpf target
> > > build is prevented, bpf headers are missing in other parts of the build.
> > >
> > > This patch ensures that in the case of NO_LIBBPF=1, the build target is
> > > changed to a header only target, and the headers are installed, without
> > > attempting to build the libbpf.a target.
> > >
> > > Applies to perf/core
> > >
> > > Fixes: 746bd29e348f ("perf build: Use tools/lib headers from install path")
> > > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > > ---
> > >  tools/perf/Makefile.perf | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 13e7d26e77f0..ee08ecf469f6 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -305,7 +305,11 @@ else
> > >  endif
> > >  LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
> > >  LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
> > > +ifndef NO_LIBBPF
> > >  LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
> > > +else
> > > +LIBBPF = $(LIBBPF_INCLUDE)/bpf/bpf.h
> >
> > This seems strange, don't we want to avoid libbpf targets?
> >
>
> This is a header only target - see my continuation comment below....
>
> > > +endif
> > >  CFLAGS += -I$(LIBBPF_OUTPUT)/include
> > >
> > >  ifneq ($(OUTPUT),)
> > > @@ -826,10 +830,16 @@ $(LIBAPI)-clean:
> > >         $(call QUIET_CLEAN, libapi)
> > >         $(Q)$(RM) -r -- $(LIBAPI_OUTPUT)
> > >
> > > +ifndef NO_LIBBPF
> > >  $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
> > >         $(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
> > >                 O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
> > >                 $@ install_headers
> > > +else
> > > +$(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
> > > +       $(Q)$(MAKE) -C $(LIBBPF_DIR) OUTPUT=$(LIBBPF_OUTPUT)/ \
> > > +               DESTDIR=$(LIBBPF_DESTDIR) prefix= install_headers
> > > +endif
> >
> > Shouldn't we just be able to conditionalize having $(LIBBPF) as a
> > dependency for the perf binary? If there is no dependency then the
> > targets won't be built and we shouldn't need to conditionalize here.
> >
>
> I did try doing just that, but the build process does two things when
> building libbpf
> a) builds the library
> b) installs the bpf headers in the libbpf output location.
>
> Now what the original patch  - "perf build: Use tools/lib headers from
> install path"  - does is to also change the include paths to the
> compiler to pick up the headers,
> removing the line:
>
> INC_FLAGS += -I$(srctree)/tools/lib/
>
> from tools/perf/Makefile.config and adding the line
>
> CFLAGS += -I$(LIBBPF_OUTPUT)/include
>
> in tools/perf/Makefile.perf (along with similar lines for libperf, libapi etc)
>
> The result of this is that if you only remove the library build, the
> headers are not installed and other compilation units fail as the
> headers are still included even if the library is not in use.
> These were originally satisfied by the now removed INC_FLAGS +=
> -I$(srctree)/tools/lib.
>
> Thus when NO_LIBBPF=1 even though we do not build the library - we
> still need to install the headers to retain the consistency - hence a
> "header only" target, that only installs the headers without building
> the library.
>
> This avoids restoring the original -I$(srctree)/tools/lib/, which
> would potentially mess up the oher library builds that have changed
> their header include paths.
>
> Regards
>
> Mike


Thanks Mike,

The -I is needed for the libbpf headers but if NO_LIBBPF is enabled
then the C define HAVE_LIBBPF_SUPPORT isn't and we shouldn't include
any of these headers. This means updating the CFLAGS for libbpf should
only be done if we actually build the static  libbpf.a, the dynamic
version's headers should already be on the include path. I sent out a
variant of this fix doing that here:
https://lore.kernel.org/lkml/20230106061631.571659-1-irogers@google.com/

Apologies again for the breakage, I can buy you a beer the next time
I'm home in Manchester.
Ian

>
> > Thanks!
> > Ian
> >
> > >  $(LIBBPF)-clean:
> > >         $(call QUIET_CLEAN, libbpf)
> > > --
> > > 2.17.1
> > >
>
>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
