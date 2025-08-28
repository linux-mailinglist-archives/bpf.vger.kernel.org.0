Return-Path: <bpf+bounces-66838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15308B3A4C8
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 17:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A786F56134B
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA42459DC;
	Thu, 28 Aug 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JP9FoAW9"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728AC245010
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395882; cv=none; b=SdogyOffBSB/8aFccYtBSS3vQeFzNTugSNdtnZ0mLjG0H6Eu0FbuPr/6R4qBlFSlqNlCh/Qt1WF4cDHBTMnhepuRlYuEs/vW29ORDKQo6LD523huoiWHb+FoEY6h4qQ4unrIw+W+FzAnQrYUQX/kFD3pXUoDebHT0O7Fc7qkvjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395882; c=relaxed/simple;
	bh=eGux+lSLHXPJbjzyaiq1YTpK69W1JM1ifsj59JIj9M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jICUJoym77QmZxpwhYA696YYhJdi2oYEsIJAUdHCpmzUPsjun8CmQQB/rpSWfurcoISigeUjJPlrCutCmjdH+jfO8UQliN3zrTTmjiV1yte+XDFleFFCrlODeIOpEJtPVaw8cUYceTyomL9VKgF7bms9QOwNkDLd4MFokcN41gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JP9FoAW9; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cb068cb2-5432-43fb-b798-c2bda2bbc173@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756395877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6c29Mpry7CXHVuk5EkrQl0t6Gjm8pFixBHfVoKHV04=;
	b=JP9FoAW9NkpnQtyUrKG+w22AvOiGSEkbXPCseH2a30aNpRIb7eIk2jg5zUbhMlUVpUJVqi
	e+vH1oW/zW+CCyIMS5rr3LiJ7IfV8g+1BUKzn91xd7/nByMj3QUwk1TIigF5gbAHQzMEbe
	n9f8zaZg4xozGkugDCBge6LBVaAOBA8=
Date: Thu, 28 Aug 2025 08:44:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add tests for arena fault
 reporting
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
References: <20250827153728.28115-1-puranjay@kernel.org>
 <20250827153728.28115-4-puranjay@kernel.org>
 <543975dd-6173-455d-a1a0-aca7806c2b31@linux.dev>
 <mb61pbjnzmy4d.fsf@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <mb61pbjnzmy4d.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/28/25 5:25 AM, Puranjay Mohan wrote:
