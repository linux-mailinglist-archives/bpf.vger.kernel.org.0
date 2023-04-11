Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDE86DE32F
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 19:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDKRye (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 13:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDKRyd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 13:54:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ACB5241;
        Tue, 11 Apr 2023 10:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECB1B625B5;
        Tue, 11 Apr 2023 17:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634C6C4339E;
        Tue, 11 Apr 2023 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681235671;
        bh=54LJu/uSR+OsrlePoQijbNxy1ZDn64og6zc21iXSGBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZM7uyjNGHb190bgTNK8XIfUWc5OWWpnCC2DBIMmQ0TOjo8htAv2XNx2Mg+0YBHhS
         BSeyE2SA9B8oxWjfSu/2Na+nvWy+upQ4VyB9OdYWwm6Hr7Ma3Xw17W3arxD9KayRwT
         HmIPJ8NTIoyLmiw95MjWATlmInH5pX2zxPfljlImUnhkSDcYBwlUPbJ9RFor+5H0+g
         GLF4YJWt59Oy8p/ME+f7vAW+/2alSHw6Gh0RrbtYVR42eyP1ZqstkUzE2qeAahk1Du
         NjgRtXpolpQ/7ZMUu1BSJyOQ28v6iAtN50jLnQVlZcEvjL7CmwG5b8XIkDOhe7Zxmf
         hzo/Z9oXsk15A==
Date:   Tue, 11 Apr 2023 18:54:24 +0100
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
Message-ID: <20230411175423.GD23143@willie-the-truck>
References: <20230405180250.2046566-1-revest@chromium.org>
 <ZDWDPUY2tZiMbk8V@FVFF77S0Q05N>
 <20230411124749.7aeea715@gandalf.local.home>
 <20230411170807.GA23143@willie-the-truck>
 <20230411134456.728551f8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411134456.728551f8@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 11, 2023 at 01:44:56PM -0400, Steven Rostedt wrote:
> On Tue, 11 Apr 2023 18:08:08 +0100
> Will Deacon <will@kernel.org> wrote:
> 
> > On Tue, Apr 11, 2023 at 12:47:49PM -0400, Steven Rostedt wrote:
> > > On Tue, 11 Apr 2023 16:56:45 +0100
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > >   
> > > > IIUC Steve was hoping to take the FUNCTION_GRAPH_RETVAL series through the
> > > > trace tree, and if that's still the plan, maybe both should go that way?  
> > > 
> > > The conflict is minor, and I think I prefer to still have the ARM64 bits go
> > > through the arm64 tree, as it will get better testing, and I don't like to
> > > merge branches ;-)
> > > 
> > > I've added Linus to the Cc so he knows that there will be conflicts, but as
> > > long as we mention it in our pull request, with a branch that includes the
> > > solution, it should be fine going through two different trees.  
> > 
> > If it's just the simple asm-offsets conflict that Mark mentioned, then that
> > sounds fine to me. However, patches 3-5 don't seem to have anything to do
> 
> I guess 3 and 5 are not, but patch 4 adds arm64 code to the samples (as
> it requires arch specific asm to handle the direct trampolines).

Sorry, yes, I was thinking of arch/arm64/ and then failed spectacularly
at communicating :)

> > with arm64 at all and I'd prefer those to go via other trees (esp. as patch
> > 3 is an independent -stable candidate and the last one is a bpf selftest
> > change which conflicts in -next).
> > 
> > So I'll queue the first two in arm64 on a branch (or-next/ftrace) based
> > on trace-direct-v6.3-rc3.
> 
> Are 3-5 dependent on those changes? If not, I can pull them into my tree.

Good question. Florent?

Will
