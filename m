Return-Path: <bpf+bounces-57525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CD7AAC7CF
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEAF1C42CCA
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B429F2820BC;
	Tue,  6 May 2025 14:23:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB8278E5D
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541397; cv=none; b=aE/eis4vnm0AVQ69lXYD06krnSvJjumVJ39Pni4aNg0r3c0SeKD8JesKlJFVr189WBymDjQyJE1UcQ0F0Zp7beg9KRswnqVftEytAwaudgC4cieQac4kndvXvbDUrUL/abPQsV6fdqLCJhJkOnK1qCVLPIFBOaG3R1J540w7wGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541397; c=relaxed/simple;
	bh=ts6/McXcWz5IqsgjmHO5s2qEUjoGhumJ6Csacdm0oF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hEnpkxoztPtgsUF4CrES6NQivwLkyN+fBszuLxAEs/oaZINkhKaNW6bt6ExRTYWKGUXHKpMfDSTKLJ/apd9eVH1OJqoae13THydZlSS1Gi4WNL5ZHzf464hKtwhMhooP+CmrC7wMbwIPhQeRpBAgmP4J9jX2bpKpDi97cw0f5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZsLFn5g1vzsTJl;
	Tue,  6 May 2025 22:22:37 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id D6A521A0188;
	Tue,  6 May 2025 22:23:11 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 May 2025 22:23:09 +0800
Message-ID: <22ecc626-0982-4cff-adfd-9ea4bb658ee5@huawei.com>
Date: Tue, 6 May 2025 22:23:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 6/8] selftests/bpf: Avoid passing out-of-range
 values to __retval()
Content-Language: en-US
To: Peilin Ye <yepeilin@google.com>, <bpf@vger.kernel.org>
CC: <linux-riscv@lists.infradead.org>, Andrea Parri <parri.andrea@gmail.com>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Puranjay Mohan
	<puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Luke Nelson
	<luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Josh Don
	<joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu
	<neelnatu@google.com>, Benjamin Segall <bsegall@google.com>
References: <cover.1745970908.git.yepeilin@google.com>
 <5f7e4c5ac5d254c0f42b4ba274437262e238a5cb.1745970908.git.yepeilin@google.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <5f7e4c5ac5d254c0f42b4ba274437262e238a5cb.1745970908.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/4/30 8:51, Peilin Ye wrote:
