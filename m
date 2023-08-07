Return-Path: <bpf+bounces-7191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F7C772D89
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 20:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F237280F29
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4A5156F5;
	Mon,  7 Aug 2023 18:09:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D1414A93
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 18:09:46 +0000 (UTC)
Received: from out-77.mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C67171E
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 11:09:44 -0700 (PDT)
Message-ID: <9207911d-65b4-f874-3dcb-52d0c0a4950f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691431783; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiMCJQvBwmGZzCubvzQ9nvDlPtCBq1jGBQ90JT2c/tY=;
	b=tiMLNCvgcNMIiukNEN8tmcRYRkxeOAvZogkEJwjm0GiWWuT/TxmX2YckOvt01qfEpt00sZ
	kieP+x41URdNQeQBxYWOlSikueNTHsyr2u7NCxKeqQ5MoIN3gDsfx6882EYmuO/kygRTuj
	vZAfFDveynOt3R+clAQ9WgEfevjD7Nk=
Date: Mon, 7 Aug 2023 11:09:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in
 ieee802154_subif_start_xmit
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>,
 syzbot <syzbot+d61b595e9205573133b3@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
 hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000002098bc0602496cc3@google.com>
 <d520bd6c-bfd3-47f1-c794-ab451905256b@linux.dev>
 <9c8f04a0bf90db4bb8e6192824ab71f58244b74b.camel@gmail.com>
 <bc69afd6-6eec-a070-ab96-05ab137aaf0b@linux.dev>
 <72e2ff187fb8cd031a6330e4c3cd8e66a0590fc1.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <72e2ff187fb8cd031a6330e4c3cd8e66a0590fc1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/7/23 7:45 AM, Eduard Zingerman wrote:
