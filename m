Return-Path: <bpf+bounces-16151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF57FDAAF
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 16:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491311C20D3C
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 15:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047CE36B12;
	Wed, 29 Nov 2023 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B836A3;
	Wed, 29 Nov 2023 07:02:04 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VxOW.jE_1701270121;
Received: from 30.39.190.97(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VxOW.jE_1701270121)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 23:02:02 +0800
Message-ID: <d8262b12-3ac9-8608-fc6f-d48c33a4225e@linux.alibaba.com>
Date: Wed, 29 Nov 2023 23:02:01 +0800
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
 <aa83bf32-789f-fec2-ea42-74b0ae05426e@linux.alibaba.com>
 <20231129144736.GB24754@breakpoint.cc>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231129144736.GB24754@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/29/23 10:47 PM, Florian Westphal wrote:
> D. Wythe <alibuda@linux.alibaba.com> wrote:
>> And my origin intention was to allow ebpf progs to return NF_STOLEN, we are
>> trying to modify some netfilter modules via ebpf,
>> and some scenarios require the use of NF_STOLEN, but from your description,
> NF_STOLEN can only be supported via a trusted helper, as least as far as
> I understand.
>
> Otherwise verifier would have to guarantee that any branch that returns
> NF_STOLEN has released the skb, or passed it to a function that will
> release the skb in the near future.

Thank you very much for your help. I now understand the difficulty here.
The verifier cannot determine whether the consume_skb() was executed or not,
when the return value  goes to NF_STOLEN.

We may use NF_DROP at first, it won't be make much difference for us now.

Also, do you have any plans to support this helper?

Best wishes,
D. Wythe

