Return-Path: <bpf+bounces-66729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876ADB38B8A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4526D36775D
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26C30DD16;
	Wed, 27 Aug 2025 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gnd7ztql"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FC1A073F
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756330689; cv=none; b=TkV5tSOhw62FbUSTANxQBmH5d9Dtxo7xwQkAOEf4QKC1W+KA1212HNkCPDOb76ssQ4l9163b6EPY5xCiMsLRhGhJlj/AijWl0k2VXOgKMh5V0W6R10lRtShmmqrH3zW4t2yCcPvWQUqe/0UXGScAZyV4D0vpkvnkCfIFeeixFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756330689; c=relaxed/simple;
	bh=CN0nmjPVVD+t3srm+R2o1grHEMFHJyF4AaBM4NUSmCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJnAww5iJzRttOaMC+hXQjX+FC+AN1Kp607gudvZkzDpUF3gpf6pJcnCDkTJkAymBO6jOoZzGaM+wDaUymrdH2NL29scYczlNFOGkStmHrrgJZYjNyyDQVmdMOtUYPxABkHaAaUUopM2jyPHjttBL7VQxD6DbsdfWzks/f0d+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gnd7ztql; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac3eabcb-934d-40a4-b725-6a4684ef48a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756330685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SNt+nLORUveiv+iyzoNW5prbk5920wrPd1N+QCzxzo=;
	b=Gnd7ztql5KYKHWmBuQ+bJtKp8jsrVIdPWQIJ8pww1Y8DI+NNws25OVG+m6LXqjiVd4T6Qn
	hCX0xpPsWfGpLVQFUe166TfB2o6uN1XGC14vtDiHy0MFd6wkKh3cMM6XPFTQlgrDUlxt8+
	gEvjqaNfsCL416FIDEmUHoVw0mCsR5w=
Date: Wed, 27 Aug 2025 14:37:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: Annotate
 bpf_obj_new_impl() with __must_check
Content-Language: en-GB
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250827194929.416969-1-iii@linux.ibm.com>
 <20250827194929.416969-2-iii@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250827194929.416969-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/27/25 12:46 PM, Ilya Leoshkevich wrote:
> The verifier requires that pointers returned by bpf_obj_new_impl() are
> either dropped or stored in a map. Therefore programs that do not use
> its return values will fail to load. Make the compiler point out these
> issues. Adjust selftests that check that the verifier does indeed spot
> these bugs.
>
> Note that now there two different bpf_obj_new_impl() declarations: one
> with __must_check from bpf_experimental.h, and one without from
> vmlinux.h. According to the GCC doc [1] this is fine and has the
> desired effect:
>
>      Compatible attribute specifications on distinct declarations of the
>      same function are merged.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc-12.4.0/gcc/Function-Attributes.html
>
> Link: https://lore.kernel.org/bpf/CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com/
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   .../testing/selftests/bpf/bpf_experimental.h  |  6 ++++-
>   .../selftests/bpf/progs/linked_list_fail.c    | 23 +++++++++++++++----
>   2 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index da7e230f2781..a8f206f4fdb9 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -8,6 +8,10 @@
>   
>   #define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
>   
> +#ifndef __must_check
> +#define __must_check __attribute__((__warn_unused_result__))
> +#endif

As you mentioned in Patch 2, we definitely has an issue with clang. I tried the following
experiments with latest master branch.

$ cat run3.sh
echo ".c => .i => .o"

clang  -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian \
   -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include \
   -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf \
   -I/home/yhs/work/bpf-next/tools/include/uapi \
   -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include \
   -std=gnu11 -fno-strict-aliasing -Wno-compare-distinct-pointer-types \
   -idirafter /home/yhs/work/llvm-project/llvm/build.21/Release/lib/clang/21/include \
   -idirafter /usr/local/include -idirafter /usr/include    -DENABLE_ATOMICS_TESTS \
   -O2 --target=bpfel -E progs/linked_list_fail.c -mcpu=v4 \
   -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/linked_list_fail.i
clang  -g -Wall -Werror -mlittle-endian -std=gnu11 -fno-strict-aliasing \
   -Wno-compare-distinct-pointer-types -O2 --target=bpfel -c linked_list_fail.i \
   -mcpu=v4 \
   -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/cpuv4/linked_list_fail.bpf.o

