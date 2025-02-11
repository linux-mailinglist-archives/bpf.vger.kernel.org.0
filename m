Return-Path: <bpf+bounces-51081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B923A2FF32
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390B8163FC1
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2DD70808;
	Tue, 11 Feb 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBk39A+a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2405BA3D
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234052; cv=none; b=jHq+zbvX/h+yR0/LYgEsndse5Wt9KfRrPxPZhaA+SPslX4qV8RS6B7TMcI395QY+h77VgFLG2iVVaVqCmxUGdx36DzqzKdIEDv4JNzG/gh/Y4GffNKbQNaEub9QTFfNKrK9taybEXsrv7byYbGwJHiSpi17FnA1Rkpn8PVpIsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234052; c=relaxed/simple;
	bh=WDfDTfHtqeIzToQTmmFnN6+NL2xAph6kR6zVbJmk7tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCP9yed4/5TryXxjZ2xlaNDAwCaoIf8x17bok+NoMPEtWmvOz2u5N1mjw4TDLA/R5KkxNUR797TChyt2pH5bp4rFs86evXRTMY6qZaU4YoSOe+Sjy1i+2bx4Dj4RLpYTNH1smKMR/X9AhVYuuG01qXrEnBcE5Gaog1vNoP2m7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBk39A+a; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so3245237a91.3
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 16:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739234050; x=1739838850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuEeWJhMrC3RqWADueoUEaqzgg5vT8D4pacwtpolI2M=;
        b=gBk39A+aHTmKmmSq0Fmn69wyQCPd551wWsQKpNxbnymM3APMr5/5SYNKX+lmIFZ7Ck
         7Kd/AekQjTx8P8QoALyjjit4f2BEJGFjLkPENvVfIM/uOQMeaBVeRk/oTd0lqJehduEY
         0Z3CxBZnck/DT0REkp7+upGAqsfa9GAecMZkzB81M7Wie6XBIyUYLFwfv/Vr0F6m9s1K
         rI6qEkQQXSaeyExiYyD4bcI3u4YSW7Bs+0RqD+UuoJ/bovFlWkaSjfj+3IjIz4uP7zDa
         Jq8M9QA2jHu5ddaYSC0KcFl+r+YCTD3EIx30FyDgBs/67sckksvdBw1lAs9wlxxdOKsa
         949Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234050; x=1739838850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuEeWJhMrC3RqWADueoUEaqzgg5vT8D4pacwtpolI2M=;
        b=pPSRh5+THH4tjPAPuQOVVCJiZCi/i0SIz+phRPFVUJt7OdndTh3k1K9Hkr3HrAZBBM
         Saqwgz7Du8RRRttbr7jZOAvfHFroxTbPHMJ0m92Y+qjbpmruguVHwSiEkxGPgSCD1RA5
         4J8y/OGdgM22uNfBjFSpAQ56XNAmOciGhtdTrhZg8gX07DEsjdam3UgCBzSHysHR64Vb
         siIoH1WKHWrwEO7TAgKsg39+TLoh0KgNRhVUFf6r/iFbvdZBbcT6QoEW8XJf02gl39Rf
         Mesycsx0NUeHPFKUsjmYf+pBgjga/Gz7hhIaniXjNGm7flxZfVlEA1zEAu7PuUDYmR9T
         bhSg==
X-Forwarded-Encrypted: i=1; AJvYcCWHPHoocTtIuWDtdP1jG7gfVehL/XiDcT1Olz1WHvt3nCS45QcN8yCQ0TNLC4iNzl2Lrac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/bMvU6ctXGPJNhvN+9dSt+6cvpXdGEpzm7GiFZVHGDSmPvejb
	raxamOVm6oSScetEpLVpDikgEyEH0gT3ozVu4o3lWk/Mlwl6SLGqcPF+2j8L0ZHkJz8QFPTuuOU
	HyBRLFm4hDmwX8+ljqKMVI6e7jyg=
X-Gm-Gg: ASbGnctimonMOoeoG3bSDQG5eEjJ1VGOYHjRZSV05xeIJAK2UscZ7NiuU9qgHFe3+LV
	oaMUIZHdliid85m2DEXTY7cLxSQeRrpQDQhBbtKgFJdcE5i3mMDgg8IjoX/pn/2fZM3zUyNURaC
	3UHLLbamBmrGHL
