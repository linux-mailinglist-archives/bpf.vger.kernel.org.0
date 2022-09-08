Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1F5B2692
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 21:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIHTN7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 15:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIHTN5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 15:13:57 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B26FEE51E;
        Thu,  8 Sep 2022 12:13:55 -0700 (PDT)
Message-ID: <30cd1aa2-4dcf-d181-30d8-678377bf96c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662664433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fcjsre31INBVp/IVj9TsfTLSl4EYVGMrSoczkfDg8/g=;
        b=RQMBYV6PzyyXv9pu7VQxhNKE4Brl0Wi3VVhhghI9ubjd0G/twMX2U7Yuglf4hsS1h9Yj0J
        GMdNBmEHq6aNj3v9hRSbGdND0ikx2bRb5X+pJytfK1RJwmWC6Mr2UYNwrbD5bJK46baFuz
        hK9MO7BaDpctVRhfitPRPlDGaIxzD64=
Date:   Thu, 8 Sep 2022 12:13:50 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/2] Fix cgroup attach flags being assigned to
 effective progs
Content-Language: en-US
To:     sdf@google.com, Pu Lehui <pulehui@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
References: <20220908145304.3436139-1-pulehui@huaweicloud.com>
 <YxomJlABk3fzQ9bQ@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <YxomJlABk3fzQ9bQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/8/22 10:28 AM, sdf@google.com wrote:
> On 09/08, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
> 
>> When root-cgroup attach multi progs and sub-cgroup attach a
>> override prog, bpftool will display incorrectly for the attach
>> flags of the sub-cgroup’s effective progs:
> 
>> $ bpftool cgroup tree /sys/fs/cgroup effective
>> CgroupPath
>> ID       AttachType      AttachFlags     Name
>> /sys/fs/cgroup
>> 6        cgroup_sysctl   multi           sysctl_tcp_mem
>> 13       cgroup_sysctl   multi           sysctl_tcp_mem
>> /sys/fs/cgroup/cg1
>> 20       cgroup_sysctl   override        sysctl_tcp_mem
>> 6        cgroup_sysctl   override        sysctl_tcp_mem <- wrong
>> 13       cgroup_sysctl   override        sysctl_tcp_mem <- wrong
>> /sys/fs/cgroup/cg1/cg2
>> 20       cgroup_sysctl                   sysctl_tcp_mem
>> 6        cgroup_sysctl                   sysctl_tcp_mem
>> 13       cgroup_sysctl                   sysctl_tcp_mem
> 
>> For cg1, obviously, the attach flags of prog6 and prog13 can not be
>> OVERRIDE, and the attach flags of prog6 and prog13 is meaningless for
>> cg1. We only need to care the attach flags of prog which attached to
>> cg1, other progs attach flags should be omit. After these patches,
>> the above situation will show as bellow:
> 
>> $ bpftool cgroup tree /sys/fs/cgroup effective
>> CgroupPath
>> ID       AttachType      AttachFlags     Name
>> /sys/fs/cgroup
>> 6        cgroup_sysctl   multi           sysctl_tcp_mem
>> 13       cgroup_sysctl   multi           sysctl_tcp_mem
>> /sys/fs/cgroup/cg1
>> 20       cgroup_sysctl   override        sysctl_tcp_mem
>> 6        cgroup_sysctl                   sysctl_tcp_mem
>> 13       cgroup_sysctl                   sysctl_tcp_mem
>> /sys/fs/cgroup/cg1/cg2
>> 20       cgroup_sysctl                   sysctl_tcp_mem
>> 6        cgroup_sysctl                   sysctl_tcp_mem
>> 13       cgroup_sysctl                   sysctl_tcp_mem
> 
>> v2:
>> - Limit prog_cnt to avoid overflow. (John)
>> - Add more detail message.
> 
> John also raised a good question in v1: the flags don't seem to
> make sense when requesting effective list. So maybe not export them
> at all?
+1. not exporting them for 'effective' listing makes sense.

This seems to be the day one behavior instead of the recent 
prog_attach_flags changes? so bpf-next makes sense also.

