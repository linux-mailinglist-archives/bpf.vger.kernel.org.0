Return-Path: <bpf+bounces-49981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFF1A2135D
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 21:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737F9163AB1
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E591E98FD;
	Tue, 28 Jan 2025 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWzsL7ap"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603B1DED68;
	Tue, 28 Jan 2025 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738097883; cv=none; b=Bf7gzd/eKrJr2jK732+bixsGVO+dKds5b/DfdH69KQiyd3u5hofwmgQK9DzAuIs3OdmpMuanTDUv0+pE6es+QA+S0Vj3f+FfPYWdUwwKrF1bcZatMS0isTMbYrFbvUqFJmyUlAd792/We/YnDc7olGDC3RCgxi1t7UFQ1X/1EB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738097883; c=relaxed/simple;
	bh=a96zUL8woR/oDc/KLnuutHpBtiL9Sc2/WwWTwdHbXbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi6BEObRsqTyk/JNNKRLydZJNGyKWxLOA6NkEGX2yy/xQk3nz6x4fAlqA+fPtPk3HHTskplUoHgl88qmnsj4gLDDIeP7MwcSdGD23sAHQpEb5kWAFs/qbjlIZc1eh8Y2uFTob0b6wH82N53deiRWzIISz3BKe5FaM6pFLdKabUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWzsL7ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210C0C4CEE1;
	Tue, 28 Jan 2025 20:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738097883;
	bh=a96zUL8woR/oDc/KLnuutHpBtiL9Sc2/WwWTwdHbXbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWzsL7apgXFCF33hgtqZqklxfO55L7C/q2hmlt+bCrLkLRIaIKHXYtSwfu9BjpBEl
	 N14hmdHeJbeuAIaCJY5JDIWm7BHQk/XVzD6btA10nQQKw0lK89hR/RCD92xuW1KkRb
	 ooL9KIJ4nIRroQPN3XCPBHx44vSTSPfperDQl4IhdMSfcyCJEmHccmeyK6iRTGvgvE
	 8eeH6qcQgRWXKz9rfHZGSukacSv6d8cyeQ03QeIuLro6g4jZK9mvdtCiSFvoC/n1bh
	 97SGvaQ0rntN40M32HyM2Tb+P5UsYGTrA41W9xVcldQkmRq/18YKq9aYAutl9xYUAx
	 hleKC7EYtsOoA==
Date: Tue, 28 Jan 2025 12:58:00 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Changbin Du <changbin.du@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 06/18] perf capstone: Support for dlopen-ing
 libcapstone.so
Message-ID: <Z5lE2MC0wh3WDVnX@google.com>
References: <20250122174308.350350-1-irogers@google.com>
 <20250122174308.350350-7-irogers@google.com>
 <Z5QSm-w0efS9xh47@google.com>
 <CAP-5=fWNy8CM8nKOAH=aXyNKg5h4U4vWfB92io_T5KpCsSgv9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWNy8CM8nKOAH=aXyNKg5h4U4vWfB92io_T5KpCsSgv9Q@mail.gmail.com>

