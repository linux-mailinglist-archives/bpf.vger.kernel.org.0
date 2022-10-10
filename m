Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81235FA372
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJJSiv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJJSis (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 14:38:48 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC320BC0;
        Mon, 10 Oct 2022 11:38:45 -0700 (PDT)
Message-ID: <5abb2728-9867-175c-911c-b0bb49b8babd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665427124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHdiqyG3BWXzGNzYiF3krt4RSxlAbZJRHoGUGlRi33w=;
        b=Pbl/phZMAxbfSzN7ZHLhKAPyeJRqMXF+MJCvm3o6OZP+N/vev3LEPRv6/Ie5WjL4yB8qEP
        OO5rQr34cQXqw9IHVV2D2WnUH2SZxnH3GrQ041hY/VNyIycO+jmzvVvAog4O8RrHqI0qT7
        IC64HXIrvIVUPhyIHXvuiy3AZYRvnD8=
Date:   Mon, 10 Oct 2022 11:38:39 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] cgroup: Fix crash with CLONE_INTO_CGROUP and v1 cgroups
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        "Christian A. Ehrhardt" <lk@c--e.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com> <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
 <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
 <20221009084039.cw6meqbvy4362lsa@wittgenstein>
 <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
 <CAJD7tkaQSMSmrb3Nt17-NPAPkvEoUp5tJBg8e4UYn0eU6x-Gqw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAJD7tkaQSMSmrb3Nt17-NPAPkvEoUp5tJBg8e4UYn0eU6x-Gqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/9/22 11:42 AM, Yosry Ahmed wrote:
> On Sun, Oct 9, 2022 at 6:10 AM Christian A. Ehrhardt <lk@c--e.de> wrote:
>>
>>
>> Since commit f3a2aebdd6, Version 1 cgroups no longer cause an
>> error when used with CLONE_INTO_CGROUP. However, the permission
>> checks performed during clone assume a Version 2 cgroup.
>>
>> Restore the error check for V1 cgroups in the clone() path.
>>
>> Reported-by: syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com
>> Link: https://lore.kernel.org/lkml/000000000000385cbf05ea3f1862@google.com/
>> Fixes: f3a2aebdd6 ("cgroup: enable cgroup_get_from_file() on cgroup1")
> 
> Thanks for fixing this, and sorry if this caused a mess.
> 
> cgroup_get_from_file() independently seemed like it can support
> cgroup1, I didn't realize that some of the callers depend on the fact
> that it only supports cgroup2.
> 
> +Andrii Nakryiko +Alexei Starovoitov +Martin KaFai Lau +bpf
> I wonder if BPF users have this dependency. Does cgroup_bpf_attach()
> also depend on cgroup_get_from_fd() (which calls
> cgroup_get_from_file()) eliminating v1 cgroups?

Yes, cgroup_bpf_{prog,link}_attach() depends on cgroup_get_from_fd() only 
returning v2 cgroup.  Thus, it needs a fix to get back this filtering after 
commit f3a2aebdd6.


> 
> It seems like cgroup storages (and some other places) use cgroup ids.
> Collisions can happen in cgroup1 ids so I am assuming we want to add a
> check there as well. Perhaps in cgroup_bpf_attach() ?

 From a quick look, cgroup storage should be fine.  The insertion (where the 
cgrp is required for the key purpose) has already passed the attach filtering.

Where 'other places' might have problem with the cgroup id?

> 
> I can send a patch for this if that's the case.
> 
>> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
>> ---
>>   kernel/cgroup/cgroup.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index b6e3110b3ea7..f7fc3afa88c1 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -6244,6 +6244,11 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
>>                  goto err;
>>          }
>>
>> +       if (!cgroup_on_dfl(dst_cgrp)) {
>> +               ret = -EBADF;
>> +               goto err;
>> +       }
>> +
>>          if (cgroup_is_dead(dst_cgrp)) {
>>                  ret = -ENODEV;
>>                  goto err;
>> --
>> 2.34.1
>>

