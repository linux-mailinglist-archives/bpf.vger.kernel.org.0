Return-Path: <bpf+bounces-4572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB274CDBE
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 08:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE44280F50
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 06:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA45244;
	Mon, 10 Jul 2023 06:57:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261463D8C;
	Mon, 10 Jul 2023 06:57:14 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8433E7;
	Sun,  9 Jul 2023 23:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6YEh6S2RB/GZk+gCoVcUnnZi+dpDGelxs08xDAdj6eQ=; b=rTa6xDLWXuvnQggmW7isFFM0lM
	rs+T2NQV+55snlVp4L2LsEWL8BQjZ4i+XayhxAEAHRundIlPxteNT68rLhbzim+iu0TiMe93qYqtP
	ehKhjAQIBTGseseYEZ/pzxY2J5BVGRcmNIvNouahbueAOnRllKmQOF8ALytUnTmR6rx29wKy0R10b
	KmOm/xMlbVKkRy/4DgOM0oDSbQlbSE7Lo+Mz8qSjb8wgy5/sRWjzTwjekU0LcNELsPLPGQ0pwby+Q
	E4Av7UzzmS4JCRVA+/ha6RA30mAxdmeS2xtTTDOriH8i4vRo5zBFaRV36l0fhySN9hwIXqCTB03jz
	HiJ0Q3Lg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIkpV-000H6B-7X; Mon, 10 Jul 2023 08:57:05 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIkpU-0000Iy-Jt; Mon, 10 Jul 2023 08:57:04 +0200
Subject: Re: [PATCH bpf-next v3 2/8] bpf: Add fd-based tcx multi-prog infra
 with link support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
 davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230707172455.7634-1-daniel@iogearbox.net>
 <20230707172455.7634-3-daniel@iogearbox.net>
 <20230709171934.o2v4o5lc66qczygd@MacBook-Pro-8.local>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2ced8289-a0fa-11ca-d133-8eefe9af05f2@iogearbox.net>
Date: Mon, 10 Jul 2023 08:57:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230709171934.o2v4o5lc66qczygd@MacBook-Pro-8.local>
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

On 7/9/23 7:19 PM, Alexei Starovoitov wrote:
> On Fri, Jul 07, 2023 at 07:24:49PM +0200, Daniel Borkmann wrote:
>> diff --git a/net/Kconfig b/net/Kconfig
>> index 2fb25b534df5..d532ec33f1fe 100644
>> --- a/net/Kconfig
>> +++ b/net/Kconfig
>> @@ -52,6 +52,11 @@ config NET_INGRESS
>>   config NET_EGRESS
>>   	bool
>>   
>> +config NET_XGRESS
>> +	select NET_INGRESS
>> +	select NET_EGRESS
>> +	bool
> 
> Since new kconfig is needed, can NET_INGRESS and NET_EGRESS be removed at the same time?

No because netfilter can pick these individually :

config NETFILTER_INGRESS
         bool "Netfilter ingress support"
         default y
         select NET_INGRESS
         help
           This allows you to classify packets from ingress using the Netfilter
           infrastructure.

config NETFILTER_EGRESS
         bool "Netfilter egress support"
         default y
         select NET_EGRESS
         help
           This allows you to classify packets before transmission using the
           Netfilter infrastructure.

Thanks,
Daniel

