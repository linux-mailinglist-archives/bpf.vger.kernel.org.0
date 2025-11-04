Return-Path: <bpf+bounces-73496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53568C32D64
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 20:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67C5462A56
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CF026F2B6;
	Tue,  4 Nov 2025 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KbbQk1xJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F0184540
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762285189; cv=none; b=fvlKgAj5IGOUg6StxozGzreTmKtiQf7r3P+dx8hR/M1MJRC03qgfxrQf129s1giE+4gCql8343MJdjosW3Ixpe2HWpajW+Hn/Jgl9sOe3GbHmd7sFHjR129Ra0M1tgpccpTRNDMrjFOVE6Sk/V7HQxtSRDldx88GBrbduRIM96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762285189; c=relaxed/simple;
	bh=09TMW9H4E5Apw2nibUlwBgB4WcUCFBjz9yy+dpsXI4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujcUkgubKrkIexQ0XJN8zE7rYTMljj2DkxODALxgli+MKjmKd4a1iKCem2LpxRYgy0yzeKLuwO4O4xuSKvO0gjPbazVfJTi5xGigBj7C+xv6e4qXFlDFAGhLXmykPeNQLUcYv5w2jYsEMi0XbGS96v1E3nkCOcohZNQcHJ0BP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KbbQk1xJ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6312eb6-65cd-4700-abba-dd5c98b0af84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762285185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsM1KP8YQrmn4jBduYwtpkBgO/EOPLLZrOTKffqgdQg=;
	b=KbbQk1xJL5yxO1QqK8vOpSz9DRLV7pkq4vzRVUG7EZYWoo+8EPQqn8hSToPsoiTArGa+gF
	a5WTHk0Ni0MS/SH+OgO1zODr2BvjKC9jJMIGlElYbNwy1gOH3ipUh5gLrUYtsihXe3jWN8
	x+yLpet1EROALtabMbI5sYGLckf393Q=
Date: Tue, 4 Nov 2025 11:39:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 0/2] bpf: add _impl suffix for kfuncs with implicit
 args
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20251104-implv2-v2-0-6dbc35f39f28@meta.com>
 <529b54a3-c534-4760-9bec-ed1214e82819@linux.dev>
 <CAEf4Bza3xzxucYS_1U=hoHs=ihJGvpSk4h1M1k-cnb4eyDQwtg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4Bza3xzxucYS_1U=hoHs=ihJGvpSk4h1M1k-cnb4eyDQwtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/4/25 11:29 AM, Andrii Nakryiko wrote:
> On Tue, Nov 4, 2025 at 9:23 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 11/4/25 7:29 AM, Mykyta Yatsenko wrote:
>>> We’re introducing support for implicit kfunc arguments and need to
>>> rename new kfuncs to comply with the naming convention.
>>> This new feature, will for each kfunc of the form:
>>>
>>> `bpf_foo_impl(args..., aux__prog)`
>>>
>>> generate a public BTF type:
>>>
>>> `bpf_foo(args...)`
>>>
>>> and the verifier will resolve calls to bpf_foo() to bpf_foo_impl(),
>>> supplying a valid struct bpf_prog_aux via aux__prog.
>>
>> Hi Mykyta, thank you for submitting this.
>>
>> The explanation in this cover is inaccurate. There were a few
>> discussions, and the "implicit" feature is in active development, so
>> it is confusing... Let me try to elaborate.
>>
>> [...]
>> 
>>> The implicit-arg mechanism is not in tree yet, so callers must switch to
>>> the *_impl names for now. Once the new mechanism lands, the plain
>>> names (without _impl) will be reintroduced as BTF-visible entry points
>>> and will resolve to the _impl versions automatically.
>>>
> 
> TBH, it looks like both Mykyta's and Ihor's descriptions are a little
> bit too detailed and are more concerned with details of the upcoming
> feature.
> 
> What's important with these fixes is that we are fixing deviation from
> the previously established "_impl" suffix naming convention for these
> kfuncs that accept verifier-provided bpf_prog_aux arguments. Following
> uniform convention will allow for transparent backwards compatibility
> with the upcoming KF_IMPLICIT_ARGS feature, so this patch set aims to
> fix current deviation from the convention so as to eliminate
> unnecessary backwards incompatibility breakage in the future.
> 
> WDYT?

I agree. For this patches we didn't have to go into the details, but that
has already happened :)

> 
>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>> ---
>>> Changes in v1:
>>> - Split commit into 2
>>> - Rebase on the correct branch
>>> - Link to v1: https://lore.kernel.org/all/20251103232319.122965-1-mykyta.yatsenko5@gmail.com/
>>>
>>> ---
>>> Mykyta Yatsenko (2):
>>>       bpf:add _impl suffix for bpf_task_work_schedule* kfuncs
>>>       bpf:add _impl suffix for bpf_stream_vprintk() kfunc
>>>
>>>  kernel/bpf/helpers.c                               | 26 +++++++++++---------
>>>  kernel/bpf/stream.c                                |  3 ++-
>>>  kernel/bpf/verifier.c                              | 12 +++++-----
>>>  tools/bpf/bpftool/Documentation/bpftool-prog.rst   |  2 +-
>>>  tools/lib/bpf/bpf_helpers.h                        | 28 +++++++++++-----------
>>>  tools/testing/selftests/bpf/progs/stream_fail.c    |  6 ++---
>>>  tools/testing/selftests/bpf/progs/task_work.c      |  6 ++---
>>>  tools/testing/selftests/bpf/progs/task_work_fail.c |  8 +++----
>>>  .../testing/selftests/bpf/progs/task_work_stress.c |  4 ++--
>>>  9 files changed, 50 insertions(+), 45 deletions(-)
>>> ---
>>> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
>>> change-id: 20251104-implv2-d6c4be255026
>>>
>>> Best regards,
>>


