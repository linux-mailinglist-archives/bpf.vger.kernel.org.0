Return-Path: <bpf+bounces-27050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 558628A846C
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89D71F21A34
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F45140E34;
	Wed, 17 Apr 2024 13:24:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474F513C910;
	Wed, 17 Apr 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360283; cv=none; b=k8s7s0qNAHIwCBFxSzw73hda4F9BXY4OyKCRQ1xKg+UsRmnNBqfRtjyMkNsU2k7X3tk8YPOZ/PjP6QaYeE6bnv+nt2YvGZQOJZJT0+XECGbdj6bV0IWbjK/BN1eY15HDlDM0ea1Xv5ev5lAKBWgYY4krONEsjsk0rHgdfNY0S5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360283; c=relaxed/simple;
	bh=PDeBdt6CsgyabjmfzzexP71XAp/o9b6LqNuTAgkvKR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qporKNFV/gIkei7CImUJpCmFCo/G9SVYCyhqhqVQ1i1xZ9eKHG+YwBunhtGA1SlzQQ1iZDXl14mTexjgDnlsJVsO3pjTC7sONmYoJnZl7ZamqFx9Ih12VfDXuOhmBZBMjgAvbCDQT2YhwNYckCFzQkfTtaNPsqiAR/HXxEoYjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F0E2339;
	Wed, 17 Apr 2024 06:25:08 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E84B73F738;
	Wed, 17 Apr 2024 06:24:35 -0700 (PDT)
Message-ID: <1b52699d-8f92-4a79-89aa-c4df1594e8b1@arm.com>
Date: Wed, 17 Apr 2024 14:24:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/8] perf tools: Fix test "perf probe of function from
 different CU"
To: Alexey Dobriyan <adobriyan@gmail.com>,
 Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>,
 Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Chenyuan Mi <cymi20@fudan.edu.cn>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ravi Bangoria
 <ravi.bangoria@amd.com>,
 =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Colin Ian King <colin.i.king@gmail.com>, Changbin Du
 <changbin.du@huawei.com>, Kan Liang <kan.liang@linux.intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, =?UTF-8?Q?Georg_M=C3=BCller?=
 <georgmueller@gmx.net>, Liam Howlett <liam.howlett@oracle.com>,
 bpf@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
 <d0dc91b6-98ee-4ddd-b0a9-ba74e1b6c85f@p183>
 <f57685aa-fdbf-4625-900b-d612ffb747f3@arm.com>
 <2d7a896b-bbee-4285-9b2b-3edfab6797d3@p183>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <2d7a896b-bbee-4285-9b2b-3edfab6797d3@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/04/2024 12:41, Alexey Dobriyan wrote:
> On Thu, Apr 11, 2024 at 05:40:04PM +0530, Chaitanya S Prakash wrote:
>>
>> On 4/9/24 11:02, Alexey Dobriyan wrote:
>>> On Mon, Apr 08, 2024 at 11:52:22AM +0530, Chaitanya S Prakash wrote:
>>>> - Add str_has_suffix() and str_has_prefix() to tools/lib/string.c
>>>> - Delete ends_with() and replace its usage with str_has_suffix()
>>>> - Delete strstarts() from tools/include/linux/string.h and replace its
>>>>    usage with str_has_prefix()
>>> It should be the other way: starts_with is normal in userspace.
>>> C++, Python, Java, C# all have it. JavaScript too!
>>
>> This is done in accordance with Ian's comments on V1 of this patch
>> series. Please find the link to the same below.
> 
> Yes, but str_has_suffix() doesn't make sense in the wider context.
> 
>> https://lore.kernel.org/all/CAP-5=fUFmeoTjLuZTgcaV23iGQU1AdddG+7Rw=d6buMU007+1Q@mail.gmail.com/
> 
> 	The naming ends_with makes sense but there is also strstarts and
> 	str_has_prefix, perhaps str_has_suffix would be the most consistent
> 	and intention revealing name?
> 

Hi Alexey,

From a brief check it looks like str_has_prefix() is already quite
common with 94 uses. So the path of least resistance is to make
everything self consistent and add str_has_suffix().

I agree it's a bit of a mouthful and not so common in other languages.
Once this more complicated set gets through we could always do a simple
search and replace change it to anything we like. But it would touch
_lots_ of different drivers and trees, so it would be hard to justify.

Thanks
James

