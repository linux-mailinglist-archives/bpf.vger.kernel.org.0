Return-Path: <bpf+bounces-65897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8980CB2AEAC
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 18:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032471B66AC3
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496DE3469F4;
	Mon, 18 Aug 2025 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PyTqyfxu"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9EB34575C
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536291; cv=none; b=WIEqeqQQiIgRkQ2U0GthIvyxm7bQLIu0IHOSkXksbrEUOOw+BIhn5ae7liBdgASiZiPC5h4lHRAvHYL07wMp1nlYTjTeN2l87RCHBIzT7h+kkVUZumaTU1WWt8JSpaZs5P/d2wMdlw5fw865yuoXzTkMTVln5ftBMSQSoKwR5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536291; c=relaxed/simple;
	bh=qB/du4+h2BkGKxRvI2dz0qnKLCK7vF6NJAAjOWk1BYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAt104U6KVNoyUsfi1mNgqnnozH5goPeUcclkBn+2I5wk8hXW2RIjemtXy6npbRnWv18a4pfIqhcshX6D1/qCUQ74cGSTys5lHog2p4hBJdGYotzPlSNiGycAwQmcVhqcKWF7IhcipTdWBeLsn9Qk605s9XSWJr29A5eDIdQPp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PyTqyfxu; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca5b2f4a-f92d-4749-9abe-c2af9254addc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755536287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xb5yUldNbugtkzzc/SK7w3Fc0K4g0SP0ZrQ6qmuZw14=;
	b=PyTqyfxuY/eyV4S6ke+l490nfXsc7BS5wvC0hyaDaSZoC8eyPdX9XFAthyci8oTSFPvYHx
	3wsDy2TdjRqOJbh8W0QC8IAyX2KWt+S8FFUneTq9k11I1lOCGzZWlb/uzCsQTCjHn77APq
	aZ2aoV6behH3L4Gu0OdMR/RpLnLikwQ=
Date: Mon, 18 Aug 2025 09:57:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Content-Language: en-GB
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>, song@kernel.org,
 jolsa@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250813204606.167019-1-contact@arnaud-lcm.com>
 <20250813205506.168069-1-contact@arnaud-lcm.com>
 <07d849b2-67c2-40b2-9cd3-75b8f3a4e0a6@arnaud-lcm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <07d849b2-67c2-40b2-9cd3-75b8f3a4e0a6@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/18/25 6:49 AM, Lecomte, Arnaud wrote:
> Hey,
> Just forwarding the patch to the associated maintainers with 
> `stackmap.c`.

Arnaud, please add Ack (provided in comments for v3) to make things easier
for maintainers.

Also, looks like all your patch sets (v1 to v4) in the same thread.
It would be good to have all these versions in separate thread.
Please look at some examples in bpf mailing list.

> Have a great day,
> Cheers
>
> On 13/08/2025 21:55, Arnaud Lecomte wrote:
>> Syzkaller reported a KASAN slab-out-of-bounds write in 
>> __bpf_get_stackid()
>> when copying stack trace data. The issue occurs when the perf trace
>>   contains more stack entries than the stack map bucket can hold,
>>   leading to an out-of-bounds write in the bucket's data array.
>>
>> Changes in v2:
>>   - Fixed max_depth names across get stack id
>>
>> Changes in v4:
>>   - Removed unnecessary empty line in __bpf_get_stackid
>>
>> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>> ---
>>   kernel/bpf/stackmap.c | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
[...]


