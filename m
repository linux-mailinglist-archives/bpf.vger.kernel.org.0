Return-Path: <bpf+bounces-67960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E7DB50AF7
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E5E7A4A46
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6A6239E67;
	Wed, 10 Sep 2025 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AU+XsgX6"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1179B22EE5
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470829; cv=none; b=FOct3aQfM39LmbvLmka+XE568wTnlypCcvbpxHhB04Y2bASlgSwBpms53vQtzv20IcfhJ8J5oFXXWfP+JQ7CQ6WDHEiADA8Wgx1+6OgezqVxXgiix2p++OXj1lLTXNSWEhEos3nuK6zBswNQbdW/7zkD/+4E5s5yZYcC/KPA/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470829; c=relaxed/simple;
	bh=1SOXEa78Y/SpQf5cs/UYdp5TWL/WDbCmJLCG3+XPYxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jE5zC6pMq5DyKrYOXtqdWc+7A3HIF2KiYjP3vwXesmt5jB//TbGvkYjVrEg/p3sR8uWQf7aAY0fO10OvpVbMi8ksi3OSvD2L64yjJ6+N/XqO9FjJO0LWnodmW7+i0PPKMMc8+49EkWRffXbm3R0+4aX2DwL1Nb2G3xgZAPZURqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AU+XsgX6; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73949da2-30fe-482e-ba2b-443978a666ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757470825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+oDGOrDXXixhR4cwqJJQAsiegOCgoTEo2AcF4gVQUU=;
	b=AU+XsgX64AbnExKULCvfxOYh4kIHBLY4IaRQjqHYIAzC3crwWpRxqPBw5/MGAomHrAFhGY
	vEAs8Dd231Ai6giCW97Ex5KFu9qLeNyky+cf272X64dA2RehSMrrqx8FQ3Utvj3YV9Dah9
	eFMzs5oy/hx3+/rBQX4ljaK0zya5pJA=
Date: Wed, 10 Sep 2025 10:20:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>,
 Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
 kernel-patches-bot@fb.com
References: <20250909141422.45450-1-leon.hwang@linux.dev>
 <20250909141422.45450-3-leon.hwang@linux.dev>
 <CAADnVQJcu2VM-NdXsteA=0+MtdxvhGya7PZ5_UcYe+d9xqobbw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJcu2VM-NdXsteA=0+MtdxvhGya7PZ5_UcYe+d9xqobbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/9/25 07:07, Alexei Starovoitov wrote:
> On Tue, Sep 9, 2025 at 7:14 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags and check them for
>> following APIs:
>>
>> * 'map_lookup_elem()'
>> * 'map_update_elem()'
>> * 'generic_map_lookup_batch()'
>> * 'generic_map_update_batch()'
>>
>> And, get the correct value size for these APIs.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h            | 22 ++++++++++++++++++
>>  include/uapi/linux/bpf.h       |  2 ++
>>  kernel/bpf/syscall.c           | 42 ++++++++++++++++++++++------------
>>  tools/include/uapi/linux/bpf.h |  2 ++
>>  4 files changed, 54 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 8f6e87f0f3a89..60c235836987d 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3709,4 +3709,26 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
>>                            const char **linep, int *nump);
>>  struct bpf_prog *bpf_prog_find_from_stack(void);
>>
>> +static inline int bpf_map_check_cpu_flags(u64 flags, bool check_all_cpus_flag)
>> +{
> 
> This function is not used in this patch. Don't add it without users.
> 
> Also I really don't like 'bool' arguments.
> They make callsite hard to read.

Agreed. Using a bool argument here makes the call sites harder to
understand.

> Instead of bool use
> bpf_map_check_flags(u64 flags, u64 allowed_flags)
> 
> so the callsites will look like:
> bpf_map_check_flags(flags, BPF_F_CPU);
> and
> bpf_map_check_flags(flags, BPF_F_CPU | BPF_F_ALL_CPUS);
> 
> Also two functions that do very similar things look redundant.
> This bpf_map_check_flags() vs bpf_map_check_op_flags()...
> I think one should do it.
> 
Yes. It would be better to consolidate this logic into
bpf_map_check_op_flags(), rather than introducing a separate but
overlapping helper. That should keep the code simpler and avoid redundancy.

Thanks,
Leon

[...]

