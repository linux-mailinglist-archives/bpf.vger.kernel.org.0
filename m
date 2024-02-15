Return-Path: <bpf+bounces-22079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1922856426
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 14:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983D7288CC1
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 13:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC055130AC2;
	Thu, 15 Feb 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnCDQfvv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5212FF63
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003007; cv=none; b=XYgL2FF8tU/gqitgZFxMA1K7ds/ClQwClEZ9CC+GLOY/OqA/sEN5Zu701HR63naySzPo8yTo3Q1f7uQ8D6+jlEf6W+DJq5ZW2vPNtJMZIDMKMLkdjjBJZRgbD/GKzx8m0hnfOuTJ0iAb56x77QMhtiu17QqSK+FTZZto1H0ymXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003007; c=relaxed/simple;
	bh=VEIju5TUcEp97GzypWRD4thmoyoSsowpEB1lp6A2IeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o99IolTOGkafowyhd+D6FsKekZWKwt6lwzYEU+x77xj2wpgK03X6qg74mBN2JSIwRjyszdzWyPsJtFi8OZ8tlpZEhrSLgloWSrJ0w/yi0DKKl9VGiYHTnUkAJD/GfnkZCx6xlcP53YEQ9OsUYG6PMOp7v78YO2hrpITCsfNoEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnCDQfvv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso786127b3a.2
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 05:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708003005; x=1708607805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZKsx2Z/h/NW4KybRtx2hvp0c5P8jUpTVELuRFYJ8s0=;
        b=OnCDQfvvAISKUta+2koJDl4OcYUROEnD1K5A9ongUrKEiyiE6fbq2pqcS8KVQFk25U
         5+qsmvZ5Nj3rQQxPgDDjDpERz3n512hLALzsFZmjIglao/0Ucg0uPtRCwke2+W8f8b8o
         RGgK/aS9on3zRyd3vraDtwAjOwFT1wiUe2xUOkTj3uT/BJzGDLHzJxJ3iOHX1fvQPrT9
         rImGbPbPBPtIl7GhMcecICZnWKDLT530oG9wGM9c2ph2Datf55pgVXfojQQ6853FsDp3
         5eSbBMzAjIHcCqgP6MYyt1i/BnFBs/ujEHe/Iy44AsYOocpBzsJFtkdSPV6C/2IlQKcr
         4+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003005; x=1708607805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZKsx2Z/h/NW4KybRtx2hvp0c5P8jUpTVELuRFYJ8s0=;
        b=M5CY6gAgMlHFRLuLvlJghYWBm6XEG/tAH6/XDmOo5LDpc1BcRlrYLcK2FZ0d00buom
         mT1fs3MpZBNMA1WsQ4koJn6fBAfZ2VyX8EEXzm0YjLhy2CvY5bC4mBhErlUO8kKI0VDL
         ErWdUAMtmSbykQSh4cv9wLftF0WaTafcOKTUYiWicL5DAa2GHlVjpVxV6wLno6Y9egS7
         lLnVvLgpYERc/Nxo6s8NLm8h7y9G6k7KgBR9RgH1K6dWCXpDzZDoj4MqGE2+wULvu2HJ
         uKnRctU3h8ZmwgPfXxVRYTamRUarm95yHx/T0FQYGEnLd8itL2iYdDNrec9aIMbRkizz
         rEMA==
X-Gm-Message-State: AOJu0YxWwPbElc2bpu10fK9odNtMVZWax6lzFMdoQ1VoOkFChJp2Mlh3
	0EG44ltS6iUD2zLYxBklmmVx81/FWoFGRF5S/1UgLDj7DOaQgOB3
X-Google-Smtp-Source: AGHT+IE4Kp2yLMRqDGF80sNqTCvBHHnxZuaMXGGFp8TbR5Q1wdyBr8cxvYIPSNdMXva7mETGakNsWw==
X-Received: by 2002:a05:6a21:151b:b0:1a0:6eb4:76e1 with SMTP id nq27-20020a056a21151b00b001a06eb476e1mr2290728pzb.4.1708003004991;
        Thu, 15 Feb 2024 05:16:44 -0800 (PST)
Received: from [172.20.10.5] ([111.65.46.187])
        by smtp.gmail.com with ESMTPSA id x64-20020a638643000000b005dc816b2369sm1333062pgd.28.2024.02.15.05.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:16:44 -0800 (PST)
Message-ID: <81607ab3-a7f5-4ad1-98c2-771c73bfb55c@gmail.com>
Date: Thu, 15 Feb 2024 21:16:37 +0800
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
 <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com>
 <CAADnVQLOswL3BY1s0B28wRZH1PU675S6_2=XknjZKNgyJ=yDxw@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQLOswL3BY1s0B28wRZH1PU675S6_2=XknjZKNgyJ=yDxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/2/15 07:16, Alexei Starovoitov wrote:
> On Tue, Feb 13, 2024 at 9:47 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 2024/1/5 12:15, Alexei Starovoitov wrote:
>>> On Thu, Jan 4, 2024 at 6:23 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>
>>>>
>>>
>>> Other alternatives?
>>
>> I've finish the POC of an alternative, which passed all tailcall
>> selftests including these tailcall hierarchy ones.
>>
>> In this alternative, I use a new bpf_prog_run_ctx to wrap the original
>> ctx and the tcc_ptr, then get the tcc_ptr and recover the original ctx
>> in JIT.
>>
>> Then, to avoid breaking runtime with tailcall on other arch, I add an
>> arch-related check bpf_jit_supports_tail_call_cnt_ptr() to determin
>> whether to use bpf_prog_run_ctx.
>>

