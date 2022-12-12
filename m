Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB5A649D80
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 12:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiLLLYG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 06:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiLLLXn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 06:23:43 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8984165AF;
        Mon, 12 Dec 2022 03:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xbySExnymeLiX0edbLV7dOAxg/fp4Y9NfVGS5yBeLhI=; b=JWLvZnmwGqaP0yM7/Vurx4X88q
        TrXmVgFe261C2vrYkJf5F48NeROkG2gn8AC7kD6WsXTz1vO5UFLW4PjPCOS1bwpB0CRrx672O09Dx
        bhXzy77mCHVDDClZrkdB56FP0UqqVVwvfBGGOoQWjTTOHEi1DI3FqDB0fjIN3uWEjpvBHXFu9VJiO
        HdCof7Um9iQiYOMvmB47OcclalmCzqsG6tCsh4Pnaqmf8pTs+9CmUrSAvYwbzngFz2pyNtvlS6AeD
        9cVvbWylgIbVwq+pWlOb10edI5HuCZrzM6SA51dmPzqDabKMhkqHf9ohVb7ov5Qd+02xvXVPh3I75
        9Nl4k0Pg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4gtR-009l9g-E6; Mon, 12 Dec 2022 11:22:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 360B3300129;
        Mon, 12 Dec 2022 12:22:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDFF4209FB782; Mon, 12 Dec 2022 12:22:43 +0100 (CET)
Date:   Mon, 12 Dec 2022 12:22:43 +0100
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
Message-ID: <Y5cPA2L/G2GiRP9X@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-6-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-6-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 10:22:47PM -1000, Tejun Heo wrote:
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a4a20046e586..08799b2a566e 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2193,6 +2193,8 @@ struct sched_class {
>  	 */
>  	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
>  	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
> +	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
> +			      int newprio);
>  	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
>  			      int oldprio);

Hurmph.. this further propagate the existing problem of thinking that
'prio' is a useful concept in general (it isn't).

Yeah, you're just following precedent here, but still :/
