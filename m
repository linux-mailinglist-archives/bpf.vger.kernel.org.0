Return-Path: <bpf+bounces-48450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFC5A08194
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A44816941A
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A921FF7B9;
	Thu,  9 Jan 2025 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWvKKMjG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82C84039;
	Thu,  9 Jan 2025 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455782; cv=none; b=h6DMkQngE7ZRRKjCTtNCwr+Zzmvi47OBqi2NlE2+BQlrHRE0EnwX5L21djHeiflwa2ECtloYf5uS0YaHdmw19buEDOS/m+bdxIH0ZphHC9ZNNGe8I0wUt2bsVtQDNFH8CBuVp1xwKX0JGivT5hNwuJ/mEt2psMlhy3f9/0u3ULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455782; c=relaxed/simple;
	bh=ZXX4c3x7gBrrsmjeXcEhCbYQD0RNFq9SKOTJyfD+w8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz+D+orQkN6J3Wwljwu8kiLR73aocMAc9zQ+onLxbT9FpngCR73Dp+KpA2erRaEP4os3T+C34OnAMsB1rnHA8GHlkhRIMBwQhzsUjBHkys/KAIHUPZC2qljedNoCVCovpTDBxYqz2xtvd6ezwEASAYj40EZtHbP1L3Q9Hsar0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWvKKMjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA63C4CED2;
	Thu,  9 Jan 2025 20:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736455782;
	bh=ZXX4c3x7gBrrsmjeXcEhCbYQD0RNFq9SKOTJyfD+w8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWvKKMjG4qNcEdVbxpmuI7b4+HbBdLkpA+CAMEMYEpRiDciCf4+vEIw2Q4+w2yjfZ
	 jTvxs8jEmA05UEDVWAXXpjNc2VtZiEIpRu70xTvqCcsKpRbzaHI1lWSmw7CNxREs+Y
	 tcF2kH3OJnCH5l1gN7nYB+GygB7QcjZAbUF8tBCsIpAxeJJlhSo8SgcHZCtTgRw+5b
	 PAoxrRVlGEHzJLN9Oucuu/ShuUtvjHD6sfNGb0+TMeUfZJg8u1/VX1eDTtxpj2kfwH
	 2u7OfDHS4bABbNg/V0Xml60Go/or9ECQsio/b80eE3ZedaBdcLgKM5LgnvvFLc9HZ/
	 2p9f4xhFqpurg==
Date: Thu, 9 Jan 2025 17:49:39 -0300
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
Message-ID: <Z4A2Y269Ffo0ERkS@x1>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
 <Z3_ybwWW3QZvJ4V6@x1>
 <Z4AoFA974kauIJ9T@ghost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4AoFA974kauIJ9T@ghost>

On Thu, Jan 09, 2025 at 11:48:36AM -0800, Charlie Jenkins wrote:
> On Thu, Jan 09, 2025 at 12:59:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > ⬢ [acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
> > d06826160a982494 (HEAD -> perf-tools-next) perf tools: Remove dependency on libaudit
> > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> > - tarpkg: ./tests/perf-targz-src-pkg .
> >                  make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j28  DESTDIR=/tmp/tmp.JJT3tvN7bV
> >               make_with_gtk2: cd . && make GTK2=1 -j28  DESTDIR=/tmp/tmp.BF53V2qpl3
> > - /home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . && make FEATURE_DUMP_COPY=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
> > cd . && make FEATURE_DUMP_COPY=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
> >          make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.KZuQ0q2Vs6 DESTDIR=/tmp/tmp.0sxMyH91gS
> >            make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.Y0Mx3KLREI DESTDIR=/tmp/tmp.wg9HCVVLHE
> >               make_install_O: cd . && make install FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.P0LEBAkW1X DESTDIR=/tmp/tmp.agTavZndFN
> >   failed to find: etc/bash_completion.d/perf
> 
> Is this something introduced by this patch?

I don't think so.

BTW this series is already pushed out to perf-tools-next:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next

Thanks!

- Arnaldo

