Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A637464A886
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 21:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiLLUMn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 15:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiLLUMQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 15:12:16 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16EB17E0D;
        Mon, 12 Dec 2022 12:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6mk69IYRuvnV5AJxQok3ai+88SShAxIoeDfYcokMLfI=; b=KQJRK//lvnsHX+IpBLq9HpY4GW
        0qjeI48lnXMdJswvzn5CSEh72thdtII+Y6IgnteG19uslCLq/Co4vPOEPlhT+2VEkun1X6WC2vVHm
        wUCOh9nNrr9GiWgGnv7TQ5QlXhZ19dOK/dya7STvLfC6VL0yC+TFaBzazhbOMrc0dKeuQ5BYcvblh
        nY+LIpJH6R+OsI4+GAE3ae/K3s4S+9lSkysQYTugosItuG4WpmKjqhAay0ey5h2AeMN5j8V49+LlI
        dbcL0wwyXsPYouSigC1s4VOv/yPEKyAuiuT3WN7uyNbL6CfCa+X+DJjmYNdQWVmU1Xi1qEdbLn04p
        KjPOWKnQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4p9E-009s4M-Rp; Mon, 12 Dec 2022 20:11:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5EA24300129;
        Mon, 12 Dec 2022 21:11:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4754820B600FF; Mon, 12 Dec 2022 21:11:36 +0100 (CET)
Date:   Mon, 12 Dec 2022 21:11:36 +0100
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
Subject: Re: [PATCH 05/31] sched: Add sched_class->reweight_task()
Message-ID: <Y5eK+DwksKRYmhMJ@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-6-tj@kernel.org>
 <Y5cPA2L/G2GiRP9X@hirez.programming.kicks-ass.net>
 <Y5dmI3uAl/kYR5nQ@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5dmI3uAl/kYR5nQ@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 07:34:27AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Dec 12, 2022 at 12:22:43PM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 29, 2022 at 10:22:47PM -1000, Tejun Heo wrote:
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index a4a20046e586..08799b2a566e 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -2193,6 +2193,8 @@ struct sched_class {
> > >  	 */
> > >  	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
> > >  	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
> > > +	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
> > > +			      int newprio);
> > >  	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
> > >  			      int oldprio);
> > 
> > Hurmph.. this further propagate the existing problem of thinking that
> > 'prio' is a useful concept in general (it isn't).
> 
> I'm not quite following. Can you please expand on why prio isn't a generally
> useful concept?

The whole fixed vs dynamic priority scheduling thing. Specifically
SCHED_DEADLINE implements a dynamic priority scheme using the sporadic
task model which just doesn't map well to this single prio value
(notably every SCHED_DEADLINE task has prio -1, making it impossible to
order SCHED_DEADLINE tasks based on this).