[SNIP]

>> +
>> +       if (bpf_jit_supports_tail_call_cnt_ptr() && prog->jited)
>> +               ret = dfunc(&run_ctx, prog->insnsi, prog->bpf_func);
>> +       else
>> +               ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> 
> This is no good either.
> We cannot introduce two extra run-time checks before calling every bpf prog.
> The solution must be overhead free for common cases.
> 
> Can we switch to percpu tail_call_cnt instead of on stack and %rax tricks ?
> 

Good idea to use percpu tail_call_cnt.

I did another POC to use percpu tail_call_cnt, which passed all tailcall
selftests too.

In this POC, in order to prepare tcc_ptr at the prologue of x86 JIT,
it's to call bpf_tail_call_cnt_prepare() to get the pointer that points
to percpu tail_call_cnt, and to store the pointer to %rax meanwhile.

Here's the diff:

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4065bdcc5b2a4..fc1df6a7d87c9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -241,6 +241,8 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 }

 struct jit_context {
+	int prologue_tail_call_offset;
+
 	int cleanup_addr; /* Epilogue code offset */

 	/*
@@ -250,6 +252,8 @@ struct jit_context {
 	 */
 	int tail_call_direct_label;
 	int tail_call_indirect_label;
+
+	bool tail_call_reachable;
 };

 /* Maximum number of bytes emitted while JITing one eBPF insn */
@@ -259,7 +263,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(22 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(14 + ENDBR_INSN_SIZE)

 static void push_r12(u8 **pprog)
 {
@@ -389,6 +393,19 @@ static void emit_cfi(u8 **pprog, u32 hash)
 	*pprog = prog;
 }

+DEFINE_PER_CPU(u32, bpf_tail_call_cnt);
+
+__attribute__((used))
+static u32 *bpf_tail_call_cnt_prepare(void)
+{
+	u32 *tcc_ptr = this_cpu_ptr(&bpf_tail_call_cnt);
+
+	/* Initialise tail_call_cnt. */
+	*tcc_ptr = 0;
+
+	return tcc_ptr;
+}
+
 /*
  * Emit x86-64 prologue code for BPF program.
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
@@ -396,7 +413,7 @@ static void emit_cfi(u8 **pprog, u32 hash)
  */
 static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 			  bool tail_call_reachable, bool is_subprog,
-			  bool is_exception_cb)
+			  bool is_exception_cb, struct jit_context *ctx)
 {
 	u8 *prog = *pprog;

@@ -406,21 +423,15 @@ static void emit_prologue(u8 **pprog, u32
stack_depth, bool ebpf_from_cbpf,
 	 */
 	emit_nops(&prog, X86_PATCH_SIZE);
 	if (!ebpf_from_cbpf) {
-		if (tail_call_reachable && !is_subprog) {
-			/* When it's the entry of the whole tailcall context,
-			 * zeroing rax means initialising tail_call_cnt.
-			 */
-			EMIT2(0x31, 0xC0);       /* xor eax, eax */
-			EMIT1(0x50);             /* push rax */
-			/* Make rax as ptr that points to tail_call_cnt. */
-			EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
-			EMIT1_off32(0xE8, 2);    /* call main prog */
-			EMIT1(0x59);             /* pop rcx, get rid of tail_call_cnt */
-			EMIT1(0xC3);             /* ret */
-		} else {
-			/* Keep the same instruction size. */
-			emit_nops(&prog, 13);
-		}
+		/* These 5-bytes nops is prepared to emit_call() to call
+		 * bpf_tail_call_cnt_prepare later.
+		 *
+		 * After calling bpf_tail_call_cnt_prepare, %rax will be
+		 * the tail_call_cnt pointer that points to an initialised
+		 * PER-CPU tail_call_cnt.
+		 */
+		ctx->prologue_tail_call_offset = prog - *pprog;
+		emit_nops(&prog, X86_PATCH_SIZE);
 	}
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
@@ -583,6 +594,17 @@ static void emit_return(u8 **pprog, u8 *ip)
 	*pprog = prog;
 }

+static void bpf_tail_call_prologue_fixup(u8 *image, struct bpf_prog *prog,
+					 struct jit_context *ctx)
+{
+	bool ebpf_from_cbpf = bpf_prog_was_classic(prog);
+	u8 *ip = image + ctx->prologue_tail_call_offset;
+
+	if (!ebpf_from_cbpf && ctx->tail_call_reachable && !bpf_is_subprog(prog))
+		__bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL,
+				     bpf_tail_call_cnt_prepare);
+}
+
 /*
  * Generate the following code:
  *
@@ -1165,10 +1187,12 @@ static int do_jit(struct bpf_prog *bpf_prog, int
*addrs, u8 *image, u8 *rw_image

 	/* tail call's presence in current prog implies it is reachable */
 	tail_call_reachable |= tail_call_seen;
+	ctx->tail_call_reachable = tail_call_reachable;

 	emit_prologue(&prog, bpf_prog->aux->stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
-		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
+		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb,
+		      ctx);
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */
@@ -3097,6 +3121,7 @@ struct bpf_prog *bpf_int_jit_compile(struct
bpf_prog *prog)
 			}

 			bpf_tail_call_direct_fixup(prog);
+			bpf_tail_call_prologue_fixup(image, prog, &ctx);
 		} else {
 			jit_data->addrs = addrs;
 			jit_data->ctx = ctx;

Thanks,
Leon

