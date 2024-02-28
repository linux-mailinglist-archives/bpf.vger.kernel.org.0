Return-Path: <bpf+bounces-22875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6224186B1D1
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A311C213F0
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE6F612FC;
	Wed, 28 Feb 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8TZ8+DA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9D1852
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130664; cv=none; b=sZaewljrjRTuuCMdswxxHel76rb+XFEloH8YK2BEQaqpx68ojWM1yFc0FobE/Xz4OdJ3JUfL0f/V4xK9tBWNxPOWb/gE3g17WjuWEBmUn/AoZ02BX5JPMyJt8NKkP/uc2EiV9nWVg+zX4OO13ZlWMjOLe9ATfCUBKwWUSWCGTeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130664; c=relaxed/simple;
	bh=WfpGx825Bio2uVzhQI4+m3VsVFfRj2sC5kRqC8yPzdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKoeTPt/it4PRio2APEPP40d9fYcaSFPn7eX6DJcwcbcWcRPlFjgUjZFXcwWJXuZr7N8hkpc1ImtMgWejqY4k2F1s/SNh3BiHKDHwo1Vw5ACkd/1BYJBzffl+vmqJJ4+14QMs0VtVr/ggqBM7V1NzDREXP7/DMaeZL0rQ2/Zy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8TZ8+DA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e57ab846a1so115250b3a.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 06:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709130662; x=1709735462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qDHtaI+cg1pSLk3w/SU0WCmTMq/1RAcPfr7gCTU0Ctg=;
        b=Y8TZ8+DAZUKutbuR2bEd0aFG6y+ITS2/i5bnEgp4r2VzjfNJmZBTBjjiQfyvFZyTt8
         lR5EEWWQ9eNzuju1uCxcLkGq8AJzdAfSs2Uyb7N2VPTFeaW3VH9NU7SyjApy53FHeqVR
         ZXosRUB4IMV+UVPEgz6jGrkvCroSx3mM2iwDsYuHqqTUdV7+Wr7S8DCXXveMcKmwNb/R
         qYoZCnwNt1staaGSLqoihZ4QVTG7NxcSumqOlbk8BVa6liouMvXR2PH7tP+Z7WtZi+cO
         OypJnKgQ3TG68IjRq4/xK3jWqgGMhK1ETKpJc+Lu7r/tcHoLhWLlS4jdIvcGcHdH20Vw
         A0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709130662; x=1709735462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDHtaI+cg1pSLk3w/SU0WCmTMq/1RAcPfr7gCTU0Ctg=;
        b=egfYBXNUWvFCCHwfG7jCaDxT4cWeeuIJb8VMysmkTLSro6TiVCw//7vbJ1kcVAYmGh
         8ox7Q1p82MwKSgTWPtyFKsdt0e8crbsXs6zrgCuOlM/y3dBFeG1JlEb30rEaQpgsoSNr
         zRHoYk1oabf1ljJ8m2J08Z9sRp57yNR0m+yV3UdRN4qN1ko8yFFoPzepvvRzbnhhi6Mi
         g5yb+4x0vcSmvwUkPe4N7A0dTP55w1LFGzTX7trb/NU1Jwn9oUIRP8rz9Nsvf8LU2X3U
         R7SNxBWn2GmmlHecb9UJNDcaTRo8zjeXWe4NDp1CGCeW/KqZckvgPJx2jNA3wDp+geAe
         RlKg==
X-Forwarded-Encrypted: i=1; AJvYcCU7y02wm6h6YDAf5s+/l71sxZb33B668Am5qAyr5nMh8qdIFvh46JL13ZPMmY6a7LrXuSUYK5VuxbcXaZHVdrPiP8DJ
X-Gm-Message-State: AOJu0YyiQHGodeItnBWU+O7DyH9wdc9o0+J6koMsm6yVAOCj4EAnJhlS
	iBMXly39GSbNoi5+MRCdPkp4coNd2/kTCupE+03xko69N4LEYHIo
X-Google-Smtp-Source: AGHT+IHt+7kWZbq4XxlEWPl+2Wm5wW7cwQlZ8ux7KotpLkOIX/Xu+l82OD7qJv6f7aGCzhaFm53uwQ==
X-Received: by 2002:a05:6a20:c887:b0:1a0:ecaa:e416 with SMTP id hb7-20020a056a20c88700b001a0ecaae416mr5734339pzb.17.1709130661428;
        Wed, 28 Feb 2024 06:31:01 -0800 (PST)
