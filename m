Return-Path: <bpf+bounces-38664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934696703B
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 09:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FE81C217AB
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 07:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134216F8E9;
	Sat, 31 Aug 2024 07:57:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3844B14A4F1;
	Sat, 31 Aug 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725091027; cv=none; b=f/3OJDS9znwak6VFAE0tBin0B7yAfp5u19krbMPQEaLi28l0pr1RKpNtN5FTQ/WR5jIsFlsNMgGUFhryDliHWjpy6IcWVtOvqlK5UsPvQPfUtULsL+4ncGLO8vrkusKnjXyVXNLOotX+a3rKzOqoVXKfU8kN410Hf0r+n3gOEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725091027; c=relaxed/simple;
	bh=6szWU4nLb963mx9nh9M5k8xWXTuIqLNSfy020SIaS4I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NsQfe0zS6XuVWB2snq0zXlWVMpNBoadwQPI/y475owLV+fX05pVNELWQFrodfU+9ZA6bHPqtEZS51nYYhZnD5vZpXkDmMdaYgHFe/U4CJPajytOqAvii3BbN2RvZAA1InWcj2fAMhmHGDxUSf23iS+Q+/KwRHotW07SgC4Lw4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WwnR1302pz4f3lDG;
	Sat, 31 Aug 2024 15:56:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0C2C71A058E;
	Sat, 31 Aug 2024 15:57:01 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCnGYDLzNJmO_LeDA--.44445S2;
	Sat, 31 Aug 2024 15:57:00 +0800 (CST)
Message-ID: <79b30c83-ee5e-453d-981e-61f826cf82d7@huaweicloud.com>
Date: Sat, 31 Aug 2024 15:57:02 +0800
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
From: Xu Kuohai <xukuohai@huaweicloud.com>
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
 <2379c139-6457-49dc-84fa-0d60ce226f2a@huaweicloud.com>
In-Reply-To: <2379c139-6457-49dc-84fa-0d60ce226f2a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnGYDLzNJmO_LeDA--.44445S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCry3Xr1rZr4UJw1DCw1rZwb_yoW5tw13pF
	W8Ca4UCr18u3yjka42g3y3JF13Jws8tw48JF93Ga4S9FWjgryFq3W2gFWakryavrs7Gwsx
	ZrnFkry0q3W2v3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/31/2024 3:26 PM, Xu Kuohai wrote:
> On 8/31/2024 12:19 PM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Currently PT_REGS_PARM1 SYSCALL(x) is consistent with PT_REGS_PARM1_CORE
>> SYSCALL(x), which will introduce the overhead of BPF_CORE_READ(), taking
>> into account the read pt_regs comes directly from the context, let's use
>> CO-RE direct read to access the first system call argument.
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   tools/lib/bpf/bpf_tracing.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
>> index e7d9382efeb3..051c408e6aed 100644
>> --- a/tools/lib/bpf/bpf_tracing.h
>> +++ b/tools/lib/bpf/bpf_tracing.h
>> @@ -222,7 +222,7 @@ struct pt_regs___s390 {
>>   struct pt_regs___arm64 {
>>       unsigned long orig_x0;
>> -};
>> +} __attribute__((preserve_access_index));
>>   /* arm64 provides struct user_pt_regs instead of struct pt_regs to userspace */
>>   #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
>> @@ -241,7 +241,7 @@ struct pt_regs___arm64 {
>>   #define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
>>   #define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
>>   #define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
>> -#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
>> +#define PT_REGS_PARM1_SYSCALL(x) (((const struct pt_regs___arm64 *)(x))->orig_x0)
>>   #define PT_REGS_PARM1_CORE_SYSCALL(x) \
>>       BPF_CORE_READ((const struct pt_regs___arm64 *)(x), __PT_PARM1_SYSCALL_REG)
> 
> Cool!
> 
> Acked-by: Xu Kuohai <xukuohai@huawei.com>
> 
> 

Wait, it breaks the following test:

--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -43,7 +43,7 @@ int BPF_KPROBE(handle_sys_prctl)

         /* test for PT_REGS_PARM */

-       bpf_probe_read_kernel(&tmp, sizeof(tmp), &PT_REGS_PARM1_SYSCALL(real_regs));
+       tmp = PT_REGS_PARM1_SYSCALL(real_regs);
         arg1 = tmp;
         bpf_probe_read_kernel(&arg2, sizeof(arg2), &PT_REGS_PARM2_SYSCALL(real_regs));
         bpf_probe_read_kernel(&arg3, sizeof(arg3), &PT_REGS_PARM3_SYSCALL(real_regs));

Failed with verifier rejection:

0: R1=ctx() R10=fp0
; int BPF_KPROBE(handle_sys_prctl) @ bpf_syscall_macro.c:33
0: (bf) r6 = r1                       ; R1=ctx() R6_w=ctx()
; pid_t pid = bpf_get_current_pid_tgid() >> 32; @ bpf_syscall_macro.c:36
1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=scalar()
; if (pid != filter_pid) @ bpf_syscall_macro.c:39
2: (18) r1 = 0xffff800082e0e000       ; R1_w=map_value(map=bpf_sysc.rodata,ks=4,vs=4)
4: (61) r1 = *(u32 *)(r1 +0)          ; R1_w=607
; pid_t pid = bpf_get_current_pid_tgid() >> 32; @ bpf_syscall_macro.c:36
5: (77) r0 >>= 32                     ; R0_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
; if (pid != filter_pid) @ bpf_syscall_macro.c:39
6: (5e) if w1 != w0 goto pc+98        ; R0_w=607 R1_w=607
; real_regs = PT_REGS_SYSCALL_REGS(ctx); @ bpf_syscall_macro.c:42
7: (79) r8 = *(u64 *)(r6 +0)          ; R6_w=ctx() R8_w=scalar()
; tmp = PT_REGS_PARM1_SYSCALL(real_regs); @ bpf_syscall_macro.c:46
8: (79) r1 = *(u64 *)(r8 +272)
R8 invalid mem access 'scalar'
processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0


