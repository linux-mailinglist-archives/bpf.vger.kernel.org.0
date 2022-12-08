Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DE764796A
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 00:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLHXBB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 18:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLHXAz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 18:00:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D48F73F
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 15:00:54 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m14so3453659wrh.7
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 15:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh4bsmmhDV2na+c1cDv3cDUUxd8uJbpto56UNxa7sxs=;
        b=h0zqJYv790Sm8oD9EZiXdsmgwuqIWnxyzinQSwmgcnt2z1UBuZ4wDsBE2FInDTf2ZF
         6Ni+I7BhNsYSaXDpJ4OICWVSmXM0ZQa7vEAvUn/Mu6Rw785VXoioOen7YF2JbZPElwtX
         7hVCh6pY7iYmZMYRdc2uMqvpHOcGb11iIBZ9gZSk6VL7vhuiSQYYVvFvJWpuPSsUEdbY
         XCsTzACU6jG3gvz/5S+Jj3Rjs+/DTIXLFgHEgiDKhDFxxp2VLxIZBD7FZY4XLUx9DAbp
         Uaxh6pFW+Ir4pXSIk0CMGs/1QaB21SqsyPhMpPBWFppMdfghIOJniuJ5oANsEHg30JpS
         m0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eh4bsmmhDV2na+c1cDv3cDUUxd8uJbpto56UNxa7sxs=;
        b=oL+tGX9x9PulyQkk6DQ2ATb6nJkAhi8rMMZMDxWOrQnVylviH9xRxxJbm1sc8ka/O0
         yE+eAmN72xBTYTm/LpGC98mj5+7pdQkHvIn2LD84BIfirKJm2/dMwnMNG7qjyl9LozhN
         qDvzITrFWIA+Oe5+vKCyVWfRhDYOaRZdtpqYzeC+yPKMHCqtaVZ9kp3Q+cNsp+jHTtE0
         CgWKYkbFd5H1WOgcFR0J21y5MmPdxgrVbSnTNlLfpXYKnITZ3K/vThhG6uaV2uaGZj2t
         HinROvfBne/suqWEPnreOKm8Hh32P1QRCQ19j7K019tigKn+wiTVCcuwgWBkmO0ZuD3T
         3pgQ==
X-Gm-Message-State: ANoB5pkcGY5dnRA2d0h36BDOsPLDoHt1WbvlwdoLdmXWwwuhXiL+Xfkm
        DLnuAjYb11u4IZPKU71oD/aKd71eTqiAP7fcSNJgbQ==
X-Google-Smtp-Source: AA0mqf6Rao5E3PztPW/BA/HFs3hriIaxIw1376MqyH3vaJ986VSvvGkQHWkM90HPAR9KgKdO7dRZ0JYlBanDMJdtk+s=
X-Received: by 2002:a5d:4acb:0:b0:242:78b7:6bf3 with SMTP id
 y11-20020a5d4acb000000b0024278b76bf3mr5995792wrs.375.1670540452229; Thu, 08
 Dec 2022 15:00:52 -0800 (PST)
MIME-Version: 1.0
References: <Y49vx0v6Z7EiR8jr@kernel.org> <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org> <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org> <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com> <Y5DNBZNC5rBBqlJW@kernel.org>
 <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com> <Y5JfgyN59dSeKbUP@kernel.org>
 <Y5Jl8MeW90DXy1wT@kernel.org>
In-Reply-To: <Y5Jl8MeW90DXy1wT@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 8 Dec 2022 15:00:39 -0800
Message-ID: <CAP-5=fWyb+w2EP4cGBJU3RD6E_OkBZ+3w5+YyhwX7fOA-H0aWQ@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 8, 2022 at 2:32 PM Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>
> Em Thu, Dec 08, 2022 at 07:04:52PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Thu, Dec 08, 2022 at 12:21:20PM +0530, Athira Rajeev escreveu:
> > > > On 07-Dec-2022, at 10:57 PM, Arnaldo Carvalho de Melo <acme@kernel.=
org> wrote:
> > > > Can you try again? tmp.perf/core? That "tmp." part means its a forc=
e
> > > > pushed branch, so I just force pushed with some arch specific fixes=
, now
> > > > I'm down to (removing the successful builds and unrelated failures,=
 now
