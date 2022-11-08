Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3D1621ED3
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 23:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiKHWH2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 17:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKHWH1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 17:07:27 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB0559847
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 14:07:24 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so93849wmb.0
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 14:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZa2XsBC7LSTs3tg2Aekhd4AeoshIZpxVnZl6SEC4lk=;
        b=KxBQ4KUBSA33jXcR3gUddQwWIISKgRvrB4BVa64HjRHCGWzmit4A9fuj7o0bS0O32j
         CmvZ6prPCzADMDdPDl1qyf/nXRqvi9Ayg561y+JRo08oheNEq+pzV92L7gnMQPbKT2+B
         gGjE0IDl/8gAxB+fL4VPyLAq+KdUhcL1tkBXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZa2XsBC7LSTs3tg2Aekhd4AeoshIZpxVnZl6SEC4lk=;
        b=gDfUAYsPMnqTXLxd8UBfmTJJIatEggm59vETdS5Z5lAWZ2xuwGVM37RcfMny09RbL6
         gLybcuNM//qMWmxERcWnoAQpkR/79fwH61Qd4JQs9IXaD1sB9ReVddHOjL13tH09CS1o
         pmyby2pBn1YOdXexOCZVv7za23HUkGTfND1ILsHKvPRFsy8dnN6OChh0emtSnljlV4tE
         5HuArQr5spEV00z4EfDriAeBTBIdNBCpiXoZSt9T9ii+79UsdUyaljzi+JGRsRUOPkIo
         Uk3rwHS7lRhDugEoEqf6CRPQ2OGybYE6TKNfqR9Jgt5ar7fr06I+CscpigM79lPDf06p
         1dJg==
X-Gm-Message-State: ACrzQf3qUy3wqs2DvZQkDnKu80DbEohUzcfp+ziHvJOFYZ+dCXYdVK5V
        Rh2B3zXZ6rQgHcl1Iy9YJMHgwDiVCL/iSA==
X-Google-Smtp-Source: AMsMyM5pJq+k2FsxumM1/v0O/EpJeObWC2YCk8fWIOp9a76FfNHAaKBpgJmd4Nw45KOA7D3JTGizpQ==
X-Received: by 2002:a05:600c:3587:b0:3cf:9aab:ab4a with SMTP id p7-20020a05600c358700b003cf9aabab4amr16653350wmq.155.1667945242563;
        Tue, 08 Nov 2022 14:07:22 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:8b01:3c16:212f:91df])
        by smtp.gmail.com with ESMTPSA id bw9-20020a0560001f8900b00236c1f2cecesm14001004wrb.81.2022.11.08.14.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:07:21 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, markowsky@google.com,
        mark.rutland@arm.com, mhiramat@kernel.org, rostedt@goodmis.org,
        xukuohai@huawei.com, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [RFC 0/1] BPF tracing for arm64 using fprobe
Date:   Tue,  8 Nov 2022 23:06:50 +0100
Message-Id: <20221108220651.24492-1-revest@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

With this RFC, I'd like to revive the conversation between BPF, ARM and tracing
folks on what BPF tracing (fentry/fexit/fmod_ret) could/should look like on
arm64.

Current status of BPF tracing
=============================

On currently supported architectures (like x86), BPF tracing programs are
called from a JITted BPF trampoline, itself called from the ftrace patch site
thanks to the ftrace "direct call" API. (or from the end of the ftrace
trampoline if a ftrace ops is also tracing that function, but this is
transparent to BPF)

Thanks to Xu's work [1], we now have BPF trampolines on arm64 (these can be
used for struct ops programs already), but Xu's attempts at getting ftrace
direct calls support [2][3] on arm64 have been unsucessful so far so we still
do not support BPF tracing programs. This prompted me to try a different
approach. I'd like to collect feedback on it here.

Why not direct calls ?
======================

Mark and Steven have not been too keen on getting direct calls on arm64 because:
- working around BL instruction's limited range introduces complexity [4]
- it's difficult to get reliable stacktraces right with direct calls [5]
- direct calls are complex to maintain on the arch/ftrace side [5]

In the absence of ftrace direct calls support, BPF tracing programs would need
to be called from an ftrace ops instead. Note that the BPF callback signature
would have to be different, so we can't re-use trampolines (direct called
callbacks receive arguments in registers whereas ftrace ops callbacks receive
arguments in a struct ftrace_regs pointer)

Why fprobe ?
============

