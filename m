Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3CE649E4B
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 12:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiLLL6b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 06:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiLLL6L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 06:58:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38E5B7F3;
        Mon, 12 Dec 2022 03:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KyIsZ51iDgmhrosekEBIjWqvS8sH1sTZ+mHelYrb3wU=; b=ZIwrASXRJiafJbdwee42SjCxy6
        JZFXaNxvmjfZ3UOLMZhFjuC1VY+Cl3OHVD/5Kq9J4lKVExTdTULYwuKpeB74Ty3Qh/8AVaqZj0qma
        6ZvNLW5ci0e0zQMwXoSutT0jf38Lr/vPw5ZqMAsjuWlpJypf/0Bim9zJ1wHMZsy9GmJ+dQ0ztGhq2
        /Y4fN/Yw17aBGJ82cIiQyWqr8GxzZDIfhdmTgIj8lcR9esjPQRuLfVAU6dYaB85X7EKQV/i1b2qaF
        /jVVcOG/Zgxbme95pns1c2thDU475AuGRLY+rOQ9zS5T4OouFVvR7WNJkq/Ff/Lp6N45WEMwSYkfV
        cZQwDT1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4hRK-00B0Mq-3M; Mon, 12 Dec 2022 11:57:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7631300129;
        Mon, 12 Dec 2022 12:57:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC31B209FB782; Mon, 12 Dec 2022 12:57:36 +0100 (CET)
Date:   Mon, 12 Dec 2022 12:57:36 +0100
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
Subject: Re: [PATCH 10/31] sched: Add @reason to
 sched_class->rq_{on|off}line()
Message-ID: <Y5cXMMor2qZAj7Cw@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-11-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-11-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 10:22:52PM -1000, Tejun Heo wrote:
> ->rq_{on|off}line are called either during CPU hotplug or cpuset partition
> updates. Let's add an argument to distinguish the two cases. The argument
> will be used by a new sched_class to track CPU hotplug events.

Again, utter lack of why.
