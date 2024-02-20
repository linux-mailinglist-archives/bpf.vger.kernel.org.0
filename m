Return-Path: <bpf+bounces-22276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6854D85B081
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 02:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC031F2261D
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 01:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634061E860;
	Tue, 20 Feb 2024 01:23:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A441D2375D;
	Tue, 20 Feb 2024 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708392180; cv=none; b=ScUhEOOIVbLTHiQ7en+6yVs16th82aArtSuQPUJaIK/Sdku5yDTTqR6qDqXhdhKmLjqx3JJRqpGao8dUwyY0aG1wIyb/ziilLQZq2XV+csZWt8zuVHMI4vfIU6nFWU4lno/UeCpIXgFVvY9JOcSbxQVlqUYjizl4zH/xomYbztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708392180; c=relaxed/simple;
	bh=99PSqupxaWhciKD6PS2xAzi9+SnpFL6NS1UK09usFKg=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=upDUv4b5RtFZL6jPGzTAxNbKnuktsHDvNvJVgjkWY0Gjdo3hWfOENamIlPTwLAxXzhmUuUXouFMm39jNVzpYOy8xek/bM7WPZFadRl52sLjDb6g4A/JQnjfZAIvpdUDulolfVx7susHChJgLvOamSrdQ7vexJiHVDVYN0vLoONE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Ax++ju_tNlFNMOAA--.19552S3;
	Tue, 20 Feb 2024 09:22:54 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX8_l_tNlG2M8AA--.23719S3;
	Tue, 20 Feb 2024 09:22:46 +0800 (CST)
Subject: Re: [PATCH bpf-next 2/2] bpf: Take return from set_memory_rox() into
 account with bpf_jit_binary_lock_ro()
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Puranjay Mohan <puranjay12@gmail.com>, Zi Shen Lim <zlim.lnx@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Hengqi Chen <hengqi.chen@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Johan Almbladh <johan.almbladh@anyfinetworks.com>,
 Paul Burton <paulburton@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Wang YanQing <udknight@gmail.com>, David Ahern <dsahern@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
 <ec35e06dbe8672a36415ebe2b9273277c2921977.1708253445.git.christophe.leroy@csgroup.eu>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 netdev@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 "linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <326d7b90-614f-ec2d-e224-5d325c06a349@loongson.cn>
Date: Tue, 20 Feb 2024 09:22:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ec35e06dbe8672a36415ebe2b9273277c2921977.1708253445.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8AxX8_l_tNlG2M8AA--.23719S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWrW8GFy7ur13Jr17JrWxZrc_yoW5Aw17pF
	9rZwnrCr4vgr4UWFsFk3WUXFZ3Z397Ka47urya9ryjg3Z0qF1kuayfKw1SgFW3ArWUXa18
	Xa1vgryUuaykA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUjx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_GFv_Wryle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b8YL9UUU
	UU=

On 02/18/2024 06:55 PM, Christophe Leroy wrote:
> set_memory_rox() can fail, leaving memory unprotected.
>
> Check return and bail out when bpf_jit_binary_lock_ro() returns
> and error.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---

...

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index e73323d759d0..aafc5037fd2b 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1294,16 +1294,18 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	flush_icache_range((unsigned long)header, (unsigned long)(ctx.image + ctx.idx));
>
>  	if (!prog->is_func || extra_pass) {
> +		int err;
> +
>  		if (extra_pass && ctx.idx != jit_data->ctx.idx) {
>  			pr_err_once("multi-func JIT bug %d != %d\n",
>  				    ctx.idx, jit_data->ctx.idx);
> -			bpf_jit_binary_free(header);
> -			prog->bpf_func = NULL;
> -			prog->jited = 0;
> -			prog->jited_len = 0;
> -			goto out_offset;
> +			goto out_free;
> +		}
> +		err = bpf_jit_binary_lock_ro(header);
> +		if (err) {
> +			pr_err_once("bpf_jit_binary_lock_ro() returned %d\n", err);
> +			goto out_free;
>  		}
> -		bpf_jit_binary_lock_ro(header);
>  	} else {
>  		jit_data->ctx = ctx;
>  		jit_data->image = image_ptr;
> @@ -1334,6 +1336,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	out_offset = -1;
>
>  	return prog;
> +
> +out_free:
> +	bpf_jit_binary_free(header);
> +	prog->bpf_func = NULL;
> +	prog->jited = 0;
> +	prog->jited_len = 0;
> +	goto out_offset;
>  }
>
>  /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */

...

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index fc0994dc5c72..314414fa6d70 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -892,10 +892,10 @@ static inline int __must_check bpf_prog_lock_ro(struct bpf_prog *fp)
>  	return 0;
>  }
>
> -static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
> +static inline int __must_check bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
>  {
>  	set_vm_flush_reset_perms(hdr);
> -	set_memory_rox((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
> +	return set_memory_rox((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
>  }
>
>  int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap);

LoongArch does not select CONFIG_ARCH_HAS_SET_MEMORY, set_memory_ro()
and set_memory_x() always return 0, then set_memory_rox() also returns
0, that is to say, bpf_jit_binary_lock_ro() will return 0, it seems
that there is no obvious effect for LoongArch with this patch.

But once CONFIG_ARCH_HAS_SET_MEMORY is selected and the arch-specified
set_memory_*() functions are implemented in the future, it is necessary
to handle the error cases. At least, in order to keep consistent with
the other archs, the code itself looks good to me.

Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>  # LoongArch

Thanks,
Tiezhu


