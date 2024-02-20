Return-Path: <bpf+bounces-22325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C6F85C052
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 16:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB411C22594
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE98762EB;
	Tue, 20 Feb 2024 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gTCPRfh1"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0687E76059;
	Tue, 20 Feb 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444179; cv=none; b=lFrbDTyiTlXEvdXAa8XlBHCoLdSBqs+a7NxMIKzh/x057rDWJ4Y+tds7inj5dQB7f2ptAMF0x2/p7k8kI/3g/G4L0smuw0Ob/sBBQf0wH+VeC6bsuE+B22co0z9Qy2PDKmSNQBPsMwtwXtwXmFkF9Q/Vle56s0iVb2+ROLQihzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444179; c=relaxed/simple;
	bh=u/2HKUJb6KGR6GS1f6EQ0sj4zlsfwLdjihnnE9eniGM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kNXNs96sN/x8Ou1zPa6ORSDLHCXPMvwx576ETaiPaDvFwKK3rlCA5djdaOjZHKijkHoKM48SDxunO/+BtcENPmTbJZSxNwmvWIJKVct/PQIl6ep0PXFOSgVuFHBKod27qHU7sWWLTAJX058EMPO51bWx7ub6MmjsijBC9Np49oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gTCPRfh1; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yjD/eaYEnzVF/8XY0SxXdbxqNJ3HkVv8gNxXdrBIF80=; b=gTCPRfh1k+KWhdFTHcqLyyleoR
	lV1pGoxSo9EGhdFaJD4L3IHUn3RWRMHtxZqDqpj4oWwAlvYmmeB5vrDDMUZELfJlYGL5xa/2AW3Za
	ZFT44Tqy14S/cnmWe9hPqJOTNXvNaH1JJWLZeEZ++XB3vGcy+rsvPf/MLIVt7rhbynI34NspQW/py
	2ZHBVVFQ++yR8MykRPM4ALrcm/RAiukUjrRhdYrQELo0z1qpQgpCvm73Va2KTYiQUkZFShKjiRIGB
	hFoSJytNDo2AxtfWaPvPGAmXjsVWqLHl9+Rvn6qt+9iKxVrcIgzBkLOxJunuKsyrqe2zmjuWwBokc
	Dce1TJUQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcS65-000I8h-3v; Tue, 20 Feb 2024 16:31:53 +0100
Received: from [178.197.249.29] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcS63-000Re9-MX; Tue, 20 Feb 2024 16:31:51 +0100
Subject: Re: [PATCH v10 net-next 15/15] p4tc: add P4 classifier
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
 anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
 mleitner@redhat.com, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com,
 horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com,
 bpf@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20240122194801.152658-1-jhs@mojatatu.com>
 <20240122194801.152658-16-jhs@mojatatu.com>
 <6841ee07-40c6-9a67-a1a7-c04cbff84757@iogearbox.net>
 <CAM0EoMnjEpZrajgfKLQhsJjDANsdsZf3z2W8CT9FTMQDw2hGMw@mail.gmail.com>
 <a567ac93-2564-2235-b65f-d0940da076a5@iogearbox.net>
 <CAM0EoM=XPJ96s3Y=ivrjH-crGb6hRu4hi90WB-O_SkxvLZNYpQ@mail.gmail.com>
 <CAM0EoM=TfDESv=Ewsf_HM3aN+p+718DXoVm-vvmz+5+7-9z3dQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c44e2c3f-06dd-4709-6799-3ab8f85a7265@iogearbox.net>
Date: Tue, 20 Feb 2024 16:31:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoM=TfDESv=Ewsf_HM3aN+p+718DXoVm-vvmz+5+7-9z3dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27191/Tue Feb 20 10:25:13 2024)

