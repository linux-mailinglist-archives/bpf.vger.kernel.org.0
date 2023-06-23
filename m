Return-Path: <bpf+bounces-3327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6F73C4C0
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 01:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24139281E74
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 23:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF30F6FB7;
	Fri, 23 Jun 2023 23:23:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A023108
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 23:23:19 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66721A4;
	Fri, 23 Jun 2023 16:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lew6KM9RZ1FtcI/xKeufajB05nzJZ4IWlgLzP6bUBu4=; b=Qa+KJ3EyX+W7tvQTkjMcTUVopd
	fmy0+cSHZdv2AP2NEO6X/9eKwCdxhm5NqZvbtY3p7rp1tqjz9LWUbsdwWqfoiyv9mXgoPdEGskwej
	HoljDnIpS8tBea9A7W7JziT+8PaHNEAh/yq+Bk7cPqH8QY3bNvey/6mWpuXEnVUjT8cK7mTfMlzte
	fY8Cj29PAlbwfx1en6MCjRKFQmYw77dO+5PaEGGcfCyLm+VQZ10PlnvpZOl/Sn4c2mtAAxNHCim1c
	fPDHZ8WGysCPTTLP4uBjP/JjlFQMsOs/KOAQr6VN8glRphxfPfDEBPBoL80yVOb0+RukaeHuYn8n7
	AOmgnnGw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qCq7T-000LhD-Ow; Sat, 24 Jun 2023 01:23:11 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qCq7T-000EiV-DP; Sat, 24 Jun 2023 01:23:11 +0200
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Andy Lutomirski <luto@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Christian Brauner <brauner@kernel.org>, lennart@poettering.net,
 cyphar@cyphar.com, kernel-team@meta.com
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
 <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
 <5a75d1f0-4ed9-399c-4851-2df0755de9b5@redhat.com>
 <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
 <82b79e57-a0ad-4559-abc9-858e0f51fbba@app.fastmail.com>
 <9b0e9227-4cf4-4acb-ba88-52f65b099709@app.fastmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <173f0af7-e6e1-f4b7-e0a6-a91b7a4da5d7@iogearbox.net>
Date: Sat, 24 Jun 2023 01:23:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9b0e9227-4cf4-4acb-ba88-52f65b099709@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26948/Fri Jun 23 09:28:15 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/23/23 5:10 PM, Andy Lutomirski wrote:
> On Thu, Jun 22, 2023, at 6:02 PM, Andy Lutomirski wrote:
>> On Thu, Jun 22, 2023, at 11:40 AM, Andrii Nakryiko wrote:
>>
>>> Hopefully you can see where I'm going with this. And this is just one
>>> random tiny example. We can think up tons of other cases to prove BPF
>>> is not isolatable to any sort of "container".
>>
>> No.  You have not come up with an example of why BPF is not isolatable
>> to a container.  You have come up with an example of why binding to a
>> sched_switch raw tracepoint does not make sense in a container without
>> additional mechanisms to give it well defined functionality and
>> appropriate security.

One big blocker for the case of BPF is not isolatable to a container are
CPU hardware bugs. There has been plenty of mitigation effort so that the
flexibility cannot be abused as a tool e.g. discussed in [0], but ultimately
it's a cat and mouse game and vendors are also not really transparent. So
actual reasonable discussion can be resumed once CPU vendors gets their
stuff fixed.

   [0] https://popl22.sigplan.org/details/prisc-2022-papers/11/BPF-and-Spectre-Mitigating-transient-execution-attacks

> Thinking about this some more:
> 
> Suppose the goal is to allow a workload in a container to monitor itself by attaching to a tracepoint (something in the scheduler, for example).  The workload is in the container.  The tracepoint is global.  Kernel memory is global unless something that is trusted and understands the containers is doing the reading.  And proxying BPF is a mess.

Agree that proxy is a mess for various reasons stated earlier.

> So here are a couple of possible solutions:
> 
> (a) Improve BPF maps a bit so that BPF maps work well in containers.  It should be possible to create a map and share it (the file descriptor!) between the outside and the container without running into various snags.  (IIRC my patch series was a decent step in this direction,)  Now load the BPF program and attach it to the tracepoint outside the container but have it write its gathered data to the map that's in the container.  So you end up with a daemon outside the container that gets a request like "help me monitor such-and-such by running BPF program such-and-such (where the BPF program code presumably comes from a library outside the container", and the daemon arranges for the requesting container to have access to the map it needs to get the data.

I don't think it's very practical, meaning the vast majority of applications
out there today are tightly coupled BPF code + user space application, and in
a lot of cases programs are dynamically created. This would require somehow
splitting up parts of your application to run outside the container in hostns
and other parts inside the container.. for the sake of the mentioned example
it's something fairly static, but real-world applications look different and
are much more complex.

> (b) Make a way to pass a pre-approved program into a container.  So a daemon outside loads the program and does some new magic to say "make an fd that can be used to attach this particular program to this particular tracepoint" and pass that into the container.

Same as above. Programs are in most cases very tightly coupled to the application
itself. I'm not sure if the ask is to redesign/implement all the existing user
space infra.

> I think (a) is better.  In particular, if you have a workload with many containers, and they all want to monitor the same tracepoint as it relates to their container, you will get much better performance if a single BPF program does the monitoring and sends the data out to each container as needed instead of having one copy of the program per container.
> 
> For what it's worth, BPF tokens seem like they'll have the same performance problem -- without coordination, you can end up with N containers generating N hooks all targeting the same global resource, resulting in overhead that scales linearly with the number of containers.

Worst case, sure, but it's not the point. These containers which would receive
the tokens are part of your trusted compute base.. so its up to the specific
applications and their surrounding infrastructure with regards to what problem
they solve where and approved by operators/platform engs to deploy in your cluster.
I don't particularly see that there's a performance problem. Andrii specifically
mentioned /trusted unprivileged applications/.

> And, again, I'm not an XDP expert, but if you have one NIC, and you attach N XDP programs to it, and each one is inspecting packets and sending some to one particular container's AF_XDP socket, you are not going to get good performance.  You want *one* XDP program fanning the packets out to the relevant containers.
> 
> If this is hard right now, perhaps you could add new kernel mechanisms as needed to improve the situation.
> 
> --Andy
> 


