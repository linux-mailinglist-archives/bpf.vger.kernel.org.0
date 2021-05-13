Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF12F37F487
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 10:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhEMI6e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 04:58:34 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:59664 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232234AbhEMI6d (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 May 2021 04:58:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yunbo.xufeng@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UYk7TrO_1620896240;
Received: from IT-C02XP11YJHD2.local(mailfrom:yunbo.xufeng@linux.alibaba.com fp:SMTPD_---0UYk7TrO_1620896240)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 May 2021 16:57:22 +0800
Subject: Re: [RFC] [PATCH bpf-next 1/1] bpf: Add a BPF helper for getting the
 cgroup path of current task
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     kpsingh@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, revest@chromium.org,
        jackmanb@chromium.org, yhs@fb.com, songliubraving@fb.com,
        kafai@fb.com, john.fastabend@gmail.com, joe@cilium.io,
        quentin@isovalent.com
References: <20210512095823.99162-1-yunbo.xufeng@linux.alibaba.com>
 <20210512095823.99162-2-yunbo.xufeng@linux.alibaba.com>
 <20210512225504.3kt6ij4xqzbtyej5@ast-mbp.dhcp.thefacebook.com>
From:   xufeng zhang <yunbo.xufeng@linux.alibaba.com>
Message-ID: <9ae7e503-8f49-a7a4-3e18-0288c7989484@linux.alibaba.com>
Date:   Thu, 13 May 2021 16:57:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210512225504.3kt6ij4xqzbtyej5@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ÔÚ 2021/5/13 ÉÏÎç6:55, Alexei Starovoitov Ð´µÀ:

> On Wed, May 12, 2021 at 05:58:23PM +0800, Xufeng Zhang wrote:
>> To implement security rules for application containers by utilizing
>> bpf LSM, the container to which the current running task belongs need
>> to be known in bpf context. Think about this scenario: kubernetes
>> schedules a pod into one host, before the application container can run,
>> the security rules for this application need to be loaded into bpf
>> maps firstly, so that LSM bpf programs can make decisions based on
>> this rule maps.
>>
>> However, there is no effective bpf helper to achieve this goal,
>> especially for cgroup v1. In the above case, the only available information
>> from user side is container-id, and the cgroup path for this container
>> is certain based on container-id, so in order to make a bridge between
>> user side and bpf programs, bpf programs also need to know the current
>> cgroup path of running task.
> ...
>> +#ifdef CONFIG_CGROUPS
>> +BPF_CALL_2(bpf_get_current_cpuset_cgroup_path, char *, buf, u32, buf_len)
>> +{
>> +	struct cgroup_subsys_state *css;
>> +	int retval;
>> +
>> +	css = task_get_css(current, cpuset_cgrp_id);
>> +	retval = cgroup_path_ns(css->cgroup, buf, buf_len, &init_cgroup_ns);
>> +	css_put(css);
>> +	if (retval >= buf_len)
>> +		retval = -ENAMETOOLONG;
> Manipulating string path to check the hierarchy will be difficult to do
> inside bpf prog. It seems to me this helper will be useful only for
> simplest cgroup setups where there is no additional cgroup nesting
> within containers.
> Have you looked at *ancestor_cgroup_id and *cgroup_id helpers?
> They're a bit more flexible when dealing with hierarchy and
> can be used to achieve the same correlation between kernel and user cgroup ids.


Thanks for your timely reply, Alexei!

Yes, this helper is not so common, it does not works for nesting cgroup 
within containers.

About your suggestion, the *cgroup_id helpers only works for cgroup v2, 
however, we're still using cgroup v1 in product£¬and even for cgroup v2, 
I'm not sure if there is any way for user space to get this cgroup id 
timely(after container created, but before container start to run)¡£

So if there is any effective way works for cgroup v1?


Many thanks!

Xufeng


