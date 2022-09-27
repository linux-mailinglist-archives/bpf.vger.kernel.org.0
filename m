Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C7F5ECEE7
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 22:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiI0UrC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiI0Uqn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 16:46:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47357107DC1;
        Tue, 27 Sep 2022 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t9fdahaIlTbuuw4gBOVz0mj5oYRa25j90QOIBaBUK4Y=; b=SgH3Z9oJqaAY/hI4xOawkOVGMP
        Ql52FHE88nF6mcDoTmY7kX1ans4xJmdgvv8ZjV4sXUzjaVyNn1eow1p61IQXsNagqhyw8i11JFLd8
        8UE/+0Kdr+4nvvAPAxtxvzfbq5zvah+BeRqbyAOf4Bj8NXotes4+MCLR+QWHmsrv17FCwgxrMPbv5
        sjtVSMX+px2dteU7oIznrmBczdXBib+dAxX2uhsDFc2uoZkXr0NppfK9uxRZOdN/dBb2AdGJv7Kgo
        sdJjyuR3ya4wmhDBeSW0Y1w+3ezBtPB0vkivQ6tGKrfmU2kvOgWcSGAMED/F2x1G3f7Owi/ebYvUq
        83EtPP8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odHT4-00GNk8-15; Tue, 27 Sep 2022 20:46:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3CCB3001F3;
        Tue, 27 Sep 2022 22:46:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B02A82BE0F540; Tue, 27 Sep 2022 22:46:12 +0200 (CEST)
Date:   Tue, 27 Sep 2022 22:46:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH -tip] bpf: Check flags for branch stack in
 bpf_read_branch_records helper
Message-ID: <YzNhFKj7UoGcc5ky@hirez.programming.kicks-ass.net>
References: <20220927203259.590950-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927203259.590950-1-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 10:32:59PM +0200, Jiri Olsa wrote:
> Recent commit [1] changed branch stack data indication from
> br_stack pointer to sample_flags in perf_sample_data struct.
> 
> We need to check sample_flags for PERF_SAMPLE_BRANCH_STACK
> bit for valid branch stack data.
> 
> [1] a9a931e26668 ("perf: Use sample_flags for branch stack")
> 
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Fixes: a9a931e26668 ("perf: Use sample_flags for branch stack")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> NOTE sending on top of tip/master because [1] is not
>      merged in bpf-next/master yet

Shall I stick this in tip/perf/core right along with [1] then?
