Return-Path: <bpf+bounces-11028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFCC7B185E
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 12:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B1B141C209A7
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 10:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24DF33993;
	Thu, 28 Sep 2023 10:39:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C81C27;
	Thu, 28 Sep 2023 10:39:30 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A842B12A;
	Thu, 28 Sep 2023 03:39:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rx92b6X4fz4f3khw;
	Thu, 28 Sep 2023 18:39:19 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgCHHd3bVxVlJRxmBg--.31819S2;
	Thu, 28 Sep 2023 18:39:24 +0800 (CST)
Message-ID: <8fd3cb4e-bcf0-44d4-b907-7e0795ee90ce@huaweicloud.com>
Date: Thu, 28 Sep 2023 18:39:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
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
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87lecqobyb.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHHd3bVxVlJRxmBg--.31819S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1UZw45CrWkGw17tw1UZFb_yoW8ZFyxpa
	9xua17K3yvgrWSkwnFqF18JFZ5WF4fA3WYyr1aqw1Fya1UCr92gF47KF4j9a48Zrs2k3Wj
	vF4jqa1Duw4DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



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

Sorry, I am on holiday, will deal with it after the holiday.

> 
> Björn


