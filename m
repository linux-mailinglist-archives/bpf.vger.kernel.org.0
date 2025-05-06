Return-Path: <bpf+bounces-57522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B29AAAC75A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D734A1BA3224
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621DE28032F;
	Tue,  6 May 2025 14:04:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816B266588
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540249; cv=none; b=Tcx5eTEFrwgIBbT+2KtxH68GEhOWe23lSROixv3CJvtwINwFZ7cYFb81PAy+v3J9rz5AJTsQqmWMmwvK5RHdwRb8aqWgfbhjUxVl6zvHgpyyd11zihr/aZ7+Y5XPnobX15KwwiKr//JN2ApYIPkHdbPstsS8UhPth0juLmcPc5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540249; c=relaxed/simple;
	bh=U7t4UZ/LXdVVhjjnxov2rmO8nRADeGFjM4nDLekLFoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d2hwnGcMwDRgTRgCOkBtXuTB0JJfU/pN75X7RarcrS3fHPE80BTm2Drqru3i5H7pHhHghuhDUhOc2UxbBOMWht9glPzDC3wCMK+YsoXJHJU+4mvkaYK4mOseoOUfpNu9ydLRlkWV0cYlbBVLfKdR6Nbdn9NvymVhFx7g2z/NY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZsKqh0LNYz2TS2d;
	Tue,  6 May 2025 22:03:28 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F554140203;
	Tue,  6 May 2025 22:04:01 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 May 2025 22:03:59 +0800
Message-ID: <83698e73-3b47-4cdc-af50-c4f3ca479b7a@huawei.com>
Date: Tue, 6 May 2025 22:03:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/8] bpf/verifier: Handle BPF_LOAD_ACQ
 instructions in insn_def_regno()
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
 <2c1ec0e60974f8438730dc5126f9ed986b32a3f6.1745970908.git.yepeilin@google.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <2c1ec0e60974f8438730dc5126f9ed986b32a3f6.1745970908.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/4/30 8:50, Peilin Ye wrote:
> In preparation for supporting BPF load-acquire and store-release
> instructions for architectures where bpf_jit_needs_zext() returns true
> (e.g. riscv64), make insn_def_regno() handle load-acquires properly.
> 
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>   kernel/bpf/verifier.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 54c6953a8b84..6435ea23fee4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3649,13 +3649,16 @@ static int insn_def_regno(const struct bpf_insn *insn)
>   	case BPF_ST:
>   		return -1;
>   	case BPF_STX:
> -		if ((BPF_MODE(insn->code) == BPF_ATOMIC ||
> -		     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) &&
> -		    (insn->imm & BPF_FETCH)) {
> +		if (BPF_MODE(insn->code) == BPF_ATOMIC ||
> +		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
>   			if (insn->imm == BPF_CMPXCHG)
>   				return BPF_REG_0;
> -			else
> +			else if (insn->imm == BPF_LOAD_ACQ)
> +				return insn->dst_reg;
> +			else if (insn->imm & BPF_FETCH)
>   				return insn->src_reg;
> +			else
> +				return -1;
>   		} else {
>   			return -1;
>   		}

How about simplify like this:
```
static int insn_def_regno(const struct bpf_insn *insn)
{
         switch (BPF_CLASS(insn->code)) {
         case BPF_JMP:
         case BPF_JMP32:
         case BPF_ST:
                 return -1;
         case BPF_STX:
                 if (BPF_MODE(insn->code) == BPF_ATOMIC ||
                     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
                         if (insn->imm == BPF_CMPXCHG)
                                 return BPF_REG_0;
                         else if (insn->imm == BPF_LOAD_ACQ)
                                 return insn->dst_reg;
                         else if (insn->imm & BPF_FETCH)
                                 return insn->src_reg;
                 }
                 return -1;
         default:
                 return insn->dst_reg;
         }
}
```

