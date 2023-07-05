Return-Path: <bpf+bounces-4025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01538747E59
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 09:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F28280FF5
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF691C2E;
	Wed,  5 Jul 2023 07:35:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66AD138F;
	Wed,  5 Jul 2023 07:35:08 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A570197;
	Wed,  5 Jul 2023 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=l2vY1WwVkbfdJVH6Zyj90CyovKSVcWmyRiX5QdEmv6c=; b=h4A7DMfVXMYwLheaGB/KP3zOrb
	lbALYWgYyjG5/n3yMALthZN5YxJ3QI5hLK+n+FRnMd8mwB5ogcsrKDALB4Jj/ykzp/2z13PMWMecV
	t499j9IscxF9UiQZqOaY3kAAKjFYTYQzJIP2hYcGu67q/kliqmsbcslAa+7vJME9u3WxSboAyw3Bz
	PYXlLp/jeDzkAuIuvznCeJFx7sAUukuc3uzK/PMDsHf7enEhdBlrxeRRvMM75VDt/3NQS6OP4sT2D
	5VrJDiHBI+X+HJSaS8eA6B0YSrX/IuDvjo16VcWGRtczDyC55OS2GeYR3rr9VVeIaBEQmsvgOAYts
	7OxqdZWQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGx2N-0009XN-Rv; Wed, 05 Jul 2023 09:34:55 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGx2N-000WvA-A7; Wed, 05 Jul 2023 09:34:55 +0200
Subject: Re: [PATCH bpf-next v2 2/7] bpf: Add fd-based tcx multi-prog infra
 with link support
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, razor@blackwall.org,
 sdf@google.com, john.fastabend@gmail.com, kuba@kernel.org, dxu@dxuuu.xyz,
 joe@cilium.io, toke@kernel.org, davem@davemloft.net, bpf@vger.kernel.org,
 netdev@vger.kernel.org, lmb@isovalent.com
References: <20230607192625.22641-1-daniel@iogearbox.net>
 <20230607192625.22641-3-daniel@iogearbox.net>
 <CAM0EoMm25tdjxp+7Mq4fowGfCJzFRhbThHhaO7T_46vNJ9y-NQ@mail.gmail.com>
 <fe2e13a6-1fb6-c160-1d6f-31c09264911b@iogearbox.net>
 <CAM0EoM=FFsTNNKaMbRtuRxc8ieJgDFsBifBmZZ2_67u5=+-3BQ@mail.gmail.com>
 <CAEf4BzbuzNw4gRXSSDoHTwGH82moaSWtaX1nvmUAVx4+OgaEyw@mail.gmail.com>
 <CAM0EoM=SeFagzNMWLHqM7LRXt71pWz7BJax_4rvCnLyARDyWig@mail.gmail.com>
 <15ab0ba7-abf7-b9c3-eb5e-7a6b9fd79977@iogearbox.net>
 <CAM0EoMndiP6c20Q9g+dSFMh+XPJCdCAUzjHPXm6-4mmNJtAH3A@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b147aa2d-6aa5-6336-1484-41c7c1032ecd@iogearbox.net>
Date: Wed, 5 Jul 2023 09:34:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMndiP6c20Q9g+dSFMh+XPJCdCAUzjHPXm6-4mmNJtAH3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26959/Tue Jul  4 09:29:23 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/5/23 12:38 AM, Jamal Hadi Salim wrote:
> On Tue, Jul 4, 2023 at 6:01 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 7/4/23 11:36 PM, Jamal Hadi Salim wrote:
>>> On Thu, Jun 8, 2023 at 5:25 PM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>> On Thu, Jun 8, 2023 at 12:46 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>>>> On Thu, Jun 8, 2023 at 6:12 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>>> On 6/8/23 3:25 AM, Jamal Hadi Salim wrote:
>> [...]
>>>>>> BPF links are supported for XDP today, just tc BPF is one of the few
>>>>>> remainders where it is not the case, hence the work of this series. What
>>>>>> XDP lacks today however is multi-prog support. With the bpf_mprog concept
>>>>>> that could be addressed with that common/uniform api (and Andrii expressed
>>>>>> interest in integrating this also for cgroup progs), so yes, various hook
>>>>>> points/program types could benefit from it.
>>>>>
>>>>> Is there some sample XDP related i could look at?  Let me describe our
>>>>> use case: lets say we load an ebpf program foo attached to XDP of a
>>>>> netdev  and then something further upstream in the stack is consuming
>>>>> the results of that ebpf XDP program. For some reason someone, at some
>>>>> point, decides to replace the XDP prog with a different one - and the
>>>>> new prog does a very different thing. Could we stop the replacement
>>>>> with the link mechanism you describe? i.e the program is still loaded
>>>>> but is no longer attached to the netdev.
>>>>
>>>> If you initially attached an XDP program using BPF link api
>>>> (LINK_CREATE command in bpf() syscall), then subsequent attachment to
>>>> the same interface (of a new link or program with BPF_PROG_ATTACH)
>>>> will fail until the current BPF link is detached through closing its
>>>> last fd.
>>>
>>> So this works as advertised. The problem is however not totally solved
>>> because it seems we need a process that's alive to hold the ownership.
>>> If we had a daemon then that would solve it i think (we dont).
>>> Alternatively,  you pin the link. The pinning part can be
>>> circumvented, unless i misunderstood i,e anybody with the right
>>> permissions can remove it.
>>>
>>> Am I missing something?
>>
>> It would be either of those depending on the use case, and for pinning
>> removal, it would require right permissions/acls. Keep in mind that for
>> your application you can also use your own bpffs mount, so you don't
>> need to use the default /sys/fs/bpf one in hostns.
> 
> This helps for sure - doesnt 100% solve it. It would really be nice if
> we could tie in a kerberos-like ticketing system for ownership of the
> mount or something even more fine grained like a link. Doesnt have to
> be kerberos but anything that would allow a digest of some verifiable
> credentials/token to be handed to the kernel for authorization...

What is your use-case, you don't want anyone except your own orchestration
application to access it, so any kind of ACLs, LSM policies or making the
mount only available to your container are not enough in this scenario you
have in mind?

I think the closest to that is probably the prototype which Lorenz recently
built where the user space application's digest is validated via IMA [0].

   [0] http://vger.kernel.org/bpfconf2023_material/Lorenz_Bauer_-_BPF_signing_using_fsverity_and_LSM_gatekeeper.pdf
       https://github.com/isovalent/bpf-verity

