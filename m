Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6410421E63
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 07:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhJEFsf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 01:48:35 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:53521 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231142AbhJEFsd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 01:48:33 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HNmmf3g9gz9sVN;
        Tue,  5 Oct 2021 07:46:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WUUh7mSj-d3s; Tue,  5 Oct 2021 07:46:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HNmmf2SGlz9sV4;
        Tue,  5 Oct 2021 07:46:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3894C8B770;
        Tue,  5 Oct 2021 07:46:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Dn0FEY3zgrb3; Tue,  5 Oct 2021 07:46:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.122])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 620958B765;
        Tue,  5 Oct 2021 07:46:41 +0200 (CEST)
Subject: Re: [PATCH 4/9] powerpc/bpf: Handle large branch ranges with BPF_EXIT
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
 <ebc0317ce465cb4f8d6fe485ab468ac5bda7c48f.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
 <e37766fd-8c52-6961-39a8-2de44a769204@csgroup.eu>
 <1633371632.j9hqy0kjhu.naveen@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a63a7b97-08cd-b93e-bc12-d17cd6e94229@csgroup.eu>
Date:   Tue, 5 Oct 2021 07:46:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1633371632.j9hqy0kjhu.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 04/10/2021 à 20:24, Naveen N. Rao a écrit :
> Christophe Leroy wrote:
>>
>>
>> Le 01/10/2021 à 23:14, Naveen N. Rao a écrit :
>>> In some scenarios, it is possible that the program epilogue is outside
>>> the branch range for a BPF_EXIT instruction. Instead of rejecting such
>>> programs, emit an indirect branch. We track the size of the bpf program
>>> emitted after the initial run and do a second pass since BPF_EXIT can
>>> end up emitting different number of instructions depending on the
>>> program size.
>>>
>>> Suggested-by: Jordan Niethe <jniethe5@gmail.com>
>>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/net/bpf_jit.h        |  3 +++
>>>   arch/powerpc/net/bpf_jit_comp.c   | 22 +++++++++++++++++++++-
>>>   arch/powerpc/net/bpf_jit_comp32.c |  2 +-
>>>   arch/powerpc/net/bpf_jit_comp64.c |  2 +-
>>>   4 files changed, 26 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
>>> index 89bd744c2bffd4..4023de1698b9f5 100644
>>> --- a/arch/powerpc/net/bpf_jit.h
>>> +++ b/arch/powerpc/net/bpf_jit.h
>>> @@ -126,6 +126,7 @@
>>>   #define SEEN_FUNC    0x20000000 /* might call external helpers */
>>>   #define SEEN_TAILCALL    0x40000000 /* uses tail calls */
>>> +#define SEEN_BIG_PROG    0x80000000 /* large prog, >32MB */
>>>   #define SEEN_VREG_MASK    0x1ff80000 /* Volatile registers r3-r12 */
>>>   #define SEEN_NVREG_MASK    0x0003ffff /* Non volatile registers 
>>> r14-r31 */
>>> @@ -179,6 +180,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 
>>> *image, struct codegen_context *
>>>   void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
>>>   void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
>>>   void bpf_jit_realloc_regs(struct codegen_context *ctx);
>>> +int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx,
>>> +                    int tmp_reg, unsigned long exit_addr);
>>>   #endif
>>> diff --git a/arch/powerpc/net/bpf_jit_comp.c 
>>> b/arch/powerpc/net/bpf_jit_comp.c
>>> index fcbf7a917c566e..3204872fbf2738 100644
>>> --- a/arch/powerpc/net/bpf_jit_comp.c
>>> +++ b/arch/powerpc/net/bpf_jit_comp.c
>>> @@ -72,6 +72,21 @@ static int bpf_jit_fixup_subprog_calls(struct 
>>> bpf_prog *fp, u32 *image,
>>>       return 0;
>>>   }
>>> +int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx,
>>> +                    int tmp_reg, unsigned long exit_addr)
>>> +{
>>> +    if (!(ctx->seen & SEEN_BIG_PROG) && 
>>> is_offset_in_branch_range(exit_addr)) {
>>> +        PPC_JMP(exit_addr);
>>> +    } else {
>>> +        ctx->seen |= SEEN_BIG_PROG;
>>> +        PPC_FUNC_ADDR(tmp_reg, (unsigned long)image + exit_addr);
>>> +        EMIT(PPC_RAW_MTCTR(tmp_reg));
>>> +        EMIT(PPC_RAW_BCTR());
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   struct powerpc64_jit_data {
>>>       struct bpf_binary_header *header;
>>>       u32 *addrs;
>>> @@ -155,12 +170,17 @@ struct bpf_prog *bpf_int_jit_compile(struct 
>>> bpf_prog *fp)
>>>           goto out_addrs;
>>>       }
>>> +    if (!is_offset_in_branch_range((long)cgctx.idx * 4))
>>> +        cgctx.seen |= SEEN_BIG_PROG;
>>> +
>>>       /*
>>>        * If we have seen a tail call, we need a second pass.
>>>        * This is because bpf_jit_emit_common_epilogue() is called
>>>        * from bpf_jit_emit_tail_call() with a not yet stable ctx->seen.
>>> +     * We also need a second pass if we ended up with too large
>>> +     * a program so as to fix branches.
>>>        */
>>> -    if (cgctx.seen & SEEN_TAILCALL) {
>>> +    if (cgctx.seen & (SEEN_TAILCALL | SEEN_BIG_PROG)) {
>>>           cgctx.idx = 0;
>>>           if (bpf_jit_build_body(fp, 0, &cgctx, addrs, false)) {
>>>               fp = org_fp;
>>> diff --git a/arch/powerpc/net/bpf_jit_comp32.c 
>>> b/arch/powerpc/net/bpf_jit_comp32.c
>>> index a74d52204f8da2..d2a67574a23066 100644
>>> --- a/arch/powerpc/net/bpf_jit_comp32.c
>>> +++ b/arch/powerpc/net/bpf_jit_comp32.c
>>> @@ -852,7 +852,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 
>>> *image, struct codegen_context *
>>>                * we'll just fall through to the epilogue.
>>>                */
>>>               if (i != flen - 1)
>>> -                PPC_JMP(exit_addr);
>>> +                bpf_jit_emit_exit_insn(image, ctx, tmp_reg, exit_addr);
>>
>> On ppc32, if you use tmp_reg you must flag it. But I think you could 
>> use r0 instead.
> 
> Indeed. Can we drop tracking of the temp registers and using them while
> remapping registers? Are you seeing significant benefits with re-use of 
> those temp registers?
> 

I'm not sure to follow you.

On ppc32, all volatile registers are used for function arguments, so 
temp registers are necessarily non-volatile so we track them as all 
non-volatile registers we use.

I think saving on stack only the non-volatile registers we use provides 
real benefit, otherwise you wouldn't have implemented it would you ?

Anyway here you should use _R0 instead of tmp_reg.

Christophe
