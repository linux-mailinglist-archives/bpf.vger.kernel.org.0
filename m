Return-Path: <bpf+bounces-33048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C15A9167B4
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 14:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F8D1F228C4
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 12:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E72715FA88;
	Tue, 25 Jun 2024 12:24:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A307B158A23;
	Tue, 25 Jun 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318255; cv=none; b=mKOiYqug7vbTW5ETDRHhYg5+XGH+Q04OPwsnRatWBTdE7uyV2g5TqTL8HoAM5RWNXTPvuHW2s1RmUr+LQQ50dZPoHjjdMn7QDSVOPL8aXwjl9ii/TiwB/x1KBkMW+TIUPwgE/9Xc54K6bPgFtnCGSvhE+YfV7EPTAJBMknRnuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318255; c=relaxed/simple;
	bh=xWkRfjXbcQV976odVJL6jnfAgd/Ex17HQpOdk8g38nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhAv6+IWGHvJfyOzEvFBC2QWqK0wJukAfzbH3Wb4rzLh4tNm007cqWSgw67HjpHuoJbFGFMWFtnsgeTOQEEkeK9M3587koEDrnewdqXOorciD0fgbA7R5D2mMOeQi7LbUisZV8GVIidYpUylVqIDXJqhOAPncoU86Yinkn+ZA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7923C339;
	Tue, 25 Jun 2024 05:24:36 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CD783F766;
	Tue, 25 Jun 2024 05:24:05 -0700 (PDT)
Message-ID: <1fdf637d-3571-4145-8008-f2b5f8fc8bca@arm.com>
Date: Tue, 25 Jun 2024 13:24:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] perf python: Switch module to linking libraries
 from building source
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Nick Terrell <terrelln@fb.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Kees Cook <keescook@chromium.org>,
 Andrei Vagin <avagin@google.com>, Athira Jajeev
 <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>,
 Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
 coresight@lists.linaro.org, rust-for-linux@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240613233122.3564730-1-irogers@google.com>
 <20240613233122.3564730-8-irogers@google.com> <Znnyi2IPC79jMd9y@google.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <Znnyi2IPC79jMd9y@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/06/2024 23:26, Namhyung Kim wrote:
> On Thu, Jun 13, 2024 at 04:31:21PM -0700, Ian Rogers wrote:
>> setup.py was building most perf sources causing setup.py to mimic the
>> Makefile logic as well as flex/bison code to be stubbed out, due to
>> complexity building. By using libraries fewer functions are stubbed
>> out, the build is faster and the Makefile logic is reused which should
>> simplify updating. The libraries are passed through LDFLAGS to avoid
>> complexity in python.
>>
>> Force the -fPIC flag for libbpf.a to ensure it is suitable for linking
>> into the perf python module.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> Reviewed-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/Makefile.config |   5 +
>>  tools/perf/Makefile.perf   |   6 +-
>>  tools/perf/util/python.c   | 271 ++++++++++++++-----------------------
>>  tools/perf/util/setup.py   |  33 +----
>>  4 files changed, 110 insertions(+), 205 deletions(-)
>>
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index 7f1e016a9253..639be696f597 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -910,6 +910,11 @@ else
>>           endif
>>           CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
>>           $(call detected,CONFIG_LIBPYTHON)
>> +	 ifeq ($(filter -fPIC,$(CFLAGS)),)
> 
> Nitpick: mixed TAB and SPACEs.
> 
> 
>> +           # Building a shared library requires position independent code.
>> +           CFLAGS += -fPIC
>> +           CXXFLAGS += -fPIC
>> +         endif
> 
> 
> I'm curious if it's ok for static libraries too..
> 
> Thanks,
> Namhyung
> 

I think I tested the whole set with a static build so it should be ok.

> 
>>        endif
>>      endif
>>    endif

