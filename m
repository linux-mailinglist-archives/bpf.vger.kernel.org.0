Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790BC649E52
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 13:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiLLMBD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 07:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiLLMBC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 07:01:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA376D41;
        Mon, 12 Dec 2022 04:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ff5rzn1x1a9IulOrFirS0vdxGOS+P3fKFHa6Fly2lnA=; b=i1niLlk+R2j6V1t3aRlRXAbUAa
        +IVCn8vhtSengmC7jXcVAZ+PfpNBpY/nKJ44aSr6ZYL2wiQ1OAGiiQNJC7vjNJmeNJxMwQCd8tZxn
        0+pT02JO4KgXeoCVfYNul91hXX61G0JoWuvOM+9/8q8LjMJfQO0ryXum1WpqxEAAtlGOSfMV8lgGk
        8z+Nva9S7YL+OgYG9FlZ6wuLzmIKPAZVs83o9ZRNAfTkd6wAQCXRvI3MZ14C/mXcaejqXbByV2Aqc
        QMlpSSXSxtRti8FoYIBNi4IRZNfOVcvK66PxQBwfCvszMLDkgFB6y1+ep/ID+FUCjFVKX0H2Z/gIY
        fkVTyyog==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4hU4-009ldt-KC; Mon, 12 Dec 2022 12:00:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF6BA300129;
        Mon, 12 Dec 2022 13:00:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99113209FB782; Mon, 12 Dec 2022 13:00:35 +0100 (CET)
Date:   Mon, 12 Dec 2022 13:00:35 +0100
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
Subject: Re: [PATCH 11/31] sched: Add @reason to sched_move_task()
Message-ID: <Y5cX45wE7Wn0FlkE@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-12-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-12-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 10:22:53PM -1000, Tejun Heo wrote:
> sched_move_task() can be called for both cgroup and autogroup moves. Add a
> parameter to distinguish the two cases. This will be used by a new
> sched_class to track cgroup migrations.

This all seems pointless, you can trivially distinguish a
cgroup/autogroup task_group if you so want (again for unspecified
raisins).
