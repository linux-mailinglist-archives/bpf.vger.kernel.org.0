Return-Path: <bpf+bounces-61732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DA4AEAE2D
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 06:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD9A4E0B52
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 04:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB31D9A5D;
	Fri, 27 Jun 2025 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mymVmmFu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A353EAD0
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 04:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000041; cv=none; b=SMaFKdpPcFtyNdEp4e8ybSxbFRiLgvwJyNk+Clq9fVhVv686iFZOUVCHoHqqXScVbMmtiVaboiIegKrR64LQHRlQ1K/IRn7d+AAvZEW5/VG9/fpjY0QRUiqI7nBtFQmQfteVGU9YhNPeiawwf/8l7pWtMuF29IM+obeXtbB32zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000041; c=relaxed/simple;
	bh=483uB6UzX2TgzfCyZzzGHymgeL//x7AkYDxxGnp6K6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvOZ8EYiqtV/Zw8jM1iCB/5HCJYleSQDDHsHf1i9RN2qRrfAUQkkn2WJv80jCUgf3yUaMQXZhe8prbv0ciIbqo5geNTaCk44ZHnvHh7UD3k0i4ZakLOo8xvH2ViEFoMee4ZE/8amoKUk971WlampBzbZNukmf8x0jUhrLiqHNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mymVmmFu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-237f270513bso74655ad.1
        for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 21:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751000038; x=1751604838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtGyqXmElvAld4zBVXkgxOmHALsnPQCTadiFmCBdWaw=;
        b=mymVmmFuNagM1bLnkwA+QbAnjJj+KRJhvyTIKF9bews5RIiU1XZwrk1H3SrXo3Gx6Z
         ZskB5VCFyx5RZcVZTVlyQeDI4Wi4KoJ6EQ5A9Q9K7SbP2Gdfi+l/IgYbK7xUh3KvIoYE
         GWuLe7PhTHskq5QVvt5aTE2ymgEnR7FoTHMiDCeiV09lmnur78TQJrZHyPEmU2Mure+s
         42kaaW4Dmk3cZeTCifLpFK+V9z4+BdaO1qi0KM/sN2m3fm25+xFKDGMZUTctW5eMsp8L
         6mADiyU+sK02PXFgpecvGc/1OdvUaiHKZ3VrK3BGYdZSS6b8L/wlaqQfuNVFdBw1oPsS
         +RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751000038; x=1751604838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtGyqXmElvAld4zBVXkgxOmHALsnPQCTadiFmCBdWaw=;
        b=B1lq8E4WXS9apkqbPXgHPI548fJ+oMvNtpEgyL6zToDOd3l5ozYb8waqhJwUN0//Xb
         4jXManNgyvx3qmfJPzez9zLRvwbV2i7LwAvxbeR7oOrDzT9X2uR+rzNz2ADX3RRtA736
         PXiAkadwW3CDgxADqZkqcxun1ZOhCDuayIQPaao+ABfkQ0zrxU70gHY5K1pl6rRq+7K0
         x8uG0OFeJe//waqqsPBDPYlNkiBLMx4bHaL6+hVaDeFfAj54UrVpyLqbd986QdupKh+V
         fJfP399pMBCsSwl2N5eqrNKhDliNaZUro+jkWKNafE1DnuKDti+yChm5+5PNko9rEAS3
         v+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa61Eq9hzMpwnLC7yJiDCYQcE/19trjNMiykXIERQZJHWDrAuL9yF/NfRoP+j49Os7jio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLqJiLfEd/fGTcL+nD2TqlJ1KtSoxdMcsOVaTWIbaneCsE9pO
	ml73c3sbAz4/bCGH3P+f3Y0PtAgKWI97oxojE7vAAgmlTV4P4rB4m4oy93CAVXLdetmZEHz8T6i
	HqlYKqc1uNGsN2g18/eTyx7DypiapL6rHtawMPQ2V
