Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F85FD32E
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 04:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJMCHm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 22:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJMCHa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 22:07:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C916EB46;
        Wed, 12 Oct 2022 19:07:17 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mnt863KHrzVhwJ;
        Thu, 13 Oct 2022 10:02:46 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 10:07:13 +0800
Message-ID: <a40bd241-6b31-1542-ff81-f4f615268d84@huawei.com>
Date:   Thu, 13 Oct 2022 10:07:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RESEND PATCH bpf-next 1/2] bpf, arm64: Jit BPF_CALL to direct
 call when possible
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <mark.rutland@arm.com>,
        <revest@chromium.org>
References: <20220919092138.1027353-1-xukuohai@huaweicloud.com>
 <20220919092138.1027353-2-xukuohai@huaweicloud.com>
 <21073277-5bbd-5555-88f2-76b07ad9b74f@iogearbox.net>
 <30bbaf09-1c2f-72fb-98cd-afe75849261c@huawei.com>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <30bbaf09-1c2f-72fb-98cd-afe75849261c@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/27/2022 10:01 PM, Xu Kuohai wrote:
> On 9/27/2022 4:29 AM, Daniel Borkmann wrote:
>> [ +Mark/Florent ]
>>
>> On 9/19/22 11:21 AM, Xu Kuohai wrote:
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> Currently BPF_CALL is always jited to indirect call, but when target is
>>> in the range of direct call, BPF_CALL can be jited to direct call.
>>>
>>> For example, the following BPF_CALL
>>>
>>>      call __htab_map_lookup_elem
>>>
>>> is always jited to an indirect call:
>>>
>>>      mov     x10, #0xffffffffffff18f4
>>>      movk    x10, #0x821, lsl #16
>>>      movk    x10, #0x8000, lsl #32
>>>      blr     x10
>>>
>>> When the target is in the range of direct call, it can be jited to:
>>>
>>>      bl      0xfffffffffd33bc98
>>>
>>> This patch does such jit when possible.
>>>
>>> 1. First pass, get the maximum jited image size. Since the jited image
>>>     memory is not allocated yet, the distance between jited BPF_CALL
>>>     instructon and call target is unknown, so jit all BPF_CALL to indirect
>>>     call to get the maximum image size.
>>>
>>> 2. Allocate image memory with the size caculated in step 1.
>>>
>>> 3. Second pass, determine the jited address and size for every bpf instruction.
>>>     Since image memory is now allocated and there is only one jit method for
>>>     bpf instructions other than BPF_CALL, so the jited address for the first
>>>     BPF_CALL is determined, so the distance to call target is determined, so
>>>     the first BPF_CALL is determined to be jited to direct or indirect call,
>>>     so the jited image size after the first BPF_CALL is determined. By analogy,
>>>     the jited addresses and sizes for all subsequent BPF instructions are
>>>     determined.
>>>
>>> 4. Last pass, generate the final image. The jump offset of jump instruction
>>>     whose target is within the jited image is determined in this pass, since
>>>     the target instruction address may be changed in step 3.
>>
>> Wouldn't this require similar convergence process like in x86-64 JIT? You state
>> the jump instructions are placed in step 4 because step 3 could have changed their
>> offsets, but then after step 4, couldn't also again the offsets have changed for
>> the target addresses from 3 again in some corner cases (given emit_a64_mov_i() is
>> used also in jump encoding)?
>>
> 
> IIUC, the reason why there is a convergence process on x86 is that x86's jmp
> instruction length varies with the size of immediate part, so after immediate
> part is adjusted, the instruction length may change accordingly, and consequently
> cause the positions of subsequent instructions to change, which in turn causes
> the distance between instructions to change. However, arm64's instruction size
> is fixed to 4 bytes and does not change with immediate part changes. So adjusting
> the immediate part of arm64 jump instruction does not result in a change in
> instruction length or position.
> 
> For BPF_CALL, arguments passed to emit_call() and emit_a64_mov_i() (if called)
> do not change in pass 3 and 4, so the jited result does not change. This is also
> true for other non-BPF_JMP instructions.
> 
> So no convergence is required on arm64.
> 

