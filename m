Return-Path: <bpf+bounces-59228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD432AC7598
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FCC4E7937
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 01:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB805221F0F;
	Thu, 29 May 2025 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iHNT4+2B"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5D717C211
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748483980; cv=none; b=BlNViJ5gPe/TSFcG1GtX9W+v1GEDD1oZ3bwz50g5KeuuTF9LGXhdM6NG4ozokLjPIwzC9DihHJaoZR1i0kuGiXJlawqetZcoSypeGnfBMpky4ea5NM5qGxtYeN5RlM83NBoF/f/AN9bngjEXp4TBwG/vgxXNZS4dsESAWhSDj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748483980; c=relaxed/simple;
	bh=E0VDnu2Vb7FasqEutiogEzJdZ70+RQibyb21+FPvlBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WObPMUz/mg2lO4GjDcCYACViz0VnHKSqy+SRYnhmTelZ4xR9KA4HlDh/5Ay9cZWGQmeHZWL8m0NDdaLCJxqgYi0D4tTKMDKJ0x1ahdbF3aSE3o/EeCPI/dZZzu2nEXrPt8YwnjxFap4yHoKtgCWUtO9Mh4vIQ/QImODmZRSaUUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iHNT4+2B; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a94dbbe2-f1cb-4ad2-a021-e07f00ee8fe1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748483976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UZsMwMj65621+5MWWMrZn5MiRxhAeR1zA5Aj//ulqI=;
	b=iHNT4+2BVmDdElb84zPCpqERjuhWRhDmlUMPAdRERhMWw5rqMRAIOWopjuWwJtJvC0HPGr
	+FYqe+ZRRWqG0eTfE3xMrLuP6I39zqkLgLEaXHKam6I1lptsWrEmtv747Dle0DDOgZpkNJ
	uIZF4Z28j9fFFqxqK5mjvQd+K29yqdE=
Date: Thu, 29 May 2025 09:59:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Introduce global percpu data
To: Yonghong Song <yonghong.song@linux.dev>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, song@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
 dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250526162146.24429-1-leon.hwang@linux.dev>
 <CAEf4Bzb69wNAvLZ_55vzsZ0Co7u+g=JD85OkodWuYsG-uHBz_w@mail.gmail.com>
 <6cc290d6-2fe8-4171-9e74-a9f20c5b5992@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <6cc290d6-2fe8-4171-9e74-a9f20c5b5992@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 29/5/25 01:10, Yonghong Song wrote:
> 
> 
> On 5/27/25 3:31 PM, Andrii Nakryiko wrote:
>> On Mon, May 26, 2025 at 9:22 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>> This patch set introduces global percpu data, similar to commit
>>> 6316f78306c1 ("Merge branch 'support-global-data'"), to reduce
>>> restrictions
>>> in C for BPF programs.
>>>
>>> With this enhancement, it becomes possible to define and use global
>>> percpu
>>> variables, like the DEFINE_PER_CPU() macro in the kernel[0].
>>>
>>> The section name for global peurcpu data is ".data..percpu". It
>>> cannot be
>>> named ".percpu" or ".percpudata" because defining a one-byte percpu
>>> variable (e.g., char run SEC(".data..percpu") = 0;) can trigger a crash
>>> with Clang 17[1]. The name ".data.percpu" is also avoided because some
>> Does this happen with newer Clangs? If not, I don't think a bug in
>> Clang 17 is reason enough for this weird '.data..percpu' naming
>> convention. I'd still very much prefer .percpu prefix. .data is used
>> for non-per-CPU data, we shouldn't share the prefix, if we can avoid
>> that.
> 
> I checked and clang17 does have a fatal error with '.percpu'. But clang18
> to clang21 all fine.
> 
> For clang17, the error message is
>   fatal error: error in backend: unable to write nop sequence of 3 bytes
> in llvm/lib/MC/MCAssembler.cpp.
> 
> The key reason is in bpf backend llvm/lib/Target/BPF/MCTargetDesc/
> BPFAsmBackend.cpp
> 
> bool BPFAsmBackend::writeNopData(raw_ostream &OS, uint64_t Count,
>                                  const MCSubtargetInfo *STI) const {
>   if ((Count % 8) != 0)
>     return false;
> 
>   for (uint64_t i = 0; i < Count; i += 8)
>     support::endian::write<uint64_t>(OS, 0x15000000, Endian);
> 
>   return true;
> }
> 
> Since Count is 3, writeNopData returns false and it caused the fatal error.
> 
> The bug is likely in MC itself as for the same BPF writeNopData
> implementatation,
> clang18 works fine (with Count is 8). So the bug should be fixed in
> clang18.
> 
From my testing, Clang 18 handles 'char run SEC(".percpu");' correctly
without crashing.

To use the '.percpu' section while avoiding the Clang 17 bug, the test
case can be adjusted as follows:

int data SEC(".percpu") = -1;
int nums[7] SEC(".percpu");
#if defined(__clang__) && __clang_major__ >= 18
char run SEC(".percpu") = 0;
struct {
	char set;
	int i;
	int nums[7];
} struct_data SEC(".percpu") = {
	.set = 0,
	.i = -1,
};
#else
struct {
	int i;
	int nums[7];
} struct_data SEC(".percpu") = {
	.i = -1,
};
#endif

SEC("raw_tp/task_rename")
int update_percpu_data(struct __sk_buff *skb)
{
	struct_data.nums[6] = 0xc0de;
	struct_data.i = 1;
	nums[6] = 0xc0de;
	data = 1;
#if defined(__clang__) && __clang_major__ >= 18
	struct_data.set = 1;
	run = 1;
#endif
	return 0;
}

With this change, the 'char run SEC(".percpu");' declaration will only
be compiled and tested with Clang 18 or newer, effectively avoiding the
crash with Clang 17.

Thanks,
Leon


