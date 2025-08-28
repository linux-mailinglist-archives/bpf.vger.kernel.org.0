Return-Path: <bpf+bounces-66826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F67B39D3C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 14:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACB43A3DEE
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3148C30F817;
	Thu, 28 Aug 2025 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krsg8rwY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AC3101A3
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383942; cv=none; b=hwdOXBav/0OjBRgVjkGiTmIPSaTHNEKuI8YjfZvNlh3bq5921TF5hvqeqM8iNakitqA12k3lhHp9ONhThr9rSfidWYSJNzhWwGXr65OOrbsJWyKlN41dZRLMYqfDZqncBxEI6IBFUbEV0ooRM+f3m4+/29/jhGAb57+JdGG4kH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383942; c=relaxed/simple;
	bh=01dw2IkiVtDKwT78GjGN+qGxdsdg7ABYCfiOguvY8Qc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kq20vxJruC80ObateahIdI7IVX/qh/H2yR/qUOUSfL1GXI07wWzYoFcgnPL1LAdTqzkZS6m/x9wYJ4bQniarpgX7Yczxn5VdegonJdmjXR8MAYjIdcyhBlU19ZuGKwBd9z+HM3Ve99EV9d6DGzMfYsqCoAcsfT8AnGNvJ/4sJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krsg8rwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A44C4CEEB;
	Thu, 28 Aug 2025 12:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756383942;
	bh=01dw2IkiVtDKwT78GjGN+qGxdsdg7ABYCfiOguvY8Qc=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=krsg8rwYLhEdci3xaJB/kXLWonMZYBAsgFptsX0hpBqFwpUYRYoI4IZZIjwxatmIy
	 FfUqpfDlSey2YZlhyd+bdjzhbDY6KRbNrjmiVxozqwJQaKLwGqpiKuTH+Qz9nEG4ez
	 iOfGWUcx2oLLBXXpa2mjLeqlWIHWYkZ+3desw9NxSq5CnxZ55wvO5MLA7LtV2SDSQe
	 XEdGSPSlwyxdYNaFXFWfUmk5R6dbxbxhUIvCs1YRtdhkWlhpfc05UkEg5uQeKVdkQF
	 GXMoKpyEqp4cxlgrfum/pirDqkLRST2oG20ScYs7n//EJ7CdUGfg6HuEe5o+awTTcb
	 ER51VrH10wNhA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add tests for arena
 fault reporting
In-Reply-To: <543975dd-6173-455d-a1a0-aca7806c2b31@linux.dev>
References: <20250827153728.28115-1-puranjay@kernel.org>
 <20250827153728.28115-4-puranjay@kernel.org>
 <543975dd-6173-455d-a1a0-aca7806c2b31@linux.dev>
Date: Thu, 28 Aug 2025 12:25:38 +0000
Message-ID: <mb61pbjnzmy4d.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yonghong Song <yonghong.song@linux.dev> writes:

> On 8/27/25 8:37 AM, Puranjay Mohan wrote:
>> Add selftests for testing the reporting of arena page faults through BPF
>> streams. Two new bpf programs are added that read and write to an
>> unmapped arena address and the fault reporting is verified in the
>> userspace through streams.
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>   .../testing/selftests/bpf/prog_tests/stream.c | 33 +++++++++++++++-
>>   tools/testing/selftests/bpf/progs/stream.c    | 39 +++++++++++++++++++
>>   2 files changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/tes=
ting/selftests/bpf/prog_tests/stream.c
>> index 36a1a1ebde692..8fdc83260ea14 100644
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
>>=20=20=20
>>   static int match_regex(const char *pattern, const char *string)
>> @@ -63,6 +79,7 @@ void test_stream_errors(void)
>>   	struct stream *skel;
>>   	int ret, prog_fd;
>>   	char buf[1024];
>> +	char fault_addr[64] =3D {0};
>
> You can replace '{0}' to '{}' so the whole array will be initialized.

Ack!

