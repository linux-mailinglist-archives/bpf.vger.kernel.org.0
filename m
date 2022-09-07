Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9EE5AFD13
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 09:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiIGHG4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 03:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIGHGy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 03:06:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351B184EF2;
        Wed,  7 Sep 2022 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LomlCPM6yTE1Gu1LvPHSTZqH0XKNAKGROehmM9dPqmo=; b=An+xOFX3tmOB1j9dGfCKYEJ3Ph
        B3F7zYFOKpKzKKaaFwTj5ZPciSmJUPJ1DzMoG/man4/KFRrmb9evBprsTjFcthWlZW+D5rgc6wrN2
        PdgP9xuXnBJFHyyJssjVm8q1xoOwEYWwsgiUfQXlJ0/e6Ra9iiFN+jCbrBnwAzjTrcuhrh/LCXN3B
        j68L6YRpMfR743b84xbEX1QkRJyNLE+3Hei2SKwLfzV55cEIWnWUqhFHobHegirP/8vdBp1g510qK
        weWZW+CiCW1FdyrlpbqasEtMjhU/a55zUTbHR7IXaWztoy26W3EwnKCh5AVonjG/6LTNpnhTVNnpq
        ub8r34Rg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVp96-00B98K-0F; Wed, 07 Sep 2022 07:06:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C6243003B0;
        Wed,  7 Sep 2022 09:06:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14088203BF6B4; Wed,  7 Sep 2022 09:06:45 +0200 (CEST)
Date:   Wed, 7 Sep 2022 09:06:44 +0200
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
Message-ID: <YxhDBAhYrs0Sfqjt@hirez.programming.kicks-ass.net>
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

> +/* Return the jump target address or 0 */
> +static inline unsigned long insn_get_branch_addr(struct insn *insn)
> +{
> +	switch (insn->opcode.bytes[0]) {
> +	case 0xe0:	/* loopne */
> +	case 0xe1:	/* loope */
> +	case 0xe2:	/* loop */

Oh cute, objtool doesn't know about those, let me go add them.

> +	case 0xe3:	/* jcxz */
> +	case 0xe9:	/* near relative jump */

 /* JMP.d32 */

> +	case 0xeb:	/* short relative jump */

 /* JMP.d8 */

> +		break;
> +	case 0x0f:
> +		if ((insn->opcode.bytes[1] & 0xf0) == 0x80) /* jcc near */

 /* Jcc.d32 */

Are the GNU AS names for these things.

> +			break;
> +		return 0;

> +	default:
> +		if ((insn->opcode.bytes[0] & 0xf0) == 0x70) /* jcc short */
> +			break;
> +		return 0;

You could write that as:

	case 0x70 ... 0x7f: /* Jcc.d8 */
		break;

	default:
		return 0;

> +	}
> +	return (unsigned long)insn->next_byte + insn->immediate.value;
> +}


