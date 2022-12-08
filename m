Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65575647974
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 00:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLHXFs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 18:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLHXFq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 18:05:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E97C6427
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 15:05:44 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m19so2360215wms.5
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 15:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTv4506erGiBCj0j5Ixgx4QNx0N7fkuohkOysHpWz8k=;
        b=ERQODVH4V0vDCCOLP8h30zAIY/3xoWjuS0H5D+zGK1vZsHhm2BZQJXjUOQExJ7j8ei
         OK+0KxsFxOhd2OoHOAdFhkx9CHa9dkF3W+EEZ21HRLv88yb5lYC0KzjbQW4IFXMwbJls
         VV8WnXzsagT00pdvANQtR6cRWauPwOsz90hC9AYg7jLFuc76dDp12C8bYF12qwowwoWt
         9i7+z9JuB1QM+OmeCg4iYxSldzC03YZlOVm2XU9/txu9BKrGFBmdgBJs0DDE7QOYeqZH
         qj+yhYUtynUAc3Q+PwGkQXnbtiu1Du4gQuZ+SyIeMiDrWAnwbOevfCa3+mE8hS/c4AyT
         G5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTv4506erGiBCj0j5Ixgx4QNx0N7fkuohkOysHpWz8k=;
        b=0MUxJBg7ZAEasj7mA4KW8JcQby5TDq9B75G/9IJlDQGFmJOBeddL1EGECMioKVbcj8
         9lTNksPHSMjUZgKdHwZCoPm4lcLbyDOATUSkA3NMPne9GLTqfJu2E0KhEtzHcVO6ktF5
         ua2yvLlF1YpE16c85pcffj7d9nqTdqNw+xG1s3C82iKeHGkm1WAxYb81gCJYJOoNfMHd
         f4Wpis8zQccH1Puwe+YpfOTFllrm9U9VYMGxri4bnSzVSSWEskZx+r2ZDVLWcmSRxOWK
         GGDDYqZH7vJYAPizdc/4xMbUQGQf4GI6zsPYwAUpgbVfYaLb5d69kOrFedHThxhhII3t
         FeZg==
X-Gm-Message-State: ANoB5plkVS9ocffq/FlLY0LPvFWeOIIxh2HCY2jjrJwKAyzQRpAxChRd
        RlmtRSZaymUnD+rcQs7+ooSI1iOk/TX+Ue53sPtpCw==
X-Google-Smtp-Source: AA0mqf6H+jHm9cDVPP1Qkjt2X1ghS68xL6i7GYALqPlITTyMlIg+b2jkbkgBIpC7HIKPnsXKl9eKmj9lkoKs9iy7ZkA=
X-Received: by 2002:a05:600c:3d8f:b0:3cf:6a4c:af8b with SMTP id
 bi15-20020a05600c3d8f00b003cf6a4caf8bmr57219747wmb.115.1670540742806; Thu, 08
 Dec 2022 15:05:42 -0800 (PST)
MIME-Version: 1.0
References: <Y49vx0v6Z7EiR8jr@kernel.org> <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org> <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org> <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com> <Y5DNBZNC5rBBqlJW@kernel.org>
 <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com> <Y5JfgyN59dSeKbUP@kernel.org>
 <Y5Jl8MeW90DXy1wT@kernel.org> <CAP-5=fWyb+w2EP4cGBJU3RD6E_OkBZ+3w5+YyhwX7fOA-H0aWQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWyb+w2EP4cGBJU3RD6E_OkBZ+3w5+YyhwX7fOA-H0aWQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 8 Dec 2022 15:05:29 -0800
Message-ID: <CAP-5=fXJpxq-A7VJkZv+Y0fiCuNj9bhTXJx9+FGBQtePJ92z_A@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
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

On Thu, Dec 8, 2022 at 3:00 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Dec 8, 2022 at 2:32 PM Arnaldo Carvalho de Melo <acme@kernel.org>=
 wrote:
> >
> > Em Thu, Dec 08, 2022 at 07:04:52PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Thu, Dec 08, 2022 at 12:21:20PM +0530, Athira Rajeev escreveu:
> > > > > On 07-Dec-2022, at 10:57 PM, Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
> > > > > Can you try again? tmp.perf/core? That "tmp." part means its a fo=
rce
> > > > > pushed branch, so I just force pushed with some arch specific fix=
es, now
> > > > > I'm down to (removing the successful builds and unrelated failure=
s, now
> > > > > related to libbpf's F_DUPFD_CLOEXEC kaboom):
> > >
> > > > Ok Arnaldo, Sure, I will check with updated branch
> > >
> > > > >   5     7.38 fedora:34                     : FAIL gcc version 11.=
3.1 20220421 (Red Hat 11.3.1-2) (GCC)
> > > > >    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function =E2=
=80=98evsel__rawptr=E2=80=99:
> > > > >    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: =
=E2=80=98TEP_FIELD_IS_RELATIVE=E2=80=99 undeclared (first use in this funct=
ion); did you mean =E2=80=98TEP_FIELD_IS_FLAG=E2=80=99?
> > > > >     2787 |                 if (field->flags & TEP_FIELD_IS_RELATI=
VE)
> > > > >          |                                    ^~~~~~~~~~~~~~~~~~~=
~~
> > > > >          |                                    TEP_FIELD_IS_FLAG
> > >
> > > > I observed same issue as updated here:
> > > > https://lore.kernel.org/lkml/10476A85-3F75-4C91-AB5B-E5B136F31297@l=
inux.vnet.ibm.com/
> > >
> > > > Looks like TEP_FIELD_IS_RELATIVE is not defined in header file of t=
he system installed version.
> > > > whereas it is there in header file in tools/lib/traceevent
> > >
> > > > # grep TEP_FIELD_IS_RELATIVE /usr/include/traceevent/event-parse.h
> > > > # grep TEP_FIELD_IS_RELATIVE ../lib/traceevent/event-parse.h
> > > >     TEP_FIELD_IS_RELATIVE   =3D 256,
> > >
> > > Right, I had noticed that as well, so as a prep patch I'm adding the
> > > patch below, before Ian's. Please check and provide an
> > > Acked-by/Tested-by/Reviewed-by if possible.
> >
> > I ended up with the one below, _after_ Ian's patch as I had some troubl=
e grafting
> > it before and had already tested it this way multiple times, I'm pushin=
g
> > this to tmp/perf.core.
> >
> > - Arnaldo
> >
> > commit a0ec3ef4590e7e82339b6f318e671a6b69fd94e8
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Thu Dec 8 19:28:58 2022 -0300
> >
> >     perf tools: Add test to check if libtracevent has TEP_FIELD_IS_RELA=
TIVE
> >
>
> Could HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE be a version rather
> than feature check, something like:
>
> #define MAKE_LIBTRACEEVENT_VERSION(maj, mid, min) (maj * 255 *255 +
> mid * 255 + min)
> #define HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> (LIBTRACEEVENT_VERSION >=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>
> Note, we have LIBTRACEEVENT_VERSION computed in Makefile.config by way
> of pkg-config.
>
> Thanks,
> Ian

LIBTRACEEVENT_VERSION had a workaround if pkg-config wasn't present to
default to 1.1.0 for its use in:
https://lore.kernel.org/linux-perf-users/20210923001024.550263-4-irogers@go=
ogle.com/
We should un-revert that change now the -Itools/lib issue is resolved
(1.1 traceevent headers compiled against newer system libtraceevent
library).

Thanks,
Ian

> >     Some distros have older versions of libtraceevent where
> >     TEP_FIELD_IS_RELATIVE and its associated semantics are not present,=
 so
