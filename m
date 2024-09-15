Return-Path: <bpf+bounces-39938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0822F9796C0
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 15:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A8F1F2137C
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FBF1C57B8;
	Sun, 15 Sep 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V6dcpZQW"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53B2941B
	for <bpf@vger.kernel.org>; Sun, 15 Sep 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726405246; cv=none; b=QSkKas9y4gqoobFM8AOfkcdcQhy/zdynAp1mdLhU0haXnrHIiUG0kDFnNOZ3mveveVeh/tpL/R3kfsrQBdB1lj5iV2dYVSTTn8UHZmgfwQWMQ559CLumFFiWW4hcSe1tU+QM3OwzY29eqYslD6Zuw+mA9vXMU/BUZuRrplaybMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726405246; c=relaxed/simple;
	bh=w6kywzMynfuPimCaflIOAbGc+lOaljaMMTS2qrZD5RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjxCv/e8Jx0om00ejzRfdJ/38xXhb4x3io/DeYatWL2XFOxaNQdku4TLjNHYXnZ4ebKVMmY3LmL8ott7Bb6R9tXUxxsfVzAbX2vbmLhh2NgKPYXGONjRiZ/1c6Gxu7/jlMAUihkqPDzTbQM6bamOdsFGQyV80W3X/G+BXnG9mBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V6dcpZQW; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ec660430-b342-4823-8771-3599a1724c10@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726405241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KXH5Ig5S93ZxpWQes/Ut9wka/7FmFKVOE8jNUySYwU=;
	b=V6dcpZQWMKnp6Eot2sVPj1fgp8s5idz48OzWla/u5cfMT2/SsAZ/LG7PvxoH8hwzH3K4LM
	mV1RwpGoMBp7WHJ6Ba0FwX/ltDgfqmCJlitmulq5fzZTvIdDfPB/yEGS7Sco2WJj66QTpZ
	NIrcjBzaqhjCLy4WnET35x1qNwcPs7g=
Date: Sun, 15 Sep 2024 21:00:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] bpf, x64: Fix tailcall infinite loop
 caused by freplace
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Eddy Z <eddyz87@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kernel-patches-bot@fb.com
References: <20240901133856.64367-1-leon.hwang@linux.dev>
 <20240901133856.64367-2-leon.hwang@linux.dev>
 <CAADnVQJ0yz-VcFCJ0v4+LXGNDOgu1jYoSGHzywnszDjTrRSE7Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJ0yz-VcFCJ0v4+LXGNDOgu1jYoSGHzywnszDjTrRSE7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/9/14 03:28, Alexei Starovoitov wrote:
> On Sun, Sep 1, 2024 at 6:41 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> @@ -573,10 +575,13 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
>>
>>         /*
>>          * See emit_prologue(), for IBT builds the trampoline hook is preceded
>> -        * with an ENDBR instruction.
>> +        * with an ENDBR instruction and 3 bytes tail_call_cnt initialization
>> +        * instruction.
>>          */
>>         if (is_endbr(*(u32 *)ip))
>>                 ip += ENDBR_INSN_SIZE;
>> +       if (is_bpf_text_address((long)ip))
>> +               ip += X86_POKE_EXTRA;
> 
> This is a foot gun.
> bpf_arch_text_poke() is used not only at the beginning of the function.
> So unconditional ip += 3 is not just puzzling with 'what is this for',
> but dangerous and wasteful...
> 
>> @@ -2923,6 +2930,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>>                  */
>>                 if (is_endbr(*(u32 *)orig_call))
>>                         orig_call += ENDBR_INSN_SIZE;
>> +               if (is_bpf_text_address((long)orig_call))
>> +                       orig_call += X86_POKE_EXTRA;
>>                 orig_call += X86_PATCH_SIZE;
>>         }
> 
> ..this bit needs to be hacked too...
> 
>> @@ -3025,6 +3034,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>>                 /* remember return value in a stack for bpf prog to access */
>>                 emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
>>                 im->ip_after_call = image + (prog - (u8 *)rw_image);
>> +               emit_nops(&prog, X86_POKE_EXTRA);
>>                 emit_nops(&prog, X86_PATCH_SIZE);
> 
> And this is just pure waste of kernel code and cpu run-time.
> 
> You're adding 3 byte nop for no reason at all.
> 
> See commit e21aa341785c ("bpf: Fix fexit trampoline.")
> that added:
>                 int err = bpf_arch_text_poke(im->ip_after_call, BPF_MOD_JUMP,
>                                              NULL, im->ip_epilogue);
> logic that is patching bpf trampoline in the middle of it.
> (not at the start).
> 
> Because of unconditional +=3 in bpf_arch_text_poke() every trampoline
> will have to waste nop3 ?
> No.
> 
> Please fix freplace and tail call combination without
> this kind of unacceptable shortcuts.
> 
> I very much prefer to stop hacking into JITs and trampolines because
> tailcalls and freplace don't work well together.
> 
> We cannot completely disable that combination because libxdp
> is using freplace to populate chain of progs the main prog is calling
> and these freplace progs might be doing tailcall,
> but we can still prevent such infinite loop that you describe in commit log:
> entry_tc -> subprog_tc -> entry_freplace -> subprog_tail --tailcall-> entry_tc
> in the verifier without resorting to JIT hacks.
> 
> pw-bot: cr

