Return-Path: <bpf+bounces-13312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD067D824E
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 14:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A806281F8E
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A782D7BC;
	Thu, 26 Oct 2023 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="I8Y3UlLQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0D2AB2D;
	Thu, 26 Oct 2023 12:11:44 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AB4B9;
	Thu, 26 Oct 2023 05:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=afBoL1CywY5vzAibNNUL1al1UqCXTRmPXng/B7TR7sg=; b=I8Y3UlLQFBG6oXsysPBNHoIlTL
	My5mhjHFtOfpAiefm4lgUb/knh2KVOMifotLQlZnrgucBT2oTQvyCoUvxAKeg9Xss4hKul/w3nn/+
	GG8RAGH0iJU8tGywZnJwstCwKi8hpAgml9y+S1lT2di94/MDPFmWBM245grI1hCEizLEiU9SeCuU3
	QkY5ibaprj6CYD/dqbd/jDGcTgCKAWbYGCx+TNV1kG7rIqWm775SNM2Qxem3ETVmVNIXzfdu/S0cv
	JGih0RxqiDidarh423eKeVj1WyvObpO49xVeg8TYfAUWDILdA184/O1/wrkaMFbI5PJOY0/qlc/Ty
	/SJN7rAQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvzDA-000O4a-69; Thu, 26 Oct 2023 14:11:40 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvzD9-0005Dt-JX; Thu, 26 Oct 2023 14:11:39 +0200
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
To: Jiri Pirko <jiri@resnulli.us>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, toke@kernel.org, kuba@kernel.org,
 andrew@lunn.ch, =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?=
 <toke@redhat.com>, joe@cilium.io
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net> <ZTk4ec8CBh92PZvs@nanopsycho>
 <7dcf130e-db64-34bc-5207-15e4a4963bc0@iogearbox.net>
 <ZTn2k1vn0AN8IHlw@nanopsycho>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c2e0535d-8091-9504-4edd-9974f44c416c@iogearbox.net>
Date: Thu, 26 Oct 2023 14:11:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZTn2k1vn0AN8IHlw@nanopsycho>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27073/Thu Oct 26 09:47:53 2023)

On 10/26/23 7:18 AM, Jiri Pirko wrote:
> Wed, Oct 25, 2023 at 07:20:01PM CEST, daniel@iogearbox.net wrote:
>> On 10/25/23 5:47 PM, Jiri Pirko wrote:
>>> Tue, Oct 24, 2023 at 11:48:58PM CEST, daniel@iogearbox.net wrote:
>> [...]
>>>> comes with a primary and a peer device. Only the primary device, typically
>>>> residing in hostns, can manage BPF programs for itself and its peer. The
>>>> peer device is designated for containers/Pods and cannot attach/detach
>>>> BPF programs. Upon the device creation, the user can set the default policy
>>>> to 'pass' or 'drop' for the case when no BPF program is attached.
>>>
>>> It looks to me that you only need the host (primary) netdevice to be
>>> used as a handle to attach the bpf programs. Because the bpf program
>>> can (and probably in real use case will) redirect to uplink/another
>>> pod netdevice skipping the host (primary) netdevice, correct?
>>>
>>> If so, why can't you do just single device mode from start finding a
>>> different sort of bpf attach handle? (not sure which)
>>
>> The first point where we switch netns from a K8s Pod is out of the netdevice.
>> For the CNI case the vast majority has one but there could also be multi-
>> homing for Pods where there may be two or more, and from a troubleshooting
>> PoV aka tcpdump et al, it is the most natural point. Other attach handle
>> inside the Pod doesn't really fit given from policy PoV it also must be
>> unreachable for apps inside the Pod itself.
> 
> Okay. What is the usecase for the single device model then?

One immediate use case in the context of Cilium itself is to replace
and simplify our cilium_host/cilium_net pair which is in the hostns
and depending on the routing mode that Cilium is configured in handling
traffic/policy from host into Pods respectively from host or Pods into
collect_md encaps in order to route traffic E/W to other cluster nodes.
Going further, we were thinking also to have single dev and move it into
target netns with policy being configured from host.

Best,
Daniel