Received: from [192.168.1.76] (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78007000000b006e02da39dbcsm8124552pfi.10.2024.02.28.06.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:31:00 -0800 (PST)
Message-ID: <c5d7fcbf-a798-4c2d-8978-7c19ae7eafa3@gmail.com>
Date: Wed, 28 Feb 2024 22:30:54 +0800
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
 <c43e82e2-7a23-44fc-b841-b3ace7dc6bcf@gmail.com>
 <CAADnVQ+Fr0k+28L=BLaXDxu=wDBwpiuCaXzEN3y6jEXj48zhUg@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQ+Fr0k+28L=BLaXDxu=wDBwpiuCaXzEN3y6jEXj48zhUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/2/27 06:12, Alexei Starovoitov wrote:
> On Mon, Feb 26, 2024 at 7:32 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 2024/2/24 00:35, Alexei Starovoitov wrote:
>>> On Fri, Feb 23, 2024 at 7:30 AM Leon Hwang <hffilwlqm@gmail.com> wrote:

[SNIP]

>>
>> Let's take a look at tailcall3.c selftest:
>>
>> struct {
>>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>>         __uint(max_entries, 1);
>>         __uint(key_size, sizeof(__u32));
>>         __uint(value_size, sizeof(__u32));
>> } jmp_table SEC(".maps");
>>
>> int count = 0;
>>
>> SEC("tc")
>> int classifier_0(struct __sk_buff *skb)
>> {
>>         count++;
>>         bpf_tail_call_static(skb, &jmp_table, 0);
>>         return 1;
>> }
>>
>> SEC("tc")
>> int entry(struct __sk_buff *skb)
>> {
>>         bpf_tail_call_static(skb, &jmp_table, 0);
>>         return 0;
>> }
>>
>> Here, classifier_0 is populated to jmp_table.
>>
>> Then, at classifier_0's prologue, when we 'move rax,
>> classifier_0->tail_call_cnt' in order to use the PERCPU tail_call_cnt in
>> 'struct bpf_prog' for current run-time, it fails to run selftests. It's
>> because the tail_call_cnt is not from the entry bpf prog. The
>> tail_call_cnt from the entry bpf prog is the expected one, even though
>> classifier_0 bpf prog runs. (It seems that it's unnecessary to provide
>> the diff of the exclusive approach with PERCPU tail_call_cnt.)
> 
> Not following.
> With percpu tail_call_cnt, does classifier_0 loop forever ? I doubt it.
> You mean expected 'count' value is different?
> The test expected 33 and instead it's ... what?

Yeah, the test result is 34 instead of expected 33.

test_tailcall_count:PASS:tailcall 0 nsec
test_tailcall_count:PASS:tailcall retval 0 nsec
test_tailcall_count:PASS:tailcall count 0 nsec
test_tailcall_count:FAIL:tailcall count unexpected tailcall count:
actual 34 != expected 33
test_tailcall_count:PASS:tailcall 0 nsec
test_tailcall_count:PASS:tailcall retval 0 nsec
#311/3   tailcalls/tailcall_3:FAIL

> 
>> +               if (tail_call_reachable && !is_subprog) {
>> +                       /* mov rax, entry->tail_call_cnt */
>> +                       EMIT2_off64(0x48, 0xB8, (u64) entry->tail_call_cnt);
>> +                       /* call bpf_tail_call_cnt_prepare */
>> +                       emit_call(&prog, bpf_tail_call_cnt_prepare,
>> +                                 ip + (prog - start));
>> +               } else {
>>                         /* Keep the same instruction layout. */
>> -                       EMIT2(0x66, 0x90); /* nop2 */
>> +                       emit_nops(&prog, 10 + X86_PATCH_SIZE);
> 
> As mentioned before... such "fix" is not acceptable.
> We will not be penalizing all progs this way.
> 
> How about we make percpu tail_call_cnt per prog_array map,

No, we can not store percpu tail_call_cnt on either bpf prog or
prog_array map.

Considering this case:

1. prog1 tailcall prog2 with prog_array map1.
2. prog2 tailcall prog3 with prog_array map2.
3. prog3 tailcall prog4 with prog_array map3.
4. ...

We can not store percpu tail_call_cnt on either prog1 or prog_array map1.

In conclusion, tail_call_cnt is a run-time variable that should be
stored on stack ideally.

Can we store tail_call_cnt on stack and then propagate tcc_ptr by some
way instead of rax?

> then remove rax as this patch does,
> but instead of zeroing tcc on entry, zero it on exit.
> While processing bpf_exit add:
> if (tail_call_reachable)
>   emit_call(&prog, bpf_tail_call_cnt_prepare,...)
> 
> if prog that tailcalls get preempted on this cpu and
> another prog starts that also tailcalls it won't zero the count.
> This way we can remove nop5 from prologue too.
> 
> The preempted prog will eventually zero ttc on exit,
> and earlier prog that uses the same prog_array can tail call more
> than 32 times, but it cannot be abused reliably,
> since preemption is non deterministic.


We can not zeroing tcc on exit. If zero it on exit, the selftests of
this patchset will run forever, e.g.

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

int count = 0;

static __noinline
int subprog_tail(struct __sk_buff *skb)
{
	bpf_tail_call_static(skb, &jmp_table, 0);
	return 0;
}

SEC("tc")
int entry(struct __sk_buff *skb)
{
	int ret = 1;

	count++;
	subprog_tail(skb); /* tailcall-pos1 */
	subprog_tail(skb); /* tailcall-pos2 */

	return ret; /* zeroing tcc */
}

The jmp_table populates with the entry bpf prog.

The entry bpf prog zeros tcc always when returns. So, after the entry
bpf prog returns from subprog_tail() at tailcall-pos1, tcc has been
reset to 0, and the entry bpf prog tailcalled from subprog_tail() at
tailcall-pos2 can run forever.



Here's another alternative approach. Like this PATCH v2, it's ok to
initialise tcc as MAX_TAIL_CALL_CNT, and then decrement it when tailcall
happens. This approach does same with this PATCH v2, and passes all
selftests.

Here's the diff:

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e1390d1e3..72773899a 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -11,6 +11,7 @@
 #include <linux/bpf.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
+#include <linux/stringify.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
@@ -18,6 +19,7 @@
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
 #include <asm/cfi.h>
+#include <asm/percpu.h>

 static bool all_callee_regs_used[4] = {true, true, true, true};

@@ -259,7 +261,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(14 + ENDBR_INSN_SIZE)

 static void push_r12(u8 **pprog)
 {
@@ -389,6 +391,9 @@ static void emit_cfi(u8 **pprog, u32 hash)
 	*pprog = prog;
 }

+static int emit_call(u8 **pprog, void *func, void *ip);
+static __used void bpf_tail_call_cnt_prepare(void);
+
 /*
  * Emit x86-64 prologue code for BPF program.
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
@@ -396,9 +401,9 @@ static void emit_cfi(u8 **pprog, u32 hash)
  */
 static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 			  bool tail_call_reachable, bool is_subprog,
-			  bool is_exception_cb)
+			  bool is_exception_cb, u8 *ip)
 {
-	u8 *prog = *pprog;
+	u8 *prog = *pprog, *start = *pprog;

 	emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash);
 	/* BPF trampoline can be made to work without these nops,
@@ -407,13 +412,11 @@ static void emit_prologue(u8 **pprog, u32
stack_depth, bool ebpf_from_cbpf,
 	emit_nops(&prog, X86_PATCH_SIZE);
 	if (!ebpf_from_cbpf) {
 		if (tail_call_reachable && !is_subprog)
-			/* When it's the entry of the whole tailcall context,
-			 * zeroing rax means initialising tail_call_cnt.
-			 */
-			EMIT2(0x31, 0xC0); /* xor eax, eax */
+			emit_call(&prog, bpf_tail_call_cnt_prepare,
+				  ip + (prog - start));
 		else
 			/* Keep the same instruction layout. */
