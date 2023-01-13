Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0C6695B6
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 12:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbjAMLfp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 06:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbjAMLfI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 06:35:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03867FEF6;
        Fri, 13 Jan 2023 03:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3vRfHiLfrkhVRWh8Q836T2oAvikTr6SSM9QK64azLu0=; b=oCsjbMHx33bOAX4Tv4zwpoNCZ6
        ovcZmpwpYf3viEaCmWRW1NjHS5BElLNn1CYHwWZWXf3pTtgLXKIu8GwzSuaV09b6XBhOyrMKufQQk
        yRIRjZX3u8LpQjJInVH763XEP5XYL1JljGVBD3AkCYeY8uj2JsFHPaslEQQajitHyRv0M5HnahN+d
        yyXUqPZWC+AqB4hukGLV9YpXDWYQIG/8L2vMIStio0Ur1lLnUYE0bsCmJdgxVriPy/x5zg+ohZ/py
        nD83bKZoyz2MtKvMX5iEGtVOOxRCMKi/i4afyUhvUnmfmtSN+Ko8vy2tsG+dStL9dYZ9hWCbGfbnT
        CmC1ij5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGI7f-0062lE-Ma; Fri, 13 Jan 2023 11:21:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65E413001F7;
        Fri, 13 Jan 2023 12:21:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 564F62CCEBAD8; Fri, 13 Jan 2023 12:21:10 +0100 (CET)
Date:   Fri, 13 Jan 2023 12:21:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCHSET 0/8] perf/core: Prepare sample data for BPF
Message-ID: <Y8E+phvLQZ5+kSOq@hirez.programming.kicks-ass.net>
References: <20230112214015.1014857-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112214015.1014857-1-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 12, 2023 at 01:40:07PM -0800, Namhyung Kim wrote:

> Namhyung Kim (8):
>   perf/core: Save the dynamic parts of sample data size
>   perf/core: Add perf_sample_save_callchain() helper
>   perf/core: Add perf_sample_save_raw_data() helper
>   perf/core: Add perf_sample_save_brstack() helper
>   perf/core: Set data->sample_flags in perf_prepare_sample()
>   perf/core: Do not pass header for sample id init
>   perf/core: Introduce perf_prepare_header()
>   perf/core: Call perf_prepare_sample() before running BPF

Aside from a few small niggles, this looks really good, Thanks!
