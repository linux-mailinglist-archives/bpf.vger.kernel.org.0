Return-Path: <bpf+bounces-20008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E181836595
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 15:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF84287348
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 14:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2183D554;
	Mon, 22 Jan 2024 14:38:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C23D0A8;
	Mon, 22 Jan 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934284; cv=none; b=clmWln9Q2tSPQH3OJU+bPv/0tPh4KUd/pvmxKGbSsQEsu8vI50RCeM4hxKhsvipoxSJcFG+1bo47zSx4/ApkT+sYJmBoT9/7a21d5na8tDy7EF5QDdwOr22f0EdfrcypulJvy96STGZZNXoG/9aeZeaZpnhJThgJNRv8s4FGzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934284; c=relaxed/simple;
	bh=Asbn0FbDDiZZq6QRKMuE7b0RhZ2cnN4ua72xQ3XRjas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La9UkJrnq5x7MkYCSzncJks5aCLqF/W0swV3wH969N5eKbkWUplhqZOOjIqPjaSPqHFiZ6bsxZzdT3jr8aZw39rxOldIVf5MKpnQ+/R2OWoF3Okik/RXXPnu9KpmcDCiPNA9ES4tVamoFgGKZpIxYn0GklnW567Ps1VzNWT7b5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TJXrN12B6z4f3jqS;
	Mon, 22 Jan 2024 22:37:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6E6AD1A0232;
	Mon, 22 Jan 2024 22:37:58 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgC3iBHEfa5ltWuLBg--.55325S2;
	Mon, 22 Jan 2024 22:37:58 +0800 (CST)
Message-ID: <baffbab8-721f-462a-8b58-64972f5eae70@huaweicloud.com>
Date: Mon, 22 Jan 2024 22:37:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND bpf-next v3 0/6] Zbb support and code
 simplification for RV64 JIT
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
 Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <87il3lqvye.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87il3lqvye.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3iBHEfa5ltWuLBg--.55325S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr47Zw1rtr1xGF4kuFW5GFg_yoW8uF4Dpa
	n5Kwn0kF1vq3WDWry0qa18XF13t3yvq3srGFWFgrWF9a9IqrykKF15ta4Yy34ayrsY9r43
	AFZ093Wqy3W8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/1/22 22:33, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> Add Zbb support [0] to optimize code size and performance of RV64 JIT.
>> Meanwhile, adjust the code for unification and simplification. Tests
>> test_bpf.ko and test_verifier have passed, as well as the relative
>> testcases of test_progs*.
>>
>> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0-38-g865e7a7.pdf [0]
>>
>> v3 resend:
>> - resend for mail be treated as spam.
>>
>> v3:
>> - Change to early-exit code style and make code more explicit.
> 
> Lehui,
> 
> Sorry for the delay. I'm chasing a struct_ops RISC-V BPF regression in
> 6.8-rc1, I will need to wrap my head around that prior reviewing
> properly.
> 

Oh, I also found the problem with struct ops and fixed it

diff --git a/arch/riscv/net/bpf_jit_comp64.c 
b/arch/riscv/net/bpf_jit_comp64.c
index 42cfd1ed295e..5c4e0ac389d0 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -795,6 +795,7 @@ static int __arch_prepare_bpf_trampoline(struct 
bpf_tramp_image *im,
         struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
         struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
         struct bpf_tramp_links *fmod_ret = 
&tlinks[BPF_TRAMP_MODIFY_RETURN];
+       bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
         void *orig_call = func_addr;
         bool save_ret;
         u32 insn;
@@ -878,7 +879,7 @@ static int __arch_prepare_bpf_trampoline(struct 
bpf_tramp_image *im,

         stack_size = round_up(stack_size, 16);

-       if (func_addr) {
+       if (!is_struct_ops) {
                 /* For the trampoline called from function entry,
                  * the frame of traced function and the frame of
                  * trampoline need to be considered.
@@ -998,7 +999,7 @@ static int __arch_prepare_bpf_trampoline(struct 
bpf_tramp_image *im,

         emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);

-       if (func_addr) {
+       if (!is_struct_ops) {
                 /* trampoline called from function entry */
                 emit_ld(RV_REG_T0, stack_size - 8, RV_REG_SP, ctx);
                 emit_ld(RV_REG_FP, stack_size - 16, RV_REG_SP, ctx);

> 
> Björn


