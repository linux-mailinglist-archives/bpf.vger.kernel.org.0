Return-Path: <bpf+bounces-21283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED5684AE6E
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 07:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3DC8B23830
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 06:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12E128803;
	Tue,  6 Feb 2024 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QFizZ9ma"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5A127B6B
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201491; cv=none; b=VXWAjJyGROTUF69EbLBOaTNLXLJQCrFivvK+HkmlXCqckxSiKnSf6JFsLi9rsBmO1tzEvVwWXK8zXQpPg6Wku7LogOHBQDpvysC4BpgqZe9D61sAo6NVnpfK7BVyjczdbln/V55/XDloxtSzNFXtPVUnkij1TVHgV25cuLp66IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201491; c=relaxed/simple;
	bh=gYSPPQkxGVxopRefB4oNvj3XotsXyzANMSieUfq5dMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZKIYXIxu3zSFnWWuPypIrDtD4CAlwYow1IVp0+1hHn/ORbaiLkMDUfW8NwTqudSopcgFERtnOnQxXsEk7QQ3UtlKPUMngThJSlpS/dMvb1vnYqM4BSFf5dVhPmE/lJoajWuYf0Y/aTYDbrg6ZupzbT7AObPZqUnbgzv6bCB7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QFizZ9ma; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d92b0371-6d36-4296-b920-28bea1f5fd07@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707201486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlA3r8GlivXM9HR/+q/C6ySN28fs400IEwqhUtJRU8k=;
	b=QFizZ9mahH9MFDecwMwtn4hckcrR9KCmQwqXBEMOu47G4n933dgeJ62n1S9fPQrH8sf5mR
	xTGdfz09k/GAcCIiZnrhciJhDsfQBANw7eeBNVEznJl9mMZcjp+XXXmoRamEVRi2C+QqjO
	AaSf+DjSqIVSQYAo0EtwJ0wuVPnXJmk=
Date: Mon, 5 Feb 2024 22:37:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky test ptr_untrusted
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240204194452.2785936-1-yonghong.song@linux.dev>
 <CAEf4BzZhg13E=-z1yUKwtiXOeNwaA8m5N_jaTW_DRGV7ZdFE9A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZhg13E=-z1yUKwtiXOeNwaA8m5N_jaTW_DRGV7ZdFE9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/5/24 10:56 AM, Andrii Nakryiko wrote:
> On Sun, Feb 4, 2024 at 11:45 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Somehow recently I frequently hit the following test failure
>> with either ./test_progs or ./test_progs-cpuv4:
>>    serial_test_ptr_untrusted:PASS:skel_open 0 nsec
>>    serial_test_ptr_untrusted:PASS:lsm_attach 0 nsec
>>    serial_test_ptr_untrusted:PASS:raw_tp_attach 0 nsec
>>    serial_test_ptr_untrusted:FAIL:cmp_tp_name unexpected cmp_tp_name: actual -115 != expected 0
>>    #182     ptr_untrusted:FAIL
>>
>> Further investigation found the failure is due to
>>    bpf_probe_read_user_str()
>> where reading user-level string attr->raw_tracepoint.name
>> is not successfully, most likely due to the
>> string itself still in disk and not populated into memory yet.
>>
>> One solution is do a printf() call of the string before doing bpf
>> syscall which will force the raw_tracepoint.name into memory.
>> But I think a more robust solution is to use bpf_copy_from_user()
>> which is used in sleepable program and can tolerate page fault,
>> and the fix here used the latter approach.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/progs/test_ptr_untrusted.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c b/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
>> index 4bdd65b5aa2d..2fdc44e76624 100644
>> --- a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
>> +++ b/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
>> @@ -6,13 +6,13 @@
>>
>>   char tp_name[128];
>>
>> -SEC("lsm/bpf")
>> +SEC("lsm.s/bpf")
>>   int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
>>   {
>>          switch (cmd) {
>>          case BPF_RAW_TRACEPOINT_OPEN:
>> -               bpf_probe_read_user_str(tp_name, sizeof(tp_name) - 1,
>> -                                       (void *)attr->raw_tracepoint.name);
>> +               bpf_copy_from_user(tp_name, sizeof(tp_name) - 1,
>> +                                  (void *)attr->raw_tracepoint.name);
> Should we also add bpf_copy_from_user_str (and
> bpf_copy_from_user_str_task) kfuncs to complete bpf_copy_from_user?
> This change is not strictly equivalent (though for tests it's fine,
> but in real-world apps it would be problematic).

Sounds a good idea. Let me do some investigations!

>
>>                  break;
>>          default:
>>                  break;
>> --
>> 2.34.1
>>

