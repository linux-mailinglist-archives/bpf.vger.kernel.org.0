Return-Path: <bpf+bounces-18688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D5281ED36
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 09:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C2D7B22548
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8375563C0;
	Wed, 27 Dec 2023 08:20:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A86127;
	Wed, 27 Dec 2023 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VzKSstD_1703665209;
Received: from 30.221.145.199(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VzKSstD_1703665209)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 16:20:11 +0800
Message-ID: <d5879c57-634f-4973-b52d-4994d0929de6@linux.alibaba.com>
Date: Wed, 27 Dec 2023 16:20:09 +0800
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
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <CAADnVQJEUEo3g7knXtkD0CNjazTpQKcjrAaZLJ4utk962bjmvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/23/23 6:23 AM, Alexei Starovoitov wrote:
> On Thu, Dec 21, 2023 at 11:06 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
>>
>>
>> On 12/21/23 5:11 AM, Alexei Starovoitov wrote:
>>> On Wed, Dec 20, 2023 at 6:09 AM D. Wythe <alibuda@linux.alibaba.com> wrote:
>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>
>>>> To support the prog update, we need to ensure that the prog seen
>>>> within the hook is always valid. Considering that hooks are always
>>>> protected by rcu_read_lock(), which provide us the ability to
>>>> access the prog under rcu.
>>>>
>>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>>> ---
>>>>    net/netfilter/nf_bpf_link.c | 63 ++++++++++++++++++++++++++++++++++-----------
>>>>    1 file changed, 48 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
>>>> index e502ec0..9bc91d1 100644
>>>> --- a/net/netfilter/nf_bpf_link.c
>>>> +++ b/net/netfilter/nf_bpf_link.c
>>>> @@ -8,17 +8,8 @@
>>>>    #include <net/netfilter/nf_bpf_link.h>
>>>>    #include <uapi/linux/netfilter_ipv4.h>
>>>>
>>>> -static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
>>>> -                                   const struct nf_hook_state *s)
>>>> -{
>>>> -       const struct bpf_prog *prog = bpf_prog;
>>>> -       struct bpf_nf_ctx ctx = {
>>>> -               .state = s,
>>>> -               .skb = skb,
>>>> -       };
>>>> -
>>>> -       return bpf_prog_run(prog, &ctx);
>>>> -}
>>>> +/* protect link update in parallel */
>>>> +static DEFINE_MUTEX(bpf_nf_mutex);
>>>>
>>>>    struct bpf_nf_link {
>>>>           struct bpf_link link;
>>>> @@ -26,8 +17,20 @@ struct bpf_nf_link {
>>>>           struct net *net;
>>>>           u32 dead;
>>>>           const struct nf_defrag_hook *defrag_hook;
>>>> +       struct rcu_head head;
>>> I have to point out the same issues as before, but
>>> will ask them differently...
>>>
>>> Why do you think above rcu_head is necessary?
>>>
>>>>    };
>>>>
>>>> +static unsigned int nf_hook_run_bpf(void *bpf_link, struct sk_buff *skb,
>>>> +                                   const struct nf_hook_state *s)
>>>> +{
>>>> +       const struct bpf_nf_link *nf_link = bpf_link;
>>>> +       struct bpf_nf_ctx ctx = {
>>>> +               .state = s,
>>>> +               .skb = skb,
>>>> +       };
>>>> +       return bpf_prog_run(rcu_dereference_raw(nf_link->link.prog), &ctx);
>>>> +}
>>>> +
>>>>    #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
>>>>    static const struct nf_defrag_hook *
>>>>    get_proto_defrag_hook(struct bpf_nf_link *link,
>>>> @@ -126,8 +129,7 @@ static void bpf_nf_link_release(struct bpf_link *link)
>>>>    static void bpf_nf_link_dealloc(struct bpf_link *link)
>>>>    {
>>>>           struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
>>>> -
>>>> -       kfree(nf_link);
>>>> +       kfree_rcu(nf_link, head);
>>> Why is this needed ?
>>> Have you looked at tcx_link_lops ?
>> Introducing rcu_head/kfree_rcu is to address the situation where the
>> netfilter hooks might
>> still access the link after bpf_nf_link_dealloc.
> Why do you think so?
>

Hi Alexei,


IMMO, nf_unregister_net_hook does not wait for the completion of the 
execution of the hook that is being removed,
instead, it allocates a new array without the very hook to replace the 
old arrayvia rcu_assign_pointer() (in __nf_hook_entries_try_shrink),
then it use call_rcu() to release the old one.

You can find more details in commit 
8c873e2199700c2de7dbd5eedb9d90d5f109462b.

In other words, when nf_unregister_net_hook returns, there may still be 
contexts executing hooks on the
old array, which means that the `link` may still be accessed after 
nf_unregister_net_hook returns.

And that's the reason why we use kfree_rcu() to release the `link`.
>>                                                        nf_hook_run_bpf
>>                                                        const struct
>> bpf_nf_link *nf_link = bpf_link;
>>
>> bpf_nf_link_release
>>       nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
>>
>> bpf_nf_link_dealloc
>>       free(link)
>> bpf_prog_run(link->prog);
>>
>>
>> I had checked the tcx_link_lops ,it's seems it use the synchronize_rcu()
>> to solve the
> Where do you see such code in tcx_link_lops ?

I'm not certain if the reason that it choose to use synchronize_rcu()is 
the same as mine,
but I did see it here:


tcx_link_release() -> tcx_entry_sync()


static inline void tcx_entry_sync(void)
{
     /* bpf_mprog_entry got a/b swapped, therefore ensure that
      * there are no inflight users on the old one anymore.
      */
     synchronize_rcu();
}

>> same problem, which is also the way we used in the first version.
>>
>> https://lore.kernel.org/bpf/1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com/
>>
>> However, we have received some opposing views, believing that this is a
>> bit overkill,
>> so we decided to use kfree_rcu.
>>
>> https://lore.kernel.org/bpf/20231213222415.GA13818@breakpoint.cc/
>>
>>>>    }
>>>>
>>>>    static int bpf_nf_link_detach(struct bpf_link *link)
>>>> @@ -162,7 +164,34 @@ static int bpf_nf_link_fill_link_info(const struct bpf_link *link,
>>>>    static int bpf_nf_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
>>>>                                 struct bpf_prog *old_prog)
>>>>    {
>>>> -       return -EOPNOTSUPP;
>>>> +       struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
>>>> +       int err = 0;
>>>> +
>>>> +       mutex_lock(&bpf_nf_mutex);
>>> Why do you need this mutex?
>>> What race does it solve?
>> To avoid user update a link with differ prog at the same time. I noticed
>> that sys_bpf()
>> doesn't seem to prevent being invoked by user at the same time. Have I
>> missed something?
> You're correct that sys_bpf() doesn't lock anything.
> But what are you serializing in this bpf_nf_link_update() ?
> What will happen if multiple bpf_nf_link_update()
> without mutex run on different CPUs in parallel ?

I must admit that it is indeed feasible if we eliminate the mutex and 
use cmpxchg to swap the prog (we need to ensure that there is only one 
bpf_prog_put() on the old prog).
However, when cmpxchg fails, it means that this context has not 
outcompeted the other one, and we have to return a failure. Maybe 
something like this:

if (!cmpxchg(&link->prog, old_prog, new_prog)) {
     /* already replaced by another link_update */
     return -xxx;
}

As a comparison, The version with the mutex wouldn't encounter this 
error, every update would succeed. I think that it's too harsh for the 
user to receive a failure
in that case since they haven't done anything wrong.

Best wishes,
D. Wythe



