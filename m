Return-Path: <bpf+bounces-62464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8D8AF9E52
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 06:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00E7543F3E
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 04:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A162272E7F;
	Sat,  5 Jul 2025 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gkP1Es9f"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7C1E8345;
	Sat,  5 Jul 2025 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751691187; cv=none; b=jMDIBTLVPS9U5B/748C01HyxJMtIFlSDGTZGFpsAapTJYMzz96MGcvCZseQw92+bu/ozFAsEGHJ49pUrQi6FSL1E274Y1HyhTjwwgADTi1ikMNqtuRrqAwFBxLFJAj/rbvBfWfGQ22Wp0bxMUayIy0dC8JtIo6sJG+yfQuxX+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751691187; c=relaxed/simple;
	bh=LiMemUJtXNNV/GBQRO0lYPu9IYQxwTYih8di6bOFILw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAKFnTz9KQ6CF9L28nGj14V+5gSDYKbVxiWPfrGODi3Tbdpd0o8H70D6Ydgf9bNllcNPx97RAwwPbvY9oNv7AufSZRDAlrU7tk1ukbO8CYS9vB3EpHxeKUz8PcTf47ufY031+sURCRQQI+Xp5xTi1Kfejjn9SAqGB603BtTaaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gkP1Es9f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=rsqiq6A8D5Ym1/QAtW0mPwsfEGt9jk+qM1g61X2FR3Y=; b=gkP1Es9fUcQF2tQGxTaQg+H7Se
	VU287WSHGNESsqai/fq8IzK5Xf3GL9SSs5loTIsNM1QMQRGF4SiDlBbxriVUIuYqp+G+5yYvUofNC
	QZC2/RbpPsQGRPdkbg4bwWMqUeEJaO0cBK9+ohxTD+gGmCOCLGrjXxTpIvT0d2+P9W5AQhloU57P/
	I4VGZ/bLgs/tsay6tlYZaaGNH6IyLNaOT5Of8nuVmXjzM8P9t6LYq/qU/JfCk6+gSxG9ba19zWJLJ
	aJhyiFiknlJCFMw0OBKp/JetuXN1zsRcKOhjMAx5tt2B5dSaUcVAvduPC8m5thz15LZksns8uf9ff
	o4g2zqAA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXutZ-000000020XQ-0lCX;
	Sat, 05 Jul 2025 04:53:01 +0000
Message-ID: <d5136da0-51f9-4359-a283-9075b4992bfb@infradead.org>
Date: Fri, 4 Jul 2025 21:52:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 4 (kernel/bpf/stream.c)
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bot@kernelci.org,
 kernelci@lists.linux.dev
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org
References: <20250704205116.551577e4@canb.auug.org.au>
 <5496b723-440f-451b-b101-f0c7c971fc9b@infradead.org>
 <f06082bf-27b5-488d-b484-fecc100014a1@infradead.org>
 <CAP01T77AWoBqDgOPpmmcL5tQFqNa8W3rxBDB+Er0J5rxogCrVA@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAP01T77AWoBqDgOPpmmcL5tQFqNa8W3rxBDB+Er0J5rxogCrVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/4/25 9:44 PM, Kumar Kartikeya Dwivedi wrote:
> On Sat, 5 Jul 2025 at 01:38, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 7/4/25 4:35 PM, Randy Dunlap wrote:
>>>
>>>
>>> On 7/4/25 3:51 AM, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Changes since 20250703:
>>>>
>>>
>>> on i386:
>>>
>>> kernel/bpf/stream.c: In function 'dump_stack_cb':
>>> kernel/bpf/stream.c:501:53: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>>   501 |                                                     (void *)ip, line, file, num);
>>>       |                                                     ^
>>> ../kernel/bpf/stream.c:505:64: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>>   505 |         ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
>>>       |
>>>
>>>
>>
>> Also reported (earlier) here:
>>
>>   https://lore.kernel.org/linux-next/CACo-S-16Ry4Gn33k4zygRKwjE116h1t--DSqJpQfodeVb0ssGA@mail.gmail.com/T/#u
>>
> 
> Thanks, I will share a fix soon. Could the bot also Cc the author of
> the commit using git blame?

I added the email address for the bot. We'll see if it can read email.

-- 
~Randy


