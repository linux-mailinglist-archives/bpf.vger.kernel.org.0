Return-Path: <bpf+bounces-18280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B082D8187EE
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 13:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F31E28A89A
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 12:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F9C18658;
	Tue, 19 Dec 2023 12:50:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6EA1862E;
	Tue, 19 Dec 2023 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyqyhQ6_1702990206;
Received: from 30.221.149.49(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VyqyhQ6_1702990206)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 20:50:08 +0800
Message-ID: <2fd4fb88-8aaa-b22d-d048-776a6c19d9a6@linux.alibaba.com>
Date: Tue, 19 Dec 2023 20:50:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC nf-next v2 1/2] netfilter: bpf: support prog update
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org
References: <1702873101-77522-1-git-send-email-alibuda@linux.alibaba.com>
 <1702873101-77522-2-git-send-email-alibuda@linux.alibaba.com>
 <20231218190640.GJ6288@kernel.org>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231218190640.GJ6288@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/19/23 3:06 AM, Simon Horman wrote:
> On Mon, Dec 18, 2023 at 12:18:20PM +0800, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> To support the prog update, we need to ensure that the prog seen
>> within the hook is always valid. Considering that hooks are always
>> protected by rcu_read_lock(), which provide us the ability to
>> access the prog under rcu.
>>
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ...
>
>> @@ -26,8 +17,20 @@ struct bpf_nf_link {
>>   	struct net *net;
>>   	u32 dead;
>>   	const struct nf_defrag_hook *defrag_hook;
>> +	struct rcu_head head;
>>   };
>>   
>> +static unsigned int nf_hook_run_bpf(void *bpf_link, struct sk_buff *skb,
>> +				    const struct nf_hook_state *s)
>> +{
>> +	const struct bpf_nf_link *nf_link = bpf_link;
>> +	struct bpf_nf_ctx ctx = {
>> +		.state = s,
>> +		.skb = skb,
>> +	};
>> +	return bpf_prog_run(rcu_dereference(nf_link->link.prog), &ctx);
> Hi,
>
> AFAICT nf_link->link.prog isn't annotated as __rcu,
> so perhaps rcu_dereference() is not correct here?
>
> In any case, sparse seems a bit unhappy:
>
>    .../nf_bpf_link.c:31:29: error: incompatible types in comparison expression (different address spaces):
>    .../nf_bpf_link.c:31:29:    struct bpf_prog [noderef] __rcu *
>    .../nf_bpf_link.c:31:29:    struct bpf_prog *

Hi Simon,

thanks for the reporting.

Yes, I had anticipated that sparse would report an error. I tried to 
cast the type,
but it would compile an error likes that:


net/netfilter/nf_bpf_link.c: In function ‘nf_hook_run_bpf’:
./include/asm-generic/rwonce.h:44:70: error: lvalue required as unary 
‘&’ operand
    44 | #define __READ_ONCE(x) (*(const volatile 
__unqual_scalar_typeof(x) *)&(x))
| ^
./include/asm-generic/rwonce.h:50:2: note: in expansion of macro 
‘__READ_ONCE’
    50 |  __READ_ONCE(x);       \
       |  ^~~~~~~~~~~
./include/linux/rcupdate.h:436:43: note: in expansion of macro ‘READ_ONCE’
   436 |  typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
       |                                           ^~~~~~~~~
./include/linux/rcupdate.h:584:2: note: in expansion of macro 
‘__rcu_dereference_check’
   584 |  __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
       |  ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/rcupdate.h:656:28: note: in expansion of macro 
‘rcu_dereference_check’
   656 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
       |                            ^~~~~~~~~~~~~~~~~~~~~
net/netfilter/nf_bpf_link.c:31:22: note: in expansion of macro 
‘rcu_dereference’
    31 |  return bpf_prog_run(rcu_dereference((const struct bpf_prog 
__rcu *)nf_link->link.prog), &ctx);
       |                      ^~~~~~~~~~~~~~~

So, I think we might need to go back to version 1.

@ Florian , what do you think ?

D. Wythe

>> +}
>> +
>>   #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
>>   static const struct nf_defrag_hook *
>>   get_proto_defrag_hook(struct bpf_nf_link *link,
> ...


