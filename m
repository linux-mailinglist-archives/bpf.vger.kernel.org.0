Return-Path: <bpf+bounces-73566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A4DC33D85
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 04:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E39718C32CB
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 03:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8AB25EFBF;
	Wed,  5 Nov 2025 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aGBfBYj+"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC292153E7
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762313775; cv=none; b=ed1TQ3g0aPcw1UMkw727qmSK7E/bYG77StYUHr3DuIYRL5uxoFQEBum44uWykzstFk9BgaVnI0qPxvOvh8USQmsnAsx3kYi+fhax1dCN43Ygo64GsbbdVtTU/mnulr2UlNyT+EXHxZrOW/9As7Zk6enDikXiKO3PpRVYFSJxIgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762313775; c=relaxed/simple;
	bh=Grs3ShgDLUGKKSpWpKSVo8zGkRLNBbByj3CMSD53Jtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NccYi9X/80MUvwGKNJMDx+b5mWzI1DtZrUYbVYmAx9Euwpy3ucMSw7FEyzt7x5GmSvFFVegPRxYvWAXAJNdowTlGJbBIk1/0Lte2MxDV9qn4BzNBO0dAs3EPkZqYQ49ZryzcMGP8a2YHz7RDmDHZxEsJrQpR06a5OWzahBn6rW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aGBfBYj+; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a22dd9a4-94a7-4a9b-ac66-4076caacc9a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762313757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tednmqSeWKE2vdAr3M4CEfIfWy7x4aBJvsASV0JQaog=;
	b=aGBfBYj+BFhcqH11ToDWbF1TLEW9AHm8XN6/RElHjeD2bJhKi8qfVlh+Aei5A8NkhWg2s1
	0BtCNQ3cWIC2H4Ns6SdJQjf395HGPCzMVvb3VAb5VU31fzPExu2cxtBIcUbCZclqaR1mx5
	Pzzt8s40wng1EfL1VJgfjLQplyQaL2A=
Date: Tue, 4 Nov 2025 19:35:46 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 4/4] selftests/bpf: Add tests to verify
 freeing the special fields when update hash and local storage maps
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, ameryhung@gmail.com,
 linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
References: <20251030152451.62778-1-leon.hwang@linux.dev>
 <20251030152451.62778-5-leon.hwang@linux.dev>
 <02b8c4ba-eb24-41e2-813c-98b83561ef9d@linux.dev>
 <697dc64e-8707-44ba-8cda-ba48747f2973@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <697dc64e-8707-44ba-8cda-ba48747f2973@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/4/25 6:14 PM, Leon Hwang wrote:
