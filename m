Return-Path: <bpf+bounces-26724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6408A4223
	for <lists+bpf@lfdr.de>; Sun, 14 Apr 2024 13:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73721F21548
	for <lists+bpf@lfdr.de>; Sun, 14 Apr 2024 11:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DA736B1C;
	Sun, 14 Apr 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIq4lR1l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB821A1C
	for <bpf@vger.kernel.org>; Sun, 14 Apr 2024 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713095288; cv=none; b=iBkXHqpT5gt6v1bUxEghPIespK4GFGdWXI0B8erlu7R1QG8iMdyxUBcScRFRrmB3BrYo9MAM07eJVKDqVEWq+Pue+UU1TAiB2//vIF3WR/wPoEdlsV2TRXsRF2arHf2v6jGhY3/CRcnLBgnRTbpJz49zmB5hI0TIScE8Y5YkDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713095288; c=relaxed/simple;
	bh=y2p4h6pEiYs15ii7h5Jj1DGhU9jKvclPdKtw6aJVAkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwPG6sEHifdc3iD03/Rw+bKWn/wPDZntMIYkAlTqXMlwyXr96rJksh2HOM1xsHI8va7Gsq2xd27dXwWuT0ToFt3uch/P47+c/iIZOlPFOoPmwf1G5sGLc89nBpt8GGCou/QMfn/T/4UhZbWW3N2dEH1Hlot9+wStRQyh6RKn6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIq4lR1l; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so1189608a91.3
        for <bpf@vger.kernel.org>; Sun, 14 Apr 2024 04:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713095277; x=1713700077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3P/crFLl+IsS4DFtH782LMl+4qybiDEEnusn/8GwV4=;
        b=hIq4lR1lvWi2mIPHU3chGrtkFnMVh1ZS6EsC/Qx0n7GPMNJwh9XLXgF6Jfvu1lO6rH
         ZHCTZs2UfEODTRi/U+anPcZPYuzjTKxqJmVcd9vPtjwMq6QLQvLGQBmlhxZMxNLhLNCv
         gHb0IzvCQcGlTOC88sk+SByHVuaNMEZSkNznUB8zfX9ATSg8ISFmYfzU7Vhhazu5Xlt/
         8chbuzf+W/KJw7TetO3CXmJDEUhiMzUNCvdYR5lApH+wzMeWB6n0mbFtyIUID4DMZs+M
         xnpqLcpmuQk6haMY1o1kO78k3/bQBwuQM2MvG2Hd7ZIzklfd02DAqTGPX7EVK+eI2CMH
         x63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713095277; x=1713700077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3P/crFLl+IsS4DFtH782LMl+4qybiDEEnusn/8GwV4=;
        b=r9tS9SyOSTebIFpdmz6rfBPUtPZLF7gOnudQVDg4S6aNWQGo5KPxdnIS+OKi/Fto/D
         rAiqpOepnxiRXzptfeqFO2J8OIFhn+d9qxhcpIQWtKO0qpPEpZ+zEflmEa8VO1gjoaFy
         3Mu0e9hJ4cUilyDUUpdGflW/EEmraLyIZJez+C8rYbbZMOOXG4TPwrk7B+LzmrrhZfeL
         YhpLLY+l7JynWWKbbhPlFRY607+8hAbMdlUEB8nuuNeALcBF1ZzQ6Xmh7SIU/QNCom+y
         /5lbaY177q95cOHW7JocxhVSEZybBeWug3OZjOYKi68Bv5QNSdL1UagD+KKT4KoFjDIS
         clbg==
X-Gm-Message-State: AOJu0Yzwxd2jOPM/Ryj9EpgKz2FlIRYpSUkWx/YDqYcsxKBl+KJ6vfhI
	pQeG5cEwUhAm2DdoGmDaUcHZWxdUV8hK2AtFE/vqhc4SFhT2/ZlS
X-Google-Smtp-Source: AGHT+IG3ZpNrHFI6GjnPuzP8UYUb6is/8PV4IfyVlBN1BTfw4l1WNnXkWhO/Yt2iz02ZHLRRjBQrkw==
X-Received: by 2002:a17:90a:4298:b0:2a3:394:7f06 with SMTP id p24-20020a17090a429800b002a303947f06mr5657863pjg.19.1713095277365;
        Sun, 14 Apr 2024 04:47:57 -0700 (PDT)