On 2/16/24 10:18 PM, Jamal Hadi Salim wrote:
> On Thu, Jan 25, 2024 at 12:59 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>> On Thu, Jan 25, 2024 at 10:47 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>> On 1/24/24 3:40 PM, Jamal Hadi Salim wrote:
>>>> On Wed, Jan 24, 2024 at 8:59 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>> On 1/22/24 8:48 PM, Jamal Hadi Salim wrote:
>>> [...]
>>>>>>
>>>>>> It should also be noted that it is feasible to split some of the ingress
>>>>>> datapath into XDP first and more into TC later (as was shown above for
>>>>>> example where the parser runs at XDP level). YMMV.
>>>>>> Regardless of choice of which scheme to use, none of these will affect
>>>>>> UAPI. It will all depend on whether you generate code to load on XDP vs
>>>>>> tc, etc.
>>>>>>
>>>>>> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
>>>>>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>>>>>> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>>>>>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>>>>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>>>>
>>>>> My objections from last iterations still stand, and I also added a nak,
>>>>> so please do not just drop it with new revisions.. from the v10 as you
>>>>> wrote you added further code but despite the various community feedback
>>>>> the design still stands as before, therefore:
>>>>>
>>>>> Nacked-by: Daniel Borkmann <daniel@iogearbox.net>
>>>>
>>>> We didnt make code changes - but did you read the cover letter and the
>>>> extended commentary in this patch's commit log? We should have
>>>> mentioned it in the changes log. It did respond to your comments.
>>>> There's text that says "the filter manages the lifetime of the
>>>> pipeline" - which in the future could include not only tc but XDP but
>>>> also the hardware path (in the form of a file that gets loaded). I am
>>>> not sure if that message is clear. Your angle being this is layer
>>>> violation. In the last discussion i asked you for suggestions and we
>>>> went the tcx route, which didnt make sense, and  then you didnt
>>>> respond.
>>> [...]
>>>
>>>>> Also as mentioned earlier I don't think tc should hold references on
>>>>> XDP programs in here. It doesn't make any sense aside from the fact
>>>>> that the cls_p4 is also not doing anything with it. This is something
>>>>> that a user space control plane should be doing i.e. managing a XDP
>>>>> link on the target device.
>>>>
>>>> This is the same argument about layer violation that you made earlier.
>>>> The filter manages the p4 pipeline - i.e it's not just about the ebpf
>>>> blob(s) but for example in the future (discussions are still ongoing
>>>> with vendors who have P4 NICs) a filter could be loaded to also
>>>> specify the location of the hardware blob.
>>>
>>> Ah, so there is a plan to eventually add HW offload support for cls_p4?
>>> Or is this only specifiying a location of a blob through some opaque
>>> cookie value from user space?
>>
>> Current thought process is it will be something along these lines (the
>> commit provides more details):
>>
>> tc filter add block 22 ingress protocol all prio 1 p4 pname simple_l3 \
>>     prog type hw filename "mypnameprog.o" ... \
>>     prog type xdp obj $PARSER.o section parser/xdp pinned_link
>> /sys/fs/bpf/mylink \
>>     action bpf obj $PROGNAME.o section prog/tc-ingress
>>
>> These discussions are still ongoing - but that is the current
>> consensus. Note: we are not pushing any code for that, but hope it
>> paints the bigger picture....
>> The idea is the cls p4 owns the lifetime of the pipeline. Installing
>> the filter instantiates the p4 pipeline "simple_l3" and triggers a lot
>> of the refcounts to make sure the pipeline and its components stays
>> alive.
>> There could be multiple such filters - when someone deletes the last
>> filter, then it is safe to delete the pipeline.
>> Essentially the filter manages the lifetime of the pipeline.
>>
>>>> I would be happy with a suggestion that gets us moving forward with
>>>> that context in mind.
>>>
>>> My question on the above is mainly what does it bring you to hold a
>>> reference on the XDP program? There is no guarantee that something else
>>> will get loaded onto XDP, and then eventually the cls_p4 is the only
>>> entity holding the reference but w/o 'purpose'. We do have BPF links
>>> and the user space component orchestrating all this needs to create
>>> and pin the BPF link in BPF fs, for example. An artificial reference
>>> on XDP prog feels similar as if you'd hold a reference on an inode
>>> out of tc.. Again, that should be delegated to the control plane you
>>> have running interacting with the compiler which then manages and
>>> loads its artifacts. What if you would also need to set up some
>>> netfilter rules for the SW pipeline, would you then embed this too?
>>
>> Sorry, a slight tangent first:
>> P4 is self-contained, there are a handful of objects that are defined
>> by the spec (externs, actions, tables, etc) and we model them in the
>> patchset, so that part is self-contained. For the extra richness such
>> as the netfilter example you quoted - based on my many years of
>> experience deploying SDN - using daemons(sorry if i am reading too
>> much in what I think you are implying) for control is not the best
>> option i.e you need all kinds of coordination - for example where do
>> you store state, what happens when the daemon dies, how do you
>> graceful restarts etc. Based on that, if i can put things in the
>> kernel (which is essentially a "perpetual daemon", unless the kernel
>> crashes) it's a lot simpler to manage as a source of truth especially
>> when there is not that much info. There is a limit when there are
>> multiple pieces (to use your netfilter example) because you need
>> another layer to coordinate things.

'source of truth' for the various attach points or BPF links, yes, but in
this case here it is not, since the source of truth on what is attached
is not in cls_p4 but rather on the XDP link. How do you handle the case
when cls_p4 says something different to what is /actually/ attached? Why
is it not enough to establish some convention in user space, to pin the
link and retrieve/update from there when needed? Like everyone else does.
... even if you consider iproute2 your "control plane" (which I have the
feeling you do)?

>> Re: the XDP part - our key reason is mostly managerial, in that the
>> filter is the lifetime manager of the pipeline; and that if i dump

This is imho the problematic part which feels like square peg in round
hole, trying to fit this whole lifetime manager of the pipeline into
the cls_p4 filter. We agree to disagree here. Instead of reusing
individual building blocks from user space, this tries to cramp control
plane parts into the kernel for which its not a great fit with what is
build here as-is.

>> that filter i can see all the details in regards to the pipeline(tc,
>> XDP and in future hw, etc) in one spot. You are right, the link
>> pinning is our protection from someone replacing the XDP prog (this
>> was a tip from Toke in the early days) and the comparison of tc
>> holding inode is apropos.
>> There's some history: in the early days we were also using metadata
>> which comes from the XDP program at the tc layer if more processing
>> was to be done (and there was extra metadata which told us which XDP
>> prog produced it which we would vet before trusting the metadata).
>> Given all the above, we should still be able to hold this info without
>> necessarily holding the extra refcount and be able to see this detail.
>> So we can remove the refcounting.
> 
> Daniel?

The refcount should definitely be removed, but then again, see the point
above in that it is inconsistent information. Why can't this be done in
user space with some convention in your user space control plane - if you
take iproute2, then why it cannot pin the link in a bpf fs instance and
retrieve it from there?

