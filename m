Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D025153895E
	for <lists+bpf@lfdr.de>; Tue, 31 May 2022 03:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241938AbiEaBAK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 May 2022 21:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiEaBAJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 May 2022 21:00:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8490D56C04;
        Mon, 30 May 2022 18:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D02060F15;
        Tue, 31 May 2022 01:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E11C385B8;
        Tue, 31 May 2022 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653958806;
        bh=jNUPq/Tf7RZLxM01lVMgFQXyzyWU02Zq99rarwAuvzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H9giW1zQMpscgulPFUwCl5b84ckvXqhU7BmMSZ35f4dwWJM4XXjWrqB5ZMlaH6RiV
         2ybrnwbU96e7unajuXF7G7Nw7kQpbO7rowgaOD/vvuo+ptSBgg5TM1+jyJvEljcuoq
         twANhFTRPo5JIB7eNqXRKu7bbuGIb9KvpjG7weSytHtV4a1H4UXyfRw2zrWyz0MGg9
         oyuCy0WYpemdU5SdNE7SszZRhr+diV6HbccanRZOTX6tCOBiKpdYbcAKDqduoIeIlN
         yptHxjHgvjHc0uARiI/alXiIS0KMWPkRZNYPUhTmKxx3aS3Zp9PGvDHOJ376+JzTg2
         VQ7n1OsU6AcVA==
Date:   Tue, 31 May 2022 10:00:00 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-Id: <20220531100000.cbd18c4c08eacb67b95fba5b@kernel.org>
In-Reply-To: <YpS6x0g8AimeaAw9@krava>
References: <YnJUTuOIX9YoJq23@FVFF77S0Q05N>
        <20220505121538.04773ac98e2a8ba17f675d39@kernel.org>
        <20220509142203.6c4f2913@gandalf.local.home>
        <20220510181012.d5cba23a2547f14d14f016b9@kernel.org>
        <20220510104446.6d23b596@gandalf.local.home>
        <20220511233450.40136cdf6a53eb32cd825be8@kernel.org>
        <20220511111207.25d1a693@gandalf.local.home>
        <20220512210231.f9178a98f20a37981b1e89e3@kernel.org>
        <Yo4eWqHA/IjNElNN@FVFF77S0Q05N>
        <20220530100310.c22c36df4ea9324cb9cb3515@kernel.org>
        <YpS6x0g8AimeaAw9@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 30 May 2022 14:38:31 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, May 30, 2022 at 10:03:10AM +0900, Masami Hiramatsu wrote:
> > (Cc: BPF ML)
> > 
> > On Wed, 25 May 2022 13:17:30 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > On Thu, May 12, 2022 at 09:02:31PM +0900, Masami Hiramatsu wrote:
> > > > On Wed, 11 May 2022 11:12:07 -0400
> > > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > 
> > > > > On Wed, 11 May 2022 23:34:50 +0900
> > > > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > > 
> > > > > > OK, so fregs::regs will have a subset of pt_regs, and accessibility of
> > > > > > the registers depends on the architecture. If we can have a checker like
> > > > > > 
> > > > > > ftrace_regs_exist(fregs, reg_offset)
> > > > > 
> > > > > Or something. I'd have to see the use case.
> > > > > 
> > > > > > 
> > > > > > kprobe on ftrace or fprobe user (BPF) can filter user's requests.
> > > > > > I think I can introduce a flag for kprobes so that user can make a
> > > > > > kprobe handler only using a subset of registers. 
> > > > > > Maybe similar filter code is also needed for BPF 'user space' library
> > > > > > because this check must be done when compiling BPF.
> > > > > 
> > > > > Is there any other case without full regs that the user would want anything
> > > > > other than the args, stack pointer and instruction pointer?
> > > > 
> > > > For the kprobes APIs/events, yes, it needs to access to the registers
> > > > which is used for local variables when probing inside the function body.
> > > > However at the function entry, I think almost no use case. (BTW, pstate
> > > > is a bit special, that may show the actual processor-level status
> > > > (context), so for the debugging, user might want to read it.)
> > > 
> > > As before, if we really need PSTATE we *must* take an exception to get a
> > > reliable snapshot (or to alter the value). So I'd really like to split this
> > > into two cases:
> > > 
> > > * Where users *really* need PSTATE (or arbitrary GPRs), they use kprobes. That
> > >   always takes an exception and they can have a complete, real struct pt_regs.
> > > 
> > > * Where users just need to capture a function call boundary, they use ftrace.
> > >   That uses a trampoline without taking an exception, and they get the minimal
> > >   set of registers relevant to the function call boundary (which does not
> > >   include PSTATE or most GPRs).
> > 
> > I totally agree with this idea. The x86 is a special case, since the
> > -fentry option puts a call on the first instruction of the function entry,
> > I had to reuse the ftrace instead of swbp for kprobes.
> > But on arm64 (and other RISCs), we can use them properly.
> > 
> > My concern is that the eBPF depends on kprobe (pt_regs) interface, thus
> > I need to ask them that it is OK to not accessable to some part of
> > pt_regs (especially, PSTATE) if they puts probes on function entry
> > with ftrace (fprobe in this case.)
> > 
> > (Jiri and BPF developers)
> > Currently fprobe is only enabled on x86 for "multiple kprobes" BPF
> > interface, but in the future, it will be enabled on arm64. And at
> > that point, it will be only accessible to the regs for function
> > arguments. Is that OK for your use case? And will the BPF compiler
> 
> I guess from practical POV registers for arguments and ip should be enough,
> but whole pt_regs was already exposed to programs, so people can already use
> any of them.. not sure it's good idea to restrict it
> 
> > be able to restrict the user program to access only those registers
> > when using the "multiple kprobes"?
> 
> pt-regs pointer is provided to kprobe programs, I guess we could provide copy
> of that with just available values

Yes, ftrace_regs already provides partial filled pt_regs (which registers
are valid is arch-dependent). Thus, my idea is changing fprobe's handler
interface to expose ftrace_regs instead of pt_regs, and the BPF handler
will extract the internal pt_regs.
If the BPF compiler can list which registers will be accessed form the
user program, the kernel side can filter it.
I think similar feature can be done in the kprobe-event (new fprobe event?).

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
