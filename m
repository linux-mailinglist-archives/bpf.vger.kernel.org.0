Return-Path: <bpf+bounces-38039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1398C95E51F
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 22:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B350B20E17
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 20:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E833D158D79;
	Sun, 25 Aug 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WbxExdBX"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445B8C07
	for <bpf@vger.kernel.org>; Sun, 25 Aug 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724617445; cv=none; b=jSi2TnQr8ChXEp9zWKNfgEekCF45NgQh46Bf1/QTl7aPfwSWhfnK/VzuYAXAZRP23rFDB0UNmUiUJMWCSuuQ+stXo8N6h6jP5sgDgNtclpzDNLqFDdz7u95cc21gZIFw+w1CxFRZZa7PuXtz81/urPpczrR8xF/1fNVy05iuy8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724617445; c=relaxed/simple;
	bh=zkyR7ZWqhHXtg4p7uuToQzwm8GODl0IP6u8Xdfmc1Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OyhCZyoIJcu64rTt/YqBi3Yn8hRocti1K8glzsllNS36pK1TdIXgds9IoznPQIZM/97fqes5kDSlQ+a6yiiugVQaCIVx6LioPeW6DPGWEYrMcv0JV8TB0RA/Cuh6Xdb2SykdwkDxHQ8HqO4SB/DkfPq5wdu5t40grXr3lzMyvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WbxExdBX; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8c590b2-40b2-4cc0-9eb7-410dbd080a49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724617440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJmOM6hEOwMpe5Yh5pt13Atiwnn9TOnDLKnLZJg/H30=;
	b=WbxExdBXuYnSYsFdmRJRcypMRKZXh2bH0uWHvwOgytfpz/X47NImf1QMmx/Jvzb9HRFoXR
	bIoSCLdOZaj0bbgcKlXXV4Jgtr0kAgo1Ln/qxpKzcl0GIFcz4s56t4TB8wSYL9GRU1EGQw
	3tsQGQIdZDnFtm0dWMem8t93R2o+zjA=
Date: Sun, 25 Aug 2024 13:23:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Problem testing with S390x under QEMU on x86_64
Content-Language: en-GB
To: Tony Ambardar <tony.ambardar@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-s390@vger.kernel.org, llvm@lists.linux.dev,
 Alexei Starovoitov <ast@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <ZsEcsaa3juxxQBUf@kodidev-ubuntu>
 <180f4c27ebfb954d6b0fd2303c9fb7d5f21dae04.camel@linux.ibm.com>
 <ZsU3GdK5t6KEOr0g@kodidev-ubuntu> <Zspq+db1KOhhh2Yf@kodidev-ubuntu>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <Zspq+db1KOhhh2Yf@kodidev-ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/24/24 4:21 PM, Tony Ambardar wrote:
