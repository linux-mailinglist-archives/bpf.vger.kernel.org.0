Return-Path: <bpf+bounces-18591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF6E81C565
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 08:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5027B1F24095
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 07:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793739455;
	Fri, 22 Dec 2023 07:06:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E47C8C8;
	Fri, 22 Dec 2023 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vz-25.h_1703228777;
Received: from 30.221.148.239(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Vz-25.h_1703228777)
          by smtp.aliyun-inc.com;
          Fri, 22 Dec 2023 15:06:19 +0800
Message-ID: <1d3cb7fc-c1dc-a779-8952-cdbaaf696ce3@linux.alibaba.com>
Date: Fri, 22 Dec 2023 15:06:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
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
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <CAADnVQK3Wk+pKbvc5_7jgaQ=qFq3y0ozgnn+dbW56DaHL2ExWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/21/23 5:11 AM, Alexei Starovoitov wrote:
> On Wed, Dec 20, 2023 at 6:09 AM D. Wythe <alibuda@linux.alibaba.com> wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> To support the prog update, we need to ensure that the prog seen
>> within the hook is always valid. Considering that hooks are always
>> protected by rcu_read_lock(), which provide us the ability to
>> access the prog under rcu.
>>
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>>   net/netfilter/nf_bpf_link.c | 63 ++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 48 insertions(+), 15 deletions(-)
>>
>> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
>> index e502ec0..9bc91d1 100644
>> --- a/net/netfilter/nf_bpf_link.c
>> +++ b/net/netfilter/nf_bpf_link.c
>> @@ -8,17 +8,8 @@
>>   #include <net/netfilter/nf_bpf_link.h>
>>   #include <uapi/linux/netfilter_ipv4.h>
>>
>> -static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
>> -                                   const struct nf_hook_state *s)
>> -{
>> -       const struct bpf_prog *prog = bpf_prog;
>> -       struct bpf_nf_ctx ctx = {
>> -               .state = s,
>> -               .skb = skb,
>> -       };
>> -
>> -       return bpf_prog_run(prog, &ctx);
>> -}
>> +/* protect link update in parallel */
>> +static DEFINE_MUTEX(bpf_nf_mutex);
>>
>>   struct bpf_nf_link {
>>          struct bpf_link link;
>> @@ -26,8 +17,20 @@ struct bpf_nf_link {
>>          struct net *net;
>>          u32 dead;
>>          const struct nf_defrag_hook *defrag_hook;
>> +       struct rcu_head head;
> I have to point out the same issues as before, but
> will ask them differently...
>
> Why do you think above rcu_head is necessary?
>
>>   };
>>
>> +static unsigned int nf_hook_run_bpf(void *bpf_link, struct sk_buff *skb,
>> +                                   const struct nf_hook_state *s)
>> +{
>> +       const struct bpf_nf_link *nf_link = bpf_link;
>> +       struct bpf_nf_ctx ctx = {
>> +               .state = s,
>> +               .skb = skb,
>> +       };
>> +       return bpf_prog_run(rcu_dereference_raw(nf_link->link.prog), &ctx);
>> +}
>> +
>>   #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
>>   static const struct nf_defrag_hook *
>>   get_proto_defrag_hook(struct bpf_nf_link *link,
>> @@ -126,8 +129,7 @@ static void bpf_nf_link_release(struct bpf_link *link)
>>   static void bpf_nf_link_dealloc(struct bpf_link *link)
>>   {
>>          struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
>> -
>> -       kfree(nf_link);
>> +       kfree_rcu(nf_link, head);
> Why is this needed ?
> Have you looked at tcx_link_lops ?

Introducing rcu_head/kfree_rcu is to address the situation where the 
netfilter hooks might
still access the link after bpf_nf_link_dealloc.

                                                      nf_hook_run_bpf
                                                      const struct 
bpf_nf_link *nf_link = bpf_link;

bpf_nf_link_release
     nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);

bpf_nf_link_dealloc
     free(link)
bpf_prog_run(link->prog);


I had checked the tcx_link_lops ,it's seems it use the synchronize_rcu() 
to solve the
same problem, which is also the way we used in the first version.

https://lore.kernel.org/bpf/1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com/

However, we have received some opposing views, believing that this is a 
bit overkill,
so we decided to use kfree_rcu.

https://lore.kernel.org/bpf/20231213222415.GA13818@breakpoint.cc/

>>   }
>>
>>   static int bpf_nf_link_detach(struct bpf_link *link)
>> @@ -162,7 +164,34 @@ static int bpf_nf_link_fill_link_info(const struct bpf_link *link,
>>   static int bpf_nf_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
>>                                struct bpf_prog *old_prog)
>>   {
>> -       return -EOPNOTSUPP;
>> +       struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
>> +       int err = 0;
>> +
>> +       mutex_lock(&bpf_nf_mutex);
> Why do you need this mutex?
> What race does it solve?

To avoid user update a link with differ prog at the same time. I noticed 
that sys_bpf()
doesn't seem to prevent being invoked by user at the same time. Have I 
missed something?

Best wishes,
D. Wythe
>> +
>> +       if (nf_link->dead) {
>> +               err = -EPERM;
>> +               goto out;
>> +       }
>> +
>> +       /* target old_prog mismatch */
>> +       if (old_prog && link->prog != old_prog) {
>> +               err = -EPERM;
>> +               goto out;
>> +       }
>> +
>> +       old_prog = link->prog;
>> +       if (old_prog == new_prog) {
>> +               /* don't need update */
>> +               bpf_prog_put(new_prog);
>> +               goto out;
>> +       }
>> +
>> +       old_prog = xchg(&link->prog, new_prog);
>> +       bpf_prog_put(old_prog);
>> +out:
>> +       mutex_unlock(&bpf_nf_mutex);
>> +       return err;
>>   }
>>
>>   static const struct bpf_link_ops bpf_nf_link_lops = {
>> @@ -226,7 +255,11 @@ int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>
>>          link->hook_ops.hook = nf_hook_run_bpf;
>>          link->hook_ops.hook_ops_type = NF_HOOK_OP_BPF;
>> -       link->hook_ops.priv = prog;
>> +
>> +       /* bpf_nf_link_release & bpf_nf_link_dealloc() can ensures that link remains
>> +        * valid at all times within nf_hook_run_bpf().
>> +        */
>> +       link->hook_ops.priv = link;
>>
>>          link->hook_ops.pf = attr->link_create.netfilter.pf;
>>          link->hook_ops.priority = attr->link_create.netfilter.priority;
>> --
>> 1.8.3.1
>>


