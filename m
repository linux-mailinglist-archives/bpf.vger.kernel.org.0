Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE25760169C
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 20:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJQStg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 14:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJQStf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 14:49:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5142411A17;
        Mon, 17 Oct 2022 11:49:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 555D3B81A07;
        Mon, 17 Oct 2022 18:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17616C433C1;
        Mon, 17 Oct 2022 18:49:25 +0000 (UTC)
Date:   Mon, 17 Oct 2022 14:49:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florent Revest <revest@chromium.org>
Cc:     Xu Kuohai <xukuohai@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
Message-ID: <20221017144949.2b9dcdc5@gandalf.local.home>
In-Reply-To: <CABRcYm+d=xY9nBCJo-6JW_=F41g4X32QM9WOPChaOTfs6d6KCA@mail.gmail.com>
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
        <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net>
        <YzG51Jyd5zhvygtK@arm.com>
        <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N>
        <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
        <YzR5WSLux4mmFIXg@FVFF77S0Q05N>
        <2cb606b4-aa8b-e259-cdfd-1bfc61fd7c44@huawei.com>
        <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
        <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com>
        <20221005110707.55bd9354@gandalf.local.home>
        <CABRcYmJGY6fp0CtUBYN8BjEDN=r42BPLSBcrxqu491bTRmfm7g@mail.gmail.com>
        <20221005113019.18aeda76@gandalf.local.home>
        <CABRcYmL0bDkgYP3tSwhZYaGUSbsUR3Gq85QCRiUAdXt65czzmg@mail.gmail.com>
        <20221006122922.53802a5c@gandalf.local.home>
        <CABRcYm+d=xY9nBCJo-6JW_=F41g4X32QM9WOPChaOTfs6d6KCA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 17 Oct 2022 19:55:06 +0200
Florent Revest <revest@chromium.org> wrote:

> Note that I can't really make sense of the perf report with indirect
> calls. it always reports it spent 12% of the time in
> rethook_trampoline_handler but I verified with both a WARN in that
> function and a breakpoint with a debugger, this function does *not*
> get called when running this "bench trig-fentry" benchmark. Also it
> wouldn't make sense for fprobe_handler to call it so I'm quite
> confused why perf would report this call and such a long time spent
> there. Anyone know what I could be missing here ?

The trace shows __bpf_prog_exit, which I'm guessing is tracing the end of
the function. Right?

In which case I believe it must call rethook_trampoline_handler:

 -> fprobe_handler() /* Which could use some "unlikely()" to move disabled
                        paths out of the hot path */

       /* And also calls rethook_try_get () which does a cmpxchg! */

	-> ret_hook()
		-> arch_rethook_prepare()
			Sets regs->lr = arch_rethook_trampoline

On return of the function, it jumps to arch_rethook_trampoline()

  -> arch_rethook_trampoline()
	-> arch_rethook_trampoline_callback()
		-> rethook_trampoline_handler()

So I do not know how it wouldn't trigger the WARNING or breakpoint if you
added it there.

-- Steve
