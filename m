Return-Path: <bpf+bounces-79079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3DFD26464
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16B0E302DB39
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1D12D239B;
	Thu, 15 Jan 2026 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nf6kfS0R"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27A2C08AC
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497575; cv=none; b=BYupCV2fimUDgdCT9tF3IiZs7mDmE2kqLYo6O8cob2tbmH4xaPAUkMzfe2RJjesSx2ILS2/WDK+R3QyxHGpBKiilhgNudo+LVMkRNQb/ArQyuK7Ua0MyB/OxwwSd/ZMHb8jyNRDfEjGoW21/ra7yFbOKyRJpYTC6dZMf0bxm0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497575; c=relaxed/simple;
	bh=hXv/x8RSCX3zjlZjnlK0vMuXkgiZ2tsrwdDvvMVu66Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIPKRCo5sOu+2C1J1Irfs+/C+B/UnAuXv4FUG/uImNaKySm0YGozrH80DW1yB6/QLH+gulFb38GoJQsrzDkqHcblhZhmnEkuOo2o+XcKo9wmpUEA9U8PuXTDEYfpKXuMK6mdVcWVl9rM+7JD2dbBDzw7iXmtnxHMyDT/lOyHAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nf6kfS0R; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <be872fd4-479e-45e6-8832-9bfe560bced1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768497570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQrvGliXV3k9Qmf5bLNaH6Lxn8pRXhhom0+CqkYdbDs=;
	b=Nf6kfS0Rh1Vy+i1xmHUtbNNVlpnZyyhd5e9qxEDEowhhT9NRpOrYLOT01KzBpVshgSioeY
	PCQpTU0ANoFMMTx07MOLNuTrHeTYdaqir3K594J4n8eqcfQ850A34rGnHIKRNAm60jVvZN
	uPG2FKhkB5ldLNWmjKqSCUVoLgRaa7A=
Date: Thu, 15 Jan 2026 09:19:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix map_kptr test failure
Content-Language: en-GB
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260115061319.2895636-1-yonghong.song@linux.dev>
 <CAP01T75HfwbrZkRouGiuhfbFqMS4-LXh-nQ7ho=rJ-DZ44vCDA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAP01T75HfwbrZkRouGiuhfbFqMS4-LXh-nQ7ho=rJ-DZ44vCDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/14/26 11:54 PM, Kumar Kartikeya Dwivedi wrote:
> On Thu, 15 Jan 2026 at 07:16, Yonghong Song <yonghong.song@linux.dev> wrote:
>> On my arm64 machine, I get the following failure:
>>    ...
>>    tester_init:PASS:tester_log_buf 0 nsec
>>    process_subtest:PASS:obj_open_mem 0 nsec
>>    process_subtest:PASS:specs_alloc 0 nsec
>>    serial_test_map_kptr:PASS:rcu_tasks_trace_gp__open_and_load 0 nsec
>>    ...
>>    test_map_kptr_success:PASS:map_kptr__open_and_load 0 nsec
>>    test_map_kptr_success:PASS:test_map_kptr_ref1 refcount 0 nsec
>>    test_map_kptr_success:FAIL:test_map_kptr_ref1 retval unexpected error: 2 (errno 2)
>>    test_map_kptr_success:PASS:test_map_kptr_ref2 refcount 0 nsec
>>    test_map_kptr_success:FAIL:test_map_kptr_ref2 retval unexpected error: 1 (errno 2)
>>    ...
>>    #201/21  map_kptr/success-map:FAIL
>>
>> In serial_test_map_kptr(), before test_map_kptr_success(), one
>> kern_sync_rcu() is used to have some delay for freeing the map.
>> But in my environment, one kern_sync_rcu() seems not enough and
>> caused the test failure.
>>
>> In bpf_map_free_in_work() in syscall.c, the queue time for
>>    queue_work(system_dfl_wq, &map->work)
>> may be longer than expected. This may cause the test failure
>> since test_map_kptr_success() expects all previous maps having been freed.
>>
>> In stead of one kern_sync_rcu() before test_map_kptr_success(),
>> I added two more kern_sync_rcu() to have a longer delay and
>> the test succeeded.
>>
>> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> This is still not a proper fix, right? Maybe two works in this case,
> but it isn't guaranteed to be enough either.
> RCU gp wait won't have any synchronization with when wq items are executed.
> I forgot why I used kern_sync_rcu() originally, but I feel the right
> way to fix this would be to count when all maps have finished their
> bpf_map_free through an fexit hook. Thoughts?

Agree that this is still not to guarantee it won't break due to queue_work().
One possibility is to count the references in a separate bpf program and until
all references are gone then we can do subsequent test_map_kptr_success().
Let me give a try.

>
>>   tools/testing/selftests/bpf/prog_tests/map_kptr.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
>> index 8743df599567..f9cfc4d3153c 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
>> @@ -148,11 +148,15 @@ void serial_test_map_kptr(void)
>>
>>                  ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
>>                  ASSERT_OK(kern_sync_rcu(), "sync rcu");
>> +               ASSERT_OK(kern_sync_rcu(), "sync rcu");
>> +               ASSERT_OK(kern_sync_rcu(), "sync rcu");
>>                  /* Observe refcount dropping to 1 on bpf_map_free_deferred */
>>                  test_map_kptr_success(false);
>>
>>                  ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
>>                  ASSERT_OK(kern_sync_rcu(), "sync rcu");
>> +               ASSERT_OK(kern_sync_rcu(), "sync rcu");
>> +               ASSERT_OK(kern_sync_rcu(), "sync rcu");
>>                  /* Observe refcount dropping to 1 on synchronous delete elem */
>>                  test_map_kptr_success(true);
>>          }
>> --
>> 2.47.3
>>
>>


