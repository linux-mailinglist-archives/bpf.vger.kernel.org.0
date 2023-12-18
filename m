Return-Path: <bpf+bounces-18159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C4A81653D
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 04:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051051C22120
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 03:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CC93D64;
	Mon, 18 Dec 2023 03:07:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0F3C0D;
	Mon, 18 Dec 2023 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vydujm._1702868817;
Received: from 30.221.148.252(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Vydujm._1702868817)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 11:06:59 +0800
Message-ID: <82c74693-db42-2491-868e-b6cb1cead4ec@linux.alibaba.com>
Date: Mon, 18 Dec 2023 11:06:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC nf-next v1 1/2] netfilter: bpf: support prog update
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, kadlec@netfilter.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org
References: <1702609653-45835-1-git-send-email-alibuda@linux.alibaba.com>
 <1702609653-45835-2-git-send-email-alibuda@linux.alibaba.com>
 <20231215141712.GA17065@breakpoint.cc>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231215141712.GA17065@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/15/23 10:17 PM, Florian Westphal wrote:
> D. Wythe <alibuda@linux.alibaba.com> wrote:
>>   	const struct nf_defrag_hook *defrag_hook;
>> +	const struct bpf_prog __rcu *nf_prog;
> Hmm, why do we need this pointer?
> Can't you just re-use bpf_nf_link->link.prog?
Accessing nf_link->link.prog directly is a bit strange because it is not 
marked as __rcu, which will generate a compilation warning,
thus we need to perform a type conversion.

But I do not intend to insist on it. I will remove it in the next version.

Best wishes,
D. Wythe
>
>> +	rcu_assign_pointer(nf_link->nf_prog, new_prog);
>> +	old_prog = xchg(&link->prog, new_prog);
> This looks redundant, I think you can remove the nf_prog
> pointer again.
>
> Rest LGTM.


