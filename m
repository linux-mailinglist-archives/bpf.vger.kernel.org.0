Return-Path: <bpf+bounces-32589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E54910283
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2525BB21B45
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE911AB8E7;
	Thu, 20 Jun 2024 11:27:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4450621A19;
	Thu, 20 Jun 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882849; cv=none; b=I3QDTbPb8Rc7UnZZWzfsp/q9+EALc+VZjerE/K4Ofj7fHAe+kJ9BVxpj0IuYlf5/e9AF1310zpm48PlZGEYPqHyJTA8T8gSbyLsV+TTsdoY9WwP/20WUzwccdMstsicP+GrzPWLCz2PDtfUKAHakwQRtCv3EdTcantHuCc29CFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882849; c=relaxed/simple;
	bh=nU8lEdZZ5H6b2ve8JzNasuCw99ZtNV1kYCetk91R0Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aBqVrTMIEpMb6hLi7nrsr2ZWuBqzjPp2iKBq+AuzzYPcaOMgifkdUw/vj1zOyGpmg4tO2BafAwMIgW5oFW/q+QKgEUbHxM6+N0MuhKgL+/xizih7gUZKiQDwctaX7Ia0CmOEmGs+RncJS6Gkpc22Ug7lbs2EM5YRQOibzItnRoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W4dTQ2qTRzdcLG;
	Thu, 20 Jun 2024 19:25:46 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 76369180087;
	Thu, 20 Jun 2024 19:27:17 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 19:27:16 +0800
Message-ID: <11ae956a-9d0c-ca80-c3a7-a16b2c53e737@huawei.com>
Date: Thu, 20 Jun 2024 19:27:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH bpf-next] uprobes: Fix the xol slots reserved for
 uretprobe trampoline
To: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <nathan@kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20240619013411.756995-1-liaochang1@huawei.com>
 <20240619143852.GA24240@redhat.com>
 <7cfa9f1f-d9ce-b6bb-3fe0-687fae9c77c4@huawei.com>
 <20240620083602.GB30070@redhat.com> <ZnPxFbUJVUQd80hs@krava>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <ZnPxFbUJVUQd80hs@krava>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/6/20 17:06, Jiri Olsa 写道:
> On Thu, Jun 20, 2024 at 10:36:02AM +0200, Oleg Nesterov wrote:
>> On 06/20, Liao, Chang wrote:
>>>
>>> However, when i asm porting uretprobe trampoline to arm64
>>> to explore its benefits on that architecture, i discovered the problem that
>>> single slot is not large enought for trampoline code.
> 
> ah ok, makes sense now.. x86_64 has the slot big enough for the trampoline,
> but arm64 does not
> 
>>
>> Ah, but then I'd suggest to make the changelog more clear. It looks as
>> if the problem was introduced by the patch from Jiri. Note that we was
>> confused as well ;)
>>
>> And,
>>
>> 	+	/* Reserve enough slots for the uretprobe trampoline */
>> 	+	for (slot_nr = 0;
>> 	+	     slot_nr < max((insns_size / UPROBE_XOL_SLOT_BYTES), 1);
>> 	+	     slot_nr++)
>>
>> this doesn't look right. Just suppose that insns_size = UPROBE_XOL_SLOT_BYTES + 1.
>> I'd suggest DIV_ROUND_UP(insns_size, UPROBE_XOL_SLOT_BYTES).
>>
>> And perhaps it would be better to send this change along with
>> uretprobe_trampoline_for_arm64 ?
> 
> +1, also I'm curious what's the gain on arm64?

I am currently finalizing the uretprobe trampoline and syscall implementation on arm64.
While i have addressed most of issues, there are stiil a few bugs that reguire more effort.
Once these are fixed, i will use Redis to evaluate the performance gains on arm64. In the
next revision, i will submit a patchset that includes all relevant code changs, testcases
and benchmark data, which will allows a comprehensive review and dicussion.

> 
> thanks,
> jirka

-- 
BR
Liao, Chang

