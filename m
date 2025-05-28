Return-Path: <bpf+bounces-59187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17303AC6ECE
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 19:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91580A25F51
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD89028E565;
	Wed, 28 May 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K562yjNY"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925228C858
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452259; cv=none; b=muMn4wFWyv+3yNxgTfIt2F54bipan5BG6WEKRJfITcVnUzzb4SD33W+zjCHQ9C7rI1bYuZS2xUB4RJnu05L4hhfZZUQzxwwjTT11oBx7JsBSJHhFu7CCO6msyUmjaqNmZQoaYrxCG/2jhoOLYzPidh8kyTWbPgo/b9JL/ZoKjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452259; c=relaxed/simple;
	bh=nkNldaeEcBO6ybUmMkBwGwtsFzjBlDncpbZflpltvDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcmYDBKXbcP+uprVRGuiHWuWwCm3Vbf6FlHymDBjP4QFf2bFrGmpTL0BM2d8gahfPdBp3Y2IB12Oh/u/TI95FL+ujtDakpbyzFWSKTZXvFptEvXOwVCOA/MtCCu/6hW1GP+wELKxkeizA1rqyFVKzzpYaMXkG7m5Ka7AbpCIBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K562yjNY; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6cc290d6-2fe8-4171-9e74-a9f20c5b5992@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748452254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ObBqc53oYjuP43a3H4pWUwpJqVVjJBOKnEg7in9uARg=;
	b=K562yjNYRfX6Z5rHvunIxiD++EM8vyIt7cgwkC7DhR3PedtNbcA8O2Mm6RwNE/H2cY9tPU
	1B/p5j2/1MFDBlERwRJpIwo9SrrFMO5AZ4UWsd9PtJVZtKEsuwVc0qFwO1Nu2otuhyXm6g
	6JNbgG90F05PiJOCyuzYd36+He9chZg=
Date: Wed, 28 May 2025 10:10:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Introduce global percpu data
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, song@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
 dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250526162146.24429-1-leon.hwang@linux.dev>
 <CAEf4Bzb69wNAvLZ_55vzsZ0Co7u+g=JD85OkodWuYsG-uHBz_w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bzb69wNAvLZ_55vzsZ0Co7u+g=JD85OkodWuYsG-uHBz_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/27/25 3:31 PM, Andrii Nakryiko wrote:
> On Mon, May 26, 2025 at 9:22 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>> This patch set introduces global percpu data, similar to commit
>> 6316f78306c1 ("Merge branch 'support-global-data'"), to reduce restrictions
>> in C for BPF programs.
>>
>> With this enhancement, it becomes possible to define and use global percpu
>> variables, like the DEFINE_PER_CPU() macro in the kernel[0].
>>
>> The section name for global peurcpu data is ".data..percpu". It cannot be
>> named ".percpu" or ".percpudata" because defining a one-byte percpu
>> variable (e.g., char run SEC(".data..percpu") = 0;) can trigger a crash
>> with Clang 17[1]. The name ".data.percpu" is also avoided because some
> Does this happen with newer Clangs? If not, I don't think a bug in
> Clang 17 is reason enough for this weird '.data..percpu' naming
> convention. I'd still very much prefer .percpu prefix. .data is used
> for non-per-CPU data, we shouldn't share the prefix, if we can avoid
> that.

I checked and clang17 does have a fatal error with '.percpu'. But clang18
to clang21 all fine.

For clang17, the error message is
   fatal error: error in backend: unable to write nop sequence of 3 bytes
in llvm/lib/MC/MCAssembler.cpp.

The key reason is in bpf backend llvm/lib/Target/BPF/MCTargetDesc/BPFAsmBackend.cpp

bool BPFAsmBackend::writeNopData(raw_ostream &OS, uint64_t Count,
                                  const MCSubtargetInfo *STI) const {
   if ((Count % 8) != 0)
     return false;

   for (uint64_t i = 0; i < Count; i += 8)
     support::endian::write<uint64_t>(OS, 0x15000000, Endian);

   return true;
}

Since Count is 3, writeNopData returns false and it caused the fatal error.

