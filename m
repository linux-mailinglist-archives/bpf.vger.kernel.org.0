Return-Path: <bpf+bounces-18705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D5B81F793
	for <lists+bpf@lfdr.de>; Thu, 28 Dec 2023 12:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542432851C6
	for <lists+bpf@lfdr.de>; Thu, 28 Dec 2023 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847886FD5;
	Thu, 28 Dec 2023 11:06:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5336AAC;
	Thu, 28 Dec 2023 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VzOK8oQ_1703761600;
Received: from 30.221.146.89(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VzOK8oQ_1703761600)
          by smtp.aliyun-inc.com;
          Thu, 28 Dec 2023 19:06:41 +0800
Message-ID: <5f8ee6e1-8a3c-457c-bbda-5b003e726a7c@linux.alibaba.com>
Date: Thu, 28 Dec 2023 19:06:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC nf-next v3 1/2] netfilter: bpf: support prog update
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, coreteam@netfilter.org,
 netfilter-devel <netfilter-devel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>
References: <1703081351-85579-1-git-send-email-alibuda@linux.alibaba.com>
 <1703081351-85579-2-git-send-email-alibuda@linux.alibaba.com>
 <CAADnVQK3Wk+pKbvc5_7jgaQ=qFq3y0ozgnn+dbW56DaHL2ExWQ@mail.gmail.com>
 <1d3cb7fc-c1dc-a779-8952-cdbaaf696ce3@linux.alibaba.com>
 <CAADnVQJEUEo3g7knXtkD0CNjazTpQKcjrAaZLJ4utk962bjmvw@mail.gmail.com>
 <d5879c57-634f-4973-b52d-4994d0929de6@linux.alibaba.com>
 <CAADnVQJZsJujDH=YAoZ6ieQQ2pVo0wvc-ppwRC7y2X=ggibsEw@mail.gmail.com>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <CAADnVQJZsJujDH=YAoZ6ieQQ2pVo0wvc-ppwRC7y2X=ggibsEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/28/23 3:00 AM, Alexei Starovoitov wrote:
> On Wed, Dec 27, 2023 at 12:20 AM D. Wythe <alibuda@linux.alibaba.com> wrote:
>>
>> Hi Alexei,
>>
>>
>> IMMO, nf_unregister_net_hook does not wait for the completion of the
>> execution of the hook that is being removed,
>> instead, it allocates a new array without the very hook to replace the
>> old arrayvia rcu_assign_pointer() (in __nf_hook_entries_try_shrink),
>> then it use call_rcu() to release the old one.
>>
>> You can find more details in commit
>> 8c873e2199700c2de7dbd5eedb9d90d5f109462b.
>>
>> In other words, when nf_unregister_net_hook returns, there may still be
>> contexts executing hooks on the
>> old array, which means that the `link` may still be accessed after
>> nf_unregister_net_hook returns.
>>
>> And that's the reason why we use kfree_rcu() to release the `link`.
>>>>                                                         nf_hook_run_bpf
>>>>                                                         const struct
>>>> bpf_nf_link *nf_link = bpf_link;
>>>>
>>>> bpf_nf_link_release
>>>>        nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
>>>>
>>>> bpf_nf_link_dealloc
>>>>        free(link)
>>>> bpf_prog_run(link->prog);
> Got it.
> Sounds like it's an existing bug. If so it should be an independent
> patch with Fixes tag.
>
> Also please craft a test case to demonstrate UAF.
>

It is not an existing bug... Accessing the link within the hook was 
something I introduced here
to support updates😉, as previously there was no access to the link 
within the hook.
>> I must admit that it is indeed feasible if we eliminate the mutex and
>> use cmpxchg to swap the prog (we need to ensure that there is only one
>> bpf_prog_put() on the old prog).
>> However, when cmpxchg fails, it means that this context has not
>> outcompeted the other one, and we have to return a failure. Maybe
>> something like this:
>>
>> if (!cmpxchg(&link->prog, old_prog, new_prog)) {
>>       /* already replaced by another link_update */
>>       return -xxx;
>> }
>>
>> As a comparison, The version with the mutex wouldn't encounter this
>> error, every update would succeed. I think that it's too harsh for the
>> user to receive a failure
>> in that case since they haven't done anything wrong.
> Disagree. The mutex doesn't prevent this issue.
> There is always a race.
> It happens when link_update.old_prog_fd and BPF_F_REPLACE
> were specified.
> One user space passes an FD of the old prog and
> another user space doing the same. They both race and one of them
> gets
> if (old_prog && link->prog != old_prog) {
>                 err = -EPERM;
>
> it's no different with dropping the mutex and doing:
> if (old_prog) {
>      if (!cmpxchg(&link->prog, old_prog, new_prog))
>        -EPERM
> } else {
>     old_prog = xchg(&link->prog, new_prog);
> }

Got it!  It's very helpful, Thanks very much! I will modify my patch 
accordingly.


Best wishes,
D. Wythe






