Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09E03D71C7
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhG0JPj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 05:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbhG0JPi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 05:15:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B74C061757
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MLxsHq5q4tdMm4dpBUsp3q/JMAdbuU0PQf/d2lpTyK8=; b=XXd3qCx5tOqDlArw3wykpe40Ee
        GkruZ742rnb42ndECHwauU9PP5EM+hgKpsCAp2AkiRTuVdblMnPeV0QvYuceVO0tm61w8xomEbz5k
        2MeAuRASH4lEP7FbH2euJq4jwlQtbVm2g56xwcaxlkIZ4edvP1hPkvLTFrk7D60C1zB6KmzohrCJl
        ZSkWVPa9sHePET4suQM5N/pC8vlFJbIrmpXaztlJ7sKxPwRbI32puuYdhnBfNki0RDGS+QPY1HjCS
        Ffx6McRl6Rayr1bBpwntJYzsHsDc+hGen6MVzQ585hal044mxoQ+q2ClIfRspIumPaRtq5XIH4RZW
        8O3vNSDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8J8m-00Erkj-VN; Tue, 27 Jul 2021 09:13:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97ADE300279;
        Tue, 27 Jul 2021 11:12:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8950E2C8D506F; Tue, 27 Jul 2021 11:12:44 +0200 (CEST)
Date:   Tue, 27 Jul 2021 11:12:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 04/14] bpf: implement minimal BPF perf link
Message-ID: <YP/ODG1g0Z553x1I@hirez.programming.kicks-ass.net>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-5-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726161211.925206-5-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 26, 2021 at 09:12:01AM -0700, Andrii Nakryiko wrote:
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index ad413b382a3c..8ac92560d3a3 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -803,6 +803,9 @@ extern void ftrace_profile_free_filter(struct perf_event *event);
>  void perf_trace_buf_update(void *record, u16 type);
>  void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
>  
> +int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
> +void perf_event_free_bpf_prog(struct perf_event *event);
> +
>  void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
>  void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
>  void bpf_trace_run3(struct bpf_prog *prog, u64 arg1, u64 arg2,

Oh, I just noticed, is this the right header to put these in? Should
this not go into include/linux/perf_event.h ?