The bug is likely in MC itself as for the same BPF writeNopData implementatation,
clang18 works fine (with Count is 8). So the bug should be fixed in clang18.

>
> pw-bot: cr
>
>
>> users already use section names prefixed with ".data.percpu", such as in
>> this example from test_global_map_resize.c:
>>
>> int percpu_arr[1] SEC(".data.percpu_arr");
>>
>> The idea stems from the bpfsnoop[2], which itself was inspired by
>> retsnoop[3]. During testing of bpfsnoop on the v6.6 kernel, two LBR
>> (Last Branch Record) entries were observed related to the
>> bpf_get_smp_processor_id() helper.
>>
>> Since commit 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper"),
>> the bpf_get_smp_processor_id() helper has been inlined on x86_64, reducing
>> the overhead and consequently minimizing these two LBR records.
>>
>> However, the introduction of global percpu data offers a more robust
>> solution. By leveraging the percpu_array map and percpu instruction,
>> global percpu data can be implemented intrinsically.
>>
>> This feature also facilitates sharing percpu information between tail
>> callers and callees or between freplace callers and callees through a
>> shared global percpu variable. Previously, this was achieved using a
>> 1-entry percpu_array map, which this patch set aims to improve upon.
>>
>> Links:
>> [0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe90be28c5a3/include/linux/percpu-defs.h#L114
>> [1] https://lore.kernel.org/bpf/fd1b3f58-c27f-403d-ad99-644b7d06ecb3@linux.dev/
>> [2] https://github.com/bpfsnoop/bpfsnoop
>> [3] https://github.com/anakryiko/retsnoop
>>
>> Changes:
>> v2 -> v3:
>>    * Use ".data..percpu" as PERCPU_DATA_SEC.
>>    * Address comment from Alexei:
>>      * Add u8, array of ints and struct { .. } vars to selftest.
>>
>> v1 -> v2:
>>    * Address comments from Andrii:
>>      * Use LIBBPF_MAP_PERCPU and SEC_PERCPU.
>>      * Reuse mmaped of libbpf's struct bpf_map for .percpu map data.
>>      * Set .percpu struct pointer to NULL after loading skeleton.
>>      * Make sure value size of .percpu map is __aligned(8).
>>      * Use raw_tp and opts.cpu to test global percpu variables on all CPUs.
>>    * Address comments from Alexei:
>>      * Test non-zero offset of global percpu variable.
>>      * Test case about BPF_PSEUDO_MAP_IDX_VALUE.
>>
>> rfc -> v1:
>>    * Address comments from Andrii:
>>      * Keep one image of global percpu variable for all CPUs.
>>      * Reject non-ARRAY map in bpf_map_direct_read(), check_reg_const_str(),
>>        and check_bpf_snprintf_call() in verifier.
>>      * Split out libbpf changes from kernel-side changes.
>>      * Use ".percpu" as PERCPU_DATA_SEC.
>>      * Use enum libbpf_map_type to distinguish BSS, DATA, RODATA and
>>        PERCPU_DATA.
>>      * Avoid using errno for checking err from libbpf_num_possible_cpus().
>>      * Use "map '%s': " prefix for error message.
>>
>> Leon Hwang (4):
>>    bpf: Introduce global percpu data
>>    bpf, libbpf: Support global percpu data
>>    bpf, bpftool: Generate skeleton for global percpu data
>>    selftests/bpf: Add cases to test global percpu data
>>
>>   kernel/bpf/arraymap.c                         |  41 +++-
>>   kernel/bpf/verifier.c                         |  45 ++++
>>   tools/bpf/bpftool/gen.c                       |  47 ++--
>>   tools/lib/bpf/libbpf.c                        | 102 ++++++--
>>   tools/lib/bpf/libbpf.h                        |   9 +
>>   tools/lib/bpf/libbpf.map                      |   1 +
>>   tools/testing/selftests/bpf/Makefile          |   2 +-
>>   .../bpf/prog_tests/global_data_init.c         | 221 +++++++++++++++++-
>>   .../bpf/progs/test_global_percpu_data.c       |  29 +++
>>   9 files changed, 459 insertions(+), 38 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c
>>
>> --
>> 2.49.0
>>


