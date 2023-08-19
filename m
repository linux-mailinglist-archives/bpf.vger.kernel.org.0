Return-Path: <bpf+bounces-8121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9670781848
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 10:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46FA281C2D
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 08:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2793820EA;
	Sat, 19 Aug 2023 08:15:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADBA57;
	Sat, 19 Aug 2023 08:15:24 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97E82710;
	Sat, 19 Aug 2023 01:15:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id DD4BA320010B;
	Sat, 19 Aug 2023 04:15:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 19 Aug 2023 04:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1692432917; x=1692519317; bh=mVg7+z/59hMefv6EatBj5KT4jPl/Nf37DQy
	lbZT0lF0=; b=l7+Idw7IXTlvGLWtkX4Yk9YD3/pIkjlXypJGt7S8HC/9liI1Cdj
	AbiC77K/z0YBVQ/FVPplg+bytdlQ+dCc6NLsE/mqDY3v3d5deNXUK+iCoPqLoR4m
	7KEnWqflPdY4rVYIZ2nrq0D4B9axmUmMzkaWbpOCHFtDQHYcLbg7HnL9XIIq2f0a
	mK3zqk15aTNX0cHqWpDSzQHd7FW/4LyCfysFsUH2Dm9exVtC1p5Wo5QNbC+o51R2
	rJg3xLibAhOvJd9AOLlO0dwSv/nxgjI2n7dRMLqBJ4h5gtIzWF7nWo66Nkl2HcVZ
	5u2GV2DhRUor71Xr+SsbHXQYqCUb3sNoSfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1692432917; x=1692519317; bh=mVg7+z/59hMefv6EatBj5KT4jPl/Nf37DQy
	lbZT0lF0=; b=t6N2GC4hYniQXEfaTz2EuUH27T0sH45C1jfxLNXZxFos7HH40gT
	KBtE6edJ+rySMY3zSRjIO+7Ks3Pdn6URlSpydJymaYRu4IqS7rdz+hTuOSX0GrPa
	xKP3tHtONDVXgCKm/BZKpEKPFkPZcKDiOk48Ur3IL9ysISycJdFRi1weyZmQwy3h
	V9P4P56zaIQKJwLkFbLN29w95tx/fWeStGG89LaHLpAMdP3z5TMObUbIHBo5o0RO
	S5dA4M6DY7W7sInbbXOGEMqSICvCzeQLTOSQs4HdjoJvLGm7r4PlLJNiQkMnpam7
	ZRRY6EBwhtMkX+9Z6+l1qC2Xusq2Rb7AvdQ==
X-ME-Sender: <xms:FXrgZPjnB5QfQ4PRwkdTFgVeaN_4v5hYrLgtB-SJsuYC3ocaUzD-3Q>
    <xme:FXrgZMCwXFK_V-4i3OOVNf8ITegB7tIIpKZs8YUj1S3Fv25-7Non3G_GcgMY_6Hi6
    7GzKbd4pYIFh-cE32Q>
X-ME-Received: <xmr:FXrgZPEZpMAo-2JYx9rLLvwfHLhNQpGBXAIgu6gVwQYTx5VBle0A3_1kfvalUHNvSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduhedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghn
    jhhushgrkhgruceomhgvsehmrghnjhhushgrkhgrrdhmvgeqnecuggftrfgrthhtvghrnh
    epudevveejhfejvdegvedvuedtueekleejlefhfedtheekhfefiedvgfdukeeuieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehmrg
    hnjhhushgrkhgrrdhmvg
X-ME-Proxy: <xmx:FXrgZMT9PKKTCwesqnzedCRN4dcTB3WJCdpowJ9jyEKcW-jGGDCsnQ>
    <xmx:FXrgZMzo6QRDBv_SO0sjkjULJLR_oeGvE0uv8NMAs_s9b9nyiD7Y6w>
    <xmx:FXrgZC4DtkP2j10vgUQw1TzrGZXDMQJlTsCl6A_-0FWiMZqWSUrKPA>
    <xmx:FXrgZBpGDKAfRw10usHn5sM9lmFylMEI84bEKe7Ptud62Aq7v7D6dQ>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Aug 2023 04:15:13 -0400 (EDT)
Message-ID: <3b997205-bca6-4dba-94fe-65facb84015e@manjusaka.me>
Date: Sat, 19 Aug 2023 16:15:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, ncardwell@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com, rostedt@goodmis.org
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
 <20230812201249.62237-1-me@manjusaka.me> <20230818185156.5bb662db@kernel.org>
 <CANn89iLYsfD0tFryzCn2GbhrX4n+e0CPTXB6Vc=_m=U9Qi_CzA@mail.gmail.com>
Content-Language: en-US
From: Manjusaka <me@manjusaka.me>
In-Reply-To: <CANn89iLYsfD0tFryzCn2GbhrX4n+e0CPTXB6Vc=_m=U9Qi_CzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/19 11:10, Eric Dumazet wrote:
> On Sat, Aug 19, 2023 at 3:52 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Sat, 12 Aug 2023 20:12:50 +0000 Zheao Li wrote:
>>> In normal use case, the tcp_ca_event would be changed in high frequency.
>>>
>>> The developer can monitor the network quality more easier by tracing
>>> TCP stack with this TP event.
>>>
>>> So I propose to add a `tcp:tcp_ca_event` trace event
>>> like `tcp:tcp_cong_state_set` to help the people to
>>> trace the TCP connection status
>>
>> Ah, I completely missed v3 somehow and we got no ack from Eric so maybe
>> he missed it, too. Could you please resend not as part of this thread
>> but as a new thread?
> 
> I was waiting for a v4, because Steven asked for additional spaces in the macros
> for readability ?

I think the additional spaces should not be added in this patch. Because there will
be two code style in one file.

I think it would be a good idea for another patch to adjust the space in this file

