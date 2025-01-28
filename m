Return-Path: <bpf+bounces-49984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE426A21400
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 23:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D733A810E
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 22:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6F71DEFDD;
	Tue, 28 Jan 2025 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0vTbBHF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB0195B1A
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102430; cv=none; b=jw22l85JQngDOHGpIL8AfR8rAffceCFAaCW7OWxitHGMvfDVPaK8JPe4O59hFA7F+HookoY7tKuLFb9Y4OQkfpeTAmzlbiQguLa0AFUav7dbcha0kicmbjm7ZR9yWrGhorxuXkiHDzSugq6BR2t7AIjCbBtBbh2usuHLRdg4wpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102430; c=relaxed/simple;
	bh=dO9ZCyygnXOpXUvF7ypy5pMNcV/gvAlVBlFjk12hksM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuLPDpy1ANXAt5agqNMff/sGlos3g5mfQJLpmNs1S44J4yRGDOAhcdvKwtcq2S6DNkWEtdhLAAeEZfpSGNaBMkph9aDcAsqxpROg9Gsu8K4ZlZ0gRRUHxdciuWMvnhza0EXMqXQtz1YsFgabBBPRcPmOCg29+luASfgbYFrUK40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0vTbBHF; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso177005ab.1
        for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738102428; x=1738707228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0/fm5ppJZe9x1luK50N4ncG1x+Av8TN6lNMic4niRo=;
        b=k0vTbBHFL3noHY/G7RDvfcJl08ih6d6hKGwVvH5AMynxgBRzOWXDEkQE1OmiBb6WlG
         ftMKTeURR/QchOH1lEtMzbtSDaB1hh3SloOLae/nKS9TNUTWrk9vNOYbQtDgK6GBKxse
         MzuQd/V1m1bvn2RgjG3xb3pvf/xPBb8f3n5VdvOhcjSneqMPh1D4gKXQYPJkpfwdOBjg
         a6auz4EyP60CtleHu2g6yufh6rkk/HA6dD9wGB/chp7lD++UWHn5LixechjnWj7w6NFg
         iKQWgwbHYTL02h8KnvId8lqinKRcSKtVFppZ9nXAXbs4GpOUrD51Dm9oAWlo/RuMDc5k
         rDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738102428; x=1738707228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0/fm5ppJZe9x1luK50N4ncG1x+Av8TN6lNMic4niRo=;
        b=MzhuQFCUmpaWKNZwR4ToE0rZDVG4P2LLShEy0E07o/ogbXtB7Lu6M8/VVGztqYcm8P
         R7qVrTa8wykLrFE7Tq491XWLM3PSmarXg6bPXNpMAJnz1+tnvi2ZvfQjq6nU6bxKIoH8
         VobhiYWYiPaTdsmtj1K4uEL7S/Nav4HIWRtij/U3CO/4+rjGnCcCEUIZaSxO11XCtFm/
         kjLcI91dJ8Ydo8m6fUmlH33/BcO+mlVvxsSTriv7DsoasHV8LmNLV0fuMn9EP/wVVTCa
         V7EHiXzJ+N7p01Nx6vgc6hP1Y1on0PLlbzmGP+oqGpR5OBa4Yx6TwotujVF269zKjenh
         Xmgg==
X-Forwarded-Encrypted: i=1; AJvYcCXuIsbAszBhl9jTCJsmJYkItP/yKj8CoRW3cQja064rY37aZQH5o0wypwO1tSwgFa8fSnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqDWaGvj0EXepIVAVV9P4Owhj/6XxHQhyGF2d95wkrI+L0GCJl
	QuhO73Eza7//rwUswhjgryrtVUhzawfXSuOUEGD7OvVYeSizz8FLqtauB7KkeMA6duqX2FZOwu/
	/tMXzDgzOp7EZnDQ9GPeIfglySzXgEC68QwQk