>
> On 5/11/25 01:30, Yonghong Song wrote:
>>
>> On 10/30/25 8:24 AM, Leon Hwang wrote:
>>> Add tests to verify that updating hash and local storage maps decrements
>>> refcount when BPF_KPTR_REF objects are involved.
>>>
>>> The tests perform the following steps:
>>>
>>> 1. Call update_elem() to insert an initial value.
>>> 2. Use bpf_refcount_acquire() to increment the refcount.
>>> 3. Store the node pointer in the map value.
>>> 4. Add the node to a linked list.
>>> 5. Probe-read the refcount and verify it is *2*.
>>> 6. Call update_elem() again to trigger refcount decrement.
>>> 7. Probe-read the refcount and verify it is *1*.
>>>
>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> I applied this patch only (i.e., not including patches 1/2/3) to master
>> branch and do bpf selftest and all tests succeeded.
>>
>> [root@arch-fb-vm1 bpf]# ./test_progs -t refcounted_kptr
>> #294/1   refcounted_kptr/insert_read_both: remove from tree + list:OK
>> ...
>> #294/18  refcounted_kptr/pcpu_hash_refcount_leak:OK
>> #294/19  refcounted_kptr/check_pcpu_hash_refcount:OK
>> #294/20  refcounted_kptr/hash_lock_refcount_leak:OK
>> #294/21  refcounted_kptr/check_hash_lock_refcount:OK
>> #294/22  refcounted_kptr/rbtree_sleepable_rcu:OK
>> #294/23  refcounted_kptr/rbtree_sleepable_rcu_no_explicit_rcu_lock:OK
>> #294/24  refcounted_kptr/cgroup_storage_lock_refcount_leak:OK
>> #294/25  refcounted_kptr/check_cgroup_storage_lock_refcount:OK
>> ...
>>
>> Did I miss anything?
>>
> Oops.
>
> You should run:
> ./test_progs -t kptr_refcount
>
> The results are as follows:
>
> test_percpu_hash_refcount_leak:PASS:libbpf_num_possible_cpus 0 nsec
> test_percpu_hash_refcount_leak:PASS:calloc values 0 nsec
> test_percpu_hash_refcount_leak:PASS:refcounted_kptr__open_and_load 0 nsec
> test_refcnt_leak:PASS:bpf_map__update_elem init 0 nsec
> test_refcnt_leak:PASS:bpf_prog_test_run_opts 0 nsec
> test_refcnt_leak:PASS:refcount 0 nsec
> test_refcnt_leak:PASS:bpf_map__update_elem dec refcount 0 nsec
> test_refcnt_leak:PASS:bpf_prog_test_run_opts 0 nsec
> test_refcnt_leak:FAIL:refcount unexpected refcount: actual 2 != expected 1
> #158/1   kptr_refcount_leak/percpu_hash_refcount_leak:FAIL
> test_hash_lock_refcount_leak:PASS:refcounted_kptr__open_and_load 0 nsec
> test_refcnt_leak:PASS:bpf_map__update_elem init 0 nsec
> test_refcnt_leak:PASS:bpf_prog_test_run_opts 0 nsec
> test_refcnt_leak:PASS:refcount 0 nsec
> test_refcnt_leak:PASS:bpf_map__update_elem dec refcount 0 nsec
> test_refcnt_leak:PASS:bpf_prog_test_run_opts 0 nsec
> test_refcnt_leak:FAIL:refcount unexpected refcount: actual 2 != expected 1
> #158/2   kptr_refcount_leak/hash_lock_refcount_leak:FAIL
> test_cgroup_storage_lock_refcount_leak:PASS:setup_cgroup_environment 0 nsec
> test_cgroup_storage_lock_refcount_leak:PASS:get_root_cgroup 0 nsec
> test_cgroup_storage_lock_refcount_leak:PASS:refcounted_kptr__open_and_load
> 0 nsec
> test_refcnt_leak:PASS:bpf_map__update_elem init 0 nsec
> test_refcnt_leak:PASS:bpf_prog_test_run_opts 0 nsec
> test_refcnt_leak:PASS:refcount 0 nsec
> test_refcnt_leak:PASS:bpf_map__update_elem dec refcount 0 nsec
> test_refcnt_leak:PASS:bpf_prog_test_run_opts 0 nsec
> test_refcnt_leak:FAIL:refcount unexpected refcount: actual 2 != expected 1
> #158/3   kptr_refcount_leak/cgroup_storage_lock_refcount_leak:FAIL
> #158     kptr_refcount_leak:FAIL
>
> All error logs:
> test_percpu_hash_refcount_leak:PASS:libbpf_num_possible_cpus 0 nsec
> test_percpu_hash_refcount_leak:PASS:calloc values 0 nsec
> test_percpu_hash_refcount_leak:PASS:refcounted_kptr__open_and_load 0 nsec
> test_refcnt_leak:PASS:bpf_map__update_elem init 0 nsec
> test_refcnt_leak:PASS:bpf_prog_test_run_opts 0 nsec
> test_refcnt_leak:PASS:refcount 0 nsec
> test_refcnt_leak:PASS:bpf_map__update_elem dec refcount 0 nsec
> test_refcnt_leak:PASS:bpf_prog_test_run_opts 0 nsec
> test_refcnt_leak:FAIL:refcount unexpected refcount: actual 2 != expected 1
> #158/1   kptr_refcount_leak/percpu_hash_refcount_leak:FAIL
> test_hash_lock_refcount_leak:PASS:refcounted_kptr__open_and_load 0 nsec
> test_refcnt_leak:PASS:bpf_map__update_elem init 0 nsec
> test_refcnt_leak:PASS:bpf_prog_test_run_opts 0 nsec
> test_refcnt_leak:PASS:refcount 0 nsec
> test_refcnt_leak:PASS:bpf_map__update_elem dec refcount 0 nsec
> test_refcnt_leak:PASS:bpf_prog_test_run_opts 0 nsec
> test_refcnt_leak:FAIL:refcount unexpected refcount: actual 2 != expected 1
> #158/2   kptr_refcount_leak/hash_lock_refcount_leak:FAIL
> test_cgroup_storage_lock_refcount_leak:PASS:setup_cgroup_environment 0 nsec
> test_cgroup_storage_lock_refcount_leak:PASS:get_root_cgroup 0 nsec
> test_cgroup_storage_lock_refcount_leak:PASS:refcounted_kptr__open_and_load
> 0 nsec
> test_refcnt_leak:PASS:bpf_map__update_elem init 0 nsec
> test_refcnt_leak:PASS:bpf_prog_test_run_opts 0 nsec
> test_refcnt_leak:PASS:refcount 0 nsec
> test_refcnt_leak:PASS:bpf_map__update_elem dec refcount 0 nsec
> test_refcnt_leak:PASS:bpf_prog_test_run_opts 0 nsec
> test_refcnt_leak:FAIL:refcount unexpected refcount: actual 2 != expected 1
> #158/3   kptr_refcount_leak/cgroup_storage_lock_refcount_leak:FAIL
> #158     kptr_refcount_leak:FAIL
> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>
> All three tests failed because the refcount remained 2 instead of
> decreasing to 1 after the second update_elem() call.
>
> The CI result [1] also demonstrates this issue.
>
> Sorry for the misleading test name earlier.

Sorry. It is my fault. Indeed, with patches 1-3, the tests indeed failed.
I obviously looked at the wrong selftest.

>
> Links:
> [1] https://github.com/kernel-patches/bpf/pull/10203
>
> Thanks,
> Leon
>
> [...]
>


