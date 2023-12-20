Return-Path: <bpf+bounces-18377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219E1819F30
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 13:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB471C22E58
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E06F24B4B;
	Wed, 20 Dec 2023 12:40:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945F2230D;
	Wed, 20 Dec 2023 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyuTPGv_1703076019;
Received: from 30.221.149.0(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VyuTPGv_1703076019)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 20:40:21 +0800
Message-ID: <b3614748-e34e-5629-e483-ddff29af8fe4@linux.alibaba.com>
Date: Wed, 20 Dec 2023 20:40:19 +0800
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
To: Florian Westphal <fw@strlen.de>
Cc: Simon Horman <horms@kernel.org>, pablo@netfilter.org,
 kadlec@netfilter.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, coreteam@netfilter.org,
 netfilter-devel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org
References: <1702873101-77522-1-git-send-email-alibuda@linux.alibaba.com>
 <1702873101-77522-2-git-send-email-alibuda@linux.alibaba.com>
 <20231218190640.GJ6288@kernel.org>
 <2fd4fb88-8aaa-b22d-d048-776a6c19d9a6@linux.alibaba.com>
 <20231219145813.GA28704@breakpoint.cc>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231219145813.GA28704@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/19/23 10:58 PM, Florian Westphal wrote:
> D. Wythe <alibuda@linux.alibaba.com> wrote:
>> net/netfilter/nf_bpf_link.c:31:22: note: in expansion of macro
>> ‘rcu_dereference’
>>     31 |  return bpf_prog_run(rcu_dereference((const struct bpf_prog __rcu
>> *)nf_link->link.prog), &ctx);
>>        |                      ^~~~~~~~~~~~~~~
>>
>> So, I think we might need to go back to version 1.
>>
>> @ Florian , what do you think ?
> Use rcu_dereference_raw().

Got it. I'm also good with that.

D. Wythe

