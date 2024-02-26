Return-Path: <bpf+bounces-22732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C642867B16
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 17:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53DF28BAA4
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFD412C52D;
	Mon, 26 Feb 2024 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imqH86yu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E1127B4D
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963488; cv=none; b=BGuikXMpw582+z9W4xOpV2sepArQyOd+4TwVSETUqSlBhUsLqJ6VJvVTxCDBP8Pg7Q4GcBVU52ymastU6GgcwAOnpLLjFAB57Oj1OHnvp6iU0s7hUYPAELjlXt1JVL7n1GNUb090MVr6iGbQ8897ZKcB0olLfXcg2nz+ykCat2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963488; c=relaxed/simple;
	bh=mXcrettUIxCIXmm+dnPdSvjAIKcLwmVjNnNl0HeVHUM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nZBVsf2FREywPMBGSLX2XPs4w3W1n5l8VkMMnENNxzsQAIV6uMAGoR7geOb5hQqbj+kNNFY7/zIvjvUWP2fbijlgdordDSnfNTsWVE8AVK+tE1c0+xZB2gbiSeL0ac0Opc90cDG1o6Q0Pthp07fd2ZY2oi5621/mZdrp2Sdkju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imqH86yu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e4f5e84abeso728424b3a.2
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 08:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708963485; x=1709568285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTDOZYPVm1GmzaLODkZVu6UBFOD9nLaNNw22Ddhkz5k=;
        b=imqH86yuEaCL25GeKWBrh+9I9WdemyRwHutZwuDFWfXMi/rLVORHr1lUoavlqggWj0
         qsOxdM/a5t7RvDfwoROFAHqHWiFAjQBCuvYfWy8tawLIgKpMtl0/WARzGLZrq26beKJq
         90cbWNSqvcGzOlRPA1V7JGJbpVUp6CE6nnq0CIaMp0lqBqeJVeeI6bsJ30Fg06HHJP4X
         BB03v5TJMIPMW/57jkGUq4qCfIA0PJGdjSMi2+jVOU4GGqRMEb3WHkNFECUrIdGiQfRs
         Zg5f7Xbe/X3xvVkmg9G546LrnTb9eXTVj8ak5uo8QNxDTxo8nH54WrJCyfGSSxIAhN98
         wxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963485; x=1709568285;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTDOZYPVm1GmzaLODkZVu6UBFOD9nLaNNw22Ddhkz5k=;
        b=abUeAF3MiAb3BBM+7romEO6QXsQ4YqmKs+kHRvVm2+rXx2RMy6eCoh6JEACrYMe8sx
         HxtNI9Jb+/5imKEvctDGU5CSrWXLNfQHp+9dhq2CZBPjc8UHVUEsoF47TuAX7pA5mWR3
         gTmniSOoqvUHKkgu5rOAtNeclfYuN16OmEiaUracXK8C/+dTnaw5zOfsvEQ/xj2f9gy7
         2HfUhDNVRnmtBkRGJa9V25fmuHa3dwem7zyYrjxOZbCKWA3Xak2/smNeMhmsRm6RJOLr
         fUNAxlF74bAPXFIWErgnmLEqOg1gohjkUTmaN3ODLFmeDmjfl8eFDePYJL2b+ZwqSjvP
         fmDA==
X-Forwarded-Encrypted: i=1; AJvYcCXBVNaFweNFlIgkDcQMvE0NBIzcrO29EILiyhKCh/ViO6rf5Us2+uCNnQIK5gzSUW38ZKTVWiMQ5hCJvrHX+hkxvOoo
X-Gm-Message-State: AOJu0Yzuwv5KWf8iauoHy+cjOQikkRGJK8Xp2UnE/uhVjzx0s9gFHxVx
	Q5OJWELlMkhsjnVVwObAPHiD/qtClFLiaszZ8F3dG4HIElNBv4hr
