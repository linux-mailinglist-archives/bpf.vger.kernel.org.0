Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA7C65FE77
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 10:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjAFJ6k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 04:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjAFJ6c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 04:58:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EEF17E39
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 01:58:28 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso1204317pjf.1
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 01:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CrjUnzx6Y0AzNC4bTmiJNh2GA82mK4lsLIP1FqHbkU=;
        b=Pk1/5aKBsJT3eZHlz15O4D34VNL6zvi3OXcDFug+6Jrvoxw7A+4PBcW4+Obj7WwGjv
         cJl2N9alD1MxZrPaBC07/GFkVKlcOFmz6pcQ4mPndrvGfW7A9zAiHy5NYt2B8pZ5HGWY
         XODS1gb9Q5eLn/ydD52Suvy5PuKVenhcbziPV+lqfcXa75xC0x27SEH23bh+CYTqlKlC
         oA6uQZSbtI9Twzbm+b1iUXd+R+NgZa8AxPoBptXJGacAhEffwwjunaUvgEY2knGKOIpu
         x/bgBy38gENtmclOtoyjvms2R2bwzlwoyXmvhOonE5U7oofl23F8rCASUu9Lj5aInu9T
         DzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CrjUnzx6Y0AzNC4bTmiJNh2GA82mK4lsLIP1FqHbkU=;
        b=jwZEy4FlAJYhlY8zlrH/XKXaSGJJTO5h5GxsY+WqjZx7xxBqt6/QnX0ZOs1mtSoQMg
         VfBqRoKwu6KxrYExCIxHR2nmeCZWm2QKaeFwAonbVUxzaEs+lbSCSHry5P25U5brZZ1x
         eF0/ThKjD6Y7pKeCQJl4ANvbtOogAfrMgo0sSCZuGz8aXdbFy+Bv6RucF4Lka1c0QHJK
         ZOB2Ls7R1+4udnStsclAW5wg5iGF2NCcpE20oINYpo8ZxPVuokRczDKtdaRLhSUCcVSg
         2qxtimYsk/qD0X1YLUJ+g66Z8ReFl6stbsfs1JdIBIQ9mpVypPVCh+R5hMlNnvM6KxYr
         cwgA==
X-Gm-Message-State: AFqh2krPBghKP/IryaXV7GmqINK5Gur8U++U1Se8Cn78k7KxuNoepI4u
        4Ga+0HUGbFNvXb9X8OvUHlyIoIABSTenarqPIIUoCQ==
X-Google-Smtp-Source: AMrXdXt0NM4Sg9RjyPjiTwK8ETP4ogyEw1QoPM3sKp27jjbda4129oRr5vXkXCWIEvSGlyU0j3722ScHNflvJBBxTPg=
X-Received: by 2002:a17:902:6b05:b0:18c:5dae:6f2 with SMTP id
 o5-20020a1709026b0500b0018c5dae06f2mr3140065plk.24.1672999108061; Fri, 06 Jan
 2023 01:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20230105172243.7238-1-mike.leach@linaro.org> <CAP-5=fVbPVE4rxJ2s8phhJ5RRH4EnKaWrF2kaT0oCmK6kvhP2g@mail.gmail.com>
 <CAJ9a7Vi7cB2t3wao9d78j3G9v4zpO8_hHf8DB4vKOzgT9O+j6g@mail.gmail.com> <CAP-5=fV5tiKNyJRUKC0gD_2Y=RgN=NrAtee4k1ZT1tynyJpL6w@mail.gmail.com>
In-Reply-To: <CAP-5=fV5tiKNyJRUKC0gD_2Y=RgN=NrAtee4k1ZT1tynyJpL6w@mail.gmail.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 6 Jan 2023 09:58:17 +0000
Message-ID: <CAJ9a7ViY=XOnp2ZJgEdR4qqXth=N4MRLHZWifJw-3-qT-md12g@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix build error when NO_LIBBPF=1
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ian,