>>=20=20=20
>>   	skel =3D stream__open_and_load();
>>   	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
>> @@ -85,6 +102,14 @@ void test_stream_errors(void)
>>   			continue;
>>   		}
>>   #endif
>> +#if !defined(__x86_64__) && !defined(__aarch64__)
>> +		ASSERT_TRUE(1, "Arena fault reporting unsupported, skip.");
>> +		if (i =3D=3D 2 || i =3D=3D 3) {
>> +			ret =3D bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
>> +			ASSERT_EQ(ret, 0, "stream read");
>> +			continue;
>> +		}
>> +#endif
>>=20=20=20
>>   		ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof=
(buf), &ropts);
>>   		ASSERT_GT(ret, 0, "stream read");
>> @@ -92,8 +117,14 @@ void test_stream_errors(void)
>>   		buf[ret] =3D '\0';
>>=20=20=20
>>   		ret =3D match_regex(stream_error_arr[i].errstr, buf);
>> -		if (!ASSERT_TRUE(ret =3D=3D 1, "regex match"))
>> +		if (ret && (i =3D=3D 2 || i =3D=3D 3)) {
>> +			sprintf(fault_addr, "0x%lx", skel->bss->fault_addr);
>> +			ret =3D match_regex(fault_addr, buf);
>> +		}
>> +		if (!ASSERT_TRUE(ret =3D=3D 1, "regex match")) {
>>   			fprintf(stderr, "Output from stream:\n%s\n", buf);
>> +			fprintf(stderr, "Fault Addr: 0x%lx\n", skel->bss->fault_addr);
>
> This will=C2=A0fault addr even for i =3D=3D 0 or i =3D=3D 1 and those add=
ress may be confusing
> for test 0/1.

Will add a check before printing this.

>> +		}
>>   	}
>>=20=20=20
>>   	stream__destroy(skel);
>> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/=
selftests/bpf/progs/stream.c
>> index 35790897dc879..9de015ac3ced5 100644
>> --- a/tools/testing/selftests/bpf/progs/stream.c
>> +++ b/tools/testing/selftests/bpf/progs/stream.c
>> @@ -5,6 +5,7 @@
>>   #include <bpf/bpf_helpers.h>
>>   #include "bpf_misc.h"
>>   #include "bpf_experimental.h"
>> +#include "bpf_arena_common.h"
>>=20=20=20
>>   struct arr_elem {
>>   	struct bpf_res_spin_lock lock;
>> @@ -17,10 +18,17 @@ struct {
>>   	__type(value, struct arr_elem);
>>   } arrmap SEC(".maps");
>>=20=20=20
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARENA);
>> +	__uint(map_flags, BPF_F_MMAPABLE);
>> +	__uint(max_entries, 1); /* number of pages */
>> +} arena SEC(".maps");
>> +
>>   #define ENOSPC 28
>>   #define _STR "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
>>=20=20=20
>>   int size;
>> +u64 fault_addr;
>>=20=20=20
>>   SEC("syscall")
>>   __success __retval(0)
>> @@ -76,4 +84,35 @@ int stream_syscall(void *ctx)
>>   	return 0;
>>   }
>>=20=20=20
>> +SEC("syscall")
>> +__success __retval(0)
>> +int stream_arena_write_fault(void *ctx)
>> +{
>> +	struct bpf_arena *ptr =3D (void *)&arena;
>> +	u64 user_vm_start;
>> +
>> +	barrier_var(ptr);
>
> Do we need this barrier_var()? I tried llvm20 and it works fine without t=
he
> above barrier_var().

As kumar explained in his reply, this is for making it build with GCC,
without the barrier_var() GCC fails with:

  progs/stream.c: In function =E2=80=98stream_arena_write_fault=E2=80=99:
  progs/stream.c:91:76: error: array subscript =E2=80=98struct bpf_arena[0]=
=E2=80=99 is partly outside array bounds of =E2=80=98struct <anonymous>[1]=
=E2=80=99 [-Werror=3Darray-bounds=3D]
     91 |         u64 user_vm_start =3D ((struct bpf_arena *)(uintptr_t)(vo=
id *)&arena)->user_vm_start;
        |                                                                  =
          ^~
  progs/stream.c:25:3: note: object =E2=80=98arena=E2=80=99 of size 24
     25 | } arena SEC(".maps");
        |   ^~~~~
    GCC-BPF  [test_progs-bpf_gcc] struct_ops_refcounted_fail__tail_call.bpf=
.o
  progs/stream.c: In function =E2=80=98stream_arena_read_fault=E2=80=99:
  progs/stream.c:103:85: error: array subscript =E2=80=98struct bpf_arena[0=
]=E2=80=99 is partly outside array bounds of =E2=80=98struct <anonymous>[1]=
=E2=80=99 [-Werror=3Darray-bounds=3D]
    103 |         volatile u64 user_vm_start =3D ((struct bpf_arena *)(uint=
ptr_t)(void *)&arena)->user_vm_start;
        |                                                                  =
                   ^~
  progs/stream.c:25:3: note: object =E2=80=98arena=E2=80=99 of size 24
     25 | } arena SEC(".maps");
        |   ^~~~~
  cc1: all warnings being treated as errors

>> +	user_vm_start =3D  ptr->user_vm_start;
>> +
>
> Remove this line.
>
>> +	fault_addr =3D user_vm_start + 0xbeef;
>> +	*(u32 __arena *)(user_vm_start + 0xbeef) =3D 1;
>
> Simplify to=C2=A0*(u32 __arena *)fault =3D 1;

I wanted it to compile to an instruction with *(u32 *)src + offset =3D 1, w=
hich
was naive of me to think but now I will rewrite this in inline assembly to
also test dst_reg =3D=3D src_reg case which Kumar found out.

Thanks,
Puranjay

