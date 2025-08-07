Return-Path: <bpf+bounces-65197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7D1B1D8ED
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 15:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DE274E1184
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E6625A353;
	Thu,  7 Aug 2025 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urNZPIyv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A51D47B4
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573105; cv=none; b=WI0GK/HIsz7i04m9iXfdxJC5YY0JEm4wm9do+P3TUzopv95KMnNvP0N+m71b9k3WtFZYR4+Xer4w1Ftvkd10QCIUbvLUZfNZvn7jZ7GglVkSpu151Uefob5gGT7Me+KTV8VNyARCvYOFGe1DN2EwpzxqXO3C2EhZzUvy5A8vwQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573105; c=relaxed/simple;
	bh=Eikor+ToOFnKuM00MXYMW2W6iW/2+0REX0qqfpr974c=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IerYoDisz97xoeXU55eabFPbRLrTx68yj9o9NVbjwhcciLNXDdFjsmvNB5hTLpIY1V+3Q6PNFwRQ+NpZVos2OO0uCYYaaW5HltEM7vm/T3Z2YZWXJPIFxkxUJRo/ct0id3i4TWVnqhNpeN8rmWCgTIM+qucAtA4C6Nnme2iFrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urNZPIyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B67EC4CEEB;
	Thu,  7 Aug 2025 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754573104;
	bh=Eikor+ToOFnKuM00MXYMW2W6iW/2+0REX0qqfpr974c=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=urNZPIyvdMlrDKrAmjNwDyeKbwukU9vI06H1dH5tDSLLAYsYtbvucuQ6kKGwYceYE
	 QQtfznaFGGc51o7Mm4gy7ea9I4jr7QaebX98YInQf9E9p09GymBqcfzi5JJBclITuF
	 KRBI/xTof5viiDFylZ+KG3cNf/R1hUh5pDpZRNakV6DvrvBUS1Vy7XNgn6TNB4oFRy
	 I0SIL7soGO78vkbzKtiroKOhUGKn07+gZ7BBsJwS9TcPgKlTi6emKmrjCmWHzKDhbA
	 oDWBtoRioW7M2Rwc4U1Yp5u20dFSFsfnXbv+pp4cCfa1XzdokTcsQfga8/ckoIOVuZ
	 MNb0A5aa5KMzg==
From: <puranjay@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add tests for arena fault
 reporting
In-Reply-To: <34ce4521-6dac-4f78-a049-e6bc928cbd28@linux.dev>
References: <20250806085847.18633-1-puranjay@kernel.org>
 <20250806085847.18633-4-puranjay@kernel.org>
 <34ce4521-6dac-4f78-a049-e6bc928cbd28@linux.dev>
Date: Thu, 07 Aug 2025 13:25:00 +0000
Message-ID: <mb61ph5yjgt77.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yonghong Song <yonghong.song@linux.dev> writes:

> On 8/6/25 1:58 AM, Puranjay Mohan wrote:
>> Add selftests for testing the reporting of arena page faults through BPF
>> streams. Two new bpf programs are added that read and write to an
>> unmapped arena address and the fault reporting is verified in the
>> userspace through streams.
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>   .../testing/selftests/bpf/prog_tests/stream.c | 24 ++++++++++++
>>   tools/testing/selftests/bpf/progs/stream.c    | 37 +++++++++++++++++++
>>   2 files changed, 61 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
>> index d9f0185dca61b..4bdde56de35b1 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
>> @@ -41,6 +41,22 @@ struct {
>>   		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>>   		"|[ \t]+[^\n]+\n)*",
>>   	},
>> +	{
>> +		offsetof(struct stream, progs.stream_arena_read_fault),
>> +		"ERROR: Arena READ access at unmapped address 0x.*\n"
>> +		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
>> +		"Call trace:\n"
>> +		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>> +		"|[ \t]+[^\n]+\n)*",
>> +	},
>> +	{
>> +		offsetof(struct stream, progs.stream_arena_write_fault),
>> +		"ERROR: Arena WRITE access at unmapped address 0x.*\n"
>> +		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
>> +		"Call trace:\n"
>> +		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>> +		"|[ \t]+[^\n]+\n)*",
>> +	},
>>   };
>>   
>>   static int match_regex(const char *pattern, const char *string)
>> @@ -85,6 +101,14 @@ void test_stream_errors(void)
>>   			continue;
>>   		}
>>   #endif
>> +#if !defined(__x86_64__) && !defined(__aarch64__)
>> +		ASSERT_TRUE(1, "Arena fault reporting unsupported, skip.");
>> +		if (i == 2 || i == 3) {
>> +			ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
>> +			ASSERT_EQ(ret, 0, "stream read");
>> +			continue;
>> +		}
>> +#endif
>>   
>>   		ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
>>   		ASSERT_GT(ret, 0, "stream read");
>> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
>> index 35790897dc879..58ebff60cd96a 100644
>> --- a/tools/testing/selftests/bpf/progs/stream.c
>> +++ b/tools/testing/selftests/bpf/progs/stream.c
>> @@ -1,10 +1,15 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +#define BPF_NO_KFUNC_PROTOTYPES
>
> Do we have to defineBPF_NO_KFUNC_PROTOTYPES in the above? Without the above, we do not need 
> below extern bpf_res_spin_lock and bpf_res_spin_unlock.
>

If we don't define BPF_NO_KFUNC_PROTOTYPES then there are build failures
for bpf_arena_alloc/free_pages() because the prototypes in vmlinux.h
lack __arena attribute.

>> +
>> +	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
>> +	bpf_arena_free_pages(&arena, page, 1);
>> +

Thanks,
Puranjay

