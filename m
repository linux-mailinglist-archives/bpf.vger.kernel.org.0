Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8B57A05A
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiGSOFG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 10:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGSOEq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 10:04:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8C1474D2;
        Tue, 19 Jul 2022 06:17:27 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LnK8J2QhVzlVlM;
        Tue, 19 Jul 2022 21:15:44 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 21:17:25 +0800
Received: from [127.0.0.1] (10.67.111.83) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 21:17:25 +0800
Message-ID: <dedc7b72-9da4-91d0-d81d-75360c177188@huawei.com>
Date:   Tue, 19 Jul 2022 21:17:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     <roman.gushchin@linux.dev>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mgorman@techsingularity.net>, <mingo@redhat.com>,
        <peterz@infradead.org>
References: <20210916162451.709260-1-guro@fb.com>
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <20210916162451.709260-1-guro@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Roman and list,

We want to implement a programmable scheduler to meet the schedule 
requirements of different workloads.

Using BPF, we can easily deploy schedule policies for specific 
workloads, quickly verifying without modifying the kernel code. This 
greatly reduces the cost of deploying new schedule policies in the 
production environment.

Therefore, we want to continue to develop based on your patch. We plan 
to merge it into the openeuler open-source community and use the 
community to continuously evolve and maintain it.
(link: https://www.openeuler.org/en/)

We made some changes to your patch:
1. Adapt to the openeuler-OLK-5.10 branch, which mostly base on linux 
longterm branch 5.10.
2. Introduce the Kconfig CONFIG_BPF_SCHED to isolate related code at 
compile time.
3. helpers bpf_sched_entity_to_cgrpid() and 
bpf_sched_entity_belongs_to_cgrp() are modified to obtain the task group 
to which the sched entity belongs through se->my_q->tg->css.cgroup.

We have some ideas for the next iteration of Scheduler BPF that we would 
like to share with you:
1.The tag field is added to struct task_struct and struct task_group. 
Users can use the file system interface to mark different tags for 
specific workloads. The bpf prog obtains the tags to detect different 
workloads.
2.Add BPF hook and helper to scheduling processes such as select_task_rq 
and pick_next_task to enable scalability.

It's a new attempt, and there's bound to be a lot of problems later, but 
it's exciting that it makes the schduler programmable.

cheers,
Ren Zhijie


