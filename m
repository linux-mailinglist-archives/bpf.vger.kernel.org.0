Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCFB62FA30
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 17:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiKRQ0l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 11:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKRQ0k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 11:26:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0C36764F;
        Fri, 18 Nov 2022 08:26:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D124623A;
        Fri, 18 Nov 2022 08:26:45 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A582E3F663;
        Fri, 18 Nov 2022 08:26:37 -0800 (PST)
Date:   Fri, 18 Nov 2022 16:26:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
Message-ID: <Y3eyOpVg1dgP1Gjv@FVFF77S0Q05N.cambridge.arm.com>
References: <20221108220651.24492-1-revest@chromium.org>
 <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117223353.431e29124ba51a72c3507ced@kernel.org>
 <CAADnVQJgWb36eLEPqcChiVTUikSMU5UNAdo30fD7H8xFiE2E1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJgWb36eLEPqcChiVTUikSMU5UNAdo30fD7H8xFiE2E1w@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

On Thu, Nov 17, 2022 at 08:50:12AM -0800, Alexei Starovoitov wrote:
> There might not be a task available where bpf trampoline is running.

I'm not sure what you mean by "there might not be a task available"; do you
mean that there might not be space in the per-task shadow stack, or that the
BPF program can be invoked inan IRQ context?

> rcu protection might not be there either.

We've spent a lot of time reworking entry/idle sequences with noinstr, so any
time BPF can be invoked, we should have a regular kernel environment available,
with RCU watching (but not necessarily in an RCU read-side critical section).
If BPF is being invoked without RCU watching, that is a bug that needs to be
fixed.

Do you have a specific example in mind?

Thanks,
Mark.