> > > > related to libbpf's F_DUPFD_CLOEXEC kaboom):
> >
> > > Ok Arnaldo, Sure, I will check with updated branch
> >
> > > >   5     7.38 fedora:34                     : FAIL gcc version 11.3.=
1 20220421 (Red Hat 11.3.1-2) (GCC)
> > > >    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function =E2=80=
=98evsel__rawptr=E2=80=99:
> > > >    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: =E2=
=80=98TEP_FIELD_IS_RELATIVE=E2=80=99 undeclared (first use in this function=
); did you mean =E2=80=98TEP_FIELD_IS_FLAG=E2=80=99?
> > > >     2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE=
)
> > > >          |                                    ^~~~~~~~~~~~~~~~~~~~~
> > > >          |                                    TEP_FIELD_IS_FLAG
> >
> > > I observed same issue as updated here:
> > > https://lore.kernel.org/lkml/10476A85-3F75-4C91-AB5B-E5B136F31297@lin=
ux.vnet.ibm.com/
> >
> > > Looks like TEP_FIELD_IS_RELATIVE is not defined in header file of the=
 system installed version.
> > > whereas it is there in header file in tools/lib/traceevent
> >
> > > # grep TEP_FIELD_IS_RELATIVE /usr/include/traceevent/event-parse.h
> > > # grep TEP_FIELD_IS_RELATIVE ../lib/traceevent/event-parse.h
> > >     TEP_FIELD_IS_RELATIVE   =3D 256,
> >
> > Right, I had noticed that as well, so as a prep patch I'm adding the
> > patch below, before Ian's. Please check and provide an
> > Acked-by/Tested-by/Reviewed-by if possible.
>
> I ended up with the one below, _after_ Ian's patch as I had some trouble =
grafting
> it before and had already tested it this way multiple times, I'm pushing
> this to tmp/perf.core.
>
> - Arnaldo
>
> commit a0ec3ef4590e7e82339b6f318e671a6b69fd94e8
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Dec 8 19:28:58 2022 -0300
>
>     perf tools: Add test to check if libtracevent has TEP_FIELD_IS_RELATI=
VE
>

Could HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE be a version rather
than feature check, something like:

#define MAKE_LIBTRACEEVENT_VERSION(maj, mid, min) (maj * 255 *255 +
mid * 255 + min)
#define HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
(LIBTRACEEVENT_VERSION >=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)

Note, we have LIBTRACEEVENT_VERSION computed in Makefile.config by way
of pkg-config.

Thanks,
Ian

