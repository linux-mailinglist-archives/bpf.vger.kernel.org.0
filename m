Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8E76877A6
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 09:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjBBIhQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 03:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBBIhP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 03:37:15 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C288766ED4;
        Thu,  2 Feb 2023 00:36:46 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P6sZg1zLqzfZ9N;
        Thu,  2 Feb 2023 16:36:27 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 2 Feb 2023 16:36:37 +0800
Message-ID: <85af713d-00fe-b113-1331-1a44480c016f@huawei.com>
Date:   Thu, 2 Feb 2023 16:36:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/8] Add ftrace direct call for arm64
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mark.rutland@arm.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kpsingh@kernel.org>, <jolsa@kernel.org>,
        <xukuohai@huaweicloud.com>
References: <20230201163420.1579014-1-revest@chromium.org>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <20230201163420.1579014-1-revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/2/2023 12:34 AM, Florent Revest wrote:
> This series adds ftrace direct call support to arm64.
> This makes BPF tracing programs (fentry/fexit/fmod_ret/lsm) work on arm64.
> 
> It is meant to apply on top of the arm64 tree which contains Mark Rutland's
> series on CALL_OPS [1] under the for-next/ftrace tag.
> > The first three patches consolidate the two existing ftrace APIs for registering
> direct calls. They are split to make the reviewers lives easier but if it'd be a
> preferred style, I'd be happy to squash them in the next revision.
> Currently, there is both a _ftrace_direct and _ftrace_direct_multi API. Apart
> from samples and selftests, there are no users of the _ftrace_direct API left
> in-tree so this deletes it and renames the _ftrace_direct_multi API to
> _ftrace_direct for simplicity.
> 
> The main benefit of this refactoring is that, with the API that's left, an
> ftrace_ops backing a direct call will only ever point to one direct call. We can
> therefore store the direct called trampoline address in the ops (patch 4) and
> look it up from the ftrace trampoline on arm64 (patch 7) in the case when the
> destination would be out of reach of a BL instruction at the ftrace callsite.
> (in this case, ftrace_caller acts as a lightweight intermediary trampoline)
> 
> This series has been tested on both arm64 and x86_64 with:
> 1- CONFIG_FTRACE_SELFTEST (cf: patch 6)
> 2- samples/ftrace/*.ko (cf: patch 8)
> 3- tools/testing/selftests/bpf/test_progs (both -t lsm and -t fentry_fexit)

so it's time to update DENYLIST.aarch64 to unblock tests that failed due to lack of direct call.

> 
> This follows up on prior art by Xu Kuohai [2].
> The implementation here is totally different but the fix for ftrace selftests
> (patch 6) is a trivial rebase of a patch originally by Xu so I kept his
> authorship and trailers untouched on that patch, I hope that's ok. >

that's ok for me, thanks.

> 1: https://lore.kernel.org/all/20230123134603.1064407-1-mark.rutland@arm.com/
> 2: https://lore.kernel.org/bpf/20220913162732.163631-1-xukuohai@huaweicloud.com/
> 
> Florent Revest (7):
>    ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
>    ftrace: Remove the legacy _ftrace_direct API
>    ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
>    ftrace: Store direct called addresses in their ops
>    ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
>    arm64: ftrace: Add direct call support
>    arm64: ftrace: Add direct called trampoline samples support
> 
> Xu Kuohai (1):
>    ftrace: Fix dead loop caused by direct call in ftrace selftest
> 
>   arch/arm64/Kconfig                          |   4 +
>   arch/arm64/include/asm/ftrace.h             |  24 ++
>   arch/arm64/kernel/asm-offsets.c             |   6 +
>   arch/arm64/kernel/entry-ftrace.S            |  70 +++-
>   arch/arm64/kernel/ftrace.c                  |  36 +-
>   include/linux/ftrace.h                      |  51 +--
>   kernel/bpf/trampoline.c                     |  14 +-
>   kernel/trace/Kconfig                        |   2 +-
>   kernel/trace/ftrace.c                       | 433 +-------------------
>   kernel/trace/trace_selftest.c               |  14 +-
>   samples/Kconfig                             |   2 +-
>   samples/ftrace/ftrace-direct-modify.c       |  41 +-
>   samples/ftrace/ftrace-direct-multi-modify.c |  44 +-
>   samples/ftrace/ftrace-direct-multi.c        |  28 +-
>   samples/ftrace/ftrace-direct-too.c          |  35 +-
>   samples/ftrace/ftrace-direct.c              |  33 +-
>   16 files changed, 333 insertions(+), 504 deletions(-)
> 

