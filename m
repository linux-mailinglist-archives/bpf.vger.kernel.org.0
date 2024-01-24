Return-Path: <bpf+bounces-20228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3230283AAA1
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 14:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F051C28660
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A89177656;
	Wed, 24 Jan 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="RXTAUNYz"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B460BB3;
	Wed, 24 Jan 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101692; cv=none; b=pNgs/AzI1GDW5yaZW6uorAdjUUZMFdwibOdfAPWWOgPQnM0Zvmo/cJnzk+R8KXeFWp7fddOS/N5XOCHddaeQ/iaVSYhrDLu/88sHz9FpVERI/c4EoD1LxXcydija5kbD9o1EiFXKHS3uPJd7DUGEHNPo+N0/mnfwUs19Dcmas4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101692; c=relaxed/simple;
	bh=VXkcYHC/XJa9aN7GwgXuH1iLFsBinqKr+fcn66pRcxY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tvdBicE9ov+J7I1cNw6rUjcxSm4Qz/FkEZS41BLjMK6IZ5PQXFXSR7WOIJYIhUD23GJoEKV37GEMKVkG3/BB2E2iSMmY71EpLijmcafWbzanA85d3klsy7HanB2/W7rpsHzd/N2cIN2VqKKoGKEY3qxjOOjKDxXMkS+1K9OGj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=RXTAUNYz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=p09qQkLHUPyqnEPIebyl9BnIJ1sxt1XdLL+oliFa4h0=; b=RXTAUNYzgJiL97RFoQXMCZ5PGI
	NSBU5WBa12HGmZYPZeHf26GyDtdmV7XDcpGjUvhjon3ODKk6fONBOTp1CKQpb0+Vq+WTKRKwMUorJ
	xsp9oH2TBL5OMqyTNiC9otaPi4/B7PbuiRE7Evv/jiLrQGKsjIoQehqS3CZGPvLZ1iiAFNZlvlV02
	0nT2oMrvtejrOEueE2Q57wNnzA54p9tuYM8adGImt9uGRdEUdhDNAUNggGL+V+Ql79lkRvDKV1n0L
	F9dI0s6tXHjt/l7pOgf1hiKkfwUKFGHOqSdMCoNvtHisrOYwYjDhtqa/bnsiTj3+ab+lWPhriHpEB
	UnvSFxXw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rScz1-000IH7-IP; Wed, 24 Jan 2024 14:07:59 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rScz1-0001Cy-1S; Wed, 24 Jan 2024 14:07:59 +0100
Subject: Re: [RFC PATCH v7 0/8] net_sched: Introduce eBPF based Qdisc
To: Jamal Hadi Salim <jhs@mojatatu.com>, Stanislav Fomichev <sdf@google.com>
Cc: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, toke@redhat.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <ZbAr_dWoRnjbvv04@google.com>
 <CAM0EoMkHZO9Mpz7JugN7+o95gqX8HBgAVK6R_jhRRYQ-D=QDFQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <44a35467-53cb-1031-df9d-0891d585db65@iogearbox.net>
Date: Wed, 24 Jan 2024 14:07:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMkHZO9Mpz7JugN7+o95gqX8HBgAVK6R_jhRRYQ-D=QDFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27164/Wed Jan 24 10:45:32 2024)

On 1/24/24 1:09 PM, Jamal Hadi Salim wrote:
> On Tue, Jan 23, 2024 at 4:13 PM Stanislav Fomichev <sdf@google.com> wrote:
>> On 01/17, Amery Hung wrote:
>>> Hi,
>>>
>>> I am continuing the work of ebpf-based Qdisc based on Cong’s previous
>>> RFC. The followings are some use cases of eBPF Qdisc:
>>>
>>> 1. Allow customizing Qdiscs in an easier way. So that people don't
>>>     have to write a complete Qdisc kernel module just to experiment
>>>     some new queuing theory.
>>>
>>> 2. Solve EDT's problem. EDT calcuates the "tokens" in clsact which
>>>     is before enqueue, it is impossible to adjust those "tokens" after
>>>     packets get dropped in enqueue. With eBPF Qdisc, it is easy to
>>>     be solved with a shared map between clsact and sch_bpf.
>>>
>>> 3. Replace qevents, as now the user gains much more control over the
>>>     skb and queues.
>>>
>>> 4. Provide a new way to reuse TC filters. Currently TC relies on filter
>>>     chain and block to reuse the TC filters, but they are too complicated
>>>     to understand. With eBPF helper bpf_skb_tc_classify(), we can invoke
>>>     TC filters on _any_ Qdisc (even on a different netdev) to do the
>>>     classification.
>>>
>>> 5. Potentially pave a way for ingress to queue packets, although
>>>     current implementation is still only for egress.
>>>
>>> I’ve combed through previous comments and appreciated the feedbacks.
>>> Some major changes in this RFC is the use of kptr to skb to maintain
>>> the validility of skb during its lifetime in the Qdisc, dropping rbtree
>>> maps, and the inclusion of two examples.
>>>
>>> Some questions for discussion:
>>>
>>> 1. We now pass a trusted kptr of sk_buff to the program instead of
>>>     __sk_buff. This makes most helpers using __sk_buff incompatible
>>>     with eBPF qdisc. An alternative is to still use __sk_buff in the
>>>     context and use bpf_cast_to_kern_ctx() to acquire the kptr. However,
>>>     this can only be applied to enqueue program, since in dequeue program
>>>     skbs do not come from ctx but kptrs exchanged out of maps (i.e., there
>>>     is no __sk_buff). Any suggestion for making skb kptr and helper
>>>     functions compatible?
>>>
>>> 2. The current patchset uses netlink. Do we also want to use bpf_link
>>>     for attachment?
>>
>> [..]
>>
>>> 3. People have suggested struct_ops. We chose not to use struct_ops since
>>>     users might want to create multiple bpf qdiscs with different
>>>     implementations. Current struct_ops attachment model does not seem
>>>     to support replacing only functions of a specific instance of a module,
>>>     but I might be wrong.
>>
>> I still feel like it deserves at leasta try. Maybe we can find some potential
>> path where struct_ops can allow different implementations (Martin probably
>> has some ideas about that). I looked at the bpf qdisc itself and it doesn't
>> really have anything complicated (besides trying to play nicely with other
>> tc classes/actions, but I'm not sure how relevant that is).
> 
> Are you suggesting that it is a nuisance to integrate with the
> existing infra? I would consider it being a lot more than "trying to
> play nicely". Besides, it's a kfunc and people will not be forced to
> use it.

What's the use case? If you already go that route to implement your own
qdisc, why is there a need to take the performane hit and go all the
way into old style cls/act infra when it can be done in a more straight
forward way natively? For the vast majority of cases this will be some
very lightweight classification anyway (if not outsourced to tc egress
given the lock). If there is a concrete production need, it could be
added, otherwise if there is no immediate use case which cannot be solved
otherwise I would not add unnecessary kfuncs.

Cheers,
Daniel

