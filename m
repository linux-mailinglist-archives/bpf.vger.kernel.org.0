Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5C55F5F34
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 04:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJFCzQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 22:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiJFCyK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 22:54:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFA1895F6
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 19:52:13 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id j71so700093pge.2
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 19:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=3G2TAXdxEngpp36u1h2aMfIMVCYy7EPHjZC8dbly0KE=;
        b=dXD7Mlac/N+9hH9apNeeZyaTXV38clEb8HP/Hxn95sIl38GFizl9J4TqHy4ouYj9cE
         D2Y8ChpDS2oefW0Cuc4aqcIvoymU5YxIRpEq0yFOoi8qITwXAEAsTtpYpXtCh6TgQ6AI
         CHxXshjKKB7ggciGHUMHywfpnS+ZJE0Qa8b+6r56O7JYHlMR8OMJMOoFwe4YDCyY0+Gu
         G3o3ou2rNObGPvG6b9B0IDf6J9MCUHLVfVxOoFkbVjoHnJWZQMe1afzhpg9JhMCF2BKC
         CYOI23UiT+Bbf4B2Iy+oWVZ3HWjF1A24QP0fLHXJFmtFmWeUeWrbtrIAehj/pXg+Ayy9
         kxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3G2TAXdxEngpp36u1h2aMfIMVCYy7EPHjZC8dbly0KE=;
        b=Rz2v6Eb85a18EtB/WhjZJGx1ZnzxsQGFet9jFxCips15cxr9U29wDzR9hUxGMJDtuu
         Yi7d58u+5GBUnWCCS1WZLkVq06T+qybFj03VsUn6u8W2UUobL0Rfdu6cuRniPDfANrKI
         m/6CQ/FrKJSWL0+xSnDEbcxmo+bzfEhhqRZqfG/WvqoV1nnS56a0P6LaQJ4S43bqE+jD
         qpPpPx0HsClnVqYl8ZbpdiJzgbB8LN82nJtzgdqELPjdnl6c1pntlzflSgYCNV3XfM9i
         ugr0Y8xwy4pNQzGCjVHyW4oI9xridiXtf2mSjfCWYJfIxtgbA2mcvZ4djZJv+BRctHH8
         WedQ==
X-Gm-Message-State: ACrzQf0GIdkUIfhb53jg6IyhgqBAcB259QEXT1SxGoIPJeMRMptoRoU5
        TL2cjmUuff01iU0UzozRe4fiaebS+HM=
X-Google-Smtp-Source: AMsMyM4YsNFQ9TbsLrqrylCgBpsxdjc7yQl69yfWmjryPO3cfLTDHfBtSSEnYBpm5xDVbZOXt6pVhA==
X-Received: by 2002:a63:1608:0:b0:45a:355a:9420 with SMTP id w8-20020a631608000000b0045a355a9420mr2532333pgl.354.1665024732129;
        Wed, 05 Oct 2022 19:52:12 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:d9ff])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b001745662d568sm11294264pla.278.2022.10.05.19.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 19:52:11 -0700 (PDT)
Date:   Wed, 5 Oct 2022 19:52:09 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     bpf@vger.kernel.org
Subject: Re: [RFC v2 6/9] netfilter: add bpf base hook program generator
Message-ID: <20221006025209.rx4xnwdduqypja4b@macbook-pro-4.dhcp.thefacebook.com>
References: <20221005141309.31758-1-fw@strlen.de>
 <20221005141309.31758-7-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005141309.31758-7-fw@strlen.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 05, 2022 at 04:13:06PM +0200, Florian Westphal wrote:
>  
> @@ -254,11 +269,24 @@ static inline int nf_hook(u_int8_t pf, unsigned int hook, struct net *net,
>  
>  	if (hook_head) {
>  		struct nf_hook_state state;
> +#if IS_ENABLED(CONFIG_NF_HOOK_BPF)
> +		const struct bpf_prog *p = READ_ONCE(hook_head->hook_prog);
> +
> +		nf_hook_state_init(&state, hook, pf, indev, outdev,
> +				   sk, net, okfn);
> +
> +		state.priv = (void *)hook_head;
> +		state.skb = skb;
>  
> +		migrate_disable();
> +		ret = bpf_prog_run_nf(p, &state);
> +		migrate_enable();

Since generated prog doesn't do any per-cpu work and not using any maps
there is no need for migrate_disable.
There is cant_migrate() in __bpf_prog_run(), but it's probably better
to silence that instead of adding migrate_disable/enable overhead.
I guess it's ok for now.

> +static bool emit_mov_ptr_reg(struct nf_hook_prog *p, u8 dreg, u8 sreg)
> +{
> +	if (sizeof(void *) == sizeof(u64))
> +		return emit(p, BPF_MOV64_REG(dreg, sreg));
> +	if (sizeof(void *) == sizeof(u32))
> +		return emit(p, BPF_MOV32_REG(dreg, sreg));

I bet that was never tested :) because... see below.

> +
> +	return false;
> +}
> +
> +static bool do_prologue(struct nf_hook_prog *p)
> +{
> +	int width = bytes_to_bpf_size(sizeof(void *));
> +
> +	if (WARN_ON_ONCE(width < 0))
> +		return false;
> +
> +	/* argument to program is a pointer to struct nf_hook_state, in BPF_REG_1. */
> +	if (!emit_mov_ptr_reg(p, BPF_REG_6, BPF_REG_1))
> +		return false;
> +
> +	if (!emit(p, BPF_LDX_MEM(width, BPF_REG_7, BPF_REG_1,
> +				 offsetof(struct nf_hook_state, priv))))
> +		return false;
> +
> +	/* could load state->hook_index, but we don't support index > 0 for bpf call. */
> +	if (!emit(p, BPF_MOV32_IMM(BPF_REG_8, 0)))
> +		return false;
> +
> +	return true;
> +}
> +
> +static void patch_hook_jumps(struct nf_hook_prog *p)
> +{
> +	unsigned int i;
> +
> +	if (!p->insns)
> +		return;
> +
> +	for (i = 0; i < p->pos; i++) {
> +		if (BPF_CLASS(p->insns[i].code) != BPF_JMP)
> +			continue;
> +
> +		if (p->insns[i].code == (BPF_EXIT | BPF_JMP))
> +			continue;
> +		if (p->insns[i].code == (BPF_CALL | BPF_JMP))
> +			continue;
> +
> +		if (p->insns[i].off != JMP_INVALID)
> +			continue;
> +		p->insns[i].off = p->pos - i - 1;

Pls add a check that it fits in 16-bits.

> +	}
> +}
> +
> +static bool emit_retval(struct nf_hook_prog *p, int retval)
> +{
> +	if (!emit(p, BPF_MOV32_IMM(BPF_REG_0, retval)))
> +		return false;
> +
> +	return emit(p, BPF_EXIT_INSN());
> +}
> +
> +static bool emit_nf_hook_slow(struct nf_hook_prog *p)
> +{
> +	int width = bytes_to_bpf_size(sizeof(void *));
> +
> +	/* restore the original state->priv. */
> +	if (!emit(p, BPF_STX_MEM(width, BPF_REG_6, BPF_REG_7,
> +				 offsetof(struct nf_hook_state, priv))))
> +		return false;
> +
> +	/* arg1 is state->skb */
> +	if (!emit(p, BPF_LDX_MEM(width, BPF_REG_1, BPF_REG_6,
> +				 offsetof(struct nf_hook_state, skb))))
> +		return false;
> +
> +	/* arg2 is "struct nf_hook_state *" */
> +	if (!emit(p, BPF_MOV64_REG(BPF_REG_2, BPF_REG_6)))
> +		return false;
> +
> +	/* arg3 is nf_hook_entries (original state->priv) */
> +	if (!emit(p, BPF_MOV64_REG(BPF_REG_3, BPF_REG_7)))
> +		return false;
> +
> +	if (!emit(p, BPF_EMIT_CALL(nf_hook_slow)))
> +		return false;
> +
> +	/* No further action needed, return retval provided by nf_hook_slow */
> +	return emit(p, BPF_EXIT_INSN());
> +}
> +
> +static bool emit_nf_queue(struct nf_hook_prog *p)
> +{
> +	int width = bytes_to_bpf_size(sizeof(void *));
> +
> +	if (width < 0) {
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}
> +
> +	/* int nf_queue(struct sk_buff *skb, struct nf_hook_state *state, unsigned int verdict) */
> +	if (!emit(p, BPF_LDX_MEM(width, BPF_REG_1, BPF_REG_6,
> +				 offsetof(struct nf_hook_state, skb))))
> +		return false;
> +	if (!emit(p, BPF_STX_MEM(BPF_H, BPF_REG_6, BPF_REG_8,
> +				 offsetof(struct nf_hook_state, hook_index))))
> +		return false;
> +	/* arg2: struct nf_hook_state * */
> +	if (!emit(p, BPF_MOV64_REG(BPF_REG_2, BPF_REG_6)))
> +		return false;
> +	/* arg3: original hook return value: (NUM << NF_VERDICT_QBITS | NF_QUEUE) */
> +	if (!emit(p, BPF_MOV32_REG(BPF_REG_3, BPF_REG_0)))
> +		return false;
> +	if (!emit(p, BPF_EMIT_CALL(nf_queue)))
> +		return false;

here and other CALL work by accident on x84-64.
You need to wrap them with BPF_CALL_ and point BPF_EMIT_CALL to that wrapper.
On x86-64 it will be a nop.
On x86-32 it will do quite a bit of work.

> +
> +	/* Check nf_queue return value.  Abnormal case: nf_queue returned != 0.
> +	 *
> +	 * Fall back to nf_hook_slow().
> +	 */
> +	if (!emit(p, BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2)))
> +		return false;
> +
> +	/* Normal case: skb was stolen. Return 0. */
> +	return emit_retval(p, 0);
> +}
> +
> +static bool do_epilogue_base_hooks(struct nf_hook_prog *p)
> +{
> +	int width = bytes_to_bpf_size(sizeof(void *));
> +
> +	if (WARN_ON_ONCE(width < 0))
> +		return false;
> +
> +	/* last 'hook'. We arrive here if previous hook returned ACCEPT,
> +	 * i.e. all hooks passed -- we are done.
> +	 *
> +	 * Return 1, skb can continue traversing network stack.
> +	 */
> +	if (!emit_retval(p, 1))
> +		return false;
> +
> +	/* Patch all hook jumps, in case any of these are taken
> +	 * we need to jump to this location.
> +	 *
> +	 * This happens when verdict is != ACCEPT.
> +	 */
> +	patch_hook_jumps(p);
> +
> +	/* need to ignore upper 24 bits, might contain errno or queue number */
> +	if (!emit(p, BPF_MOV32_REG(BPF_REG_3, BPF_REG_0)))
> +		return false;
> +	if (!emit(p, BPF_ALU32_IMM(BPF_AND, BPF_REG_3, 0xff)))
> +		return false;
> +
> +	/* ACCEPT handled, check STOLEN. */
> +	if (!emit(p, BPF_JMP_IMM(BPF_JNE, BPF_REG_3, NF_STOLEN, 2)))
> +		return false;
> +
> +	if (!emit_retval(p, 0))
> +		return false;
> +
> +	/* ACCEPT and STOLEN handled.  Check DROP next */
> +	if (!emit(p, BPF_JMP_IMM(BPF_JNE, BPF_REG_3, NF_DROP, 1 + 2 + 2 + 2 + 2)))
> +		return false;
> +
> +	/* First step. Extract the errno number. 1 insn. */
> +	if (!emit(p, BPF_ALU32_IMM(BPF_RSH, BPF_REG_0, NF_VERDICT_QBITS)))
> +		return false;
> +
> +	/* Second step: replace errno with EPERM if it was 0. 2 insns. */
> +	if (!emit(p, BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1)))
> +		return false;
> +	if (!emit(p, BPF_MOV32_IMM(BPF_REG_0, EPERM)))
> +		return false;
> +
> +	/* Third step: negate reg0: Caller expects -EFOO and stash the result.  2 insns. */
> +	if (!emit(p, BPF_ALU32_IMM(BPF_NEG, BPF_REG_0, 0)))
> +		return false;
> +	if (!emit(p, BPF_MOV32_REG(BPF_REG_8, BPF_REG_0)))
> +		return false;
> +
> +	/* Fourth step: free the skb. 2 insns. */
> +	if (!emit(p, BPF_LDX_MEM(width, BPF_REG_1, BPF_REG_6,
> +				 offsetof(struct nf_hook_state, skb))))
> +		return false;
> +	if (!emit(p, BPF_EMIT_CALL(kfree_skb)))
> +		return false;