X-Google-Smtp-Source: AGHT+IER9pyV2ag0W1yKF1uEmEb74ULNskaBSwq8WCnJ1AhPmj/gjYiDYcsWSYl8KnZ20EtEimKIqA==
X-Received: by 2002:a62:d407:0:b0:6e5:bb8:dc1c with SMTP id a7-20020a62d407000000b006e50bb8dc1cmr3226830pfh.2.1708963485392;
        Mon, 26 Feb 2024 08:04:45 -0800 (PST)
Received: from [192.168.1.76] (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id ld4-20020a056a004f8400b006e535131c52sm1537469pfb.146.2024.02.26.08.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:04:44 -0800 (PST)
Message-ID: <b140a62b-e198-4a98-ba52-9e53cc064558@gmail.com>
Date: Tue, 27 Feb 2024 00:04:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
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
 <c43e82e2-7a23-44fc-b841-b3ace7dc6bcf@gmail.com>
In-Reply-To: <c43e82e2-7a23-44fc-b841-b3ace7dc6bcf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/2/26 23:32, Leon Hwang wrote:
> 
> 
> On 2024/2/24 00:35, Alexei Starovoitov wrote:
>> On Fri, Feb 23, 2024 at 7:30 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>
>>>
>>>
>>> On 2024/2/23 12:06, Pu Lehui wrote:
>>>>
>>>>
>>>> On 2024/2/22 16:52, Leon Hwang wrote:
>>>
>>> [SNIP]
>>>
>>>>>   }
>>>>>   @@ -575,6 +574,54 @@ static void emit_return(u8 **pprog, u8 *ip)
>>>>>       *pprog = prog;
>>>>>   }
>>>>>   +DEFINE_PER_CPU(u32, bpf_tail_call_cnt);
>>>>
>>>> Hi Leon, the solution is really simplifies complexity. If I understand
>>>> correctly, this TAIL_CALL_CNT becomes the system global wise, not the
>>>> prog global wise, but before it was limiting the TCC of entry prog.
>>>>
>>>
>>> Correct. It becomes a PERCPU global variable.
>>>
>>> But, I think this solution is not robust enough.
>>>
>>> For example,
>>>
>>> time      prog1           prog1
>>> ==================================>
>>> line              prog2
>>>
>>> this is a time-line on a CPU. If prog1 and prog2 have tailcalls to run,
>>> prog2 will reset the tail_call_cnt on current CPU, which is used by
>>> prog1. As a result, when the CPU schedules from prog2 to prog1,
>>> tail_call_cnt on current CPU has been reset to 0, no matter whether
>>> prog1 incremented it.
>>>
>>> The tail_call_cnt reset issue happens too, even if PERCPU tail_call_cnt
>>> moves to 'struct bpf_prog_aux', i.e. one kprobe bpf prog can be
>>> triggered on many functions e.g. cilium/pwru. However, this moving is
>>> better than this solution.
>>
>> kprobe progs are not preemptable.
>> There is bpf_prog_active that disallows any recursion.
>> Moving this percpu count to prog->aux should solve it.
>>
>>> I think, my previous POC of 'struct bpf_prog_run_ctx' would be better.
>>> I'll resend it later, with some improvements.
>>
>> percpu approach is still prefered, since it removes rax mess.
> 
> It seems that we cannot remove rax.
> 
> Let's take a look at tailcall3.c selftest:
> 
> struct {
> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> 	__uint(max_entries, 1);
> 	__uint(key_size, sizeof(__u32));
> 	__uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
> 
> int count = 0;
> 
> SEC("tc")
> int classifier_0(struct __sk_buff *skb)
> {
> 	count++;
> 	bpf_tail_call_static(skb, &jmp_table, 0);
> 	return 1;
> }
> 
> SEC("tc")
> int entry(struct __sk_buff *skb)
> {
> 	bpf_tail_call_static(skb, &jmp_table, 0);
> 	return 0;
> }
> 
> Here, classifier_0 is populated to jmp_table.
> 
> Then, at classifier_0's prologue, when we 'move rax,
> classifier_0->tail_call_cnt' in order to use the PERCPU tail_call_cnt in
> 'struct bpf_prog' for current run-time, it fails to run selftests. It's
> because the tail_call_cnt is not from the entry bpf prog. The
> tail_call_cnt from the entry bpf prog is the expected one, even though
> classifier_0 bpf prog runs. (It seems that it's unnecessary to provide
> the diff of the exclusive approach with PERCPU tail_call_cnt.)

Sorry for the unclear message. It should be emit_bpf_tail_call_xxx()
instead of emit_prologue().

I think it's better to provide the diff of the exclusive approach with
PERCPU tail_call_cnt, in order to compare these two approachs.

P.S. This POC failed to pass all selftests, like "Summary: 0/13 PASSED,
0 SKIPPED, 1 FAILED".

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e1390d1e3..695c99c0f 100644
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
@@ -389,16 +396,20 @@ static void emit_cfi(u8 **pprog, u32 hash)
 	*pprog = prog;
 }

