Return-Path: <bpf+bounces-35634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76E393C17A
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 14:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC1C2B226D3
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 12:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170A0199246;
	Thu, 25 Jul 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMToeNtm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FCE199E98
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909553; cv=none; b=QhaNuJK3J8yd5M1qxQgi9WRCFqvTMHjufhz+cBI8aAkkgkrF59+mkghb+4UD3tMGR1VVra1fV9H0xray4nveGhEje0AwEQAsJtj7SW1Gl3SY1+OnmhP5mh9aCBP/MUfKjP500mHfGvQFPUPTtiWK98rzDO92jB7UowgbacZ7n/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909553; c=relaxed/simple;
	bh=qM3cW0z36uEERBAFHDEiR2t1ktyWC8MSk1UZOa0s/Uk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEQZo0rZCJbvAeXD1V3rDv/5SulLjFSA1KIxTyK7u2xqjy1bkH0o+Vr3WYuVZ7DCNId8a/kBMCVtIBoQxyhCKwlko1kkSy4uBAkO2LnmufKkP+gT2ZnRTT15QROli4O+wR6YrCm9mW0vqbWn88NrPdTVFumDS1aXR4Qj8ll5Duc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMToeNtm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so1150569a12.0
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 05:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721909550; x=1722514350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YakgHT/EogMs6Hu0mtdLFl5FJZRyYmmDQG2krNitqBA=;
        b=XMToeNtmuZPRbPCn8qYTDEuXiY23fAbAUC6x5RphWbRV1KqwmGPkI6ICHhF9VIm/OT
         jDhQrWVftuaFeYCqHZ9gW7Gb6MFTl82d/kV/THptfAZ+W+Gn9VMl8iuy7pchDLqFyeCi
         lqCUhW5ghE1+Iin1CdHiirkXl9xyY7mULuPtLQQCGNA1qwUF/sIr7kl25lpOEu/aiMDs
         3Ude8eF+w+SmywnkwC5nBJE95M6jUg9G6sOOi/yR2LEAm77lBO4zuO68I56FuOfjYoOp
         7vMkYAtRq4OHl858169xM8W6Cm/+dOf7mnaSw7fbFMITbNYTLDSjid5VQzITk5Ewg6/D
         kCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909550; x=1722514350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YakgHT/EogMs6Hu0mtdLFl5FJZRyYmmDQG2krNitqBA=;
        b=qFo3PoiUg2vau1EFXO7fsOAOj8Hd0pnt6vBg0zlXY2pX7uBGQjqpRIpc3ALtSqmfxO
         2mDGyic8WiPSlIQ/gmI5N26VWcL8yr02B/hKlmJMUvFJnPCyDMR2taZ9HAOltEqZMPNl
         bV/0Lf04Y2b33xBuANIEjfPtPnqGESqKk8Q8qWhZEsATf63WcxcfPCH0vg90WY6DHN/L
         JJj10a/09K2YXUpSgUCiM4nlGbqGXflRcx7sXwhGNLN0tpeySgPyZGC1JH5Hz/ZM9Qh7
         n2rvA4p0YRHqztj3UhowTCF75wur6AnvRAYLLUgQlU+z+GZzJ5Qspv55c2TSfcvHmJ+p
         1zQA==
X-Gm-Message-State: AOJu0YxKGsO6QIZjsU6VEERyjBNp/HmVYogepor6UU4iiK1PQVgJZ979
	3kYjOOVZUKchnjP3JIHowNn+6Vjp9YvV8vGM6zF64psyM0VL/LlO
X-Google-Smtp-Source: AGHT+IF50fGKn4D3doSGhcdcnIjXr3HgZxlcwHtWNoKCcjkn4Idkpk5qXwMYYjdLLEQ63HASjizOyQ==
X-Received: by 2002:a17:906:c10b:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-a7acb9a4c37mr124112466b.43.1721909549717;
        Thu, 25 Jul 2024 05:12:29 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de47sm67115166b.67.2024.07.25.05.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:12:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Jul 2024 14:12:27 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add build ID tests
Message-ID: <ZqJBK4loBv030jj_@krava>
References: <20240724225210.545423-1-andrii@kernel.org>
 <20240724225210.545423-11-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724225210.545423-11-andrii@kernel.org>