On Fri, 6 Jan 2023 at 06:24, Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Jan 5, 2023 at 3:40 PM Mike Leach <mike.leach@linaro.org> wrote:
> >
> > Hi,
> >
> > On Thu, 5 Jan 2023 at 19:03, Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Thu, Jan 5, 2023 at 9:22 AM Mike Leach <mike.leach@linaro.org> wro=
te:
> > > >
> > > > Recent updates to perf build result in the following output when cr=
oss
> > > > compiling to aarch64, with libelf unavailable, and therefore
> > > > NO_LIBBPF=3D1 set.
> > > >
> > > > ```
> > > >   $make -C tools/perf
> > > >
> > > >   <cut>
> > > >
> > > >   Makefile.config:428: No libelf found. Disables 'probe' tool, jvmt=
i
> > > >   and BPF support in 'perf record'. Please install libelf-dev,
> > > >   libelf-devel or elfutils-libelf-devel
> > > >
> > > >   <cut>
> > > >
> > > >   libbpf.c:46:10: fatal error: libelf.h: No such file or directory
> > > >       46 | #include <libelf.h>
> > > >          |          ^~~~~~~~~~
> > > >   compilation terminated.
> > > >
> > > >   ./tools/build/Makefile.build:96: recipe for target
> > > >   '.tools/perf/libbpf/staticobjs/libbpf.o' failed
> > > >
> > > > ```
> > > >
> > > > plus one other include error for <gelf.h>
> > >
> > > Ouch, apologies for the breakage. You wouldn't happen to have
> > > something like a way with say a docker image to repro the problem? Th=
e
> > > make line above is somewhat minimal.
> > >
> >
> > Unfortunately not - I was cross compiling on my main workstation.
> > However, in theory
> > $make -C tools/perf NO_LIBBPF=3D1
> > should explicitly exclude the library from the build - which without
> > the fix it does not.
> >
> > > > The issue is that the commit noted below adds libbpf to the prepare=
:
> > > > target but no longer accounts for the NO_LIBBPF define. Additionall=
y
> > > > changing the include directories means that even if the libbpf targ=
et
> > > > build is prevented, bpf headers are missing in other parts of the b=
uild.
> > > >
> > > > This patch ensures that in the case of NO_LIBBPF=3D1, the build tar=
get is
> > > > changed to a header only target, and the headers are installed, wit=
hout
> > > > attempting to build the libbpf.a target.
> > > >
> > > > Applies to perf/core
> > > >
> > > > Fixes: 746bd29e348f ("perf build: Use tools/lib headers from instal=
l path")
> > > > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > > > ---
> > > >  tools/perf/Makefile.perf | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > index 13e7d26e77f0..ee08ecf469f6 100644
> > > > --- a/tools/perf/Makefile.perf
> > > > +++ b/tools/perf/Makefile.perf
> > > > @@ -305,7 +305,11 @@ else
> > > >  endif
> > > >  LIBBPF_DESTDIR =3D $(LIBBPF_OUTPUT)
> > > >  LIBBPF_INCLUDE =3D $(LIBBPF_DESTDIR)/include
> > > > +ifndef NO_LIBBPF
> > > >  LIBBPF =3D $(LIBBPF_OUTPUT)/libbpf.a
> > > > +else
> > > > +LIBBPF =3D $(LIBBPF_INCLUDE)/bpf/bpf.h
> > >
> > > This seems strange, don't we want to avoid libbpf targets?
> > >
> >
> > This is a header only target - see my continuation comment below....
> >
> > > > +endif
> > > >  CFLAGS +=3D -I$(LIBBPF_OUTPUT)/include
> > > >
> > > >  ifneq ($(OUTPUT),)
> > > > @@ -826,10 +830,16 @@ $(LIBAPI)-clean:
> > > >         $(call QUIET_CLEAN, libapi)
> > > >         $(Q)$(RM) -r -- $(LIBAPI_OUTPUT)
> > > >
> > > > +ifndef NO_LIBBPF
> > > >  $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
> > > >         $(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=3D$(FEATURE_DUMP=
_EXPORT) \
> > > >                 O=3D OUTPUT=3D$(LIBBPF_OUTPUT)/ DESTDIR=3D$(LIBBPF_=
DESTDIR) prefix=3D \
> > > >                 $@ install_headers
> > > > +else
> > > > +$(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
> > > > +       $(Q)$(MAKE) -C $(LIBBPF_DIR) OUTPUT=3D$(LIBBPF_OUTPUT)/ \
> > > > +               DESTDIR=3D$(LIBBPF_DESTDIR) prefix=3D install_heade=
rs
> > > > +endif
> > >
> > > Shouldn't we just be able to conditionalize having $(LIBBPF) as a
> > > dependency for the perf binary? If there is no dependency then the
> > > targets won't be built and we shouldn't need to conditionalize here.
> > >
> >
> > I did try doing just that, but the build process does two things when
> > building libbpf
> > a) builds the library
> > b) installs the bpf headers in the libbpf output location.
> >
> > Now what the original patch  - "perf build: Use tools/lib headers from
> > install path"  - does is to also change the include paths to the
> > compiler to pick up the headers,
> > removing the line:
> >
> > INC_FLAGS +=3D -I$(srctree)/tools/lib/
> >
> > from tools/perf/Makefile.config and adding the line
> >
> > CFLAGS +=3D -I$(LIBBPF_OUTPUT)/include
> >
> > in tools/perf/Makefile.perf (along with similar lines for libperf, liba=
pi etc)
> >
> > The result of this is that if you only remove the library build, the
> > headers are not installed and other compilation units fail as the
> > headers are still included even if the library is not in use.
> > These were originally satisfied by the now removed INC_FLAGS +=3D
> > -I$(srctree)/tools/lib.
> >
> > Thus when NO_LIBBPF=3D1 even though we do not build the library - we
> > still need to install the headers to retain the consistency - hence a
> > "header only" target, that only installs the headers without building
> > the library.
> >
> > This avoids restoring the original -I$(srctree)/tools/lib/, which
> > would potentially mess up the oher library builds that have changed
> > their header include paths.
> >
> > Regards
> >
> > Mike
>
>
> Thanks Mike,
>
> The -I is needed for the libbpf headers but if NO_LIBBPF is enabled
> then the C define HAVE_LIBBPF_SUPPORT isn't and we shouldn't include
> any of these headers. This means updating the CFLAGS for libbpf should
> only be done if we actually build the static  libbpf.a, the dynamic
> version's headers should already be on the include path. I sent out a
> variant of this fix doing that here:
> https://lore.kernel.org/lkml/20230106061631.571659-1-irogers@google.com/
>
> Apologies again for the breakage, I can buy you a beer the next time
> I'm home in Manchester.
> Ian
>

Applying your new patch to perf/core and building I get:-

  CC      builtin-stat.o
In file included from builtin-stat.c:71:
util/bpf_counter.h:7:10: fatal error: bpf/bpf.h: No such file or directory
    7 | #include <bpf/bpf.h>
      |          ^~~~~~~~~~~
compilation terminated.
/datadisk/mike/work/kernel-ups/tools/build/Makefile.build:96: recipe
for target 'builtin-stat.o' failed
make[3]: *** [builtin-stat.o] Error 1
make[3]: *** Waiting for unfinished jobs....
  LD      pmu-events/pmu-events-in.o
Makefile.perf:673: recipe for target 'perf-in.o' failed
make[2]: *** [perf-in.o] Error 2
Makefile.perf:235: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make: *** [all] Error 2

which is a result of the bpf headers not being installed in their new
location and the removal of the -I from the old location as mentioned
in my last.
So perhaps the issue is less about the build operations and more about
the lack of #ifdef HAVE_LIBBPF_SUPPORT in certain other source files.

However, if I put the #ifdef HAVE_LIBBPF_SUPPORT around the #include
of util/bpf_counter.h, then compilation fails with multiple

builtin-stat.c: In function =E2=80=98read_bpf_map_counters=E2=80=99:
builtin-stat.c:463:9: error: implicit declaration of function
=E2=80=98bpf_counter__read=E2=80=99; did you mean =E2=80=98refcount_read=E2=
=80=99?
[-Werror=3Dimplicit-function-declaration]
  463 |   err =3D bpf_counter__read(counter);
      |         ^~~~~~~~~~~~~~~~~
      |         refcount_read

type errors.

Turns out that bpf_counter.h has inline stubs for these functions
bracketed by #ifdef HAVE_BPF_SKEL / #else / #endif, which I presume
are used in the non-bpf case.

I can get a clean build with your patch if I adjust the HAVE_BFP_SKEL
bracketing to encompass everything (including header includes, struct
defines and other functions) other than the stubs in the #ifdef case
and only the stubs in the #else case  - but I have no idea if this
will have an adverse effect on other tools which may use the same
header.

Thanks and Regards

Mike

> >
> > > Thanks!
> > > Ian
> > >
> > > >  $(LIBBPF)-clean:
> > > >         $(call QUIET_CLEAN, libbpf)
> > > > --
> > > > 2.17.1
> > > >
> >
> >
> >
> > --
> > Mike Leach
> > Principal Engineer, ARM Ltd.
> > Manchester Design Centre. UK



--=20
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
