Return-Path: <bpf+bounces-26505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B729B8A1404
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 14:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81F81C21902
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC2E14B064;
	Thu, 11 Apr 2024 12:10:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B1B14A4D4;
	Thu, 11 Apr 2024 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837425; cv=none; b=HGQEUXQVpyqXR/b+eIAEtUCLTB7jfEcGFDbvX2EQYbyHZWivH27iCxHo28axrZr0j8XQB+0B+1hKudVedq5XYekWyYFXthpSkK1AAhdwgDva+6X+iC6cOq6jbB5dJeNqeO13h4QGsi82DBYmp4zkSd7wJvgeOTA4CaLOTkpzNsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837425; c=relaxed/simple;
	bh=ocRnIxs6wujZ806WOVns+Tmp+Ey4F4aPQWLBpel6pYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2z9p5+WVoOO7BEW3sNZg2bOf43PhjtXlGOhb/w/yfq/cYtt1neC1DD5JN6RDa3CCNCUblbhTeZS6ASWkLOnJ3ANWSaj1iBHyGe3z3IgZiZlAUmtXBq8aPgk/Dhn+hzqRo4vs1KEJKxNKfyxWF1SOqnFT03RVeBb5RUItx/26ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B51CE113E;
	Thu, 11 Apr 2024 05:10:51 -0700 (PDT)
Received: from [10.163.57.160] (unknown [10.163.57.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F1A33F64C;
	Thu, 11 Apr 2024 05:10:07 -0700 (PDT)
Message-ID: <f57685aa-fdbf-4625-900b-d612ffb747f3@arm.com>
Date: Thu, 11 Apr 2024 17:40:04 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/8] perf tools: Fix test "perf probe of function from
 different CU"
Content-Language: en-US
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
 james.clark@arm.com, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
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
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
In-Reply-To: <d0dc91b6-98ee-4ddd-b0a9-ba74e1b6c85f@p183>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/9/24 11:02, Alexey Dobriyan wrote:
> On Mon, Apr 08, 2024 at 11:52:22AM +0530, Chaitanya S Prakash wrote:
>> - Add str_has_suffix() and str_has_prefix() to tools/lib/string.c
>> - Delete ends_with() and replace its usage with str_has_suffix()
>> - Delete strstarts() from tools/include/linux/string.h and replace its
>>    usage with str_has_prefix()
> It should be the other way: starts_with is normal in userspace.
> C++, Python, Java, C# all have it. JavaScript too!

This is done in accordance with Ian's comments on V1 of this patch
series. Please find the link to the same below.

https://lore.kernel.org/all/CAP-5=fUFmeoTjLuZTgcaV23iGQU1AdddG+7Rw=d6buMU007+1Q@mail.gmail.com/

>