> On Mon, 2023-08-07 at 07:40 -0700, Yonghong Song wrote:
>>
>> On 8/7/23 6:11 AM, Eduard Zingerman wrote:
>>> On Sun, 2023-08-06 at 23:40 -0700, Yonghong Song wrote:
>>>>
>>>> On 8/6/23 4:23 PM, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    25ad10658dc1 riscv, bpf: Adapt bpf trampoline to optimized..
>>>>> git tree:       bpf-next
>>>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=147cbb29a80000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8acaeb93ad7c6aaa
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=d61b595e9205573133b3
>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d73ccea80000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1276aedea80000
>>>>>
>>>>> Downloadable assets:
>>>>> disk image: https://storage.googleapis.com/syzbot-assets/3d378cc13d42/disk-25ad1065.raw.xz
>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/44580fd5d1af/vmlinux-25ad1065.xz
>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/840587618b41/bzImage-25ad1065.xz
>>>>>
>>>>> The issue was bisected to:
>>>>>
>>>>> commit 8100928c881482a73ed8bd499d602bab0fe55608
>>>>> Author: Yonghong Song <yonghong.song@linux.dev>
>>>>> Date:   Fri Jul 28 01:12:02 2023 +0000
>>>>>
>>>>>        bpf: Support new sign-extension mov insns
>>>>
>>>> Thanks for reporting. I will look into this ASAP.
>>>
>>> Hi Yonghong,
>>>
>>> I guess it's your night and my morning, so I did some initial assessment.
>>> The BPF program being loaded is:
>>>
>>>     0 : (62) *(u32 *)(r10 -8) = 553656332
>>>     1 : (bf) r1 = (s16)r10
>>>     2 : (07) r1 += -8
>>>     3 : (b7) r2 = 3
>>>     4 : (bd) if r2 <= r1 goto pc+0
>>>     5 : (85) call bpf_trace_printk#6
>>>     6 : (b7) r0 = 0
>>>     7 : (95) exit
>>>
>>> (Note: when using bpftool (prog dump xlated id <some-id>) the disassembly
>>>    of the instruction #1 is incorrectly printed as "1: (bf) r1 = r10")
>>>    
>>> The error occurs when instruction #5 (call to printk) is executed.
>>> An incorrect address for the format string is passed to printk.
>>> Disassembly of the jited program looks as follows:
>>>
>>>     $ bpftool prog dump jited id <some-id>
>>>     bpf_prog_ebeed182d92b487f:
>>>        0: nopl    (%rax,%rax)
>>>        5: nop
>>>        7: pushq   %rbp
>>>        8: movq    %rsp, %rbp
>>>        b: subq    $8, %rsp
>>>       12: movl    $553656332, -8(%rbp)
>>>       19: movswq  %bp, %rdi            ; <---- Note movswq %bp !
>>>       1d: addq    $-8, %rdi
>>>       21: movl    $3, %esi
>>>       26: cmpq    %rdi, %rsi
>>>       29: jbe 0x2b
>>>       2b: callq   0xffffffffe11c484c
>>>       30: xorl    %eax, %eax
>>>       32: leave
>>>       33: retq
>>>
>>> Note jit instruction #19 corresponding to BPF instruction #1, which
>>> loads truncated and sign-extended value of %rbp's first byte as an
>>> address of format string.
>>>
>>> Here is how verifier log looks for (slightly modified) program:
>>>
>>>     func#0 @0
>>>     0: R1=ctx(off=0,imm=0) R10=fp0
>>>     ; asm volatile ("			\n\
>>>     0: (b7) r1 = 553656332                ; R1_w=553656332
>>>     1: (63) *(u32 *)(r10 -8) = r1         ; R1_w=553656332 R10=fp0 fp-8=553656332
>>>     2: (bf) r1 = (s16)r10                 ; R1_w=fp0 R10=fp0
>>>     3: (07) r1 += -8                      ; R1_w=fp-8
>>>     4: (b7) r2 = 3                        ; R2_w=3
>>>     5: (bd) if r2 <= r1 goto pc+0         ; R1_w=fp-8 R2_w=3
>>>     6: (85) call bpf_trace_printk#6
>>>     mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1
>>>     ...
>>>     mark_precise: frame0: falling back to forcing all scalars precise
>>>     7: R0=scalar()
>>>     7: (b7) r0 = 0                        ; R0_w=0
>>>     8: (95) exit
>>>     
>>>     from 5 to 6: R1_w=fp-8 R2_w=3 R10=fp0 fp-8=553656332
>>>     6: (85) call bpf_trace_printk#6
>>>     mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1
>>>     ...
>>>     mark_precise: frame0: falling back to forcing all scalars precise
>>>     7: safe
>>>
>>> Note the following line:
>>>
>>>     2: (bf) r1 = (s16)r10                 ; R1_w=fp0 R10=fp0
>>>
>>> Verifier incorrectly marked r1 as fp0, hence not noticing the problem
>>> with address passed to printk.
>>
>> Thanks, Eduard. Right. I am also able to dump xlated code like
>> below:
>>
>>      0: (62) *(u32 *)(r10 -8) = 553656332
>>      1: (bf) r1 = (s16)r10
>>      2: (07) r1 += -8
>>      3: (b7) r2 = 3
>>      4: (bd) if r2 <= r1 goto pc+0
>>      5: (85) call bpf_trace_printk#-138320
>>      6: (b7) r0 = 0
>>      7: (95) exit
>>
>> Something like below can fix the problem,
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 132f25dab931..db72619551b2 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -13171,6 +13171,7 @@ static int check_alu_op(struct bpf_verifier_env
>> *env, struct bpf_insn *insn)
>>                                           if (no_sext && need_id)
>>                                                   src_reg->id =
>> ++env->id_gen;
>>                                           copy_register_state(dst_reg,
>> src_reg);
>> +                                       dst_reg->type = SCALAR_VALUE;
>>                                           if (!no_sext)
>>                                                   dst_reg->id = 0;
>>                                           coerce_reg_to_size_sx(dst_reg,
>> insn->off >> 3);
>>
>> After insn 1, we need change r1 type to SCALAR_VALUE. Will add
>> the the test to selftest and submit the patch to fix the problem
>> today.
> 
> Should this be an error?
> Like in the same function but slightly below, when u32 moves are
> processed:
> 
>      /* R1 = (u32) R2 */
>      if (is_pointer_value(env, insn->src_reg)) {
>          verbose(env,
>              "R%d partial copy of pointer\n",
>              insn->src_reg);
>          return -EACCES;
>      } else { ...

Right, this is indeed better for unprivileged prog run.
I have submitted a patch to fix the issue reported by syzbot.
Please help review. Thanks!

> 
>>
>>>
>>> Thanks,
>>> Eduard.
>>>
>>>>>
>>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17970c5da80000
>>>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14570c5da80000
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10570c5da80000
>>>>>
>> [...]
> 
> 

