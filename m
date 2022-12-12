Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F9649EF7
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 13:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiLLMkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 07:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiLLMj6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 07:39:58 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50965BF8;
        Mon, 12 Dec 2022 04:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rLXBe+RoHHYl7BUjTTeJDA6gZEGVC+/pTWgMAlBA1S4=; b=J0AoCLpmjG6UMI8hnybVDquDR9
        CLP+X1/PN/aDhfMjCwCdizgYEgKoCY1dp1sWnD2eAknVSlVyjIgqa1SbMuSBKKSoblPQffDPexdMd
        OOFTBtBiY31IrPBprLvrcssDcQYiSoR69EmvTSP3VGc4nMhLUM8rtv0FaXNeLtGEm88Y5eAIJgBjV
        OuRWqN++SVdf6emWLHdHY11sKJSo6HKPMhDl1HJds6dvDaNvKECtqAGc4Uo15+cCFOYaDvcbihuK/
        Cy6qFHDfxp/riPbOrMzYNDctl+pvU3q0SQCwpnkKrgp/RlEoGWpKWVikOQTxU7xJxptJ0X9ntobV3
        A607eBZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4i5I-009mDa-Tx; Mon, 12 Dec 2022 12:39:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 637CD300299;
        Mon, 12 Dec 2022 13:39:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45CEA20248CFF; Mon, 12 Dec 2022 13:39:04 +0100 (CET)
Date:   Mon, 12 Dec 2022 13:39:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 28/31] sched_ext: Add
 Documentation/scheduler/sched-ext.rst
Message-ID: <Y5cg6FgDnYkVES0R@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-29-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-29-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 10:23:10PM -1000, Tejun Heo wrote:

If you expect me to read this, please as to provide something readable,
not markup gibberish.
