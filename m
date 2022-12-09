Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068DC647DD0
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 07:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLIGe4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 01:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLIGez (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 01:34:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801E26BC87;
        Thu,  8 Dec 2022 22:34:54 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B96AFcf008277;
        Fri, 9 Dec 2022 06:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Xqg6JunzJ8tqwBBY6B5JEhoApmfxFkl/+lYLCgR6hFc=;
 b=JzKOP+G58VxxpE+1p1SkHMIW4djQ5dChnS2JaxYn+4xcU3xBKsGhNzim12szgfvzzaSc
 v+bmOiMyagAVLm9/gnP+Gl078QDoiHYSzBKmGKc2nh7Kx304t35Xb+iqt5cHnkdtp04d
 4g5ARtoOb+jcS1nIcIovn4CGDiwfnA1P6piVz7g1+A75AAct9RA+65PmCe6XthxGRmmW
 Q2ApuzauREUjDuhtjZSezMtvcmkf00GFTdOW+5s0IzK3DXupxcD0dKQ0Ej/ojaJn2epQ
 R52TCRT2IqEvePCtZ5+gT7GJjaEO9PNp4WzLYQappYBjCesZ3fPbKpqXRK+n8delvqfr Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbrjk8r0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 06:34:40 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B96KY2J008757;
        Fri, 9 Dec 2022 06:34:39 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbrjk8qyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 06:34:39 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8LNuiT027261;
        Fri, 9 Dec 2022 06:34:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3m9ks45hwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 06:34:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B96YYFE44499242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Dec 2022 06:34:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 862A920063;
        Fri,  9 Dec 2022 06:34:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88F8220040;
        Fri,  9 Dec 2022 06:34:31 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.0.55])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Dec 2022 06:34:31 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Y5Jl8MeW90DXy1wT@kernel.org>
Date:   Fri, 9 Dec 2022 12:04:18 +0530
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Message-Id: <8F6F0C27-53F3-4837-A19C-845768253249@linux.vnet.ibm.com>
References: <Y49vx0v6Z7EiR8jr@kernel.org> <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org> <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org> <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
 <Y5DNBZNC5rBBqlJW@kernel.org>
 <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com>
 <Y5JfgyN59dSeKbUP@kernel.org> <Y5Jl8MeW90DXy1wT@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cYAxDGwvXZV8JB3vSpygCkYJbKXlRIuW
X-Proofpoint-ORIG-GUID: 4hJrBgfdiV5JaP8TW9qSwlsJnCZs81yS
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_02,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 09-Dec-2022, at 4:02 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>=20
> Em Thu, Dec 08, 2022 at 07:04:52PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Thu, Dec 08, 2022 at 12:21:20PM +0530, Athira Rajeev escreveu:
>>>> On 07-Dec-2022, at 10:57 PM, Arnaldo Carvalho de Melo <acme@kernel.org=
> wrote:
>>>> Can you try again? tmp.perf/core? That "tmp." part means its a force
>>>> pushed branch, so I just force pushed with some arch specific fixes, n=
ow
>>>> I'm down to (removing the successful builds and unrelated failures, now
>>>> related to libbpf's F_DUPFD_CLOEXEC kaboom):
>>=20
>>> Ok Arnaldo, Sure, I will check with updated branch
>>=20
>>>>  5     7.38 fedora:34                     : FAIL gcc version 11.3.1 20=
220421 (Red Hat 11.3.1-2) (GCC)
>>>>   /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function =E2=80=98ev=
sel__rawptr=E2=80=99:
>>>>   /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: =E2=80=
=98TEP_FIELD_IS_RELATIVE=E2=80=99 undeclared (first use in this function); =
did you mean =E2=80=98TEP_FIELD_IS_FLAG=E2=80=99?
>>>>    2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>>>>         |                                    ^~~~~~~~~~~~~~~~~~~~~
>>>>         |                                    TEP_FIELD_IS_FLAG
>>=20
>>> I observed same issue as updated here:=20
>>> https://lore.kernel.org/lkml/10476A85-3F75-4C91-AB5B-E5B136F31297@linux=
.vnet.ibm.com/
>>=20
>>> Looks like TEP_FIELD_IS_RELATIVE is not defined in header file of the s=
ystem installed version.
>>> whereas it is there in header file in tools/lib/traceevent
>>=20
>>> # grep TEP_FIELD_IS_RELATIVE /usr/include/traceevent/event-parse.h
>>> # grep TEP_FIELD_IS_RELATIVE ../lib/traceevent/event-parse.h
>>> 	TEP_FIELD_IS_RELATIVE	=3D 256,
>>=20
>> Right, I had noticed that as well, so as a prep patch I'm adding the
>> patch below, before Ian's. Please check and provide an
>> Acked-by/Tested-by/Reviewed-by if possible.
>=20
> I ended up with the one below, _after_ Ian's patch as I had some trouble =
grafting
> it before and had already tested it this way multiple times, I'm pushing
> this to tmp/perf.core.
>=20
> - Arnaldo