IIUC, it's going to prevent this niche case at update/attach time, that
a prog cannot be updated to prog_array map and be extended by freplace
prog at the same time.

More specific explanation:

1. If a prog has been updated to prog_array, it and its subprog cannot
   be extended by freplace prog.
2. If a prog or its subprog has been extended by freplace prog, it
   cannot be updated to prog_array map.

Then, I do a POC[0] to prevent this niche case. And the POC does not
break any selftest.

[0] https://github.com/kernel-patches/bpf/pull/7732

Here's the diff of the POC.

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0c3893c471711..b864b37e67c17 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1483,6 +1483,8 @@ struct bpf_prog_aux {
 	bool xdp_has_frags;
 	bool exception_cb;
 	bool exception_boundary;
+	bool is_extended; /* true if extended by freplace program */
+	atomic_t tail_callee_cnt;
 	struct bpf_arena *arena;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 79660e3fca4c1..be41240d4fb3a 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -951,18 +951,27 @@ static void *prog_fd_array_get_ptr(struct bpf_map
*map,
 	if (IS_ERR(prog))
 		return prog;

-	if (!bpf_prog_map_compatible(map, prog)) {
+	if (!bpf_prog_map_compatible(map, prog) || prog->aux->is_extended) {
+		/* Extended prog can not be tail callee. It's to prevent a
+		 * potential infinite loop like:
+		 * tail callee prog entry -> tail callee prog subprog ->
+		 * freplace prog entry --tailcall-> tail callee prog entry.
+		 */
 		bpf_prog_put(prog);
 		return ERR_PTR(-EINVAL);
 	}

+	atomic_inc(&prog->aux->tail_callee_cnt);
 	return prog;
 }

 static void prog_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool
need_defer)
 {
+	struct bpf_prog *prog = ptr;
+
 	/* bpf_prog is freed after one RCU or tasks trace grace period */
-	bpf_prog_put(ptr);
+	atomic_dec(&prog->aux->tail_callee_cnt);
+	bpf_prog_put(prog);
 }

 static u32 prog_fd_array_sys_lookup_elem(void *ptr)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a4117f6d7610..be829016d8182 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3292,8 +3292,11 @@ static void bpf_tracing_link_release(struct
bpf_link *link)
 	bpf_trampoline_put(tr_link->trampoline);

 	/* tgt_prog is NULL if target is a kernel function */
-	if (tr_link->tgt_prog)
+	if (tr_link->tgt_prog) {
+		if (link->prog->type == BPF_PROG_TYPE_EXT)
+			tr_link->tgt_prog->aux->is_extended = false;
 		bpf_prog_put(tr_link->tgt_prog);
+	}
 }

 static void bpf_tracing_link_dealloc(struct bpf_link *link)
@@ -3498,6 +3501,18 @@ static int bpf_tracing_prog_attach(struct
bpf_prog *prog,
 		tgt_prog = prog->aux->dst_prog;
 	}

+	if (prog->type == BPF_PROG_TYPE_EXT &&
+	    atomic_read(&tgt_prog->aux->tail_callee_cnt)) {
+		/* Program extensions can not extend target prog when the target
+		 * prog has been updated to any prog_array map as tail callee.
+		 * It's to prevent a potential infinite loop like:
+		 * tgt prog entry -> tgt prog subprog -> freplace prog entry
+		 * --tailcall-> tgt prog entry.
+		 */
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
 	err = bpf_link_prime(&link->link.link, &link_primer);
 	if (err)
 		goto out_unlock;
@@ -3523,6 +3538,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog
*prog,
 	if (prog->aux->dst_trampoline && tr != prog->aux->dst_trampoline)
 		/* we allocated a new trampoline, so free the old one */
 		bpf_trampoline_put(prog->aux->dst_trampoline);
+	if (prog->type == BPF_PROG_TYPE_EXT)
+		tgt_prog->aux->is_extended = true;

 	prog->aux->dst_prog = NULL;
 	prog->aux->dst_trampoline = NULL;

Thanks,
Leon

