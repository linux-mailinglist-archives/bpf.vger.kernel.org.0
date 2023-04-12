Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501096DF109
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 11:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDLJup (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 05:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDLJun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 05:50:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DB727DA1;
        Wed, 12 Apr 2023 02:50:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C28EC14;
        Wed, 12 Apr 2023 02:51:11 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 818193F587;
        Wed, 12 Apr 2023 02:50:24 -0700 (PDT)
Date:   Wed, 12 Apr 2023 10:50:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 0/5] Add ftrace direct call for arm64
Message-ID: <ZDZ+3dNnIdEpmWiP@FVFF77S0Q05N>
References: <20230405180250.2046566-1-revest@chromium.org>
 <ZDWDPUY2tZiMbk8V@FVFF77S0Q05N>
 <20230411124749.7aeea715@gandalf.local.home>
 <20230411170807.GA23143@willie-the-truck>
 <20230411134456.728551f8@gandalf.local.home>
 <20230411175423.GD23143@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411175423.GD23143@willie-the-truck>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 11, 2023 at 06:54:24PM +0100, Will Deacon wrote:
> On Tue, Apr 11, 2023 at 01:44:56PM -0400, Steven Rostedt wrote:
> > On Tue, 11 Apr 2023 18:08:08 +0100
> > Will Deacon <will@kernel.org> wrote:
> > 
> > > On Tue, Apr 11, 2023 at 12:47:49PM -0400, Steven Rostedt wrote:
> > > > On Tue, 11 Apr 2023 16:56:45 +0100
> > > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > >   
> > > > > IIUC Steve was hoping to take the FUNCTION_GRAPH_RETVAL series through the
> > > > > trace tree, and if that's still the plan, maybe both should go that way?  
> > > > 
> > > > The conflict is minor, and I think I prefer to still have the ARM64 bits go
> > > > through the arm64 tree, as it will get better testing, and I don't like to
> > > > merge branches ;-)
> > > > 
> > > > I've added Linus to the Cc so he knows that there will be conflicts, but as
> > > > long as we mention it in our pull request, with a branch that includes the
> > > > solution, it should be fine going through two different trees.  
> > > 
> > > If it's just the simple asm-offsets conflict that Mark mentioned, then that
> > > sounds fine to me. However, patches 3-5 don't seem to have anything to do
> > 
> > I guess 3 and 5 are not, but patch 4 adds arm64 code to the samples (as
> > it requires arch specific asm to handle the direct trampolines).
> 
> Sorry, yes, I was thinking of arch/arm64/ and then failed spectacularly
> at communicating :)
> 
> > > with arm64 at all and I'd prefer those to go via other trees (esp. as patch
> > > 3 is an independent -stable candidate and the last one is a bpf selftest
> > > change which conflicts in -next).
> > > 
> > > So I'll queue the first two in arm64 on a branch (or-next/ftrace) based
> > > on trace-direct-v6.3-rc3.
> > 
> > Are 3-5 dependent on those changes? If not, I can pull them into my tree.
> 
> Good question. Florent?

Patch 3 (the fix to the ftrace test) does not depend upon patches 1 and 2. It
probably would've been better to queue that as a preparatory fix before the
other changes.

Patch 4 (adding arm64 support to the samples) depends on patch 3. The arm64
parts depends upon patch 1 to be selectable, and without patch 1 the samples
will behave the same as before. It could be queued independently of patch 1,
but won't have any effect until merged with patch 1.

Patch 5 (the bpf selftest list changes) depends on patch 1 alone.

Perhaps we could queue 1 and 2 via the arm64 tree, 3 and 4 via the ftrace tree,
and follow up with patch 5 via the bpf tree after -rc1?

Thanks,
Mark.