> >     we need to test for its presence and cope when it isn't present whe=
n
> >     building with LIBTRACEEVENT_DYNAMIC=3D1.
> >
> >     Reported-by: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
> >     Cc: Adrian Hunter <adrian.hunter@intel.com>
> >     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >     Cc: Ian Rogers <irogers@google.com>
> >     Cc: Ingo Molnar <mingo@redhat.com>
> >     Cc: Jiri Olsa <jolsa@kernel.org>
> >     Cc: Mark Rutland <mark.rutland@arm.com>
> >     Cc: Namhyung Kim <namhyung@kernel.org>
> >     Cc: Nick Desaulniers <ndesaulniers@google.com>
> >     Cc: Peter Zijlstra <peterz@infradead.org>,
> >     Cc: Stephane Eranian <eranian@google.com>
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.featur=
e
> > index 38f8851bd7cbdb0e..c6c9b7c7723d4290 100644
> > --- a/tools/build/Makefile.feature
> > +++ b/tools/build/Makefile.feature
> > @@ -71,7 +71,8 @@ FEATURE_TESTS_BASIC :=3D                  \
> >          libzstd                                \
> >          disassembler-four-args         \
> >          disassembler-init-styled       \
> > -        file-handle
> > +        file-handle                    \
> > +        libtraceevent-tep_field_is_relative
> >
> >  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
> >  # of all feature tests
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > index 690fe97be1904399..24246df35ac30eeb 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -81,7 +81,8 @@ FILES=3D                                          \
> >           test-libzstd.bin                      \
> >           test-clang-bpf-co-re.bin              \
> >           test-file-handle.bin                  \
> > -         test-libpfm4.bin
> > +         test-libpfm4.bin                      \
> > +         test-libtraceevent-tep_field_is_relative
> >
> >  FILES :=3D $(addprefix $(OUTPUT),$(FILES))
> >
> > @@ -159,6 +160,9 @@ $(OUTPUT)test-dwarf_getlocations.bin:
> >  $(OUTPUT)test-libelf-getphdrnum.bin:
> >         $(BUILD) -lelf
> >
> > +$(OUTPUT)test-libtraceevent-tep_field_is_relative.bin:
> > +       $(BUILD) -ltraceevent
> > +
> >  $(OUTPUT)test-libelf-gelf_getnote.bin:
> >         $(BUILD) -lelf
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 680228e19c1aabdb..e29975664f06bd61 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -1197,6 +1197,10 @@ ifneq ($(NO_LIBTRACEEVENT),1)
> >      LIBTRACEEVENT_VERSION_CPP :=3D $(shell expr $(LIBTRACEEVENT_VERSIO=
N_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VE=
RSION_3))
> >      CFLAGS +=3D -DLIBTRACEEVENT_VERSION=3D$(LIBTRACEEVENT_VERSION_CPP)
> >      $(call detected,CONFIG_LIBTRACEEVENT)
> > +    $(call feature_check,libtraceevent-tep_field_is_relative)
> > +    ifeq ($(feature-libtraceevent-tep_field_is_relative), 1)
> > +      CFLAGS +=3D -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> > +    endif
> >    else
> >      dummy :=3D $(warning Warning: libtraceevent is missing limiting fu=
nctionality, please install libtraceevent-dev/libtraceevent-devel)
> >    endif
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 6909cd9f48d11644..c9802ab549d7782f 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2729,8 +2729,10 @@ static size_t trace__fprintf_tp_fields(struct tr=
ace *trace, struct evsel *evsel,
> >                                 offset =3D format_field__intval(field, =
sample, evsel->needs_swap);
> >                                 syscall_arg.len =3D offset >> 16;
> >                                 offset &=3D 0xffff;
> > +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> >                                 if (field->flags & TEP_FIELD_IS_RELATIV=
E)
> >                                         offset +=3D field->offset + fie=
ld->size;
> > +#endif
> >                         }
> >
> >                         val =3D (uintptr_t)(sample->raw_data + offset);
> > diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-c=
onvert-bt.c
> > index 8031b586e81384e7..b842273458b862bd 100644
> > --- a/tools/perf/util/data-convert-bt.c
> > +++ b/tools/perf/util/data-convert-bt.c
> > @@ -322,8 +322,10 @@ static int add_tracepoint_field_value(struct ctf_w=
riter *cw,
> >                 offset =3D tmp_val;
> >                 len =3D offset >> 16;
> >                 offset &=3D 0xffff;
> > +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> >                 if (flags & TEP_FIELD_IS_RELATIVE)
> >                         offset +=3D fmtf->offset + fmtf->size;
> > +#endif
> >         }
> >
> >         if (flags & TEP_FIELD_IS_ARRAY) {
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index ca911856c4b1d3c8..77b2cf5a214ec1e4 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2784,8 +2784,10 @@ void *evsel__rawptr(struct evsel *evsel, struct =
perf_sample *sample, const char
> >         if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> >                 offset =3D *(int *)(sample->raw_data + field->offset);
> >                 offset &=3D 0xffff;
> > +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> >                 if (field->flags & TEP_FIELD_IS_RELATIVE)
> >                         offset +=3D field->offset + field->size;
> > +#endif
> >         }
> >
> >         return sample->raw_data + offset;
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index 6fb84b7455b8392d..7320f7f777fe0e56 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -442,8 +442,10 @@ tracepoint_field(struct pyrf_event *pe, struct tep=
_format_field *field)
> >                         offset  =3D val;
> >                         len     =3D offset >> 16;
> >                         offset &=3D 0xffff;
> > +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> >                         if (field->flags & TEP_FIELD_IS_RELATIVE)
> >                                 offset +=3D field->offset + field->size=
;
> > +#endif
> >                 }
> >                 if (field->flags & TEP_FIELD_IS_STRING &&
> >                     is_printable_array(data + offset, len)) {
> > diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/too=
ls/perf/util/scripting-engines/trace-event-perl.c
> > index 0bacb49408f84adf..c097b7934fd4ebe9 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> > @@ -393,8 +393,10 @@ static void perl_process_tracepoint(struct perf_sa=
mple *sample,
> >                         if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> >                                 offset =3D *(int *)(data + field->offse=
t);
> >                                 offset &=3D 0xffff;
> > +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> >                                 if (field->flags & TEP_FIELD_IS_RELATIV=
E)
> >                                         offset +=3D field->offset + fie=
ld->size;
> > +#endif
> >                         } else
> >                                 offset =3D field->offset;
> >                         XPUSHs(sv_2mortal(newSVpv((char *)data + offset=
, 0)));
> > diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/t=
ools/perf/util/scripting-engines/trace-event-python.c
> > index fabba21919b8fa51..e930f5f1f36d2831 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-python.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> > @@ -994,8 +994,10 @@ static void python_process_tracepoint(struct perf_=
sample *sample,
> >                                 offset  =3D val;
> >                                 len     =3D offset >> 16;
> >                                 offset &=3D 0xffff;
> > +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> >                                 if (field->flags & TEP_FIELD_IS_RELATIV=
E)
> >                                         offset +=3D field->offset + fie=
ld->size;
> > +#endif
> >                         }
> >                         if (field->flags & TEP_FIELD_IS_STRING &&
> >                             is_printable_array(data + offset, len)) {
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index c7a97b33e13477e1..0ecc2cb137920d2d 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -2568,9 +2568,10 @@ static int64_t __sort__hde_cmp(struct perf_hpp_f=
mt *fmt,
> >                 tep_read_number_field(field, a->raw_data, &dyn);
> >                 offset =3D dyn & 0xffff;
> >                 size =3D (dyn >> 16) & 0xffff;
> > +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> >                 if (field->flags & TEP_FIELD_IS_RELATIVE)
> >                         offset +=3D field->offset + field->size;
> > -
> > +#endif
> >                 /* record max width for output */
> >                 if (size > hde->dynamic_len)
> >                         hde->dynamic_len =3D size;
