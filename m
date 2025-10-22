Return-Path: <bpf+bounces-71755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBF9BFCE6E
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 17:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E701896D44
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4352749C4;
	Wed, 22 Oct 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eFGKa3n0"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4B274669
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147205; cv=none; b=nhlzMJFKhLhz4j06SDZpsFxgTaeRnUxk2ZoreIbhXsxcKAp36MgU4xk3NGcQlzjHkKCEhoeA55xi5wkCQ4O11gmjs8wQoUZ1IZj4d+qmBN54BL+rucGVq/+kyzpuKCEABUARwezBUCPwVnR+XkCoTDpuwthOwehgWHc0gTJX0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147205; c=relaxed/simple;
	bh=azd4xDmevme8F23fM40Ty5P4T9DB/os76+mdY/FZrRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUdOSPusRi/4YtxUpJxkBDUbwpavWFRN2s7ZofBqFIKoTQsFMdPP1cdDFBWJ1CKWPsg2UlItdw0JZFRYvSALoxxaKl/28Prz0mOdAaYaR7Eus3bsZ3BC+/uuAPDicyt8Wy5dJD1ZrhR5931rpC0gBlgFo4SY69FKUkm8Y55uE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eFGKa3n0; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6aa7fafd-30b1-4605-8b80-4a158934218d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761147200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1a9OuwdCiOtRZfIJ9ZURVIn9cH6TPq5+gdX1ROh5QmQ=;
	b=eFGKa3n0v+gHauHTxLKueQLAry7KlTReLpg9h+9XqhNtPRk8LF+u+R6oVmn9YtpGzNCiHr
	0LR4qy9YAe5qyC2O1TlqqARqKSZdMMw9HwU2uuoq+j/3hO5drJ7GYoRHfshorDkep/F8Z+
	LozxD+2XkIn2iXlKfyXRyQUHadfDEDo=
Date: Wed, 22 Oct 2025 08:33:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Guard addr_space_cast code
 with __BPF_FEATURE_ADDR_SPACE_CAST
Content-Language: en-GB
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Puranjay Mohan <puranjay@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20251022071825.238909-1-jiayuan.chen@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251022071825.238909-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/22/25 12:18 AM, Jiayuan Chen wrote:
> When compiling the BPF selftests with Clang versions that do not support
> the addr_space_cast builtin, the build fails with assembly errors in
> "verifier_ldsx.c" [1].
>
> The root cause is that the inline assembly using addr_space_cast is
> being processed by a compiler that lacks this feature. To resolve this,
> wrap the affected code sections (specifically the arena_ldsx_* test
> functions) with #if defined(__BPF_FEATURE_ADDR_SPACE_CAST). This
> ensures the code is only compiled when the Clang supports the necessary
> feature, preventing build failures on older or incompatible compiler
> versions.
>
> This change maintains test coverage for systems with support while
> allowing the tests to build successfully in all environments.
>
> [1]:
> root:tools/testing/selftests/bpf$ make
>
>    CLNG-BPF [test_progs] verifier_ldsx.bpf.o
> progs/verifier_ldsx.c:322:2: error: invalid operand for instruction
>    322 |         "r1 = %[arena] ll;"
>        |         ^
> <inline asm>:1:52: note: instantiated into assembly here
>      1 |         r1 = arena ll;r0 = 0xdeadbeef;r0 = addr_space_cast(r0,...
>        |                                                           ^

I think you are using llvm18 and earlier. Why can you upgrade to llvm19 and later
which should solve the problem?

> Fixes: f61654912404 ("selftests: bpf: Add tests for signed loads from arena")

We do not need to have Fixes. compiler is also moving forward, we cannot support
really old compiler and it is no point to have __BPF_FEATURE_ADDR_SPACE_CAST
for really old compilers. So at some point, __BPF_FEATURE_ADDR_SPACE_CAST will
become default.

> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>   tools/testing/selftests/bpf/progs/verifier_ldsx.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> index c8494b682c31..cefa02e417d3 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> @@ -263,6 +263,7 @@ __naked void ldsx_ctx_8(void)
>   	: __clobber_all);
>   }
>   
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>   SEC("syscall")
>   __description("Arena LDSX Disasm")
>   __success
> @@ -425,6 +426,7 @@ __naked void arena_ldsx_s32(void *ctx)
>   	:  __clobber_all
>   	);
>   }
> +#endif

If you are really using llvm18, then I found there are some other
build failures as well, e.g.,

/home/yhs/work/bpf-next/tools/testing/selftests/bpf/bpf_arena_common.h:47:15: error: conflicting types for 'bpf_arena_alloc_pages'
    47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
       |               ^
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:160636:48: note: previous declaration is here
  160636 | extern void __attribute__((address_space(1))) *bpf_arena_alloc_pages(void *p__map, void __attribute__((address_space(1))) *addr__ign, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
         |                                                ^
In file included from progs/stream.c:8:
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/bpf_arena_common.h:49:5: error: conflicting types for 'bpf_arena_reserve_pages'
    49 | int bpf_arena_reserve_pages(void *map, void __arena *addr, __u32 page_cnt) __ksym __weak;
       |     ^
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:160638:12: note: previous declaration is here
  160638 | extern int bpf_arena_reserve_pages(void *p__map, void __attribute__((address_space(1))) *ptr__ign, u32 page_cnt) __weak __ksym;
         |            ^
In file included from progs/stream.c:8:
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/bpf_arena_common.h:50:6: error: conflicting types for 'bpf_arena_free_pages'
    50 | void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;
       |      ^
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:160637:13: note: previous declaration is here
  160637 | extern void bpf_arena_free_pages(void *p__map, void __attribute__((address_space(1))) *ptr__ign, u32 page_cnt) __weak __ksym;
         |             ^

Please cover all build failures at once.

>   
>   /* to retain debug info for BTF generation */
>   void kfunc_root(void)


