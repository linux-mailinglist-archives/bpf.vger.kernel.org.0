Return-Path: <bpf+bounces-22730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EEE867A80
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 16:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639B1B2B098
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C67912A17C;
	Mon, 26 Feb 2024 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g28+F0+j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B08592F
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961549; cv=none; b=QTD1/5e9yCde2dBC60G6uN5rCZVS107r9leQogdBlMc76myCRHc7+Qz7Ytp+6lZaZySjzv+pdBJfzODfK03Q2cfoFY6eA3Mfmh4ftwHbwtHkH0QBEJ1NpvRHHkuDPLnlwtfET/bSHxtHN/k8rww95zt44y/NkPxgH53eqD2jkMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961549; c=relaxed/simple;
	bh=L8dn2JsQlgr7kPNWgo0bcfH6f0QpaU28SjDfgo7R3Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUXbImoo3975JWLbilEs8a6xCDBQZ8F5olT/wtfgY1oBcdrJigMc3UbHQPN6C8F+6/VXVfi3TREG8vv+s6PzaP1s5HoJ2A8lq1eaMtWFumgxt7ZEEMjS01NgxDJrjZ99t8HXk4s6f0sMKQ94ztW7oK3sSt+TQ4XuMhcsVPbFV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g28+F0+j; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36576b35951so17081575ab.3
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 07:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708961547; x=1709566347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSJiB9bvGiGWePDQf3OhpZVE3AGUfSOIlm+9aANYSPI=;
        b=g28+F0+jsH+PGSvYwZUN+9Az3CeeCx/AsycODOAY+PnQb1RCVHRUBvc3E2749UxLz2
         sXyqAxywMIQfwZcxMLhpvjCB6pjKvOzwx6jjpjPTzkeBrNdgK7fRxSAJSTpiqAwkaThz
         0EkL81xX1C9ueyMvhTmZQymPqgWwWitzdeoXAkR4FfN5bu/NrSANulJgHGnYlBdZ1J74
         ie3T60And2P4qolO4JM8hN5qAhPx0UEuEEM08NkvH2w/CAMuTArQ7tMtSNn/A7DpiyWl
         1TIsvQijBvz0S7iwJ+fLFIGvHqzTWUU8RQRVQ7G5hovxHM6bHZLUvqR6YIvAIJP4DO0n
         j8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961547; x=1709566347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSJiB9bvGiGWePDQf3OhpZVE3AGUfSOIlm+9aANYSPI=;
        b=FNh4o+I5l6vWwP33SHe9nPgWAaKKh0uzScq1SbpyJg4QfkDePm/7TXonpe1Vb6ZiRZ
         dGaRhoUAhouWPKqnhd1E1UivKyNQzda3foUIf5DglCa5tjzSc9G9dg0A9fquLvuqJbCF
         vIb5W5+Vn01J4ia9vq+TN7QSajVHVGXkbjQSv0thcLFiSd1AtrL4OWE16+6j/aiHR3Gc
         YPeAuvLuSNJ6yi2M38QOV1pd1UyNKgWj8kPfR1SHqVHCf+oTpzQ/JXVAkaXYic5ZWknl
         0WCHa4bvlk3IokiEreO6Tgff7wKodIEn83XiuXchLkWR1n5+Wi4N2Q7szcsfpa4Seg0j
         y5fA==
X-Forwarded-Encrypted: i=1; AJvYcCVr/oV7O0A4BU/GNNWMl8GOm3r0a15/+piYCw73OQh/UnMOQOBYm5YJch+l+fRO/pMA5JtwFR8ionqitUf3RTYs6Mig
X-Gm-Message-State: AOJu0Yy/jTG04k+XoTQm7cMTFviape1Ecr5gm901jFzcPMM894MVsLYD
	tammVhg+kbpAnRKgMbhP8mQObuPHxCSGwfMt5jbvYbd8PViegHFk
