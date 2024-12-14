Return-Path: <bpf+bounces-46984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A0A9F1D8F
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 09:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2558D188B7E3
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 08:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E7B16F8F5;
	Sat, 14 Dec 2024 08:38:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B2D383;
	Sat, 14 Dec 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734165510; cv=none; b=oS4DUd0x+Rz3nMzIQlcyztk1kuChfmdjoU3h+tmSZZGI0w6fqmCtV8qF1SeokQJrSh4ijIzRlwcM138WrjZjiQnux0Tqy569eTXiBJdRFqIJvTgImYiBlT25fn/aG+N8r/QjOb6E8SWrUpeLJVJKEJPzIbz2M2GMkGS/gpr1pHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734165510; c=relaxed/simple;
	bh=1/yIy1SrlcaNV2kPAIqau8laoWMKllp8+UijVCDcJAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d3ITfWZ21vvrTNiqsgZIpxMBKUDlPUoNK9Ph1btsbkQntTqtRvjHRKQ9IECC1HXdv1A7DbBhF+Hn7oD2iY7YJeSjkmF8TVVs5PKf9wGn/43eK8y2W7OmYn7IAYZr53y3Zgp2QCAzcL8zbUcGhZJNe3Emx7VvhAbkgjwEhJ5qJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y9KNp5ZCgz20lpM;
	Sat, 14 Dec 2024 16:38:34 +0800 (CST)
Received: from kwepemo500008.china.huawei.com (unknown [7.202.195.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 33C09180044;
	Sat, 14 Dec 2024 16:38:17 +0800 (CST)
Received: from [10.67.111.172] (10.67.111.172) by
 kwepemo500008.china.huawei.com (7.202.195.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 14 Dec 2024 16:38:15 +0800
Message-ID: <7266ee61-3085-74fc-2560-c62fc34c2148@huawei.com>
Date: Sat, 14 Dec 2024 16:37:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/5] kallsyms: Emit symbol for holes in text and fix
 weak function issue
Content-Language: en-US
To: Martin Kelly <martin.kelly@crowdstrike.com>, "masahiroy@kernel.org"
	<masahiroy@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"james.clark@arm.com" <james.clark@arm.com>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "nicolas@fjasle.eu"
	<nicolas@fjasle.eu>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"nathan@kernel.org" <nathan@kernel.org>, "npiggin@gmail.com"
	<npiggin@gmail.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "surenb@google.com" <surenb@google.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "naveen.n.rao@linux.ibm.com"
	<naveen.n.rao@linux.ibm.com>, "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>, "bp@alien8.de" <bp@alien8.de>,
	"yeweihua4@huawei.com" <yeweihua4@huawei.com>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>
CC: Amit Dang <amit.dang@crowdstrike.com>, "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>, "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
 <44353f4cd4d1cc7170d006031819550b37039dd2.camel@crowdstrike.com>
 <364aaf7c-cdc4-4e57-bb4c-f62e57c23279@csgroup.eu>
 <d25741d8a6f88d5a6c219fb53e8aa0bcc1fea982.camel@crowdstrike.com>
 <1f11e3c4-e8fd-d4ac-23cd-0ab2de9c1799@huaweicloud.com>
 <30ee9989044dad1a7083a85316d77b35f838e622.camel@crowdstrike.com>
From: Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <30ee9989044dad1a7083a85316d77b35f838e622.camel@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemo500008.china.huawei.com (7.202.195.163)

On 2024/12/14 03:31, Martin Kelly wrote:
> On Thu, 2024-12-12 at 17:52 +0800, Zheng Yejian wrote:
>> On 2024/12/11 04:49, Martin Kelly wrote:
>>>
>>>
>>> Zheng, do you plan to send a v3? I'd be happy to help out with this
>>> patch series if you'd like, as I'm hoping to get this issue
>>> resolved
>>> (though I am not an ftrace expert).
>>
>> Sorry to rely so late. Thanks for your feedback!
>>
>> Steve recently started a discussion of the issue in:
>>
>> https://lore.kernel.org/all/20241015100111.37adfb28@gandalf.local.home/
>> but there's no conclusion.
>>    
>> I can rebase this patch series and send a new version first, and
>> I'm also hoping to get more feedbacks and help to resolve the issue.
>>
> 
> Hi Zheng,
> 
> I may have misunderstood, but based on the final message from Steven, I
> got the sense that the idea listed in that thread didn't work out and
> we should proceed with your current approach.

This patch set attempts to add length information of symbols to kallsyms,
which can then ensure that there is only one valid fentry within the range
of function length.

However, I think this patch set actually has some performance implications,
including：
   1. Adding hole symbols may cause the symbol table to grow significantly;
   2. When parsing fentry tables, excluding invalid fentries through kallsyms lookups
      may also increase boot or module load times slightly.

The direct cause of this issue is the wrong fentry being founded by ftrace_location(),
following the approach of "FTRACE_MCOUNT_MAX_OFFSET", narrowing down the search range
and re-finding may also solve this problem, demo patch like below (not
fully tested):

     diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
     index 9b17efb1a87d..7d34320ca9d1 100644
     --- a/kernel/trace/ftrace.c
     +++ b/kernel/trace/ftrace.c
     @@ -1678,8 +1678,11 @@ unsigned long ftrace_location(unsigned long ip)
                             goto out;
     
                     /* map sym+0 to __fentry__ */
     -               if (!offset)
     +               if (!offset) {
                             loc = ftrace_location_range(ip, ip + size - 1);
     +                       while (loc > ip && loc - ip > FTRACE_MCOUNT_MAX_OFFSET)
     +                               loc = ftrace_location_range(ip, loc - 1);
     +               }
             }

Steve, Peter, what do you think?

> 
> Please consider me an interested party for this patch series, and let
> me know if there's anything I can do to help speed it along (co-
> develop, test, anything else). And of course, thanks very much for your
> work thus far!

-- 
Thanks,
Zheng Yejian