+static int emit_call(u8 **pprog, void *func, void *ip);
+static __used void bpf_tail_call_cnt_prepare(void);
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
@@ -406,14 +417,16 @@ static void emit_prologue(u8 **pprog, u32
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
@@ -438,8 +451,6 @@ static void emit_prologue(u8 **pprog, u32
stack_depth, bool ebpf_from_cbpf,
 	/* sub rsp, rounded_stack_depth */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
-	if (tail_call_reachable)
-		EMIT1(0x50);         /* push rax */
 	*pprog = prog;
 }

@@ -575,13 +586,61 @@ static void emit_return(u8 **pprog, u8 *ip)
 	*pprog = prog;
 }

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
+static __used u32 bpf_tail_call_cnt_fetch_and_inc(void)
+{
+	u32 tail_call_cnt;
+
+	/* The following asm equals to
+	 *
+	 * u32 *tcc_ptr = this_cpu_ptr(prog->aux->entry->tail_call_cnt);
+	 *
+	 * (*tcc_ptr)++;
+	 * tail_call_cnt = *tcc_ptr;
+	 * tail_call_cnt--;
+	 *
+	 * This asm must uses %rax only.
+	 */
+
+	/* %rax has been set as prog->aux->entry->tail_call_cnt. */
+	asm volatile (
+	    "addq " __percpu_arg(1) ", %%rax\n\t"
+	    "incl (%%rax)\n\t"
+	    "movl (%%rax), %0\n\t"
+	    "decl %0\n\t"
+	    : "=r" (tail_call_cnt)
+	    : "m" (this_cpu_off)
+	);
+
+	return tail_call_cnt;
+}
+
 /*
  * Generate the following code:
  *
  * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) ...
  *   if (index >= array->map.max_entries)
  *     goto out;
- *   if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+ *   if (bpf_tail_call_cnt_fetch_and_inc() >= MAX_TAIL_CALL_CNT)
  *     goto out;
  *   prog = array->ptrs[index];
  *   if (prog == NULL)
@@ -594,7 +653,7 @@ static void emit_bpf_tail_call_indirect(struct
bpf_prog *bpf_prog,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	struct bpf_prog *entry = bpf_prog->aux->entry;
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;

@@ -615,17 +674,16 @@ static void emit_bpf_tail_call_indirect(struct
bpf_prog *bpf_prog,
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JBE, offset);                   /* jbe out */

-	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+	/* if (bpf_tail_call_cnt_fetch_and_inc() >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp -
tcc_off] */
+	/* mov rax, entry->tail_call_cnt */
+	EMIT2_off64(0x48, 0xB8, (u64) entry->tail_call_cnt);
+	emit_call(&prog, bpf_tail_call_cnt_fetch_and_inc, ip + (prog - start));
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */

 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                   /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp -
tcc_off], eax */

 	/* prog = array->ptrs[index]; */
 	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 +
offsetof(...)] */
@@ -647,7 +705,6 @@ static void emit_bpf_tail_call_indirect(struct
bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}

-	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
 			    round_up(stack_depth, 8));