Received: from [192.168.1.76] (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id h10-20020a63e14a000000b005f3c5cf33b5sm5469104pgk.37.2024.04.14.04.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 04:47:56 -0700 (PDT)
Message-ID: <0d8f29c9-c9cb-4f88-99c1-33222d230f59@gmail.com>
Date: Sun, 14 Apr 2024 19:47:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] bpf, x64: Fix tailcall hierarchy
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Pu Lehui <pulehui@huawei.com>,
 Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
References: <20240402152638.31377-1-hffilwlqm@gmail.com>
 <20240402152638.31377-3-hffilwlqm@gmail.com>
 <CAADnVQ+vJyi6JFsck8KbyxvOuRvmAO5gVTJPwNiyNeBwzsHu9Q@mail.gmail.com>
 <55442238-33d6-4e7d-9dd1-e36da20f7c90@gmail.com>
 <CAADnVQKxnEBS7JxK8YqXaa1C0kZZ=KSyPmqiE79KuZbe8Y_7YA@mail.gmail.com>
 <6140d7a3-53c6-46ea-b812-d2f45ed2ca92@gmail.com>
 <CAADnVQK1qF+uBjwom2s2W-yEmgd_3rGi5Nr+KiV3cW0T+UPPfA@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQK1qF+uBjwom2s2W-yEmgd_3rGi5Nr+KiV3cW0T+UPPfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/4/11 11:42, Alexei Starovoitov wrote:
> On Wed, Apr 10, 2024 at 7:09 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>> Why did I raise this approach, tcc in task_struct? When I tried to
>> figure out a better position to store tcc instead as a stack variable or
>> a per-cpu variable, why not store it in runtime context?
>> Around a tail call, the tail caller and the tail callee run on the same
>> thread, and the thread won't be migrated because of migrate_disable(),
>> if I understand correctly. As a consequence, it's better to store tcc in
>> thread struct or in thread local storage. In kernel, task_struct is the
>> thread struct, if I understand correctly. Thereafter, when multiple
>> progs tail_call-ing on the same cpu, the per-task tcc should limit them
>> independently, e.g.
>>
>>    prog1     prog2
>>   thread1   thread2
>>      |         |
>>      |--sched->|
>>      |         |
>>      |<-sched--|
>>      |         |
>>    ---------------
>>         CPU1
>>
>> NOTE: prog1 is diff from prog2. And they have tail call to handle while
>> they're scheduled.
>>
>> The tcc in thread2 would not override the tcc in thread1.
>>
>> When the same scenario as the above diagram shows happens to per-cpu tcc
>> approach, the tcc in thread2 will override the tcc in thread1. As a
>> result, per-cpu tcc cannot limit the tail call in thread1 and thread2
>> independently. This is what I concern about per-cpu tcc approach.
> 
> The same issue exists with per-task tcc.
> In the above example prog1 and prog2 can be in the same thread1.
> Example: prog1 is a kprobe-prog and prog2 is fentry prog that attaches
> to something that prog1 is going to call.
> When prog2 starts it will overwrite tcc in task.
> So same issue as with per-cpu tcc.

Oh, it's a horrible case for per-cpu/per-task approach.

It pushes me back to tcc_ptr-propagating approach, even though it is not
as elegant as per-cpu approach. But it works.