ditto.

> +
> +	/* Last step: return. 2 insns. */
> +	if (!emit(p, BPF_MOV32_REG(BPF_REG_0, BPF_REG_8)))
> +		return false;
> +	if (!emit(p, BPF_EXIT_INSN()))
> +		return false;
> +
> +	/* ACCEPT, STOLEN and DROP have been handled.
> +	 * REPEAT and STOP are not allowed anymore for individual hook functions.
> +	 * This leaves NFQUEUE as only remaing return value.
> +	 *
> +	 * In this case BPF_REG_0 still contains the original verdict of
> +	 * '(NUM << NF_VERDICT_QBITS | NF_QUEUE)', so pass it to nf_queue() as-is.
> +	 */
> +	if (!emit_nf_queue(p))
> +		return false;
> +
> +	/* Increment hook index and store it in nf_hook_state so nf_hook_slow will
> +	 * start at the next hook, if any.
> +	 */
> +	if (!emit(p, BPF_ALU32_IMM(BPF_ADD, BPF_REG_8, 1)))
> +		return false;
> +	if (!emit(p, BPF_STX_MEM(BPF_H, BPF_REG_6, BPF_REG_8,
> +				 offsetof(struct nf_hook_state, hook_index))))
> +		return false;
> +
> +	return emit_nf_hook_slow(p);
> +}
> +
> +static int nf_hook_prog_init(struct nf_hook_prog *p)
> +{
> +	memset(p, 0, sizeof(*p));
> +
> +	p->insns = kcalloc(BPF_MAXINSNS, sizeof(*p->insns), GFP_KERNEL);
> +	if (!p->insns)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void nf_hook_prog_free(struct nf_hook_prog *p)
> +{
> +	kfree(p->insns);
> +}
> +
> +static int xlate_base_hooks(struct nf_hook_prog *p, const struct nf_hook_entries *e)
> +{
> +	unsigned int i, len;
> +
> +	len = e->num_hook_entries;
> +
> +	if (!do_prologue(p))
> +		goto out;
> +
> +	for (i = 0; i < len; i++) {
> +		if (!xlate_one_hook(p, e, &e->hooks[i]))
> +			goto out;
> +
> +		if (i + 1 < len) {
> +			if (!emit(p, BPF_MOV64_REG(BPF_REG_1, BPF_REG_6)))
> +				goto out;
> +
> +			if (!emit(p, BPF_ALU32_IMM(BPF_ADD, BPF_REG_8, 1)))
> +				goto out;
> +		}
> +	}
> +
> +	if (!do_epilogue_base_hooks(p))
> +		goto out;
> +
> +	return 0;
> +out:
> +	return -EINVAL;
> +}
> +
> +static struct bpf_prog *nf_hook_jit_compile(struct bpf_insn *insns, unsigned int len)
> +{
> +	struct bpf_prog *prog;
> +	int err = 0;
> +
> +	prog = bpf_prog_alloc(bpf_prog_size(len), 0);
> +	if (!prog)
> +		return NULL;
> +
> +	prog->len = len;
> +	prog->type = BPF_PROG_TYPE_SOCKET_FILTER;

lol. Just say BPF_PROG_TYPE_UNSPEC ?

> +	memcpy(prog->insnsi, insns, prog->len * sizeof(struct bpf_insn));
> +
> +	prog = bpf_prog_select_runtime(prog, &err);
> +	if (err) {
> +		bpf_prog_free(prog);
> +		return NULL;
> +	}

Would be good to do bpf_prog_alloc_id() so it can be seen in
bpftool prog show.
and bpf_prog_kallsyms_add() to make 'perf report' and
stack traces readable.

Overall I don't hate it, but don't like it either.
Please provide performance numbers.
It's a lot of tricky code and not clear what the benefits are.
Who will maintain this body of code long term?
How are we going to deal with refactoring that will touch generic bpf bits
and this generated prog?

> Purpose of this is to eventually add a 'netfilter prog type' to bpf and
> permit attachment of (userspace generated) bpf programs to the netfilter
> machinery, e.g.  'attach bpf prog id 1234 to ipv6 PREROUTING at prio -300'.
> 
> This will require to expose the context structure (program argument,
> '__nf_hook_state', with rewriting accesses to match nf_hook_state layout.

This part is orthogonal, right? I don't see how this work is connected
to above idea.
I'm still convinced that xt_bpf was a bad choice for many reasons.
"Add a 'netfilter prog type' to bpf" would repeat the same mistakes.
Let's evaluate this set independently.
