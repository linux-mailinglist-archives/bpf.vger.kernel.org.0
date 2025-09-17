Return-Path: <bpf+bounces-68603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCECB7F46F
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD543ACEF4
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 02:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D162E29DB6A;
	Wed, 17 Sep 2025 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDXjsQC2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4402192F2
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075104; cv=none; b=WHJxGVLclSUHhQvY7zGcyUc6JqZvdvfE8nTpnQrCsehh9jXIsL0KhXkyBXnlx0PrgGco0NunXIX0PWU/iBHNluIgqnRPo+3G87gESm2IUFI0g237BrDyPnFbqS8Ev0GVuzIcHXzRuMIFjZj0jocvwSNG9rHNOOi6DLLtIp2ydA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075104; c=relaxed/simple;
	bh=A+E+aqVt3aRWsL4IAWH94Ul/Mid5c31izIrAezVfAcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBFlbHpxTQ8JhLxHgLbACCO4y83aCYp3lCOyCkbrW3LxBI28TcamaAsOEmQvfRUeSHDIoq+8kXKrU627QjTdDX/9iW1S3h9xw+91VKI17IPkvz9QVHJiBBXh9jQF3plJgXvYeywHsr23h4ABacWb5pgpfaZMEi6VxtKdzhuy3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDXjsQC2; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso3247616a12.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 19:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758075100; x=1758679900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7KeX4LfcpjnDEPvsUbVePEMq7fEDA6iy2rZnbyaZ7l4=;
        b=lDXjsQC2NyOrpqCET2hcEg0bZXv2fQZ1SC477U1FIrnCI1SINmDPRSKQaTJv9/z2BB
         AzEgZIdtFgct6wun3utwL6AQokqhtvn4Vb30mDQ2qeRJd4p+Fih9VUDoUsLTfqpLM/II
         +l3ZutBvOzAPZwdaMG38Eyn6k65s8hq86C22uejwYOAaDRePQW5qYPAssnWLLoi1pbyU
         SwPodN7tCEpIwSOe086Y7wjU0VOehX+GzIsAwKnTucHJGdrsU00dYy8/PjOSl7nwSi+7
         u9iaUVy8q/8bRlNWWcYSlyjLvPJVL8Apue+gqgl8Z7+4XWhP+DJzCecrE7eqjYmQBI+X
         yHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758075100; x=1758679900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KeX4LfcpjnDEPvsUbVePEMq7fEDA6iy2rZnbyaZ7l4=;
        b=Qr39JI7CZV7hum4EKUdV+eJxk74VWZLj0RkdsEV+Xz2jA53T/uRU9SJa4j7LQ3umN5
         KXVj86jfGlvRBTVLl22TcNXe2l+1Q7PD01wTO6tmIJjkLmTAhQ0IOmm4WDp3q45/vjbM
         cO6wRjbgdQMe3D2srOJWD3KhtGDfDW7PtmeKEoOx7K6f1DY1XAnKVUBQzOIaBCuc5bMs
         FI98o9MW1y9ZRNZrLlDK3oKm4Tnc2JEBYv61SvEtgg1056Qzyc8LXHi4nN6gGHAg+qa6
         jJSuP+lIpXZZ6mVRPnAsXuu1bQ7PvQZ4JxcrtQIKSvNDRlPUaClINC6iIKe0ZZotk9A/
         rsLQ==
X-Gm-Message-State: AOJu0YwvOSh7HSRhAGik1DY1QfkxheuIgxI6nJtxa8Gv71ZyH5nbmkKJ
	TqAW+WSNOUvmh57h7HpsEhTtbWqGPAjwhV8ND22gsjpPQGgvEshg67cK+c3VXN/w2FrLWU4+Ucb
	tMOTL4Tf/LojSc6MyFQb/2TL2zo1cAOw=
X-Gm-Gg: ASbGnctRrIuVKt5IrJLVEwmpsMWp0m09WNB3DdnuyauohrR1PzMzf95dL6CNdihkM/A
	Ie9KBHRMUb5u4To2L+HK4OoD8HPHWbOQUwM2UhXspD2J5tlR/3RRJQnw9HqLMIYvyzeQJN/zs8v
	zYWEO7PYXociskpyBkkS26GapXrB/IHTp+Zu6/U/5yyRNluBHxWr9OyPKYSjONn+af8VH6939yz
	aLESnpWDg==
