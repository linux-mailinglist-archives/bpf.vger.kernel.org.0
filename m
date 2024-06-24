Return-Path: <bpf+bounces-32956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285DA9159D8
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98125B22A2E
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 22:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E421A0B1F;
	Mon, 24 Jun 2024 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmN/u75H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35E17BCC;
	Mon, 24 Jun 2024 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267983; cv=none; b=GVheupaHmJ0NYJt3ftQ0uuVkduApM4hshuwYEEx0vg8OSlqcCj9LZ6AcZpFB/5Cl1xkxIIVJD+pP2TPeAV9vAki7EzDw78e8ElDb/I+OxY22QNy6wN+moqO1zlKnSL9a1sKOWMAVkmNH1jJu0gNPbBfTJBZh4LGcwnPlp5ZCd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267983; c=relaxed/simple;
	bh=A1zw7pChb50vCYHTi+cKNPAO0Oryfwi6Z4lff+lI6Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKAGX2JCTjOIoQXSUTtYynY3NkgNtQ/DFoafOModyF6Fqlc+qkWwOEdWvUAtVBqv+uDcF/A4+2rcERIEU1FER/Sqkv0xoOqUTrEQ+9GPzC1aG0gZa5JnAMxMZp66FIQ4N4whPQ/xhtDu+OftdxbuzeYzD/hfgUDZ9RXlh31q5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmN/u75H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAECC2BBFC;
	Mon, 24 Jun 2024 22:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719267982;
	bh=A1zw7pChb50vCYHTi+cKNPAO0Oryfwi6Z4lff+lI6Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RmN/u75HA1sFMpeGPdJhkl4iIpVo2QC3mcj4pV3sSro9zUXSg77efg3iJbqMAgsva
	 e2eLM/YOePlu2m1GZRn17m/S1YU3iOvZAYvmUcCV8oZwNzTgE194CKbUQKvz6/2ANQ
	 F8IUUTej+bXUYcut+Ihvlv2di7ARhVVTb06R/XFMS+S+6WuKAuqmqpcBG6yeQTdIlb
	 M/rXFi6XnrPpCOabmhSZBP8sx5LHAf5mYRT9YivXxIcvXZ5Niz1JGKDmyncJerdOUk
	 G+MECTVMOxUllUNDbx260XaCoth/cIZmho3/G3JBlmxTNJ54cG+acw5a+nB/73TKk6
	 L3pS82Zv27FWQ==
Date: Mon, 24 Jun 2024 15:26:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Nick Terrell <terrelln@fb.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Oliver Upton <oliver.upton@linux.dev>, Ze Gao <zegao2021@gmail.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org, coresight@lists.linaro.org,
	rust-for-linux@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 7/8] perf python: Switch module to linking libraries
 from building source
Message-ID: <Znnyi2IPC79jMd9y@google.com>
References: <20240613233122.3564730-1-irogers@google.com>
 <20240613233122.3564730-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240613233122.3564730-8-irogers@google.com>

On Thu, Jun 13, 2024 at 04:31:21PM -0700, Ian Rogers wrote:
> setup.py was building most perf sources causing setup.py to mimic the
> Makefile logic as well as flex/bison code to be stubbed out, due to
> complexity building. By using libraries fewer functions are stubbed
> out, the build is faster and the Makefile logic is reused which should
> simplify updating. The libraries are passed through LDFLAGS to avoid
> complexity in python.
> 
> Force the -fPIC flag for libbpf.a to ensure it is suitable for linking
> into the perf python module.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/Makefile.config |   5 +
>  tools/perf/Makefile.perf   |   6 +-
>  tools/perf/util/python.c   | 271 ++++++++++++++-----------------------
>  tools/perf/util/setup.py   |  33 +----
>  4 files changed, 110 insertions(+), 205 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7f1e016a9253..639be696f597 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -910,6 +910,11 @@ else
>           endif
>           CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
>           $(call detected,CONFIG_LIBPYTHON)
> +	 ifeq ($(filter -fPIC,$(CFLAGS)),)

Nitpick: mixed TAB and SPACEs.


> +           # Building a shared library requires position independent code.
> +           CFLAGS += -fPIC
> +           CXXFLAGS += -fPIC
> +         endif


I'm curious if it's ok for static libraries too..

Thanks,
Namhyung


>        endif
>      endif
>    endif