X-Google-Smtp-Source: AGHT+IFe7MCt3tMy8UJnCFcTCDJ7Ws9aSGX9GZLsZKm8TXGecMHmJJdHGw5Lw4vx1Y8cmCvlQpVBvadNgzfTIk1Y+cI=
X-Received: by 2002:a17:90b:3596:b0:2ee:bf84:4fe8 with SMTP id
 98e67ed59e1d1-2fa243eaa37mr21305490a91.30.1739234049785; Mon, 10 Feb 2025
 16:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207014809.1573841-1-andrii@kernel.org> <20250207014809.1573841-2-andrii@kernel.org>
 <3313c853-9ed7-4498-b78d-96713ff7b50d@oracle.com>
In-Reply-To: <3313c853-9ed7-4498-b78d-96713ff7b50d@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Feb 2025 16:33:57 -0800
X-Gm-Features: AWEUYZkwlwYCpvPHBOHgdSVriKWqbR5OXZpKN3pJ7jDG1TmexpF2vAFVGl7pwGI
Message-ID: <CAEf4BzZAOJMm7pdaM6DYn=_nhL9qA2h29V-itpQx=RvgyMsodw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add test for LDX/STX/ST
 relocations over array field
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 12:13=E2=80=AFPM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> Hi Andrii,
>
> On 07-02-2025 01:48, Andrii Nakryiko wrote:
> > Add a simple repro for the issue of miscalculating LDX/STX/ST CO-RE
> > relocation size adjustment when the CO-RE relocation target type is an
> > ARRAY.
> >
> > We need to make sure that compiler generates LDX/STX/ST instruction wit=
h
> > CO-RE relocation against entire ARRAY type, not ARRAY's element. With
> > the code pattern in selftest, we get this:
> >
> >        59:       61 71 00 00 00 00 00 00 w1 =3D *(u32 *)(r7 + 0x0)
> >                  00000000000001d8:  CO-RE <byte_off> [5] struct core_re=
loc_arrays::a (0:0)
> >
> > Where offset of `int a[5]` is embedded (through CO-RE relocation) into =
memory
> > load instruction itself.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   tools/testing/selftests/bpf/prog_tests/core_reloc.c    |  6 ++++--
> >   ...f__core_reloc_arrays___err_bad_signed_arr_elem_sz.c |  3 +++
> >   tools/testing/selftests/bpf/progs/core_reloc_types.h   | 10 +++++++++=
+
> >   .../selftests/bpf/progs/test_core_reloc_arrays.c       |  5 +++++
> >   4 files changed, 22 insertions(+), 2 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_=
arrays___err_bad_signed_arr_elem_sz.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tool=
s/testing/selftests/bpf/prog_tests/core_reloc.c
> > index e10ea92c3fe2..08963c82f30b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> > @@ -85,11 +85,11 @@ static int duration =3D 0;
> >   #define NESTING_ERR_CASE(name) {                                    \
> >       NESTING_CASE_COMMON(name),                                      \
> >       .fails =3D true,                                                 =
 \
> > -     .run_btfgen_fails =3D true,                                      =
                 \
> > +     .run_btfgen_fails =3D true,                                      =
 \
> >   }
> >
> >   #define ARRAYS_DATA(struct_name) STRUCT_TO_CHAR_PTR(struct_name) {  \
> > -     .a =3D { [2] =3D 1 },                                            =
   \
> > +     .a =3D { [2] =3D 1, [3] =3D 11 },                                =
     \
> >       .b =3D { [1] =3D { [2] =3D { [3] =3D 2 } } },                    =
       \
> >       .c =3D { [1] =3D { .c =3D  3 } },                                =
     \
> >       .d =3D { [0] =3D { [0] =3D { .d =3D 4 } } },                     =
       \