-			EMIT2(0x66, 0x90); /* nop2 */
+			emit_nops(&prog, X86_PATCH_SIZE);
 	}
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
@@ -438,8 +441,6 @@ static void emit_prologue(u8 **pprog, u32
stack_depth, bool ebpf_from_cbpf,
 	/* sub rsp, rounded_stack_depth */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
-	if (tail_call_reachable)
-		EMIT1(0x50);         /* push rax */
 	*pprog = prog;
 }

@@ -575,13 +576,53 @@ static void emit_return(u8 **pprog, u8 *ip)
 	*pprog = prog;
 }

+DEFINE_PER_CPU(u32, bpf_tail_call_cnt);
+
+static __used void bpf_tail_call_cnt_prepare(void)
+{
+	/* The following asm equals to
+	 *
+	 * u32 *tcc_ptr = this_cpu_ptr(&bpf_tail_call_cnt);
+	 *
+	 * *tcc_ptr = MAX_TAIL_CALL_CNT;
+	 */
+
+	asm volatile (
+	    "addq " __percpu_arg(0) ", %1\n\t"
+	    "movl $" __stringify(MAX_TAIL_CALL_CNT) ", (%1)\n\t"
+	    :
+	    : "m" (this_cpu_off), "r" (&bpf_tail_call_cnt)
+	);
+}
+
+static __used u32 *bpf_tail_call_cnt_ptr(void)
+{
+	u32 *tcc_ptr;
+
+	/* The following asm equals to
+	 *
+	 * u32 *tcc_ptr = this_cpu_ptr(&bpf_tail_call_cnt);
+	 *
+	 * return tcc_ptr;
+	 */
+
+	asm volatile (
+	    "addq " __percpu_arg(1) ", %2\n\t"
+	    "movq %2, %0\n\t"
+	    : "=r" (tcc_ptr)
+	    : "m" (this_cpu_off), "r" (&bpf_tail_call_cnt)
+	);
+
+	return tcc_ptr;
+}
+
 /*
  * Generate the following code:
  *
  * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) ...
  *   if (index >= array->map.max_entries)
  *     goto out;
- *   if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+ *   if ((*tcc_ptr)-- == 0)
  *     goto out;
  *   prog = array->ptrs[index];
  *   if (prog == NULL)
@@ -594,7 +635,6 @@ static void emit_bpf_tail_call_indirect(struct
bpf_prog *bpf_prog,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;

@@ -616,16 +656,16 @@ static void emit_bpf_tail_call_indirect(struct
bpf_prog *bpf_prog,
 	EMIT2(X86_JBE, offset);                   /* jbe out */

 	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+	 * if ((*tcc_ptr)-- == 0)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp -
