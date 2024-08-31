Return-Path: <bpf+bounces-38663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA09967010
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 09:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF731C21A64
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A31B16EB54;
	Sat, 31 Aug 2024 07:26:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079DB33981;
	Sat, 31 Aug 2024 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725089212; cv=none; b=WYRNzJTnnKTwB4gB3QNIL5jtwWchY68svkoS7z9fk6EeJgNGp/Dv5qE3yHvf0WLOctU/2N96MGLXxAv+5/gs40PXRkUM+IB9F+M3l591ecV8SUkaoD/+1O0Uhg1xo1+yjc8pBXOJGF/uX5FctKmcocirAKqty0l1n9ROIbEgroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725089212; c=relaxed/simple;
	bh=nuHI7HnFliMd8Dt+eIqeDoMrC7klDw8n++rsR6rI6Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mD//dZXaxFhGK1/wIWDOVNWhXokwAW0XwvjRWgn0PSuFtddnRr0bmIkJeWvpNfCSfQufTNpQTUiZzQOIfyi65d1L0pRC4g3F5Vy2F2Z92lm+bVAMHVHZckYa3M39u6FmKleQI6SB1GY425TjUuEM2Lw8VZZkpuMsGaj2h4w/lhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wwmm52kkpz4f3l2C;
	Sat, 31 Aug 2024 15:26:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0403A1A018D;
	Sat, 31 Aug 2024 15:26:45 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgAHPLuzxdJmcpHTDA--.9841S2;
	Sat, 31 Aug 2024 15:26:44 +0800 (CST)
Message-ID: <2379c139-6457-49dc-84fa-0d60ce226f2a@huaweicloud.com>
Date: Sat, 31 Aug 2024 15:26:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/4] libbpf: Access first syscall argument
 with CO-RE direct read on arm64
Content-Language: en-US
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
References: <20240831041934.1629216-1-pulehui@huaweicloud.com>
 <20240831041934.1629216-3-pulehui@huaweicloud.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20240831041934.1629216-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAHPLuzxdJmcpHTDA--.9841S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4DAr13tFWDGw47Kr4DArb_yoW8WFWrpa
	yUCa4UKw18Ww4jkasrKF4avrW3tws3trnrCFZ7W3yS9FWUK3yrWa42grs0kw4ay3yUtw4Y
	vr9Fkr18G3W7Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/31/2024 12:19 PM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Currently PT_REGS_PARM1 SYSCALL(x) is consistent with PT_REGS_PARM1_CORE
> SYSCALL(x), which will introduce the overhead of BPF_CORE_READ(), taking
> into account the read pt_regs comes directly from the context, let's use
> CO-RE direct read to access the first system call argument.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   tools/lib/bpf/bpf_tracing.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index e7d9382efeb3..051c408e6aed 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -222,7 +222,7 @@ struct pt_regs___s390 {
>   
>   struct pt_regs___arm64 {
>   	unsigned long orig_x0;
> -};
> +} __attribute__((preserve_access_index));
>   
>   /* arm64 provides struct user_pt_regs instead of struct pt_regs to userspace */
>   #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
> @@ -241,7 +241,7 @@ struct pt_regs___arm64 {
>   #define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
>   #define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
>   #define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
> -#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
> +#define PT_REGS_PARM1_SYSCALL(x) (((const struct pt_regs___arm64 *)(x))->orig_x0)
>   #define PT_REGS_PARM1_CORE_SYSCALL(x) \
>   	BPF_CORE_READ((const struct pt_regs___arm64 *)(x), __PT_PARM1_SYSCALL_REG)
>   

Cool!

Acked-by: Xu Kuohai <xukuohai@huawei.com>


