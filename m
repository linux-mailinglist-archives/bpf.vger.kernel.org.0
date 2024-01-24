Return-Path: <bpf+bounces-20235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B05683AD47
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 16:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD781F26367
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F447CF01;
	Wed, 24 Jan 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DkOwJF5J"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1D7C083;
	Wed, 24 Jan 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110028; cv=none; b=dKTXcf2j6FlqqOOtiqPh5QYJM1gU5gdxrUy26gOBsv83O8JKGJh6vjkrVxEqAfXkHKnh4QP+3g1IIg3zKtVjeK9+BWFvFmLgQdsDaG13rlIjtLeVFNsdAmgUhUnfPKrpAb+QPFqdcdMXg1OjvHRpXNPv7rBdmgqtWTDA6/EWXzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110028; c=relaxed/simple;
	bh=8yupxpzAUryDbcwxUh7uDUdnpKJu/WFG88d/ojUfLfk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kLo1yMkfAQbUEbr/W8soSUZSN8YaOkf8ix1t+VaZU+VBtzGAsLr3PS6DHByL2k/FSwnrYowVMfIw/i07AbSVpICtePF8CBX8XJ9mlmhnBy6SA70Z7tNhENy0atoegK4A4WywyW0l8D0GDoiL0XoIwB5XDz1DYv/zsWCZQT/+0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DkOwJF5J; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0lVXOsxtzPMOajVkRwsOirBAoRoktatmGq4lxIizvuc=; b=DkOwJF5JDS7kugYtW2AX4xcJOE
	ZnqXxY86S8ow4inyvtwfdOV0tqcAS9CyPW0IBa331woQXKs12xNZuwW02+TyE1rmC8zXEvvRdJYm7
	021VF7tMxmWtPxQLqnQY45G9ODnCMJ2Dvpd1Vf1Ofxj0ptdvHgUiDZtu6dA0Jmj/OdnilbtL4YLaU
	CAnFk2pi7IOIY8POR5ikyWn7SEQry1WceILHsbD4n+GtBriHrg0Lqpy/ZnCX6pFhlLk+8bq8yEH4K
	zYw7YW+vT1VX7wt5xM6+OA1GeukWtV2jIZWNb3zFmBHliQlFqAtJqru3IPiKiOrIPni+EA62hWvSn
	jC6vfu0w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSf9X-0008oF-64; Wed, 24 Jan 2024 16:26:59 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSf9W-000AdQ-Ih; Wed, 24 Jan 2024 16:26:58 +0100
Subject: Re: [RFC PATCH v7 0/8] net_sched: Introduce eBPF based Qdisc
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Stanislav Fomichev <sdf@google.com>, Amery Hung <ameryhung@gmail.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 toke@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 yepeilin.cs@gmail.com
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <ZbAr_dWoRnjbvv04@google.com>
 <CAM0EoMkHZO9Mpz7JugN7+o95gqX8HBgAVK6R_jhRRYQ-D=QDFQ@mail.gmail.com>
 <44a35467-53cb-1031-df9d-0891d585db65@iogearbox.net>
 <CAM0EoMm45HX=zd1qMThugYRGA9bugM-OT9NPx++VWj_zYowDmQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e6af0fe9-e7f0-40e7-bb80-143d99063db7@iogearbox.net>
Date: Wed, 24 Jan 2024 16:26:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMm45HX=zd1qMThugYRGA9bugM-OT9NPx++VWj_zYowDmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27164/Wed Jan 24 10:45:32 2024)

