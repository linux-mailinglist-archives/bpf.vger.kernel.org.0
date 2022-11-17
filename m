Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797D262D132
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 03:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKQCll (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 21:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiKQClk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 21:41:40 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3199B429BE;
        Wed, 16 Nov 2022 18:41:39 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n20so1930888ejh.0;
        Wed, 16 Nov 2022 18:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uKxGBHMAN3UiI7Gqdl3dxWknkRvzMPql8pZxmBidFZU=;
        b=BEGJMAKm/hxrL5kaJ+kD8XPZyeCYovERo+xVc1w16Xb5gqbIci4ujNMF1DZAlAHe6S
         MNhIfe+qCqkh6A7ALM2LfcVCoAKvdp00C1AWDlBeoIx9u69raX0AWaF2h2oqZFPoXDJY
         Q/NT/NkvWuowIWYl2CAyaHevZv2PF0gTdUK5gWVAiAMBfehBT235XJyHTgE90lYWv9Eg
         c8Fa/37D8kbKdHFEMJEXHK2s+N5sQqb0dsfVvg5kWdGjY6IoV41G/2MPiQDlmmM+ujcF
         6lchTrZlQ70eWKzwU8BtOZ+OpjUKbGffIE8uVH2WX0V/3AlGP9PPIEeYB0GCO6auE1td
         D3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKxGBHMAN3UiI7Gqdl3dxWknkRvzMPql8pZxmBidFZU=;
        b=dP316cLdnEyKoMxM5TEdYYA8LdT2rR30qhXgRpgtsBYH3nZG4B6EKAs8W4rde6eUm2
         CwP2LgGfiW+5pL+ZmyFcZWR12nMn5+Q35XkPFM5Teb8uJvf9gtYZRmK/UZmW5V56Jpl8
         WAOv8eWL1W/tkn2VvpFXa5Xv3mw7B08tjrPQd+KYGvlK6Z+l/gJVUiGSo9fPneCgZ42L
         ZalooLzDbbIFPh+ydEP9vDSJQxW5em5eq5/sPpJ6mPnfS3Ns7w+HTq9HfXFZiY81VF38
         GLERUHdIyhsRz8ILk7HDfiadgzPnsML14I5eW73QsifBsfcJwLS8c8jFxg/fcNRkiWcw
         uGAg==
X-Gm-Message-State: ANoB5pkxYJooPrjyVtwinfiaO7HHEzQDQwzS6opYoxdsIuNwsYRNNWZy
        BDMNfvgiNn6hYsl7ogcYDBOyhvSpwe1/Vus9Qb2LQN8WISo=
X-Google-Smtp-Source: AA0mqf6EgRAN/j1wXHsoRv/GjI+gQCiHsCp4U9dOlM8xn4VqH7W/TKSXrk66AHJI8X6S3Y3P1z+uWpbuI1/FkL6ty6g=
X-Received: by 2002:a17:906:1495:b0:7ad:d250:b904 with SMTP id
 x21-20020a170906149500b007add250b904mr480092ejc.633.1668652897745; Wed, 16
 Nov 2022 18:41:37 -0800 (PST)
MIME-Version: 1.0
References: <20221108220651.24492-1-revest@chromium.org>
In-Reply-To: <20221108220651.24492-1-revest@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 16 Nov 2022 18:41:26 -0800
Message-ID: <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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

On Tue, Nov 8, 2022 at 2:07 PM Florent Revest <revest@chromium.org> wrote:
>
> Hi!
>
> With this RFC, I'd like to revive the conversation between BPF, ARM and tracing
> folks on what BPF tracing (fentry/fexit/fmod_ret) could/should look like on
> arm64.
>
> Current status of BPF tracing
> =============================
>
> On currently supported architectures (like x86), BPF tracing programs are
> called from a JITted BPF trampoline, itself called from the ftrace patch site
> thanks to the ftrace "direct call" API. (or from the end of the ftrace
> trampoline if a ftrace ops is also tracing that function, but this is
> transparent to BPF)
>
> Thanks to Xu's work [1], we now have BPF trampolines on arm64 (these can be
> used for struct ops programs already), but Xu's attempts at getting ftrace
> direct calls support [2][3] on arm64 have been unsucessful so far so we still
> do not support BPF tracing programs. This prompted me to try a different
> approach. I'd like to collect feedback on it here.
>
> Why not direct calls ?
> ======================
>
> Mark and Steven have not been too keen on getting direct calls on arm64 because:
> - working around BL instruction's limited range introduces complexity [4]
> - it's difficult to get reliable stacktraces right with direct calls [5]
> - direct calls are complex to maintain on the arch/ftrace side [5]
>
> In the absence of ftrace direct calls support, BPF tracing programs would need
> to be called from an ftrace ops instead. Note that the BPF callback signature
> would have to be different, so we can't re-use trampolines (direct called
> callbacks receive arguments in registers whereas ftrace ops callbacks receive
> arguments in a struct ftrace_regs pointer)
>
> Why fprobe ?
> ============
>
> Ftrace ops per-se only expose an API to hook before a function. There are two
> systems built on top of ftrace ops that also allow hooking the function exit:
> fprobe (using rethook) and the function graph tracer. There are plans from
> Masami and Steven to unify these two systems but, as they stand, only fprobe
> gives enough flexibility to implement BPF tracing.
>
> In order not to reinvent the wheel, if direct calls aren't available on the
> arch, BPF could leverage fprobe to hook before and after the traced function.
> Note that return hooking is implemented a bit differently than it is in BPF
> trampolines. Instead of keeping arguments on a stack frame and calling the
> traced function, rethook saves arguments in a memory pool and returns to the
> traced function with a hijacked return pointer that will have its ret jump back
> to the rethook trampoline.
>
> What about performances ?
> =========================
>
> In its current state, a fprobe callback on arm64 is very expensive because:
> 1- the ftrace trampoline saves all registers (including many unnecessary ones)
> 2- it calls ftrace_ops_list_func which iterates over all ops and is very slow
> 3- the fprobe ops unconditionally hooks a rethook
> 4- rethook grabs memory from a freelist which is slow under high contention
>
> However, all the above points are currently being addressed:
> 1- by Mark's series to save argument registers only [6]
> 2- by Mark's series to call single ops directly [7]
> 3- by Masami's patch to skip rethooks if not needed [8]
> 4- Masami said the rethook freelist would be replaced by a per-task stack as
>    part of its unification with the function graph tracer [9]
>
> I measured the costs of BPF on different approaches on my RPi4 here: [10]
> tl;dr: the BPF "bench" takes a performance hit of:
> - 28.6% w/ BPF tracing on direct calls (best case scenario for reference) [11]
> - 66.8% w/ BPF on kprobe (just for reference)
> - 62.6% w/ BPF tracing on fprobe without any optimizations (current state) [12]
> - 34.1% w/ BPF tracing on fprobe with all optimizations (near-future state) [13]

Even with all optimization the performance overhead is not acceptable.
It feels to me that folks are still thinking about bpf trampoline
as a tracing facility.
It's a lot more than that. It needs to run 24/7 with zero overhead.
It needs to replace the kernel functions and be invoked
millions times a second until the system is rebooted.
In this environment every nanosecond counts.

Even if the fprobe side was completely free the patch 1 has so much
overhead in copy of bpf_cookie, regs, etc that it's a non-starter
for these use cases.

There are several other fundamental issues in this approach
because of fprobe/ftrace.
It has ftrace_test_recursion_trylock and disables preemption.
Both are deal breakers.

bpf trampoline has to allow recursion in some cases.
See __bpf_prog_enter*() flavors.

bpf trampoline also has to use migrate_disable instead of preemption
and rcu_read_lock() in some cases and rcu_read_lock_trace() in others.

bpf trampoline must never allocate memory or grab locks.

All of these mandatory features exclude fprobe, ftrace, rethook
from possible options.

Let's figure out how to address concerns with direct calls:

> - working around BL instruction's limited range introduces complexity [4]
> - it's difficult to get reliable stacktraces right with direct calls [5]
> - direct calls are complex to maintain on the arch/ftrace side [5]