> On Tue, Aug 20, 2024 at 05:38:49PM -0700, Tony Ambardar wrote:
>> Hi Ilya,
>>
>> Thanks for following up. As it happens, I did this the day before out of
>> desperation after trying various kernel config and rootfs changes
>> with no luck, and can confirm the system runs faster and without the
>> kernel crashes noted above. Certainly the latest QEMU seems mandatory.
>>
>> The good news is that 99% of tests with my cross-compiled test_progs
>> work as expected out of the box, and some of the failing ones helped
>> troubleshoot a few hidden libbpf issues. I'll outline the remaining
>> failures for your feedback and comparison with native-built tests.
>>
>> I used the command line:
>>      ./test_progs -d get_stack_raw_tp,stacktrace_build_id,verifier_iterating_callbacks,tailcalls
>>
> [snip]
>
>> Aside from the tests above, I see only 3 failing tests:
>>
>> All error logs:
>> test_map_ptr:PASS:skel_open 0 nsec
>> test_map_ptr:FAIL:skel_load unexpected error: -22 (errno 22)
>> #165     map_ptr:FAIL
>> subtest_userns:PASS:socketpair 0 nsec
>> subtest_userns:PASS:fork 0 nsec
>> recvfd:PASS:recvmsg 0 nsec
>> recvfd:PASS:cmsg_null 0 nsec
>> recvfd:PASS:cmsg_len 0 nsec
>> recvfd:PASS:cmsg_level 0 nsec
>> recvfd:PASS:cmsg_type 0 nsec
>> parent:PASS:recv_bpffs_fd 0 nsec
>> materialize_bpffs_fd:PASS:fs_cfg_cmds 0 nsec
>> materialize_bpffs_fd:PASS:fs_cfg_maps 0 nsec
>> materialize_bpffs_fd:PASS:fs_cfg_progs 0 nsec
>> materialize_bpffs_fd:PASS:fs_cfg_attachs 0 nsec
>> parent:PASS:materialize_bpffs_fd 0 nsec
>> sendfd:PASS:sendmsg 0 nsec
>> parent:PASS:send_mnt_fd 0 nsec
>> recvfd:PASS:recvmsg 0 nsec
>> recvfd:PASS:cmsg_null 0 nsec
>> recvfd:PASS:cmsg_len 0 nsec
>> recvfd:PASS:cmsg_level 0 nsec
>> recvfd:PASS:cmsg_type 0 nsec
>> parent:PASS:recv_token_fd 0 nsec
>> parent:FAIL:waitpid_child unexpected error: 22 (errno 3)
>> #402/9   token/obj_priv_implicit_token_envvar:FAIL
>> #402     token:FAIL
>> libbpf: prog 'on_event': BPF program load failed: Bad address
>> libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
>> The sequence of 8193 jumps is too complex.
>> verification time 2816240 usec
>> stack depth 360
>> processed 116096 insns (limit 1000000) max_states_per_insn 1 total_states 5061 peak_states 5061 mark_read 2540
>> -- END PROG LOAD LOG --
>> libbpf: prog 'on_event': failed to load: -14
>> libbpf: failed to load object 'pyperf600.bpf.o'
>> scale_test:FAIL:expect_success unexpected error: -14 (errno 14)
>> #525     verif_scale_pyperf600:FAIL
>> Summary: 559/4166 PASSED, 98 SKIPPED, 3 FAILED
>>
> Hi Ilya,
>
> A brief update with some good news: the 3 test failures above have been
> resolved and all expected tests now pass on QEMU/s390x under x86_64.
>
> Test '#165 map_ptr:FAIL' was a bug in my light-skeleton code, and fixed in
> my patch series v2:
> https://lore.kernel.org/bpf/cover.1724313164.git.tony.ambardar@gmail.com/
>
> Test '#402/9 token/obj_priv_implicit_token_envvar:FAIL' was a problem in my
> rootfs configuration and now passes after resolving.
>
> Test '#525 verif_scale_pyperf600:FAIL' was caused by clang miscompilation
> exposed by my use of clang-19 and clang-20. The test passes when built
> with clang-17 (used by BPF CI) or clang-18 which I switched to use.

x86 has the same issue where clang19 generated code will cause verification
failure. Eduard is working on this.

>
> One symptom of the problem is easily seen by manually compiling:
>
> $ clang-18  -g -Wall -Werror -D__TARGET_ARCH_s390 -mbig-endian -Itools/testing/selftests/bpf/tools/include -Itools/testing/selftests/bpf -Itools/include/uapi -Itools/testing/selftests/usr/include -Wno-compare-distinct-pointer-types -idirafter /usr/lib/llvm-18/lib/clang/18/include -idirafter /usr/local/include -idirafter /usr/lib/gcc-cross/s390x-linux-gnu/11/../../../../s390x-linux-gnu/include -idirafter /usr/include/s390x-linux-gnu -idirafter /usr/include -DENABLE_ATOMICS_TESTS -O2 --target=bpfeb -c tools/testing/selftests/bpf/progs/pyperf600.c -mcpu=v3 -o pyperf600.clang18.bpf.o
>
> $ clang-19  -g -Wall -Werror -D__TARGET_ARCH_s390 -mbig-endian -Itools/testing/selftests/bpf/tools/include -Itools/testing/selftests/bpf -Itools/include/uapi -Itools/testing/selftests/usr/include -Wno-compare-distinct-pointer-types -idirafter /usr/lib/llvm-19/lib/clang/19/include -idirafter /usr/local/include -idirafter /usr/lib/gcc-cross/s390x-linux-gnu/11/../../../../s390x-linux-gnu/include -idirafter /usr/include/s390x-linux-gnu -idirafter /usr/include -DENABLE_ATOMICS_TESTS -O2 --target=bpfeb -c tools/testing/selftests/bpf/progs/pyperf600.c -mcpu=v3 -o pyperf600.clang19.bpf.o
>
> $ llvm-readelf-18 -S pyperf600.clang{18,19}.bpf.o |grep .symtab
>    [27] .symtab           SYMTAB          0000000000000000 1739d0 01ad60 18      1 4572  8
>    [27] .symtab           SYMTAB          0000000000000000 14f048 0001e0 18      1  12  8
>
> Notice that the .symtab has shrunk by ~200X for example going to clang-19!
> (CCing llvm maintainers)

This is a known issue. In llvm18, all labels (to identify basic blocks) are in symbol table.
Those labels are removed from symbol table in llvm19.

>
>
> Kind regards,
> Tony
>

