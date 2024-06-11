Return-Path: <bpf+bounces-31796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467459037FC
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70B8288857
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 09:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638A178367;
	Tue, 11 Jun 2024 09:36:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C8176FC9;
	Tue, 11 Jun 2024 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098618; cv=none; b=FD9+ClsD4SrEGaPJHzjqoppAcTFCHD69k0wVwKIjtWinPIDFOqSm0Kmo+tym5dcKoZXCGd3SGhJSAvxog0nib1LWmHevjm8iLrhUdMNgdubihGwadDI5gS/E1l6DJYuILZLaEB6CXGdrycWgfGkWWXMzmpeoStn7auUfmNKk9j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098618; c=relaxed/simple;
	bh=q+pnA94jVzMSLj4z6FXJf6PzzV6xwk04ttDNDlMYGio=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qWsFh4p0FHaDEorGk0oAjO1AsNjxqSif4JDsR55N4uaobO5kJ0poAzP5b59lwIEchmAnrjSaIAMaaDlaYeK0uMN2AIXlo1l793RGJ1/+FDAbJNR2L4MHgnq/f3MleRA0+Lfpun1MNyRYUmfxMmkFT2+/afBeAvm/VE9tKZQ/LMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Vz3PT4NTzz3560P;
	Tue, 11 Jun 2024 17:33:01 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 161E5180065;
	Tue, 11 Jun 2024 17:36:48 +0800 (CST)
Received: from [10.67.111.172] (10.67.111.172) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 17:36:47 +0800
Message-ID: <d0743ed8-d26c-3471-ed5d-66ec9e46db5e@huawei.com>
Date: Tue, 11 Jun 2024 17:36:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH] ftrace: Skip __fentry__ location of overridden weak
 functions
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
CC: <rostedt@goodmis.org>, <mcgrof@kernel.org>, <mhiramat@kernel.org>,
	<mark.rutland@arm.com>, <mathieu.desnoyers@efficios.com>,
	<jpoimboe@kernel.org>, <linux-modules@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20240607115211.734845-1-zhengyejian1@huawei.com>
 <20240607150228.GR8774@noisy.programming.kicks-ass.net>
 <57e499a4-e26d-148f-317d-233e873d11b4@huawei.com>
 <20240611092157.GU40213@noisy.programming.kicks-ass.net>
From: Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20240611092157.GU40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)

On 2024/6/11 17:21, Peter Zijlstra wrote:
> On Tue, Jun 11, 2024 at 09:56:51AM +0800, Zheng Yejian wrote:
>> On 2024/6/7 23:02, Peter Zijlstra wrote:
> 
>>> Oh gawd, sodding weak functions again.
>>>
>>> I would suggest changing scipts/kallsyms.c to emit readily identifiable
>>> symbol names for all the weak junk, eg:
>>>
>>>     __weak_junk_NNNNN
>>>
>>
>> Sorry for the late reply, I just had a long noon holiday :>
>>
>> scripts/kallsyms.c is compiled and used to handle symbols in vmlinux.o
>> or vmlinux.a, see kallsyms_step() in scripts/link-vmlinux.sh, those
>> overridden weak symbols has been removed from symbol table of vmlinux.o
>> or vmlinux.a. But we can found those symbols from original xx/xx.o file,
>> for example, the weak free_initmem() in in init/main.c is overridden,
>> its symbol is not in vmlinx but is still in init/main.o .
>>
>> How about traversing all origin xx/xx.o and finding all weak junk symbols ?
> 
> You don't need to. ELF symbl tables have an entry size for FUNC type
> objects, this means that you can readily find holes in the text and fill
> them with a symbol.
> 
> Specifically, you can check the mcount locations against the symbol
> table and for every one that falls in a hole, generate a new junk
> symbol.
> 
> Also see 4adb23686795 where objtool adds these holes to the
> ignore/unreachable code check.
> 
> 
> The lack of size for kallsyms is in a large part what is causing the
> problems.

Thanks for your suggestions, I'll try it soon.

--

Thanks,
ZYJ

