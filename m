Return-Path: <bpf+bounces-57527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62261AAC7CC
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5423BFE56
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0DE2820D7;
	Tue,  6 May 2025 14:23:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8822DA1A
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541415; cv=none; b=LSNjq0XW6FaZMMiwjVqRKkSZn2DsPlywjK1l0heAiV4bt24VYu0UG/waKzrfWBQbkI5f5eX2EziMby1MUyRpsqCQsP9gJZwIzCeiLgejzNA1MaUsqHG0y8jmaliHkt6im09WAqCh1l42m3qtHppk9SWNSbelbs3YBm0l2VvTSWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541415; c=relaxed/simple;
	bh=PGDvBE2OpszmBBJmMn7fwDNTJ+QGs5Gex0qADAWXLzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z1SUkcGX8xmaQKdMvDK9XwAhhM+Ihxi03bHUvnhVUgXTP8cnMaSDoXeNs0izDr/4d6yG4/hu54U8DVHf+G8yg5cwOx3bHek5Jl+pASR/00x5LuN9fLpn5bFNt2uBsCZzpB48QN1o6b/66/se2qpo5s96vo64YlBo+cO0DWuF9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZsLG927n5zsTBf;
	Tue,  6 May 2025 22:22:57 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CF521A016C;
	Tue,  6 May 2025 22:23:31 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 May 2025 22:23:30 +0800
Message-ID: <2116c5b4-4bdd-47fd-8af1-0956f8339651@huawei.com>
Date: Tue, 6 May 2025 22:23:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: Enable non-arena
 load-acquire/store-release selftests for riscv64
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
 <755e831c84af2e7a4fc65fb52bc4724a6a7c2e53.1745970908.git.yepeilin@google.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <755e831c84af2e7a4fc65fb52bc4724a6a7c2e53.1745970908.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/4/30 8:51, Peilin Ye wrote:
> For riscv64, enable all BPF_{LOAD_ACQ,STORE_REL} selftests except the
> arena_atomics/* ones (not guarded behind CAN_USE_LOAD_ACQ_STORE_REL),
> since arena access is not yet supported.
> 
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>   tools/testing/selftests/bpf/progs/bpf_misc.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 863df7c0fdd0..6e208e24ba3b 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -225,8 +225,9 @@
>   #define CAN_USE_BPF_ST
>   #endif
>   
> -#if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) && \
> -	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86))
> +#if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) &&		\
> +	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
> +	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
>   #define CAN_USE_LOAD_ACQ_STORE_REL
>   #endif
>   
Reviewed-by: Pu Lehui <pulehui@huawei.com>