X-Google-Smtp-Source: AGHT+IG+EYijsp1a+tXYO1/vrZ3EV1nPkC4OX/OR27p3a1q/52fQ59HmfVcA2H6eeBOmteAjqE3aig==
X-Received: by 2002:a05:6e02:927:b0:365:15c3:dcb3 with SMTP id o7-20020a056e02092700b0036515c3dcb3mr7183248ilt.9.1708961546781;
        Mon, 26 Feb 2024 07:32:26 -0800 (PST)
Received: from [192.168.1.76] (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id s16-20020a63ff50000000b005d8b89bbf20sm4128398pgk.63.2024.02.26.07.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:32:26 -0800 (PST)
Message-ID: <c43e82e2-7a23-44fc-b841-b3ace7dc6bcf@gmail.com>
Date: Mon, 26 Feb 2024 23:32:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Pu Lehui <pulehui@huawei.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
References: <20240222085232.62483-1-hffilwlqm@gmail.com>
 <20240222085232.62483-2-hffilwlqm@gmail.com>
 <8a3111a0-b190-437f-979e-393f0c890bf1@huawei.com>
 <1fdb4ba0-5b91-419a-960c-a26de0e51c25@gmail.com>
 <CAADnVQ+yzkAxCK=L9qVUzSEmj72CH=9kqe25=Risj_BdaLDA=A@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQ+yzkAxCK=L9qVUzSEmj72CH=9kqe25=Risj_BdaLDA=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/2/24 00:35, Alexei Starovoitov wrote:
> On Fri, Feb 23, 2024 at 7:30 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 2024/2/23 12:06, Pu Lehui wrote:
>>>
>>>
>>> On 2024/2/22 16:52, Leon Hwang wrote:
>>
>> [SNIP]
>>
>>>>   }
>>>>   @@ -575,6 +574,54 @@ static void emit_return(u8 **pprog, u8 *ip)
>>>>       *pprog = prog;
>>>>   }
>>>>   +DEFINE_PER_CPU(u32, bpf_tail_call_cnt);
>>>
>>> Hi Leon, the solution is really simplifies complexity. If I understand
>>> correctly, this TAIL_CALL_CNT becomes the system global wise, not the
>>> prog global wise, but before it was limiting the TCC of entry prog.
>>>
>>
>> Correct. It becomes a PERCPU global variable.
>>
>> But, I think this solution is not robust enough.
>>
>> For example,
>>
>> time      prog1           prog1
>> ==================================>
>> line              prog2
>>
>> this is a time-line on a CPU. If prog1 and prog2 have tailcalls to run,
>> prog2 will reset the tail_call_cnt on current CPU, which is used by
>> prog1. As a result, when the CPU schedules from prog2 to prog1,
>> tail_call_cnt on current CPU has been reset to 0, no matter whether
>> prog1 incremented it.
>>
>> The tail_call_cnt reset issue happens too, even if PERCPU tail_call_cnt
>> moves to 'struct bpf_prog_aux', i.e. one kprobe bpf prog can be
>> triggered on many functions e.g. cilium/pwru. However, this moving is
>> better than this solution.
> 
> kprobe progs are not preemptable.
> There is bpf_prog_active that disallows any recursion.
> Moving this percpu count to prog->aux should solve it.
> 
>> I think, my previous POC of 'struct bpf_prog_run_ctx' would be better.
>> I'll resend it later, with some improvements.
> 
> percpu approach is still prefered, since it removes rax mess.

It seems that we cannot remove rax.

Let's take a look at tailcall3.c selftest:

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

int count = 0;

SEC("tc")
int classifier_0(struct __sk_buff *skb)
{
	count++;
	bpf_tail_call_static(skb, &jmp_table, 0);
	return 1;
}

SEC("tc")
int entry(struct __sk_buff *skb)
{
	bpf_tail_call_static(skb, &jmp_table, 0);
	return 0;
}

Here, classifier_0 is populated to jmp_table.

