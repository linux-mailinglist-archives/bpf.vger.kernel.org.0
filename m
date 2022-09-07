Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B874D5AFE9A
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 10:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiIGILa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 04:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiIGIL3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 04:11:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6627D1EF;
        Wed,  7 Sep 2022 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LZ16vfN6hWpH5qjZzb4a8WjhyWuTw6lCcL/cXdpUjF4=; b=Lx543qPKzPVnW/jSXoSHIfFSx0
        qVP4WuWNQaKTjX1K/6NknKvsQHp8NXxKgbEodJRS84LrfkkKIiErtF49W1esGVR/XgWMRtbrK57FR
        wNCplPbzaD8EfOKBr+7m3hXmAOVg0xxrp3Dtkr0dYtwWGxF6GejgtVBdh1ao36Juo6ufEpxRaLU0l
        0V5Mh+Goyzwx7r37L8N5iNFUVKuS9HdRkgkxZf1ZTC2htGXktBka2Lnbv2sC2sSqK02IaCmnTb3U+
        aHZu5cRZ3zvVW7sVMnEnKNztDCkurEU4bLewnl0zipTkz6b2DjVZ/m26MSe2rj6NpbdGfnAJGfQXl
        uJT4Q8jw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVq9X-00BBaE-E4; Wed, 07 Sep 2022 08:11:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D3333003B0;
        Wed,  7 Sep 2022 10:11:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73FA02B98C60B; Wed,  7 Sep 2022 10:11:16 +0200 (CEST)
Date:   Wed, 7 Sep 2022 10:11:16 +0200
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
Message-ID: <YxhSJBiNJ5QRLQX8@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
 <YxhQIBKzi+L0KDhc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxhQIBKzi+L0KDhc@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 10:02:41AM +0200, Peter Zijlstra wrote:
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

	case RET_INSN_OPCODE:

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
