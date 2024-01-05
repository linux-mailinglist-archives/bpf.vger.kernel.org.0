Return-Path: <bpf+bounces-19112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF89824E89
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 07:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E9D1F22519
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB975690;
	Fri,  5 Jan 2024 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTBcXyip"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73B610E
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d4a980fdedso9368335ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 22:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704435363; x=1705040163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3NX7XOwiEfZ6zJGfheJUMmxobQkLM6PSUzG9+Rlyuiw=;
        b=iTBcXyipP4PrA8dMjrKiyHFiecNiT6CmVkNi9q9OMLwIcFVbNBl/TbyYXQZ9dEcQty
         hXVNSaRo2cgiDiCwk7RIY/U68ea8M3gQmu4UHD9OFkZ10eTK39/7QLfCYH+DGPZU91GB
         KEJbMkcd/pjrHuLjFhqq+wENsZ4aWU0TXdD/Eqh/4QaXxTnlLtaKQtgHLOdPa8/fCQ6T
         X50jTUgGlhme2xJi+E8CP90rqKR1bwWKkWGyCtwThPP95Dn5qO2AvlQh4CEp10fVnos/
         53OOApgk8RaBgr/Ob/TX2L2MQD5CEGxDYeOxK3RLssYppcYCmunmjiGhiok+Lt8FJ0D/
         ujdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704435363; x=1705040163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NX7XOwiEfZ6zJGfheJUMmxobQkLM6PSUzG9+Rlyuiw=;
        b=Gi1D4un0IUHovIuqYcleJFvP9mW/WYinud1/TosC9S2Y68bsWRQwiQFRfBjhjsFIdH
         rPe5yI+ldnwQHyj2tdBpEE+7TGK+PUX3+BKZfyjpYGuEcRDN2lW7mATiR+SswuGfPCuw
         2EpcLOj+wg//F89i08qpqKjdWNM7rdMZvkW4iQWSX4o96/eMxCA2eZMs3cmANUcASbMX
         1D5VuZaT7cXYaZFvUTlLSdnuCYnex2m++kZPLmWpjpgTld5MAVCV08qRu4/1M8ZR9MOs
         6zcddrSao8uiT1Dt8WjF3vsl+8UAWFyOlDEV+RfYb7MfSFWbBEsAHXhrU7Vha35V0ruu
         eqdw==
X-Gm-Message-State: AOJu0YzukqUXdQM4XR7vfgT5MkFnPJ2xt2RhrBZVCbpNIu0EPJIK/GOo
	HAPBGLD1wGv9RQUPBd3HlRliRzvPwgc=
X-Google-Smtp-Source: AGHT+IG5KRHzsvTuXSLjAHZZIhduGtVCSte7fRiuxIjXeTrjjUxEg0WAoNMainxaWvDFeeMB7YM0tw==
X-Received: by 2002:a17:902:da8b:b0:1d3:ee1f:ce54 with SMTP id j11-20020a170902da8b00b001d3ee1fce54mr2032927plx.89.1704435362672;
        Thu, 04 Jan 2024 22:16:02 -0800 (PST)
Received: from [10.22.68.80] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id v10-20020a170902b7ca00b001d414a00fd9sm598184plz.29.2024.01.04.22.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 22:16:02 -0800 (PST)
Message-ID: <43499e38-f395-4efd-867f-8a2fa0571ecd@gmail.com>
Date: Fri, 5 Jan 2024 14:15:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
References: <20240104142226.87869-1-hffilwlqm@gmail.com>
 <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/1/24 12:15, Alexei Starovoitov wrote:
