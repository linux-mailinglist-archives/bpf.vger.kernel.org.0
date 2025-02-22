Return-Path: <bpf+bounces-52248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6E6A406E4
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 10:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EAA188F8B2
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9EA206F25;
	Sat, 22 Feb 2025 09:29:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D25206F05;
	Sat, 22 Feb 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740216543; cv=none; b=q8vy+8whm1E/eAD+yzmYbwzp8aKfPtGe7dfEEsDeyCMxxUu9gv1yEv/QG4BZr4/3S6Zt0wPL9PSU1k1j6OJTY8Izffc+d/eCDv612J3akERu7REHBdvdK7kNLbNEoDmZYwKsigrkyjG/e8e5wUfUSTAGrzwGHTYwjJxaktCeMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740216543; c=relaxed/simple;
	bh=ms5pSSFmIOmQvVu82XxWFNYfE4nlmDqgurq5VgbvlcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXu9uwSqTcUwRKWUbKDqXgCGDiTiCopfZs/XC5gxIkCctha+kU87kgR9RXUgAe5Z66MWMxNS58t8R1bP+S0e/r/0Z0C6vcyNLl+dTqmjn0pKwOyeiEUh9GPsT9wXLTWj6BC6/9+PTwLqyXspaaPiMsNTCboJBbLW5nzpFlkp3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z0MB95cbzz4f3lDc;
	Sat, 22 Feb 2025 17:28:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DEC701A06DC;
	Sat, 22 Feb 2025 17:28:56 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgCHN3jYmLlnfioGEg--.56407S2;
	Sat, 22 Feb 2025 17:28:56 +0800 (CST)
Message-ID: <02ef4695-c9d6-4867-a25a-7d9e617f9c48@huaweicloud.com>
Date: Sat, 22 Feb 2025 17:28:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 5/9] arm64: insn: Add BIT(23) to
 {load,store}_ex's mask
Content-Language: en-US
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: bpf@ietf.org, Eduard Zingerman <eddyz87@gmail.com>,
 David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan
 <puranjay@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Yingchi Long <longyingchi24s@ict.ac.cn>, Josh Don <joshdon@google.com>,
 Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>,
 Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
References: <cover.1740009184.git.yepeilin@google.com>
 <6888a87af6ea47ea29d429b91a57cb146d1f69c8.1740009184.git.yepeilin@google.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <6888a87af6ea47ea29d429b91a57cb146d1f69c8.1740009184.git.yepeilin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHN3jYmLlnfioGEg--.56407S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1kKF4kuryrWryxXr1kZrb_yoW8Ww15p3
	93Zr4rCF48Cr15G3W3JF17W3yFqF4FyF45G34UCryFka45tF1jqr1jgr12vF4kGr4jgF4F
	va429F10vrWUC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUsPfHUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 2/20/2025 9:21 AM, Peilin Ye wrote:
> We are planning to add load-acquire (LDAR{,B,H}) and store-release
> (STLR{,B,H}) instructions to insn.{c,h}; add BIT(23) to mask of load_ex
> and store_ex to prevent aarch64_insn_is_{load,store}_ex() from returning
> false-positives for load-acquire and store-release instructions.
> 
> Reference: Arm Architecture Reference Manual (ARM DDI 0487K.a,
>             ID032224),
> 
>    * C6.2.228 LDXR
>    * C6.2.165 LDAXR
>    * C6.2.161 LDAR
>    * C6.2.393 STXR
>    * C6.2.360 STLXR
>    * C6.2.353 STLR
> 
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>   arch/arm64/include/asm/insn.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index e390c432f546..2d8316b3abaf 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -351,8 +351,8 @@ __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
>   __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
>   __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
>   __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
> -__AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
> -__AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)
> +__AARCH64_INSN_FUNCS(load_ex,	0x3FC00000, 0x08400000)
> +__AARCH64_INSN_FUNCS(store_ex,	0x3FC00000, 0x08000000)
>   __AARCH64_INSN_FUNCS(mops,	0x3B200C00, 0x19000400)
>   __AARCH64_INSN_FUNCS(stp,	0x7FC00000, 0x29000000)
>   __AARCH64_INSN_FUNCS(ldp,	0x7FC00000, 0x29400000)


Looks good to me

Acked-by: Xu Kuohai <xukuohai@huawei.com>


