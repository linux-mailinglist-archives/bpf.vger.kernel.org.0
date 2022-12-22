Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF88B654703
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 21:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLVUQX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 15:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLVUQW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 15:16:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD97BFD0E;
        Thu, 22 Dec 2022 12:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FrcMg1fD3WjaxmA4M6dJMmbvA17lnKLFY/uq8KDDT+g=; b=JPHlreIgXL0wZO7dhLYht3nCYz
        5IpoKptUalyJlRmMVn4MgrNXjBp7WhS695dhayJJ+eeoBt2/1/IYD1Ftle9GjGoC1b7X2JFyOZtnv
        z5LHSVRCP/1uK8N7BvJJHbZNyx8z90w+L6zFg3nA4NG3ngNsN1/gaYTdd5wvwCwhR0WqrpJdrebMH
        h0gXcp+GNC7pN4mF0yS5+wRS6uos/rIGxo+V8UNP85r2Fy66vDT3HuFqUrXkB1IpLvz8w88j0rwwV
        I/q+Dlrfw+06byLsRbo4/Kmsa+6WcXjUgz8BF5/PTRlvaE2YPYmHf6S5L2mxsZNRzEsx+R5DILwHE
        2GUnCDww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p8Rz3-00Dxfw-0w;
        Thu, 22 Dec 2022 20:16:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE25830006D;
        Thu, 22 Dec 2022 21:16:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCAE320165192; Thu, 22 Dec 2022 21:16:05 +0100 (CET)
Date:   Thu, 22 Dec 2022 21:16:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf/perf: Call perf_prepare_sample() before
 bpf_prog_run()
Message-ID: <Y6S7BcblAHO4nQTf@hirez.programming.kicks-ass.net>
References: <20221220220144.4016213-1-namhyung@kernel.org>
 <20221220220144.4016213-2-namhyung@kernel.org>
 <Y6RTy29ULXp8WJ/Q@hirez.programming.kicks-ass.net>
 <2d164a5f-2885-2a6e-581a-2673ca0b1b81@iogearbox.net>
 <CAM9d7cj=iuxhLndNMBMeff6Ayp2hLfdz+6CHsZL7g213aWbUYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj=iuxhLndNMBMeff6Ayp2hLfdz+6CHsZL7g213aWbUYQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 22, 2022 at 09:34:42AM -0800, Namhyung Kim wrote:

> Sorry about that.  Let me rephrase it like below:
> 
> With bpf_cast_to_kern_ctx(), BPF programs attached to a perf event
> can access perf sample data directly from the ctx. 

This is the bpf_prog_run() in bpf_overflow_handler(), right?

> But the perf sample
> data is not fully prepared at this point, and some fields can have invalid
> uninitialized values.  So it needs to call perf_prepare_sample() before
> calling the BPF overflow handler.

It never was, why is it a problem now?

> But just calling perf_prepare_sample() can be costly when the BPF

So you potentially call it twice now, how's that useful?