On 1/24/24 3:11 PM, Jamal Hadi Salim wrote:
> On Wed, Jan 24, 2024 at 8:08 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 1/24/24 1:09 PM, Jamal Hadi Salim wrote:
>>> On Tue, Jan 23, 2024 at 4:13 PM Stanislav Fomichev <sdf@google.com> wrote:
>>>> On 01/17, Amery Hung wrote:
>>>>> Hi,
>>>>>
>>>>> I am continuing the work of ebpf-based Qdisc based on Cong’s previous
>>>>> RFC. The followings are some use cases of eBPF Qdisc:
>>>>>
>>>>> 1. Allow customizing Qdiscs in an easier way. So that people don't
>>>>>      have to write a complete Qdisc kernel module just to experiment
>>>>>      some new queuing theory.
>>>>>
>>>>> 2. Solve EDT's problem. EDT calcuates the "tokens" in clsact which
>>>>>      is before enqueue, it is impossible to adjust those "tokens" after
>>>>>      packets get dropped in enqueue. With eBPF Qdisc, it is easy to
>>>>>      be solved with a shared map between clsact and sch_bpf.
>>>>>
>>>>> 3. Replace qevents, as now the user gains much more control over the
>>>>>      skb and queues.
>>>>>
>>>>> 4. Provide a new way to reuse TC filters. Currently TC relies on filter
>>>>>      chain and block to reuse the TC filters, but they are too complicated
>>>>>      to understand. With eBPF helper bpf_skb_tc_classify(), we can invoke
>>>>>      TC filters on _any_ Qdisc (even on a different netdev) to do the
>>>>>      classification.
>>>>>
>>>>> 5. Potentially pave a way for ingress to queue packets, although
>>>>>      current implementation is still only for egress.
>>>>>
>>>>> I’ve combed through previous comments and appreciated the feedbacks.
>>>>> Some major changes in this RFC is the use of kptr to skb to maintain
>>>>> the validility of skb during its lifetime in the Qdisc, dropping rbtree
>>>>> maps, and the inclusion of two examples.
>>>>>
>>>>> Some questions for discussion:
>>>>>
>>>>> 1. We now pass a trusted kptr of sk_buff to the program instead of
>>>>>      __sk_buff. This makes most helpers using __sk_buff incompatible
>>>>>      with eBPF qdisc. An alternative is to still use __sk_buff in the
>>>>>      context and use bpf_cast_to_kern_ctx() to acquire the kptr. However,
>>>>>      this can only be applied to enqueue program, since in dequeue program
>>>>>      skbs do not come from ctx but kptrs exchanged out of maps (i.e., there
>>>>>      is no __sk_buff). Any suggestion for making skb kptr and helper
>>>>>      functions compatible?
>>>>>
>>>>> 2. The current patchset uses netlink. Do we also want to use bpf_link
>>>>>      for attachment?
>>>>
>>>> [..]
>>>>
>>>>> 3. People have suggested struct_ops. We chose not to use struct_ops since
>>>>>      users might want to create multiple bpf qdiscs with different
>>>>>      implementations. Current struct_ops attachment model does not seem
>>>>>      to support replacing only functions of a specific instance of a module,
>>>>>      but I might be wrong.
>>>>
>>>> I still feel like it deserves at leasta try. Maybe we can find some potential
>>>> path where struct_ops can allow different implementations (Martin probably
>>>> has some ideas about that). I looked at the bpf qdisc itself and it doesn't
>>>> really have anything complicated (besides trying to play nicely with other
>>>> tc classes/actions, but I'm not sure how relevant that is).
>>>
>>> Are you suggesting that it is a nuisance to integrate with the
>>> existing infra? I would consider it being a lot more than "trying to
>>> play nicely". Besides, it's a kfunc and people will not be forced to
>>> use it.
>>
>> What's the use case?
> 
> What's the use case for enabling existing infra to work? Sure, let's
> rewrite everything from scratch in ebpf. And then introduce new
> tooling which well funded companies are capable of owning the right
> resources to build and manage. Open source is about choices and
> sharing and this is about choices and sharing.
> 
>> If you already go that route to implement your own
>> qdisc, why is there a need to take the performane hit and go all the
>> way into old style cls/act infra when it can be done in a more straight
>> forward way natively?
> 
> Who is forcing you to use the kfunc? This is about choice.
> What is ebpf these days anyways? Is it a) a programming environment or
> b) is it the only way to do things? I see it as available infra i.e #a
> not as the answer looking for a question.  IOW, as something we can
> use to build the infra we need and use kfuncs when it makes sense. Not
> everybody has infinite resources to keep hacking things into ebpf.
> 
>> For the vast majority of cases this will be some
>> very lightweight classification anyway (if not outsourced to tc egress
>> given the lock). If there is a concrete production need, it could be
>> added, otherwise if there is no immediate use case which cannot be solved
>> otherwise I would not add unnecessary kfuncs.
> 
> "Unnecessary" is really your view.

Looks like we're talking past each other? If there is no plan to use it
in production (I assume Amery would be able to answer?), why add it right
now to the initial series, only to figure out later on (worst case in
few years) when the time comes that the kfunc does not fit the actual
need? You've probably seen the life cycle doc (Documentation/bpf/kfuncs.rst)
and while changes can be made, they should still be mindful about potential
breakages the longer it's out in the wild, hence my question if it's
planning to be used given it wasn't in the samples.

Thanks,
Daniel

