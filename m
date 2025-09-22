Return-Path: <bpf+bounces-69215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B62ADB918E2
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05ACC1899901
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934B15B971;
	Mon, 22 Sep 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jORAcFgm"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C9286A9
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549627; cv=none; b=Q+pF0OIxHlefQz61ZYV/B28rgY5ItBafWrbDZg9ybCG3uhtcbk88Wtslpz2XRXO6lqCpvPo6y0kmaEyExr2l++r/gxNb/M5/0ip/xsENvbbH8WdUzQhRswZ8YRFLbtQe83ClAVLxBrG0hRh/xMQUxUrzg2T+30eCrsTEekjNazo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549627; c=relaxed/simple;
	bh=txu02aOEWFd5cRrk/D9uytjfj1brvBTdGo5LruCYJ3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTsHGWpCFIKPcWAgncQNiZm30jh+yTZNuHHZ7KrlRf6mZRBYsn+y7wg67UwPviq0l6y8+uR1tCnD8JKWlN0uGmbZddDVrcfh1kxbZwHm+BaIBkQqupQawubZFqouM+XM/3AxkZGCI045pvJ3zjoTfskljN7+BuUWRwW9Tbe59WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jORAcFgm; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3a8c61c-feba-4e2b-ba2d-b86f206e1035@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758549623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oK3TqsMlnl2qHt67syvIkShvhS5cC+G6UTnvhWS/dG4=;
	b=jORAcFgmN0FIX8gEORPfH+ogZfO1WL3cCo1+lqRWFx5UZy7T0NT9ctmiMryWnQCGVHooxe
	16xu+TBGI0WYjnBY6hdvcV2ill+jiC/ZaKVVfz4XrSCDC1hzqMm1WT52lIR2fdQmkh0/5H
	UFyKWNx3WwL23iXqU7KRrQMUxLGldF4=
Date: Mon, 22 Sep 2025 22:00:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add stacktrace map
 lookup_and_delete_elem test case
To: Leon Hwang <hffilwlqm@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250920155211.1354348-1-chen.dylane@linux.dev>
 <20250920155211.1354348-2-chen.dylane@linux.dev>
 <f1d2d0fc-c541-4acc-b5d6-34f2bba37aea@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <f1d2d0fc-c541-4acc-b5d6-34f2bba37aea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/22 10:42, Leon Hwang 写道:
> 
> 
> On 20/9/25 23:52, Tao Chen wrote:
>> ...
>> test_stacktrace_map:PASS:compare_stack_ips stackmap vs. stack_amap 0 nsec
>> test_stacktrace_map:PASS:stack_key_map lookup 0 nsec
>> test_stacktrace_map:PASS:stackmap lookup and detele 0 nsec
>> test_stacktrace_map:PASS:stackmap lookup deleted stack_id 0 nsec
>>   #397     stacktrace_map:OK
>> ...
> 
> As they suppose to pass, they are meaningless in the commit log.
> 
> Please describe what the test is for and what it is doing instead.
> 

will reedit the commit message in v4, thanks.

>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   .../selftests/bpf/prog_tests/stacktrace_map.c | 22 ++++++++++++++++++-
>>   .../selftests/bpf/progs/test_stacktrace_map.c |  8 +++++++
>>   2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
>> index 84a7e405e91..7d38afe5cfc 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
>> @@ -3,7 +3,7 @@
>>   
>>   void test_stacktrace_map(void)
>>   {
>> -	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
>> +	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd, stack_key_map_fd;
>>   	const char *prog_name = "oncpu";
>>   	int err, prog_fd, stack_trace_len;
>>   	const char *file = "./test_stacktrace_map.bpf.o";
>> @@ -11,6 +11,9 @@ void test_stacktrace_map(void)
>>   	struct bpf_program *prog;
>>   	struct bpf_object *obj;
>>   	struct bpf_link *link;
>> +	__u32 stack_id;
>> +	char val_buf[PERF_MAX_STACK_DEPTH *
>> +		sizeof(struct bpf_stack_build_id)];
> 
> Nit: minor indentation issue here.
> 
> 'val_buf' should stay on a single line, since up to 100 characters per
> line are allowed.
> 

will change it in v4, thanks.

> NOTE: keep inverted Christmas tree style.
> 
> Thanks,
> Leon
> 
>>   
>>   	err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
>>   	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
>> @@ -41,6 +44,10 @@ void test_stacktrace_map(void)
>>   	if (CHECK_FAIL(stack_amap_fd < 0))
>>   		goto disable_pmu;
>>   
>> +	stack_key_map_fd = bpf_find_map(__func__, obj, "stack_key_map");
>> +	if (CHECK_FAIL(stack_key_map_fd < 0))
>> +		goto disable_pmu;
>> +
>>   	/* give some time for bpf program run */
>>   	sleep(1);
>>   
> 
> [...]


-- 
Best Regards
Tao Chen

