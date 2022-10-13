Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06985FD40E
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 07:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJMFHu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 01:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiJMFHt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 01:07:49 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42DB120058;
        Wed, 12 Oct 2022 22:07:47 -0700 (PDT)
Message-ID: <32d6ebed-c93b-f2eb-184a-47bd85b1ba7a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665637665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jg4DKh9v9tzEagToHZo51WNrcqay2yOdLXZ/s6JVt/I=;
        b=Y9Ozpad7IYKvceurjt3QgAd4SAQnxxm3Xg+m+lbK2kccu9SCo5SY0nG6oFy7lwBK22pfD6
        JD4ay+x1cSfsjpyreWxvez7hIzA3+vsRmVV675/DVOJwnVMV/rmMZyE+TCjRuxT4dV38JW
        D3LshYneiUpkac7WUwo54y1WLeZ6gQs=
Date:   Wed, 12 Oct 2022 22:07:40 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Free elements after one RCU-tasks-trace
 grace period
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Delyan Kratunov <delyank@fb.com>, rcu@vger.kernel.org,
        houtao1@huawei.com, paulmck@kernel.org
References: <20221011071128.3470622-1-houtao@huaweicloud.com>
 <20221011071128.3470622-2-houtao@huaweicloud.com>
 <20221011090742.GG4221@paulmck-ThinkPad-P17-Gen-1>
 <d91a9536-8ed2-fc00-733d-733de34af510@huaweicloud.com>
 <20221012063607.GM4221@paulmck-ThinkPad-P17-Gen-1>
 <b0ece7d9-ec48-0ecb-45d9-fb5cf973000b@huaweicloud.com>
 <20221012161103.GU4221@paulmck-ThinkPad-P17-Gen-1>
 <ca5f2973-e8b5-0d73-fd23-849f0dfc4347@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ca5f2973-e8b5-0d73-fd23-849f0dfc4347@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/12/22 6:25 PM, Hou Tao wrote:
>>>> Back to the polling API.  Are these things freed individually, or can
>>>> they be grouped?  If they can be grouped, the storage for the grace-period
>>>> state could be associated with the group.
>>> As said above, for bpf memory allocator it may be OK because it frees elements
>>> in batch, but for bpf local storage and its element these memories are freed
>>> individually. So I think if the implication of RCU tasks trace grace period will
>>> not be changed in the foreseeable future, adding rcu_trace_implies_rcu_gp() and
>>> using it in bpf is a good idea. What do you think ?
>> Maybe the BPF memory allocator does it one way and BPF local storage
>> does it another way.
> Why not. Maybe bpf expert think the space overhead is also reasonable in the BPF
> local storage case.

There is only 8 bytes hole left in 'struct bpf_local_storage_elem', so it is 
precious.  Put aside the space overhead, only deletion of a local storage 
requires call_rcu_tasks_trace().  The common use case for local storage is to 
alloc once and stay there for the whole life time of the sk/task/inode.  Thus, 
delete should happen very infrequent.

It will still be nice to optimize though if it does not need extra space and 
that seems possible from reading the thread.

