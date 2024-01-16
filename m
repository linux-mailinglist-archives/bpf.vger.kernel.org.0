Return-Path: <bpf+bounces-19609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D0A82F079
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 15:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5662EB22B02
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B6A1BF2B;
	Tue, 16 Jan 2024 14:21:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3C1BF21;
	Tue, 16 Jan 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TDrlp0PMcz4f3kFK;
	Tue, 16 Jan 2024 22:21:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BE0101A0C48;
	Tue, 16 Jan 2024 22:21:13 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgAXamzYkKZlxjsZBA--.56272S2;
	Tue, 16 Jan 2024 22:21:13 +0800 (CST)
Message-ID: <4e73b095-0c08-4a6f-b2ee-8f7a071b14ee@huaweicloud.com>
Date: Tue, 16 Jan 2024 22:21:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
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
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
 <20230919035711.3297256-5-pulehui@huaweicloud.com>
 <87lecqobyb.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87lecqobyb.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXamzYkKZlxjsZBA--.56272S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw15ZF4UJrW8Gw4DAFW8Zwb_yoW5GFWrpF
	Wak3W7Kw1vgr4Ikrn7AF48Xa95Cr4xA3W3Ar1Iqr1Fya1jkrZ2gr43GFWj9Fy8Zrn7Kw1Y
	qr4jqanxCr4DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2023/9/28 17:59, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
>> the TCC can be propagated from the parent process to the subprocess, but
>> the TCC of the parent process cannot be restored when the subprocess
>> exits. Since the RV64 TCC is initialized before saving the callee saved
>> registers into the stack, we cannot use the callee saved register to
>> pass the TCC, otherwise the original value of the callee saved register
>> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
>> similar to x86_64, i.e. using a non-callee saved register to transfer
>> the TCC between functions, and saving that register to the stack to
>> protect the TCC value. At the same time, we also consider the scenario
>> of mixing trampoline.
> 
> Hi!
> 
> The RISC-V JIT tries to minimize the stack usage, e.g. it doesn't have a
> fixed pro/epilogue like some of the other JITs. I think we can do better
> here, so that the pass-TCC-via-register can be used, and the additional
> stack access can be avoided.
> 
> Today, the TCC is passed via a register (a6) and can be viewed as a
> "state" variable/transparent argument/return value. As you point out, we
> loose this when we do a call. On (any) calls we move the TCC to a
> callee-saved register.
> 
> WDYT about the following scheme:
> 
> 1 Pickup the arm64 bpf2bpf/tailmix mechanism of just clearing the TCC
>    for the main program.
> 2 For BPF helper calls, move TCC to s6, perform the call, and restore
>    a6. Dito for kfunc calls (BPF_PSEUDO_KFUNC_CALL).
> 3 For all other calls, a6 is passed transparently.
> 
> For 2 bpf_jit_get_func_addr() can be used to determine if the callee is
> a BPF helper or not.
> 
> In summary; Determine in the JIT if we're leaving BPF-land, and need to
> move the TCC to a callee-saved reg, or not, and save us a bunch of stack
> store/loads.
> 

Valuable scheme. But we need to consider TCC back propagation. Let me 
show an example of calling subprog with TCC stored in A6:

prog1(TCC==1){
     subprog1(TCC==1)
         -> tailcall1(TCC==0)
             -> subprog2(TCC==0)
     subprog3(TCC==0) <--- should be TCC==1
         -\-> tailcall2 <--- can't be called
}

We call prog1 and TCC is 1. prog1 has two subprogs, subprog1 and 
subprog3. subprog1 calls tailcall1 and TCC become to 0. tailcall1 call 
subprog2 and then return to prog1 with TCC is 0. At this time, subprog3 
cannot call tailcall2 because TCC is 0. But TCC should be 1 here.

The question is A6 cannot be saved and restored, that is why I saved A6 
in stack at prologue, and restored at epilogue.

> 
> Björn


