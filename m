Return-Path: <bpf+bounces-55051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477C6A776DF
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 10:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD99188A156
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A1B1EB5F0;
	Tue,  1 Apr 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="T7/MJBWl"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0BB1EA7E6;
	Tue,  1 Apr 2025 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497398; cv=none; b=N4taodFtUDedbDKYzhCOfpKZkSe+NZ1a+LWrJRqo0Pq34x4/ZG/Vn5oOhIHl1rQylgJ+gCPOqWtRwdqUtvOdM+Wo/0e/3eauskq+WiJ+IL6ijS5TYVfmusZinHl5JeMmra+a0II1NR4gT8C4EZSIvO2euWssJLvDdE7odWyWvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497398; c=relaxed/simple;
	bh=8Wpy81kT7TAdW80xAypJxb8zwA8ToD3dhvNI1DF5/tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MDHZ3AKxXOuDJKf89q7rDqsJt9T+lIbNuJRiNttcWEF4qhPrGNEmR4ebzYAFedNJrwLjtZpDcdpGeTVsOHJyURUcwAF0dx9OcLlEVIdvHZwWYNtRj3iBEHqhtV4MtLqQMD0JYWJarKeaE/bdqS2hoqXtQSlxKyhd/No8BN/ju20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=T7/MJBWl; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id C26F12022C81;
	Tue,  1 Apr 2025 10:44:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be C26F12022C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1743497063;
	bh=NMSewLCZVUlqvdalC/wCq7Jj67bLVDUUghgF0Nt7r8c=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=T7/MJBWlQgQ9eXP1jb+DAibnpmulCgGaRuhoxYXSKesrBxHk1XLhjfIONyOGvQ0Su
	 NS7B071ZfjwKB6JXUZIdCfafnFNzJPy3DfK45usDGUvWb+6RtlaqMYqUb4YHrDWbqv
	 uC4MToKCoetoKmiRp/7lr0PSQYvxT/lUW9WMJSESH+5qvqxcHvffVqy/YcY/s12s8G
	 IK7Z+BWHM7HBhUbvnEW5XJuUgwCKhqIeL1Tap9bUrZEmQB8XClZ4gBokPo+i1ZE7u4
	 kczS0N2Zgel3MF2GvwC30lPwMGtmFNyxKJmR9lLEw6dmEGboK966XVNAmqt/bVWKCT
	 xC7ciQ6Okvq5g==
Message-ID: <d24ea1cc-4d32-44f9-9051-0c874f73f1c5@uliege.be>
Date: Tue, 1 Apr 2025 10:44:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: new splat
To: Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <CAADnVQJFWn3dBFJtY+ci6oN1pDFL=TzCmNbRgey7MdYxt_AP2g@mail.gmail.com>
 <647c3886-72fd-4e49-bdd0-4512f0319e8c@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <647c3886-72fd-4e49-bdd0-4512f0319e8c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/25 10:07, Paolo Abeni wrote:
> Adding Justin.
> 
> On 3/31/25 1:28 AM, Alexei Starovoitov wrote:
>> After bpf fast forward we see this new failure:
>>
>> [  138.359852] BUG: using __this_cpu_read() in preemptible [00000000]
>> code: test_progs/9368
>> [  138.362686] caller is lwtunnel_xmit+0x1c/0x2e0
>> [  138.364363] CPU: 9 UID: 0 PID: 9368 Comm: test_progs Tainted: G
>>        O        6.14.0-10767-g8be3a12f9f26 #1092 PREEMPT
>> [  138.364366] Tainted: [O]=OOT_MODULE
>> [  138.364366] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>> [  138.364368] Call Trace:
>> [  138.364370]  <TASK>
>> [  138.364375]  dump_stack_lvl+0x80/0x90
>> [  138.364381]  check_preemption_disabled+0xc6/0xe0
>> [  138.364385]  lwtunnel_xmit+0x1c/0x2e0
>> [  138.364387]  ip_finish_output2+0x2f9/0x850
>> [  138.364391]  ? __ip_finish_output+0xa0/0x320
>> [  138.364394]  ip_send_skb+0x3f/0x90
>> [  138.364397]  udp_send_skb+0x1a6/0x3d0
>> [  138.364402]  udp_sendmsg+0x87b/0x1000
>> [  138.364404]  ? ip_frag_init+0x60/0x60
>> [  138.364406]  ? reacquire_held_locks+0xcd/0x1f0
>> [  138.364414]  ? copy_process+0x2ae0/0x2fa0
>> [  138.364418]  ? inet_autobind+0x41/0x60
>> [  138.364420]  ? __local_bh_enable_ip+0x79/0xe0
>> [  138.364422]  ? inet_autobind+0x41/0x60
>> [  138.364424]  ? inet_send_prepare+0xe7/0x1e0
>> [  138.364428]  __sock_sendmsg+0x38/0x70
>> [  138.364432]  ____sys_sendmsg+0x1c9/0x200
>> [  138.364437]  ___sys_sendmsg+0x73/0xa0
>> [  138.364444]  ? __fget_files+0xb9/0x180
>> [  138.364447]  ? lock_release+0x131/0x280
>> [  138.364450]  ? __fget_files+0xc3/0x180
>> [  138.364453]  __sys_sendmsg+0x5a/0xa0
> 
> Possibly a decoded stack trace could help.
> 
> I think a possible suspect is:
> 
> commit 986ffb3a57c5650fb8bf6d59a8f0f07046abfeb6
> Author: Justin Iurman <justin.iurman@uliege.be>
> Date:   Fri Mar 14 13:00:46 2025 +0100
> 
>      net: lwtunnel: fix recursion loops
> 
> with dev_xmit_recursion() in lwtunnel_xmit() being called in preemptible
> scope.

Correct, I came to the same conclusion based on that trace. However, I 
can't reproduce it with a PREEMPT kernel. It goes through without 
problem and the output is (as expected), i.e., "lwtunnel_xmit(): 
recursion limit reached on datapath".

> @Justin, could you please have a look?

I guess that using preempt_{disable|enable}() would not be enough here, 
so we may s/rcu_read_{lock|unlock}()/rcu_read_{lock|unlock}_bh()/g and 
move the call to rcu_read_lock_bh() before dev_xmit_recursion(). Thoughts?

> Thanks,
> 
> Paolo
> 

