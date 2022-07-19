Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA2557AA63
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 01:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbiGSXVy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 19:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiGSXVv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 19:21:51 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD6A509C0;
        Tue, 19 Jul 2022 16:21:44 -0700 (PDT)
Date:   Tue, 19 Jul 2022 16:21:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658272902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=otC1tTkwE6VyOKni7sKSG3LnYp+1TQS+Z3cn/1v0m9s=;
        b=j6s0Z0QO0xQ76TiNRXJwxfXbcoQvlVDfcJqv5ru8r9pULc32wyjPkP1lkd+Qt2Ih8PqYVJ
        oG8+yhiUYoxFx9fHeTAt4SSHh3EIRzexhj+FcEUTHm/JJdBkS1A+HkQuW0z+Odl7LazgJv
        3vKva4+MhTzM9id5gYAACJoiFrGdbDc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
Message-ID: <Ytc8gX1S1yIsXVRh@castle>
References: <20210916162451.709260-1-guro@fb.com>
 <dedc7b72-9da4-91d0-d81d-75360c177188@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dedc7b72-9da4-91d0-d81d-75360c177188@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 09:17:24PM +0800, Ren Zhijie wrote:
> Hi Roman and list,
> 
> We want to implement a programmable scheduler to meet the schedule
> requirements of different workloads.
> 
> Using BPF, we can easily deploy schedule policies for specific workloads,
> quickly verifying without modifying the kernel code. This greatly reduces
> the cost of deploying new schedule policies in the production environment.
> 
> Therefore, we want to continue to develop based on your patch. We plan to
> merge it into the openeuler open-source community and use the community to
> continuously evolve and maintain it.
> (link: https://www.openeuler.org/en/)
> 
> We made some changes to your patch:
> 1. Adapt to the openeuler-OLK-5.10 branch, which mostly base on linux
> longterm branch 5.10.
> 2. Introduce the Kconfig CONFIG_BPF_SCHED to isolate related code at compile
> time.
> 3. helpers bpf_sched_entity_to_cgrpid() and
> bpf_sched_entity_belongs_to_cgrp() are modified to obtain the task group to
> which the sched entity belongs through se->my_q->tg->css.cgroup.
> 
> We have some ideas for the next iteration of Scheduler BPF that we would
> like to share with you:
> 1.The tag field is added to struct task_struct and struct task_group. Users
> can use the file system interface to mark different tags for specific
> workloads. The bpf prog obtains the tags to detect different workloads.
> 2.Add BPF hook and helper to scheduling processes such as select_task_rq and
> pick_next_task to enable scalability.
> 
> It's a new attempt, and there's bound to be a lot of problems later, but
> it's exciting that it makes the schduler programmable.

Hi Ren!

Great to hear my work is useful and thank you for describing your plans!
I'm not actively working on it right now, but I might start again in the future.
Let me know if I can help you with this effort.

Thanks!