X-Google-Smtp-Source: AGHT+IFhW3QoHuS6o227C+38WcmRAWOdVM6lbgZ5RZ5qWFsxKgHYnx3jNvCtXOE781h8jX15YNtPLQkKX5qcQRNIhpw=
X-Received: by 2002:a05:6402:2803:b0:62f:259f:af29 with SMTP id
 4fb4d7f45d1cf-62f8444cadbmr764995a12.27.1758075100275; Tue, 16 Sep 2025
 19:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907230415.289327-1-sidchintamaneni@gmail.com> <20250907230415.289327-4-sidchintamaneni@gmail.com>
In-Reply-To: <20250907230415.289327-4-sidchintamaneni@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 17 Sep 2025 04:11:03 +0200
X-Gm-Features: AS18NWAPPUfCA-4Ovk9ocPfXeQbiFHdoD9swe29h_hI2TobZRPquTxXKe49mMD8
Message-ID: <CAP01T77Ji_5LzakSM_5LdW1cXYw9uCOH9o+hUSz+cO1q_aDS=A@mail.gmail.com>
Subject: Re: [PATCH 3/4] bpf: runtime part of fast-path termination approach
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, 
	miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, 
	quanzhif@vt.edu, jinghao7@illinois.edu, egor@vt.edu, sairoop10@gmail.com, 
	rjsu26@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 01:04, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> Update softlock detection logic to detect any stalls due to
> BPF programs. When softlockup is detected, bpf_die will be
> added to a workqueue on a CPU. With this implementation termination
> handler will only get triggered when CONFIG_SOFTLOCKUP_DETECTOR is
> enabled.
>

This is probably good for demonstration, but I'm not sure
piggy-backing off of optional softlockup detection is a good idea.
In any case, let's focus on the mechanism for now.

> Inside bpf_die, we perform the text_poke to stub helpers/kfuncs.
> The current implementation handles termination of long running
> bpf_loop iterators both inlining and non-inlining case.
>
> The limitation of this implementation is that the termination handler
> atleast need a single CPU to run.

Yeah, as discussed in v2, there were other options without this
limitation, i.e. take some overhead and check a terminate bit that
doesn't rely on punting work off to a wq to ensure prog is killed.

>
> Signed-off-by: Raj Sahu <rjsu26@gmail.com>
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 132 ++++++++++++++++++++++++++++++++++++
>  include/linux/bpf.h         |   2 +
>  include/linux/filter.h      |   6 ++
>  kernel/bpf/core.c           |  35 +++++++++-
>  kernel/watchdog.c           |   8 +++
>  5 files changed, 182 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 107a44729675..4de9a8cdc465 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2606,6 +2606,10 @@ st:                      if (is_imm8(insn->off))
>                                 if (arena_vm_start)
>                                         pop_r12(&prog);
>                         }
> +                       /* emiting 5 byte nop for non-inline bpf_loop callback */

typo: emitting

> +                       if (bpf_is_subprog(bpf_prog) && bpf_prog->aux->is_bpf_loop_cb_non_inline) {
> +                               emit_nops(&prog, X86_PATCH_SIZE);
> +                       }

But this is not the only source of potential stalls, right? E.g. bpf
iterators can stall (if nested), cond_break, etc.

