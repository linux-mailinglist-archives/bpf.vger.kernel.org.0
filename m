Return-Path: <bpf+bounces-21948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2308D854284
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 06:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402761C2446A
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 05:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0220ED510;
	Wed, 14 Feb 2024 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtg/UplI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A2D310
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 05:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707889674; cv=none; b=KatPffd0JQ7p1NTH0YMbQcsOgbSCf9KFHSwr+4M8RzFSHqlYQ+twy3GQGXGZLDdIXFsycW4BBYIXhb75ajvGK6L0dJwpo58tPsh0F4IyJHfFNhOL0nQp1YkzbvP2juBJ+dZD2At4WnYSYGLkDc6h9m5KsKupyttygB3uZgpx7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707889674; c=relaxed/simple;
	bh=Q/EkBthXF8JTpmlEQasVxlFYd8vsdk/tJQjpqqKch5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7wcdZRBjt9PhgNIZZRfCnxo3oVF8J6XOhh+zGfpjd1zbLB7L9rbMmbBOewnZc36NokIb7OxgopPqiyfkCqoBXP2VKUpfW3t6UP58huAthkHtzDmQPOQBEfk77hsf/MCh1G0WINBxtGz7HAKbuqfmACZmdQgkmY4gWoNJsRBCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qtg/UplI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7858a469aso34522135ad.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 21:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707889672; x=1708494472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+J+gHmkWUpFDPat4xVKGOF8H3lqlCxrIL6pcKwe0/UI=;
        b=Qtg/UplIzbZYOcesqekFCVVbinlYGs43Q3bhLjoeQ8UyBXggDglEO1RR7y+3eK6GjS
         h5QWA3+DTW4VJ8VfifF+3GQ7q+6/dTpXn5HqCW19rdXzSfnXpTm0eL7m6pGQ+HkqGr9Z
         HkpNmeR7KbyHE8lh/jdHxJW2Hq2VUCQS4pxqHjVpKv7bCyZnyfqijbsxNmpJorCKHSYh
         xsdc9a4nNllyIX2rVTWTX/PkVEoccmjQanWy4eFHVsnm9vn0k4/aacKZJiuhNiphWW5o
         4YeAV01z7pOz9/0140hXm6DAfu7BF6ANiLULfxf/ZAhiLvlifGzm558LWufVhd7W0xOQ
         4biQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707889672; x=1708494472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+J+gHmkWUpFDPat4xVKGOF8H3lqlCxrIL6pcKwe0/UI=;
        b=w9l3tm73Fo/z7acqzHwXFWbj7yLRfSBBZfGT2xZeJxfbpIBsWf8vqjytr2GqogzyJw
         cms4FsSakRhM92xzvxFzQW4rwuhLcHe4Z1ZWGV07bQfzN5okhIUlfrclgjprlJELNPoK
         pt5CQGpxHboRhB+zdk5BLN9w+aMBCJ7l4PwKTt7pjtVmgpVVjoa0IQja6j93gJVFEnB3
         0py+WRWpubpbvZ7CpfifmUNUSs5zK92T/D3OKosFH9NX4jmWI1FAGAnCruPsfeUA32Wl
         F7L5wj7Iwms7hVKSmEfV2Z/8vjCZkHw/Lr34+nYVPipNJWW/x6glTIm37+xRCjg6yHGa
         YUyw==
X-Gm-Message-State: AOJu0YyRiLmISyYNGIRDI+Qo0P/i6Xl3PWojVexrFRNme5WkiJms0Zfc
	fHXQkGNxleO6bpLaJyP3hJSzR//5TS0fEQx2SyYUNj2BSn0R5Bj5
X-Google-Smtp-Source: AGHT+IE9zFDCyLG1h8J2m01iGGhm4j5k4A77eP0Co++OpCWhW6//GlWJsN/qgppOyZ/y5PPSzDCPaQ==
X-Received: by 2002:a17:902:a3c3:b0:1db:4245:454b with SMTP id q3-20020a170902a3c300b001db4245454bmr1475456plb.57.1707889672205;
        Tue, 13 Feb 2024 21:47:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIgLIsD1ls9O65R/FCXt6rmOLn75yCPyRZKiyWnR1EAiCCRCOI/28E3sVx2Li1IHbAyqBjyvhoDKmvxwqdBvXmsbVoJXY7Rbn4NWo5B/eRRJyl1FFPyIzRauZukI6zgUHMaVY3BZSFpuAizfbzhCCq4kcRKpDlvCexeYXACRSgM5WCBkCDvj5YH+N2BwgJOSXHKy4sc3N2XpHMy2J9b15FAVSKQPanVccgOtqTRbPEwugYff95jitBpG1SoLMLMOZp4JQ/zsvbxNDL6Y3nmKwYrfafzRnlG8jpeMCkQUkWCA==
Received: from [172.20.10.5] ([111.65.58.112])
        by smtp.gmail.com with ESMTPSA id kr3-20020a170903080300b001db604f41dcsm224116plb.103.2024.02.13.21.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 21:47:51 -0800 (PST)
Message-ID: <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com>
Date: Wed, 14 Feb 2024 13:47:45 +0800
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



On 2024/1/5 12:15, Alexei Starovoitov wrote:
> On Thu, Jan 4, 2024 at 6:23 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
> 
> Other alternatives?

I've finish the POC of an alternative, which passed all tailcall
selftests including these tailcall hierarchy ones.

In this alternative, I use a new bpf_prog_run_ctx to wrap the original
ctx and the tcc_ptr, then get the tcc_ptr and recover the original ctx
in JIT.

