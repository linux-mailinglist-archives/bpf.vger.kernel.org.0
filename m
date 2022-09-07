Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F245B0864
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 17:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiIGPWi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 11:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiIGPWh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 11:22:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5005D77EB3;
        Wed,  7 Sep 2022 08:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1747B61934;
        Wed,  7 Sep 2022 15:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F15C433D6;
        Wed,  7 Sep 2022 15:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662564151;
        bh=x6mfB2ASpqvoYpjbtpWOERqX/eZvJRAkxIxQEDE7+YE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uHNloUqP4trJgQtX2xPpo9byibfFsuOvn19Y3Kz8lJjVY46LBpy+ZQGIL4Kq/ZbGa
         hfcBXj9i48Oa9lOSuu+LmMytCLqLbNs56PICYvUS2JpGd/iv0xa7If26xrlX6YFVKR
         TphOXFVOpsl9Jp6y3SUdfVeXgl23xuu2l00ja3EYY2X/Kw7ZGyGPSZAwez6kXTO+t9
         B+lRxk9qIC8sI3sbL97OPDNnWZFBhB50ouHDo2O70ftie3Uz3K5SPPNXLJ8oUHastG
         q5a3ZDRJj/blkNa/B6zewExNeGB3VSUFvQC2TjcKVCQ78hyM3ZHak/GcaZcBcXSi2G
         gq8Np91GxMotw==
Date:   Thu, 8 Sep 2022 00:22:27 +0900
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
Message-Id: <20220908002227.528154f5aaef62719a234e8e@kernel.org>
In-Reply-To: <Yxiqb+QkSQeAPzJw@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
        <166251212072.632004.16078953024905883328.stgit@devnote2>
        <YxhQIBKzi+L0KDhc@hirez.programming.kicks-ass.net>
        <YxiXCf1LcFqj5di6@hirez.programming.kicks-ass.net>
        <20220907231450.0a5f085319251349a45465d8@kernel.org>
        <Yxiqb+QkSQeAPzJw@hirez.programming.kicks-ass.net>
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

On Wed, 7 Sep 2022 16:27:59 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 07, 2022 at 11:14:50PM +0900, Masami Hiramatsu wrote:
> > On Wed, 7 Sep 2022 15:05:13 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Wed, Sep 07, 2022 at 10:02:41AM +0200, Peter Zijlstra wrote:
> > > 
> > > > 	struct queue q;
> > > > 
> > > > 	start = paddr - offset;
> > > > 	end = start + size;
> > > > 	push(&q, paddr - offset);
> > > > 
> > > > 	while (start = pop(&q)) {
> > > > 		for_each_insn(&insn, start, end, buf) {
> > > > 			if (insn.kaddr == paddr)
> > > > 				return 1;
> > > > 
> > > > 			target = insn_get_branch_addr(&insn);
> > > > 			if (target)
> > > > 				push(&q, target);
> > > > 
> > > > 			if (dead_end_insn(&insn))
> > > > 				break;
> > > > 		}
> > > > 	}
> > > 
> > > There is the very rare case of intra-function-calls; but I *think*
> > > they're all in noinstr/nokprobe code anyway.
> > > 
> > > For instance we have RSB stuffing code like:
> > > 
> > > 	.rept 16
> > > 	call 1f;
> > > 	int3
> > > 	1:
> > > 	.endr
> > > 	add $(BITS_PER_LONG/8) * 16, %_ASM_SP
> > > 
> > > And the proposed will be horribly confused by that. But like said; it
> > > should also never try and untangle it.
> > 
> > Yeah, but I guess if we break the decoding (internal) loop when we
> > hit an INT3, it maybe possible to be handled?
> 
> If you make insn_get_branch_addr() return the target of CALL
> instructions when this target is between function start and end, it
> should work I think.

Ah Indeed. Anyway, I would like to use INT3 as a stop instruction,
instread of checking dead_end_instruction. Is there any problem?

> 
> But like said; this construct is rare and all instances I can remember
> should not be kprobes to begin with. These are all 'fun' things like
> retpoline stubs and the the above RSB stuff loop.

Agree. That should not appear on normal code.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