> Currently, we pass 0x1234567890abcdef to __retval() for the following
> two tests:
> 
>    verifier_load_acquire/load_acquire_64
>    verifier_store_release/store_release_64
> 
> However, the upper 32 bits of that value are being ignored, since
> __retval() expects an int.  Actually, the tests would still pass even if
> I change '__retval(0x1234567890abcdef)' to e.g. '__retval(0x90abcdef)'.
> 
> Restructure the tests a bit to test the entire 64-bit values properly.
> Do the same to their 8-, 16- and 32-bit variants as well to keep the
> style consistent.
> 
> Fixes: ff3afe5da998 ("selftests/bpf: Add selftests for load-acquire and store-release instructions")
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>   .../bpf/progs/verifier_load_acquire.c         | 40 +++++++++++++------
>   .../bpf/progs/verifier_store_release.c        | 32 +++++++++++----
>   2 files changed, 52 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
> index 77698d5a19e4..a696ab84bfd6 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
> @@ -10,65 +10,81 @@
>   
>   SEC("socket")
>   __description("load-acquire, 8-bit")
> -__success __success_unpriv __retval(0x12)
> +__success __success_unpriv __retval(0)
>   __naked void load_acquire_8(void)
>   {
>   	asm volatile (
> +	"r0 = 0;"
>   	"w1 = 0x12;"
>   	"*(u8 *)(r10 - 1) = w1;"
> -	".8byte %[load_acquire_insn];" // w0 = load_acquire((u8 *)(r10 - 1));
> +	".8byte %[load_acquire_insn];" // w2 = load_acquire((u8 *)(r10 - 1));
> +	"if r2 == r1 goto 1f;"
> +	"r0 = 1;"
> +"1:"
>   	"exit;"
>   	:
>   	: __imm_insn(load_acquire_insn,
> -		     BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -1))
> +		     BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -1))
>   	: __clobber_all);
>   }
>   
>   SEC("socket")
>   __description("load-acquire, 16-bit")
> -__success __success_unpriv __retval(0x1234)
> +__success __success_unpriv __retval(0)
>   __naked void load_acquire_16(void)
>   {
>   	asm volatile (
> +	"r0 = 0;"
>   	"w1 = 0x1234;"
>   	"*(u16 *)(r10 - 2) = w1;"
> -	".8byte %[load_acquire_insn];" // w0 = load_acquire((u16 *)(r10 - 2));
> +	".8byte %[load_acquire_insn];" // w2 = load_acquire((u16 *)(r10 - 2));
> +	"if r2 == r1 goto 1f;"
> +	"r0 = 1;"
> +"1:"
>   	"exit;"
>   	:
>   	: __imm_insn(load_acquire_insn,
> -		     BPF_ATOMIC_OP(BPF_H, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -2))
> +		     BPF_ATOMIC_OP(BPF_H, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -2))
>   	: __clobber_all);
>   }
>   
>   SEC("socket")
>   __description("load-acquire, 32-bit")
> -__success __success_unpriv __retval(0x12345678)
> +__success __success_unpriv __retval(0)
>   __naked void load_acquire_32(void)
>   {
>   	asm volatile (
> +	"r0 = 0;"
>   	"w1 = 0x12345678;"
>   	"*(u32 *)(r10 - 4) = w1;"
> -	".8byte %[load_acquire_insn];" // w0 = load_acquire((u32 *)(r10 - 4));
> +	".8byte %[load_acquire_insn];" // w2 = load_acquire((u32 *)(r10 - 4));
> +	"if r2 == r1 goto 1f;"
> +	"r0 = 1;"
> +"1:"
>   	"exit;"
>   	:
>   	: __imm_insn(load_acquire_insn,
> -		     BPF_ATOMIC_OP(BPF_W, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -4))
> +		     BPF_ATOMIC_OP(BPF_W, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -4))
>   	: __clobber_all);
>   }
>   
>   SEC("socket")
>   __description("load-acquire, 64-bit")
> -__success __success_unpriv __retval(0x1234567890abcdef)
> +__success __success_unpriv __retval(0)
>   __naked void load_acquire_64(void)
>   {
>   	asm volatile (
> +	"r0 = 0;"
>   	"r1 = 0x1234567890abcdef ll;"
>   	"*(u64 *)(r10 - 8) = r1;"
> -	".8byte %[load_acquire_insn];" // r0 = load_acquire((u64 *)(r10 - 8));
> +	".8byte %[load_acquire_insn];" // r2 = load_acquire((u64 *)(r10 - 8));
> +	"if r2 == r1 goto 1f;"
> +	"r0 = 1;"
> +"1:"
>   	"exit;"
>   	:
>   	: __imm_insn(load_acquire_insn,
> -		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -8))
> +		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -8))
>   	: __clobber_all);
>   }
>   
> diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/tools/testing/selftests/bpf/progs/verifier_store_release.c
> index 7e456e2861b4..72f1eb006074 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
> @@ -10,13 +10,17 @@
>   
>   SEC("socket")
>   __description("store-release, 8-bit")
> -__success __success_unpriv __retval(0x12)
> +__success __success_unpriv __retval(0)
>   __naked void store_release_8(void)
>   {
>   	asm volatile (
> +	"r0 = 0;"
>   	"w1 = 0x12;"
>   	".8byte %[store_release_insn];" // store_release((u8 *)(r10 - 1), w1);
> -	"w0 = *(u8 *)(r10 - 1);"
> +	"w2 = *(u8 *)(r10 - 1);"
> +	"if r2 == r1 goto 1f;"
> +	"r0 = 1;"
> +"1:"
>   	"exit;"
>   	:
>   	: __imm_insn(store_release_insn,
> @@ -26,13 +30,17 @@ __naked void store_release_8(void)
>   
>   SEC("socket")
>   __description("store-release, 16-bit")
> -__success __success_unpriv __retval(0x1234)
> +__success __success_unpriv __retval(0)
>   __naked void store_release_16(void)
>   {
>   	asm volatile (
> +	"r0 = 0;"
>   	"w1 = 0x1234;"
>   	".8byte %[store_release_insn];" // store_release((u16 *)(r10 - 2), w1);
> -	"w0 = *(u16 *)(r10 - 2);"
> +	"w2 = *(u16 *)(r10 - 2);"
> +	"if r2 == r1 goto 1f;"
> +	"r0 = 1;"
> +"1:"
>   	"exit;"
>   	:
>   	: __imm_insn(store_release_insn,
> @@ -42,13 +50,17 @@ __naked void store_release_16(void)
>   
>   SEC("socket")
>   __description("store-release, 32-bit")
> -__success __success_unpriv __retval(0x12345678)
> +__success __success_unpriv __retval(0)
>   __naked void store_release_32(void)
>   {
>   	asm volatile (
> +	"r0 = 0;"
>   	"w1 = 0x12345678;"
>   	".8byte %[store_release_insn];" // store_release((u32 *)(r10 - 4), w1);
> -	"w0 = *(u32 *)(r10 - 4);"
> +	"w2 = *(u32 *)(r10 - 4);"
> +	"if r2 == r1 goto 1f;"
> +	"r0 = 1;"
> +"1:"
>   	"exit;"
>   	:
>   	: __imm_insn(store_release_insn,
> @@ -58,13 +70,17 @@ __naked void store_release_32(void)
>   
>   SEC("socket")
>   __description("store-release, 64-bit")
> -__success __success_unpriv __retval(0x1234567890abcdef)
> +__success __success_unpriv __retval(0)
>   __naked void store_release_64(void)
>   {
>   	asm volatile (
> +	"r0 = 0;"
>   	"r1 = 0x1234567890abcdef ll;"
>   	".8byte %[store_release_insn];" // store_release((u64 *)(r10 - 8), r1);
> -	"r0 = *(u64 *)(r10 - 8);"
> +	"r2 = *(u64 *)(r10 - 8);"
> +	"if r2 == r1 goto 1f;"
> +	"r0 = 1;"
> +"1:"
>   	"exit;"
>   	:
>   	: __imm_insn(store_release_insn,
Reviewed-by: Pu Lehui <pulehui@huawei.com>

