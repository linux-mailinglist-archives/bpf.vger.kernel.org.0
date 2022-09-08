Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883575B13D1
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 07:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIHFJH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 01:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiIHFJB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 01:09:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF98C92F55;
        Wed,  7 Sep 2022 22:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93595B81F74;
        Thu,  8 Sep 2022 05:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C59C433D7;
        Thu,  8 Sep 2022 05:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662613738;
        bh=dg8wftGIvmW8f8CxANQmVU9WzgpbVESeuK33TzXQNuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpROFulEeTkGHTFH1WQZcXr5tmSa3vWhKhn99/2aXSWhe7QrS/o92XogewYtQT75M
         yXKmuFb9SBJ5x/+C+/h+NtIrwvrwU4Lmi7b93zmj9yPltoOSHkdNkXKrzxSFfL04wD
         ie5mjahJpvZyqGTWpRYxS343ak7RJJEuS34xcFGU4sN/T18prCGq4AUEIegR6o3o+3
         kI4c8F8nbSIxHhku1MkNhYnpIZ8RhwHKdPGk/eK+TEOg/CS1HU0aBKmHFAsDwM2uD0
         BpmwwmQ0Xj1Qzlrjor1fu74rWCJ1C6H18rqdNu0t/jrCmMfFZEpGaqRp15XE80mHg2
         7L1sMat+zGXBg==
Date:   Wed, 7 Sep 2022 22:08:55 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/kprobes: Fix kprobes instruction boudary
 check with CONFIG_RETHUNK
Message-ID: <20220908050855.w77mimzznrlp6pwe@treble>
References: <166260087224.759381.4170102827490658262.stgit@devnote2>
 <166260088298.759381.11727280480035568118.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <166260088298.759381.11727280480035568118.stgit@devnote2>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 08, 2022 at 10:34:43AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the CONFIG_RETHUNK and CONFIG_SLS will use INT3 for stopping
> speculative execution after RET instruction, kprobes always failes to
> check the probed instruction boundary by decoding the function body if
> the probed address is after such sequence. (Note that some conditional
> code blocks will be placed after function return, if compiler decides
> it is not on the hot path.)
> 
> This is because kprobes expects someone (e.g. kgdb) puts the INT3 as
> a software breakpoint and it will replace the original instruction.
> But these INT3 are not such purpose, it doesn't need to recover the
> original instruction.
> 
> To avoid this issue, memorize the branch target address during decoding
> and if there is INT3, restart decoding from unchecked target address.

Hm, is kprobes conflicting with kgdb actually a realistic concern?
Seems like a dangerous combination

Either way, this feels overengineered.  Sort of like implementing
objtool in the kernel.

And it's incomplete: for a switch statement jump table (or C goto jump
table like in BPF), you can't detect the potential targets of the
indirect branch.

Wouldn't it be much simpler to just encode the knowledge that

  	if (CONFIG_RETHUNK && !X86_FEATURE_RETHUNK)
		// all rets are followed by four INT3s
	else if (CONFIG_SLS)
		// all rets are followed by one INT3

?
	
-- 
Josh
