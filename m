Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0BE5F7A68
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 17:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiJGPS6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 11:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGPS4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 11:18:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7986C102505;
        Fri,  7 Oct 2022 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UgVcldoi+wivatOko2lwfadSrfRsdo0FEX94U3R3f2Y=; b=aFxU2Gb8pIwZ/bliGhAjwBzqwR
        9oEcJISsa4wSoTUM/xVzGTdyGHZQIvhPKM3EZ025GQ/0ZjTLCnJkRCAuxdJij/m3v/jNry08fdp5l
        Sy484QqUXzXAyomlfAlOjn+sv3R4oz5whZ78CKOX7b/jcteaT3fyUseFOQi1M5LccEkkFvC67tC5M
        169iFIpGUY+eliue0dFknrsFYGFd7Uz7iGTQT9ZBJetJzLdckBhyzR9gWOEDUydW7KfgBTQdMyQwm
        Oz6VneeYFg5NMj3EgdBlfP1VYyGx4ISDwnzi52Lrw5pgOtFaUwYoE/4w1hBpEAgDwYc/n5l469hWy
        3DVW5ICA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogp7k-001xxe-PV; Fri, 07 Oct 2022 15:18:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91083300205;
        Fri,  7 Oct 2022 17:18:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7179C2C09A803; Fri,  7 Oct 2022 17:18:48 +0200 (CEST)
Date:   Fri, 7 Oct 2022 17:18:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Sumanth Korikkar <sumanthk@linux.ibm.com>, bpf@vger.kernel.org,
        gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        namhyung@kernel.org, svens@linux.ibm.com, tip-bot2@linutronix.de,
        tmricht@linux.ibm.com, x86@kernel.org
Subject: Re: [PATCH] bpf: fix sample_flags for bpf_perf_event_output
Message-ID: <Y0BDWK7cl83Fkwqz@hirez.programming.kicks-ass.net>
References: <Yz8lbkx3HYQpnvIB@krava>
 <20221007081327.1047552-1-sumanthk@linux.ibm.com>
 <Yz/1QNGfO39Y7dOJ@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz/1QNGfO39Y7dOJ@krava>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 07, 2022 at 11:45:36AM +0200, Jiri Olsa wrote:
> On Fri, Oct 07, 2022 at 10:13:27AM +0200, Sumanth Korikkar wrote:
> > * Raw data is also filled by bpf_perf_event_output.
> > * Add sample_flags to indicate raw data.
> > * This eliminates the segfaults as shown below:
> >   Run ./samples/bpf/trace_output
> >   BUG pid 9 cookie 1001000000004 sized 4
> >   BUG pid 9 cookie 1001000000004 sized 4
> >   BUG pid 9 cookie 1001000000004 sized 4
> >   Segmentation fault (core dumped)
> > 
> > Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Peter,
> I think this should go through your tree again?
> bpf-next/master does not have sample_flags merged yet

Yep can do. I'll line it up in perf/urgent (Ingo just send out
perf/core).
