Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2D764A866
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 21:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiLLUHu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 15:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiLLUHs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 15:07:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC86B481;
        Mon, 12 Dec 2022 12:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7OX40oMl+2p0PSAKXkt694b+bW8bTpeLgJV+mHSZIUs=; b=dFQGzO1916Z714Dhb2wNdbGoqu
        SI/CgC4B/9XauDFj0cSo9X4zc1bYQi5Rr9uDDYIJ0R2om3xh0hWaQ+oUHkoMA0dIpDIUNSjSxRz19
        ro/Iu2vsRE6/req/2QsAHcJdKnVRSV/bZhJeMZ4sIqpXneIymbOgyvgVJAp5KG14D+kAnpPRf3GI6
        qMzZ/2y08yEKG1gpJnDxdgVmm9om630vb5TAX3S99QXnrvaLbY4cIeL+0ENdldj8ow3AvNLs1oPpV
        KpVFdGiaLqfGlPtjycVDdw2J58zy9cp/pv+LZ35id/VOmoqYw/iikDw9Ess2mQmejMxdpkPa+GWex
        K1BLzedA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4p51-009rxz-SJ; Mon, 12 Dec 2022 20:07:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E9D4300209;
        Mon, 12 Dec 2022 21:07:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6CFA2DC2DA2F; Mon, 12 Dec 2022 21:07:11 +0100 (CET)
Date:   Mon, 12 Dec 2022 21:07:11 +0100
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
Subject: Re: [PATCH 04/31] sched: Allow sched_cgroup_fork() to fail and
 introduce sched_cancel_fork()
Message-ID: <Y5eJ75pH87c+ngmo@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-5-tj@kernel.org>
 <Y5cM24M4007WcPod@hirez.programming.kicks-ass.net>
 <Y5ds7G7qTmpAyaKU@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5ds7G7qTmpAyaKU@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 08:03:24AM -1000, Tejun Heo wrote:
> On Mon, Dec 12, 2022 at 12:13:31PM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 29, 2022 at 10:22:46PM -1000, Tejun Heo wrote:
> > > A new sched_clas needs a bit more control over forking. This patch makes the
> >                  ^
> >                  (insufficient s's)
> 
> Will update.
> 
> > > following changes:
> > > 
> > > * Add sched_cancel_fork() which is called if fork fails after sched_fork()
> > >   succeeds so that the preparation can be undone.
> > > 
> > > * Allow sched_cgroup_fork() to fail.
> > > 
> > > Neither is used yet and this patch shouldn't cause any behavior changes.
> > 
> > Fails to explain why this would be needed and why that would be a good
> > thing. IOW, total lack of justification.
> 
> This is because sched_ext calls out to BPF scheduler's prepare_enable()
> operation to prepare the task. The operation is allowed to fail (e.g. it
> might need to allocate something which can fail), so we need a way back back
> out of it.

sched_fork() can already fail; why isn't that a suitable location to do
what needs doing?