@@ -675,21 +732,20 @@ static void emit_bpf_tail_call_direct(struct
bpf_prog *bpf_prog,
 				      bool *callee_regs_used, u32 stack_depth,
 				      struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	struct bpf_prog *entry = bpf_prog->aux->entry;
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;

-	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+	/* if (bpf_tail_call_cnt_fetch_and_inc() >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr
[rbp - tcc_off] */
+	/* mov rax, entry->tail_call_cnt */
+	EMIT2_off64(0x48, 0xB8, (u64) entry->tail_call_cnt);
+	emit_call(&prog, bpf_tail_call_cnt_fetch_and_inc, ip + (prog - start));
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax,
MAX_TAIL_CALL_CNT */

 	offset = ctx->tail_call_direct_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                       /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp -
tcc_off], eax */

 	poke->tailcall_bypass = ip + (prog - start);
 	poke->adj_off = X86_TAIL_CALL_OFFSET;
@@ -706,7 +762,6 @@ static void emit_bpf_tail_call_direct(struct
bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}

-	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));

@@ -1133,10 +1188,6 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg,
u8 src_reg, bool is64, u8 op)

 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))

-/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-#define RESTORE_TAIL_CALL_CNT(stack)				\
-	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
-
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8
*rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -1158,9 +1209,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int
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
@@ -1752,17 +1804,12 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			int offs;

+			if (!imm32)
+				return -EINVAL;
+
 			func = (u8 *) __bpf_call_base + imm32;
-			if (tail_call_reachable) {
-				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
-				if (!imm32)
-					return -EINVAL;
-				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
-			} else {
-				if (!imm32)
-					return -EINVAL;
-				offs = x86_call_depth_emit_accounting(&prog, func);
-			}
+			offs = x86_call_depth_emit_accounting(&prog, func);
+
 			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
 				return -EINVAL;
 			break;
@@ -2550,7 +2597,6 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
 	 * RBP - arg_stack_off [ stack_arg1 ]
-	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */

 	/* room for return value of orig_call or fentry prog */
@@ -2622,8 +2668,6 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im
 		/* sub rsp, stack_size */
 		EMIT4(0x48, 0x83, 0xEC, stack_size);
 	}
-	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
-		EMIT1(0x50);		/* push rax */
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);

@@ -2678,16 +2722,9 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im
 		restore_regs(m, &prog, regs_off);
 		save_args(m, &prog, arg_stack_off, true);

-		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-			/* Before calling the original function, restore the
-			 * tail_call_cnt from stack to rax.
-			 */
-			RESTORE_TAIL_CALL_CNT(stack_size);
-		}
-
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
-			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
-			EMIT2(0xff, 0xd3); /* call *rbx */
+			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
+			EMIT2(0xff, 0xd0); /* call *rax */
 		} else {
 			/* call original function */
 			if (emit_rsb_call(&prog, orig_call, image + (prog - (u8 *)rw_image))) {
@@ -2740,11 +2777,6 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im
 			ret = -EINVAL;
 			goto cleanup;
 		}
-	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-		/* Before running the original function, restore the
-		 * tail_call_cnt from stack to rax.
-		 */
-		RESTORE_TAIL_CALL_CNT(stack_size);
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
index 71c459a51..1b5baa922 100644
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

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 011d54a1d..616e1d7a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18917,7 +18917,7 @@ static int convert_ctx_accesses(struct
bpf_verifier_env *env)

 static int jit_subprogs(struct bpf_verifier_env *env)
 {
-	struct bpf_prog *prog = env->prog, **func, *tmp;
+	struct bpf_prog *prog = env->prog, **func, *tmp, *entry = prog;
 	int i, j, subprog_start, subprog_end = 0, len, subprog;
 	struct bpf_map *map_ptr;
 	struct bpf_insn *insn;
@@ -19025,6 +19025,7 @@ static int jit_subprogs(struct bpf_verifier_env
*env)
 		}
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable =
env->subprog_info[i].tail_call_reachable;
+		func[i]->aux->entry = entry;
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;

> 
> Next, I tried a POC with PERCPU tail_call_cnt in 'struct bpf_prog' and rax:
> 
> 1. At prologue, initialise tail_call_cnt from bpf_prog's tail_call_cnt.
> 2. Propagate tail_call_cnt pointer by the previous rax way.
> 
> Here's the diff for the POC:
> 

[SNIP]

Thanks,
Leon

