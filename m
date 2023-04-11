Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485C96DE1E0
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 19:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDKRIR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 13:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDKRIQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 13:08:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7DA4214;
        Tue, 11 Apr 2023 10:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FA136229A;
        Tue, 11 Apr 2023 17:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC12FC433EF;
        Tue, 11 Apr 2023 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681232894;
        bh=3xl+XtZezdw4QpMyzTsLS/WvCzCf6vBV48z/ovOohUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeNbsTFchff9V07+7tRlWST/zDXWjpGlPgAiT/3o3TQt66nKuGSYYpPyh6ECcYcJP
         yceYhlpxtGAt72MI0iClIXLFuW/Of9ZnkKoNMFjoMiDJ9jscomSbj3Ly5KcFZzA3XN
         rdJv71G31aGVYwlnc1zLQdddPsHoFNZuMaS5RsoqHVot02YLBu/UDzMj2ppiMbPTlw
         UnB613knpO85dSWd1hvf+6a2xVQwHP8oG4QLQEfIP5UjydR2Jc7RQXNB0yVdNScSpJ
         WvmgTdhJymezaokv7Hf1jMZVIpOXgh0E3uODQC27LH6GJrKPeoOkoMem+qng8XF9WL
         FdkqvcQdhcd9Q==
Date:   Tue, 11 Apr 2023 18:08:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 0/5] Add ftrace direct call for arm64
Message-ID: <20230411170807.GA23143@willie-the-truck>
References: <20230405180250.2046566-1-revest@chromium.org>
 <ZDWDPUY2tZiMbk8V@FVFF77S0Q05N>
 <20230411124749.7aeea715@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411124749.7aeea715@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 11, 2023 at 12:47:49PM -0400, Steven Rostedt wrote:
> On Tue, 11 Apr 2023 16:56:45 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > IIUC Steve was hoping to take the FUNCTION_GRAPH_RETVAL series through the
> > trace tree, and if that's still the plan, maybe both should go that way?
> 
> The conflict is minor, and I think I prefer to still have the ARM64 bits go
> through the arm64 tree, as it will get better testing, and I don't like to
> merge branches ;-)
> 
> I've added Linus to the Cc so he knows that there will be conflicts, but as
> long as we mention it in our pull request, with a branch that includes the
> solution, it should be fine going through two different trees.

If it's just the simple asm-offsets conflict that Mark mentioned, then that
sounds fine to me. However, patches 3-5 don't seem to have anything to do
with arm64 at all and I'd prefer those to go via other trees (esp. as patch
3 is an independent -stable candidate and the last one is a bpf selftest
change which conflicts in -next).

So I'll queue the first two in arm64 on a branch (or-next/ftrace) based
on trace-direct-v6.3-rc3.

Will
