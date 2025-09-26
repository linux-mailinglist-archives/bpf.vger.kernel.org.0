Return-Path: <bpf+bounces-69853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5517DBA497E
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6EA7BA629
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A9D2494F0;
	Fri, 26 Sep 2025 16:19:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0D7242D65;
	Fri, 26 Sep 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903585; cv=none; b=QoQ/0BJaCWVChiFRuL54lPX6Buic/iHQkpxsaDjKle8N8Hc6m13dn5bpIZxZncgVESFtoaHbnxwe3ePLsT0BldMF/bvHh3zA9EeCPa/mFQ1njdi0be1F6RPn2twF2Bw9VzwBs7hYVVRL8nDwA32+EvdYcDB/pZR718iC9EFeA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903585; c=relaxed/simple;
	bh=g3N28JsRJOyCJChjvaPlbQw8NwaDKl6p9+ZI6M+/NMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiIhf5aZoTg5BuYedXWI+poUi+M22QQjZW/YDh2howvWIEhk3tBCnzh/HnnOxStWyWQejHl0vGQerFTHChUGfITJak68MjCuHIg1bF7lz+bpi80LADg7Qsd54t9MNEt5AMLztRUcoJSRS7nihRfCAZk86Evnb3WiTbCc8anVcfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 598C8168F;
	Fri, 26 Sep 2025 09:19:35 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F1D13F5A1;
	Fri, 26 Sep 2025 09:19:43 -0700 (PDT)
Date: Fri, 26 Sep 2025 17:19:41 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH 4/8] perf test coresight: Dismiss clang warning for
 memcpy thread
Message-ID: <20250926161941.GG7985@e132581.arm.com>
References: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com>
 <20250925-perf_build_android_ndk-v1-4-8b35aadde3dc@arm.com>
 <CAP-5=fWGKgXV52_9E7n9yDX1uNLF8qWT9XTFK8eKtc_LRCW5wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWGKgXV52_9E7n9yDX1uNLF8qWT9XTFK8eKtc_LRCW5wg@mail.gmail.com>

On Thu, Sep 25, 2025 at 12:38:36PM -0700, Ian Rogers wrote:
> On Thu, Sep 25, 2025 at 3:26 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > clang-18.1.3 on Ubuntu 24.04.2 reports warning:
> >
> >   memcpy_thread.c:30:1: warning: non-void function does not return a value in all control paths [-Wreturn-type]
> >      30 | }
> >         | ^
> >
> > Dismiss the warning with returning NULL from the thread function.
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> lgtm, should this be moved into being a perf test workload as in
> tools/perf/tests/workloads/ ?

Now we have four programs under shell folder:

  $ cd linux/tools/perf/tests/shell
  $ find ./ -name *.c -o -name *.S
  ./coresight/unroll_loop_thread/unroll_loop_thread.c
  ./coresight/asm_pure_loop/asm_pure_loop.S
  ./coresight/thread_loop/thread_loop.c
  ./coresight/memcpy_thread/memcpy_thread.c
 
If really do this, can move all programs into folders?

  tools/perf/tests/workloads/       - Common programs
  tools/perf/tests/workloads/arm64  - Arch specific programs

Anyway, this should be a separate series to avoid complexity for
enabling Clang build.

Thanks,
Leo