On Wed, Jul 24, 2024 at 03:52:10PM -0700, Andrii Nakryiko wrote:
> Add a new set of tests validating behavior of capturing stack traces
> with build ID. We extend uprobe_multi target binary with ability to
> trigger uprobe (so that we can capture stack traces from it), but also
> we allow to force build ID data to be either resident or non-resident in
> memory (see also a comment about quirks of MADV_PAGEOUT).
> 
> That way we can validate that in non-sleepable context we won't get
> build ID (as expected), but with sleepable uprobes we will get that
> build ID regardless of it being physically present in memory.
> 
> Also, we add a small add-on linker script which reorders
> .note.gnu.build-id section and puts it after (big) .text section,
> putting build ID data outside of the very first page of ELF file. This
> will test all the relaxations we did in build ID parsing logic in kernel
> thanks to freader abstraction.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

one of my bpf selftests runs showed:

test_build_id:PASS:parse_build_id 0 nsec
subtest_nofault:PASS:skel_open 0 nsec
subtest_nofault:PASS:link 0 nsec
subtest_nofault:PASS:trigger_uprobe 0 nsec
subtest_nofault:PASS:res 0 nsec
subtest_nofault:FAIL:build_id_status unexpected build_id_status: actual 1 != expected 2
#42/1    build_id/nofault-paged-out:FAIL
#42/2    build_id/nofault-paged-in:OK
#42/3    build_id/sleepable:OK
#42      build_id:FAIL

I could never reproduce again.. but I wonder the the page could sneak
in before the bpf program is hit and the buildid will get parsed?

or maybe likely madvise might just ignore that:

       MADV_PAGEOUT (since Linux 5.4)
              Reclaim a given range of pages.  This is done to free up memory occupied by these pages.  If a page is anonymous, it will be swapped out.  If
              a  page  is  file-backed  and dirty, it will be written back to the backing storage.  The advice might be ignored for some pages in the range
              when it is not applicable.

jirka