Then, at classifier_0's prologue, when we 'move rax,
classifier_0->tail_call_cnt' in order to use the PERCPU tail_call_cnt in
'struct bpf_prog' for current run-time, it fails to run selftests. It's
because the tail_call_cnt is not from the entry bpf prog. The
tail_call_cnt from the entry bpf prog is the expected one, even though
classifier_0 bpf prog runs. (It seems that it's unnecessary to provide
the diff of the exclusive approach with PERCPU tail_call_cnt.)

Next, I tried a POC with PERCPU tail_call_cnt in 'struct bpf_prog' and rax:

1. At prologue, initialise tail_call_cnt from bpf_prog's tail_call_cnt.
2. Propagate tail_call_cnt pointer by the previous rax way.

Here's the diff for the POC:

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e1390d1e3..54f5770d9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -18,18 +18,22 @@
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
 #include <asm/cfi.h>
+#include <asm/percpu.h>

 static bool all_callee_regs_used[4] = {true, true, true, true};

-static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
+static u8 *emit_code(u8 *ptr, u64 bytes, unsigned int len)
 {
 	if (len == 1)
 		*ptr = bytes;
 	else if (len == 2)
 		*(u16 *)ptr = bytes;
-	else {
+	else if (len == 4) {
 		*(u32 *)ptr = bytes;
 		barrier();
+	} else {
+		*(u64 *)ptr = bytes;
+		barrier();
 	}
 	return ptr + len;
 }
@@ -51,6 +55,9 @@ static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 #define EMIT4_off32(b1, b2, b3, b4, off) \
 	do { EMIT4(b1, b2, b3, b4); EMIT(off, 4); } while (0)

+#define EMIT2_off64(b1, b2, off) \
+	do { EMIT2(b1, b2); EMIT(off, 8); } while(0)
+
 #ifdef CONFIG_X86_KERNEL_IBT
 #define EMIT_ENDBR()		EMIT(gen_endbr(), 4)
 #define EMIT_ENDBR_POISON()	EMIT(gen_endbr_poison(), 4)
@@ -259,7 +266,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(24 + ENDBR_INSN_SIZE)

 static void push_r12(u8 **pprog)
 {
@@ -389,16 +396,40 @@ static void emit_cfi(u8 **pprog, u32 hash)
 	*pprog = prog;
 }

+
+static __used void bpf_tail_call_cnt_prepare(void)
+{
+	/* The following asm equals to
+	 *
+	 * u32 *tcc_ptr = this_cpu_ptr(prog->aux->entry->tail_call_cnt);
+	 *
+	 * *tcc_ptr = 0;
+	 *
+	 * This asm must uses %rax only.
+	 */
+
+	/* %rax has been set as prog->aux->entry->tail_call_cnt. */
+	asm volatile (
+	    "addq " __percpu_arg(0) ", %%rax\n\t"
+	    "movl $0, (%%rax)\n\t"
+	    :
+	    : "m" (this_cpu_off)
+	);
+}
+
+static int emit_call(u8 **pprog, void *func, void *ip);
+
 /*
  * Emit x86-64 prologue code for BPF program.
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
  * while jumping to another program
  */
-static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
-			  bool tail_call_reachable, bool is_subprog,
-			  bool is_exception_cb)
+static void emit_prologue(struct bpf_prog *bpf_prog, u8 **pprog, u32
stack_depth,
+			  bool ebpf_from_cbpf, bool tail_call_reachable,
+			  bool is_subprog, bool is_exception_cb, u8 *ip)
 {
-	u8 *prog = *pprog;
+	struct bpf_prog *entry = bpf_prog->aux->entry;
+	u8 *prog = *pprog, *start = *pprog;

 	emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash);
 	/* BPF trampoline can be made to work without these nops,
@@ -406,14 +437,16 @@ static void emit_prologue(u8 **pprog, u32
stack_depth, bool ebpf_from_cbpf,
 	 */
 	emit_nops(&prog, X86_PATCH_SIZE);
 	if (!ebpf_from_cbpf) {
-		if (tail_call_reachable && !is_subprog)
-			/* When it's the entry of the whole tailcall context,
-			 * zeroing rax means initialising tail_call_cnt.
-			 */
-			EMIT2(0x31, 0xC0); /* xor eax, eax */
-		else
+		if (tail_call_reachable && !is_subprog) {
+			/* mov rax, entry->tail_call_cnt */
+			EMIT2_off64(0x48, 0xB8, (u64) entry->tail_call_cnt);
+			/* call bpf_tail_call_cnt_prepare */
+			emit_call(&prog, bpf_tail_call_cnt_prepare,
+				  ip + (prog - start));
+		} else {
 			/* Keep the same instruction layout. */
-			EMIT2(0x66, 0x90); /* nop2 */
+			emit_nops(&prog, 10 + X86_PATCH_SIZE);
+		}
 	}
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
@@ -581,7 +614,7 @@ static void emit_return(u8 **pprog, u8 *ip)
  * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) ...
  *   if (index >= array->map.max_entries)
  *     goto out;