> On Thu, Jan 4, 2024 at 6:23 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index fe30b9ebb8de4..67fa337fc2e0c 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -259,7 +259,7 @@ struct jit_context {
>>  /* Number of bytes emit_patch() needs to generate instructions */
>>  #define X86_PATCH_SIZE         5
>>  /* Number of bytes that will be skipped on tailcall */
>> -#define X86_TAIL_CALL_OFFSET   (11 + ENDBR_INSN_SIZE)
>> +#define X86_TAIL_CALL_OFFSET   (22 + ENDBR_INSN_SIZE)
>>
>>  static void push_r12(u8 **pprog)
>>  {
>> @@ -406,14 +406,21 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>          */
>>         emit_nops(&prog, X86_PATCH_SIZE);
>>         if (!ebpf_from_cbpf) {
>> -               if (tail_call_reachable && !is_subprog)
>> +               if (tail_call_reachable && !is_subprog) {
>>                         /* When it's the entry of the whole tailcall context,
>>                          * zeroing rax means initialising tail_call_cnt.
>>                          */
>> -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
>> -               else
>> -                       /* Keep the same instruction layout. */
>> -                       EMIT2(0x66, 0x90); /* nop2 */
>> +                       EMIT2(0x31, 0xC0);       /* xor eax, eax */
>> +                       EMIT1(0x50);             /* push rax */
>> +                       /* Make rax as ptr that points to tail_call_cnt. */
>> +                       EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
>> +                       EMIT1_off32(0xE8, 2);    /* call main prog */
>> +                       EMIT1(0x59);             /* pop rcx, get rid of tail_call_cnt */
>> +                       EMIT1(0xC3);             /* ret */
>> +               } else {
>> +                       /* Keep the same instruction size. */
>> +                       emit_nops(&prog, 13);
>> +               }
> 
> I'm afraid the extra call breaks stack unwinding and many other things.

I was worried about it. But I'm not sure how it breaks stack unwinding.

However, without the extra call, I've tried another approach:

* [RFC PATCH bpf-next 1/3] bpf, x64: Fix tailcall hierarchy
  https://lore.kernel.org/bpf/20231005145814.83122-2-hffilwlqm@gmail.com/

It's to propagate tail_call_cnt_ptr, too. But more complicated:

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8c10d9abc..001c5e4b7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -313,24 +332,15 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 			  bool tail_call_reachable, bool is_subprog,
 			  bool is_exception_cb)
 {
+	int tcc_ptr_off = round_up(stack_depth, 8) + 8;
+	int tcc_off = tcc_ptr_off + 8;
 	u8 *prog = *pprog;
 
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
 	EMIT_ENDBR();
-	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
-	prog += X86_PATCH_SIZE;
-	if (!ebpf_from_cbpf) {
-		if (tail_call_reachable && !is_subprog)
-			/* When it's the entry of the whole tailcall context,
-			 * zeroing rax means initialising tail_call_cnt.
-			 */
-			EMIT2(0x31, 0xC0); /* xor eax, eax */
-		else
-			/* Keep the same instruction layout. */
-			EMIT2(0x66, 0x90); /* nop2 */
-	}
+	emit_nops(&prog, X86_PATCH_SIZE);
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
 		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
@@ -347,15 +357,52 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 		EMIT1(0x55);             /* push rbp */
 		EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
 	}
+	if (!ebpf_from_cbpf) {
+		if (tail_call_reachable && !is_subprog) {
+			/* Make rax as ptr that points to tail_call_cnt. */
+			EMIT3(0x48, 0x89, 0xE8);          /* mov rax, rbp */
+			EMIT2_off32(0x48, 0x2D, tcc_off); /* sub rax, tcc_off */
+			/* When it's the entry of the whole tail call context,
+			 * storing 0 means initialising tail_call_cnt.
+			 */
+			EMIT2_off32(0xC7, 0x00, 0);       /* mov dword ptr [rax], 0 */
+		} else {
+			/* Keep the same instruction layout. */
+			emit_nops(&prog, 3);
+			emit_nops(&prog, 6);
+			emit_nops(&prog, 6);
+		}
+	}
 
 	/* X86_TAIL_CALL_OFFSET is here */
 	EMIT_ENDBR();
 
+	if (tail_call_reachable) {
+		/* Here, rax is tail_call_cnt_ptr. */
+		if (!is_subprog) {
+			/* Because pushing tail_call_cnt_ptr may cover tail_call_cnt,
+			 * it's required to store tail_call_cnt before storing
+			 * tail_call_cnt_ptr.
+			 */
+			EMIT1(0x50);                       /* push rax */
+			EMIT2(0x8B, 0x00);                 /* mov eax, dword ptr [rax] */
+			EMIT2_off32(0x89, 0x85, -tcc_off); /* mov dword ptr [rbp - tcc_off], eax */
+			EMIT1(0x58);                       /* pop rax */
+			/* mov qword ptr [rbp - tcc_ptr_off], rax */
+			EMIT3_off32(0x48, 0x89, 0x85, -tcc_ptr_off);
+		} else {
+			/* As for subprog, tail_call_cnt is meaningless. Storing
+			 * tail_call_cnt_ptr is enough.
+			 */
+			/* mov qword ptr [rbp - tcc_ptr_off], rax */
+			EMIT3_off32(0x48, 0x89, 0x85, -tcc_ptr_off);
+		}
+		/* Reserve 16 bytes for tail_call_cnt_ptr and tail_call_cnt. */
+		stack_depth += 16;
+	}
 	/* sub rsp, rounded_stack_depth */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
-	if (tail_call_reachable)
-		EMIT1(0x50);         /* push rax */
 	*pprog = prog;
 }

How about this approach?

Thanks,
Leon

> The proper frame needs to be setup (push rbp; etc)
> and 'leave' + emit_return() is used.
> Plain 'ret' is not ok.
> x86_call_depth_emit_accounting() needs to be used too.
> That will make X86_TAIL_CALL_OFFSET adjustment very complicated.
> Also the fix doesn't address the stack size issue.
> We shouldn't allow all the extra frames at run-time.
> 
> The tail_cnt_ptr approach is interesting but too heavy,
> since arm64, s390 and other JITs would need to repeat it with equally
> complicated calculations in TAIL_CALL_OFFSET.
> 
> The fix should really be thought through for all JITs. Not just x86.
> 
> I'm thinking whether we should do the following instead:
> 
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 0bdbbbeab155..0b45571559be 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -910,7 +910,7 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
>         if (IS_ERR(prog))
>                 return prog;
> 
> -       if (!bpf_prog_map_compatible(map, prog)) {
> +       if (!bpf_prog_map_compatible(map, prog) || prog->aux->func_cnt) {
>                 bpf_prog_put(prog);
>                 return ERR_PTR(-EINVAL);
>         }
> 
> This will stop stack growth, but it will break a few existing tests.
> I feel it's a price worth paying.
> 
> John, Daniel,
> 
> do you see anything breaking on cilium side if we disallow
> progs with subprogs to be inserted in prog_array ?
> 
> Other alternatives?

