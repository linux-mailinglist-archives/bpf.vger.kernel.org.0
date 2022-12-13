Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A317A64BF1F
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 23:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiLMWJ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 17:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiLMWJX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 17:09:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B507819C0A
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 14:09:21 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso9013695wme.5
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 14:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK0a74SExwo6tehnROoC1PuxTBylsxyy4c3HHV+FZZQ=;
        b=dCICheVvn42ItoiBZ18d0THWwQrq4cS0ikUWBSnXTdmj1me47v5qpwL9q8GRtAuQK6
         FONbctAog/MmGZ6lkLWVl9rOkA3AyhdJIPrJFVLVzwhjoBozxJcSaJw/3MU0xXi9WIwU
         mfoo4gIZmkFdBjORPDFNhKRJR4HErxlraipTQ2u6uEM1GkAQFJDyvtU+/KcFB2DvoNk+
         xxbna0D1B19jQ1oM9CGsVJQr+3LIkzp8ELh2cNm3N5yDhp8PCDJ5AK2S/taQIktanQzT
         lC/sdSWRU6KAkhrZRbwen9v/5NRuO3TKdrVzu34ZoUdlTB5AT37rRSadpNzLguqoALSK
         jUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK0a74SExwo6tehnROoC1PuxTBylsxyy4c3HHV+FZZQ=;
        b=E25dthP59LAPo5ZuZ60azPLdtKshatpnC2+aiLweJ5pZ4Sk044ehzr4CnBncshIaJF
         oQDsvLycLclW/ozjLHg1MJJHHZxw+Ypnyvi7C5irEGOa8CuxwGzv4k5iFLNtAlwyH4hs
         FK2y7W44z/LQi0vGx0UFQByovVidhYi53C9qbuPQiE8VkiSaChfhbF1Yv5yLugyLFVAy
         LVRtV8pkjJGwvGjaTqS8J57oGTCYFDkZ6xowmTlod9SpuZQ5/3S6trYUziW8p/hMFCmk
         5ltJyk9/6OUIwIQwc9fI/yXcb198lH5AZIEaHBx1AQjoRZD+XIEH17lPUR+CkF/meXlT
         kcDw==
X-Gm-Message-State: ANoB5pmBtlzG2n4iV9ao/ZuJh8jek+4Ol3jFzR7KNIX/CiX4YdFNZDd6
        lbOfxPCUfyycsw4M4V7i8eawFQEsKkTp9d7tZvTy/xhpDkkXoM/z
X-Google-Smtp-Source: AA0mqf5CZkQpS3/8A2dDqs0IvrnKonot9L9N0BgdovL45nAQFEl0ri0WSUV56B9zGddQ58Pate5qSfa/2m0tRqlRUpQ=
X-Received: by 2002:a1c:7308:0:b0:3d0:50c4:432c with SMTP id
 d8-20020a1c7308000000b003d050c4432cmr16984wmb.67.1670969360110; Tue, 13 Dec
 2022 14:09:20 -0800 (PST)
MIME-Version: 1.0
References: <Y491d1wEW4TfUi5f@kernel.org> <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org> <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com> <Y5DNBZNC5rBBqlJW@kernel.org>
 <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com> <Y5JfgyN59dSeKbUP@kernel.org>
 <Y5Jl8MeW90DXy1wT@kernel.org> <8F6F0C27-53F3-4837-A19C-845768253249@linux.vnet.ibm.com>
 <Y5cxyk3OdgFXlyhS@kernel.org> <BB236C92-3505-4DAB-AE28-A55F74EDE161@linux.vnet.ibm.com>
In-Reply-To: <BB236C92-3505-4DAB-AE28-A55F74EDE161@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Dec 2022 14:09:07 -0800
Message-ID: <CAP-5=fVVPDo_3cjKmumEVKDN2Zssz-ZU=nYVQFNr1xUGHxx-PQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Dec 13, 2022 at 1:53 AM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 12-Dec-2022, at 7:21 PM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
> >
> > Em Fri, Dec 09, 2022 at 12:04:18PM +0530, Athira Rajeev escreveu:
> >>
> >>
> >>> On 09-Dec-2022, at 4:02 AM, Arnaldo Carvalho de Melo <acme@kernel.org=
> wrote:
> >>>
> >>> Em Thu, Dec 08, 2022 at 07:04:52PM -0300, Arnaldo Carvalho de Melo es=
creveu:
> >>>> Em Thu, Dec 08, 2022 at 12:21:20PM +0530, Athira Rajeev escreveu:
> >>>>>> On 07-Dec-2022, at 10:57 PM, Arnaldo Carvalho de Melo <acme@kernel=
.org> wrote:
> >>>>>> Can you try again? tmp.perf/core? That "tmp." part means its a for=
ce
> >>>>>> pushed branch, so I just force pushed with some arch specific fixe=
s, now
> >>>>>> I'm down to (removing the successful builds and unrelated failures=
, now
> >>>>>> related to libbpf's F_DUPFD_CLOEXEC kaboom):
> >>>>
> >>>>> Ok Arnaldo, Sure, I will check with updated branch
> >>>>
> >>>>>> 5     7.38 fedora:34                     : FAIL gcc version 11.3.1=
 20220421 (Red Hat 11.3.1-2) (GCC)