Then, to avoid breaking runtime with tailcall on other arch, I add an
arch-related check bpf_jit_supports_tail_call_cnt_ptr() to determin
whether to use bpf_prog_run_ctx.

Here's the diff:

 diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4065bdcc5b2a4..56cea2676863e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -259,7 +259,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(22 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(16 + ENDBR_INSN_SIZE)

 static void push_r12(u8 **pprog)
 {
@@ -407,21 +407,19 @@ static void emit_prologue(u8 **pprog, u32
stack_depth, bool ebpf_from_cbpf,
 	emit_nops(&prog, X86_PATCH_SIZE);
 	if (!ebpf_from_cbpf) {
 		if (tail_call_reachable && !is_subprog) {
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
+			/* Make rax as tcc_ptr. */
+			EMIT4(0x48, 0x8B, 0x47, 0x08); /* mov rax, qword ptr [rdi + 8] */
 		} else {
-			/* Keep the same instruction size. */
-			emit_nops(&prog, 13);
+			/* Keep the same instruction layout. */
+			emit_nops(&prog, 4);
 		}
 	}
+	if (!is_subprog)
+		/* Recover the original ctx. */
+		EMIT3(0x48, 0x8B, 0x3F); /* mov rdi, qword ptr [rdi] */
+	else
+		/* Keep the same instruction layout. */
+		emit_nops(&prog, 3);
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
 		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
@@ -3152,6 +3150,12 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }

+/* Indicate the JIT backend supports tail call count pointer in
tailcall context. */
+bool bpf_jit_supports_tail_call_cnt_ptr(void)
+{
+	return true;
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7671530d6e4e0..fea4326c27d31 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1919,6 +1919,11 @@ int bpf_prog_array_copy(struct bpf_prog_array
*old_array,
 			u64 bpf_cookie,
 			struct bpf_prog_array **new_array);

+struct bpf_prog_run_ctx {
+	const void *ctx;
+	u32 *tail_call_cnt;
+};
+
 struct bpf_run_ctx {};

 struct bpf_cg_run_ctx {
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 68fb6c8142fec..c1c035c44b4ab 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -629,6 +629,10 @@ typedef unsigned int (*bpf_dispatcher_fn)(const
void *ctx,
 					  unsigned int (*bpf_func)(const void *,
 								   const struct bpf_insn *));

+static __always_inline u32 __bpf_prog_run_dfunc(const struct bpf_prog
*prog,
+						const void *ctx,
+						bpf_dispatcher_fn dfunc);
+
 static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 					  const void *ctx,
 					  bpf_dispatcher_fn dfunc)
@@ -641,14 +645,14 @@ static __always_inline u32 __bpf_prog_run(const
struct bpf_prog *prog,
 		u64 start = sched_clock();
 		unsigned long flags;

-		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+		ret = __bpf_prog_run_dfunc(prog, ctx, dfunc);
 		stats = this_cpu_ptr(prog->stats);
 		flags = u64_stats_update_begin_irqsave(&stats->syncp);
 		u64_stats_inc(&stats->cnt);
 		u64_stats_add(&stats->nsecs, sched_clock() - start);
 		u64_stats_update_end_irqrestore(&stats->syncp, flags);
 	} else {
-		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+		ret = __bpf_prog_run_dfunc(prog, ctx, dfunc);
 	}
 	return ret;
 }
@@ -952,12 +956,31 @@ struct bpf_prog *bpf_int_jit_compile(struct
bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_supports_subprog_tailcalls(void);
+bool bpf_jit_supports_tail_call_cnt_ptr(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64
sp, u64 bp), void *cookie);
 bool bpf_helper_changes_pkt_data(void *func);

+static __always_inline u32 __bpf_prog_run_dfunc(const struct bpf_prog
*prog,
+						const void *ctx,
+						bpf_dispatcher_fn dfunc)
+{
+	struct bpf_prog_run_ctx run_ctx = {};
+	u32 ret, tcc = 0;
+
+	run_ctx.ctx = ctx;
+	run_ctx.tail_call_cnt = &tcc;
+
+	if (bpf_jit_supports_tail_call_cnt_ptr() && prog->jited)
+		ret = dfunc(&run_ctx, prog->insnsi, prog->bpf_func);
+	else
+		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+
+	return ret;
+}
+
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
 {
 	/* Reconstruction of call-sites is dependent on kallsyms,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ea6843be2616c..80b20e99456f0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2915,6 +2915,15 @@ bool __weak bpf_jit_supports_subprog_tailcalls(void)
 	return false;
 }

+/* Return TRUE if the JIT backend supports tail call count pointer in
tailcall
+ * context.
+ */
+bool __weak bpf_jit_supports_tail_call_cnt_ptr(void)
+{
+	return false;
+}
+EXPORT_SYMBOL(bpf_jit_supports_tail_call_cnt_ptr);
+
 bool __weak bpf_jit_supports_kfunc_call(void)
 {
 	return false;

Why use EXPORT_SYMBOL here?

It's to avoid the building error.

ERROR: modpost: "bpf_jit_supports_tail_call_cnt_ptr"
[net/sched/act_bpf.ko] undefined!
ERROR: modpost: "bpf_jit_supports_tail_call_cnt_ptr"
[net/sched/cls_bpf.ko] undefined!
ERROR: modpost: "bpf_jit_supports_tail_call_cnt_ptr"
[net/netfilter/xt_bpf.ko] undefined!
ERROR: modpost: "bpf_jit_supports_tail_call_cnt_ptr" [net/ipv6/ipv6.ko]
undefined!

I'm not familiar with this building error. Is it OK to use EXPORT_SYMBOL
here?

Thanks,
Leon


