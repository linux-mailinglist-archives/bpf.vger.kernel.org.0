Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16075BD3AD
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 19:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiISR2g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 13:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiISR2f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 13:28:35 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EB3222B0;
        Mon, 19 Sep 2022 10:28:34 -0700 (PDT)
Message-ID: <783eb0b0-adce-ba31-0b2a-dbc93ea86b23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663608512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mzsyDUbKLp8t5bBv48E8iUXBg//fLeG88S+gA9efcu4=;
        b=sM0T4N5jV0UHdyNcbNBPtxcn7iB2dRvR+bcUvCS7BmGnmZzYJysFPyXnanGP/yN7VwZP3u
        KsaVdTtlb46Z+cdinMBhy+b0sZOkYLVRMIfAAbxXnWEevI7Dy9gk4Fn8qPEpVPGUfTmYJh
        a8imSdrAu2/JeGc0HpLdLyLpGIZTcMc=
Date:   Mon, 19 Sep 2022 10:28:25 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf, cgroup: Don't populate
 prog_attach_flags array when effective query
Content-Language: en-US
To:     Pu Lehui <pulehui@huaweicloud.com>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pu Lehui <pulehui@huawei.com>
References: <20220914161742.3180731-1-pulehui@huaweicloud.com>
 <20220914161742.3180731-2-pulehui@huaweicloud.com>
 <9b66564e-2582-03b2-56f1-8037f8aca886@linux.dev>
 <037a6a32-5143-ddad-4a43-bd815280a0ef@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <037a6a32-5143-ddad-4a43-bd815280a0ef@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/19/22 6:32 AM, Pu Lehui wrote:
> 
> 
> On 2022/9/17 8:03, Martin KaFai Lau wrote:
>> On 9/14/22 9:17 AM, Pu Lehui wrote:
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> Attach flags is only valid for attached progs of this layer cgroup,
>>> but not for effective progs. For querying with EFFECTIVE flags,
>>> exporting attach flags does not make sense. so we don't need to
>>> populate prog_attach_flags array when effective query.
>>
>> prog_attach_flags has been added to 6.0 which is in rc5.  It is still 
>> doable (and cleaner) to reject prog_attach_flags when it is an 
>> effective_query.  This should be done regardless of 'type == 
>> BPF_LSM_CGROUP' or not.  Something like:
>>
>> if (effective_query && prog_attach_flags)
>>      return -EINVAL;
>>
>> Otherwise, the whole prog_attach_flags needs to be set to 0 during 
>> effective_query.  Please target the change to the bpf tree instead of 
>> bpf-next such that this uapi bit can be fixed before 6.0.
>>
> 
> Okay, will handle in next version.

Thanks.  It will also be useful to comment the uapi's bpf.h and mention
prog_attach_flags should not be set during effective_query.

> 
>> Also, the effective_query issue is not limited to the 
>> prog_attach_flags? For the older uattr->query.attach_flags, it should 
>> be set to 0 also when it is an effective_query, right?
> 
> For output uattr->query.attach_flags, we certainly don't need to copy it 
> to userspace when effective query. Since we do not utilize 
> uattr->query.attach_flags in the cgroup query function, should we need 
> to take it as input and reject when it is non-zero in effective query? 
> Something like:
> if (effective_query && (prog_attach_flags || attr->query.attach_flags))

No.  I don't think the zero attr->query.attach_flags can be enforced 
now.  It is used as an output value only and its input value has never 
been checked.  Although the bpftool always sets it to 0 before the 
query, checking zero now does not gain much while there is a slight 
chance of breaking other users.

Only need to set/output uattr->query.attach_flags as 0 during 
effective_query.

> 
> For both output and input scenarios, we are faced with the problem that 
> there is a ambiguity in attach_flags being 0. When we do not copy to the 
> userspace, libbpf will set it to 0 by default, and 0 can mean NONE flag 
> attach, or no attach prog. The same is true for input scenarios.
> 
> So should we need to define NONE attach flag and redefine the others? 
> Such as follow:
> #define BPF_F_ALLOW_NONE        (1U << 0)

I would not change the uapi for this.  0 implicitly means no flags or 
none.  Regardless, this change does not belong to the bpf tree where 
this fix will be landing.

> #define BPF_F_ALLOW_OVERRIDE    (1U << 1)
> #define BPF_F_ALLOW_MULTI       (1U << 2)
> #define BPF_F_REPLACE           (1U << 3)
> 
> And then attach flags being 0 certainly means no attach any prog.
> 

