Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198186BC1C2
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 00:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjCOXvq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 19:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjCOXvp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 19:51:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F5824499;
        Wed, 15 Mar 2023 16:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FE7CB81E8A;
        Wed, 15 Mar 2023 23:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632F8C433D2;
        Wed, 15 Mar 2023 23:51:39 +0000 (UTC)
Date:   Wed, 15 Mar 2023 19:51:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Xu Kuohai <xukuohai@huawei.com>
Subject: Re: [PATCH v2 06/10] ftrace: selftest: remove broken
 trace_direct_tramp
Message-ID: <20230315195136.2996b1dd@gandalf.local.home>
In-Reply-To: <20230207182135.2671106-7-revest@chromium.org>
References: <20230207182135.2671106-1-revest@chromium.org>
        <20230207182135.2671106-7-revest@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue,  7 Feb 2023 19:21:31 +0100
Florent Revest <revest@chromium.org> wrote:

> From: Mark Rutland <mark.rutland@arm.com>
> 
> The ftrace selftest code has a trace_direct_tramp() function which it
> uses as a direct call trampoline. This happens to work on x86, since the
> direct call's return address is in the usual place, and can be returned
> to via a RET, but in general the calling convention for direct calls is
> different from regular function calls, and requires a trampoline written
> in assembly.
> 
> On s390, regular function calls place the return address in %r14, and an
> ftrace patch-site in an instrumented function places the trampoline's
> return address (which is within the instrumented function) in %r0,
> preserving the original %r14 value in-place. As a regular C function
> will return to the address in %r14, using a C function as the trampoline
> results in the trampoline returning to the caller of the instrumented
> function, skipping the body of the instrumented function.
> 
> Note that the s390 issue is not detcted by the ftrace selftest code, as
> the instrumented function is trivial, and returning back into the caller
> happens to be equivalent.
> 
> On arm64, regular function calls place the return address in x30, and
> an ftrace patch-site in an instrumented function saves this into r9
> and places the trampoline's return address (within the instrumented
> function) in x30. A regular C function will return to the address in
> x30, but will not restore x9 into x30. Consequently, using a C function
> as the trampoline results in returning to the trampoline's return
> address having corrupted x30, such that when the instrumented function
> returns, it will return back into itself.
> 
> To avoid future issues in this area, remove the trace_direct_tramp()
> function, and require that each architecture with direct calls provides
> a stub trampoline, named ftrace_stub_direct_tramp. This can be written
> to handle the architecture's trampoline calling convention, and in
> future could be used elsewhere (e.g. in the ftrace ops sample, to
> measure the overhead of direct calls), so we may as well always build it
> in.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Li Huafei <lihuafei1@huawei.com>
> Cc: Xu Kuohai <xukuohai@huawei.com>
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Florent Revest <revest@chromium.org>
> Signed-off-by: Florent Revest <revest@chromium.org>


Care to respin with my update requests? I can take up to this patch and
base it directly on v6.3-rc3 when it comes out. I'm expecting that to have
the fixes in other code that is breaking my tests.

Then I'll push it out after it passes all my tests, and you can take it
and add the arm64 specific bits on top. I'm currently running these patches
as is on my tests to see if they fail (with a patched kernel for the other
code that's breaking my tests).

Does that sound OK?

-- Steve
