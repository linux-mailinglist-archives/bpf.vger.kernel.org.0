Return-Path: <bpf+bounces-46409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDBE9E9BEC
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 17:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47C4282F5A
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9136814C5AE;
	Mon,  9 Dec 2024 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYLYHKoP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD91487C8;
	Mon,  9 Dec 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762323; cv=none; b=bWo2CHWo1e6IAKdmn2BOn8VyQJ96yG8hs+kkbgtg06oNapIDZP/utHtYM+ZctNsRZc/bFBB8Ni64BBmThOjYF9dBH1fjlGk4jDp9d8/tbvXaYIIrhjGpPVEcykMhKxMCTlJ7Ftik8zolQnHatD55vKKdp1dROETQG/4MuqU+h80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762323; c=relaxed/simple;
	bh=UVWTHwKD+Fw7JmMRYWfbjUnkz6XfiVpmaocdz0WhB18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnZNqmeBSkr1PU7punTX9LI6hKx5+zTq9iwrfzigXFQm32Y0f2zbN3j0IM+wd4HPBj9N3+K4034Dr03dwsmI+aFTadYLSiatQuk2KHmcUE1ZLlkaV0P69fq0PxxF0JYENideoLPTExe7bVGj7uarruqsGUIwFE5btwEGYIe48i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYLYHKoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBEEC4CED1;
	Mon,  9 Dec 2024 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733762322;
	bh=UVWTHwKD+Fw7JmMRYWfbjUnkz6XfiVpmaocdz0WhB18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYLYHKoPEUb9mGJK8LKuDpRnIxMByrbTal8VuABrnsmbWozwukReQA65wkaOxyS89
	 tnkqCrPETrA3jsEmA1MwTW/+jGgHTfXepE0SbzUlm3y595WASjzsULXG9TuG2JeoNP
	 6jSuSPFsq1Z2Kwri4blNYDDVj7nWdU1jIPkq3QHpPsEz8p/YwZuumCJPf/+Ynto0t7
	 /KkxMmrNw0EPSn8k/WV2nSSwoxVAntifZQ2BkioQWQnU3udczh3cKvzsyOw/3B4h9e
	 /fX2iXEQaTHDIDl9q1OH+/JZXL8uH9vrs5EFyA5jJz/v8zhbKYMy9bd6New/OtaaAI
	 cEL8hLWeRs8Qg==
Date: Mon, 9 Dec 2024 13:38:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 2/4] perf lock contention: Run BPF slab cache iterator
Message-ID: <Z1cdDzXe4QNJe8jL@x1>
References: <20241108061500.2698340-1-namhyung@kernel.org>
 <20241108061500.2698340-3-namhyung@kernel.org>
 <Z1ccoNOl4Z8c5DCz@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1ccoNOl4Z8c5DCz@x1>

On Mon, Dec 09, 2024 at 01:36:52PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Nov 07, 2024 at 10:14:57PM -0800, Namhyung Kim wrote:
> > Recently the kernel got the kmem_cache iterator to traverse metadata of
> > slab objects.  This can be used to symbolize dynamic locks in a slab.
> > 
> > The new slab_caches hash map will have the pointer of the kmem_cache as
> > a key and save the name and a id.  The id will be saved in the flags
> > part of the lock.
> 
> Trying to fix this 

So you have that struct in tools/perf/util/bpf_skel/vmlinux/vmlinux.h,
but then, this kernel is old and doesn't have the kmem_cache iterator,
so using the generated vmlinux.h will fail the build.

- Arnaldo
 
