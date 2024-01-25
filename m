Return-Path: <bpf+bounces-20333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF483C734
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 16:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4302B1C232D2
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 15:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D12745E9;
	Thu, 25 Jan 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mMA1VRo8"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439837CF31;
	Thu, 25 Jan 2024 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197656; cv=none; b=Rhgn1Tig+GpZXupcHdngMuZr/m3GLAvsxoKOl/7v7fze+g02jFUUvdwYieKHLOFYSDLeCSldhRYDWl+JwydtNp5/9cAWCAgxFbXvkiUnO5k6i7QC7equNCgbpKGB8Z5BbJPHvxgRGGfg40/tcVTk9RoNo5BiCYlQJ9opyjk0us4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197656; c=relaxed/simple;
	bh=VahnD2WF97Gr+wP0g4hnDQOrIUwn3rdLtkIc/F/a1o0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nS+4EjQRMZa4AslaHvkju0vDl87nNDqjVU1aOEhqn8vldAVkQP1Bynj1MTzO5Q+0o7k26yLObKgjDkhVR6lWCCtlTPBjsbcC07wajoo7zecbXLaxWU8oMl9dv08gWExHb6Ml8xxQqIX14ws7y33aTASQYjAKtDnI5V9EFa8FsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mMA1VRo8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=s6agdKzmNrctWvv3P+nld9yIlLBZSPLgtdmmZf/JoK0=; b=mMA1VRo8e1/yLM1e0j8sz3lYvj
	8jBks6SbY+5CeZtAjxjXfDa0VcML9jh0NdgE5uKUN9JQP+ksisAqsC8IpxULWK9aw/6NbosDxPYtT
	g71ffx4+ienI0Wo/65Xs+9UYXrjjcvqgHLHu6F3VZvFJ4+jZWo4AbUV1L03g+bGmnKFwQ8VKk1d3x
	wH83cDKflKbbXkQvvX6o/Cd8ceesRiKG3/nqPGeqP1EGM8l4IY9YCAZ1n6vjs/UFukl61FJwkWQ5L
	Qael6uJZs3mToEtuJ1x0n6BOSshtc0UKITCiVlFF79H9X57MDmzzbjcn4jPapA8EghMDxhaRKjFRj
	+e1UNNkg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rT1wo-000Gtb-Ml; Thu, 25 Jan 2024 16:47:22 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rT1wn-000JWP-Ez; Thu, 25 Jan 2024 16:47:21 +0100
Subject: Re: [PATCH v10 net-next 15/15] p4tc: add P4 classifier
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
 anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
 mleitner@redhat.com, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com,
 horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com,
 bpf@vger.kernel.org
References: <20240122194801.152658-1-jhs@mojatatu.com>
 <20240122194801.152658-16-jhs@mojatatu.com>
 <6841ee07-40c6-9a67-a1a7-c04cbff84757@iogearbox.net>
 <CAM0EoMnjEpZrajgfKLQhsJjDANsdsZf3z2W8CT9FTMQDw2hGMw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a567ac93-2564-2235-b65f-d0940da076a5@iogearbox.net>
Date: Thu, 25 Jan 2024 16:47:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMnjEpZrajgfKLQhsJjDANsdsZf3z2W8CT9FTMQDw2hGMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27165/Thu Jan 25 10:51:15 2024)

On 1/24/24 3:40 PM, Jamal Hadi Salim wrote:
> On Wed, Jan 24, 2024 at 8:59 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 1/22/24 8:48 PM, Jamal Hadi Salim wrote:
[...]
>>>
>>> It should also be noted that it is feasible to split some of the ingress
>>> datapath into XDP first and more into TC later (as was shown above for
>>> example where the parser runs at XDP level). YMMV.
>>> Regardless of choice of which scheme to use, none of these will affect
>>> UAPI. It will all depend on whether you generate code to load on XDP vs
>>> tc, etc.
>>>
>>> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
>>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>>> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>
>> My objections from last iterations still stand, and I also added a nak,
>> so please do not just drop it with new revisions.. from the v10 as you
>> wrote you added further code but despite the various community feedback
>> the design still stands as before, therefore:
>>
>> Nacked-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> We didnt make code changes - but did you read the cover letter and the
> extended commentary in this patch's commit log? We should have
> mentioned it in the changes log. It did respond to your comments.
> There's text that says "the filter manages the lifetime of the
> pipeline" - which in the future could include not only tc but XDP but
> also the hardware path (in the form of a file that gets loaded). I am
> not sure if that message is clear. Your angle being this is layer
> violation. In the last discussion i asked you for suggestions and we
> went the tcx route, which didnt make sense, and  then you didnt
> respond.
[...]

>> Also as mentioned earlier I don't think tc should hold references on
>> XDP programs in here. It doesn't make any sense aside from the fact
>> that the cls_p4 is also not doing anything with it. This is something
>> that a user space control plane should be doing i.e. managing a XDP
>> link on the target device.
> 
> This is the same argument about layer violation that you made earlier.
> The filter manages the p4 pipeline - i.e it's not just about the ebpf
> blob(s) but for example in the future (discussions are still ongoing
> with vendors who have P4 NICs) a filter could be loaded to also
> specify the location of the hardware blob.

Ah, so there is a plan to eventually add HW offload support for cls_p4?
Or is this only specifiying a location of a blob through some opaque
cookie value from user space?

> I would be happy with a suggestion that gets us moving forward with
> that context in mind.

My question on the above is mainly what does it bring you to hold a
reference on the XDP program? There is no guarantee that something else
will get loaded onto XDP, and then eventually the cls_p4 is the only
entity holding the reference but w/o 'purpose'. We do have BPF links
and the user space component orchestrating all this needs to create
and pin the BPF link in BPF fs, for example. An artificial reference
on XDP prog feels similar as if you'd hold a reference on an inode
out of tc.. Again, that should be delegated to the control plane you
have running interacting with the compiler which then manages and
loads its artifacts. What if you would also need to set up some
netfilter rules for the SW pipeline, would you then embed this too?

Thanks,
Daniel

