Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F791350C23
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 03:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhDAByp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 21:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230284AbhDABy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 21:54:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FD9960FE9;
        Thu,  1 Apr 2021 01:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617242067;
        bh=I1Vutxd2fotaDN7XIHIAgeH4hifd8ayloeGtrgZkmYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SR0DLDz8rzxeAm6JtFEUCiI7DD/4GT105sl02Mca6xlyT0K2U8VPNqZsol4Bxs97I
         S5nxB805BmRc/5fzQDrwxoFqc0TO+Q9n3pRAuMn2acus98Tb3mZwyqct21bo3obZUK
         dZ4CjzvSsjyTUINQjCe0hD/6QA9HZrSu+6ku9KaOoMrmR8wDJIK/XHTDHpQxvwa8Ik
         a4L8qAqwjDg1747HFbW8qSdDr/aAeUswb9spPTYOna2HSt4oNcjk6oOAVn+LbRgomC
         sNBs6WHIJAzj9cU+hXuvNJwtHI+urYJvJVvdQHrdi+AjWq3/Yp8+6wGFqFBY+AuT7G
         enOv3lhHiQpnA==
Date:   Thu, 1 Apr 2021 10:54:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH -tip 3/3] x86/kprobes,orc: Unwind optprobe
 trampoline correctly
Message-Id: <20210401105422.bc7953889a2e0aaf03201b92@kernel.org>
In-Reply-To: <161716949640.721514.14252504351086671126.stgit@devnote2>
References: <161716946413.721514.4057380464113663840.stgit@devnote2>
        <161716949640.721514.14252504351086671126.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 31 Mar 2021 14:44:56 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> +#ifdef CONFIG_UNWINDER_ORC
> +unsigned long recover_optprobe_trampoline(unsigned long addr, unsigned long *sp)
> +{
> +	unsigned long offset, entry, probe_addr;
> +	struct optimized_kprobe *op;
> +	struct orc_entry *orc;
> +
> +	entry = find_kprobe_optinsn_slot_entry(addr);
> +	if (!entry)
> +		return addr;
> +
> +	offset = addr - entry;
> +
> +	/* Decode arg1 and get the optprobe */
> +	op = (void *)extract_set_arg1((void *)(entry + TMPL_MOVE_IDX));
> +	if (!op)
> +		return addr;
> +
> +	probe_addr = (unsigned long)op->kp.addr;
> +
> +	if (offset < TMPL_END_IDX) {

Maybe I should add a comment here.

/*
 * Since this is on the trampoline code based on the template code,
 * ORC information on the template code can be used for adjusting
 * stack pointer. The template code may change the stack pointer to
 * store pt_regs.
 */

> +		orc = orc_find((unsigned long)optprobe_template_func + offset);
> +		if (!orc || orc->sp_reg != ORC_REG_SP)
> +			return addr;
> +		/*
> +		 * Since optprobe trampoline doesn't push caller on the stack,
> +		 * need to decrement 1 stack entry size
> +		 */
> +		*sp += orc->sp_offset - sizeof(long);
> +		return probe_addr;
> +	} else {

/*
 * In this case, the address is on the instruction copied from probed
 * address, and jump instruction. Here the stack pointer is exactly
 * the same as the value where it was copied by the kprobes.
 */

> +		return probe_addr + offset - TMPL_END_IDX;
> +	}
> +}
> +#endif
> +


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
