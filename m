Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96533503F8
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCaP6C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 11:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232399AbhCaP5s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 11:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617206268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqFru+9hw+gJWIwERvjgVi+GWdWYD0rWG4MghlDR7S0=;
        b=YTzseYDX6tk+XNEZgB9IihZmVKy0v2DkhSbIjwAJynaVkhZSg9S5uMFiNFJU3RZp+xnc0/
        VqxgYQaOI/wY6+cY7EvW7aQNfq54ofbjJcYtVy1BDP6HJCrppw4mcIBzqTlB60sJleoIy/
        ns1DjmkC5yKf/fVlZtjCGK+XGNhWPnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-ybA1eGXvOpmb49m-mdhcYA-1; Wed, 31 Mar 2021 11:57:45 -0400
X-MC-Unique: ybA1eGXvOpmb49m-mdhcYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CD7C801814;
        Wed, 31 Mar 2021 15:57:43 +0000 (UTC)
Received: from treble (ovpn-119-212.rdu2.redhat.com [10.10.119.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 850E819D9F;
        Wed, 31 Mar 2021 15:57:39 +0000 (UTC)
Date:   Wed, 31 Mar 2021 10:57:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH -tip 3/3] x86/kprobes,orc: Unwind optprobe trampoline
 correctly
Message-ID: <20210331155736.qyuph7sgabmqqmq3@treble>
References: <161716946413.721514.4057380464113663840.stgit@devnote2>
 <161716949640.721514.14252504351086671126.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <161716949640.721514.14252504351086671126.stgit@devnote2>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 31, 2021 at 02:44:56PM +0900, Masami Hiramatsu wrote:
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
> +		return probe_addr + offset - TMPL_END_IDX;
> +	}
> +}
> +#endif

Hm, I'd like to avoid intertwining kprobes and ORC like this.

ORC unwinds other generated code by assuming the generated code uses a
frame pointer.  Could we do that here?

With CONFIG_FRAME_POINTER, unwinding works because SAVE_REGS_STRING has
ENCODE_FRAME_POINTER, but that's not going to work for ORC.

Instead of these patches, can we 'push %rbp; mov %rsp, %rbp' at the
beginning of the template and 'pop %rbp' at the end?

I guess SAVE_REGS_STRING would need to be smart enough to push the
original saved version of %rbp.  Of course then that breaks the
kretprobe_trampoline() usage, so it may need to be a separate macro.

[ Or make the same change to kretprobe_trampoline().  Then the other
  patch set wouldn't be needed either ;-) ]

Of course the downside is, when you get an interrupt during the frame
pointer setup, unwinding is broken.  But I think that's acceptable for
generated code.  We've lived with that limitation for all code, with
CONFIG_FRAME_POINTER, for many years.

Eventually we may want to have a way to register generated code (and the
ORC for it).

-- 
Josh

