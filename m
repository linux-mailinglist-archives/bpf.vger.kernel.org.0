Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF6462E240
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiKQQu3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiKQQu0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:50:26 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608FDB33;
        Thu, 17 Nov 2022 08:50:25 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s12so3404997edd.5;
        Thu, 17 Nov 2022 08:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/aswNfyMkh//CcDXYmA3nSXMJmEZY1Lf+IcBw6TRdgk=;
        b=n5GQMNxVa2bgTp7K/tH+z/Pj5S8cpB0nY4bcYF6KX3oLQP1AxDPrrgVdjV4CM0/0qF
         e0sgQw+fSFL2EBv3+Ff3o1qLHfIVba9l/MByBGUopzZShBx7on3w4sg8S/XZiqmzmtEl
         WPlcRr84lCiKvQLp1VAFgrB2suaT6VIcAZLUpZmn3H/q5ITkOgPkodBlY0gsSlIP6ZdF
         ZYREWDUZcAP3Z7C5v1AkWMXxNRMsyWtYx1Ju/YKwFwT4ZYjX8Xoi+wG5sAbuvmOV1CKY
         O/SL+2X+HYTaiZbdwRLlnQjypEEdRjGybw6M+rRhQ0Ta4ChXkJ6XvaR7RRPPrCpfuVaj
         Wzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aswNfyMkh//CcDXYmA3nSXMJmEZY1Lf+IcBw6TRdgk=;
        b=rPl/Ty3yeeLPZNh2hzKs0xm6oLAJ3WA1RG8rZlr0DHz4gBrpba8cCVGOYL1hVoTIWl
         LPFPV/SiOQLUrTRPUBq/UbmH6hICJsooqg9KTT2xNClKiV6/J225sowrMjaO4NHU4mv3
         /ckuPc2ngkZBZwXqIWPk3DOT1b9UL32npco46HTzuRXQS+NOptC226VzL6tnBakPzx0e
         LcBhLJYurCd0Im0fVVdWv0KFmTtha1ul83gy6fe77dkx0XNF4I1DnsnITSDejKlKPBBu
         RlfwnM2FdyZ2//EJBnTfwyhCjOZhSZvYVeklT7fy5iUv3/MIGAYZyn09Eq3anNKcInLs
         vjMA==
X-Gm-Message-State: ANoB5pk77Xe5MsmOzk0a5jHBG7HkTpVG/D8ZLyTd1RVy8VdoWc1egCMh
        rLduhege+voE6wfSc1COcGhCHwpAyvGMzJcZe+s=
X-Google-Smtp-Source: AA0mqf4sUA7CdX0C6mH5EVP/hG+QTrF7qZiJ6ORlFptWGwbQs9RnWlM9Mmls4hLhggnRWGXn9SySpnmSGthc4ksOM7w=
X-Received: by 2002:a05:6402:142:b0:461:7fe6:9ea7 with SMTP id
 s2-20020a056402014200b004617fe69ea7mr2886585edu.94.1668703823804; Thu, 17 Nov
 2022 08:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20221108220651.24492-1-revest@chromium.org> <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117223353.431e29124ba51a72c3507ced@kernel.org>
