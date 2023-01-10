Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0642663EAB
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 11:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjAJKyw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 05:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbjAJKyn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 05:54:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C296A0CC;
        Tue, 10 Jan 2023 02:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+CxPuu/YOesZjpFjc43Yr8TUplw7b4t5h16pQOaKCjo=; b=X7KwIBfvgdRjkU6LtUyJM8/evf
        EDUam0c/si4pbXyi9ad1Yq1JgBQ/ujLtlgSOjhquLsc/f0OyH34LygvJ0XyS65IOVSirAYyMBq5ev
        f4cL2SjF1KJiUPZRt9rm60eqD3CrkMzPr9FWaDVz+D+CrOmlO4IF3Pq9nciSQG+EmYaxbNfSH2I9m
        Nml1xkCALqHfAKG3dVtkSnwdKIgTyEW8iCBgaO9acSp+4M8+XXJZ/FZIAVJD6juUB3n7AOkwuyHvJ
        Bjzai2FHaPNOY7aDHFLkMe7FOn3K1gzvVabdphEAqQv9FyP9lKES/UVVEWWzShR6ZdYvGmfAOfcKa
        X8IqVc5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFCGv-0038nu-EB; Tue, 10 Jan 2023 10:54:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F8EA300033;
        Tue, 10 Jan 2023 11:54:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63B8E201ABB61; Tue, 10 Jan 2023 11:54:12 +0100 (CET)
Date:   Tue, 10 Jan 2023 11:54:12 +0100
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
Message-ID: <Y71D1FCzoGihMUv+@hirez.programming.kicks-ass.net>
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

> Looks good.  But I'm confused by the tip-bot2 messages saying it's
> merged.  Do you want me to work on it as a follow up?

Ingo and me talked past one another, I agreed with 1/3 and he applied
the whole series. Just talked to him again and he's just zapped these
last two patches.

Sorry for the confusion.
