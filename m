Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7425A5B26BD
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 21:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiIHTbx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 15:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiIHTbw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 15:31:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D90BB932;
        Thu,  8 Sep 2022 12:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5453B82235;
        Thu,  8 Sep 2022 19:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088B0C433C1;
        Thu,  8 Sep 2022 19:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662665509;
        bh=NmE619tRw480q6SlrwPDQuo+MM2YUSnioxegTXmhEHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvlRWEJ32TDBz38Gt6UPyhmuOvwv0H6sA6MmoAaBpuZY5csfvvSiCIvigsAZcO44+
         jrgMuk0DnvyV0bATZ+zKus3DjHznzN1PeD0qA9lt3O0bkkGyKBf6MOL74LaTHezGvN
         2BLPdJKvyGadn40FA5gf0pM9uD+XcjI1FFv9XXgwnTF8LyOm60EMpL9QmPmftLl30Z
         GFxD/LOTYhqj7CvVpttkpD7Yy9NRJWcqnhq/WPr4QwWDd8SVMYLhGAlPLeip1GzC9j
         x5hRVGUDpLIe3563UcHSj+4ZriObyVnyLiIhXpAnZC6wD5mrslcMv9G/2lmPsgeeiq
         6BddUzRLayJtQ==
Date:   Thu, 8 Sep 2022 12:31:47 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: Re: [PATCH v3 0/2] x86/kprobes: Fixes for CONFIG_RETHUNK
Message-ID: <20220908193147.mtfwh33q2cfbw52b@treble>
References: <20220908220354.28c196c8bbe4e83c83afcb59@kernel.org>
 <166264927154.775585.16570756675363838701.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <166264927154.775585.16570756675363838701.stgit@devnote2>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 12:01:11AM +0900, Masami Hiramatsu (Google) wrote:
> Hi Peter and Josh,
> 
> So here is 3rd version of the patches to fix kprobes and optprobe with
> CONFIG_RETHUNK and CONFIG_SLS.
> Previous version is here;
> 
> https://lore.kernel.org/all/166260087224.759381.4170102827490658262.stgit@devnote2/
> 
> In this version, I simplified all code and just checks the INT3 comes
> from kgdb or not. Other INT3 are treated as one-byte instruction.

Looks good to me.

I was confused by the naming of kgdb_has_hit_break(), because in this
case, with the function being called from outside the stopped kgdb
context, the breakpoint hasn't actually been hit.  But it still seems to
do the right thing: it checks for BP_ACTIVE which means the breakpoint
has been written.

Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