On Fri, Jan 24, 2025 at 09:20:15PM -0800, Ian Rogers wrote:
> On Fri, Jan 24, 2025 at 2:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Jan 22, 2025 at 09:42:56AM -0800, Ian Rogers wrote:
> > > If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPORT,
> > > support dlopen-ing libcapstone.so and then calling the necessary
> > > functions by looking them up using dlsym. Reverse engineer the types
> > > in the API using pahole, adding only what's used in the perf code or
> > > necessary for the sake of struct size and alignment.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/capstone.c | 287 ++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 248 insertions(+), 39 deletions(-)
> > >
> > > diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> > > index c9845e4d8781..8d65c7a55a8b 100644
> > > --- a/tools/perf/util/capstone.c
> > > +++ b/tools/perf/util/capstone.c
> > > @@ -11,19 +11,249 @@
> > >  #include "print_insn.h"
> > >  #include "symbol.h"
> > >  #include "thread.h"
> > > +#include <dlfcn.h>
> > >  #include <fcntl.h>
> > > +#include <inttypes.h>
> >
> > These two can go under #else (!HAVE_LIBCAPSTONE_SUPPORT).
> 
> Ack.
> 
> > >  #include <string.h>
> > >
> > >  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> > >  #include <capstone/capstone.h>
> > > +#else
> > > +typedef size_t csh;
> > > +enum cs_arch {
> > > +     CS_ARCH_ARM = 0,
> > > +     CS_ARCH_ARM64 = 1,
> > > +     CS_ARCH_X86 = 3,
> > > +     CS_ARCH_SYSZ = 6,
> > > +};
> > > +enum cs_mode {
> > > +     CS_MODE_ARM = 0,
> > > +     CS_MODE_32 = 1 << 2,
> > > +     CS_MODE_64 = 1 << 3,
> > > +     CS_MODE_V8 = 1 << 6,
> > > +     CS_MODE_BIG_ENDIAN = 1 << 31,
> > > +};
> > > +enum cs_opt_type {
> > > +     CS_OPT_SYNTAX = 1,
> > > +     CS_OPT_DETAIL = 2,
> > > +};
> > > +enum cs_opt_value {
> > > +     CS_OPT_SYNTAX_ATT = 2,
> > > +     CS_OPT_ON = 3,
> > > +};
> > > +enum cs_err {
> > > +     CS_ERR_OK = 0,
> > > +     CS_ERR_HANDLE = 3,
> > > +};
> > > +enum x86_op_type {
> > > +     X86_OP_IMM = 2,
> > > +     X86_OP_MEM = 3,
> > > +};
> > > +enum x86_reg {
> > > +     X86_REG_RIP = 41,
> > > +};
> > > +typedef int32_t x86_avx_bcast;
> > > +struct x86_op_mem {
> > > +     enum x86_reg segment;
> > > +     enum x86_reg base;
> > > +     enum x86_reg index;
> > > +     int scale;
> > > +     int64_t disp;
> > > +};
> > > +
> > > +struct cs_x86_op {
> > > +     enum x86_op_type type;
> > > +     union {
> > > +             enum x86_reg  reg;
> > > +             int64_t imm;
> > > +             struct x86_op_mem mem;
> > > +     };
> > > +     uint8_t size;
> > > +     uint8_t access;
> > > +     x86_avx_bcast avx_bcast;
> > > +     bool avx_zero_opmask;
> > > +};
> > > +struct cs_x86_encoding {
> > > +     uint8_t modrm_offset;
> > > +     uint8_t disp_offset;
> > > +     uint8_t disp_size;
> > > +     uint8_t imm_offset;
> > > +     uint8_t imm_size;
> > > +};
> > > +typedef int32_t  x86_xop_cc;
> > > +typedef int32_t  x86_sse_cc;
> > > +typedef int32_t  x86_avx_cc;
> > > +typedef int32_t  x86_avx_rm;
> > > +struct cs_x86 {
> > > +     uint8_t prefix[4];
> > > +     uint8_t opcode[4];
> > > +     uint8_t rex;
> > > +     uint8_t addr_size;
> > > +     uint8_t modrm;
> > > +     uint8_t sib;
> > > +     int64_t disp;
> > > +     enum x86_reg sib_index;
> > > +     int8_t sib_scale;
> > > +     enum x86_reg sib_base;
> > > +     x86_xop_cc xop_cc;
> > > +     x86_sse_cc sse_cc;
> > > +     x86_avx_cc avx_cc;
> > > +     bool avx_sae;
> > > +     x86_avx_rm avx_rm;
> > > +     union {
> > > +             uint64_t eflags;
> > > +             uint64_t fpu_flags;
> > > +     };
> > > +     uint8_t op_count;
> > > +     struct cs_x86_op operands[8];
> > > +     struct cs_x86_encoding encoding;
> > > +};
> > > +struct cs_detail {
> > > +     uint16_t regs_read[12];
> > > +     uint8_t regs_read_count;
> > > +     uint16_t regs_write[20];
> > > +     uint8_t regs_write_count;
> > > +     uint8_t groups[8];
> > > +     uint8_t groups_count;
> > > +
> > > +     union {
> > > +             struct cs_x86 x86;
> > > +     };
> > > +};
> >
> > As discussed, let's remove the detail part.
> 
> I kind of feel there should be a #warning in that case. I'd rather
> leave it as is and not have a build warning.

What kind of build warning are you talking about?

Thanks,
Namhyung