- *   if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+ *   if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
  *     goto out;
  *   prog = array->ptrs[index];
  *   if (prog == NULL)
@@ -594,7 +627,7 @@ static void emit_bpf_tail_call_indirect(struct
bpf_prog *bpf_prog,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;

@@ -616,16 +649,15 @@ static void emit_bpf_tail_call_indirect(struct
bpf_prog *bpf_prog,
 	EMIT2(X86_JBE, offset);                   /* jbe out */

 	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp -
tcc_off] */
-	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
+	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off); /* mov rax, qword ptr [rbp
- tcc_ptr_off] */
+	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);     /* cmp dword ptr [rax],
MAX_TAIL_CALL_CNT */

 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                   /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp -
tcc_off], eax */
+	EMIT3(0x83, 0x00, 0x01);                  /* add dword ptr [rax], 1 */

 	/* prog = array->ptrs[index]; */
 	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 +
offsetof(...)] */
@@ -647,6 +679,7 @@ static void emit_bpf_tail_call_indirect(struct
bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}

+	/* pop tail_call_cnt_ptr */
 	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
@@ -675,21 +708,20 @@ static void emit_bpf_tail_call_direct(struct
bpf_prog *bpf_prog,
 				      bool *callee_regs_used, u32 stack_depth,
 				      struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;

 	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr
[rbp - tcc_off] */
-	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax,
MAX_TAIL_CALL_CNT */
+	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off);   /* mov rax, qword ptr
[rbp - tcc_ptr_off] */
+	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);         /* cmp dword ptr [rax],
MAX_TAIL_CALL_CNT */

 	offset = ctx->tail_call_direct_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                       /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp -
tcc_off], eax */
+	EMIT3(0x83, 0x00, 0x01);                      /* add dword ptr [rax], 1 */

 	poke->tailcall_bypass = ip + (prog - start);
 	poke->adj_off = X86_TAIL_CALL_OFFSET;
@@ -706,6 +738,7 @@ static void emit_bpf_tail_call_direct(struct
bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}

+	/* pop tail_call_cnt_ptr */
 	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
@@ -1134,7 +1167,7 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg,
u8 src_reg, bool is64, u8 op)
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))

 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-#define RESTORE_TAIL_CALL_CNT(stack)				\
+#define LOAD_TAIL_CALL_CNT_PTR(stack)				\
 	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)

 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8
*rw_image,
@@ -1158,9 +1191,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int
*addrs, u8 *image, u8 *rw_image
 	/* tail call's presence in current prog implies it is reachable */
 	tail_call_reachable |= tail_call_seen;

-	emit_prologue(&prog, bpf_prog->aux->stack_depth,
+	emit_prologue(bpf_prog, &prog, bpf_prog->aux->stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
-		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
+		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb,
+		      image);
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */
@@ -1754,7 +1788,7 @@ st:			if (is_imm8(insn->off))

 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
+				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
 				if (!imm32)
 					return -EINVAL;
 				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
@@ -2679,10 +2713,10 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im
 		save_args(m, &prog, arg_stack_off, true);

 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-			/* Before calling the original function, restore the
-			 * tail_call_cnt from stack to rax.
+			/* Before calling the original function, load the
+			 * tail_call_cnt_ptr to rax.
 			 */
-			RESTORE_TAIL_CALL_CNT(stack_size);
+			LOAD_TAIL_CALL_CNT_PTR(stack_size);
 		}

 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
