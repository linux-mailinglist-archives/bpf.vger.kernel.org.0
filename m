Return-Path: <bpf+bounces-55094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F16A781FA
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 20:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DDC1888C60
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A9920E318;
	Tue,  1 Apr 2025 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JJsZlB0Y"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B079FE
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531253; cv=none; b=CwWQNlAtvyak88y1n1iRP1p/dCt05VlHUnzOLnAYgjn7V+/FUcQT2B3TAg+X4pxF01vV55xviOoJCZQNE0IyyyV7As2UU/6ErdktXTPnta5QsHuKb1ji7XgovsfYvGf53vqHXIqfEY/Zl8aWW3v+ls7SNdqa0vCeqV39M8UJSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531253; c=relaxed/simple;
	bh=wnsAGKNDcDr00ugHa9ohNnrc92iy/iLWi2gfw5u8Cbw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Q8YZedhP0Fe6aHAVkYv4FSR15+Uiulfx6NTWBNSYAP6u7ZvANkfRZFbTlwu6GiAhslfa+zDcm7qPM266BYrPKLAZWvG/kQ7Npwj8BV9t+22WPMdPo2ScTmsRtE07C9A68HiltMt/iVwf6/o/2lzJPPy9ysesdam0Had1Dn+UguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JJsZlB0Y; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743531249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnsAGKNDcDr00ugHa9ohNnrc92iy/iLWi2gfw5u8Cbw=;
	b=JJsZlB0YV4iBrvX8pY1qdwbHpFchMoYtp34Q6KFQuFBr1+/mBiJuKaTALn9iTAZdGZWatZ
	6/76knrsAmPA381ylgdq8A7I7gacHTKBDNVivYbY6FV+ojzoWQn2DL5MUdmKVyccrMEwp0
	bo6+EZl4msHmfmV3SW7vrLvPUi1gCFg=
Date: Tue, 01 Apr 2025 18:14:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <87cd6084224598546f4711c36ad506a77009664e@linux.dev>
TLS-Required: No
Subject: Re: s390x: selftests/bpf are failing on CI
To: "Vasily Gorbik" <gor@linux.ibm.com>, "iii" <iii@imap.linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Song Liu" <song@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, bpf@vger.kernel.org, kernel-team@meta.com,
 "Sumanth Korikkar" <sumanthk@linux.ibm.com>, "Heiko Carstens"
 <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <your-ad-here.call-01743522822-ext-4975@work.hours>
References: <7adb418e282468fcd5dc10c05790614e622579d4@linux.dev>
 <7d55acbf6e6b20f9e8d679883c1e77391e80b304@linux.dev>
 <1199a2932ed1800fa0a898e67ba74590@imap.linux.ibm.com>
 <a1b5ac5e01e50a6f3dc1047a08b725d6@imap.linux.ibm.com>
 <your-ad-here.call-01743522822-ext-4975@work.hours>
X-Migadu-Flow: FLOW_OUT

On 4/1/25 8:53 AM, Vasily Gorbik wrote:
> On Tue, Apr 01, 2025 at 05:16:28PM +0200, iii wrote:
>> On 2025-04-01 10:06, iii wrote:
>>> On 2025-04-01 00:45, Ihor Solodrai wrote:
>>>> On 3/31/25 3:25 PM, iii wrote:
>>>>> On 2025-03-31 20:25, Ihor Solodrai wrote:
>>>>>> Hi Ilya,
>>>>>>
>>>>>> After recent merges from upstream, CI started failing both
>>>>>> on bpf and
>>>>>> bpf-next trees. Yonghong Song and Song Liu submitted a
>>>>>> couple of fixes
>>>>>> that are already applied to bpf tree, but there are still
>>>>>> failures on
>>>>>> s390x.
>>>>>>
>>>>>> https://github.com/kernel-patches/bpf/actions/runs/14163772245
>>>>>>
>>>>>> Could you please investigate?
>>>>>>
>>>>>> [...]
>>
>> I could not reproduce this on a s390x machine, so I downloaded the CI
>> artifacts and noticed that
>> /sys/kernel/debug/tracing/available_filter_functions is empty.
>> Turns out this is caused by cross-compilation.
>> I have let our kernel team (on Cc:) know and they will investigate thi=
s
>> further.
>
> There must be an endianness issue in the sorttable tool. Reverting just
> the commit fa1518875286 ("s390: Sort mcount locations at build time")
> fixes the issue. I'll take a look.

Hi Vasily.

I can confirm that reverting fa1518875286 fixes the selftests
failures. I added a revert commit as a CI-specific patch for now.

Please keep me in cc.

Thank you for the help!

