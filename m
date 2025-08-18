Return-Path: <bpf+bounces-65913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD07B2AEF1
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 19:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FE21BA3D75
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1790A32C335;
	Mon, 18 Aug 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="adW9Plt4"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD732C321
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536580; cv=none; b=aHkFhiijU6OITdT6FX4mwOqOsNOlKF6Gpl97ebyTk637aQZy3CVDUJtTEkklqX2Cn5bFoshkl1RyKHtqhrpwRPvYYBkgYuL1tTsgIcLafvx0sN1CDn0blBLNNJ/bCfgycOxoL/w1SUgWOtf1zuEwpah9RzfA6Lpbd0ASEkCuLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536580; c=relaxed/simple;
	bh=AcHBm4APEi3sdXhmN4WXx60+SUdPd+z/O8N3BsZLTIY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A7MBs3cJJn4xalyQKJjichfCgx2KoZhwpGmZ/KVvk66MNIostFSlHDR69dmrNMcKqyEY2UkZ9AhcKdM8cg/r1AqfXhQKmOYsM7SoCSMTtN6Od7h5GUGggX8ktahmSE3ifHJUdp99bjvIwo2ajHNSfKCGL/oouZfPldGq2ICKc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=adW9Plt4; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae450780-f2a9-46fc-8e49-3528ff2e5daa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755536577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LmMGy7HSKihP9lQaYXfWbPIJLBdvs2p07iKRH6zNAo=;
	b=adW9Plt41n1KE+VR1zmHNwyxZLJjr0IGtLFx7Yk9NfMdKY/Y9bjMjNNe+EPZ2pMhTOMnLH
	DUAkVi4LWiwDemngfY+DBQLLeQssAKaDICNRoDKkxZMZSbw0wE0pn09vg/l+V0p8R+CwU2
	4HCDb6AexFxaaviXWH6oJhGrImpMmms=
Date: Mon, 18 Aug 2025 10:02:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
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
 <ca5b2f4a-f92d-4749-9abe-c2af9254addc@linux.dev>
In-Reply-To: <ca5b2f4a-f92d-4749-9abe-c2af9254addc@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/18/25 9:57 AM, Yonghong Song wrote:
>
>
> On 8/18/25 6:49 AM, Lecomte, Arnaud wrote:
>> Hey,
>> Just forwarding the patch to the associated maintainers with 
>> `stackmap.c`.
>
> Arnaud, please add Ack (provided in comments for v3) to make things 
> easier
> for maintainers.
>
> Also, looks like all your patch sets (v1 to v4) in the same thread.

sorry, it should be v3 and v4 in the same thread.

> It would be good to have all these versions in separate thread.
> Please look at some examples in bpf mailing list.
>
>> Have a great day,
>> Cheers
>>
>> On 13/08/2025 21:55, Arnaud Lecomte wrote:
>>> Syzkaller reported a KASAN slab-out-of-bounds write in 
>>> __bpf_get_stackid()
>>> when copying stack trace data. The issue occurs when the perf trace
>>>   contains more stack entries than the stack map bucket can hold,
>>>   leading to an out-of-bounds write in the bucket's data array.
>>>
>>> Changes in v2:
>>>   - Fixed max_depth names across get stack id
>>>
>>> Changes in v4:
>>>   - Removed unnecessary empty line in __bpf_get_stackid
>>>
>>> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>>> ---
>>>   kernel/bpf/stackmap.c | 23 +++++++++++++----------
>>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>>
> [...]
>
>


