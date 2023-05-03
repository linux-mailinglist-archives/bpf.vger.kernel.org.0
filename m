Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8916F60AE
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 23:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjECV5V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 17:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjECV5U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 17:57:20 -0400
Received: from out-53.mta1.migadu.com (out-53.mta1.migadu.com [IPv6:2001:41d0:203:375::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C607684
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 14:57:18 -0700 (PDT)
Message-ID: <0fc99af7-fa0d-c5c7-00c4-3f446a5ad77b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683151035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dyl4nQ5Zcy7LJgdc7f/Vc8TCj+DLWwtZNKua2voeAWs=;
        b=W8m+GEy6fO6Or4LjtGUNcfM6ynrHyZO+6JWrWcW1V+3MSa/AC56Gs7KXQMtkD/onmKdImm
        ixK6wAhzmSgcqD4/bnoWD58c+cF0w4Qm1exLvk+MoA/ehfbeIh6o3e4OAjKQjhV5bjl+sY
        BLGLj76GFeQqX9BdQZ6EJihYnAvkiWw=
Date:   Wed, 3 May 2023 14:57:03 -0700
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 3/6] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20230429101215.111262-1-houtao@huaweicloud.com>
 <20230429101215.111262-4-houtao@huaweicloud.com>
 <20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/3/23 11:48 AM, Alexei Starovoitov wrote:
> What it means that sleepable progs using hashmap will be able to avoid uaf with bpf_rcu_read_lock().
> Without explicit bpf_rcu_read_lock() it's still safe and equivalent to existing behavior of bpf_mem_alloc.
> (while your proposed BPF_MA_FREE_AFTER_RCU_GP flavor is not safe to use in hashtab with sleepable progs)
> 
> After that we can unconditionally remove rcu_head/call_rcu from bpf_cpumask and improve usability of bpf_obj_drop.
> Probably usage of bpf_mem_alloc in local storage can be simplified as well.
> Martin wdyt?

If the bpf prog always does a bpf_rcu_read_lock() before accessing the (e.g.) 
task local storage, it can remove the reuse_now conditions in the 
bpf_local_storage and directly call the bpf_mem_cache_free().

The only corner use case is when the bpf_prog or syscall does 
bpf_task_storage_delete() instead of having the task storage stays with the 
whole lifetime of the task_struct. Using REUSE_AFTER_RCU_GP will be a change of 
this uaf guarantee to the sleepable program but it is still safe because it is 
freed after tasks_trace gp. We could take this chance to align this behavior of 
the local storage map to the other bpf maps.

For BPF_MA_FREE_AFTER_RCU_GP, there are cases that the bpf local storage knows 
it can be freed without waiting tasks_trace gp. However, only task/cgroup 
storages are in bpf ma and I don't believe this optimization matter much for 
them. I would rather focus on the REUSE_AFTER_RCU_GP first.