It stores tcc on stack of dispatcher function, like

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5034c1b4ded7b..c53e81102c150 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1225,7 +1225,7 @@ struct bpf_dispatcher {
 #define __bpfcall __nocfi
 #endif

-static __always_inline __bpfcall unsigned int bpf_dispatcher_nop_func(
+static notrace __used __bpfcall unsigned int bpf_dispatcher_nop_func(
 	const void *ctx,
 	const struct bpf_insn *insnsi,
 	bpf_func_t bpf_func)
@@ -1233,6 +1233,25 @@ static __always_inline __bpfcall unsigned int
bpf_dispatcher_nop_func(
 	return bpf_func(ctx, insnsi);
 }

+struct bpf_tail_call_run_ctx {
+	const void *ctx;
+	u32 *tail_call_cnt;
+};
+
+static notrace __used __bpfcall unsigned int bpf_dispatcher_tail_call_func(
+	const void *ctx,
+	const struct bpf_insn *insnsi,
+	bpf_func_t bpf_func)
+{
+	struct bpf_tail_call_run_ctx run_ctx = {};
+	u32 tail_call_cnt = 0;
+
+	run_ctx.ctx = ctx;
+	run_ctx.tail_call_cnt = &tail_call_cnt;
+
+	return bpf_func(&run_ctx, insnsi);
+}
+
 /* the implementation of the opaque uapi struct bpf_dynptr */
 struct bpf_dynptr_kern {
 	void *data;


Then, it propagates the original ctx with tcc_ptr in
bpf_tail_call_run_ctx by using the original ctx position.

And, it gets tcc_ptr and recovers the original ctx at prologue, like

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2b5a475c4dd0d..a8ef1dbf141cc 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -273,7 +273,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(16 + ENDBR_INSN_SIZE)

 static void push_r12(u8 **pprog)
 {
@@ -420,14 +420,16 @@ static void emit_prologue(u8 **pprog, u32
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
+			/* Make rax as tcc_ptr. */
+			/* mov rax, qword ptr [rdi + 8] */
+			EMIT4(0x48, 0x8B, 0x47, 0x08);
+			/* Recover the original ctx. */
+			EMIT3(0x48, 0x8B, 0x3F); /* mov rdi, qword ptr [rdi] */
+		} else {
 			/* Keep the same instruction layout. */
-			EMIT2(0x66, 0x90); /* nop2 */
+			emit_nops(&prog, 7);
+		}
 	}


Thereafter, it propagates tcc_ptr by rax and stack.

But, when does it use bpf_dispatcher_tail_call_func()?

It stores bpf prog's dispatcher function in prog->aux at bpf prog
loading time's bpf_prog_select_runtime().

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5034c1b4ded7b..c53e81102c150 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1425,6 +1444,10 @@ struct btf_mod_pair {

 struct bpf_kfunc_desc_tab;

+typedef unsigned int (*bpf_dispatcher_func)(const void *ctx,
+					    const struct bpf_insn *insnsi,
+					    bpf_func_t bpf_func);
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1485,6 +1508,7 @@ struct bpf_prog_aux {
 	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 	char name[BPF_OBJ_NAME_LEN];
 	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
+	bpf_dispatcher_func dfunc;
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a41718eaeefe7..00cd48eb70de0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2368,6 +2368,19 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
 #endif
 }

+static void bpf_prog_select_dispatcher_func(struct bpf_prog *fp)
+{
+	if (fp->aux->tail_call_reachable && fp->jited &&
+	    bpf_jit_supports_tail_call_cnt_ptr()) {
+		fp->aux->dfunc = bpf_dispatcher_tail_call_func;
+		return;
+	}
+
+	fp->aux->dfunc = fp->type == BPF_PROG_TYPE_XDP ?
+			 BPF_DISPATCHER_FUNC(xdp) :
+			 bpf_dispatcher_nop_func;
+}
+
 /**
  *	bpf_prog_select_runtime - select exec runtime for BPF program
  *	@fp: bpf_prog populated with BPF program
@@ -2429,6 +2442,10 @@ struct bpf_prog *bpf_prog_select_runtime(struct
bpf_prog *fp, int *err)
 	 * all eBPF JITs might immediately support all features.
 	 */
 	*err = bpf_check_tail_call(fp);
+	if (*err)
+		return fp;
+
+	bpf_prog_select_dispatcher_func(fp);

 	return fp;
 }


Yeah, here, it adds bpf_jit_supports_tail_call_cnt_ptr() to determine
whether the arch JIT supports tcc_ptr.

Finally, when to run bpf prog, it uses the dispatcher function in
prog->aux to run it.

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7a27f19bf44d0..b0278305bdc51 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -662,14 +662,9 @@ extern int (*nfct_btf_struct_access)(struct
bpf_verifier_log *log,
 				     const struct bpf_reg_state *reg,
 				     int off, int size);

-typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
-					  const struct bpf_insn *insnsi,
-					  unsigned int (*bpf_func)(const void *,
-								   const struct bpf_insn *));
-
 static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 					  const void *ctx,
-					  bpf_dispatcher_fn dfunc)
+					  bpf_dispatcher_func dfunc)
 {
 	u32 ret;

@@ -695,7 +690,7 @@ static __always_inline u32 __bpf_prog_run(const
struct bpf_prog *prog,

 static __always_inline u32 bpf_prog_run(const struct bpf_prog *prog,
const void *ctx)
 {
-	return __bpf_prog_run(prog, ctx, bpf_dispatcher_nop_func);
+	return __bpf_prog_run(prog, ctx, prog->aux->dfunc);
 }


With these changes in POC, it is able to pass all selftests[0] on x86_64.

[0] https://github.com/kernel-patches/bpf/pull/6794/checks

Besides these changes, there are some details it has to handle for this
approach.

I would like to send this approach as next version patchset.

Thanks,
Leon

