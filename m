Return-Path: <bpf+bounces-29626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8558C3BAF
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 09:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCAE1F21EE1
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 07:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9F6146A7E;
	Mon, 13 May 2024 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DL1O4sdP"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2181FA1
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715583668; cv=none; b=ISFGoRNmyYDRCOHwGH+sQvMDQsMmILBL9arMLqa2Y5KBquO9jgk9AoxJ7MWH7j3INgDgQlN5RMHdelpuG1rqM9RDTFgY5nxgKK0NZT8Ja34f4jkhHHgQxiAuMYFQ3MclaVZf++0nsBrgGGVye3twMDmfXwVJ8W59n+23CtcL3LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715583668; c=relaxed/simple;
	bh=FNglutKOMNf4oIKy8z3CJ0ag4Xtd06wdi78Qz0/sjP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDknaQGrWBrsNiBp9pyd15YT9QczqujzY41hiqXGJzWROiIJP/bxsFfR3Ds8S8BGLYRslg2Ayz0/ivgfiBq2ETlAI496MYil+ExhQNM8cvj1bUQ0GT0Uako6kMIPIPMFWXkiluSsS+/vU9MYzCT+sE2Wti2nrChLcoTOJSwmobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DL1O4sdP; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b666dbe4-e406-44fc-8bb7-122e6c007948@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715583662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuM1ivPBry8hvT+SMqe+Wim0oUpETn/fwoja6E4kiSE=;
	b=DL1O4sdP9UfM9V2ARELSgsO1X5MSdx7mxbW/hLANEG8uSQPn8nxDnmNGMYBvvb2yju/8Gh
	xDWPOaCrYAUuIW4TJi/7MkSQeekKER3ZUAzZKE4a71d1rTuCl2l64jfOpaHOz/9EKPIlpc
	EVOLVTM9a+uqRnSxS/F0mh8A6Vxvv+A=
Date: Mon, 13 May 2024 15:00:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Add some null pointer
 checks
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, kunwu.chan@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, kunwu.chan@hotmail.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240510095803.472840-1-kunwu.chan@linux.dev>
 <20240510095803.472840-2-kunwu.chan@linux.dev>
 <a6172c6e-3b5b-43e5-8678-9dc4e428cf94@collabora.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <a6172c6e-3b5b-43e5-8678-9dc4e428cf94@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/10 19:20, Muhammad Usama Anjum wrote:
> On 5/10/24 2:58 PM, kunwu.chan@linux.dev wrote:
>> From: Kunwu Chan <chentao@kylinos.cn>
>>
>> There is a 'malloc' call, which can be unsuccessful.
>> This patch will add the malloc failure checking
>> to avoid possible null dereference.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   tools/testing/selftests/bpf/test_progs.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
>> index 89ff704e9dad..ecc3ddeceeeb 100644
>> --- a/tools/testing/selftests/bpf/test_progs.c
>> +++ b/tools/testing/selftests/bpf/test_progs.c
>> @@ -582,6 +582,11 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
>>   
>>   	val_buf1 = malloc(stack_trace_len);
>>   	val_buf2 = malloc(stack_trace_len);
>> +	if (!val_buf1 || !val_buf2) {
>> +		err = -ENOMEM;
> Return from here instead of going to out where free(val_buf*) is being called.
I think it's no harm.  And Unify the processing at the end to achieve 
uniform format.
>> +		goto out;
>> +	}
>> +
>>   	cur_key_p = NULL;
>>   	next_key_p = &key;
>>   	while (bpf_map_get_next_key(smap_fd, cur_key_p, next_key_p) == 0) {
>> @@ -1197,6 +1202,8 @@ static int dispatch_thread_send_subtests(int sock_fd, struct test_state *state)
>>   	int subtest_num = state->subtest_num;
>>   
>>   	state->subtest_states = malloc(subtest_num * sizeof(*subtest_state));
>> +	if (!state->subtest_states)
>> +		return -ENOMEM;
>>   
>>   	for (int i = 0; i < subtest_num; i++) {
>>   		subtest_state = &state->subtest_states[i];

-- 
Thanks,
   Kunwu.Chan