> cd . && make GEN_VMLINUX_H=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.DWo9tIFvWU DESTDIR=/tmp/tmp.ex3iljqLBT
>   BUILD:   Doing 'make -j28' parallel build
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/drm/drm.h include/uapi/drm/drm.h
>   diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
>   diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
>   diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
>   diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
>   diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
>   diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h
>   diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
>   diff -u tools/include/uapi/asm-generic/mman.h include/uapi/asm-generic/mman.h
>   diff -u tools/perf/arch/x86/entry/syscalls/syscall_32.tbl arch/x86/entry/syscalls/syscall_32.tbl
>   diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
>   diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
>   diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
>   diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl
>   diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h include/uapi/linux/mount.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/prctl.h include/uapi/linux/prctl.h
> Makefile.config:989: No libllvm 13+ found, slower source file resolution, please install llvm-devel/llvm-dev
> Makefile.config:1171: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> 
>   GEN     /tmp/tmp.DWo9tIFvWU/common-cmds.h
>   CC      /tmp/tmp.DWo9tIFvWU/dlfilters/dlfilter-test-api-v0.o
>   CC      /tmp/tmp.DWo9tIFvWU/dlfilters/dlfilter-test-api-v2.o
>   CC      /tmp/tmp.DWo9tIFvWU/dlfilters/dlfilter-show-cycles.o
>   GEN     /tmp/tmp.DWo9tIFvWU/arch/arm64/include/generated/asm/sysreg-defs.h
>   LINK    /tmp/tmp.DWo9tIFvWU/dlfilters/dlfilter-test-api-v2.so
>   LINK    /tmp/tmp.DWo9tIFvWU/dlfilters/dlfilter-show-cycles.so
>   LINK    /tmp/tmp.DWo9tIFvWU/dlfilters/dlfilter-test-api-v0.so
>   PERF_VERSION = 6.13.rc1.g61c6ae4ddd41
>   GEN     perf-iostat
>   GEN     perf-archive
>   INSTALL /tmp/tmp.DWo9tIFvWU/libsubcmd/include/subcmd/exec-cmd.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libsubcmd/include/subcmd/help.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libsubcmd/include/subcmd/pager.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libsubcmd/include/subcmd/parse-options.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libsubcmd/include/subcmd/run-command.h
>   INSTALL libsubcmd_headers
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/perf/bpf_perf.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/perf/core.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/perf/cpumap.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/perf/threadmap.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/perf/evlist.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/perf/evsel.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/perf/event.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/perf/mmap.h
>   CC      /tmp/tmp.DWo9tIFvWU/libperf/core.o
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/internal/cpumap.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/internal/evlist.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libapi/include/api/cpu.h
>   CC      /tmp/tmp.DWo9tIFvWU/libperf/cpumap.o
>   INSTALL /tmp/tmp.DWo9tIFvWU/libsymbol/include/symbol/kallsyms.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/internal/evsel.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libapi/include/api/io.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libapi/include/api/debug.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/internal/lib.h
>   CC      /tmp/tmp.DWo9tIFvWU/libsymbol/kallsyms.o
>   CC      /tmp/tmp.DWo9tIFvWU/libperf/threadmap.o
>   GEN     /tmp/tmp.DWo9tIFvWU/libbpf/bpf_helper_defs.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/internal/mmap.h
>   MKDIR   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf
>   CC      /tmp/tmp.DWo9tIFvWU/libperf/evsel.o
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/internal/rc_check.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libapi/include/api/fd/array.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/internal/threadmap.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/bpf.h
>   CC      /tmp/tmp.DWo9tIFvWU/libperf/evlist.o
>   INSTALL /tmp/tmp.DWo9tIFvWU/libapi/include/api/fs/fs.h
>   CC      /tmp/tmp.DWo9tIFvWU/libapi/cpu.o
>   INSTALL libsymbol_headers
>   INSTALL /tmp/tmp.DWo9tIFvWU/libapi/include/api/fs/tracing_path.h
>   MKDIR   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/libbpf.h
>   CC      /tmp/tmp.DWo9tIFvWU/libperf/mmap.o
>   MKDIR   /tmp/tmp.DWo9tIFvWU/libapi/fd/
>   INSTALL /tmp/tmp.DWo9tIFvWU/libperf/include/internal/xyarray.h
>   MKDIR   /tmp/tmp.DWo9tIFvWU/libapi/fs/
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/btf.h
>   CC      /tmp/tmp.DWo9tIFvWU/libperf/zalloc.o
>   CC      /tmp/tmp.DWo9tIFvWU/libapi/debug.o
>   CC      /tmp/tmp.DWo9tIFvWU/libapi/fd/array.o
>   CC      /tmp/tmp.DWo9tIFvWU/libapi/fs/fs.o
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/libbpf_common.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/libbpf_legacy.h
>   CC      /tmp/tmp.DWo9tIFvWU/libapi/str_error_r.o
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/bpf_helpers.h
>   MKDIR   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/
>   INSTALL libperf_headers
>   INSTALL libapi_headers
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/bpf_tracing.h
>   CC      /tmp/tmp.DWo9tIFvWU/libapi/fs/tracing_path.o
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/bpf_endian.h
>   CC      /tmp/tmp.DWo9tIFvWU/libperf/xyarray.o
>   CC      /tmp/tmp.DWo9tIFvWU/libapi/fs/cgroup.o
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/bpf_core_read.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/skel_internal.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/libbpf_version.h
>   CC      /tmp/tmp.DWo9tIFvWU/libperf/lib.o
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/usdt.bpf.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/hashmap.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/relo_core.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_internal.h
>   CC      /tmp/tmp.DWo9tIFvWU/libsubcmd/help.o
>   CC      /tmp/tmp.DWo9tIFvWU/libsubcmd/exec-cmd.o
>   CC      /tmp/tmp.DWo9tIFvWU/libsubcmd/pager.o
>   CC      /tmp/tmp.DWo9tIFvWU/libsubcmd/parse-options.o
>   CC      /tmp/tmp.DWo9tIFvWU/libsubcmd/run-command.o
>   CC      /tmp/tmp.DWo9tIFvWU/libsubcmd/sigchain.o
>   CC      /tmp/tmp.DWo9tIFvWU/libsubcmd/subcmd-config.o
>   INSTALL /tmp/tmp.DWo9tIFvWU/libbpf/include/bpf/bpf_helper_defs.h
>   INSTALL libbpf_headers
>   GEN     /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/bpf_helper_defs.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/btf.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_common.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_legacy.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helpers.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_tracing.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_endian.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_core_read.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/skel_internal.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_version.h
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/usdt.bpf.h
>   LD      /tmp/tmp.DWo9tIFvWU/libapi/fd/libapi-in.o
>   LD      /tmp/tmp.DWo9tIFvWU/libsymbol/libsymbol-in.o
>   AR      /tmp/tmp.DWo9tIFvWU/libsymbol/libsymbol.a
>   LD      /tmp/tmp.DWo9tIFvWU/libapi/fs/libapi-in.o
>   INSTALL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helper_defs.h
>   INSTALL libbpf_headers
>   LD      /tmp/tmp.DWo9tIFvWU/libapi/libapi-in.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/libbpf.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/bpf.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/nlattr.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/btf.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/libbpf_errno.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/str_error.o
>   LD      /tmp/tmp.DWo9tIFvWU/libperf/libperf-in.o
>   AR      /tmp/tmp.DWo9tIFvWU/libapi/libapi.a
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/netlink.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/bpf_prog_linfo.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/libbpf_probes.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/hashmap.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/btf_dump.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/ringbuf.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/strset.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/linker.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/gen_loader.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/relo_core.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/usdt.o
>   AR      /tmp/tmp.DWo9tIFvWU/libperf/libperf.a
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/zip.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/elf.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/features.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/btf_iter.o
>   CC      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/btf_relocate.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/nlattr.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_errno.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/str_error.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/netlink.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_probes.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/hashmap.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_dump.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/ringbuf.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/strset.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/linker.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/gen_loader.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/relo_core.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/usdt.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/zip.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/elf.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/features.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_iter.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_relocate.o
>   LD      /tmp/tmp.DWo9tIFvWU/libsubcmd/libsubcmd-in.o
>   AR      /tmp/tmp.DWo9tIFvWU/libsubcmd/libsubcmd.a
>   LD      /tmp/tmp.DWo9tIFvWU/libbpf/staticobjs/libbpf-in.o
>   LINK    /tmp/tmp.DWo9tIFvWU/libbpf/libbpf.a
>   LD      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf-in.o
>   LINK    /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/main.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/common.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/json_writer.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/gen.o
>   CC      /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/btf.o
>   LINK    /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bootstrap/bpftool
>   GEN     /tmp/tmp.DWo9tIFvWU/util/bpf_skel/vmlinux.h
>   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
>   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bperf_leader.bpf.o
>   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bperf_follower.bpf.o
>   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
>   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/func_latency.bpf.o
>   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/off_cpu.bpf.o
>   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/lock_contention.bpf.o
>   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/kwork_trace.bpf.o
>   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/sample_filter.bpf.o
>   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/kwork_top.bpf.o
>   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bench_uprobe.bpf.o
>   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
>   GENSKEL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/bench_uprobe.skel.h
>   GENSKEL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/func_latency.skel.h
> util/bpf_skel/lock_contention.bpf.c:612:28: error: declaration of 'struct bpf_iter__kmem_cache' will not be visible outside of this function [-Werror,-Wvisibility]
>   612 | int slab_cache_iter(struct bpf_iter__kmem_cache *ctx)
>       |                            ^
> util/bpf_skel/lock_contention.bpf.c:614:28: error: incomplete definition of type 'struct bpf_iter__kmem_cache'
>   614 |         struct kmem_cache *s = ctx->s;
>       |                                ~~~^
> util/bpf_skel/lock_contention.bpf.c:612:28: note: forward declaration of 'struct bpf_iter__kmem_cache'
>   612 | int slab_cache_iter(struct bpf_iter__kmem_cache *ctx)
>       |                            ^
> 2 errors generated.
> make[4]: *** [Makefile.perf:1248: /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/lock_contention.bpf.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [Makefile.perf:292: sub-make] Error 2
> make[2]: *** [Makefile:76: all] Error 2
> make[1]: *** [tests/make:344: make_gen_vmlinux_h_O] Error 1
> make: *** [Makefile:109: build-test] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> 
> real	3m43.896s
> user	29m30.716s
> sys	6m36.609s
> ⬢ [acme@toolbox perf-tools-next]$ 
> 
> 
>  
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/bpf_lock_contention.c         | 50 +++++++++++++++++++
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 28 +++++++++++
> >  tools/perf/util/bpf_skel/lock_data.h          | 12 +++++
> >  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |  8 +++
> >  4 files changed, 98 insertions(+)
> > 
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> > index 41a1ad08789511c3..558590c3111390fc 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -12,12 +12,59 @@
> >  #include <linux/zalloc.h>
> >  #include <linux/string.h>
> >  #include <bpf/bpf.h>
> > +#include <bpf/btf.h>
> >  #include <inttypes.h>
> >  
> >  #include "bpf_skel/lock_contention.skel.h"
> >  #include "bpf_skel/lock_data.h"
> >  
> >  static struct lock_contention_bpf *skel;
> > +static bool has_slab_iter;
> > +
> > +static void check_slab_cache_iter(struct lock_contention *con)
> > +{
> > +	struct btf *btf = btf__load_vmlinux_btf();
> > +	s32 ret;
> > +
> > +	if (btf == NULL) {
> > +		pr_debug("BTF loading failed: %s\n", strerror(errno));
> > +		return;
> > +	}
> > +
> > +	ret = btf__find_by_name_kind(btf, "bpf_iter__kmem_cache", BTF_KIND_STRUCT);
> > +	if (ret < 0) {
> > +		bpf_program__set_autoload(skel->progs.slab_cache_iter, false);
> > +		pr_debug("slab cache iterator is not available: %d\n", ret);
> > +		goto out;
> > +	}
> > +
> > +	has_slab_iter = true;
> > +
> > +	bpf_map__set_max_entries(skel->maps.slab_caches, con->map_nr_entries);
> > +out:
> > +	btf__free(btf);
> > +}
> > +
> > +static void run_slab_cache_iter(void)
> > +{
> > +	int fd;
> > +	char buf[256];
> > +
> > +	if (!has_slab_iter)
> > +		return;
> > +
> > +	fd = bpf_iter_create(bpf_link__fd(skel->links.slab_cache_iter));
> > +	if (fd < 0) {
> > +		pr_debug("cannot create slab cache iter: %d\n", fd);
> > +		return;
> > +	}
> > +
> > +	/* This will run the bpf program */
> > +	while (read(fd, buf, sizeof(buf)) > 0)
> > +		continue;
> > +
> > +	close(fd);
> > +}
> >  
> >  int lock_contention_prepare(struct lock_contention *con)
> >  {
> > @@ -109,6 +156,8 @@ int lock_contention_prepare(struct lock_contention *con)
> >  			skel->rodata->use_cgroup_v2 = 1;
> >  	}
> >  
> > +	check_slab_cache_iter(con);
> > +
> >  	if (lock_contention_bpf__load(skel) < 0) {
> >  		pr_err("Failed to load lock-contention BPF skeleton\n");
> >  		return -1;
> > @@ -304,6 +353,7 @@ static void account_end_timestamp(struct lock_contention *con)
> >  
> >  int lock_contention_start(void)
> >  {
> > +	run_slab_cache_iter();
> >  	skel->bss->enabled = 1;
> >  	return 0;
> >  }
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > index 1069bda5d733887f..fd24ccb00faec0ba 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -100,6 +100,13 @@ struct {
> >  	__uint(max_entries, 1);
> >  } cgroup_filter SEC(".maps");
> >  
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_HASH);
> > +	__uint(key_size, sizeof(long));
> > +	__uint(value_size, sizeof(struct slab_cache_data));
> > +	__uint(max_entries, 1);
> > +} slab_caches SEC(".maps");
> > +
> >  struct rw_semaphore___old {
> >  	struct task_struct *owner;
> >  } __attribute__((preserve_access_index));
> > @@ -136,6 +143,8 @@ int perf_subsys_id = -1;
> >  
> >  __u64 end_ts;
> >  
> > +__u32 slab_cache_id;
> > +
> >  /* error stat */
> >  int task_fail;
> >  int stack_fail;
> > @@ -563,4 +572,23 @@ int BPF_PROG(end_timestamp)
> >  	return 0;
> >  }
> >  
> > +SEC("iter/kmem_cache")
> > +int slab_cache_iter(struct bpf_iter__kmem_cache *ctx)
> > +{
> > +	struct kmem_cache *s = ctx->s;
> > +	struct slab_cache_data d;
> > +
> > +	if (s == NULL)
> > +		return 0;
> > +
> > +	d.id = ++slab_cache_id << LCB_F_SLAB_ID_SHIFT;
> > +	bpf_probe_read_kernel_str(d.name, sizeof(d.name), s->name);
> > +
> > +	if (d.id >= LCB_F_SLAB_ID_END)
> > +		return 0;
> > +
> > +	bpf_map_update_elem(&slab_caches, &s, &d, BPF_NOEXIST);
> > +	return 0;
> > +}
> > +
> >  char LICENSE[] SEC("license") = "Dual BSD/GPL";
> > diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
> > index 4f0aae5483745dfa..c15f734d7fc4aecb 100644
> > --- a/tools/perf/util/bpf_skel/lock_data.h
> > +++ b/tools/perf/util/bpf_skel/lock_data.h
> > @@ -32,9 +32,16 @@ struct contention_task_data {
> >  #define LCD_F_MMAP_LOCK		(1U << 31)
> >  #define LCD_F_SIGHAND_LOCK	(1U << 30)
> >  
> > +#define LCB_F_SLAB_ID_SHIFT	16
> > +#define LCB_F_SLAB_ID_START	(1U << 16)
> > +#define LCB_F_SLAB_ID_END	(1U << 26)
> > +#define LCB_F_SLAB_ID_MASK	0x03FF0000U
> > +
> >  #define LCB_F_TYPE_MAX		(1U << 7)
> >  #define LCB_F_TYPE_MASK		0x0000007FU
> >  
> > +#define SLAB_NAME_MAX  28
> > +
> >  struct contention_data {
> >  	u64 total_time;
> >  	u64 min_time;
> > @@ -55,4 +62,9 @@ enum lock_class_sym {
> >  	LOCK_CLASS_RQLOCK,
> >  };
> >  
> > +struct slab_cache_data {
> > +	u32 id;
> > +	char name[SLAB_NAME_MAX];
> > +};
> > +
> >  #endif /* UTIL_BPF_SKEL_LOCK_DATA_H */
> > diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > index 4dcad7b682bdee9c..7b81d3173917fdb5 100644
> > --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > @@ -195,4 +195,12 @@ struct bpf_perf_event_data_kern {
> >   */
> >  struct rq {};
> >  
> > +struct kmem_cache {
> > +	const char *name;
> > +} __attribute__((preserve_access_index));
> > +
> > +struct bpf_iter__kmem_cache {
> > +	struct kmem_cache *s;
> > +} __attribute__((preserve_access_index));
> > +
> >  #endif // __VMLINUX_H
> > -- 
> > 2.47.0.277.g8800431eea-goog

