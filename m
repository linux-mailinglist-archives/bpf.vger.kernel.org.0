Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A88687ADE
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 11:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjBBKwH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 05:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjBBKwD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 05:52:03 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAEC8A7EA;
        Thu,  2 Feb 2023 02:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Z9tFqTf2Ygy2QKomIll6AMhCHGv+ELQEI5/5r7xbC98=; b=B7BCJJTSa/NJ20xZKC4ZGqFelI
        hh0+teQkrP82TPAepMGQtXBKSjSPAemWCh1aSnHNq0X0y4UaIn9iah2oOAxc1TOM2Excq27JpmOCa
        NNPSEkUB2cLwst1l3kYB/v2kMN9MWj0zrEZOaAV5FRxomHpUweq8IM6+qzhLPANSbjTGWfRzV+z2u
        8OkiMKuBTSqxWjqJ3j4jX8t2jILK1iUkwtgDlUrO6apJKSfr6k/MGZpdZqtCfLBPQNSnAwRu2uoUg
        +towGE9bBCbv2LxMS9tWJrzgs9Y4xdTbZe0M0wrclnj6KEIGG8XI80LbjHd1i3j5wiA7okmjr6ClC
        6RuAx+3g==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pNXAg-000EyE-56; Thu, 02 Feb 2023 11:50:26 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pNXAf-000O2J-Ci; Thu, 02 Feb 2023 11:50:25 +0100
Subject: Re: [PATCH 0/8] Add ftrace direct call for arm64
To:     Xu Kuohai <xukuohai@huawei.com>,
        Florent Revest <revest@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com
References: <20230201163420.1579014-1-revest@chromium.org>
 <85af713d-00fe-b113-1331-1a44480c016f@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <eacfbd23-da92-3572-7f57-3de425117c8a@iogearbox.net>
Date:   Thu, 2 Feb 2023 11:50:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <85af713d-00fe-b113-1331-1a44480c016f@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26800/Thu Feb  2 09:47:56 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/2/23 9:36 AM, Xu Kuohai wrote:
> On 2/2/2023 12:34 AM, Florent Revest wrote:
>> This series adds ftrace direct call support to arm64.
>> This makes BPF tracing programs (fentry/fexit/fmod_ret/lsm) work on arm64.
>>
>> It is meant to apply on top of the arm64 tree which contains Mark Rutland's
>> series on CALL_OPS [1] under the for-next/ftrace tag.
>> > The first three patches consolidate the two existing ftrace APIs for registering
>> direct calls. They are split to make the reviewers lives easier but if it'd be a
>> preferred style, I'd be happy to squash them in the next revision.
>> Currently, there is both a _ftrace_direct and _ftrace_direct_multi API. Apart
>> from samples and selftests, there are no users of the _ftrace_direct API left
>> in-tree so this deletes it and renames the _ftrace_direct_multi API to
>> _ftrace_direct for simplicity.
>>
>> The main benefit of this refactoring is that, with the API that's left, an
>> ftrace_ops backing a direct call will only ever point to one direct call. We can
>> therefore store the direct called trampoline address in the ops (patch 4) and
>> look it up from the ftrace trampoline on arm64 (patch 7) in the case when the
>> destination would be out of reach of a BL instruction at the ftrace callsite.
>> (in this case, ftrace_caller acts as a lightweight intermediary trampoline)
>>
>> This series has been tested on both arm64 and x86_64 with:
>> 1- CONFIG_FTRACE_SELFTEST (cf: patch 6)
>> 2- samples/ftrace/*.ko (cf: patch 8)
>> 3- tools/testing/selftests/bpf/test_progs (both -t lsm and -t fentry_fexit)

Thanks a ton for working on this!

> so it's time to update DENYLIST.aarch64 to unblock tests that failed due to lack of direct call.

+1, with regards to logistics, if possible it might be nice to eventually gets
this into a feature branch on arm64 tree, then we could pull it too from there
for bpf-next and hash out the BPF CI bits for arm64 in the meantime.

>> This follows up on prior art by Xu Kuohai [2].
>> The implementation here is totally different but the fix for ftrace selftests
>> (patch 6) is a trivial rebase of a patch originally by Xu so I kept his
>> authorship and trailers untouched on that patch, I hope that's ok. >
> 
> that's ok for me, thanks.
> 
>> 1: https://lore.kernel.org/all/20230123134603.1064407-1-mark.rutland@arm.com/
>> 2: https://lore.kernel.org/bpf/20220913162732.163631-1-xukuohai@huaweicloud.com/
>>
>> Florent Revest (7):
>>    ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
>>    ftrace: Remove the legacy _ftrace_direct API
>>    ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
>>    ftrace: Store direct called addresses in their ops
>>    ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
>>    arm64: ftrace: Add direct call support
>>    arm64: ftrace: Add direct called trampoline samples support
>>
>> Xu Kuohai (1):
>>    ftrace: Fix dead loop caused by direct call in ftrace selftest
>>
>>   arch/arm64/Kconfig                          |   4 +
>>   arch/arm64/include/asm/ftrace.h             |  24 ++
>>   arch/arm64/kernel/asm-offsets.c             |   6 +
>>   arch/arm64/kernel/entry-ftrace.S            |  70 +++-
>>   arch/arm64/kernel/ftrace.c                  |  36 +-
>>   include/linux/ftrace.h                      |  51 +--
>>   kernel/bpf/trampoline.c                     |  14 +-
>>   kernel/trace/Kconfig                        |   2 +-
>>   kernel/trace/ftrace.c                       | 433 +-------------------
>>   kernel/trace/trace_selftest.c               |  14 +-
>>   samples/Kconfig                             |   2 +-
>>   samples/ftrace/ftrace-direct-modify.c       |  41 +-
>>   samples/ftrace/ftrace-direct-multi-modify.c |  44 +-
>>   samples/ftrace/ftrace-direct-multi.c        |  28 +-
>>   samples/ftrace/ftrace-direct-too.c          |  35 +-
>>   samples/ftrace/ftrace-direct.c              |  33 +-
>>   16 files changed, 333 insertions(+), 504 deletions(-)
>>
> 