Hi Daniel,

I think I should make it more clear.

Please take a look at the following code snippet, which jits BPF_JMP instructions
to arm64 instructions.

The code can be divided into two parts: the part where instruction offset jmp_offset
is used and the part where jmp_offset is not used.

1. Lines 963-966 and lines 990-1028 use jmp_offset. We can see that no matter what
    value of jmp_offset is, the jited result is emitted either at line 965 or at
    line 1027, which is exactly one arm64 instruction, that is, the jited size is
    always 4 bytes.

2. The other lines don't use jmp_offset. We can see that the input arguments,
    including arguments passed to emit_a64_mov_i and emit_call, do not change in
    pass 3 and pass 4, so the jited result also do not change.

  961         /* JUMP off */
  962         case BPF_JMP | BPF_JA:
  963                 jmp_offset = bpf2a64_offset(i, off, ctx);
  964                 check_imm26(jmp_offset);
  965                 emit(A64_B(jmp_offset), ctx);
  966                 break;
  967         /* IF (dst COND src) JUMP off */
  968         case BPF_JMP | BPF_JEQ | BPF_X:
  969         case BPF_JMP | BPF_JGT | BPF_X:
  970         case BPF_JMP | BPF_JLT | BPF_X:
  971         case BPF_JMP | BPF_JGE | BPF_X:
  972         case BPF_JMP | BPF_JLE | BPF_X:
  973         case BPF_JMP | BPF_JNE | BPF_X:
  974         case BPF_JMP | BPF_JSGT | BPF_X:
  975         case BPF_JMP | BPF_JSLT | BPF_X:
  976         case BPF_JMP | BPF_JSGE | BPF_X:
  977         case BPF_JMP | BPF_JSLE | BPF_X:
  978         case BPF_JMP32 | BPF_JEQ | BPF_X:
  979         case BPF_JMP32 | BPF_JGT | BPF_X:
  980         case BPF_JMP32 | BPF_JLT | BPF_X:
  981         case BPF_JMP32 | BPF_JGE | BPF_X:
  982         case BPF_JMP32 | BPF_JLE | BPF_X:
  983         case BPF_JMP32 | BPF_JNE | BPF_X:
  984         case BPF_JMP32 | BPF_JSGT | BPF_X:
  985         case BPF_JMP32 | BPF_JSLT | BPF_X:
  986         case BPF_JMP32 | BPF_JSGE | BPF_X:
  987         case BPF_JMP32 | BPF_JSLE | BPF_X:
  988                 emit(A64_CMP(is64, dst, src), ctx);
  989 emit_cond_jmp:
  990                 jmp_offset = bpf2a64_offset(i, off, ctx);
  991                 check_imm19(jmp_offset);
  992                 switch (BPF_OP(code)) {
  993                 case BPF_JEQ:
  994                         jmp_cond = A64_COND_EQ;
  995                         break;
  996                 case BPF_JGT:
  997                         jmp_cond = A64_COND_HI;
  998                         break;
  999                 case BPF_JLT:
1000                         jmp_cond = A64_COND_CC;
1001                         break;
1002                 case BPF_JGE:
1003                         jmp_cond = A64_COND_CS;
1004                         break;
1005                 case BPF_JLE:
1006                         jmp_cond = A64_COND_LS;
1007                         break;
1008                 case BPF_JSET:
1009                 case BPF_JNE:
1010                         jmp_cond = A64_COND_NE;
1011                         break;
1012                 case BPF_JSGT:
1013                         jmp_cond = A64_COND_GT;
1014                         break;
1015                 case BPF_JSLT:
1016                         jmp_cond = A64_COND_LT;
1017                         break;
1018                 case BPF_JSGE:
1019                         jmp_cond = A64_COND_GE;
1020                         break;
1021                 case BPF_JSLE:
1022                         jmp_cond = A64_COND_LE;
1023                         break;
1024                 default:
1025                         return -EFAULT;
1026                 }
1027                 emit(A64_B_(jmp_cond, jmp_offset), ctx);
1028                 break;
1029         case BPF_JMP | BPF_JSET | BPF_X:
1030         case BPF_JMP32 | BPF_JSET | BPF_X:
1031                 emit(A64_TST(is64, dst, src), ctx);
1032                 goto emit_cond_jmp;
1033         /* IF (dst COND imm) JUMP off */
1034         case BPF_JMP | BPF_JEQ | BPF_K:
1035         case BPF_JMP | BPF_JGT | BPF_K:
1036         case BPF_JMP | BPF_JLT | BPF_K:
1037         case BPF_JMP | BPF_JGE | BPF_K:
1038         case BPF_JMP | BPF_JLE | BPF_K:
1039         case BPF_JMP | BPF_JNE | BPF_K:
1040         case BPF_JMP | BPF_JSGT | BPF_K:
1041         case BPF_JMP | BPF_JSLT | BPF_K:
1042         case BPF_JMP | BPF_JSGE | BPF_K:
1043         case BPF_JMP | BPF_JSLE | BPF_K:
1044         case BPF_JMP32 | BPF_JEQ | BPF_K:
1045         case BPF_JMP32 | BPF_JGT | BPF_K:
1046         case BPF_JMP32 | BPF_JLT | BPF_K:
1047         case BPF_JMP32 | BPF_JGE | BPF_K:
1048         case BPF_JMP32 | BPF_JLE | BPF_K:
1049         case BPF_JMP32 | BPF_JNE | BPF_K:
1050         case BPF_JMP32 | BPF_JSGT | BPF_K:
1051         case BPF_JMP32 | BPF_JSLT | BPF_K:
1052         case BPF_JMP32 | BPF_JSGE | BPF_K:
1053         case BPF_JMP32 | BPF_JSLE | BPF_K:
1054                 if (is_addsub_imm(imm)) {
1055                         emit(A64_CMP_I(is64, dst, imm), ctx);
1056                 } else if (is_addsub_imm(-imm)) {
1057                         emit(A64_CMN_I(is64, dst, -imm), ctx);
1058                 } else {
1059                         emit_a64_mov_i(is64, tmp, imm, ctx);
1060                         emit(A64_CMP(is64, dst, tmp), ctx);
1061                 }
1062                 goto emit_cond_jmp;
1063         case BPF_JMP | BPF_JSET | BPF_K:
1064         case BPF_JMP32 | BPF_JSET | BPF_K:
1065                 a64_insn = A64_TST_I(is64, dst, imm);
1066                 if (a64_insn != AARCH64_BREAK_FAULT) {
1067                         emit(a64_insn, ctx);
1068                 } else {
1069                         emit_a64_mov_i(is64, tmp, imm, ctx);
1070                         emit(A64_TST(is64, dst, tmp), ctx);
1071                 }
1072                 goto emit_cond_jmp;
1073         /* function call */
1074         case BPF_JMP | BPF_CALL:
1075         {
1076                 const u8 r0 = bpf2a64[BPF_REG_0];
1077                 bool func_addr_fixed;
1078                 u64 func_addr;
1079
1080                 ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
1081                                             &func_addr, &func_addr_fixed);
1082                 if (ret < 0)
1083                         return ret;
1084                 emit_call(func_addr, ctx);
1085                 emit(A64_MOV(1, r0, A64_R(0)), ctx);
1086                 break;
1087         }
1088         /* tail call */
1089         case BPF_JMP | BPF_TAIL_CALL:
1090                 if (emit_bpf_tail_call(ctx))
1091                         return -EFAULT;
1092                 break;
1093         /* function return */
1094         case BPF_JMP | BPF_EXIT:
1095                 /* Optimization: when last instruction is EXIT,
1096                    simply fallthrough to epilogue. */
1097                 if (i == ctx->prog->len - 1)
1098                         break;
1099                 jmp_offset = epilogue_offset(ctx);
1100                 check_imm26(jmp_offset);
1101                 emit(A64_B(jmp_offset), ctx);
1102                 break;

In fact, what happens in step 3 and step 4 is almost the same as what happened in
pass 1 and pass 2 before this series, where there is no convergence either.

>>> Tested with test_bpf.ko and some arm64 working selftests, nothing failed.
> 
> [...]
> 
> .