> >>>>>>  /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function =E2=80=
=98evsel__rawptr=E2=80=99:
> >>>>>>  /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: =E2=
=80=98TEP_FIELD_IS_RELATIVE=E2=80=99 undeclared (first use in this function=
); did you mean =E2=80=98TEP_FIELD_IS_FLAG=E2=80=99?
> >>>>>>   2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
> >>>>>>        |                                    ^~~~~~~~~~~~~~~~~~~~~
> >>>>>>        |                                    TEP_FIELD_IS_FLAG
> >>>>
> >>>>> I observed same issue as updated here:
> >>>>> https://lore.kernel.org/lkml/10476A85-3F75-4C91-AB5B-E5B136F31297@l=
inux.vnet.ibm.com/
> >>>>
> >>>>> Looks like TEP_FIELD_IS_RELATIVE is not defined in header file of t=
he system installed version.
> >>>>> whereas it is there in header file in tools/lib/traceevent
> >>>>
> >>>>> # grep TEP_FIELD_IS_RELATIVE /usr/include/traceevent/event-parse.h
> >>>>> # grep TEP_FIELD_IS_RELATIVE ../lib/traceevent/event-parse.h
> >>>>>   TEP_FIELD_IS_RELATIVE   =3D 256,
> >>>>
> >>>> Right, I had noticed that as well, so as a prep patch I'm adding the
> >>>> patch below, before Ian's. Please check and provide an
> >>>> Acked-by/Tested-by/Reviewed-by if possible.
> >>>
> >>> I ended up with the one below, _after_ Ian's patch as I had some trou=
ble grafting
> >>> it before and had already tested it this way multiple times, I'm push=
ing
> >>> this to tmp/perf.core.
> >>>
> >>> - Arnaldo
> >>
> >>
> >> Hi Arnaldo, Ian
> >>
> >> Thanks for the fixes.
> >>
> >> Since we changed =E2=80=9CCONFIG_TRACEEVENT=E2=80=9D to =E2=80=9CCONFI=
G_LIBTRACEEVENT=E2=80=9D,
> >> below change is also needed in =E2=80=9Carch/powerpc/util/Build=E2=80=
=9D
> >>
> >> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powe=
rpc/util/Build
> >> index 71e57f28abda..9889245c555c 100644
> >> --- a/tools/perf/arch/powerpc/util/Build
> >> +++ b/tools/perf/arch/powerpc/util/Build
> >> @@ -1,5 +1,5 @@
> >> perf-y +=3D header.o
> >> -perf-$(CONFIG_TRACEEVENT) +=3D kvm-stat.o
> >> +perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> >> perf-y +=3D perf_regs.o
> >> perf-y +=3D mem-events.o
> >> perf-y +=3D sym-handling.o
> >>
> >> With this change, I could successfully compile in these environment:
> >> - Without libtraceevent-devel installed
> >> - With libtraceevent-devel installed
> >> - With =E2=80=9Cmake NO_LIBTRACEEVENT=3D1=E2=80=9D
> >>
> >> With above change,
> >> Acked-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >
> > I did that and the same thing for other architectures, thanks for
> > testing!
> >
> > I'll now give a try at implementing it without
> > tools/build/feature/test-libtraceevent-tep_field_is_relative.c, using
> > just the version of libtraceevent, as Ian suggested.
> >
> > It would be great if you could test it again then,
> >
>
> Sure Arnaldo, I will test with updated code.
>
> Thanks
> Athira


Thanks Athira and Arnaldo. It is a little strange to me to be using
the shell to do a version number test. The intent was to be doing
these in the code:
#if LIBRTRACEEVENT_VERSION >=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
vs
...
LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE :=3D $(shell expr 1 \*
255 \* 255 + 5 \* 255 + 0) # 1.5.0
ifeq ($(shell test $(LIBTRACEEVENT_VERSION_CPP) -gt
$(LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE); echo $$?),0)
CFLAGS +=3D -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
endif
...
#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
I'm a little selfish as I'm maintaining a bazel build and a single
version number to maintain is easier than lots of HAVE_... tests. I'm
happy to follow Arnaldo's lead. I think the test should also be
greater-equal rather than greater-than:
https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/tree/include=
/traceevent/event-parse.h?h=3Dlibtraceevent-v1.5#n128

Thanks,
Ian


Ian

> > Thanks,
> >
> > - Arnaldo
> >
> >
> > diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/u=
til/Build
> > index 88553c578ed7a1c4..78ef7115be3d91a7 100644
> > --- a/tools/perf/arch/arm64/util/Build
> > +++ b/tools/perf/arch/arm64/util/Build
> > @@ -3,7 +3,7 @@ perf-y +=3D machine.o
> > perf-y +=3D perf_regs.o
> > perf-y +=3D tsc.o
> > perf-y +=3D pmu.o
> > -perf-$(CONFIG_TRACEEVENT) +=3D kvm-stat.o
> > +perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> > perf-$(CONFIG_DWARF)     +=3D dwarf-regs.o
> > perf-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> > perf-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/power=
pc/util/Build
> > index 71e57f28abdac7e9..9889245c555c4cfb 100644
> > --- a/tools/perf/arch/powerpc/util/Build
> > +++ b/tools/perf/arch/powerpc/util/Build
> > @@ -1,5 +1,5 @@
> > perf-y +=3D header.o
> > -perf-$(CONFIG_TRACEEVENT) +=3D kvm-stat.o
> > +perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> > perf-y +=3D perf_regs.o
> > perf-y +=3D mem-events.o
> > perf-y +=3D sym-handling.o
> > diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/uti=
l/Build
> > index aa8a5f05c9cb4706..db68840869979f2c 100644
> > --- a/tools/perf/arch/s390/util/Build
> > +++ b/tools/perf/arch/s390/util/Build
> > @@ -1,5 +1,5 @@
> > perf-y +=3D header.o
> > -perf-$(CONFIG_TRACEEVENT) +=3D kvm-stat.o
> > +perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> > perf-y +=3D perf_regs.o
> >
> > perf-$(CONFIG_DWARF) +=3D dwarf-regs.o
>
