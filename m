Return-Path: <bpf+bounces-74309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AFBC537B6
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 17:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428CC3A91A7
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 16:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23767347BC3;
	Wed, 12 Nov 2025 16:11:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EAE33B6E1;
	Wed, 12 Nov 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963907; cv=none; b=DeHlJE70UGa9iX+g7SdvCINOoqYYux9uN993rjSc0QJjoQnioHqFyjfnogk3qIWpMGwHskMrpMrS3+E08xc1NU6Sshisa3elorh23b1aer2KfjTQ+MGVYlvs2YeGoLdagI3ATs0OsxgF1FOo7yVE0r+Rfspycn2Jx6PWWawX2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963907; c=relaxed/simple;
	bh=EBnKUP1MlXQmMXoo++IL/jgxbadEJQGUpo3RwDwduVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gITMbNe3ULMW5USD5YIL0shyZGrNiZD2u9BY40eHazV6ke6SgcW6pncy0wu7il9nC4BZg5s+DDqrFtBmA+vIPgTqapM0Rd3HmHdKiMcFmSjGnL1l/vf9azFybb2y99aiSIcYcfVcdATew7t4rNyxzcH4gUjzRBxeQi7P4OP/N6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [192.168.9.28] (54-240-197-239.amazon.com [54.240.197.239])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id A2DB340A66;
	Wed, 12 Nov 2025 16:11:42 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 54.240.197.239) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[192.168.9.28]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <fead1ceb-c3a2-4e61-9b11-f30da188d93a@arnaud-lcm.com>
Date: Wed, 12 Nov 2025 16:11:41 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack to
 fix OOB write
To: Brahmajit Das <listout@listout.xyz>,
 David Laight <david.laight.linux@gmail.com>
Cc: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
 <20251111081254.25532-1-listout@listout.xyz>
 <20251112133546.4246533f@pumpkin>
 <u34sykpbi6vw7xyalqnsjqt4aieayjotyppl3dwilv3hq7kghf@prx4ktfpk36o>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <u34sykpbi6vw7xyalqnsjqt4aieayjotyppl3dwilv3hq7kghf@prx4ktfpk36o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <176296390367.5293.6044545848476434680@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 12/11/2025 14:47, Brahmajit Das wrote:
> On 12.11.2025 13:35, David Laight wrote:
>> On Tue, 11 Nov 2025 13:42:54 +0530
>> Brahmajit Das <listout@listout.xyz> wrote:
>>
> ...snip...
>> Please can we have no unnecessary min_t().
>> You wouldn't write:
>> 	x = (u32)a < (u32)b ? (u32)a : (u32)b;
>>
>>      David
>>   
>>>   	copy_len = trace_nr * elem_size;
>>>   
>>>   	ips = trace->ip + skip;
> Hi David,
>
> Sorry, I didn't quite get that. Would prefer something like:
> 	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;

min_t is a min with casting which is unnecessary in this case as 
trace_nr and num_elem
are already u32.

> The pre-refactor code.
>

