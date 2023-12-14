Return-Path: <bpf+bounces-17784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E4D8126EE
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 06:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F3B1C214CE
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 05:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDCC6AC0;
	Thu, 14 Dec 2023 05:31:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12009BD;
	Wed, 13 Dec 2023 21:31:26 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VyTFUF0_1702531882;
Received: from 30.221.148.227(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VyTFUF0_1702531882)
          by smtp.aliyun-inc.com;
          Thu, 14 Dec 2023 13:31:24 +0800
Message-ID: <0e94149a-05f1-3f98-3f75-ca74f364a45b@linux.alibaba.com>
Date: Thu, 14 Dec 2023 13:31:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC nf-next 1/2] netfilter: bpf: support prog update
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, kadlec@netfilter.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org
References: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
 <1702467945-38866-2-git-send-email-alibuda@linux.alibaba.com>
 <20231213222415.GA13818@breakpoint.cc>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231213222415.GA13818@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/14/23 6:24 AM, Florian Westphal wrote:
> D. Wythe <alibuda@linux.alibaba.com> wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> To support the prog update, we need to ensure that the prog seen
>> within the hook is always valid. Considering that hooks are always
>> protected by rcu_read_lock(), which provide us the ability to use a
>> new RCU-protected context to access the prog.
>>
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>>   net/netfilter/nf_bpf_link.c | 124 +++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 111 insertions(+), 13 deletions(-)
>>
>> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
>> index e502ec0..918c470 100644
>> --- a/net/netfilter/nf_bpf_link.c
>> +++ b/net/netfilter/nf_bpf_link.c
>> @@ -8,17 +8,11 @@
>>   #include <net/netfilter/nf_bpf_link.h>
>>   #include <uapi/linux/netfilter_ipv4.h>
>>   
>> -static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
>> -				    const struct nf_hook_state *s)
>> +struct bpf_nf_hook_ctx
>>   {
>> -	const struct bpf_prog *prog = bpf_prog;
>> -	struct bpf_nf_ctx ctx = {
>> -		.state = s,
>> -		.skb = skb,
>> -	};
>> -
>> -	return bpf_prog_run(prog, &ctx);
>> -}
>> +	struct bpf_prog *prog;
>> +	struct rcu_head rcu;
>> +};
> I don't understand the need for this structure.  AFAICS bpf_prog_put()
> will always release the program via call_rcu()?
>
> If it doesn't, we are probably already in trouble as-is without this
> patch, I don't think anything that prevents us from ending up calling already
> released bpf prog, or releasing it while another cpu is still running it
> if bpf_prog_put releases the actual underlying prog instantly.
>
> A BPF expert could confirm bpf-prog-put-is-call-rcu.

Hi Florian,

I must admit that I did not realize that bpf_prog is released
under RCU ...

>>   struct bpf_nf_link {
>>   	struct bpf_link link;
>> @@ -26,8 +20,59 @@ struct bpf_nf_link {
>>   	struct net *net;
>>   	u32 dead;
>>   	const struct nf_defrag_hook *defrag_hook;
>> +	/* protect link update in parallel */
>> +	struct mutex update_lock;
>> +	struct bpf_nf_hook_ctx __rcu *hook_ctx;
> What kind of replacements-per-second rate are you aiming for?
> I think
>
> static DEFINE_MUTEX(bpf_nf_mutex);
>
> is enough.

I'm okay with that.

>
> Then bpf_nf_link gains
>
> 	struct bpf_prog __rcu *prog
>
> and possibly a trailing struct rcu_head, see below.

Yes, that's what we need.

>> +static void bpf_nf_hook_ctx_free_rcu(struct bpf_nf_hook_ctx *hook_ctx)
>> +{
>> +	call_rcu(&hook_ctx->rcu, __bpf_nf_hook_ctx_free_rcu);
>> +}
> Don't understand the need for call_rcu either, see below.
>
>> +static unsigned int nf_hook_run_bpf(void *bpf_link, struct sk_buff *skb,
>> +				    const struct nf_hook_state *s)
>> +{
>> +	const struct bpf_nf_link *link = bpf_link;
>> +	struct bpf_nf_hook_ctx *hook_ctx;
>> +	struct bpf_nf_ctx ctx = {
>> +		.state = s,
>> +		.skb = skb,
>> +	};
>> +
>> +	hook_ctx = rcu_dereference(link->hook_ctx);
> This could then just rcu_deref link->prog.
>
>> +	return bpf_prog_run(hook_ctx->prog, &ctx);
>> +}
>> +
>>   #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
>>   static const struct nf_defrag_hook *
>>   get_proto_defrag_hook(struct bpf_nf_link *link,
>> @@ -120,6 +165,10 @@ static void bpf_nf_link_release(struct bpf_link *link)
>>   	if (!cmpxchg(&nf_link->dead, 0, 1)) {
>>   		nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
>>   		bpf_nf_disable_defrag(nf_link);
>> +		/* Wait for outstanding hook to complete before the
>> +		 * link gets released.
>> +		 */
>> +		synchronize_rcu();
>>   	}
> Could you convert bpf_nf_link_dealloc to release via kfree_rcu instead?
>
Got it.
>> @@ -162,7 +212,42 @@ static int bpf_nf_link_fill_link_info(const struct bpf_link *link,
>>   static int bpf_nf_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
>>   			      struct bpf_prog *old_prog)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
>> +	struct bpf_nf_hook_ctx *hook_ctx;
>> +	int err = 0;
>> +
>> +	mutex_lock(&nf_link->update_lock);
>> +
> I think you need to check link->dead here too.

Got that.
>
>> +	/* bpf_nf_link_release() ensures that after its execution, there will be
>> +	 * no ongoing or upcoming execution of nf_hook_run_bpf() within any context.
>> +	 * Therefore, within nf_hook_run_bpf(), the link remains valid at all times."
>> +	 */
>> +	link->hook_ops.priv = link;
> ATM we only need to make sure the bpf prog itself stays alive until after
> all concurrent rcu critical sections have completed.
>
> After this change, struct bpf_link gets passed instead, so we need to
> keep that alive too.
>
> Which works with synchronize_rcu, sure, but that seems a bit overkill here.

Got it! Thank you very much for your suggestion.
I will address those issues you mentioned in the next version.


Best wishes,
D. Wythe


