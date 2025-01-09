Return-Path: <bpf+bounces-48477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A43BA08276
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DD2188947D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8930E205AA2;
	Thu,  9 Jan 2025 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6JeSpPB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC62054E9;
	Thu,  9 Jan 2025 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459470; cv=none; b=gidaUPS3nDXTlibaKg/mOCc8UqshBpkgXWVreBdlqAJfRuOPESkNNvOIMbDvGygXA90sL67QmnTeT97XnkVjRWx5pD2PPlewkMaxf+scQbcMZTEvai08yVxN4V4WtHsEPmAJGg93MhfyDeEOtI4Nedegx+EoBdGaE824hrVXraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459470; c=relaxed/simple;
	bh=0x1L7px6GPDuN8m2XYejKWaY2IIWooxoAEoHV0V6Woc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX7/WOpXEYxjyh925YT8dzuGyErCwHp5J6gUK8ogsYFgf3r3UnhBP+WTOA1WOErogFC/Rle35ZzvlW8QjSGzpw+pLPQtFQ6F+fyLbTtodCggzhiCehq4frcDueR129wf+KrNfkqBC3+ujIWRNtFpFcyjyJRgBgSa4lV3Oi1fBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6JeSpPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C59C4CEE5;
	Thu,  9 Jan 2025 21:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736459469;
	bh=0x1L7px6GPDuN8m2XYejKWaY2IIWooxoAEoHV0V6Woc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6JeSpPBmvIKVy1aiaXseMKmL48kdpl1zcK4ql1QqBBn+kNNyPLZPO8aZme2NZukJ
	 YiCoQBT5HTYD0iErWGTusMGjWgIH6e1GmDPgrYDXxcCw4ib6o9fahInGGItWRgUuRP
	 bnxJ5ZHSeOgCFNb32NdoIMI8VQnfDI+s6pSm6K4MuFkYmKLZRnELrBi6jHur+Px00N
	 IHoRP0b/+Xkt86vziXDu55mu0FCOklUTrpqtiQ/py3BKro3MOUtLcrtH/HK89y8gIU
	 +FZ88rpN8hQRVkhT+pFUTbMWc0B9oYpxGwxUiPD7B3HGahhHMuNE3eSyckDn76exf7
	 czOJNAWpptSPw==
Date: Thu, 9 Jan 2025 18:51:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 00/16] perf tools: Use generic syscall scripts for all
 archs
Message-ID: <Z4BEygdXmofWBr0-@x1>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
 <Z3_ybwWW3QZvJ4V6@x1>
 <Z4AoFA974kauIJ9T@ghost>
 <Z4A2Y269Ffo0ERkS@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4A2Y269Ffo0ERkS@x1>

On Thu, Jan 09, 2025 at 05:49:42PM -0300, Arnaldo Carvalho de Melo wrote:
> BTW this series is already pushed out to perf-tools-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next

Hey, now I noticed that with this latest version we see:

⬢ [acme@toolbox perf-tools-next]$ m
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j28' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

   /home/acme/git/perf-tools-next/tools/perf/scripts/syscalltbl.sh  --abis common,32,i386 /home/acme/git/perf-tools-next/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_32.h
   /home/acme/git/perf-tools-next/tools/perf/scripts/syscalltbl.sh  --abis common,64 /home/acme/git/perf-tools-next/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_64.h
  GEN     /tmp/build/perf-tools-next/common-cmds.h
  GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
  PERF_VERSION = 6.13.rc2.gd73982c39183
  GEN     perf-archive
  GEN     perf-iostat
  MKDIR   /tmp/build/perf-tools-next/jvmti/
  MKDIR   /tmp/build/perf-tools-next/jvmti/
  MKDIR   /tmp/build/perf-tools-next/jvmti/
  MKDIR   /tmp/build/perf-tools-next/jvmti/


While with the previous one we would see something like SYSCALLTBL as
the step name, like we have GEN, MKDIR, etc, can you take a look?

All is out there in perf-tools-next.

- Arnaldo

