Return-Path: <bpf+bounces-16712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29930804AEE
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 08:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3D31C20E5C
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 07:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4649815EAC;
	Tue,  5 Dec 2023 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dd3gM3AC"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F3A109
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 23:11:02 -0800 (PST)
Message-ID: <15eaca25-697f-40f6-84d6-29757c1769cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701760261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XiIgLCiEXbe75GuwXPMgiXGhV0ms+5HC2pzCvwmvb3M=;
	b=Dd3gM3AC7I5beYuaVGFooLfUV9XAKXrplZJ1d/Csul07ArK/wnGTbMUucD1JIKrgywXE4Z
	JOx9X4BPQbNnxFy8OG9YqlFTlVrn0KWo/fS3BaDCXXtH5tvZq9/uM1O6EDaqGjIlEQgpCw
	t98n4zbtXxlNQKImEUzBs1VW4CBH7jc=
Date: Mon, 4 Dec 2023 23:10:54 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Fix flaky test_btf_id test
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231205060450.3577161-1-yonghong.song@linux.dev>
 <20231205060455.3577644-1-yonghong.song@linux.dev>
 <8f19799f-ecbc-acee-4892-13cb1a50db7f@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <8f19799f-ecbc-acee-4892-13cb1a50db7f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/5/23 1:39 AM, Hou Tao wrote:
> Hi,
>
> On 12/5/2023 2:04 PM, Yonghong Song wrote:
>> With previous patch, one of subtests in test_btf_id becomes
>> flaky and may fail. The following is a failing example:
>>
>>    Error: #26 btf
>>    Error: #26/174 btf/BTF ID
>>      Error: #26/174 btf/BTF ID
>>      btf_raw_create:PASS:check 0 nsec
>>      btf_raw_create:PASS:check 0 nsec
>>      test_btf_id:PASS:check 0 nsec
>>      ...
>>      test_btf_id:PASS:check 0 nsec
>>      test_btf_id:FAIL:check BTF lingersdo_test_get_info:FAIL:check failed: -1
>>
>> The test tries to prove a btf_id not available after the map is closed.
>> But btf_id is freed only after workqueue and a rcu grace period, compared
>> to previous case just after a rcu grade period.
> It is not accurate. Before applying the patch, the btf_id will be
> released in btf_put() and there is no RCU grace period involved. After

I missed it (and because I didn't double check the code).
Yes, btf_id is freed before going to rcu gp. So previously
reliable test now becomes not reliable due to workqueue.


> applying the patch, the btf_id will be released after the running of
> bpf_map_free_deferred kworker.
>> To fix the flaky test, I added a kern_sync_rcu() after closing map and
>> before querying btf id availability, essentially ensuring a rcu grace
>> period in the kernel, which seems making the test happy.
> kern_sync_rcu() doesn't guarantee the bpf_map_free_deferred kworker will
> complete, so why not remove the test case instead ?

Yes, I understand this. My hope is that kern_sync_rcu() can
make the test stable enough (that is why I am using 'seems making')
but no guarantees.

For this particular case, if I am doing refcount for btf as mentioned
in the comments of previous patch, we should be okay.

Will craft another version tomorrow with btf refcount approach.

>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/btf.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
>> index 8fb4a04fbbc0..7feb4223bbac 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
>> @@ -4629,6 +4629,7 @@ static int test_btf_id(unsigned int test_num)
>>   
>>   	/* The map holds the last ref to BTF and its btf_id */
>>   	close(map_fd);
>> +	kern_sync_rcu();
>>   	map_fd = -1;
>>   	btf_fd[0] = bpf_btf_get_fd_by_id(map_info.btf_id);
>>   	if (CHECK(btf_fd[0] >= 0, "BTF lingers")) {