Ftrace ops per-se only expose an API to hook before a function. There are two
systems built on top of ftrace ops that also allow hooking the function exit:
fprobe (using rethook) and the function graph tracer. There are plans from
Masami and Steven to unify these two systems but, as they stand, only fprobe
gives enough flexibility to implement BPF tracing.

In order not to reinvent the wheel, if direct calls aren't available on the
arch, BPF could leverage fprobe to hook before and after the traced function.
Note that return hooking is implemented a bit differently than it is in BPF
trampolines. Instead of keeping arguments on a stack frame and calling the
traced function, rethook saves arguments in a memory pool and returns to the
traced function with a hijacked return pointer that will have its ret jump back
to the rethook trampoline.

What about performances ?
=========================

In its current state, a fprobe callback on arm64 is very expensive because:
1- the ftrace trampoline saves all registers (including many unnecessary ones)
2- it calls ftrace_ops_list_func which iterates over all ops and is very slow
3- the fprobe ops unconditionally hooks a rethook
4- rethook grabs memory from a freelist which is slow under high contention

However, all the above points are currently being addressed:
1- by Mark's series to save argument registers only [6]
2- by Mark's series to call single ops directly [7]
3- by Masami's patch to skip rethooks if not needed [8]
4- Masami said the rethook freelist would be replaced by a per-task stack as
   part of its unification with the function graph tracer [9]

I measured the costs of BPF on different approaches on my RPi4 here: [10]
tl;dr: the BPF "bench" takes a performance hit of:
- 28.6% w/ BPF tracing on direct calls (best case scenario for reference) [11]
- 66.8% w/ BPF on kprobe (just for reference)
- 62.6% w/ BPF tracing on fprobe without any optimizations (current state) [12]
- 34.1% w/ BPF tracing on fprobe with all optimizations (near-future state) [13]

On top of Mark's and Masami's existing and planned work, BPF tracing programs
called from a fprobe callback become much closer to the performances of direct
calls but there's still a hit. If we want to try optimizing even further, we
could potentially go even one step further by JITting the fprobe callbacks.
This would let us unroll the argument loop and use direct calls instead of
indirect calls. However this would introduce quite some complexity and I expect
the performance impact should be fairly minimal. (arm64 doesn't have repotlines
so it doesn't suffer too much from indirect calls anyway)

Two other performance discrepancies I can think of, that would stay anyway are:
1- the ftrace trampoline saves all argument registers while BPF trampolines can
   get away with only saving the number of arguments that are actually used by
   that function (thanks to BTF info), consequentially, we need to convert the
   ftrace_regs structure into a BPF "ctx" array which inevitably takes some
   cycles
2- When a fexit program is attached, going through the rethook trampoline means
   that we need to save argument registers a second time while BPF trampolines
   can just rely on arguments kept on the stack

How to apply this RFC ?
=======================

This RFC only brings up to discussion the eventual patch that would
touch the BPF subsystem because the ftrace and fprobe optimizations it
is built on are not as controversial and already on the way. However,
this patch is meant to apply on top of Mark's and Masami's work. If
you'd like to run this patch you can use my branch. [13]

Links
=====

1: https://lore.kernel.org/bpf/20220711144722.2100039-1-xukuohai@huawei.com/
2: https://lore.kernel.org/bpf/20220518131638.3401509-2-xukuohai@huawei.com/
3: https://lore.kernel.org/bpf/20220913162732.163631-1-xukuohai@huaweicloud.com/
4: https://lore.kernel.org/bpf/Yo4xb2w+FHhUtJNw@FVFF77S0Q05N/
5: https://lore.kernel.org/bpf/YzR5WSLux4mmFIXg@FVFF77S0Q05N/
6: https://lore.kernel.org/all/20221103170520.931305-1-mark.rutland@arm.com/
7: https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace/per-callsite-ops
8: https://lore.kernel.org/all/166792255429.919356.14116090269057513181.stgit@devnote3/T/#m9d43fbdc91f48b03d644be77ac18017963a08df5
9: https://lore.kernel.org/bpf/20221024220008.48780b0f58903afed2dc8d4a@kernel.org/
10: https://paste.debian.net/1260011/
11: https://github.com/FlorentRevest/linux/commits/bpf-direct-calls
12: https://github.com/FlorentRevest/linux/commits/bpf-fprobe-slow
13: https://github.com/FlorentRevest/linux/commits/bpf-fprobe-rfc

Florent Revest (1):
  bpf: Invoke tracing progs using fprobe on archs without direct call

 include/linux/bpf.h     |   5 ++
 kernel/bpf/trampoline.c | 120 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 121 insertions(+), 4 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

