Return-Path: <bpf+bounces-20213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C983A66A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 11:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4A228589F
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 10:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8236C1862F;
	Wed, 24 Jan 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="YjRNZ2YV"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC10182C5;
	Wed, 24 Jan 2024 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091052; cv=none; b=KPzoGzP4YmineABIjHFqWstj+0n9YW8j5z7vOEQOwO4mkI06xjmaLM+G+5sFdwWx7CRsWrqK8yeiaTirDg4YQkcGpCRUT4g3uOFX+Dj930GDPNBpNO6FZEnPa5cC86KhQ1mtZWgF8MYNZnU/yT1O+ol5NQjh2MIDLSiWWw9MOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091052; c=relaxed/simple;
	bh=2uz7wnLrJbJhEj0X+bT2KBLAEV8Bvyqzqqs4OZCEN3E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VNSk8JUinVmGCx1yOnN3ejtytZuWzDddvVqEBam8ftEZm1J238MLMEwWhXZZm/gc4yqKS9YvV0RD3bGQ3ioa5wQrk74ddkoK9AFDbnlM/kkbg24l3UYuNvQzfTQgMx+S3enrbh2qFFhe+q5D+niJQZV+y/SDb5wiu426y3giFxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=YjRNZ2YV; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8NyI5A+LIWDYqfd9WymVb/VBvwDorMqv40CajixTCcc=; b=YjRNZ2YVzuDqNEdcVjgxeXe/tK
	XMEADPE0aq1SnvyTOkaSi4IeaOxqunsTdGiGrZIqheTJhDS5XxjbCAm6dpjliCSB8rKs595GTJt+V
	B5dxvzTZJAiKvOf/lLnj1KPLccc1OSFpCwSraNpVH2bc3dZQtoQd3BhI9CTmbiHG6Y25OC0fgo3iB
	wvO6hWFZ7CmcqGWUgQn8zp5Ijd3vsbHZPj6km79ejnKLygLhZwkazYB9d/MVznrs5oS8F0PPKgHRZ
	9rO/oX7ZxPeTUtFGI4D4GhMYpckAtvp58VkelUylNCN4cJo/fvjDCGSOApyebJmFCRjekpgh33D40
	P+4VJJBA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSaDS-000MXy-5V; Wed, 24 Jan 2024 11:10:42 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSaDR-0008Hi-Gn; Wed, 24 Jan 2024 11:10:41 +0100
Subject: Re: [RFC PATCH v7 0/8] net_sched: Introduce eBPF based Qdisc
To: Stanislav Fomichev <sdf@google.com>, Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <ZbAr_dWoRnjbvv04@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d7755998-079a-2280-8836-def30ff341c5@iogearbox.net>
Date: Wed, 24 Jan 2024 11:10:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZbAr_dWoRnjbvv04@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27163/Tue Jan 23 10:42:11 2024)

On 1/23/24 10:13 PM, Stanislav Fomichev wrote:
> On 01/17, Amery Hung wrote:
>> Hi,
>>
>> I am continuing the work of ebpf-based Qdisc based on Cong’s previous
>> RFC. The followings are some use cases of eBPF Qdisc:
>>
>> 1. Allow customizing Qdiscs in an easier way. So that people don't
>>     have to write a complete Qdisc kernel module just to experiment
>>     some new queuing theory.
>>
>> 2. Solve EDT's problem. EDT calcuates the "tokens" in clsact which
>>     is before enqueue, it is impossible to adjust those "tokens" after
>>     packets get dropped in enqueue. With eBPF Qdisc, it is easy to
>>     be solved with a shared map between clsact and sch_bpf.
>>
>> 3. Replace qevents, as now the user gains much more control over the
>>     skb and queues.
>>
>> 4. Provide a new way to reuse TC filters. Currently TC relies on filter
>>     chain and block to reuse the TC filters, but they are too complicated
>>     to understand. With eBPF helper bpf_skb_tc_classify(), we can invoke
>>     TC filters on _any_ Qdisc (even on a different netdev) to do the
>>     classification.
>>
>> 5. Potentially pave a way for ingress to queue packets, although
>>     current implementation is still only for egress.
>>
>> I’ve combed through previous comments and appreciated the feedbacks.
>> Some major changes in this RFC is the use of kptr to skb to maintain
>> the validility of skb during its lifetime in the Qdisc, dropping rbtree
>> maps, and the inclusion of two examples.
>>
>> Some questions for discussion:
>>
>> 1. We now pass a trusted kptr of sk_buff to the program instead of
>>     __sk_buff. This makes most helpers using __sk_buff incompatible
>>     with eBPF qdisc. An alternative is to still use __sk_buff in the
>>     context and use bpf_cast_to_kern_ctx() to acquire the kptr. However,
>>     this can only be applied to enqueue program, since in dequeue program
>>     skbs do not come from ctx but kptrs exchanged out of maps (i.e., there
>>     is no __sk_buff). Any suggestion for making skb kptr and helper
>>     functions compatible?
>>
>> 2. The current patchset uses netlink. Do we also want to use bpf_link
>>     for attachment?
> 
> [..]
> 
>> 3. People have suggested struct_ops. We chose not to use struct_ops since
>>     users might want to create multiple bpf qdiscs with different
>>     implementations. Current struct_ops attachment model does not seem
>>     to support replacing only functions of a specific instance of a module,
>>     but I might be wrong.
> 
> I still feel like it deserves at leasta try. Maybe we can find some potential
> path where struct_ops can allow different implementations (Martin probably
> has some ideas about that). I looked at the bpf qdisc itself and it doesn't
> really have anything complicated (besides trying to play nicely with other
> tc classes/actions, but I'm not sure how relevant that is).

Plus it's also not used in the two sample implementations, given you can
implement this as part of the enqueue operation in bpf. It would make sense
to drop the kfunc from the set. One other note.. the BPF samples have been
bitrotting for quite a while, please convert this into a proper BPF selftest
so that BPF CI can run this.

> With struct_ops you can also get your (2) addressed.

+1

Thanks,
Daniel

