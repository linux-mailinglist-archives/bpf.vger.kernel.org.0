Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579023802A7
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 06:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhENEHr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 May 2021 00:07:47 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34890 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231171AbhENEHo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 14 May 2021 00:07:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yunbo.xufeng@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UYof4N3_1620965189;
Received: from IT-C02XP11YJHD2.local(mailfrom:yunbo.xufeng@linux.alibaba.com fp:SMTPD_---0UYof4N3_1620965189)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 May 2021 12:06:30 +0800
Subject: Re: [RFC] [PATCH bpf-next 1/1] bpf: Add a BPF helper for getting the
 cgroup path of current task
To:     kpsingh@kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, revest@chromium.org,
        jackmanb@chromium.org, yhs@fb.com, songliubraving@fb.com,
        kafai@fb.com, john.fastabend@gmail.com, joe@cilium.io,
        quentin@isovalent.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20210512095823.99162-1-yunbo.xufeng@linux.alibaba.com>
 <20210512095823.99162-2-yunbo.xufeng@linux.alibaba.com>
 <20210512225504.3kt6ij4xqzbtyej5@ast-mbp.dhcp.thefacebook.com>
From:   xufeng zhang <yunbo.xufeng@linux.alibaba.com>
Message-ID: <1b6dfe61-29ed-5d4d-fa1f-1bd46a4f5860@linux.alibaba.com>
Date:   Fri, 14 May 2021 12:06:29 +0800
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


KP,

do you have any suggestion?

what I am thinking is the internal kernel object(cgroup id or ns.inum) 
is not so user friendly, we can get the container-context from them for 
tracing scenario, but not for LSM blocking cases, I'm not sure how 
Google internally resolve similar issue.


Thanks!

Xufeng