echo ".c => .o"

clang  -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian \
   -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include \
   -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf \
   -I/home/yhs/work/bpf-next/tools/include/uapi \
   -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include \
   -std=gnu11 -fno-strict-aliasing -Wno-compare-distinct-pointer-types \
   -idirafter /home/yhs/work/llvm-project/llvm/build.21/Release/lib/clang/21/include \
   -idirafter /usr/local/include -idirafter /usr/include    -DENABLE_ATOMICS_TESTS \
   -O2 --target=bpfel -c progs/linked_list_fail.c -mcpu=v4 \
   -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/cpuv4/linked_list_fail.bpf.o
$ ./run3.sh
.c => .i => .o
progs/linked_list_fail.c:230:3: error: expression result unused [-Werror,-Wunused-value]
   230 |  ((union { int data; unsigned udata; } *)bpf_obj_new_impl(__builtin_btf_type_id(*((typeof(union { int data; unsigned udata; }) *) 0), BPF_TYPE_ID_LOCAL), ((void *)0)));
       |   ^                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
progs/linked_list_fail.c:255:3: error: expression result unused [-Werror,-Wunused-value]
   255 |  ((struct foo *)bpf_obj_new_impl(__builtin_btf_type_id(*((typeof(struct foo) *) 0), BPF_TYPE_ID_LOCAL), ((void *)0)));
       |   ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.
.c => .o
$

The clang compilation command line is from selftest build with V=1.

Compiling from .c to .o is okay, but from .c => .i => .o will have
errors due to unused value.

I think you do not need __must_check here. '-Wall -Werror' seems already covered this.
You can also mention the clang bug in the commit message. The fix will be below:

diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
index 6438982b928b..35616b5c9b9e 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -227,7 +227,7 @@ SEC("?tc")
  int obj_new_no_struct(void *ctx)
  {
  
-       bpf_obj_new(union { int data; unsigned udata; });
+       (void)bpf_obj_new(union { int data; unsigned udata; });
         return 0;
  }
  
@@ -252,7 +252,7 @@ int new_null_ret(void *ctx)
  SEC("?tc")
  int obj_new_acq(void *ctx)
  {
-       bpf_obj_new(struct foo);
+       (void)bpf_obj_new(struct foo);
         return 0;
  }

I think this probably will address your icecc issue.


> +
>   /* Description
>    *	Allocates an object of the type represented by 'local_type_id' in
>    *	program BTF. User may use the bpf_core_type_id_local macro to pass the
> @@ -20,7 +24,7 @@
>    *	A pointer to an object of the type corresponding to the passed in
>    *	'local_type_id', or NULL on failure.
>    */
> -extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
> +extern __must_check void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
>   
>   /* Convenience macro to wrap over bpf_obj_new_impl */
>   #define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
> diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
> index 6438982b928b..1e30d103e1c7 100644
> --- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
> +++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
> @@ -212,22 +212,33 @@ int map_compat_raw_tp_w(void *ctx)
>   SEC("?tc")
>   int obj_type_id_oor(void *ctx)
>   {
> -	bpf_obj_new_impl(~0UL, NULL);
> +	void *f;
> +
> +	f = bpf_obj_new_impl(~0UL, NULL);
> +	(void)f;
> +
>   	return 0;
>   }
>   
>   SEC("?tc")
>   int obj_new_no_composite(void *ctx)
>   {
> -	bpf_obj_new_impl(bpf_core_type_id_local(int), (void *)42);
> +	void *f;
> +
> +	f = bpf_obj_new_impl(bpf_core_type_id_local(int), (void *)42);
> +	(void)f;
> +
>   	return 0;
>   }
>   
>   SEC("?tc")
>   int obj_new_no_struct(void *ctx)
>   {
> +	void *f;
> +
> +	f = bpf_obj_new(union { int data; unsigned udata; });
> +	(void)f;
>   
> -	bpf_obj_new(union { int data; unsigned udata; });
>   	return 0;
>   }
>   
> @@ -252,7 +263,11 @@ int new_null_ret(void *ctx)
>   SEC("?tc")
>   int obj_new_acq(void *ctx)
>   {
> -	bpf_obj_new(struct foo);
> +	void *f;
> +
> +	f = bpf_obj_new(struct foo);
> +	(void)f;
> +
>   	return 0;
>   }
>   


