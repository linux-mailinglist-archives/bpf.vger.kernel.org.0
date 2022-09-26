Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39375EABAF
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiIZPx1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 11:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbiIZPww (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 11:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0A891D0D;
        Mon, 26 Sep 2022 07:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0628460E2C;
        Mon, 26 Sep 2022 14:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5215C433B5;
        Mon, 26 Sep 2022 14:40:23 +0000 (UTC)
Date:   Mon, 26 Sep 2022 15:40:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Xu Kuohai <xukuohai@huaweicloud.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
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
Message-ID: <YzG51Jyd5zhvygtK@arm.com>
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
 <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 22, 2022 at 08:01:16PM +0200, Daniel Borkmann wrote:
> On 9/13/22 6:27 PM, Xu Kuohai wrote:
> > This series adds ftrace direct call for arm64, which is required to attach
> > bpf trampoline to fentry.
> > 
> > Although there is no agreement on how to support ftrace direct call on arm64,
> > no patch has been posted except the one I posted in [1], so this series
> > continues the work of [1] with the addition of long jump support. Now ftrace
> > direct call works regardless of the distance between the callsite and custom
> > trampoline.
> > 
> > [1] https://lore.kernel.org/bpf/20220518131638.3401509-2-xukuohai@huawei.com/
> > 
> > v2:
> > - Fix compile and runtime errors caused by ftrace_rec_arch_init
> > 
> > v1: https://lore.kernel.org/bpf/20220913063146.74750-1-xukuohai@huaweicloud.com/
> > 
> > Xu Kuohai (4):
> >    ftrace: Allow users to disable ftrace direct call
> >    arm64: ftrace: Support long jump for ftrace direct call
> >    arm64: ftrace: Add ftrace direct call support
> >    ftrace: Fix dead loop caused by direct call in ftrace selftest
> 
> Given there's just a tiny fraction touching BPF JIT and most are around core arm64,
> it probably makes sense that this series goes via Catalin/Will through arm64 tree
> instead of bpf-next if it looks good to them. Catalin/Will, thoughts (Ack + bpf-next
> could work too, but I'd presume this just results in merge conflicts)?

I think it makes sense for the series to go via the arm64 tree but I'd
like Mark to have a look at the ftrace changes first.

Thanks.

-- 
Catalin
