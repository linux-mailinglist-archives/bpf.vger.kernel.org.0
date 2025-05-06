Return-Path: <bpf+bounces-57524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAE0AAC7CE
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1361C42180
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43C128137C;
	Tue,  6 May 2025 14:23:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208F278E5D
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541385; cv=none; b=uCbKbjOnNjWNVb8hFRy53ORRwN6AgNu/RCATeakYpk+BqIPHHsBwdKoebvc3V3fRnd9Beo3ktCUVAmzWDNyxvGep2QE0seZXdo2GgzwOsY0C4ZNDwgUQzuuCN/rfWJ9BOOFlsNnMcy6ZMAcrq5Sy8yIPx86Ggp5LnzZCR16G6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541385; c=relaxed/simple;
	bh=AFbF0u0VVM4EJch0dtc2dQmK4V0tirU1QHumRPbCzD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iKnH8+2iyD0Bbga1ZckWQK8+EzFCd4TURjqRMIM5CR9VCgB8I/Ni98oIaRrp1i/0dy351BiMLMyoYswgmsJpRRIXqIfzU64RschxrLBQWYuBMgI/qqw2tT8Wjp38K+BcuD+olJJAJHjmL6+uxg8kQJysGWNYAj7V8O8RdyVcFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZsLDY29N5znfZy;
	Tue,  6 May 2025 22:21:33 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id BFBD11800B1;
	Tue,  6 May 2025 22:22:51 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 May 2025 22:22:50 +0800
Message-ID: <6d9f8333-a14a-468a-83ef-4562e54eb60e@huawei.com>
Date: Tue, 6 May 2025 22:22:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 5/8] selftests/bpf: Use
 CAN_USE_LOAD_ACQ_STORE_REL when appropriate
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
 <ca441a13f5ad4a34ddb622cb5b2616b309d59694.1745970908.git.yepeilin@google.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <ca441a13f5ad4a34ddb622cb5b2616b309d59694.1745970908.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/4/30 8:51, Peilin Ye wrote:
> Instead of open-coding the conditions, use
> '#ifdef CAN_USE_LOAD_ACQ_STORE_REL' to guard the following tests:
> 
>    verifier_precision/bpf_load_acquire
>    verifier_precision/bpf_store_release
>    verifier_store_release/*
> 
> Note that, for the first two tests in verifier_precision.c, switching to
> '#ifdef CAN_USE_LOAD_ACQ_STORE_REL' means also checking if
> '__clang_major__ >= 18', which has already been guaranteed by the outer
> '#if' check.
> 
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>   tools/testing/selftests/bpf/progs/verifier_precision.c     | 5 ++---
>   tools/testing/selftests/bpf/progs/verifier_store_release.c | 7 +++----
>   2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
> index 6662d4b39969..2dd0d15c2678 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
> @@ -91,8 +91,7 @@ __naked int bpf_end_bswap(void)
>   		::: __clobber_all);
>   }
>   
> -#if defined(ENABLE_ATOMICS_TESTS) && \
> -	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86))
> +#ifdef CAN_USE_LOAD_ACQ_STORE_REL
>   
>   SEC("?raw_tp")
>   __success __log_level(2)
> @@ -138,7 +137,7 @@ __naked int bpf_store_release(void)
>   	: __clobber_all);
>   }
>   
> -#endif /* load-acquire, store-release */
> +#endif /* CAN_USE_LOAD_ACQ_STORE_REL */
>   #endif /* v4 instruction */
>   
>   SEC("?raw_tp")
> diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/tools/testing/selftests/bpf/progs/verifier_store_release.c
> index c0442d5bb049..7e456e2861b4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
> @@ -6,8 +6,7 @@
>   #include "../../../include/linux/filter.h"
>   #include "bpf_misc.h"
>   
> -#if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) && \
> -	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86))
> +#ifdef CAN_USE_LOAD_ACQ_STORE_REL
>   
>   SEC("socket")
>   __description("store-release, 8-bit")
> @@ -271,7 +270,7 @@ __naked void store_release_with_invalid_reg(void)
>   	: __clobber_all);
>   }
>   
> -#else
> +#else /* CAN_USE_LOAD_ACQ_STORE_REL */
>   
>   SEC("socket")
>   __description("Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support store-release, use a dummy test")
> @@ -281,6 +280,6 @@ int dummy_test(void)
>   	return 0;
>   }
>   
> -#endif
> +#endif /* CAN_USE_LOAD_ACQ_STORE_REL */
>   
>   char _license[] SEC("license") = "GPL";
Reviewed-by: Pu Lehui <pulehui@huawei.com>

