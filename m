Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A661698E03
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 08:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBPHr1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 02:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBPHr0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 02:47:26 -0500
Received: from out-239.mta1.migadu.com (out-239.mta1.migadu.com [95.215.58.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD61B3D085
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 23:47:20 -0800 (PST)
Message-ID: <1232a3da-a58f-8cfb-b881-c049abadc203@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676533638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxHYczO7SNKQh0DoSP0lv1HbkL73XKakjcKSCpkdv6Y=;
        b=sOEUenTBaYzvNGIKHFvZm1SYk2ZyUu8rK+DvfV2Q1PDmdu4BZP5lC8NZ/1j9aaqu3VhKWe
        uhCB3i7Vio05F/qF0VSR8IGRdgjXOksYuSlBXtMw6KrFSgbDfq/SBPdSmYrlfcBliRtJKq
        09c2MxuznuSH61osWalzsHyZoWmFWp4=
Date:   Wed, 15 Feb 2023 23:47:03 -0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com>
 <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com>
 <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com>
 <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
 <20230210163258.phekigglpquitq33@apollo>
 <CAADnVQLVi7CcW9ci62Dps4mxCEqHOYvYJ-Fant-0kSy0vPZ3AA@mail.gmail.com>
 <bf936f22-f8b7-c4a3-41a1-c3f2f115e67a@huaweicloud.com>
 <CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com>
 <CAADnVQJzS9MQKS2EqrdxO7rVLyjUYD6OG-Yefak62-JRNcheZg@mail.gmail.com>
 <6d48c284-42eb-9688-4259-79b7f096e294@linux.dev>
 <7fef4ece-0982-cb43-ed39-e73791436355@huaweicloud.com>
 <2b1ddc4c-9905-899a-a903-e66a6e8b4d58@linux.dev>
 <5f22c315-ed38-b677-f36b-496d89847467@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <5f22c315-ed38-b677-f36b-496d89847467@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/15/23 6:11 PM, Hou Tao wrote:
>>>> For local storage, when its owner (sk/task/inode/cgrp) is going away, the
>>>> memory can be reused immediately. No rcu gp is needed.
>>> Now it seems it will wait for RCU GP and i think it is still necessary, because
>>> when the process exits, other processes may still access the local storage
>>> through pidfd or task_struct of the exited process.
>> When its owner (sk/task/cgrp...) is going away, its owner has reached refcnt 0
>> and will be kfree immediately next. eg. bpf_sk_storage_free is called just
>> before the sk is about to be kfree. No bpf prog should have a hold on this sk.
>> The same should go for the task.
> A bpf syscall may have already found the task local storage through a pidfd,
> then the target task exits and the local storage is free immediately, then bpf
> syscall starts to copy the local storage and there will be a UAF, right ? Did I
> missing something here ?
bpf syscall like bpf_pid_task_storage_lookup_elem and you meant 
__put_task_struct() will be called while the syscall's bpf_map_copy_value() is 
still under rcu_read_lock()?
