Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4565AFE6A
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 10:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiIGID2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 04:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiIGIDM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 04:03:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D605AB18F;
        Wed,  7 Sep 2022 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XN+gxfHihFPa6QXECmOad6etDbe4CfWwojrF9UcZbX8=; b=C84LCOTeKwZ6OCqC9aLoyX6WAS
        k+b7P5/FH5DqXfaPQpTpJlcR0KjKt8PR8wlkriK20+l9D7X4aZqDAkHyUzkc7dDc4vo3YYB/rYlgi
        ZDSWd2SSATJGzcFjkkyc+bN42P3MWh5sUxZzMY4fFQe+5rL2RZ4ynMBTC2iHfw5K8sU4l/uEfc3Ns
        OPiVDwZqzOdbdJyzV9VyYIKtTSv2/jEupkcdINPxvbvyx1tFYqtSzsGAWYPI3qCE4otwAzHdycrwr
        2t8GVcTD3/+VXTNDvM41HDva5hTSpNli8jvYh8PXIiA+7yo4S8huDfbPLMO7ZVua7PlOKqDdWwpgb
        QJ/5V5DQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVq1C-00AOq6-Oe; Wed, 07 Sep 2022 08:02:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 867EC30013F;
        Wed,  7 Sep 2022 10:02:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17B802B98C607; Wed,  7 Sep 2022 10:02:41 +0200 (CEST)
Date:   Wed, 7 Sep 2022 10:02:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/kprobes: Fix kprobes instruction boudary check
 with CONFIG_RETHUNK
Message-ID: <YxhQIBKzi+L0KDhc@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166251212072.632004.16078953024905883328.stgit@devnote2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 09:55:21AM +0900, Masami Hiramatsu (Google) wrote:

>  static int can_probe(unsigned long paddr)
>  {
>  	kprobe_opcode_t buf[MAX_INSN_SIZE];
> +	unsigned long addr, offset = 0;
> +	struct insn insn;
>  
>  	if (!kallsyms_lookup_size_offset(paddr, NULL, &offset))
>  		return 0;
>  
> +	/* The first address must be instruction boundary. */
> +	if (!offset)
> +		return 1;
>  
> +	/* Decode instructions */
> +	for_each_insn(&insn, paddr - offset, paddr, buf) {
>  		/*
> +		 * CONFIG_RETHUNK or CONFIG_SLS or another debug feature
> +		 * may install INT3.

Note: they are not debug features.

>  		 */
> +		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE) {
> +			/* Find the next non-INT3 instruction address */
> +			addr = skip_padding_int3((unsigned long)insn.kaddr);
> +			if (!addr)
> +				return 0;
> +			/*
> +			 * This can be a padding INT3 for CONFIG_RETHUNK or
> +			 * CONFIG_SLS. If a branch jumps to the address next
> +			 * to the INT3 sequence, this is just for padding,
> +			 * then we can continue decoding.
> +			 */
> +			for_each_insn(&insn, paddr - offset, addr, buf) {
> +				if (insn_get_branch_addr(&insn) == addr)
> +					goto found;
> +			}
>  
> +			/* This INT3 can not be decoded safely. */
>  			return 0;
> +found:
> +			/* Set loop cursor */
> +			insn.next_byte = (void *)addr;
> +			continue;
> +		}
>  	}
>  
> +	return ((unsigned long)insn.next_byte == paddr);
>  }

If I understand correctly, it'll fail on something like this:

foo:	insn
	insn
	insn
	jmp 2f
	int3

1:	insn
	insn
2:	insn
	jcc 1b

	ret
	int3

Which isn't weird code by any means. And soon to be generated by
compilers.


Maybe something like:

struct queue {
	int head, tail;
	unsigned long val[16]; /* insufficient; probably should allocate something */
};

void push(struct queue *q, unsigned long val)
{
	/* break loops, been here already */
	for (int i = 0; i < q->head; i++) {
		if (q->val[i] == val)
			return;
	}

	q->val[q->head++] = val;

	WARN_ON(q->head > ARRAY_SIZE(q->val)
}

unsigned long pop(struct queue *q)
{
	if (q->tail == q->head)
		return 0;

	return q->val[q->tail++];
}

bool dead_end_insn(struct instruction *insn)
{
	switch (insn->opcode.bytes[0]) {
	case INT3_INSN_OPCODE:
	case JMP8_INSN_OPCODE:
	case JMP32_INSN_OPCODE:
		return true; /* no arch execution after these */

	case 0xff:
		/* jmp *%reg; jmpf */
		if (modrm_reg == 4 || modrm_reg == 5)
			return true;
		break;

	default:
		break;
	}

	return false;
}



	struct queue q;

	start = paddr - offset;
	end = start + size;
	push(&q, paddr - offset);

	while (start = pop(&q)) {
		for_each_insn(&insn, start, end, buf) {
			if (insn.kaddr == paddr)
				return 1;

			target = insn_get_branch_addr(&insn);
			if (target)
				push(&q, target);

			if (dead_end_insn(&insn))
				break;
		}
	}



It's a bit of a pain, but I think it should cover things.