> > @@ -108,6 +108,7 @@ static int duration =3D 0;
> >       .input_len =3D sizeof(struct core_reloc_##name),                 =
 \
> >       .output =3D STRUCT_TO_CHAR_PTR(core_reloc_arrays_output) {       =
 \
> >               .a2   =3D 1,                                             =
 \
> > +             .a3   =3D 12,                                            =
 \
> >               .b123 =3D 2,                                             =
 \
> >               .c1c  =3D 3,                                             =
 \
> >               .d00d =3D 4,                                             =
 \
> > @@ -602,6 +603,7 @@ static const struct core_reloc_test_case test_cases=
[] =3D {
> >       ARRAYS_ERR_CASE(arrays___err_non_array),
> >       ARRAYS_ERR_CASE(arrays___err_wrong_val_type),
> >       ARRAYS_ERR_CASE(arrays___err_bad_zero_sz_arr),
> > +     ARRAYS_ERR_CASE(arrays___err_bad_signed_arr_elem_sz),
> >
> >       /* enum/ptr/int handling scenarios */
> >       PRIMITIVES_CASE(primitives),
> > diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_arrays__=
_err_bad_signed_arr_elem_sz.c b/tools/testing/selftests/bpf/progs/btf__core=
_reloc_arrays___err_bad_signed_arr_elem_sz.c
> > new file mode 100644
> > index 000000000000..21a560427b10
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_ba=
d_signed_arr_elem_sz.c
> > @@ -0,0 +1,3 @@
> > +#include "core_reloc_types.h"
> > +
> > +void f(struct core_reloc_arrays___err_bad_signed_arr_elem_sz x) {}
> > diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/too=
ls/testing/selftests/bpf/progs/core_reloc_types.h
> > index fd8e1b4c6762..5760ae015e09 100644
> > --- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
> > +++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
> > @@ -347,6 +347,7 @@ struct core_reloc_nesting___err_too_deep {
> >    */
> >   struct core_reloc_arrays_output {
> >       int a2;
> > +     int a3;
> >       char b123;
> >       int c1c;
> >       int d00d;
> > @@ -455,6 +456,15 @@ struct core_reloc_arrays___err_bad_zero_sz_arr {
> >       struct core_reloc_arrays_substruct d[1][2];
> >   };
> >
> > +struct core_reloc_arrays___err_bad_signed_arr_elem_sz {
> > +     /* int -> short (signed!): not supported case */
> > +     short a[5];
> > +     char b[2][3][4];
> > +     struct core_reloc_arrays_substruct c[3];
> > +     struct core_reloc_arrays_substruct d[1][2];
> > +     struct core_reloc_arrays_substruct f[][2];
> > +};
> > +
> >   /*
> >    * PRIMITIVES
> >    */
> > diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c=
 b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
> > index 51b3f79df523..448403634eea 100644
> > --- a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
> > +++ b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
> > @@ -15,6 +15,7 @@ struct {
> >
> >   struct core_reloc_arrays_output {
> >       int a2;
> > +     int a3;
> >       char b123;
> >       int c1c;
> >       int d00d;
> > @@ -41,6 +42,7 @@ int test_core_arrays(void *ctx)
> >   {
> >       struct core_reloc_arrays *in =3D (void *)&data.in;
> >       struct core_reloc_arrays_output *out =3D (void *)&data.out;
> > +     int *a;
> >
> >       if (CORE_READ(&out->a2, &in->a[2]))
> >               return 1;
> > @@ -53,6 +55,9 @@ int test_core_arrays(void *ctx)
> >       if (CORE_READ(&out->f01c, &in->f[0][1].c))
> >               return 1;
> >
> > +     a =3D __builtin_preserve_access_index(({ in->a; }));
> > +     out->a3 =3D a[0] + a[1] + a[2] + a[3];
> Just to try to understand what seems to be the expectation from the
> compiler and CO-RE in this case.
> Do you expect that all those a[n] accesses would be generating CO-RE
> relocations assuming the size for the elements in in->a ?
>

Well, I only care to get LDX instruction with associated in->a CO-RE
relocation. This is what Clang currently generates for this piece of
code. You can see that it combines both LDX+CO-RE relo for a[0], and
then non-CO-RE relocated LDX for a[1], a[2], a[3], where the base was
relocated with CO-RE a bit earlier.

      44:       18 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r7 =3D 0x0 =
ll
                0000000000000160:  R_BPF_64_64  data

...

      55:       b7 01 00 00 00 00 00 00 r1 =3D 0x0
                00000000000001b8:  CO-RE <byte_off> [5] struct
core_reloc_arrays::a (0:0)
      56:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 =3D 0x0 =
ll
                00000000000001c0:  R_BPF_64_64  data
      58:       0f 12 00 00 00 00 00 00 r2 +=3D r1
      59:       61 71 00 00 00 00 00 00 w1 =3D *(u32 *)(r7 + 0x0)
                00000000000001d8:  CO-RE <byte_off> [5] struct
core_reloc_arrays::a (0:0)
      60:       61 23 04 00 00 00 00 00 w3 =3D *(u32 *)(r2 + 0x4)
      61:       0c 13 00 00 00 00 00 00 w3 +=3D w1
      62:       61 21 08 00 00 00 00 00 w1 =3D *(u32 *)(r2 + 0x8)
      63:       0c 13 00 00 00 00 00 00 w3 +=3D w1
      64:       61 21 0c 00 00 00 00 00 w1 =3D *(u32 *)(r2 + 0xc)
      65:       0c 13 00 00 00 00 00 00 w3 +=3D w1
      66:       63 37 04 01 00 00 00 00 *(u32 *)(r7 + 0x104) =3D w3

Clang might change code generation pattern in the future, of course,
but at least as of right now I know I did test this logic :) Ideally
I'd be able to generate embedded asm with CO-RE relocation, but I'm
not sure that's supported today.

> > +
> >       return 0;
> >   }
> >
>