X-Gm-Gg: ASbGnctxnRo2QVIdGXBH8l4aZ4JBCvwGW500NBW3II7erHXWiYWp1KmSqomOlRJ9gVC
	AMLCjgfqAXDhGd/XCLoXwLBpPKhGpILVukKkhkG6dCEe3BsjgggQN6BgeKpTPThwZBcan88mP7F
	VjZNKxVIqnMZTZ5iCSUS7AMHq1
X-Google-Smtp-Source: AGHT+IG5O8kMTFGg8+3AMpRu00WPjpI8yVhb5W2sG+p5xzckAy6NSWNUUv5Hw6Mwr7iV1RTj91wp+OhDG36JIahS4zQ=
X-Received: by 2002:a05:6e02:1a81:b0:3a7:9082:50f6 with SMTP id
 e9e14a558f8ab-3cffebfbf82mr921435ab.22.1738102427752; Tue, 28 Jan 2025
 14:13:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com> <20250122174308.350350-7-irogers@google.com>
 <Z5QSm-w0efS9xh47@google.com> <CAP-5=fWNy8CM8nKOAH=aXyNKg5h4U4vWfB92io_T5KpCsSgv9Q@mail.gmail.com>
 <Z5lE2MC0wh3WDVnX@google.com>
In-Reply-To: <Z5lE2MC0wh3WDVnX@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Jan 2025 14:13:35 -0800
X-Gm-Features: AWEUYZlQoDNnKUXkgwM_qpFO73pe1Vj7qeUlHF7SA4oVUY_xzCMvBhXWlFmqKFs
Message-ID: <CAP-5=fXL0hXFT+t6gHp2RFd4dKnebSkd+rewudpmdentKGPURw@mail.gmail.com>
Subject: Re: [PATCH v3 06/18] perf capstone: Support for dlopen-ing libcapstone.so
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
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

