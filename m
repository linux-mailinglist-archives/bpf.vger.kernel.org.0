Return-Path: <bpf+bounces-51989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61494A3CB2D
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D30D1892EC5
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD4C255E35;
	Wed, 19 Feb 2025 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dADgGXrt"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DA24FBE8
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999563; cv=none; b=TGiCC2GUD/SZ/b5luBb9PVQ/9vdY0FAX1aLJVGZS/G1ryxneE/A+r8Dttyu4/iLikW3OVK5sfVdZE8RrS4hny5LcFqQwlLrRW27OV7dPo7i6LZEy/Fz++PaQolrMMGJoz49flVTXYe03wZxkdAqCjYPzRCBwtnFisJPYpaphmEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999563; c=relaxed/simple;
	bh=auzO+pa68P9lX4nJ6rWx5NXa3Hb+7X6MKykJ8Hni9l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+I8U4DWXhjIpaLFqgTIaDVHv0pEVQVkX6yUX68gMF/RQwTafn3x+BMMrwFA5+4S5ULDR3Vr4WU+x91tg4T6U019yGYk/Cqf5uiBEd1Ap0Cad1BIDM4KulMutnLVvxu7AdV6TQwSxFlxWPAFFUISu4qfulLpyYZ/zh84iPU7zZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dADgGXrt; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44e56c1a-3445-4cae-abdb-76ada1084193@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739999559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpU9LMPluU4o0fBhrfV+lUYxw3TckvjTTYAStKf3b+0=;
	b=dADgGXrte+KmsvzmgIoxKazwIL0BhE+KkZTu+OJ5hw+zlZrVvoWFl7re+FrWzsQvrFpRCw
	DmJ7parD2InZLwzpQ4NjSBJTUv72foL2BjyI2gE/1fkiMcgsPein6uGFJ2BDVPK7V/Ysw2
	vtk51vTTHYcxUMvOhpUOiA4a7RB+YQs=
Date: Wed, 19 Feb 2025 13:12:24 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/2] bpf: support setting max RTO for
 bpf_setsockopt
To: Daniel Xu <dlxu@meta.com>, Jason Xing <kerneljasonxing@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: kernel-ci <kernel-ci@meta.com>, "andrii@kernel.org" <andrii@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 "bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>
References: <20250219081333.56378-1-kerneljasonxing@gmail.com>
 <38bb5556f4c90c7d4fbe9933ba3984136f5f3d5cf8d95e4f4bc6cbfb02e1e019@mail.kernel.org>
 <CAL+tcoDZAwZojcMQZ_bc71bxDpdfSE=q5_6eXirZLEWXFnY33w@mail.gmail.com>
 <bfc930d1-4a96-47c1-a250-e53dfe7a153f@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <bfc930d1-4a96-47c1-a250-e53dfe7a153f@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/19/25 8:33 AM, Daniel Xu wrote:
> Hi Jason,
> 
> On 2/19/25 12:44 AM, Jason Xing wrote:
>> On Wed, Feb 19, 2025 at 4:27 PM <bot+bpf-ci@kernel.org> wrote:
>>> Dear patch submitter,
>>>
>>> CI has tested the following submission:
>>> Status:     FAILURE
>>> Name:       [bpf-next,v3,0/2] bpf: support setting max RTO for bpf_setsockopt
>>> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=935463&state=*
>>> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/13408235954
>>>
>>> Failed jobs:
>>> build-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/13408235954/job/37452248960
>>> build-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/13408235954/job/37452248633
>>> build-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/13408235954/job/37452249287
>>> build-x86_64-llvm-17: https://github.com/kernel-patches/bpf/actions/runs/13408235954/job/37452250339
>>> build-x86_64-llvm-17-O2: https://github.com/kernel-patches/bpf/actions/runs/13408235954/job/37452250688
>>> build-x86_64-llvm-18: https://github.com/kernel-patches/bpf/actions/runs/13408235954/job/37452251018
>>> build-x86_64-llvm-18-O2: https://github.com/kernel-patches/bpf/actions/runs/13408235954/job/37452251311
>>>
>>>
>>> Please note: this email is coming from an unmonitored mailbox. If you have
>>> questions or feedback, please reach out to the Meta Kernel CI team at
>>> kernel-ci@meta.com.
>> I think the only diff I made is that I removed the change in
>> tools/include/uapi/linux/bpf.h from V2.
>> diff --git a/tools/include/uapi/linux/tcp.h b/tools/include/uapi/linux/tcp.h
>> index 13ceeb395eb8..7989e3f34a58 100644
>> --- a/tools/include/uapi/linux/tcp.h
>> +++ b/tools/include/uapi/linux/tcp.h
>> @@ -128,6 +128,7 @@ enum {
>>    #define TCP_CM_INQ             TCP_INQ
>>
>>    #define TCP_TX_DELAY           37      /* delay outgoing packets by XX usec */
>> +#define TCP_RTO_MAX_MS         44      /* max rto time in ms */
>>
>> Last time everything was fine. I doubt it has something to do with the
>> failure :S

kernel should not need tools/include, so no.

>>
>> But I tested it locally and could not reproduce it. Could it be caused
>> because of applying to a wrong branch? I'm afraid not, right?

Right, in v2, the patch 1 cannot be applied to bpf-next/master, so the bpf CI 
retried with bpf-next/net. It is the current bpf CI setup.

That v2's patch 1 is removed in v3, so the v3 applied cleanly to bpf-next/master 
and the bpf CI moved forward to test it.

I tested locally and I have applied v3 to bpf-next/net. Thanks.

May be the bpf CI can retry with bpf-next/net also there is kernel compilation 
error.