Hi Arnaldo, Ian

Thanks for the fixes.

Since we changed =E2=80=9CCONFIG_TRACEEVENT=E2=80=9D to =E2=80=9CCONFIG_LIB=
TRACEEVENT=E2=80=9D,=20
below change is also needed in =E2=80=9Carch/powerpc/util/Build=E2=80=9D

diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/u=
til/Build
index 71e57f28abda..9889245c555c 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,5 +1,5 @@
 perf-y +=3D header.o
-perf-$(CONFIG_TRACEEVENT) +=3D kvm-stat.o
+perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
 perf-y +=3D perf_regs.o
 perf-y +=3D mem-events.o
 perf-y +=3D sym-handling.o

With this change, I could successfully compile in these environment:
- Without libtraceevent-devel installed
- With libtraceevent-devel installed
- With =E2=80=9Cmake NO_LIBTRACEEVENT=3D1=E2=80=9D

With above change,
Acked-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira

>=20
> commit a0ec3ef4590e7e82339b6f318e671a6b69fd94e8
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Dec 8 19:28:58 2022 -0300
>=20
>    perf tools: Add test to check if libtracevent has TEP_FIELD_IS_RELATIVE
>=20
>    Some distros have older versions of libtraceevent where
>    TEP_FIELD_IS_RELATIVE and its associated semantics are not present, so
>    we need to test for its presence and cope when it isn't present when
>    building with LIBTRACEEVENT_DYNAMIC=3D1.
>=20
>    Reported-by: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
>    Cc: Adrian Hunter <adrian.hunter@intel.com>
>    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>    Cc: Ian Rogers <irogers@google.com>
>    Cc: Ingo Molnar <mingo@redhat.com>
>    Cc: Jiri Olsa <jolsa@kernel.org>
>    Cc: Mark Rutland <mark.rutland@arm.com>
>    Cc: Namhyung Kim <namhyung@kernel.org>
>    Cc: Nick Desaulniers <ndesaulniers@google.com>
>    Cc: Peter Zijlstra <peterz@infradead.org>,
>    Cc: Stephane Eranian <eranian@google.com>
>    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 38f8851bd7cbdb0e..c6c9b7c7723d4290 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -71,7 +71,8 @@ FEATURE_TESTS_BASIC :=3D                  \
>         libzstd				\
>         disassembler-four-args		\
>         disassembler-init-styled	\
> -        file-handle
> +        file-handle			\
> +        libtraceevent-tep_field_is_relative
>=20
> # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
> # of all feature tests
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 690fe97be1904399..24246df35ac30eeb 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -81,7 +81,8 @@ FILES=3D                                          \
>          test-libzstd.bin			\
>          test-clang-bpf-co-re.bin		\
>          test-file-handle.bin			\
> -         test-libpfm4.bin
> +         test-libpfm4.bin			\
> +         test-libtraceevent-tep_field_is_relative
>=20
> FILES :=3D $(addprefix $(OUTPUT),$(FILES))
>=20
> @@ -159,6 +160,9 @@ $(OUTPUT)test-dwarf_getlocations.bin:
> $(OUTPUT)test-libelf-getphdrnum.bin:
> 	$(BUILD) -lelf
>=20
> +$(OUTPUT)test-libtraceevent-tep_field_is_relative.bin:
> +	$(BUILD) -ltraceevent
> +
> $(OUTPUT)test-libelf-gelf_getnote.bin:
> 	$(BUILD) -lelf
>=20
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 680228e19c1aabdb..e29975664f06bd61 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1197,6 +1197,10 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>     LIBTRACEEVENT_VERSION_CPP :=3D $(shell expr $(LIBTRACEEVENT_VERSION_1=
) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSI=
ON_3))
>     CFLAGS +=3D -DLIBTRACEEVENT_VERSION=3D$(LIBTRACEEVENT_VERSION_CPP)
>     $(call detected,CONFIG_LIBTRACEEVENT)
> +    $(call feature_check,libtraceevent-tep_field_is_relative)
> +    ifeq ($(feature-libtraceevent-tep_field_is_relative), 1)
> +      CFLAGS +=3D -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> +    endif
>   else
>     dummy :=3D $(warning Warning: libtraceevent is missing limiting funct=
ionality, please install libtraceevent-dev/libtraceevent-devel)
>   endif
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 6909cd9f48d11644..c9802ab549d7782f 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2729,8 +2729,10 @@ static size_t trace__fprintf_tp_fields(struct trac=
e *trace, struct evsel *evsel,
> 				offset =3D format_field__intval(field, sample, evsel->needs_swap);
> 				syscall_arg.len =3D offset >> 16;
> 				offset &=3D 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> 				if (field->flags & TEP_FIELD_IS_RELATIVE)
> 					offset +=3D field->offset + field->size;
> +#endif
> 			}
>=20
> 			val =3D (uintptr_t)(sample->raw_data + offset);
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-con=
vert-bt.c
> index 8031b586e81384e7..b842273458b862bd 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -322,8 +322,10 @@ static int add_tracepoint_field_value(struct ctf_wri=
ter *cw,
> 		offset =3D tmp_val;
> 		len =3D offset >> 16;
> 		offset &=3D 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> 		if (flags & TEP_FIELD_IS_RELATIVE)
> 			offset +=3D fmtf->offset + fmtf->size;
> +#endif
> 	}
>=20
> 	if (flags & TEP_FIELD_IS_ARRAY) {
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ca911856c4b1d3c8..77b2cf5a214ec1e4 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2784,8 +2784,10 @@ void *evsel__rawptr(struct evsel *evsel, struct pe=
rf_sample *sample, const char
> 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> 		offset =3D *(int *)(sample->raw_data + field->offset);
> 		offset &=3D 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> 		if (field->flags & TEP_FIELD_IS_RELATIVE)
> 			offset +=3D field->offset + field->size;
> +#endif
> 	}
>=20
> 	return sample->raw_data + offset;
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 6fb84b7455b8392d..7320f7f777fe0e56 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -442,8 +442,10 @@ tracepoint_field(struct pyrf_event *pe, struct tep_f=
ormat_field *field)
> 			offset  =3D val;
> 			len     =3D offset >> 16;
> 			offset &=3D 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> 			if (field->flags & TEP_FIELD_IS_RELATIVE)
> 				offset +=3D field->offset + field->size;
> +#endif
> 		}
> 		if (field->flags & TEP_FIELD_IS_STRING &&
> 		    is_printable_array(data + offset, len)) {
> diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools=
/perf/util/scripting-engines/trace-event-perl.c
> index 0bacb49408f84adf..c097b7934fd4ebe9 100644
> --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> @@ -393,8 +393,10 @@ static void perl_process_tracepoint(struct perf_samp=
le *sample,
> 			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> 				offset =3D *(int *)(data + field->offset);
> 				offset &=3D 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> 				if (field->flags & TEP_FIELD_IS_RELATIVE)
> 					offset +=3D field->offset + field->size;
> +#endif
> 			} else
> 				offset =3D field->offset;
> 			XPUSHs(sv_2mortal(newSVpv((char *)data + offset, 0)));
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/too=
ls/perf/util/scripting-engines/trace-event-python.c
> index fabba21919b8fa51..e930f5f1f36d2831 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -994,8 +994,10 @@ static void python_process_tracepoint(struct perf_sa=
mple *sample,
> 				offset  =3D val;
> 				len     =3D offset >> 16;
> 				offset &=3D 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> 				if (field->flags & TEP_FIELD_IS_RELATIVE)
> 					offset +=3D field->offset + field->size;
> +#endif
> 			}
> 			if (field->flags & TEP_FIELD_IS_STRING &&
> 			    is_printable_array(data + offset, len)) {
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index c7a97b33e13477e1..0ecc2cb137920d2d 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -2568,9 +2568,10 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt=
 *fmt,
> 		tep_read_number_field(field, a->raw_data, &dyn);
> 		offset =3D dyn & 0xffff;
> 		size =3D (dyn >> 16) & 0xffff;
> +#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> 		if (field->flags & TEP_FIELD_IS_RELATIVE)
> 			offset +=3D field->offset + field->size;
> -
> +#endif
> 		/* record max width for output */
> 		if (size > hde->dynamic_len)
> 			hde->dynamic_len =3D size;