> Yonghong Song <yonghong.song@linux.dev> writes:
>
>> On 8/27/25 8:37 AM, Puranjay Mohan wrote:
>>> Add selftests for testing the reporting of arena page faults through BPF
>>> streams. Two new bpf programs are added that read and write to an
>>> unmapped arena address and the fault reporting is verified in the
>>> userspace through streams.
>>>
>>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>>> ---
>>>    .../testing/selftests/bpf/prog_tests/stream.c | 33 +++++++++++++++-
>>>    tools/testing/selftests/bpf/progs/stream.c    | 39 +++++++++++++++++++
>>>    2 files changed, 71 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
>>> index 36a1a1ebde692..8fdc83260ea14 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
>>> @@ -41,6 +41,22 @@ struct {
>>>    		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>>>    		"|[ \t]+[^\n]+\n)*",
>>>    	},
>>> +	{
>>> +		offsetof(struct stream, progs.stream_arena_read_fault),
>>> +		"ERROR: Arena READ access at unmapped address 0x.*\n"
>>> +		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
>>> +		"Call trace:\n"
>>> +		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>>> +		"|[ \t]+[^\n]+\n)*",
>>> +	},
>>> +	{
>>> +		offsetof(struct stream, progs.stream_arena_write_fault),
>>> +		"ERROR: Arena WRITE access at unmapped address 0x.*\n"
>>> +		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
>>> +		"Call trace:\n"
>>> +		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>>> +		"|[ \t]+[^\n]+\n)*",
>>> +	},
>>>    };
>>>    
>>>    static int match_regex(const char *pattern, const char *string)
>>> @@ -63,6 +79,7 @@ void test_stream_errors(void)
>>>    	struct stream *skel;
>>>    	int ret, prog_fd;
>>>    	char buf[1024];
>>> +	char fault_addr[64] = {0};
>> You can replace '{0}' to '{}' so the whole array will be initialized.
> Ack!
>
>>>    
>>>    	skel = stream__open_and_load();
>>>    	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
>>> @@ -85,6 +102,14 @@ void test_stream_errors(void)
>>>    			continue;
>>>    		}
>>>    #endif
>>> +#if !defined(__x86_64__) && !defined(__aarch64__)
>>> +		ASSERT_TRUE(1, "Arena fault reporting unsupported, skip.");
>>> +		if (i == 2 || i == 3) {
>>> +			ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
>>> +			ASSERT_EQ(ret, 0, "stream read");
>>> +			continue;
>>> +		}
>>> +#endif
>>>    
>>>    		ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
>>>    		ASSERT_GT(ret, 0, "stream read");
>>> @@ -92,8 +117,14 @@ void test_stream_errors(void)
>>>    		buf[ret] = '\0';
>>>    
>>>    		ret = match_regex(stream_error_arr[i].errstr, buf);
>>> -		if (!ASSERT_TRUE(ret == 1, "regex match"))
>>> +		if (ret && (i == 2 || i == 3)) {
>>> +			sprintf(fault_addr, "0x%lx", skel->bss->fault_addr);
>>> +			ret = match_regex(fault_addr, buf);
>>> +		}
>>> +		if (!ASSERT_TRUE(ret == 1, "regex match")) {
>>>    			fprintf(stderr, "Output from stream:\n%s\n", buf);
>>> +			fprintf(stderr, "Fault Addr: 0x%lx\n", skel->bss->fault_addr);
>> This will fault addr even for i == 0 or i == 1 and those address may be confusing
>> for test 0/1.
> Will add a check before printing this.
>
>>> +		}
>>>    	}
>>>    
>>>    	stream__destroy(skel);
>>> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
>>> index 35790897dc879..9de015ac3ced5 100644
>>> --- a/tools/testing/selftests/bpf/progs/stream.c
>>> +++ b/tools/testing/selftests/bpf/progs/stream.c
>>> @@ -5,6 +5,7 @@
>>>    #include <bpf/bpf_helpers.h>
>>>    #include "bpf_misc.h"
>>>    #include "bpf_experimental.h"
>>> +#include "bpf_arena_common.h"
>>>    
>>>    struct arr_elem {
>>>    	struct bpf_res_spin_lock lock;
>>> @@ -17,10 +18,17 @@ struct {
>>>    	__type(value, struct arr_elem);
>>>    } arrmap SEC(".maps");
>>>    
>>> +struct {
>>> +	__uint(type, BPF_MAP_TYPE_ARENA);
>>> +	__uint(map_flags, BPF_F_MMAPABLE);
>>> +	__uint(max_entries, 1); /* number of pages */
>>> +} arena SEC(".maps");
>>> +
>>>    #define ENOSPC 28
>>>    #define _STR "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
>>>    
>>>    int size;
>>> +u64 fault_addr;
>>>    
>>>    SEC("syscall")
>>>    __success __retval(0)
>>> @@ -76,4 +84,35 @@ int stream_syscall(void *ctx)
>>>    	return 0;
>>>    }
>>>    
>>> +SEC("syscall")
>>> +__success __retval(0)
>>> +int stream_arena_write_fault(void *ctx)
>>> +{
>>> +	struct bpf_arena *ptr = (void *)&arena;
>>> +	u64 user_vm_start;
>>> +
>>> +	barrier_var(ptr);
>> Do we need this barrier_var()? I tried llvm20 and it works fine without the
>> above barrier_var().
> As kumar explained in his reply, this is for making it build with GCC,
> without the barrier_var() GCC fails with:
>
>    progs/stream.c: In function ‘stream_arena_write_fault’:
>    progs/stream.c:91:76: error: array subscript ‘struct bpf_arena[0]’ is partly outside array bounds of ‘struct <anonymous>[1]’ [-Werror=array-bounds=]
>       91 |         u64 user_vm_start = ((struct bpf_arena *)(uintptr_t)(void *)&arena)->user_vm_start;
>          |                                                                            ^~
>    progs/stream.c:25:3: note: object ‘arena’ of size 24
>       25 | } arena SEC(".maps");
>          |   ^~~~~
>      GCC-BPF  [test_progs-bpf_gcc] struct_ops_refcounted_fail__tail_call.bpf.o
>    progs/stream.c: In function ‘stream_arena_read_fault’:
>    progs/stream.c:103:85: error: array subscript ‘struct bpf_arena[0]’ is partly outside array bounds of ‘struct <anonymous>[1]’ [-Werror=array-bounds=]
>      103 |         volatile u64 user_vm_start = ((struct bpf_arena *)(uintptr_t)(void *)&arena)->user_vm_start;
>          |                                                                                     ^~
>    progs/stream.c:25:3: note: object ‘arena’ of size 24
>       25 | } arena SEC(".maps");
>          |   ^~~~~
>    cc1: all warnings being treated as errors

It would be great if you can have the above in the commit message.

Please also put a small comments in the code such that
without barrier_var(), gcc will do some transformation like
   u64 user_vm_start = ((struct bpf_arena *)(uintptr_t)(void *)&arena)->user_vm_start;
and this will cause struct out-of-bound access due to the casting
from smaller map struct to larger "struct bpf_arena".
clang does not have this issue.

>
>>> +	user_vm_start =  ptr->user_vm_start;
>>> +
>> Remove this line.
>>
>>> +	fault_addr = user_vm_start + 0xbeef;
>>> +	*(u32 __arena *)(user_vm_start + 0xbeef) = 1;
>> Simplify to *(u32 __arena *)fault = 1;
> I wanted it to compile to an instruction with *(u32 *)src + offset = 1, which
> was naive of me to think but now I will rewrite this in inline assembly to
> also test dst_reg == src_reg case which Kumar found out.
>
> Thanks,
> Puranjay


