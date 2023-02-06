Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8449B68C7BA
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 21:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBFUh2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 15:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjBFUh1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 15:37:27 -0500
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ED328D12
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 12:37:25 -0800 (PST)
Message-ID: <f2afdc22-a9c1-eaad-fab4-2ff61b409282@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675715839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6fFGsR8m8qzKjunW3zH95+0KifrcLp8HfHMFh9BcTaA=;
        b=ZR8Lzvy1QGHzyHrlt+PiEDtnf66ueJYRpcIEx+FmetDzRMgJhA8+UeHZ/6zyfuGZpNVcSY
        HIkhgG9xo4EPYC1pH3xzWFdeeCQK92WTfHNV6L3lAICkjAe4dblHPstNeSAdaSa4rVQN3o
        hiOcbHdA0L1L0csqFLA96bd/OBTR0TY=
Date:   Mon, 6 Feb 2023 12:37:14 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next] Add support for tracing programs in
 BPF_PROG_RUN
Content-Language: en-US
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     andrii@kernel.org, kpsingh@kernel.org, bpf@vger.kernel.org
References: <20230203182812.20657-1-grantseltzer@gmail.com>
 <6433db0e-5cc6-8acc-b92f-eb5e17f032d6@linux.dev>
 <CAO658oVRQTL8HfKFJ3X8zjYRLJCQWROjzyOcXeP=uVRML1UYOw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAO658oVRQTL8HfKFJ3X8zjYRLJCQWROjzyOcXeP=uVRML1UYOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/5/23 9:29 AM, Grant Seltzer Richman wrote:
> On Sat, Feb 4, 2023 at 1:58 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/3/23 10:28 AM, Grant Seltzer wrote:
>>> This patch changes the behavior of how BPF_PROG_RUN treats tracing
>>> (fentry/fexit) programs. Previously only a return value is injected
>>> but the actual program was not run.
>>
>> hmm... I don't understand this. The actual program is run by attaching to the
>> bpf_fentry_test{1,2,3...}. eg. The test in fentry_test.c
> 
> I'm not sure what you mean. Are you saying in order to use the
> BPF_PROG_RUN bpf syscall command the user must first attach to
> `bpf_fentry_test1` (or any 1-8), and then execute the BPF_PROG_RUN?

It is how the fentry/fexit/fmod_ret...BPF_PROG_TYPE_TRACIN_xxx prog is setup to 
run now in test_run. afaik, these tracing progs require the trampoline setup 
before calling the bpf prog, so don't understand how __bpf_prog_test_run_tracing 
will work safely.

A selftest will help how this will work without the traompline but may be first 
need to understand what it is trying to solve.