>     Some distros have older versions of libtraceevent where
>     TEP_FIELD_IS_RELATIVE and its associated semantics are not present, s=
o
>     we need to test for its presence and cope when it isn't present when
>     building with LIBTRACEEVENT_DYNAMIC=3D1.
>
>     Reported-by: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Ian Rogers <irogers@google.com>
>     Cc: Ingo Molnar <mingo@redhat.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Nick Desaulniers <ndesaulniers@google.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>,
>     Cc: Stephane Eranian <eranian@google.com>
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 38f8851bd7cbdb0e..c6c9b7c7723d4290 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -71,7 +71,8 @@ FEATURE_TESTS_BASIC :=3D                  \
>          libzstd                                \
>          disassembler-four-args         \
>          disassembler-init-styled       \
> -        file-handle
> +        file-handle                    \
> +        libtraceevent-tep_field_is_relative
>
>  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
>  # of all feature tests
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 690fe97be1904399..24246df35ac30eeb 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -81,7 +81,8 @@ FILES=3D                                          \
>           test-libzstd.bin                      \
>           test-clang-bpf-co-re.bin              \
>           test-file-handle.bin                  \
> -         test-libpfm4.bin
> +         test-libpfm4.bin                      \
> +         test-libtraceevent-tep_field_is_relative
>
>  FILES :=3D $(addprefix $(OUTPUT),$(FILES))
>
> @@ -159,6 +160,9 @@ $(OUTPUT)test-dwarf_getlocations.bin:
>  $(OUTPUT)test-libelf-getphdrnum.bin:
>         $(BUILD) -lelf
>
> +$(OUTPUT)test-libtraceevent-tep_field_is_relative.bin:
> +       $(BUILD) -ltraceevent
> +
>  $(OUTPUT)test-libelf-gelf_getnote.bin:
>         $(BUILD) -lelf
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 680228e19c1aabdb..e29975664f06bd61 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1197,6 +1197,10 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>      LIBTRACEEVENT_VERSION_CPP :=3D $(shell expr $(LIBTRACEEVENT_VERSION_=
1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERS=
ION_3))
>      CFLAGS +=3D -DLIBTRACEEVENT_VERSION=3D$(LIBTRACEEVENT_VERSION_CPP)
>      $(call detected,CONFIG_LIBTRACEEVENT)
> +    $(call feature_check,libtraceevent-tep_field_is_relative)
> +    ifeq ($(feature-libtraceevent-tep_field_is_relative), 1)
> +      CFLAGS +=3D -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +    endif
>    else
>      dummy :=3D $(warning Warning: libtraceevent is missing limiting func=
tionality, please install libtraceevent-dev/libtraceevent-devel)
>    endif
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 6909cd9f48d11644..c9802ab549d7782f 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2729,8 +2729,10 @@ static size_t trace__fprintf_tp_fields(struct trac=
e *trace, struct evsel *evsel,
>                                 offset =3D format_field__intval(field, sa=
mple, evsel->needs_swap);
>                                 syscall_arg.len =3D offset >> 16;
>                                 offset &=3D 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
>                                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                                         offset +=3D field->offset + field=
->size;
> +#endif
>                         }
>
>                         val =3D (uintptr_t)(sample->raw_data + offset);
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-con=
vert-bt.c
> index 8031b586e81384e7..b842273458b862bd 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -322,8 +322,10 @@ static int add_tracepoint_field_value(struct ctf_wri=
ter *cw,
>                 offset =3D tmp_val;
>                 len =3D offset >> 16;
>                 offset &=3D 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
>                 if (flags & TEP_FIELD_IS_RELATIVE)
>                         offset +=3D fmtf->offset + fmtf->size;
> +#endif
>         }
>
>         if (flags & TEP_FIELD_IS_ARRAY) {
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ca911856c4b1d3c8..77b2cf5a214ec1e4 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2784,8 +2784,10 @@ void *evsel__rawptr(struct evsel *evsel, struct pe=
rf_sample *sample, const char
>         if (field->flags & TEP_FIELD_IS_DYNAMIC) {
>                 offset =3D *(int *)(sample->raw_data + field->offset);
>                 offset &=3D 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
>                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                         offset +=3D field->offset + field->size;
> +#endif
>         }
>
>         return sample->raw_data + offset;
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 6fb84b7455b8392d..7320f7f777fe0e56 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -442,8 +442,10 @@ tracepoint_field(struct pyrf_event *pe, struct tep_f=
ormat_field *field)
>                         offset  =3D val;
>                         len     =3D offset >> 16;
>                         offset &=3D 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
>                         if (field->flags & TEP_FIELD_IS_RELATIVE)
>                                 offset +=3D field->offset + field->size;
> +#endif
>                 }
>                 if (field->flags & TEP_FIELD_IS_STRING &&
>                     is_printable_array(data + offset, len)) {
> diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools=
/perf/util/scripting-engines/trace-event-perl.c
> index 0bacb49408f84adf..c097b7934fd4ebe9 100644
> --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> @@ -393,8 +393,10 @@ static void perl_process_tracepoint(struct perf_samp=
le *sample,
>                         if (field->flags & TEP_FIELD_IS_DYNAMIC) {
>                                 offset =3D *(int *)(data + field->offset)=
;
>                                 offset &=3D 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
>                                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                                         offset +=3D field->offset + field=
->size;
> +#endif
>                         } else
>                                 offset =3D field->offset;
>                         XPUSHs(sv_2mortal(newSVpv((char *)data + offset, =
0)));
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/too=
ls/perf/util/scripting-engines/trace-event-python.c
> index fabba21919b8fa51..e930f5f1f36d2831 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -994,8 +994,10 @@ static void python_process_tracepoint(struct perf_sa=
mple *sample,
>                                 offset  =3D val;
>                                 len     =3D offset >> 16;
>                                 offset &=3D 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
>                                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                                         offset +=3D field->offset + field=
->size;
> +#endif
>                         }
>                         if (field->flags & TEP_FIELD_IS_STRING &&
>                             is_printable_array(data + offset, len)) {
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index c7a97b33e13477e1..0ecc2cb137920d2d 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -2568,9 +2568,10 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt=
 *fmt,
>                 tep_read_number_field(field, a->raw_data, &dyn);
>                 offset =3D dyn & 0xffff;
>                 size =3D (dyn >> 16) & 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
>                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>                         offset +=3D field->offset + field->size;
> -
> +#endif
>                 /* record max width for output */
>                 if (size > hde->dynamic_len)
>                         hde->dynamic_len =3D size;