On Tue, Jan 28, 2025 at 12:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, Jan 24, 2025 at 09:20:15PM -0800, Ian Rogers wrote:
> > On Fri, Jan 24, 2025 at 2:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, Jan 22, 2025 at 09:42:56AM -0800, Ian Rogers wrote:
> > > > If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPO=
RT,
> > > > support dlopen-ing libcapstone.so and then calling the necessary
> > > > functions by looking them up using dlsym. Reverse engineer the type=
s
> > > > in the API using pahole, adding only what's used in the perf code o=
r
> > > > necessary for the sake of struct size and alignment.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/capstone.c | 287 ++++++++++++++++++++++++++++++++-=
----
> > > >  1 file changed, 248 insertions(+), 39 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.=
c
> > > > index c9845e4d8781..8d65c7a55a8b 100644
> > > > --- a/tools/perf/util/capstone.c
> > > > +++ b/tools/perf/util/capstone.c
> > > > @@ -11,19 +11,249 @@
> > > >  #include "print_insn.h"
> > > >  #include "symbol.h"
> > > >  #include "thread.h"
> > > > +#include <dlfcn.h>
> > > >  #include <fcntl.h>
> > > > +#include <inttypes.h>
> > >
> > > These two can go under #else (!HAVE_LIBCAPSTONE_SUPPORT).
> >
> > Ack.
> >
> > > >  #include <string.h>
> > > >
> > > >  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> > > >  #include <capstone/capstone.h>
> > > > +#else
> > > > +typedef size_t csh;
> > > > +enum cs_arch {
> > > > +     CS_ARCH_ARM =3D 0,
> > > > +     CS_ARCH_ARM64 =3D 1,
> > > > +     CS_ARCH_X86 =3D 3,
> > > > +     CS_ARCH_SYSZ =3D 6,
> > > > +};
> > > > +enum cs_mode {
> > > > +     CS_MODE_ARM =3D 0,
> > > > +     CS_MODE_32 =3D 1 << 2,
> > > > +     CS_MODE_64 =3D 1 << 3,
> > > > +     CS_MODE_V8 =3D 1 << 6,
> > > > +     CS_MODE_BIG_ENDIAN =3D 1 << 31,
> > > > +};
> > > > +enum cs_opt_type {
> > > > +     CS_OPT_SYNTAX =3D 1,
> > > > +     CS_OPT_DETAIL =3D 2,
> > > > +};
> > > > +enum cs_opt_value {
> > > > +     CS_OPT_SYNTAX_ATT =3D 2,
> > > > +     CS_OPT_ON =3D 3,
> > > > +};
> > > > +enum cs_err {
> > > > +     CS_ERR_OK =3D 0,
> > > > +     CS_ERR_HANDLE =3D 3,
> > > > +};
> > > > +enum x86_op_type {
> > > > +     X86_OP_IMM =3D 2,
> > > > +     X86_OP_MEM =3D 3,
> > > > +};
> > > > +enum x86_reg {
> > > > +     X86_REG_RIP =3D 41,
> > > > +};
> > > > +typedef int32_t x86_avx_bcast;
> > > > +struct x86_op_mem {
> > > > +     enum x86_reg segment;
> > > > +     enum x86_reg base;
> > > > +     enum x86_reg index;
> > > > +     int scale;
> > > > +     int64_t disp;
> > > > +};
> > > > +
> > > > +struct cs_x86_op {
> > > > +     enum x86_op_type type;
> > > > +     union {
> > > > +             enum x86_reg  reg;
> > > > +             int64_t imm;
> > > > +             struct x86_op_mem mem;
> > > > +     };
> > > > +     uint8_t size;
> > > > +     uint8_t access;
> > > > +     x86_avx_bcast avx_bcast;
> > > > +     bool avx_zero_opmask;
> > > > +};
> > > > +struct cs_x86_encoding {
> > > > +     uint8_t modrm_offset;
> > > > +     uint8_t disp_offset;
> > > > +     uint8_t disp_size;
> > > > +     uint8_t imm_offset;
> > > > +     uint8_t imm_size;
> > > > +};
> > > > +typedef int32_t  x86_xop_cc;
> > > > +typedef int32_t  x86_sse_cc;
> > > > +typedef int32_t  x86_avx_cc;
> > > > +typedef int32_t  x86_avx_rm;
> > > > +struct cs_x86 {
> > > > +     uint8_t prefix[4];
> > > > +     uint8_t opcode[4];
> > > > +     uint8_t rex;
> > > > +     uint8_t addr_size;
> > > > +     uint8_t modrm;
> > > > +     uint8_t sib;
> > > > +     int64_t disp;
> > > > +     enum x86_reg sib_index;
> > > > +     int8_t sib_scale;
> > > > +     enum x86_reg sib_base;
> > > > +     x86_xop_cc xop_cc;
> > > > +     x86_sse_cc sse_cc;
> > > > +     x86_avx_cc avx_cc;
> > > > +     bool avx_sae;
> > > > +     x86_avx_rm avx_rm;
> > > > +     union {
> > > > +             uint64_t eflags;
> > > > +             uint64_t fpu_flags;
> > > > +     };
> > > > +     uint8_t op_count;
> > > > +     struct cs_x86_op operands[8];
> > > > +     struct cs_x86_encoding encoding;
> > > > +};
> > > > +struct cs_detail {
> > > > +     uint16_t regs_read[12];
> > > > +     uint8_t regs_read_count;
> > > > +     uint16_t regs_write[20];
> > > > +     uint8_t regs_write_count;
> > > > +     uint8_t groups[8];
> > > > +     uint8_t groups_count;
> > > > +
> > > > +     union {
> > > > +             struct cs_x86 x86;
> > > > +     };
> > > > +};
> > >
> > > As discussed, let's remove the detail part.
> >
> > I kind of feel there should be a #warning in that case. I'd rather
> > leave it as is and not have a build warning.
>
> What kind of build warning are you talking about?

If we don't feature detect capstone then we'll switch to dlopen. If we
remove detail as a consequence of that then it feels like it should
have a warning. The warning could either be in Makefile.config or a
#warning in the code.

Thanks,
Ian

