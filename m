Return-Path: <bpf+bounces-16732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA19C805644
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 14:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C171F215B1
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4035D91D;
	Tue,  5 Dec 2023 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="K3UTLyab"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EF3A8;
	Tue,  5 Dec 2023 05:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CejJeY0vLeqFQt+U97vqcKRuJ19+UmTHuWHOiR2dhE4=; b=K3UTLyabwZk4cmleWcOsKjpKtu
	5hwIJiFgkj+40JUJdgOOsa1xiIS+uT8z6mKkzy0VAgzXNBPiix4GS8SI83kHKso6M6YMqY5vTg6c2
	yptESCkQIfW4BVNZAhWkOlFs46bjYLR8jnSE/QzCUwJ45p7F6yD4FW3AMXBTPJWBtbcvwdpE6P97q
	Zx5b1Cq4GYJ699Bfq9HsIynRSCCt8fy2b7tx/pOUT+twDLEERrOLLKXlbrjyQjtqdJALuniyBnhiR
	qAiSDTghJt/MlY4JUEbrmaVNs1CL0ygfN9l5CGH2YV0/3Ag5JH/Z2+dHnle/8/fipwzKHUbCtWVGu
	BLJH6xtg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rAViA-000I01-B3; Tue, 05 Dec 2023 14:43:42 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rAVi9-000Ey1-7s; Tue, 05 Dec 2023 14:43:41 +0100
Subject: Re: [PATCH net-next v9 15/15] p4tc: add P4 classifier
To: John Fastabend <john.fastabend@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
 tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com,
 toke@redhat.com, bpf@vger.kernel.org
References: <20231201182904.532825-1-jhs@mojatatu.com>
 <20231201182904.532825-16-jhs@mojatatu.com>
 <656e6f8d7c99f_207cb2087c@john.notmuch>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2eb488f9-af4a-4e28-0de0-d4dbc1e166f5@iogearbox.net>
Date: Tue, 5 Dec 2023 14:43:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <656e6f8d7c99f_207cb2087c@john.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27114/Tue Dec  5 09:39:00 2023)

On 12/5/23 1:32 AM, John Fastabend wrote:
> Jamal Hadi Salim wrote:
>> Introduce P4 tc classifier. A tc filter instantiated on this classifier
>> is used to bind a P4 pipeline to one or more netdev ports. To use P4
>> classifier you must specify a pipeline name that will be associated to
>> this filter, a s/w parser and datapath ebpf program. The pipeline must have
>> already been created via a template.
>> For example, if we were to add a filter to ingress of network interface
>> device $P0 and associate it to P4 pipeline simple_l3 we'd issue the
>> following command:
> 
> In addition to my comments from last iteration.
> 
>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>>      action bpf obj $PARSER.o section prog/tc-parser \
>>      action bpf obj $PROGNAME.o section prog/tc-ingress
> 
> Having multiple object files is a mistake IMO and will cost
> performance. Have a single object file avoid stitching together
> metadata and run to completion. And then run entirely from XDP
> this is how we have been getting good performance numbers.

+1, fully agree.

>> $PROGNAME.o and $PARSER.o is a compilation of the eBPF programs generated
>> by the P4 compiler and will be the representation of the P4 program.
>> Note that filter understands that $PARSER.o is a parser to be loaded
>> at the tc level. The datapath program is merely an eBPF action.
>>
>> Note we do support a distinct way of loading the parser as opposed to
>> making it be an action, the above example would be:
>>
>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>>      prog type tc obj $PARSER.o ... \
>>      action bpf obj $PROGNAME.o section prog/tc-ingress
>>
>> We support two types of loadings of these initial programs in the pipeline
>> and differentiate between what gets loaded at tc vs xdp by using syntax of
>>
>> either "prog type tc obj" or "prog type xdp obj"
>>
>> For XDP:
>>
>> tc filter add dev $P0 ingress protocol all prio 1 p4 pname simple_l3 \
>>      prog type xdp obj $PARSER.o section parser/xdp \
>>      pinned_link /sys/fs/bpf/mylink \
>>      action bpf obj $PROGNAME.o section prog/tc-ingress
> 
> I don't think tc should be loading xdp programs. XDP is not 'tc'.

For XDP, we do have a separate attach API, for BPF links we have bpf_xdp_link_attach()
via bpf(2) and regular progs we have the classic way via dev_change_xdp_fd() with
IFLA_XDP_* attributes. Mid-term we'll also add bpf_mprog support for XDP to allow
multi-user attachment. tc kernel code should not add yet another way of attaching XDP,
this should just reuse existing uapi infra instead from userspace control plane side.

>> The theory of operations is as follows:
>>
>> ================================1. PARSING================================
>>
>> The packet first encounters the parser.
>> The parser is implemented in ebpf residing either at the TC or XDP
>> level. The parsed header values are stored in a shared eBPF map.
>> When the parser runs at XDP level, we load it into XDP using tc filter
>> command and pin it to a file.
>>
>> =============================2. ACTIONS=============================
>>
>> In the above example, the P4 program (minus the parser) is encoded in an
>> action($PROGNAME.o). It should be noted that classical tc actions
>> continue to work:
>> IOW, someone could decide to add a mirred action to mirror all packets
>> after or before the ebpf action.
>>
>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>>      prog type tc obj $PARSER.o section parser/tc-ingress \
>>      action bpf obj $PROGNAME.o section prog/tc-ingress \
>>      action mirred egress mirror index 1 dev $P1 \
>>      action bpf obj $ANOTHERPROG.o section mysect/section-1
>>
>> It should also be noted that it is feasible to split some of the ingress
>> datapath into XDP first and more into TC later (as was shown above for
>> example where the parser runs at XDP level). YMMV.
> 
> Is there any performance value in partial XDP and partial TC? The main
> wins we see in XDP are when we can drop, redirect, etc the packet
> entirely in XDP and avoid skb altogether.
> 
>>
>> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

The cls_p4 is roughly a copy of {cls,act}_bpf, and from a BPF community side
we moved away from this some time ago for the benefit of a better management
API for tc BPF programs via bpf(2) through bpf_mprog (see libbpf and BPF selftests
around this), as mentioned earlier. Please use this instead for your userspace
control plane, otherwise we are repeating the same mistakes from the past again
that were already fixed. Therefore, from BPF side:

Nacked-by: Daniel Borkmann <daniel@iogearbox.net>

Cheers,
Daniel

