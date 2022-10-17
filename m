Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEB4601DA3
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 01:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJQXf7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 19:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiJQXfw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 19:35:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC5B7E825;
        Mon, 17 Oct 2022 16:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06357B81B81;
        Mon, 17 Oct 2022 23:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A542DC433D6;
        Mon, 17 Oct 2022 23:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666049747;
        bh=lip3Ur+ocrRvIW0I+VBZVLQI85o9HCxQxXC3Oent80Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCuPC8cnBqvtumPy6OqCj1yPCfD6fxnnwy0hYidc/HAPVAmJjoEhDf6RuGLK4S4Kf
         7W0ccFgTN7YXil4TbTeGtII7YAFIZw7ZQFXw4jwuXbyhkHzHZYRCoXhznfTj/uTM2T
         qF1yXG4y3k59p+EjoPSWJ1SGAnPDqxFgUuMoE2uxo52XFc1PfoT4bTXjZfsYpxQsrM
         5zLqK7zGXoaWO2usbm0+vrVY/UFEiIye0y9aE8XcRKgD+ho4lKYKcXwTokcnhQnVuq
         AF0vpn8XrHzjFiEph7iriI8eJHajTkCTLCdBfEV/HySRlhDhlCemGEYv6NQEMOM4YR
         17dZUSCC136xA==
From:   SeongJae Park <sj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>, olsajiri@gmail.com,
        bpf@vger.kernel.org, gor@linux.ibm.com, hca@linux.ibm.com,
        iii@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, peterz@infradead.org,
        svens@linux.ibm.com, tip-bot2@linutronix.de, tmricht@linux.ibm.com,
        x86@kernel.org
Subject: Re: [PATCH] bpf: fix sample_flags for bpf_perf_event_output
Date:   Mon, 17 Oct 2022 23:35:44 +0000
Message-Id: <20221017233544.1408-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAM9d7cj1cvg6JUp33qxew59qz1_4hEu8noa-E3oO9DXFHabGaw@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 17 Oct 2022 15:52:15 -0700 Namhyung Kim <namhyung@kernel.org> wrote:

> Hi SeongJae,
> 
> On Mon, Oct 17, 2022 at 12:27 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hello,
> >
> >
> > The commit that this patch is fixing[1] also causes yet another segfault for
> > 'perf-script' of tracepoint records.  For example:
> >
> >     $ sudo timeout 3 perf record -e exceptions:page_fault_user
> >     [ perf record: Woken up 1 times to write data ]
> >     [ perf record: Captured and wrote 0.228 MB perf.data (74 samples) ]
> >     $ sudo perf script
> >     Segmentation fault
> >
> > Reverting this patch and the original bug commit[1] fixes the issue.  I haven't
> > deep dive yet because I'm not familiar with this area.  Anybody has any idea
> > about this?
> >
> > [1] 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> 
> Sorry for the trouble.

No problem.

> I think you also need to apply the below:
> 
> https://lore.kernel.org/r/20221012143857.48198-1-james.clark@arm.com

Thank you for this nice answer.  I confirmed that this fixes my issue.


Thanks,
SJ

[...]
