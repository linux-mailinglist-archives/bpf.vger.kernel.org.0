Return-Path: <bpf+bounces-9683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A979AAFA
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 21:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBB928123F
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E046C15ACA;
	Mon, 11 Sep 2023 19:06:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21D515AC3
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 19:06:08 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB1DD
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mzXrjMPVTLKQM6JSHw1DITdTtYk3sMxbGXGvNUVXt8k=; b=N8kpzyBPEcKrXVa6mCEQRejl5+
	83LwR0Yoi6lRJheE5Jn0Tweckm7ST254ZQef3ZtzGNTYax07y3b5ypJehhZM3CykFfsaEjytzW9gQ
	ROzE0urf1UwhfVisHd1WcA6RcQ5XLhn6DHKXP2dQInqM2170owXSS/S50Uh/W66VNPYPG3UVkyLvK
	QGJCFSuATWJejG60fBRk81HruVw0SC7o/hecLpIIJF7iuQ0xxZfzwRL54/vGJJsomc7F90Hvbmsg6
	/5Mouul7ZXZmYdH5fIIqOzRiRITF3dVbnGCpdePfYfqfAn3/PzXGPAqSWFwkZUYdKGtXR9GEeGotu
	yOd6LCPA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qfmEO-000HIk-NL; Mon, 11 Sep 2023 21:05:56 +0200
Received: from [208.125.9.132] (helo=localhost.localdomain)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qfmEO-000Vkl-7H; Mon, 11 Sep 2023 21:05:56 +0200
Subject: Re: [PATCH bpf-next 1/2] bpf: return correct -ENOBUFS from
 bpf_clone_redirect
To: Stanislav Fomichev <sdf@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20230908210007.1469091-1-sdf@google.com>
 <acdb12bc-518a-c3f6-ef09-2dfd714770b5@linux.dev>
 <ZP9KJpQIpoYqzaB3@google.com>
 <a7570c31-b19d-e1d8-8e7e-f47ead34b79b@iogearbox.net>
 <ZP9RSu3QDRN0wsr/@google.com>
 <927cc104-a266-7300-f601-e39d5d0fef59@iogearbox.net>
 <ZP9h71zBaUUVsYYs@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fd2d8a2c-8c69-c746-a1e3-49ed75ded29a@iogearbox.net>
Date: Mon, 11 Sep 2023 21:05:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZP9h71zBaUUVsYYs@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27028/Mon Sep 11 09:37:06 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/11/23 8:52 PM, Stanislav Fomichev wrote:
> On 09/11, Daniel Borkmann wrote:
>> On 9/11/23 7:41 PM, Stanislav Fomichev wrote:
>>> On 09/11, Daniel Borkmann wrote:
>>>> On 9/11/23 7:11 PM, Stanislav Fomichev wrote:
>>>>> On 09/09, Martin KaFai Lau wrote:
>>>>>> On 9/8/23 2:00 PM, Stanislav Fomichev wrote:
[...]
>>>> I think my preference would be to just document it in the helper UAPI, what
>>>> Stan was suggesting below:
>>>>
>>>> | Note, this is technically breaking existing UAPI where we used to
>>>> | return 1 and now will do -ENOBUFS. The alternative is to
>>>> | document that bpf_clone_redirect can return 1 for DROP and 2 for CN.
>>>>
>>>> And then only adjusting the test case.
>>>
>>> In this case, would we also need something similar to our
>>> TCP_BPF_<state> changes? Like BUILD_BUG_ON(BPF_NET_XMIT_XXX !=
>>> NET_XMIT_XXX)? Otherwise, we risk more leakage into the UAPI.
>>> Merely documenting doesn't seem enough?
>>
>> We could probably just mention that a positive, non-zero code indicates
>> that the skb clone got forwarded to the target netdevice but got dropped
>> from driver side. This is somewhat also driver dependent e.g. if you look
>> at dummy which does drop-all, it returns NETDEV_TX_OK. Anything more
>> specific in the helper doc such as defining BPF_NET_XMIT_* would be more
>> confusing.
> 
> Something like the following?
> 
> Return
> 	0 on success, or a negative error in case of failure. Positive
> 	error indicates a potential drop or congestion in the target
> 	device. The particular positive error codes are not defined.
> 

yeap, sgtm