@@ -2741,10 +2775,10 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im
 			goto cleanup;
 		}
 	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-		/* Before running the original function, restore the
-		 * tail_call_cnt from stack to rax.
+		/* Before running the original function, load the
+		 * tail_call_cnt_ptr to rax.
 		 */
-		RESTORE_TAIL_CALL_CNT(stack_size);
+		LOAD_TAIL_CALL_CNT_PTR(stack_size);
 	}

 	/* restore return value of orig_call or fentry prog back into RAX */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 814dc913a..5e8abcb11 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1459,6 +1459,7 @@ struct bpf_prog_aux {
 	/* function name for valid attach_btf_id */
 	const char *attach_func_name;
 	struct bpf_prog **func;
+	struct bpf_prog *entry;
 	void *jit_data; /* JIT specific data. arch dependent */
 	struct bpf_jit_poke_descriptor *poke_tab;
 	struct bpf_kfunc_desc_tab *kfunc_tab;
@@ -1542,6 +1543,7 @@ struct bpf_prog {
 	u8			tag[BPF_TAG_SIZE];
 	struct bpf_prog_stats __percpu *stats;
 	int __percpu		*active;
+	u32 __percpu		*tail_call_cnt;
 	unsigned int		(*bpf_func)(const void *ctx,
 					    const struct bpf_insn *insn);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 71c459a51..7884f66fc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -110,6 +110,13 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned
int size, gfp_t gfp_extra_flag
 		kfree(aux);
 		return NULL;
 	}
+	fp->tail_call_cnt = alloc_percpu_gfp(u32, bpf_memcg_flags(GFP_KERNEL |
gfp_extra_flags));
+	if (!fp->tail_call_cnt) {
+		free_percpu(fp->active);
+		vfree(fp);
+		kfree(aux);
+		return NULL;
+	}

 	fp->pages = size / PAGE_SIZE;
 	fp->aux = aux;
@@ -142,6 +149,7 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size,
gfp_t gfp_extra_flags)

 	prog->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
 	if (!prog->stats) {
+		free_percpu(prog->tail_call_cnt);
 		free_percpu(prog->active);
 		kfree(prog->aux);
 		vfree(prog);
@@ -261,6 +269,7 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog
*fp_old, unsigned int size,
 		fp_old->aux = NULL;
 		fp_old->stats = NULL;
 		fp_old->active = NULL;
+		fp_old->tail_call_cnt = NULL;
 		__bpf_prog_free(fp_old);
 	}

@@ -277,6 +286,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 	}
 	free_percpu(fp->stats);
 	free_percpu(fp->active);
+	free_percpu(fp->tail_call_cnt);
 	vfree(fp);
 }

@@ -1428,6 +1438,7 @@ static void bpf_prog_clone_free(struct bpf_prog *fp)
 	fp->aux = NULL;
 	fp->stats = NULL;
 	fp->active = NULL;
+	fp->tail_call_cnt = NULL;
 	__bpf_prog_free(fp);
 }

@@ -2379,6 +2390,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct
bpf_prog *fp, int *err)
 		if (*err)
 			return fp;

+		fp->aux->entry = fp;
 		fp = bpf_int_jit_compile(fp);
 		bpf_prog_jit_attempt_done(fp);
 		if (!fp->jited && jit_needed) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 011d54a1d..442d0a4b2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19025,6 +19025,7 @@ static int jit_subprogs(struct bpf_verifier_env
*env)
 		}
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable =
env->subprog_info[i].tail_call_reachable;
+		func[i]->aux->entry = prog;
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;

Thanks,
Leon

