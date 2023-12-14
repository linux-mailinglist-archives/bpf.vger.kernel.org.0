Return-Path: <bpf+bounces-17856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33D98135D4
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76D0EB218D7
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283EE5F1DB;
	Thu, 14 Dec 2023 16:10:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AED1A7;
	Thu, 14 Dec 2023 08:10:29 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyUntPm_1702570225;
Received: from 192.168.50.70(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VyUntPm_1702570225)
          by smtp.aliyun-inc.com;
          Fri, 15 Dec 2023 00:10:26 +0800
Message-ID: <f79c3b4c-4c3a-8bc1-6396-4cbba17136dc@linux.alibaba.com>
Date: Fri, 15 Dec 2023 00:10:24 +0800
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, coreteam@netfilter.org,
 netfilter-devel <netfilter-devel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>
References: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
 <1702467945-38866-2-git-send-email-alibuda@linux.alibaba.com>
 <20231213222415.GA13818@breakpoint.cc>
 <0e94149a-05f1-3f98-3f75-ca74f364a45b@linux.alibaba.com>
 <CAADnVQJx7j_kB6PVJN7cwGn5ETjcSs2Y0SuBS0+9qJRFpMNv-w@mail.gmail.com>
 <e6d9b59f-9c98-53a1-4947-720095e0c37e@linux.alibaba.com>
 <CAADnVQK5JP3D+BrugP61whZX1r1zHp7M_VLSkDmCKF9y96=79A@mail.gmail.com>
 <3c1f3b68-f1fc-495c-5430-ba7bc7339619@linux.alibaba.com>
 <CAADnVQLJ3XkZMQDdMGOcKUqK8xuFHcc1+74o6RrzfzeZo7v28A@mail.gmail.com>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <CAADnVQLJ3XkZMQDdMGOcKUqK8xuFHcc1+74o6RrzfzeZo7v28A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/15/23 12:02 AM, Alexei Starovoitov wrote:
> I see. The commit log didn't make it clear.
> Yes. That would be good to support.

That's my bad. I will make the commit log more clear in the next version.
In any case, thanks very much for your feedback.

Besh wishes,
D. Wythe

