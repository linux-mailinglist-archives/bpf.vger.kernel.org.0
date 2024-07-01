Return-Path: <bpf+bounces-33505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA53B91E3F0
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 17:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F571F22713
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C41716133C;
	Mon,  1 Jul 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="kdjLJLXz"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A5522F
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847358; cv=none; b=u+5s9ODjVE8bgDJGgGIvDxQehA/GLTxWMIWfkKrBzb3c0qjyds5cLdDDZyDF79MY9rxpWbNlWQ3d+4ptnygfmDT6a6he2yQc4ukkaRlsv6S4OHOdACinVSaFzUMJQq7NUidFWKYh3ErHCVIQAzaIldS1GKBgvnbDNP6vATYx/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847358; c=relaxed/simple;
	bh=eNvcCp2Qiej1NZMRQtn+M8DYh1VYY2ShrwtCDypJzzg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BkF/YX7PMK/hO/xYty9Fl59KJSA3mzTslZYZoeEMRo302drNssF14VMoS4GGeX2GXjidBbjf23QT6GxbPPPorD47uep/SIu0HrLEkGM0KZI0/GwY80L6Pk3qJh4AZXLvdkfCF5zcFJ/emXRArGy8FU1rZSYmJVcNh5eGb0wgMjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=kdjLJLXz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8bbrGe0HVrBAoFja7D/MB7RijzT8Bgw5+K3kvqYJZ8Y=; b=kdjLJLXz73toHtdeqlzp59gBUS
	hsluJe3G4jZM799OxA6cT17LrKQ466JY7img8rfaBwfISooD46NrM54ia6ikE9ya647mCk0wQPsct
	bKnmHoTNzPnFYCovA7xRP14Q5p6hWZvj5IECBQUm1LWkCHuR+1EUEOfGwQQ5GIpjERFbXq9Aiq7iN
	q1azySYiMPqR9z8x9rz80RUUMIKWtoflMuC6sTexYJf+s8K4CqO5QoYNa+5xRbpcjDk/b896mtnQu
	W5stdxOY2nutub9y96feHL6A+N3B4faX4JwRyuWtjvwlgFtVEDTrvm44YuPsh3fDIdC7/Bx8vV5gO
	kYwauvaQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sOIrN-000F1X-5S; Mon, 01 Jul 2024 17:22:29 +0200
Received: from [178.197.249.41] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sOIrM-000Kvo-0S;
	Mon, 01 Jul 2024 17:22:28 +0200
Subject: Re: [PATCH bpf-next v2 10/11] selftests/bpf: Add UAF tests for arena
 atomics
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20240701133432.3883-1-iii@linux.ibm.com>
 <20240701133432.3883-11-iii@linux.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b38240c0-2b33-bfc2-62af-b6a31a816fc5@iogearbox.net>
Date: Mon, 1 Jul 2024 17:22:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240701133432.3883-11-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27323/Mon Jul  1 10:40:06 2024)

On 7/1/24 3:24 PM, Ilya Leoshkevich wrote:
> Check that __sync_*() functions don't cause kernel panics when handling
> freed arena pages.
> 
> x86_64 does not support some arena atomics yet, and aarch64 may or may
> not support them, based on the availability of LSE atomics at run time.
> Do not enable this test for these architectures for simplicity.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   .../selftests/bpf/prog_tests/arena_atomics.c  | 18 +++++
>   .../selftests/bpf/progs/arena_atomics.c       | 76 +++++++++++++++++++
>   2 files changed, 94 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> index 0807a48a58ee..26e7c06c6cb4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> @@ -146,6 +146,22 @@ static void test_xchg(struct arena_atomics *skel)
>   	ASSERT_EQ(skel->arena->xchg32_result, 1, "xchg32_result");
>   }
>   
> +static void test_uaf(struct arena_atomics *skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	int err, prog_fd;
> +
> +	/* No need to attach it, just run it directly */
> +	prog_fd = bpf_program__fd(skel->progs.uaf);
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +	if (!ASSERT_OK(err, "test_run_opts err"))
> +		return;
> +	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> +		return;
> +
> +	ASSERT_EQ(skel->arena->uaf_recovery_fails, 0, "uaf_recovery_fails");
> +}
> +
>   void test_arena_atomics(void)
>   {
>   	struct arena_atomics *skel;
> @@ -180,6 +196,8 @@ void test_arena_atomics(void)
>   		test_cmpxchg(skel);
>   	if (test__start_subtest("xchg"))
>   		test_xchg(skel);
> +	if (test__start_subtest("uaf"))
> +		test_uaf(skel);
>   
>   cleanup:
>   	arena_atomics__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
> index 55f10563208d..0ea310713fe6 100644
> --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> @@ -176,3 +176,79 @@ int xchg(const void *ctx)
>   
>   	return 0;
>   }
> +
> +__u64 __arena uaf_sink;
> +volatile __u64 __arena uaf_recovery_fails;
> +
> +SEC("syscall")
> +int uaf(const void *ctx)
> +{
> +	if (pid != (bpf_get_current_pid_tgid() >> 32))
> +		return 0;
> +#if defined(ENABLE_ATOMICS_TESTS) && !defined(__TARGET_ARCH_arm64) && \
> +    !defined(__TARGET_ARCH_x86)
> +	__u32 __arena *page32;
> +	__u64 __arena *page64;
> +	void __arena *page;
> +

Looks like the selftest is failing s390x-gcc CI build, ptal :

   https://github.com/kernel-patches/bpf/actions/runs/9745362735/job/26893165998

   [...]
     CLNG-BPF [test_maps] btf__core_reloc_size.bpf.o
     CLNG-BPF [test_maps] bind6_prog.bpf.o
   progs/arena_atomics.c:190:8: error: 'section' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
     190 |         __u32 __arena *page32;
         |               ^
   progs/arena_atomics.c:32:17: note: expanded from macro '__arena'
      32 | #define __arena SEC(".addr_space.1")
         |                 ^
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:40:17: note: expanded from macro 'SEC'
      40 |         __attribute__((section(name), used))                                \
         |                        ^
   progs/arena_atomics.c:191:8: error: 'section' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
     191 |         __u64 __arena *page64;
         |               ^
   progs/arena_atomics.c:32:17: note: expanded from macro '__arena'
      32 | #define __arena SEC(".addr_space.1")
         |                 ^
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:40:17: note: expanded from macro 'SEC'
      40 |         __attribute__((section(name), used))                                \
         |                        ^
   progs/arena_atomics.c:192:7: error: 'section' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
     192 |         void __arena *page;
         |              ^
   progs/arena_atomics.c:32:17: note: expanded from macro '__arena'
      32 | #define __arena SEC(".addr_space.1")
         |                 ^
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:40:17: note: expanded from macro 'SEC'
      40 |         __attribute__((section(name), used))                                \
         |                        ^
   3 errors generated.
     CLNG-BPF [test_maps] cpumask_success.bpf.o
   make: *** [Makefile:654: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/arena_atomics.bpf.o] Error 1
   make: *** Waiting for unfinished jobs....
     CLNG-BPF [test_maps] fib_lookup.bpf.o
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.