>                         EMIT1(0xC9);         /* leave */
>                         emit_return(&prog, image + addrs[i - 1] + (prog - temp));
>                         break;
> @@ -3833,6 +3837,8 @@ bool bpf_jit_supports_private_stack(void)
>         return true;
>  }
>
> +
> +
>  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
>  {
>  #if defined(CONFIG_UNWINDER_ORC)
> @@ -3849,6 +3855,132 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
>  #endif
>  }
>
> +void in_place_patch_bpf_prog(struct bpf_prog *prog)
> +{
> +       struct call_aux_states *call_states;
> +       unsigned long new_target;
> +       unsigned char *addr;
> +       u8 ret_jmp_size = 1;
> +       if (cpu_wants_rethunk()) {
> +               ret_jmp_size = 5;
> +       }
> +       call_states = prog->term_states->patch_call_sites->call_states;
> +       for (int i = 0; i < prog->term_states->patch_call_sites->call_sites_cnt; i++) {
> +
> +               new_target = (unsigned long) bpf_termination_null_func;
> +               if (call_states[i].is_bpf_loop_cb_inline) {
> +                       new_target = (unsigned long) bpf_loop_term_callback;
> +               }
> +               char new_insn[5];
> +
> +               addr = (unsigned char *)prog->bpf_func + call_states->jit_call_idx;
> +
> +               unsigned long new_rel = (unsigned long)(new_target - (unsigned long)(addr + 5));
> +               new_insn[0] = 0xE8;
> +               new_insn[1] = (new_rel >> 0) & 0xFF;
> +               new_insn[2] = (new_rel >> 8) & 0xFF;
> +               new_insn[3] = (new_rel >> 16) & 0xFF;
> +               new_insn[4] = (new_rel >> 24) & 0xFF;
> +
> +               smp_text_poke_batch_add(addr, new_insn, 5 /* call instruction len */, NULL);
> +       }
> +
> +       if (prog->aux->is_bpf_loop_cb_non_inline) {
> +
> +               char new_insn[5] = { 0xB8, 0x01, 0x00, 0x00, 0x00 };
> +               char old_insn[5] = { 0x0F, 0x1F, 0x44, 0x00, 0x00 };
> +               smp_text_poke_batch_add(prog->bpf_func + prog->jited_len -
> +                               (1 + ret_jmp_size) /* leave, jmp/ ret */ - 5 /* nop size */, new_insn, 5 /* mov eax, 1 */, old_insn);
> +       }
> +
> +
> +       /* flush all text poke calls */
> +       smp_text_poke_batch_finish();
> +}
> +
> +void bpf_die(struct bpf_prog *prog)
> +{
> +       u8 ret_jmp_size = 1;
> +       if (cpu_wants_rethunk()) {
> +               ret_jmp_size = 5;
> +       }
> +
> +       /*
> +        * Replacing 5 byte nop in prologue with jmp instruction to ret
> +        */
> +       unsigned long jmp_offset = prog->jited_len - (4 /* First endbr is 4 bytes */
> +                                       + 5 /* noop is 5 bytes */
> +                                       + ret_jmp_size /* 5 bytes of jmp return_thunk or 1 byte ret*/);
> +
> +       char new_insn[5];
> +       new_insn[0] = 0xE9;
> +       new_insn[1] = (jmp_offset >> 0) & 0xFF;
> +       new_insn[2] = (jmp_offset >> 8) & 0xFF;
> +       new_insn[3] = (jmp_offset >> 16) & 0xFF;
> +       new_insn[4] = (jmp_offset >> 24) & 0xFF;
> +
> +       smp_text_poke_batch_add(prog->bpf_func + 4, new_insn, 5, NULL);
> +
> +       if (prog->aux->func_cnt) {
> +               for (int i = 0; i < prog->aux->func_cnt; i++) {
> +                       in_place_patch_bpf_prog(prog->aux->func[i]);
> +               }
> +       } else {
> +               in_place_patch_bpf_prog(prog);
> +       }
> +

Are you relying on batch finish() inside in_place_patch_bpf_prog()?

> +}
> +
> +void bpf_prog_termination_deferred(struct work_struct *work)
> +{
> +       struct bpf_term_aux_states *term_states = container_of(work, struct bpf_term_aux_states,
> +                                                work);
> +       struct bpf_prog *prog = term_states->prog;
> +
> +       bpf_die(prog);
> +}
> +
> +static struct workqueue_struct *bpf_termination_wq;
> +
> +void bpf_softlockup(u32 dur_s)
> +{
> +       unsigned long addr;
> +       struct unwind_state state;
> +       struct bpf_prog *prog;
> +
> +       for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
> +            unwind_next_frame(&state)) {

Why not use arch_bpf_stack_walk?

> +               addr = unwind_get_return_address(&state);
> +               if (!addr)
> +                       break;
> +
> +               if (!is_bpf_text_address(addr))
> +                       continue;
> +
> +               rcu_read_lock();
> +               prog = bpf_prog_ksym_find(addr);
> +               rcu_read_unlock();
> +               if (bpf_is_subprog(prog))
> +                       continue;
> +
> +               if (atomic_cmpxchg(&prog->term_states->bpf_die_in_progress, 0, 1))
> +                       break;
> +
> +               bpf_termination_wq = alloc_workqueue("bpf_termination_wq", WQ_UNBOUND, 1);

Err, even if you have to, I'd rather go with system_unbound_wq for
now. We have bpf_wq, and should probably have a dedicated bpf wq for
all wq executions coming from the BPF subsystem, but that's a
discussion for later.


> +               if (!bpf_termination_wq)
> +                       pr_err("Failed to alloc workqueue for bpf termination.\n");
> +
> +               queue_work(bpf_termination_wq, &prog->term_states->work);
> +
> +               /* Currently nested programs are not terminated together.
> +                * Removing this break will result in BPF trampolines being
> +                * identified as is_bpf_text_address resulting in NULL ptr
> +                * deref in next step.
> +                */
> +               break;
> +       }
> +}
> +
>  void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
>                                struct bpf_prog *new, struct bpf_prog *old)
>  {
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index caaee33744fc..03fce8f2c466 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -71,6 +71,7 @@ typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
>  typedef void (*bpf_iter_fini_seq_priv_t)(void *private_data);
>  typedef unsigned int (*bpf_func_t)(const void *,
>                                    const struct bpf_insn *);
> +
>  struct bpf_iter_seq_info {
>         const struct seq_operations *seq_ops;
>         bpf_iter_init_seq_priv_t init_seq_private;
> @@ -1600,6 +1601,7 @@ struct bpf_term_patch_call_sites {
>  struct bpf_term_aux_states {
>         struct bpf_prog *prog;
>         struct work_struct work;
> +       atomic_t bpf_die_in_progress;
>         struct bpf_term_patch_call_sites *patch_call_sites;
>  };
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 9092d8ea95c8..4f0f8fe478bf 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1123,6 +1123,8 @@ int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len);
>  bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
>  void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
>
> +void *bpf_termination_null_func(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
> +int bpf_loop_term_callback(u64 reg_loop_cnt, u64 *reg_loop_ctx);
>  u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
>  #define __bpf_call_base_args \
>         ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
> @@ -1257,6 +1259,10 @@ bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
>
>  void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns);
>  void bpf_prog_pack_free(void *ptr, u32 size);
> +void bpf_softlockup(u32 dur_s);
> +void bpf_prog_termination_deferred(struct work_struct *work);
> +void bpf_die(struct bpf_prog *prog);
> +void in_place_patch_bpf_prog(struct bpf_prog *prog);
>
>  static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
>  {
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 93442ab2acde..7b0552d15be3 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -41,6 +41,7 @@
>  #include <linux/execmem.h>
>
>  #include <asm/barrier.h>
> +#include <asm/unwind.h>
>  #include <linux/unaligned.h>
>
>  /* Registers */
> @@ -95,6 +96,37 @@ enum page_size_enum {
>         __PAGE_SIZE = PAGE_SIZE
>  };
>
> +void *bpf_termination_null_func(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5)
> +{
> +       return NULL;
> +}
> +
> +int bpf_loop_term_callback(u64 reg_loop_cnt, u64 *reg_loop_ctx)
> +{
> +       return 1;
> +}
> +
> +
> +void __weak in_place_patch_bpf_prog(struct bpf_prog *prog)
> +{
> +       return;
> +}
> +
> +void __weak bpf_die(struct bpf_prog *prog)
> +{
> +       return;
> +}
> +
> +void __weak bpf_prog_termination_deferred(struct work_struct *work)
> +{
> +       return;
> +}
> +
> +void __weak bpf_softlockup(u32 dur_s)
> +{
> +       return;
> +}
> +
>  struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flags)
>  {
>         gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | gfp_extra_flags);
> @@ -134,11 +166,12 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
>         fp->jit_requested = ebpf_jit_enabled();
>         fp->blinding_requested = bpf_jit_blinding_enabled(fp);
>         fp->term_states = term_states;
> +       atomic_set(&fp->term_states->bpf_die_in_progress, 0);
>         fp->term_states->patch_call_sites = patch_call_sites;
>         fp->term_states->patch_call_sites->call_sites_cnt = 0;
>         fp->term_states->patch_call_sites->call_states = NULL;
>         fp->term_states->prog = fp;
> -
> +       INIT_WORK(&fp->term_states->work, bpf_prog_termination_deferred);
>  #ifdef CONFIG_CGROUP_BPF
>         aux->cgroup_atype = CGROUP_BPF_ATTACH_TYPE_INVALID;
>  #endif
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 80b56c002c7f..59c91c18ca0e 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -25,6 +25,7 @@
>  #include <linux/stop_machine.h>
>  #include <linux/sysctl.h>
>  #include <linux/tick.h>
> +#include <linux/filter.h>
>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/debug.h>
> @@ -700,6 +701,13 @@ static int is_softlockup(unsigned long touch_ts,
>                 if (time_after_eq(now, period_ts + get_softlockup_thresh() * 3 / 4))
>                         scx_softlockup(now - touch_ts);
>
> +               /*
> +                * Long running BPF programs can cause CPU's to stall.
> +                * So trigger fast path termination to terminate such BPF programs.
> +                */
> +               if (time_after_eq(now, period_ts + get_softlockup_thresh() * 3 / 4))
> +                       bpf_softlockup(now - touch_ts);
> +
>                 /* Warn about unreasonable delays. */
>                 if (time_after(now, period_ts + get_softlockup_thresh()))
>                         return now - touch_ts;
> --
> 2.43.0
>

