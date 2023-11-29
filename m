Return-Path: <bpf+bounces-16147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C507FD9DD
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 15:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9884B213B2
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA8031A74;
	Wed, 29 Nov 2023 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0EA130;
	Wed, 29 Nov 2023 06:42:27 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VxOO2AH_1701268943;
Received: from 30.39.190.97(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VxOO2AH_1701268943)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 22:42:24 +0800
Message-ID: <aa83bf32-789f-fec2-ea42-74b0ae05426e@linux.alibaba.com>
Date: Wed, 29 Nov 2023 22:42:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] net/netfilter: bpf: avoid leakage of skb
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, kadlec@netfilter.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org
References: <1701252962-63418-1-git-send-email-alibuda@linux.alibaba.com>
 <20231129131846.GC27744@breakpoint.cc>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231129131846.GC27744@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/29/23 9:18 PM, Florian Westphal wrote:
> D. Wythe <alibuda@linux.alibaba.com> wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> A malicious eBPF program can interrupt the subsequent processing of
>> a skb by returning an exceptional retval, and no one will be responsible
>> for releasing the very skb.
> How?  The bpf verifier is supposed to reject nf bpf programs that
> return a value other than accept or drop.
>
> If this is a real bug, please also figure out why
> 006c0e44ed92 ("selftests/bpf: add missing netfilter return value and ctx access tests")
> failed to catch it.

Hi Florian,

You are right, i make a mistake.. , it's not a bug..

And my origin intention was to allow ebpf progs to return NF_STOLEN, we 
are trying to modify some netfilter modules via ebpf,
and some scenarios require the use of NF_STOLEN, but from your 
description, it seems that at least currently,
you do not want to return NF_STOLEN, until there is a helper for 
sonsume_skb(), right ?

Again, very sorry to bother you.

Best wishes,
D. Wythe.

>> Moreover, normal programs can also have the demand to return NF_STOLEN,
> No, this should be disallowed already.
>
>>   net/netfilter/nf_bpf_link.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
>> index e502ec0..03c47d6 100644
>> --- a/net/netfilter/nf_bpf_link.c
>> +++ b/net/netfilter/nf_bpf_link.c
>> @@ -12,12 +12,29 @@ static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
>>   				    const struct nf_hook_state *s)
>>   {
>>   	const struct bpf_prog *prog = bpf_prog;
>> +	unsigned int verdict;
>>   	struct bpf_nf_ctx ctx = {
>>   		.state = s,
>>   		.skb = skb,
>>   	};
>>   
>> -	return bpf_prog_run(prog, &ctx);
>> +	verdict = bpf_prog_run(prog, &ctx);
>> +	switch (verdict) {
>> +	case NF_STOLEN:
>> +		consume_skb(skb);
>> +		fallthrough;
> This can't be right.  STOLEN really means STOLEN (free'd,
> redirected, etc, "skb" MUST be "leaked".
>
> Which is also why the bpf program is not allowed to return it.