In-Reply-To: <20221117223353.431e29124ba51a72c3507ced@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 17 Nov 2022 08:50:12 -0800
Message-ID: <CAADnVQJgWb36eLEPqcChiVTUikSMU5UNAdo30fD7H8xFiE2E1w@mail.gmail.com>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 17, 2022 at 5:34 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Wed, 16 Nov 2022 18:41:26 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Tue, Nov 8, 2022 at 2:07 PM Florent Revest <revest@chromium.org> wrote:
> > >
> > > Hi!
> > >
> > > With this RFC, I'd like to revive the conversation between BPF, ARM and tracing
> > > folks on what BPF tracing (fentry/fexit/fmod_ret) could/should look like on
> > > arm64.
> > >
> > > Current status of BPF tracing
> > > =============================
> > >
> > > On currently supported architectures (like x86), BPF tracing programs are
> > > called from a JITted BPF trampoline, itself called from the ftrace patch site
> > > thanks to the ftrace "direct call" API. (or from the end of the ftrace
> > > trampoline if a ftrace ops is also tracing that function, but this is
> > > transparent to BPF)
> > >
> > > Thanks to Xu's work [1], we now have BPF trampolines on arm64 (these can be
> > > used for struct ops programs already), but Xu's attempts at getting ftrace
> > > direct calls support [2][3] on arm64 have been unsucessful so far so we still
> > > do not support BPF tracing programs. This prompted me to try a different
> > > approach. I'd like to collect feedback on it here.
> > >
> > > Why not direct calls ?
> > > ======================
> > >
> > > Mark and Steven have not been too keen on getting direct calls on arm64 because:
> > > - working around BL instruction's limited range introduces complexity [4]
> > > - it's difficult to get reliable stacktraces right with direct calls [5]
> > > - direct calls are complex to maintain on the arch/ftrace side [5]
> > >
> > > In the absence of ftrace direct calls support, BPF tracing programs would need
> > > to be called from an ftrace ops instead. Note that the BPF callback signature
> > > would have to be different, so we can't re-use trampolines (direct called
> > > callbacks receive arguments in registers whereas ftrace ops callbacks receive
> > > arguments in a struct ftrace_regs pointer)
> > >
> > > Why fprobe ?
> > > ============
> > >
> > > Ftrace ops per-se only expose an API to hook before a function. There are two
> > > systems built on top of ftrace ops that also allow hooking the function exit:
> > > fprobe (using rethook) and the function graph tracer. There are plans from
> > > Masami and Steven to unify these two systems but, as they stand, only fprobe
> > > gives enough flexibility to implement BPF tracing.
> > >
> > > In order not to reinvent the wheel, if direct calls aren't available on the
> > > arch, BPF could leverage fprobe to hook before and after the traced function.
> > > Note that return hooking is implemented a bit differently than it is in BPF
> > > trampolines. Instead of keeping arguments on a stack frame and calling the
> > > traced function, rethook saves arguments in a memory pool and returns to the
> > > traced function with a hijacked return pointer that will have its ret jump back
> > > to the rethook trampoline.
> > >
> > > What about performances ?
> > > =========================
> > >
> > > In its current state, a fprobe callback on arm64 is very expensive because:
> > > 1- the ftrace trampoline saves all registers (including many unnecessary ones)
> > > 2- it calls ftrace_ops_list_func which iterates over all ops and is very slow
> > > 3- the fprobe ops unconditionally hooks a rethook
> > > 4- rethook grabs memory from a freelist which is slow under high contention
> > >
> > > However, all the above points are currently being addressed:
> > > 1- by Mark's series to save argument registers only [6]
> > > 2- by Mark's series to call single ops directly [7]
> > > 3- by Masami's patch to skip rethooks if not needed [8]
> > > 4- Masami said the rethook freelist would be replaced by a per-task stack as
> > >    part of its unification with the function graph tracer [9]
> > >
> > > I measured the costs of BPF on different approaches on my RPi4 here: [10]
> > > tl;dr: the BPF "bench" takes a performance hit of:
> > > - 28.6% w/ BPF tracing on direct calls (best case scenario for reference) [11]
> > > - 66.8% w/ BPF on kprobe (just for reference)
> > > - 62.6% w/ BPF tracing on fprobe without any optimizations (current state) [12]
> > > - 34.1% w/ BPF tracing on fprobe with all optimizations (near-future state) [13]
> >
> > Even with all optimization the performance overhead is not acceptable.
> > It feels to me that folks are still thinking about bpf trampoline
> > as a tracing facility.
> > It's a lot more than that. It needs to run 24/7 with zero overhead.
> > It needs to replace the kernel functions and be invoked
> > millions times a second until the system is rebooted.
> > In this environment every nanosecond counts.
> >
> > Even if the fprobe side was completely free the patch 1 has so much
> > overhead in copy of bpf_cookie, regs, etc that it's a non-starter
> > for these use cases.
> >
> > There are several other fundamental issues in this approach
> > because of fprobe/ftrace.
> > It has ftrace_test_recursion_trylock and disables preemption.
> > Both are deal breakers.
>
> I talked with Florent about this offline.
> ftrace_test_recursion_trylock() is required for generic ftrace
> use because user callback can call a function which can be
> traced by ftrace. This means it can cause an infinite loop.
> However, if user can ensure to check it by itself, I can add a
> flag to avoid that trylock. (Of course, you can shoot your foot.)
>
> I thought the preemption disabling was for accessing per-cpu,
> but it is needed for rethook to get an object from an RCU
> protected list.
> Thus when we move on the per-task shadow stack, it can be
> removed too.

There might not be a task available where bpf trampoline is running.
rcu protection might not be there either.
Really we're just scratching the surface of all the issues why
fprobe is not usable.