X-Gm-Gg: ASbGncv8jvattpqk+H1hKJSXpdm78XuhZwhOB252oUNMPbI6OaIF8rPViVtkTvmzMVd
	pM2MroMdH3CpJNo5BSLQ7l/ZPZ3e8ISXWnzIs+6EZmGci0+9ns1hCCU7YYymsBH8CA6pvxPP0VJ
	fwI7AyoWEiSoRuwWQOlyH2ZkRxRN+pvIEkinVlP0w1z3uT
X-Google-Smtp-Source: AGHT+IFzJBBQmFYQ7cI3zeLxgkj3kZjv08y1P1BPNH+vs22PKstYf/pcm/7eHWqo/C7HnJCN2nOoS4/62QqjCLEYKY0=
X-Received: by 2002:a17:903:1b04:b0:22c:3cda:df11 with SMTP id
 d9443c01a7336-23ac4be08camr1874065ad.10.1751000038176; Thu, 26 Jun 2025
 21:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com> <20250417230740.86048-7-irogers@google.com>
 <aF3Vd0C-7jqZwz91@google.com>
In-Reply-To: <aF3Vd0C-7jqZwz91@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Jun 2025 21:53:45 -0700
X-Gm-Features: Ac12FXx6BrCLeEYICFnuYkeyjAzfSWOJvLC5yE48R4tIzxAMokm7LIFabW4mKME
Message-ID: <CAP-5=fV4x0q7YdeYJd6GAHXd48Qochpa-+jq5jsRJWK36v7rSA@mail.gmail.com>
Subject: Re: [PATCH v4 06/19] perf capstone: Support for dlopen-ing libcapstone.so
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 4:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Apr 17, 2025 at 04:07:27PM -0700, Ian Rogers wrote:
> > If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPORT,
> > support dlopen-ing libcapstone.so and then calling the necessary
> > functions by looking them up using dlsym. Reverse engineer the types
> > in the API using pahole, adding only what's used in the perf code or
> > necessary for the sake of struct size and alignment.
>
> I still think it's simpler to require capstone headers at build time and
> add LIBCAPSTONE_DYNAMIC=3D1 or something to support dlopen.

