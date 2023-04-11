Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1A6DE01C
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjDKP44 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 11:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjDKP4z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 11:56:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CCA0E74;
        Tue, 11 Apr 2023 08:56:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB32D75;
        Tue, 11 Apr 2023 08:57:38 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.20.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994CF3F73F;
        Tue, 11 Apr 2023 08:56:51 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:56:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>, catalin.marinas@arm.com,
        will@kernel.org, rostedt@goodmis.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Subject: Re: [PATCH v6 0/5] Add ftrace direct call for arm64
Message-ID: <ZDWDPUY2tZiMbk8V@FVFF77S0Q05N>
References: <20230405180250.2046566-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405180250.2046566-1-revest@chromium.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 05, 2023 at 08:02:45PM +0200, Florent Revest wrote:
> This series adds ftrace direct call support to arm64.
> This makes BPF tracing programs (fentry/fexit/fmod_ret/lsm) work on arm64.
> 
> It is meant to be taken by the arm64 tree but it depends on the
> trace-direct-v6.3-rc3 tag of the linux-trace tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> That tag was created by Steven Rostedt so the arm64 tree can pull the prior work
> this depends on. [1]

Catalin, Will, are you happy to pick this via the arm64 tree, or for it to go
via the trace tree?

We'd been assuming the former, but it looks like there'll be a (simple) merge
conflict with the series adding FUNCTION_GRAPH_RETVAL:

  https://lore.kernel.org/lkml/cover.1680954589.git.pengdonglin@sangfor.com.cn/

... as both series add some definitions to arm64's asm-offsets.c in the same
place, and all those additions need to be kept. Other than that, the two series
are independent.

IIUC Steve was hoping to take the FUNCTION_GRAPH_RETVAL series through the
trace tree, and if that's still the plan, maybe both should go that way?

Mark.

> Thanks to the ftrace refactoring under that tag, an ftrace_ops backing a ftrace
> direct call will only ever point to *one* direct call. This means we can look up
> the direct called trampoline address stored in the ops from the ftrace_caller
> trampoline in the case when the destination would be out of reach of a BL
> instruction at the ftrace callsite. This fixes limitations of previous attempts
> such as [2].
> 
> This series has been tested on arm64 with:
> 1- CONFIG_FTRACE_SELFTEST
> 2- samples/ftrace/*.ko (cf: patch 4)
> 3- tools/testing/selftests/bpf/test_progs (cf: patch 5)
> 
> Changes since v5 [3]:
> - Fixed saving the fourth argument of handle_mm_fault in both the x86 (patch 3)
>   and arm64 (as part of patch 4) "ftrace-direct-too" sample trampolines
> - Fixed the address of the traced function logged by some direct call samples
>   (ftrace-direct-multi and ftrace-direct-multi-modify) by moving lr into x0
> 
> 1: https://lore.kernel.org/all/ZB2Nl7fzpHoq5V20@FVFF77S0Q05N/
> 2: https://lore.kernel.org/all/20220913162732.163631-1-xukuohai@huaweicloud.com/
> 3: https://lore.kernel.org/bpf/20230403113552.2857693-1-revest@chromium.org/
> 
> Florent Revest (5):
>   arm64: ftrace: Add direct call support
>   arm64: ftrace: Simplify get_ftrace_plt
>   samples: ftrace: Save required argument registers in sample
>     trampolines
>   arm64: ftrace: Add direct call trampoline samples support
>   selftests/bpf: Update the tests deny list on aarch64
> 
>  arch/arm64/Kconfig                           |  6 ++
>  arch/arm64/include/asm/ftrace.h              | 22 +++++
>  arch/arm64/kernel/asm-offsets.c              |  6 ++
>  arch/arm64/kernel/entry-ftrace.S             | 90 ++++++++++++++++----
>  arch/arm64/kernel/ftrace.c                   | 46 +++++++---
>  samples/ftrace/ftrace-direct-modify.c        | 34 ++++++++
>  samples/ftrace/ftrace-direct-multi-modify.c  | 40 +++++++++
>  samples/ftrace/ftrace-direct-multi.c         | 24 ++++++
>  samples/ftrace/ftrace-direct-too.c           | 40 +++++++--
>  samples/ftrace/ftrace-direct.c               | 24 ++++++
>  tools/testing/selftests/bpf/DENYLIST.aarch64 | 82 ++----------------
>  11 files changed, 306 insertions(+), 108 deletions(-)
> 
> -- 
> 2.40.0.577.gac1e443424-goog
> 
