Return-Path: <bpf+bounces-1167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FDE70F797
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 15:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC371C20D52
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A599F182B4;
	Wed, 24 May 2023 13:29:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7160868
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 13:29:11 +0000 (UTC)
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E8AA;
	Wed, 24 May 2023 06:29:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.west.internal (Postfix) with ESMTP id 829EF2B063E5;
	Wed, 24 May 2023 09:29:07 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 24 May 2023 09:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1684934947; x=1684942147; bh=Gi
	PY4yhJsIKIhF61iNGa8GklXontEhtTLZkU/4WyhdM=; b=AfqXSSE02JYMjhCrPB
	IhnSrYEDfNwp6ZTKQCC0WNafkyLTSrRneXdUTQoCXb4Dq0tqDV3cY9uX96ygbjJy
	/X7/7YYLVmYz2hZWLrw1Wy+M3GY7uwPZF5xscl7z2BxfXiTYXdtEGvGh6zzI8JBk
	epnaKDNI20xppUukZSTlfG1r+r1rfzAfMAmtgZC3S4pBZomPQyi0y0sV1YUxYnwa
	/rfWBBe0tG193m9QXCYrZA9oBLiCVKCnFMwigkDYXWHQ2iY9JxT0sir4hyo1zaLr
	kviH19unfm9qo8foDKhunIAafN/eo8NFu+oGDzJnboI0U11yw16I5HU2kVV/larp
	dAag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1684934947; x=1684942147; bh=GiPY4yhJsIKIh
	F61iNGa8GklXontEhtTLZkU/4WyhdM=; b=BkwU785lTFysm6mx9P6nPMhnybzBy
	9lyDJSpU86Ex/R68NDtd2SsGHr/JomzKeXEyqSfVYOUFRowmbmYIg9pOdUdaD+eg
	Xre9jwdleD5xEGZXMXyuiGnfxwDYQxy2/HBspZx8VFkLszACjjKDBO9MktMqelZv
	a/rfINW3Nb08xZ8y6YHFdYGBNaowwBPXSR7vNvnDvzN1CBX9xt6wT85X9BG7BLnX
	PUOBfiiFGn/jfe9HmduyyK3RbjLK+4yL2ENhgtmSBYqcqCB+W34vcUJNMnE+kG5q
	Tu0SAOo+52BmyWpGa1LjyEFPbgajJEN9STmyh1DsRBUFw56iav2F+FGng==
X-ME-Sender: <xms:IhFuZBXskF8N8-5mWKU054mddUznMPRzG4myU7IB_2p9eIYBtPqb7w>
    <xme:IhFuZBl_IQba2T8NBi8rPJOH1MLZP3KBKsQiFs29TFus_yYCL0d20BEhIDkt3pYCk
    jp_GSDYeporFxG4HPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:IhFuZNbr34T7IAWCWG9NmJvAKlqnv4a-4KYDcMPqKMElUV3efnr-hw>
    <xmx:IhFuZEUaZQNcQy43x-fhRAuUTHIvxyCMA8KibM9aXxkODyXbXntUoQ>
    <xmx:IhFuZLnxhZEEnQFLWYSfWJ35uMbXVx89E7OjoK1GtgK5zcbNC9fO4g>
    <xmx:IxFuZNsLaiXKgJ3Yn3H3_u6S7-38UjRvb5bCDuDuV2rW5gD8FjeUYnAkTCU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BFF1AB60086; Wed, 24 May 2023 09:29:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <a63a344c-e64e-4f2a-9082-f970ae9f963a@app.fastmail.com>
In-Reply-To: <3c029fae-cb42-5a75-2858-7b8fc56a8769@meta.com>
References: <20230523194930.2116181-1-arnd@kernel.org>
 <20230523194930.2116181-2-arnd@kernel.org>
 <3c029fae-cb42-5a75-2858-7b8fc56a8769@meta.com>
Date: Wed, 24 May 2023 15:28:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yonghong Song" <yhs@meta.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Song Liu" <song@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Cc: stable@vger.kernel.org, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Yonghong Song" <yhs@fb.com>, "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@google.com>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Dave Marchevsky" <davemarchevsky@fb.com>,
 "Joanne Koong" <joannelkoong@gmail.com>, "Delyan Kratunov" <delyank@fb.com>,
 "Peter Zijlstra" <peterz@infradead.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] bpf: fix bpf_probe_read_kernel prototype mismatch
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 24, 2023, at 05:12, Yonghong Song wrote:
> On 5/23/23 12:43 PM, Arnd Bergmann wrote:

>> Aside from the warning, this addresses a bug on 32-bit architectures
>> from incorrect argument passing with the mismatched prototype.
>
> Could you explain what is this '32-bit architectures ... incorrect 
> argument passing' thing?

I've expanded that paragraph now:

| Aside from the warning, this addresses a bug on 32-bit architectures
| from incorrect argument passing with the mismatched prototype:
| BPF_CALL_x() functions use 64-bit arguments that are passed in
| pairs of register or on the stack on 32-bit architectures, while the
| normal function uses one register per argument.

Let me know if you think I should put more details in there.

>> @@ -1635,11 +1636,13 @@ bool bpf_opcode_in_insntable(u8 code)
>>   }
>>   
>>   #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>> -u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
>> +#ifndef CONFIG_BPF_EVENTS
>> +int bpf_probe_read_kernel_common(void * dst, u32 size, const void *unsafe_ptr)
>
> void * dst => void *dst
>

Fixed now.

Thanks,

     Arnd

