Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804B35B1DD8
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiIHNEC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 09:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiIHNEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 09:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FA3D742E;
        Thu,  8 Sep 2022 06:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBDD061CEF;
        Thu,  8 Sep 2022 13:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AD2C433C1;
        Thu,  8 Sep 2022 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662642239;
        bh=RNPjRQkS198xJIWi4rthy4+btO4cb14a8DHt8yLQeOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HkIQkhRp+uXeTKAVt9NNLs5t9OV4esVfbKzJNlULRmMDLGxyLqSbZNwWkJlLEZKcA
         eUix5rXrct29WRPNkT2wUqQc5degImAuLGEj/N/FkfSF/mhI2cDsopSHsaArdl7LAj
         pzJ/Pd7iWhHytZT0sQC8DBs9PX+m7HZANlZKyZ3xKOZKq4S9jujXYbnS4LPkvlnhob
         2l++v803TJf30cBhkTBVnOMMA6ILnE3TfjkNv84y9+hheWN9GZJsVSYNptFSpiLLwx
         bQIOHEVun+SOCKQ4NPYbnNXzyt60by1rPGNI+a7Hq+X48aEowfprAniVoRm4lSZhXM
         RMnZsUfscoE+w==
Date:   Thu, 8 Sep 2022 22:03:54 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/kprobes: Fix kprobes instruction boudary
 check with CONFIG_RETHUNK
Message-Id: <20220908220354.28c196c8bbe4e83c83afcb59@kernel.org>
In-Reply-To: <20220908050855.w77mimzznrlp6pwe@treble>
References: <166260087224.759381.4170102827490658262.stgit@devnote2>
        <166260088298.759381.11727280480035568118.stgit@devnote2>
        <20220908050855.w77mimzznrlp6pwe@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 7 Sep 2022 22:08:55 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Thu, Sep 08, 2022 at 10:34:43AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the CONFIG_RETHUNK and CONFIG_SLS will use INT3 for stopping
> > speculative execution after RET instruction, kprobes always failes to
> > check the probed instruction boundary by decoding the function body if
> > the probed address is after such sequence. (Note that some conditional
> > code blocks will be placed after function return, if compiler decides
> > it is not on the hot path.)
> > 
> > This is because kprobes expects someone (e.g. kgdb) puts the INT3 as
> > a software breakpoint and it will replace the original instruction.
> > But these INT3 are not such purpose, it doesn't need to recover the
> > original instruction.
> > 
> > To avoid this issue, memorize the branch target address during decoding
> > and if there is INT3, restart decoding from unchecked target address.
> 
> Hm, is kprobes conflicting with kgdb actually a realistic concern?
> Seems like a dangerous combination

I'm actually not sure, I don't recommend it. But it is safe just having
fail-safe.

> 
> Either way, this feels overengineered.  Sort of like implementing
> objtool in the kernel.
> 
> And it's incomplete: for a switch statement jump table (or C goto jump
> table like in BPF), you can't detect the potential targets of the
> indirect branch.

In that case, it just fails to detect instruction boundary (and anyway
optprobe just stops optimization if it finds the indirect jump). So it
is still fail safe.

> 
> Wouldn't it be much simpler to just encode the knowledge that
> 
>   	if (CONFIG_RETHUNK && !X86_FEATURE_RETHUNK)
> 		// all rets are followed by four INT3s
> 	else if (CONFIG_SLS)
> 		// all rets are followed by one INT3

Maybe we should just ask kgdb if it is using breakpoint on that
function, and if so, just reject kprobe on it. Then, all INT3
can be just skipped. That may be more realistic solution.

Thank you, 

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
