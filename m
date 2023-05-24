Return-Path: <bpf+bounces-1166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423E170F786
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 15:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB4D281358
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4971775C;
	Wed, 24 May 2023 13:23:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7244E6087B
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 13:23:51 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DBAE9;
	Wed, 24 May 2023 06:23:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id B89263200201;
	Wed, 24 May 2023 09:23:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 24 May 2023 09:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1684934625; x=1685021025; bh=ra
	B7OJ7UdVre69aPRy4rO+ZRGCd+zuLQcF+Qv/YoZG8=; b=KeN+SZ3c314DpYLTMq
	MBBXznHtrN2C+qFdeSIJq3xOBZ0k29HIC+Xtw6daL+hf9K5z8EyWyGcHGyo5bmux
	Ade06pXwCVbRZWyrqwUq5i0SeM2ZORXKbW6F4p1ybuaWErf4zIxhdFC1nm0s74Kj
	MvDP4siVQQD9P2pBX3hkTL76qx5cTU8LMrn2s+69+M+NEFuK03eSspFgs/6LjBz5
	19WiTORXXhHSrwaT2puNtkAdy1QUAINDeyCu7skj3fk5mwwxbiqrxAYR+B2WqYv8
	+xBr1qCJgSrnU+YINARYe94FeBkRVNkPyeoFXqAj9fgf757atGqCTiBDlzoDVQ2r
	mjhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1684934625; x=1685021025; bh=raB7OJ7UdVre6
	9aPRy4rO+ZRGCd+zuLQcF+Qv/YoZG8=; b=E6pqQAcWCmgAa1czwjMCpTyu9whwy
	2M4I2KVD0Gae7jhhVOV6WiZr5W18owt4YYHKsYbM2Gwxp0y6qo2/61S5ZSkNQEss
	mt8SOKFwkTygqSrZfXDHt43AyQ+YrVTxCd5xjVJ6jQKE5I0IGTtEUJUWUjshUnkP
	/J2PJB20kSXTbytywZ1xdNLIHQH2wkmOLFllRXlfxDu1pWMQKGywc5Gsw8SDjInE
	B7A7N6TAS8nE0msYcUYN3UKjqZFTMkdcpJ8WMsEivMAw4tZ+KdMx6PIXkQQIq/cO
	bttJROhbaE9nn8auKbIakqIJWmvFZIK5mH3K0sQdSP1P+y0m+tm+GzD2g==
X-ME-Sender: <xms:4A9uZBj9YgkKdHnHldzzQBzhuuOyvnCUj80QVD00mQyxlkwPtGJrQg>
    <xme:4A9uZGBvn1h9bFnLU5nNwSGC3x3KZZrjVdrU7f7mp36-uj8zCpq1EMhmpwECsSytj
    yQkLXJeKsMfu4YiA5I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4A9uZBEE092hwupMxH4S4SHtrfsXDcp7cZkbOc90SrYhpBO9CmBjrA>
    <xmx:4A9uZGRtD8vPxhudzeLLaSn0ZisnDtqqV0bRSA705F-1DunwVgFrIA>
    <xmx:4A9uZOwvTR6oTTCkL_MlLzb5pl6KhTP4jvOvg8pPcofLxU00w6ekag>
    <xmx:4Q9uZCjQXpAkyjuLARR3j-0yMheIgCCw0SkzJBcsCeQPV2VAwlXf0A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C5888B60086; Wed, 24 May 2023 09:23:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <e23c5155-477b-465e-a811-61945d68fde7@app.fastmail.com>
In-Reply-To: <f7b6f68e-f218-9d7f-22dc-3e4bac70051a@meta.com>
References: <20230523194930.2116181-1-arnd@kernel.org>
 <f7b6f68e-f218-9d7f-22dc-3e4bac70051a@meta.com>
Date: Wed, 24 May 2023 15:23:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yonghong Song" <yhs@meta.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>
Cc: "John Fastabend" <john.fastabend@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yhs@fb.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@google.com>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [v2] bpf: hide unused bpf_patch_call_args
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 24, 2023, at 05:05, Yonghong Song wrote:
> On 5/23/23 12:43 PM, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> This function has no callers and no declaration when CONFIG_BPF_JIT_ALWAYS_ON
>> is enabled:
>> 
>> kernel/bpf/core.c:2075:6: error: no previous prototype for 'bpf_patch_call_args' [-Werror=missing-prototypes]
>
> If CONFIG_BPF_JIT_ALWAYS_ON is enabled, the definition of
> bpf_patch_call_args should be invisible. Maybe I missed something.
> Could you list *ALL& bpf related config options in your setup
> so people can reproduce you above error messages?

Sorry, my mistake. I've reworded the changelog now to fix this:

| This function is only used when CONFIG_BPF_JIT_ALWAYS_ON is disabled,
| but CONFIG_BPF_SYSCALL is enabled. When both are turned off, the
| prototype is missing but the unused function is still compiled,
| as seen from this W=1 warning:
| 
| kernel/bpf/core.c:2075:6: error: no previous prototype for 'bpf_patch_call_args' [-Werror=missing-prototypes]
| 
| Add a matching #ifdef for the definition to leave it out.

If this makes sense now, I'll send out a v3.

      Arnd

