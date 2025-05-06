Return-Path: <bpf+bounces-57526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA75AAC7D1
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A2E1C42D0D
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02062820C5;
	Tue,  6 May 2025 14:23:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396027FB2F
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541408; cv=none; b=HIpJS6XfzAcDqYjO8QK/ABn19hB3x2xiJIWAUU0fIe/qXydK6RuteGJlsWPKF1sMG3CWeysdQpiXwB+GEip50R5I1aph0ciRzrSryx9qj61S2n7TSPcwwJ7r6Gb2YZMBojFbMKZdxToRAiOF5Xz/cATx7iRA0u57XcOcWpSmy6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541408; c=relaxed/simple;
	bh=xDCs6GQwxG4LHWsK77A84Vj7Ko88LFQ9HvCTFqaomjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tlo4LzhlKOG56rID8JEhuC9uj/hCkeoWB2ny2rEb1KtQcpVchZZV6fZIU4OER3M8g6Co8ShXqoA0ySauOCSf0E+QTvaL8vZS6Jr2zqjMVD0pYWLgKcx+LB60QwcZE+XWKlT7vvhnqk0zf/rAi660GU4ZSZzPCmEXygnhNT5GSnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZsL9l39XDzyTwG;
	Tue,  6 May 2025 22:19:07 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 78010140132;
	Tue,  6 May 2025 22:23:22 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 May 2025 22:23:21 +0800
Message-ID: <25395de2-6bb7-42b7-bb42-698af2a8d87b@huawei.com>
Date: Tue, 6 May 2025 22:23:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 7/8] selftests/bpf: Verify zero-extension
 behavior in load-acquire tests
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
 <9bab433f2b7e48519b26c1b8f2004635f6c179d2.1745970908.git.yepeilin@google.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <9bab433f2b7e48519b26c1b8f2004635f6c179d2.1745970908.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/4/30 8:51, Peilin Ye wrote:
> Verify that 8-, 16- and 32-bit load-acquires are zero-extending by using
> immediate values with their highest bit set.  Do the same for the 64-bit
> variant to keep the style consistent.
> 
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>   tools/testing/selftests/bpf/progs/verifier_load_acquire.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
> index a696ab84bfd6..74f4f19c10b8 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
> @@ -15,7 +15,7 @@ __naked void load_acquire_8(void)
>   {
>   	asm volatile (
>   	"r0 = 0;"
> -	"w1 = 0x12;"
> +	"w1 = 0xfe;"
>   	"*(u8 *)(r10 - 1) = w1;"
>   	".8byte %[load_acquire_insn];" // w2 = load_acquire((u8 *)(r10 - 1));
>   	"if r2 == r1 goto 1f;"
> @@ -35,7 +35,7 @@ __naked void load_acquire_16(void)
>   {
>   	asm volatile (
>   	"r0 = 0;"
> -	"w1 = 0x1234;"
> +	"w1 = 0xfedc;"
>   	"*(u16 *)(r10 - 2) = w1;"
>   	".8byte %[load_acquire_insn];" // w2 = load_acquire((u16 *)(r10 - 2));
>   	"if r2 == r1 goto 1f;"
> @@ -55,7 +55,7 @@ __naked void load_acquire_32(void)
>   {
>   	asm volatile (
>   	"r0 = 0;"
> -	"w1 = 0x12345678;"
> +	"w1 = 0xfedcba09;"
>   	"*(u32 *)(r10 - 4) = w1;"
>   	".8byte %[load_acquire_insn];" // w2 = load_acquire((u32 *)(r10 - 4));
>   	"if r2 == r1 goto 1f;"
> @@ -75,7 +75,7 @@ __naked void load_acquire_64(void)
>   {
>   	asm volatile (
>   	"r0 = 0;"
> -	"r1 = 0x1234567890abcdef ll;"
> +	"r1 = 0xfedcba0987654321 ll;"
>   	"*(u64 *)(r10 - 8) = r1;"
>   	".8byte %[load_acquire_insn];" // r2 = load_acquire((u64 *)(r10 - 8));
>   	"if r2 == r1 goto 1f;"
Reviewed-by: Pu Lehui <pulehui@huawei.com>

