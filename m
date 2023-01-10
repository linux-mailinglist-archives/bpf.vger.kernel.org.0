Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C15663EBE
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 11:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbjAJK4l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 05:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbjAJK4j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 05:56:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28556202;
        Tue, 10 Jan 2023 02:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TogT4Ztt7q4ZysT3AFT1rk+GzjsAIPFhnae9QZmezhE=; b=M3Inx9zClV1a15sUXMSqSUMu3O
        J1u+fjbAfKS21OB5+BUgZJHTEbcHslZOtgu8/gDjg95ya69gg6tiYKTPyuD2nOE5JO6t5UdvUgOGb
        XqPjVQUfVFx3Cc5okP5rKUPXw/u80kOOCQGNCIYza7owNnn1n3tF0XUAa0HjQ+vWziDVlIiQBjVit
        ketlZHqRI3IR+XItjANwuMlqlidEOzYf71uUGeU4dy0s2aVAJMXlqY27piyFDB3NP5khQq51YAiag
        ggBDL8Y7wkV+HsDCmGjHm22DgUZMuJbFeoV3faJeGYWUKuXgMB4iYcVX3ZYWkcf05oQf8Am0UqgbO
        UKKuIiYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pFCI2-0036Y5-2Q;
        Tue, 10 Jan 2023 10:55:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC470300033;
        Tue, 10 Jan 2023 11:55:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD839201ABB68; Tue, 10 Jan 2023 11:55:41 +0100 (CET)
Date:   Tue, 10 Jan 2023 11:55:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 2/3] perf/core: Set data->sample_flags in
 perf_prepare_sample()
Message-ID: <Y71ELS9GTz0hqaUt@hirez.programming.kicks-ass.net>
References: <20221229204101.1099430-1-namhyung@kernel.org>
 <20221229204101.1099430-2-namhyung@kernel.org>
 <Y7wFJ+NF0NwnmzLa@hirez.programming.kicks-ass.net>
 <Y7x3RUd67smv3EFQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7x3RUd67smv3EFQ@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 09, 2023 at 12:21:25PM -0800, Namhyung Kim wrote:

> > However; inspired by your next patch; we can do something like so:
> > 
> > 	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN) {
> > 		data->callchain = perf_callchain(event, regs);
> > 		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> > 
> > 		data->size += (1 + data->callchain->nr) * sizeof(u64);
> > 	}
> 
> This is fine as long as all other places (like in PMU drivers) set the
> callchain update the sample data size accordingly.  If not, we can get
> the callchain but the data size will be wrong.

Good point, maybe add a helper there to ensure that code doesn't
duplicate/diverge?
