Return-Path: <bpf+bounces-19606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A482EFEF
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 14:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF151C23289
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA4D1BDDA;
	Tue, 16 Jan 2024 13:46:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033711B944;
	Tue, 16 Jan 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W-mKldk_1705412774;
Received: from 30.221.145.228(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W-mKldk_1705412774)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 21:46:15 +0800
Message-ID: <3a82adb1-c839-4e82-834f-a63f9910b28d@linux.alibaba.com>
Date: Tue, 16 Jan 2024 21:46:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC nf-next v5 0/2] netfilter: bpf: support prog update
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, coreteam@netfilter.org,
 netfilter-devel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org
References: <1704175877-28298-1-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1704175877-28298-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Just a reminder to avoid forgetting this patch by everyone. 🙂

Best wishes,
D. Wythe


On 1/2/24 2:11 PM, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> This patches attempt to implements updating of progs within
> bpf netfilter link, allowing user update their ebpf netfilter
> prog in hot update manner.
>
> Besides, a corresponding test case has been added to verify
> whether the update works.
> --
> v1:
> 1. remove unnecessary context, access the prog directly via rcu.
> 2. remove synchronize_rcu(), dealloc the nf_link via kfree_rcu.
> 3. check the dead flag during the update.
> --
> v1->v2:
> 1. remove unnecessary nf_prog, accessing nf_link->link.prog in direct.
> --
> v2->v3:
> 1. access nf_link->link.prog via rcu_dereference_raw to avoid warning.
> --
> v3->v4:
> 1. remove mutex for link update, as it is unnecessary and can be replaced
> by atomic operations.
> --
> v4->v5:
> 1. fix error retval check on cmpxhcg
>
> D. Wythe (2):
>    netfilter: bpf: support prog update
>    selftests/bpf: Add netfilter link prog update test
>
>   net/netfilter/nf_bpf_link.c                        | 50 ++++++++-----
>   .../bpf/prog_tests/netfilter_link_update_prog.c    | 83 ++++++++++++++++++++++
>   .../bpf/progs/test_netfilter_link_update_prog.c    | 24 +++++++
>   3 files changed, 141 insertions(+), 16 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_update_prog.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_update_prog.c
>


