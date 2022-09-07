Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9465B00E1
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 11:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiIGJuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 05:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiIGJuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 05:50:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9C6520A5;
        Wed,  7 Sep 2022 02:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F9F5B81C02;
        Wed,  7 Sep 2022 09:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93841C433D6;
        Wed,  7 Sep 2022 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662544201;
        bh=hUwrU7rajizpLziyjcQs4WTMAHKfgRP/9kdmaKkNJ14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D0dVPFRptKPd9XbvMTsS5BW5ZnrCrmsYbKRpyDRzer3jiptFdyO4AOiiBX2CSssPA
         djh45erZrbdHD1ppOfuHwktynQr4en6Aye3Z98LQ+kwpNUdwlThWA+qPLT69jNyBrd
         flglSLMICIl6/7Vo+z46idRraNIlLdFs559t1h0G7CpDAvxyIArjjCFbFoJAIiON2O
         1ZZuj7a9OKxRASyMuAz1jiIMoOkFMJzDW8qRfzM34t/n+zHVCajSCJwVaFFF1NC1nS
         dH+Y3X4e7SfJOtYknVKA8R37BetX4jCub8wc2BHT7O4dh2CKniCE0ukxrD1f38HS23
         rNp4DOnlpXGxA==
Date:   Wed, 7 Sep 2022 18:49:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/kprobes: Fix kprobes instruction boudary check
 with CONFIG_RETHUNK
Message-Id: <20220907184957.d41f085a998b2c7485353171@kernel.org>
In-Reply-To: <YxhQIBKzi+L0KDhc@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
        <166251212072.632004.16078953024905883328.stgit@devnote2>
        <YxhQIBKzi+L0KDhc@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 7 Sep 2022 10:02:40 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 07, 2022 at 09:55:21AM +0900, Masami Hiramatsu (Google) wrote:
> 
> >  static int can_probe(unsigned long paddr)
> >  {
> >  	kprobe_opcode_t buf[MAX_INSN_SIZE];
> > +	unsigned long addr, offset = 0;
> > +	struct insn insn;
> >  
> >  	if (!kallsyms_lookup_size_offset(paddr, NULL, &offset))
> >  		return 0;
> >  
> > +	/* The first address must be instruction boundary. */
> > +	if (!offset)
> > +		return 1;
> >  
> > +	/* Decode instructions */
> > +	for_each_insn(&insn, paddr - offset, paddr, buf) {
> >  		/*
> > +		 * CONFIG_RETHUNK or CONFIG_SLS or another debug feature
> > +		 * may install INT3.
> 
> Note: they are not debug features.

Yes, sorry for confusion. CONFIG_RETHUNK/CONFIG_SLS are security
feature, and something like kgdb is debug feature, what I meant
here.

> 
> >  		 */
> > +		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE) {
> > +			/* Find the next non-INT3 instruction address */
> > +			addr = skip_padding_int3((unsigned long)insn.kaddr);
> > +			if (!addr)
> > +				return 0;
> > +			/*
> > +			 * This can be a padding INT3 for CONFIG_RETHUNK or
> > +			 * CONFIG_SLS. If a branch jumps to the address next
> > +			 * to the INT3 sequence, this is just for padding,
> > +			 * then we can continue decoding.
> > +			 */
> > +			for_each_insn(&insn, paddr - offset, addr, buf) {
> > +				if (insn_get_branch_addr(&insn) == addr)
> > +					goto found;
> > +			}
> >  
> > +			/* This INT3 can not be decoded safely. */
> >  			return 0;
> > +found:
> > +			/* Set loop cursor */
> > +			insn.next_byte = (void *)addr;
> > +			continue;
> > +		}
> >  	}
> >  
> > +	return ((unsigned long)insn.next_byte == paddr);
> >  }
> 
> If I understand correctly, it'll fail on something like this:
> 
> foo:	insn
> 	insn
> 	insn
> 	jmp 2f
> 	int3
> 
> 1:	insn
> 	insn
> 2:	insn
> 	jcc 1b
> 
> 	ret
> 	int3
> 
> Which isn't weird code by any means. And soon to be generated by
> compilers.

Hmm, yeah, I thought that was rare case.

> 
> 
> Maybe something like:
> 
> struct queue {
> 	int head, tail;
> 	unsigned long val[16]; /* insufficient; probably should allocate something */
> };
> 
> void push(struct queue *q, unsigned long val)
> {
> 	/* break loops, been here already */
> 	for (int i = 0; i < q->head; i++) {
> 		if (q->val[i] == val)
> 			return;
> 	}
> 
> 	q->val[q->head++] = val;
> 
> 	WARN_ON(q->head > ARRAY_SIZE(q->val)
> }
> 
> unsigned long pop(struct queue *q)
> {
> 	if (q->tail == q->head)
> 		return 0;
> 
> 	return q->val[q->tail++];
> }
> 
> bool dead_end_insn(struct instruction *insn)
> {
> 	switch (insn->opcode.bytes[0]) {
> 	case INT3_INSN_OPCODE:
> 	case JMP8_INSN_OPCODE:
> 	case JMP32_INSN_OPCODE:
> 		return true; /* no arch execution after these */
> 
> 	case 0xff:
> 		/* jmp *%reg; jmpf */
> 		if (modrm_reg == 4 || modrm_reg == 5)
> 			return true;
> 		break;
> 
> 	default:
> 		break;
> 	}
> 
> 	return false;
> }
> 
> 
> 
> 	struct queue q;
> 
> 	start = paddr - offset;
> 	end = start + size;
> 	push(&q, paddr - offset);
> 
> 	while (start = pop(&q)) {
> 		for_each_insn(&insn, start, end, buf) {
> 			if (insn.kaddr == paddr)
> 				return 1;
> 
> 			target = insn_get_branch_addr(&insn);
> 			if (target)
> 				push(&q, target);
> 
> 			if (dead_end_insn(&insn))
> 				break;
> 		}
> 	}
> 
> 
> 
> It's a bit of a pain, but I think it should cover things.

Yeah, this looks good to me. What I just need is to add expanding
queue buffer. (can we use xarray for this purpose?)

Thank you!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
