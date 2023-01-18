Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38AC671A9B
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 12:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjARLbI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 06:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjARLas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 06:30:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C2637B7E;
        Wed, 18 Jan 2023 02:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QEjwjk7nYkF7C1b0ySKce0lxosAVpdDVB2lq1DmXAnM=; b=CSDAGEt7u8PgJj1YdvqY1s4UcQ
        eU1z0IhtXGm3YRc8hvmx3oVUS+yIG/+cceJTwNs1ZkRCO9av5whDTjPVgAJ0C6mYzfwSQd6MuSO2x
        8mWlYprGcjlxxrMVkyvQd+3EankpNkqXYImnzDuBvC6oi6/5bVUDOgJer3ozjg63ltEO8fSJNimHF
        XJ/atO0/uWew6kbo++peb9H99xO3pxHC99r49GYgGKywwfNWXl9+aNzR2zRZUkfTirMf0TReCXJL8
        Gc7KGbKYVzDsJ9wG1gu0ZClsGXquNXZi/0jQqFGuLs9FyZRPaf/RMn4Z8ICG0wXZPs5iMyS39oDRK
        D+Ec217g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI61x-00Aabq-61; Wed, 18 Jan 2023 10:50:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C0153005C9;
        Wed, 18 Jan 2023 11:50:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0621E20A60F37; Wed, 18 Jan 2023 11:50:38 +0100 (CET)
Date:   Wed, 18 Jan 2023 11:50:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCHSET 0/8] perf/core: Prepare sample data for BPF (v3)
Message-ID: <Y8fO/Tro6wstoAeo@hirez.programming.kicks-ass.net>
References: <20230118060559.615653-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118060559.615653-1-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 10:05:51PM -0800, Namhyung Kim wrote:
> Namhyung Kim (8):
>   perf/core: Save the dynamic parts of sample data size
>   perf/core: Add perf_sample_save_callchain() helper
>   perf/core: Add perf_sample_save_raw_data() helper
>   perf/core: Add perf_sample_save_brstack() helper
>   perf/core: Set data->sample_flags in perf_prepare_sample()
>   perf/core: Do not pass header for sample id init
>   perf/core: Introduce perf_prepare_header()
>   perf/core: Call perf_prepare_sample() before running BPF

Thanks!,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
