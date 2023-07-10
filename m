Return-Path: <bpf+bounces-4571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C4D74CDB0
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 08:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1391C2095D
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 06:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D7B5239;
	Mon, 10 Jul 2023 06:53:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3B3D90;
	Mon, 10 Jul 2023 06:53:40 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8791B0;
	Sun,  9 Jul 2023 23:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8fvJ1dfbOwyaADnJDf9+J3fyVHcrHpGf3d/xdt5Lyu4=; b=j9BhUQDWr6ZygNAq4EeJHP1VkI
	Lm3sU35eJN4r/kpv0h3UNThFdSJakjfXGO4adMsSd526u7teerzDH4Go1/WZj8K5F/K9spVVq7Ujo
	pUNlhsyPGcCBmV6pezxxqXTPxHkPwFoBnmFl5ZixV6LWfPe0sONn9Ah4epq5cbEG/UpU6L2BiJq10
	H7wHD98xKnsSt4HHC+NFJSNR3lk2ja8JDSJr1eyAX67IQFR09EmGKeix92Jx2Cp8qJREWNNAXfrBr
	UVwJa+Sgv0aGHxN3p3sItsldPXP2b/b2HrMljppBf6IfSWb9oLAeGuPpe0qvvxipXy1YZXPnY3chG
	4ctB/vnQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIklq-000Foy-96; Mon, 10 Jul 2023 08:53:18 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIklp-0002c9-Qa; Mon, 10 Jul 2023 08:53:17 +0200
Subject: Re: [PATCH bpf-next v3 6/8] bpftool: Extend net dump with tcx progs
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, john.fastabend@gmail.com, kuba@kernel.org,
 dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, davem@davemloft.net,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230707172455.7634-1-daniel@iogearbox.net>
 <20230707172455.7634-7-daniel@iogearbox.net> <ZKiENoYiElPyQqrL@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <19f6b5cc-75a2-59b5-ce4b-5efc64c0274e@iogearbox.net>
Date: Mon, 10 Jul 2023 08:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZKiENoYiElPyQqrL@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26964/Sun Jul  9 09:27:43 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/7/23 11:31 PM, Stanislav Fomichev wrote:
> On 07/07, Daniel Borkmann wrote:
>> Add support to dump fd-based attach types via bpftool. This includes both
>> the tc BPF link and attach ops programs. Dumped information contain the
>> attach location, function entry name, program ID and link ID when applicable.
>>
>> Example with tc BPF link:
>>
>>    # ./bpftool net
>>    xdp:
>>
>>    tc:
>>    bond0(4) bpf/ingress cil_from_netdev prog id 784 link id 10
>>    bond0(4) bpf/egress cil_to_netdev prog id 804 link id 11
>>
>>    flow_dissector:
>>
>>    netfilter:
>>
>> Example with tc BPF attach ops:
>>
>>    # ./bpftool net
>>    xdp:
>>
>>    tc:
>>    bond0(4) bpf/ingress cil_from_netdev prog id 654
>>    bond0(4) bpf/egress cil_to_netdev prog id 672
>>
>>    flow_dissector:
>>
>>    netfilter:
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   tools/bpf/bpftool/net.c | 86 +++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 82 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
>> index 26a49965bf71..1ef1e880de61 100644
>> --- a/tools/bpf/bpftool/net.c
>> +++ b/tools/bpf/bpftool/net.c
>> @@ -76,6 +76,11 @@ static const char * const attach_type_strings[] = {
>>   	[NET_ATTACH_TYPE_XDP_OFFLOAD]	= "xdpoffload",
>>   };
>>   
>> +static const char * const attach_loc_strings[] = {
>> +	[BPF_TCX_INGRESS]		= "bpf/ingress",
>> +	[BPF_TCX_EGRESS]		= "bpf/egress",
> 
> Any reason we are not doing tcx/ingress & egress? To match the section
> names.

Ok, will change for v4 to tcx/{ingress,egress}.

