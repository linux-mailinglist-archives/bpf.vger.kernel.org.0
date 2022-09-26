Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597D85EAF01
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIZSDy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 14:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiIZSDI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 14:03:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3133CDF7A;
        Mon, 26 Sep 2022 10:44:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F7921CE2;
        Mon, 26 Sep 2022 10:44:08 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.81.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA163F73B;
        Mon, 26 Sep 2022 10:43:57 -0700 (PDT)
Date:   Mon, 26 Sep 2022 18:43:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Florent Revest <revest@chromium.org>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
Message-ID: <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N>
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
 <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net>
 <YzG51Jyd5zhvygtK@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzG51Jyd5zhvygtK@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 26, 2022 at 03:40:20PM +0100, Catalin Marinas wrote:
> On Thu, Sep 22, 2022 at 08:01:16PM +0200, Daniel Borkmann wrote:
> > On 9/13/22 6:27 PM, Xu Kuohai wrote:
> > > This series adds ftrace direct call for arm64, which is required to attach
> > > bpf trampoline to fentry.
> > > 
> > > Although there is no agreement on how to support ftrace direct call on arm64,
> > > no patch has been posted except the one I posted in [1], so this series
> > > continues the work of [1] with the addition of long jump support. Now ftrace
> > > direct call works regardless of the distance between the callsite and custom
> > > trampoline.
> > > 
> > > [1] https://lore.kernel.org/bpf/20220518131638.3401509-2-xukuohai@huawei.com/
> > > 
> > > v2:
> > > - Fix compile and runtime errors caused by ftrace_rec_arch_init
> > > 
> > > v1: https://lore.kernel.org/bpf/20220913063146.74750-1-xukuohai@huaweicloud.com/
> > > 
> > > Xu Kuohai (4):
> > >    ftrace: Allow users to disable ftrace direct call
> > >    arm64: ftrace: Support long jump for ftrace direct call
> > >    arm64: ftrace: Add ftrace direct call support
> > >    ftrace: Fix dead loop caused by direct call in ftrace selftest
> > 
> > Given there's just a tiny fraction touching BPF JIT and most are around core arm64,
> > it probably makes sense that this series goes via Catalin/Will through arm64 tree
> > instead of bpf-next if it looks good to them. Catalin/Will, thoughts (Ack + bpf-next
> > could work too, but I'd presume this just results in merge conflicts)?
> 
> I think it makes sense for the series to go via the arm64 tree but I'd
> like Mark to have a look at the ftrace changes first.

From a quick scan, I still don't think this is quite right, and as it stands I
believe this will break backtracing (as the instructions before the function
entry point will not be symbolized correctly, getting in the way of
RELIABLE_STACKTRACE). I think I was insufficiently clear with my earlier
feedback there, as I have a mechanism in mind that wa a little simpler.

I'll try to reply with some more detail tomorrow, but I don't think this is the
right approach, and as mentioned previously (and e.g. at LPC) I'd strongly
prefer to *not* implement direct calls, so that we can have more consistent
entry/exit handling.

Thanks,
Mark.