tcc_off] */
-	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
+	/* call bpf_tail_call_cnt_ptr */
+	emit_call(&prog, bpf_tail_call_cnt_ptr, ip + (prog - start));
+	EMIT3(0x83, 0x38, 0);                     /* cmp dword ptr [rax], 0 */

 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
-	EMIT2(X86_JAE, offset);                   /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp -
tcc_off], eax */
+	EMIT2(X86_JE, offset);                    /* je out */
+	EMIT2(0xFF, 0x08);                        /* dec dword ptr [rax] */

 	/* prog = array->ptrs[index]; */
 	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 +
offsetof(...)] */
@@ -647,7 +687,6 @@ static void emit_bpf_tail_call_indirect(struct
bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}

-	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
 			    round_up(stack_depth, 8));
@@ -675,21 +714,20 @@ static void emit_bpf_tail_call_direct(struct
bpf_prog *bpf_prog,
 				      bool *callee_regs_used, u32 stack_depth,
 				      struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;

 	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+	 * if ((*tcc_ptr)-- == 0)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr
[rbp - tcc_off] */
-	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax,
MAX_TAIL_CALL_CNT */
+	/* call bpf_tail_call_cnt_ptr */
+	emit_call(&prog, bpf_tail_call_cnt_ptr, ip);
+	EMIT3(0x83, 0x38, 0);                         /* cmp dword ptr [rax], 0 */

 	offset = ctx->tail_call_direct_label - (prog + 2 - start);
-	EMIT2(X86_JAE, offset);                       /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp -
tcc_off], eax */
+	EMIT2(X86_JE, offset);                        /* je out */
+	EMIT2(0xFF, 0x08);                            /* dec dword ptr [rax] */

 	poke->tailcall_bypass = ip + (prog - start);
 	poke->adj_off = X86_TAIL_CALL_OFFSET;
@@ -706,7 +744,6 @@ static void emit_bpf_tail_call_direct(struct
bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}

-	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));

@@ -1133,10 +1170,6 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg,
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
@@ -1160,7 +1193,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int
*addrs, u8 *image, u8 *rw_image

 	emit_prologue(&prog, bpf_prog->aux->stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
-		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
+		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb,
+		      image);
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */
@@ -1752,17 +1786,11 @@ st:			if (is_imm8(insn->off))
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
 			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
 				return -EINVAL;
 			break;
@@ -2550,7 +2578,6 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
 	 * RBP - arg_stack_off [ stack_arg1 ]
-	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */

 	/* room for return value of orig_call or fentry prog */
@@ -2622,8 +2649,6 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im
 		/* sub rsp, stack_size */
 		EMIT4(0x48, 0x83, 0xEC, stack_size);
 	}
-	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
-		EMIT1(0x50);		/* push rax */
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);

@@ -2678,16 +2703,9 @@ static int __arch_prepare_bpf_trampoline(struct
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
@@ -2740,11 +2758,6 @@ static int __arch_prepare_bpf_trampoline(struct
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

Thanks,
Leon

