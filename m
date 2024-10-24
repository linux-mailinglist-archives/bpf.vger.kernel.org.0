Return-Path: <bpf+bounces-43079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1807C9AEF6F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B68C1F225F8
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C15200139;
	Thu, 24 Oct 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="aG2D/cz+"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB11FF7D9
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793560; cv=none; b=KBrAt3iSs/iG0dEs63oWCxNsIrVTo5CgtyZezmcMhId+2XqtTWjGHEvZfnZPXFmw4O4HfE5nZiBGf28NbvcTGlPXfwRAQiF4pz3jOFAX404w80752i7x17HjdWFm6DRs3DSndUIzPhXqpgx8bPghlaND5jiSbxtZa2/KvBfi1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793560; c=relaxed/simple;
	bh=2hJYi7N3mHEINlfvmg77TFjE1P4xNJfpcDIjuxFQa+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mbl2FOmwT3lGty3gh9PQ9j7q5/RMYh+g/gdeJvgOHfy2gdm2wzB9gJneYzPnBUxCqdTAR9F4Hw53PJck1BrVFGa42RR0m9NSHgKBHofJtnR8zxyZJ5rXiX0lQ4koJxUY0nD4E37z9jSqObrLy3VUYxEA7zSabR8gdZVf4bNWahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=aG2D/cz+; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4nAaMZ150qxT19upFi/K5VL9lw9cEYQt29g+6rghjDA=; b=aG2D/cz+TRdQurNo8O/x6pYK6/
	kD/mYFBk9Deh4ZWN70uBynxoy3/VnF5dAWQDu+XT87gUp81YLsp/8TuznLh2NuL4u9TI7eN98Tl4G
	qK819yTfdfp/aDFE9G1/3zEQrbIenhNW8WJheIAbvTzYrrlYfuY5KKL2Jk97lGBEje6+bBX+u01te
	Kkz9Bgb667vxiVTG/pfteSZyIcDxvTDANCyh+/76azAa6ZVrdTOL8Usyh7uavNME2qIzkQfdWAA9U
	PQ4tQUNHQOgGHJl6bcUfBngicwm/tNMn1ek4cXe/IwJsh3X1W6z7S33zzDTvTanW+i/jXjmSFqv/9
	fwmhzvFA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t42JZ-000K7o-KQ; Thu, 24 Oct 2024 20:12:05 +0200
Received: from [85.1.206.226] (helo=[192.168.1.114])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1t42JY-0002zs-1G;
	Thu, 24 Oct 2024 20:12:04 +0200
Message-ID: <eef6d5c9-358c-4c94-b0a7-cd04b5f9c34a@iogearbox.net>
Date: Thu, 24 Oct 2024 20:12:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 0/8] Fixes to bpf_msg_push/pop_data and test_sockmap
To: Zijian Zhang <zijianzhang@bytedance.com>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org, jakub@cloudflare.com,
 liujian56@huawei.com, cong.wang@bytedance.com
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
 <6719c7aede141_1cb2208a6@john.notmuch>
 <fe0ac5b2-f662-4635-92db-081fadb5e375@iogearbox.net>
 <148ce32b-b17e-4612-a30b-baa2c249eeb2@bytedance.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <148ce32b-b17e-4612-a30b-baa2c249eeb2@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27437/Thu Oct 24 10:33:37 2024)

On 10/24/24 7:56 PM, Zijian Zhang wrote:
> On 10/24/24 7:43 AM, Daniel Borkmann wrote:
>> On 10/24/24 6:06 AM, John Fastabend wrote:
>>> zijianzhang@ wrote:
>>>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>>>
>>>> Several fixes to test_sockmap and added push/pop logic for msg_verify_data
>>>> Before the fixes, some of the tests in test_sockmap are problematic,
>>>> resulting in pseudo-correct result.
>>>>
>>>> 1. txmsg_pass is not set in some tests, as a result, no eBPF program is
>>>> attached to the sockmap.
>>>> 2. In SENDPAGE, a wrong iov_length in test_send_large may result in some
>>>> test skippings and failures.
>>>> 3. The calculation of total_bytes in msg_loop_rx is wrong, which may cause
>>>> msg_loop_rx end early and skip some data tests.
>>>>
>>>> Besides, for msg_verify_data, I added push/pop checking logic to function
>>>> msg_verify_data and added more tests for different cases.
>>>
>>> Thanks! Yep I think push/pop are not widely used anywhere unfortunately.
>>> There are some interesting uses for push/pop to add/edit headers, but
>>> I've not gotten there yet clearly.
> 
> Thanks for the reviewing :)
> 
>>>> After that, I found that there are some bugs in bpf_msg_push_data,
>>>> bpf_msg_pop_data and sk_msg_reset_curr, and fix them. I guess the reason
>>>> why they have not been exposed is that because of the above problems, they
>>>> will not be triggered.
>>>
>>> Good. I'll review these quickly tonight/tomorrow and run some testing.
>>> We don't currently have any longer running tests with push/pop.
>>
>> Looks like the series needs a rebase to latest bpf tree.
>>
>> Thanks,
>> Daniel
> 
> This series depends on my previous fixes to test_sockmap("Two fixes for
> test_sockmap"), and they were merged to bpf/bpf-next.git (net branch) a
> week ago. Shall I wait for merging of them to the latest bpf, and then
> rebase?

Then this series also needs to be based against bpf-next, net branch (along
with PATCH bpf-next in $subj) so that the CI can pick it up.

Thanks,
Daniel

