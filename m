Return-Path: <bpf+bounces-46698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFFD9EE377
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 10:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3948C163A0F
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C4D210185;
	Thu, 12 Dec 2024 09:52:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622213CF9C;
	Thu, 12 Dec 2024 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997136; cv=none; b=NHB5O3+ueMnYAOVGv7TU/YBbYVU6VvQYtx6Kjlgh+fkRHaIEvr+E366dgTEmFcb2FxRwqIs6JKoFr8rEHRYoaMP6NeEN+FtcRVAszhug6AQ2Si7c1DOGjcWD8EhiVLo4YpMA5j12//Y0WswCDh+3NOZqN1S9NFHp4smfR3nFWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997136; c=relaxed/simple;
	bh=+8uKDmRN4MfGNUlWvlfKZ1BxyRgnmiW8rTEDTQe+kkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pW4yHRhHqTBucXTKvVJyov8Kg7AvV3CE/JlzuvkTEZHNyygAOujYKT9eO83H6ubtKVWv2xLzwmzx3C42NpgvX9cr2v67r/JFtfAHWcjmdWU7aLa3/FzDcqsyUJEUbhlIBO5GAjlnKefEYctpxWpSIa02ujyB8kVNna87SlyBIAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y876M1Z5jz4f3jqx;
	Thu, 12 Dec 2024 17:51:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7A6091A06D7;
	Thu, 12 Dec 2024 17:52:09 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgCXcYVDslpnkZaEEQ--.63144S3;
	Thu, 12 Dec 2024 17:52:04 +0800 (CST)
Message-ID: <1f11e3c4-e8fd-d4ac-23cd-0ab2de9c1799@huaweicloud.com>
Date: Thu, 12 Dec 2024 17:52:03 +0800
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
To: Martin Kelly <martin.kelly@crowdstrike.com>,
 "masahiroy@kernel.org" <masahiroy@kernel.org>,
 "ojeda@kernel.org" <ojeda@kernel.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "james.clark@arm.com" <james.clark@arm.com>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "nathan@kernel.org" <nathan@kernel.org>,
 "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "nicolas@fjasle.eu" <nicolas@fjasle.eu>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, "hpa@zytor.com"
 <hpa@zytor.com>, "surenb@google.com" <surenb@google.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
 "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
 "bp@alien8.de" <bp@alien8.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
 Ye Weihua <yeweihua4@huawei.com>
Cc: Amit Dang <amit.dang@crowdstrike.com>,
 "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
 <44353f4cd4d1cc7170d006031819550b37039dd2.camel@crowdstrike.com>
 <364aaf7c-cdc4-4e57-bb4c-f62e57c23279@csgroup.eu>
 <d25741d8a6f88d5a6c219fb53e8aa0bcc1fea982.camel@crowdstrike.com>
From: Zheng Yejian <zhengyejian@huaweicloud.com>
In-Reply-To: <d25741d8a6f88d5a6c219fb53e8aa0bcc1fea982.camel@crowdstrike.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXcYVDslpnkZaEEQ--.63144S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww48WrWrXF4DKF4ftr43Wrg_yoW8XrWrpF
	WfKFW5CF4DCF48J3Z2krs7ZF1Yyws3W3y7Wwn8Jw1UurZ8JFy3Ar4Sqr4jgrWDZF93Ww4U
	ZF17tF95X34kZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU0EksDUUUUU==
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

On 2024/12/11 04:49, Martin Kelly wrote:
> On Tue, 2024-12-10 at 21:01 +0100, Christophe Leroy wrote:
>>>
>>> Hi all, what is the status of this patch series? I'd really like to
>>> see
>>> it or some other fix to this issue merged. The underlying bug is a
>>> significant one that can cause ftrace/livepatch/BPF fentry to fail
>>> silently. I've noticed this bug in another context[1] and realized
>>> they're the same issue.
>>>
>>> I'm happy to help with this patch series to address any issues as
>>> needed.
>>
>> As far as I can see there are problems on build with patch 1, see
>> https://patchwork.kernel.org/project/linux-modules/patch/20240723063258.2240610-2-zhengyejian@huaweicloud.com/
>>   
>>
>>
> 
> Yeah, I see those. Additionally, this patch no longer applies cleanly
> to current master, though fixing it up to do so is pretty easy. Having
> done that, this series appears to resolve the issues I saw in the other
> linked thread.
> 
> Zheng, do you plan to send a v3? I'd be happy to help out with this
> patch series if you'd like, as I'm hoping to get this issue resolved
> (though I am not an ftrace expert).

Sorry to rely so late. Thanks for your feedback!

Steve recently started a discussion of the issue in:
https://lore.kernel.org/all/20241014210841.5a4764de@gandalf.local.home/
but there's no conclusion.
  
I can rebase this patch series and send a new version first, and
I'm also hoping to get more feedbacks and help to resolve the issue.

-- 
Thanks,
Zheng Yejian


