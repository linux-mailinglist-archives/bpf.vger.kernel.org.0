Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359756F1D38
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 19:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjD1RLz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 13:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD1RLy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 13:11:54 -0400
X-Greylist: delayed 1048 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Apr 2023 10:11:52 PDT
Received: from smtpout15.mo541.mail-out.ovh.net (smtpout15.mo541.mail-out.ovh.net [146.59.177.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23E31FF0
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 10:11:52 -0700 (PDT)
Received: from ex4.mail.ovh.net (unknown [10.110.115.87])
        by mo541.mail-out.ovh.net (Postfix) with ESMTPS id 0EB2B25E16;
        Fri, 28 Apr 2023 16:54:22 +0000 (UTC)
Received: from [192.168.1.125] (93.21.160.242) by DAG10EX1.indiv4.local
 (172.16.2.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.23; Fri, 28 Apr
 2023 18:54:21 +0200
Message-ID: <d6de9d40-ff59-4cb6-5a97-f8b72a5d853e@naccy.de>
Date:   Fri, 28 Apr 2023 18:54:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/7] bpf: add bpf_link support for
 BPF_NETFILTER programs
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florian Westphal <fw@strlen.de>
CC:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <dxu@dxuuu.xyz>
References: <20230421170300.24115-1-fw@strlen.de>
 <20230421170300.24115-2-fw@strlen.de>
 <CAEf4Bzby3gwHmvz1cjcNHKFPA1LQdTq85TpCmOg=GB6=bQwjOQ@mail.gmail.com>
 <20230427091015.GD3155@breakpoint.cc>
 <CAEf4BzZrmUv27AJp0dDxBDMY_B8e55-wLs8DUKK69vCWsCG_pQ@mail.gmail.com>
From:   Quentin Deslandes <qde@naccy.de>
In-Reply-To: <CAEf4BzZrmUv27AJp0dDxBDMY_B8e55-wLs8DUKK69vCWsCG_pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [93.21.160.242]
X-ClientProxiedBy: CAS8.indiv4.local (172.16.1.8) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 18031849959880257134
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfedukedguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtvdejnecuhfhrohhmpefsuhgvnhhtihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtthgvrhhnpeejteetveefhfeludfggeejgffhudekffelhffhjeelieelvddvleevkeeiveetudenucfkphepuddvjedrtddrtddruddpleefrddvuddrudeitddrvdegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprghnughrihhirdhnrghkrhihihhkohesghhmrghilhdrtghomhdpfhifsehsthhrlhgvnhdruggvpdgsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpnhgvthhfihhlthgvrhdquggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpugiguhesugiguhhuuhdrgiihiidpoffvtefjohhsthepmhhoheeguddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 28/04/2023 00:21, Andrii Nakryiko wrote:
> On Thu, Apr 27, 2023 at 2:10 AM Florian Westphal <fw@strlen.de> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>>> @@ -1560,6 +1562,12 @@ union bpf_attr {
>>>>                                  */
>>>>                                 __u64           cookie;
>>>>                         } tracing;
>>>> +                       struct {
>>>> +                               __u32           pf;
>>>> +                               __u32           hooknum;
>>>
>>> catching up on stuff a bit...
>>>
>>> enum nf_inet_hooks {
>>>         NF_INET_PRE_ROUTING,
>>>         NF_INET_LOCAL_IN,
>>>         NF_INET_FORWARD,
>>>         NF_INET_LOCAL_OUT,
>>>         NF_INET_POST_ROUTING,
>>>         NF_INET_NUMHOOKS,
>>>         NF_INET_INGRESS = NF_INET_NUMHOOKS,
>>> };
>>>
>>> So it seems like this "hook number" is more like "hook type", is my
>>> understanding correct?
>>
>> What is 'hook type'?
> 
> I meant that it's not some dynamically generated number that could
> change from the system to system, it's a fixed set of point in which
> this BPF program can be triggered. The distinction I was trying to
> make that it's actually different in nature compared to, say, ifindex,
> as it is fixed by the kernel.

Doesn't this ties the program to a specific hook then? Let's say you
have a program counting the number of packets from a specific IP, and
would you be able to attach it to both LOCAL_IN and FORWARD without
modifying it?

>>> If so, wouldn't it be cleaner and more uniform
>>> with, say, cgroup network hooks to provide hook type as
>>> expected_attach_type? It would also allow to have a nicer interface in
>>> libbpf, by specifying that as part of SEC():
>>>
>>> SEC("netfilter/pre_routing"), SEC("netfilter/local_in"), etc...
>>
>> I don't understand how that would help.
>> Attachment needs a priority and a family (ipv4, arp, etc.).
>>
>> If we allow netdev type we'll also need an ifindex.
>> Daniel Xu work will need to pass extra arguments ("please enable ip
>> defrag").
> 
> Ok, that's fine, if you think it doesn't make sense to pre-declare
> that a given BPF program is supposed to be run only in, say,
> PRE_ROUTING, then it's fine. We do declare this for other programs
> (e.g., cgroup_skb/egress vs cgroup_skb/ingress), so it felt like this
> might be a similar case.
> 
>>
>>> Also, it seems like you actually didn't wire NETFILTER link support in
>>> libbpf completely. See bpf_link_create under tools/lib/bpf/bpf.c, it
>>> has to handle this new type of link as well. Existing tests seem a bit
>>> bare-bones for SEC("netfilter"), would it be possible to add something
>>> that will demonstrate it a bit better and will be actually executed at
>>> runtime and validated?
>>
>> I can have a look.
> 
> It probably makes sense to add bpf_program__attach_netfilter() API as
> well which will return `struct bpf_link *`. Right now libbpf support
> for NETFILTER is very incomplete.