> ---
>  tools/testing/selftests/bpf/Makefile          |   5 +-
>  .../selftests/bpf/prog_tests/build_id.c       | 118 ++++++++++++++++++
>  .../selftests/bpf/progs/test_build_id.c       |  31 +++++
>  tools/testing/selftests/bpf/uprobe_multi.c    |  41 ++++++
>  tools/testing/selftests/bpf/uprobe_multi.ld   |  11 ++
>  5 files changed, 204 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/build_id.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_build_id.c
>  create mode 100644 tools/testing/selftests/bpf/uprobe_multi.ld
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 888ba68e6592..fe4bca113c78 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -790,9 +790,10 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
>  
>  # Linking uprobe_multi can fail due to relocation overflows on mips.
>  $(OUTPUT)/uprobe_multi: CFLAGS += $(if $(filter mips, $(ARCH)),-mxgot)
> -$(OUTPUT)/uprobe_multi: uprobe_multi.c
> +$(OUTPUT)/uprobe_multi: uprobe_multi.c uprobe_multi.ld
>  	$(call msg,BINARY,,$@)
> -	$(Q)$(CC) $(CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
> +	$(Q)$(CC) $(CFLAGS) -Wl,-T,uprobe_multi.ld -O0 $(LDFLAGS) 	\
> +		$(filter-out %.ld,$^) $(LDLIBS) -o $@
>  
>  EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
>  	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
> diff --git a/tools/testing/selftests/bpf/prog_tests/build_id.c b/tools/testing/selftests/bpf/prog_tests/build_id.c
> new file mode 100644
> index 000000000000..8e6d3603be61
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/build_id.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +
> +#include "test_build_id.skel.h"
> +
> +static char build_id[BPF_BUILD_ID_SIZE];
> +static int build_id_sz;
> +
> +static void print_stack(struct bpf_stack_build_id *stack, int frame_cnt)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < frame_cnt; i++) {
> +		printf("FRAME #%02d: ", i);
> +		switch (stack[i].status) {
> +		case BPF_STACK_BUILD_ID_EMPTY:
> +			printf("<EMPTY>\n");
> +			break;
> +		case BPF_STACK_BUILD_ID_VALID:
> +			printf("BUILD ID = ");
> +			for (j = 0; j < BPF_BUILD_ID_SIZE; j++)
> +				printf("%02hhx", (unsigned)stack[i].build_id[j]);
> +			printf(" OFFSET = %llx", (unsigned long long)stack[i].offset);
> +			break;
> +		case BPF_STACK_BUILD_ID_IP:
> +			printf("IP = %llx", (unsigned long long)stack[i].ip);
> +			break;
> +		default:
> +			printf("UNEXPECTED STATUS %d ", stack[i].status);
> +			break;
> +		}
> +		printf("\n");
> +	}
> +}
> +
> +static void subtest_nofault(bool build_id_resident)
> +{
> +	struct test_build_id *skel;
> +	struct bpf_stack_build_id *stack;
> +	int frame_cnt;
> +
> +	skel = test_build_id__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	skel->links.uprobe_nofault = bpf_program__attach(skel->progs.uprobe_nofault);
> +	if (!ASSERT_OK_PTR(skel->links.uprobe_nofault, "link"))
> +		goto cleanup;
> +
> +	if (build_id_resident)
> +		ASSERT_OK(system("./uprobe_multi uprobe-paged-in"), "trigger_uprobe");
> +	else
> +		ASSERT_OK(system("./uprobe_multi uprobe-paged-out"), "trigger_uprobe");
> +
> +	if (!ASSERT_GT(skel->bss->res_nofault, 0, "res"))
> +		goto cleanup;
> +
> +	stack = skel->bss->stack_nofault;
> +	frame_cnt = skel->bss->res_nofault / sizeof(struct bpf_stack_build_id);
> +	if (env.verbosity >= VERBOSE_NORMAL)
> +		print_stack(stack, frame_cnt);
> +
> +	if (build_id_resident) {
> +		ASSERT_EQ(stack[0].status, BPF_STACK_BUILD_ID_VALID, "build_id_status");
> +		ASSERT_EQ(memcmp(stack[0].build_id, build_id, build_id_sz), 0, "build_id_match");
> +	} else {
> +		ASSERT_EQ(stack[0].status, BPF_STACK_BUILD_ID_IP, "build_id_status");
> +	}
> +
> +cleanup:
> +	test_build_id__destroy(skel);
> +}
> +
> +static void subtest_sleepable(void)
> +{
> +	struct test_build_id *skel;
> +	struct bpf_stack_build_id *stack;
> +	int frame_cnt;
> +
> +	skel = test_build_id__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	skel->links.uprobe_sleepable = bpf_program__attach(skel->progs.uprobe_sleepable);
> +	if (!ASSERT_OK_PTR(skel->links.uprobe_sleepable, "link"))
> +		goto cleanup;
> +
> +	/* force build ID to not be paged in */
> +	ASSERT_OK(system("./uprobe_multi uprobe-paged-out"), "trigger_uprobe");
> +
> +	if (!ASSERT_GT(skel->bss->res_sleepable, 0, "res"))
> +		goto cleanup;
> +
> +	stack = skel->bss->stack_sleepable;
> +	frame_cnt = skel->bss->res_sleepable / sizeof(struct bpf_stack_build_id);
> +	if (env.verbosity >= VERBOSE_NORMAL)
> +		print_stack(stack, frame_cnt);
> +
> +	ASSERT_EQ(stack[0].status, BPF_STACK_BUILD_ID_VALID, "build_id_status");
> +	ASSERT_EQ(memcmp(stack[0].build_id, build_id, build_id_sz), 0, "build_id_match");
> +
> +cleanup:
> +	test_build_id__destroy(skel);
> +}
> +
> +void test_build_id(void)
> +{
> +	build_id_sz = read_build_id("uprobe_multi", build_id, sizeof(build_id));
> +	ASSERT_EQ(build_id_sz, BPF_BUILD_ID_SIZE, "parse_build_id");
> +
> +	if (test__start_subtest("nofault-paged-out"))
> +		subtest_nofault(false /* not resident */);
> +	if (test__start_subtest("nofault-paged-in"))
> +		subtest_nofault(true /* resident */);
> +	if (test__start_subtest("sleepable"))
> +		subtest_sleepable();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_build_id.c b/tools/testing/selftests/bpf/progs/test_build_id.c
> new file mode 100644
> index 000000000000..32ce59f9aa27
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_build_id.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +struct bpf_stack_build_id stack_sleepable[128];
> +int res_sleepable;
> +
> +struct bpf_stack_build_id stack_nofault[128];
> +int res_nofault;
> +
> +SEC("uprobe.multi/./uprobe_multi:uprobe")
> +int uprobe_nofault(struct pt_regs *ctx)
> +{
> +	res_nofault = bpf_get_stack(ctx, stack_nofault, sizeof(stack_nofault),
> +				    BPF_F_USER_STACK | BPF_F_USER_BUILD_ID);
> +
> +	return 0;
> +}
> +
> +SEC("uprobe.multi.s/./uprobe_multi:uprobe")
> +int uprobe_sleepable(struct pt_regs *ctx)
> +{
> +	res_sleepable = bpf_get_stack(ctx, stack_sleepable, sizeof(stack_sleepable),
> +				      BPF_F_USER_STACK | BPF_F_USER_BUILD_ID);
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
> index 7ffa563ffeba..c7828b13e5ff 100644
> --- a/tools/testing/selftests/bpf/uprobe_multi.c
> +++ b/tools/testing/selftests/bpf/uprobe_multi.c
> @@ -2,8 +2,21 @@
>  
>  #include <stdio.h>
>  #include <string.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
>  #include <sdt.h>
>  
> +#ifndef MADV_POPULATE_READ
> +#define MADV_POPULATE_READ 22
> +#endif
> +
> +int __attribute__((weak)) uprobe(void)
> +{
> +	return 0;
> +}
> +
>  #define __PASTE(a, b) a##b
>  #define PASTE(a, b) __PASTE(a, b)
>  
> @@ -75,6 +88,30 @@ static int usdt(void)
>  	return 0;
>  }
>  
> +extern char build_id_start[];
> +extern char build_id_end[];
> +
> +int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
> +{
> +	int page_sz = sysconf(_SC_PAGESIZE);
> +	void *addr;
> +
> +	/* page-align build ID start */
> +	addr = (void *)((uintptr_t)&build_id_start & ~(page_sz - 1));
> +
> +	/* to guarantee MADV_PAGEOUT work reliably, we need to ensure that
> +	 * memory range is mapped into current process, so we unconditionally
> +	 * do MADV_POPULATE_READ, and then MADV_PAGEOUT, if necessary
> +	 */
> +	madvise(addr, page_sz, MADV_POPULATE_READ);
> +	if (!build_id_resident)
> +		madvise(addr, page_sz, MADV_PAGEOUT);
> +
> +	(void)uprobe();
> +
> +	return 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	if (argc != 2)
> @@ -84,6 +121,10 @@ int main(int argc, char **argv)
>  		return bench();
>  	if (!strcmp("usdt", argv[1]))
>  		return usdt();
> +	if (!strcmp("uprobe-paged-out", argv[1]))
> +		return trigger_uprobe(false /* page-out build ID */);
> +	if (!strcmp("uprobe-paged-in", argv[1]))
> +		return trigger_uprobe(true /* page-in build ID */);
>  
>  error:
>  	fprintf(stderr, "usage: %s <bench|usdt>\n", argv[0]);
> diff --git a/tools/testing/selftests/bpf/uprobe_multi.ld b/tools/testing/selftests/bpf/uprobe_multi.ld
> new file mode 100644
> index 000000000000..a2e94828bc8c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/uprobe_multi.ld
> @@ -0,0 +1,11 @@
> +SECTIONS
> +{
> +	. = ALIGN(4096);
> +	.note.gnu.build-id : { *(.note.gnu.build-id) }
> +	. = ALIGN(4096);
> +}
> +INSERT AFTER .text;
> +
> +build_id_start = ADDR(.note.gnu.build-id);
> +build_id_end = ADDR(.note.gnu.build-id) + SIZEOF(.note.gnu.build-id);
> +
> -- 
> 2.43.0
> 
> 