I agree, having a header file avoids the need to declare the header
file values. This is simpler. Can we make the build require
libcapstone and libLLVM in the same way that libtraceevent is
required? That is you have to explicitly build with NO_LIBTRACEEVENT=3D1
to get a no libtraceevent build to succeed. If we don't do this then
having LIBCAPSTONE_DYNAMIC will most likely be an unused option and
not worth carrying in the code base, I think that's sad. If we require
the libraries I don't like the idea of people arguing, "why do I need
to install libcapstone and libLLVM just to get the kernel/perf to
build now?" The non-simple, but still not very complex, approach taken
here was taken as a compromise to get the best result (a perf that
gets faster, BPF support, .. when libraries are available without
explicitly depending on them) while trying not to offend kernel
developers who are often trying to build on minimal systems.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/capstone.c | 287 ++++++++++++++++++++++++++++++++-----
> >  1 file changed, 248 insertions(+), 39 deletions(-)
> >
> > diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> > index c9845e4d8781..8d65c7a55a8b 100644
> > --- a/tools/perf/util/capstone.c
> > +++ b/tools/perf/util/capstone.c
> > @@ -11,19 +11,249 @@
> >  #include "print_insn.h"
> >  #include "symbol.h"
> >  #include "thread.h"
> > +#include <dlfcn.h>
> >  #include <fcntl.h>
> > +#include <inttypes.h>
> >  #include <string.h>
> >
> >  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> >  #include <capstone/capstone.h>
> > +#else
> > +typedef size_t csh;
> > +enum cs_arch {
> > +     CS_ARCH_ARM =3D 0,
> > +     CS_ARCH_ARM64 =3D 1,
> > +     CS_ARCH_X86 =3D 3,
> > +     CS_ARCH_SYSZ =3D 6,
> > +};
> > +enum cs_mode {
> > +     CS_MODE_ARM =3D 0,
> > +     CS_MODE_32 =3D 1 << 2,
> > +     CS_MODE_64 =3D 1 << 3,
> > +     CS_MODE_V8 =3D 1 << 6,
> > +     CS_MODE_BIG_ENDIAN =3D 1 << 31,
> > +};
> > +enum cs_opt_type {
> > +     CS_OPT_SYNTAX =3D 1,
> > +     CS_OPT_DETAIL =3D 2,
> > +};
> > +enum cs_opt_value {
> > +     CS_OPT_SYNTAX_ATT =3D 2,
> > +     CS_OPT_ON =3D 3,
> > +};
> > +enum cs_err {
> > +     CS_ERR_OK =3D 0,
> > +     CS_ERR_HANDLE =3D 3,
> > +};
> > +enum x86_op_type {
> > +     X86_OP_IMM =3D 2,
> > +     X86_OP_MEM =3D 3,
> > +};
> > +enum x86_reg {
> > +     X86_REG_RIP =3D 41,
> > +};
> > +typedef int32_t x86_avx_bcast;
> > +struct x86_op_mem {
> > +     enum x86_reg segment;
> > +     enum x86_reg base;
> > +     enum x86_reg index;
> > +     int scale;
> > +     int64_t disp;
> > +};
> > +
> > +struct cs_x86_op {
> > +     enum x86_op_type type;
> > +     union {
> > +             enum x86_reg  reg;
> > +             int64_t imm;
> > +             struct x86_op_mem mem;
> > +     };
> > +     uint8_t size;
> > +     uint8_t access;
> > +     x86_avx_bcast avx_bcast;
> > +     bool avx_zero_opmask;
> > +};
> > +struct cs_x86_encoding {
> > +     uint8_t modrm_offset;
> > +     uint8_t disp_offset;
> > +     uint8_t disp_size;
> > +     uint8_t imm_offset;
> > +     uint8_t imm_size;
> > +};
> > +typedef int32_t  x86_xop_cc;
> > +typedef int32_t  x86_sse_cc;
> > +typedef int32_t  x86_avx_cc;
> > +typedef int32_t  x86_avx_rm;
> > +struct cs_x86 {
> > +     uint8_t prefix[4];
> > +     uint8_t opcode[4];
> > +     uint8_t rex;
> > +     uint8_t addr_size;
> > +     uint8_t modrm;
> > +     uint8_t sib;
> > +     int64_t disp;
> > +     enum x86_reg sib_index;
> > +     int8_t sib_scale;
> > +     enum x86_reg sib_base;
> > +     x86_xop_cc xop_cc;
> > +     x86_sse_cc sse_cc;
> > +     x86_avx_cc avx_cc;
> > +     bool avx_sae;
> > +     x86_avx_rm avx_rm;
> > +     union {
> > +             uint64_t eflags;
> > +             uint64_t fpu_flags;
> > +     };
> > +     uint8_t op_count;
> > +     struct cs_x86_op operands[8];
> > +     struct cs_x86_encoding encoding;
> > +};
> > +struct cs_detail {
> > +     uint16_t regs_read[12];
> > +     uint8_t regs_read_count;
> > +     uint16_t regs_write[20];
> > +     uint8_t regs_write_count;
> > +     uint8_t groups[8];
> > +     uint8_t groups_count;
> > +
> > +     union {
> > +             struct cs_x86 x86;
> > +     };
> > +};
> > +struct cs_insn {
> > +     unsigned int id;
> > +     uint64_t address;
> > +     uint16_t size;
> > +     uint8_t bytes[16];
> > +     char mnemonic[32];
> > +     char op_str[160];
> > +     struct cs_detail *detail;
> > +};
> > +#endif
> > +
> > +#ifndef HAVE_LIBCAPSTONE_SUPPORT
> > +static void *perf_cs_dll_handle(void)
> > +{
> > +     static bool dll_handle_init;
> > +     static void *dll_handle;
> > +
> > +     if (!dll_handle_init) {
> > +             dll_handle_init =3D true;
> > +             dll_handle =3D dlopen("libcapstone.so", RTLD_LAZY);
> > +             if (!dll_handle)
> > +                     pr_debug("dlopen failed for libcapstone.so\n");
> > +     }
> > +     return dll_handle;
> > +}
> > +#endif
> > +
> > +static enum cs_err perf_cs_open(enum cs_arch arch, enum cs_mode mode, =
csh *handle)
> > +{
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +     return cs_open(arch, mode, handle);
> > +#else
> > +     static bool fn_init;
> > +     static enum cs_err (*fn)(enum cs_arch arch, enum cs_mode mode, cs=
h *handle);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_cs_dll_handle(), "cs_open");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for cs_open\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return CS_ERR_HANDLE;
> > +     return fn(arch, mode, handle);
> > +#endif
> > +}
> > +
> > +static enum cs_err perf_cs_option(csh handle, enum cs_opt_type type, s=
ize_t value)
> > +{
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +     return cs_option(handle, type, value);
> > +#else
> > +     static bool fn_init;
> > +     static enum cs_err (*fn)(csh handle, enum cs_opt_type type, size_=
t value);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_cs_dll_handle(), "cs_option");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for cs_option\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return CS_ERR_HANDLE;
> > +     return fn(handle, type, value);
> > +#endif
> > +}
> > +
> > +static size_t perf_cs_disasm(csh handle, const uint8_t *code, size_t c=
ode_size,
> > +                     uint64_t address, size_t count, struct cs_insn **=
insn)
> > +{
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +     return cs_disasm(handle, code, code_size, address, count, insn);
> > +#else
> > +     static bool fn_init;
> > +     static enum cs_err (*fn)(csh handle, const uint8_t *code, size_t =
code_size,
> > +                              uint64_t address, size_t count, struct c=
s_insn **insn);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_cs_dll_handle(), "cs_disasm");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for cs_disasm\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return CS_ERR_HANDLE;
> > +     return fn(handle, code, code_size, address, count, insn);
> >  #endif
> > +}
> >
> > +static void perf_cs_free(struct cs_insn *insn, size_t count)
> > +{
> >  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +     cs_free(insn, count);
> > +#else
> > +     static bool fn_init;
> > +     static void (*fn)(struct cs_insn *insn, size_t count);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_cs_dll_handle(), "cs_free");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for cs_free\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return;
> > +     fn(insn, count);
> > +#endif
> > +}
> > +
> > +static enum cs_err perf_cs_close(csh *handle)
> > +{
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +     return cs_close(handle);
> > +#else
> > +     static bool fn_init;
> > +     static enum cs_err (*fn)(csh *handle);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_cs_dll_handle(), "cs_close");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for cs_close\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return CS_ERR_HANDLE;
> > +     return fn(handle);
> > +#endif
> > +}
> > +
> >  static int capstone_init(struct machine *machine, csh *cs_handle, bool=
 is64,
> >                        bool disassembler_style)
> >  {
> > -     cs_arch arch;
> > -     cs_mode mode;
> > +     enum cs_arch arch;
> > +     enum cs_mode mode;
> >
> >       if (machine__is(machine, "x86_64") && is64) {
> >               arch =3D CS_ARCH_X86;
> > @@ -44,7 +274,7 @@ static int capstone_init(struct machine *machine, cs=
h *cs_handle, bool is64,
> >               return -1;
> >       }
> >
> > -     if (cs_open(arch, mode, cs_handle) !=3D CS_ERR_OK) {
> > +     if (perf_cs_open(arch, mode, cs_handle) !=3D CS_ERR_OK) {
> >               pr_warning_once("cs_open failed\n");
> >               return -1;
> >       }
> > @@ -56,27 +286,25 @@ static int capstone_init(struct machine *machine, =
csh *cs_handle, bool is64,
> >                * is set via annotation args
> >                */
> >               if (disassembler_style)
> > -                     cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTA=
X_ATT);
> > +                     perf_cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_=
SYNTAX_ATT);
> >               /*
> >                * Resolving address operands to symbols is implemented
> >                * on x86 by investigating instruction details.
> >                */
> > -             cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
> > +             perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
> >       }
> >
> >       return 0;
> >  }
> > -#endif
> >
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > -static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_ins=
n *insn,
> > +static size_t print_insn_x86(struct thread *thread, u8 cpumode, struct=
 cs_insn *insn,
> >                            int print_opts, FILE *fp)
> >  {
> >       struct addr_location al;
> >       size_t printed =3D 0;
> >
> >       if (insn->detail && insn->detail->x86.op_count =3D=3D 1) {
> > -             cs_x86_op *op =3D &insn->detail->x86.operands[0];
> > +             struct cs_x86_op *op =3D &insn->detail->x86.operands[0];
> >
> >               addr_location__init(&al);
> >               if (op->type =3D=3D X86_OP_IMM &&
> > @@ -94,7 +322,6 @@ static size_t print_insn_x86(struct thread *thread, =
u8 cpumode, cs_insn *insn,
> >       printed +=3D fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_st=
r);
> >       return printed;
> >  }
> > -#endif
> >
> >
> >  ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unu=
sed,
> > @@ -105,9 +332,8 @@ ssize_t capstone__fprintf_insn_asm(struct machine *=
machine __maybe_unused,
> >                                  uint64_t ip __maybe_unused, int *lenp =
__maybe_unused,
> >                                  int print_opts __maybe_unused, FILE *f=
p __maybe_unused)
> >  {
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> >       size_t printed;
> > -     cs_insn *insn;
> > +     struct cs_insn *insn;
> >       csh cs_handle;
> >       size_t count;
> >       int ret;
> > @@ -117,7 +343,7 @@ ssize_t capstone__fprintf_insn_asm(struct machine *=
machine __maybe_unused,
> >       if (ret < 0)
> >               return ret;
> >
> > -     count =3D cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
> > +     count =3D perf_cs_disasm(cs_handle, code, code_size, ip, 1, &insn=
);
> >       if (count > 0) {
> >               if (machine__normalized_is(machine, "x86"))
> >                       printed =3D print_insn_x86(thread, cpumode, &insn=
[0], print_opts, fp);
> > @@ -125,20 +351,16 @@ ssize_t capstone__fprintf_insn_asm(struct machine=
 *machine __maybe_unused,
> >                       printed =3D fprintf(fp, "%s %s", insn[0].mnemonic=
, insn[0].op_str);
> >               if (lenp)
> >                       *lenp =3D insn->size;
> > -             cs_free(insn, count);
> > +             perf_cs_free(insn, count);
> >       } else {
> >               printed =3D -1;
> >       }
> >
> > -     cs_close(&cs_handle);
> > +     perf_cs_close(&cs_handle);
> >       return printed;
> > -#else
> > -     return -1;
> > -#endif
> >  }
> >
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > -static void print_capstone_detail(cs_insn *insn, char *buf, size_t len=
,
> > +static void print_capstone_detail(struct cs_insn *insn, char *buf, siz=
e_t len,
> >                                 struct annotate_args *args, u64 addr)
> >  {
> >       int i;
> > @@ -153,7 +375,7 @@ static void print_capstone_detail(cs_insn *insn, ch=
ar *buf, size_t len,
> >               return;
> >
> >       for (i =3D 0; i < insn->detail->x86.op_count; i++) {
> > -             cs_x86_op *op =3D &insn->detail->x86.operands[i];
> > +             struct cs_x86_op *op =3D &insn->detail->x86.operands[i];
> >               u64 orig_addr;
> >
> >               if (op->type !=3D X86_OP_MEM)
> > @@ -194,9 +416,7 @@ static void print_capstone_detail(cs_insn *insn, ch=
ar *buf, size_t len,
> >               break;
> >       }
> >  }
> > -#endif
> >
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> >  struct find_file_offset_data {
> >       u64 ip;
> >       u64 offset;
> > @@ -213,9 +433,7 @@ static int find_file_offset(u64 start, u64 len, u64=
 pgoff, void *arg)
> >       }
> >       return 0;
> >  }
> > -#endif
> >
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> >  static u8 *
> >  read_symbol(const char *filename, struct map *map, struct symbol *sym,
> >           u64 *len, bool *is_64bit)
> > @@ -262,13 +480,11 @@ read_symbol(const char *filename, struct map *map=
, struct symbol *sym,
> >       free(buf);
> >       return NULL;
> >  }
> > -#endif
> >
> >  int symbol__disassemble_capstone(const char *filename __maybe_unused,
> >                                struct symbol *sym __maybe_unused,
> >                                struct annotate_args *args __maybe_unuse=
d)
> >  {
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> >       struct annotation *notes =3D symbol__annotation(sym);
> >       struct map *map =3D args->ms.map;
> >       u64 start =3D map__rip_2objdump(map, sym->start);
> > @@ -279,7 +495,7 @@ int symbol__disassemble_capstone(const char *filena=
me __maybe_unused,
> >       bool needs_cs_close =3D false;
> >       u8 *buf =3D NULL;
> >       csh handle;
> > -     cs_insn *insn =3D NULL;
> > +     struct cs_insn *insn =3D NULL;
> >       char disasm_buf[512];
> >       struct disasm_line *dl;
> >       bool disassembler_style =3D false;
> > @@ -316,7 +532,7 @@ int symbol__disassemble_capstone(const char *filena=
me __maybe_unused,
> >
> >       needs_cs_close =3D true;
> >
> > -     free_count =3D count =3D cs_disasm(handle, buf, len, start, len, =
&insn);
> > +     free_count =3D count =3D perf_cs_disasm(handle, buf, len, start, =
len, &insn);
> >       for (i =3D 0, offset =3D 0; i < count; i++) {
> >               int printed;
> >
> > @@ -355,9 +571,9 @@ int symbol__disassemble_capstone(const char *filena=
me __maybe_unused,
> >
> >  out:
> >       if (needs_cs_close) {
> > -             cs_close(&handle);
> > +             perf_cs_close(&handle);
> >               if (free_count > 0)
> > -                     cs_free(insn, free_count);
> > +                     perf_cs_free(insn, free_count);
> >       }
> >       free(buf);
> >       return count < 0 ? count : 0;
> > @@ -377,16 +593,12 @@ int symbol__disassemble_capstone(const char *file=
name __maybe_unused,
> >       }
> >       count =3D -1;
> >       goto out;
> > -#else
> > -     return -1;
> > -#endif
> >  }
> >
> >  int symbol__disassemble_capstone_powerpc(const char *filename __maybe_=
unused,
> >                                        struct symbol *sym __maybe_unuse=
d,
> >                                        struct annotate_args *args __may=
be_unused)
> >  {
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> >       struct annotation *notes =3D symbol__annotation(sym);
> >       struct map *map =3D args->ms.map;
> >       struct dso *dso =3D map__dso(map);
> > @@ -499,7 +711,7 @@ int symbol__disassemble_capstone_powerpc(const char=
 *filename __maybe_unused,
> >
> >  out:
> >       if (needs_cs_close)
> > -             cs_close(&handle);
> > +             perf_cs_close(&handle);
> >       free(buf);
> >       return count < 0 ? count : 0;
> >
> > @@ -508,7 +720,4 @@ int symbol__disassemble_capstone_powerpc(const char=
 *filename __maybe_unused,
> >               close(fd);
> >       count =3D -1;
> >       goto out;
> > -#else
> > -     return -1;
> > -#endif
> >  }
> > --
> > 2.49.0.805.g082f7c87e0-goog
> >

