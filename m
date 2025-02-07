Return-Path: <bpf+bounces-50739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC1CA2B98D
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 04:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B663A504C
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1E3169AE6;
	Fri,  7 Feb 2025 03:16:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3DEC2;
	Fri,  7 Feb 2025 03:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738898189; cv=none; b=B4EIXQa8RamwklJjuOg0Zf6aJBS9k779d0rGFMBjA9CmQUX9AsRTv99CSiNcE3dEVg4X/s9Rp9bctLLyqzS5k4USDrrrTSKjgR56mmUFmoH97vx6yc+TsSonYSVgoSIAVUIFfgn+dE+C4HE6enumOVj8RFRYm7GNGBGQtR0a3J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738898189; c=relaxed/simple;
	bh=imVNjlg3Gf1NU+7JQ+YG/FECtUN4wr+QiJzHYasDJRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oRm9zJ0NIY5q6X+LW0VdBGRukIgqld1BvhfkSDGJGaUgLhFIdBt7QbxwJaVe+RG+XZcv1bqf6oR702PZL4+k42Z6RUPNj4blhyZZ+vgsDj0SLs1DVcIwsMRxzt6ca2O0IY5lWn/nLRiMFuygAqo9IyZT5U26inYyfxnBJH2AasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YpzZR55hNzmZB8;
	Fri,  7 Feb 2025 11:13:35 +0800 (CST)
Received: from kwepemo500008.china.huawei.com (unknown [7.202.195.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B6C41400DD;
	Fri,  7 Feb 2025 11:16:23 +0800 (CST)
Received: from [10.67.111.172] (10.67.111.172) by
 kwepemo500008.china.huawei.com (7.202.195.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Feb 2025 11:16:21 +0800
Message-ID: <7960f4a0-e45e-7cfd-fa36-97732139d238@huawei.com>
Date: Fri, 7 Feb 2025 11:16:21 +0800
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
To: Steven Rostedt <rostedt@goodmis.org>
CC: Martin Kelly <martin.kelly@crowdstrike.com>, "masahiroy@kernel.org"
	<masahiroy@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"james.clark@arm.com" <james.clark@arm.com>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"nicolas@fjasle.eu" <nicolas@fjasle.eu>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "nathan@kernel.org" <nathan@kernel.org>,
	"npiggin@gmail.com" <npiggin@gmail.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "hpa@zytor.com" <hpa@zytor.com>, "surenb@google.com"
	<surenb@google.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>, "bp@alien8.de"
	<bp@alien8.de>, "yeweihua4@huawei.com" <yeweihua4@huawei.com>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, Amit Dang
	<amit.dang@crowdstrike.com>, "linux-modules@vger.kernel.org"
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
 <7266ee61-3085-74fc-2560-c62fc34c2148@huawei.com>
 <20250121124851.2205a8b2@gandalf.local.home>
Content-Language: en-US
From: Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20250121124851.2205a8b2@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemo500008.china.huawei.com (7.202.195.163)

On 2025/1/22 01:48, Steven Rostedt wrote:
> 
> Sorry for the late reply. Forgot about this as I was focused on other end-of-year issues.
> 
> On Sat, 14 Dec 2024 16:37:59 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>> The direct cause of this issue is the wrong fentry being founded by ftrace_location(),
>> following the approach of "FTRACE_MCOUNT_MAX_OFFSET", narrowing down the search range
>> and re-finding may also solve this problem, demo patch like below (not
>> fully tested):
>>
>>       diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>>       index 9b17efb1a87d..7d34320ca9d1 100644
>>       --- a/kernel/trace/ftrace.c
>>       +++ b/kernel/trace/ftrace.c
>>       @@ -1678,8 +1678,11 @@ unsigned long ftrace_location(unsigned long ip)
>>                               goto out;
>>       
>>                       /* map sym+0 to __fentry__ */
>>       -               if (!offset)
>>       +               if (!offset) {
>>                               loc = ftrace_location_range(ip, ip + size - 1);
>>       +                       while (loc > ip && loc - ip > FTRACE_MCOUNT_MAX_OFFSET)
>>       +                               loc = ftrace_location_range(ip, loc - 1);
>>       +               }
>>               }
>>
>> Steve, Peter, what do you think?
> 
> Hmm, removing the weak functions from the __mcount_loc location should also
> solve this, as the ftrace_location_range() will not return a weak function
> if it's not part of the __mcount_loc table.
> 
> That is, would this patchset work?
> 
>    https://lore.kernel.org/all/20250102232609.529842248@goodmis.org/

I only pick patch15 and patch16 into v6.14-rc1, since most of patches in that patches
have already merged, and the issue seems gone, thanks!

> 
> -- Steve

-- 
Thanks,
Zheng Yejian


