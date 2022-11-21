Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2DE632B0C
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 18:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKURdH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 12:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKURdH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 12:33:07 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4958C32BBF;
        Mon, 21 Nov 2022 09:33:05 -0800 (PST)
Message-ID: <dea8c3c5-0739-58c1-9a88-b989878a9b8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669051983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RdaGUFIwqgYJ1a1MlNFyXVwoTxqKH9XFOWaFIlnHPVw=;
        b=hPLG4vy+O0NYjxFzJ1xi4D46DWsZudpl9UchWG/PIblW0BHrqn6Q1s8RHjFBS0UjOrVDL+
        83YcJLU88ZFKi1eeBKuPqJDXYpmSgdhJLR1v3Rpp5QGFQWeyh2oYjhRtyfUM/xmueNCvpW
        NcWH8CDolLUaLsj9rXkV7v2n8vJJKws=
Date:   Mon, 21 Nov 2022 09:32:56 -0800
MIME-Version: 1.0
Subject: Re: [PATCH] perf lock contention: Do not use BPF task local storage
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org, Blake Jones <blakejones@google.com>,
        Chris Li <chriscli@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
References: <20221118190109.1512674-1-namhyung@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221118190109.1512674-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/18/22 11:01 AM, Namhyung Kim wrote:
> It caused some troubles when a lock inside kmalloc is contended
> because task local storage would allocate memory using kmalloc.
> It'd create a recusion and even crash in my system.
> 
> There could be a couple of workarounds but I think the simplest
> one is to use a pre-allocated hash map.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

> We could fix the task local storage to use the safe BPF allocator,
> but it takes time so let's change this until it happens actually.

I also got another report on the kfree_rcu path.  I am also looking into this 
direction on using the BPF allocator.
