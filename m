Return-Path: <bpf+bounces-5735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D5275FEDC
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CB81C20BF0
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADA5100C6;
	Mon, 24 Jul 2023 18:13:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA3FBFB
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 18:13:36 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60C010D;
	Mon, 24 Jul 2023 11:13:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 181165C00E2;
	Mon, 24 Jul 2023 14:13:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 24 Jul 2023 14:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1690222415; x=1690308815; bh=A78TPr7zOQZUSIsSb+PDLz8PQ1fT3C4Qm9t
	i6RePZ8E=; b=ANirWXVEVR9cJ1vNpi/cZT0NE5rOcmmOpjksE8FyNDnVg7dYQlR
	ooAZgrzwMxA75fyKbRW2EPomYLGOVhoPnvH1j39n45/bmJsQYsnZSZA6RqgdCKGu
	hRhpbAoqwttJpr+JTkQ35nMi7M31lq8TGtFc3iL1rXQ4p/+yEilPaf18+vE3EhZw
	6TK4FFJRwXJV23b1lerjgXVLE36lm6zLTBo03pU5HS/reI2ph1fpADMewOfxDjf8
	e7Cjun013/XFhtwngeurLqQ7A9ClUrYQMM3/hJ8LXFfqyxZK7PUwJ69CEIOQNrPp
	CnhOZ6EwS2i0RqQoVq9VSzKpDLwVErRqVAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1690222415; x=1690308815; bh=A78TPr7zOQZUSIsSb+PDLz8PQ1fT3C4Qm9t
	i6RePZ8E=; b=rpJdkhfdqYtYwZ4CFWamwOyyURWVJeJ4Z/8y7+03xTFLzNAgJG3
	8NXIfpu2A5+SPB6lllH2KMu7FvKwS+ydcEJhQgn/c47MsLTd5v9LLne6AA6nOrIy
	h84u4/4yYkYZ9VEvG+gdqNE5ERYPyN0ewMOSpwvakp06AfZMoTICBS6i4EgHvtb2
	6I0/8WXT5CMtGtBSoqJXzvZG8FMrwHLaPYcUdahwJrD8Uzvhyl6+/KA/bCf4cE/V
	fBjmVOXNamnVgk9Jk53zAMP4ezlPjm8Y9snD6bcgJ3XvEyEEZeNAiuBv2aVw5q+z
	8iM+9HOwyNdaebl3Y0oPn9pfedREDnhe4ng==
X-ME-Sender: <xms:Tr--ZBgCUs_j-I1zEc1-rGR-u0rcZtO6bdMA1Zr7J55in10PeFxMzw>
    <xme:Tr--ZGCQ4vmJ3P_SMuO-DtZjXpvondAwhSF2I9Ro4Q80vIntZbAMhkhY3YbvrrO9m
    Z1Gxt0tJuzHPmg5LP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheekgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Tr--ZBERDkNGE0-tWMjVeGpk4phjlHBiy27zhuC2bX9YP8FG39JiAw>
    <xmx:Tr--ZGT24e5Z3lF2N52OODUSFmU_eHUYsoKPbKv93XmZXFnMSvlikg>
    <xmx:Tr--ZOyEB9KuwqBWUUEYPWD_2dvrV4gYKqav67FgWQPrhDMPShHoRA>
    <xmx:T7--ZCA2yEoOHioVC_vuoS0oMeMI-NlojMu1kJP8qncg7A-zOMn33A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 66AF3B60089; Mon, 24 Jul 2023 14:13:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <679d8d63-ce92-4294-8620-e98c82365b2c@app.fastmail.com>
In-Reply-To: 
 <CAADnVQ+p4wpd=tKJAiwB34O1y5vv4mibtkt9D-F7sG=rQapcew@mail.gmail.com>
References: <20230722074753.568696-1-arnd@kernel.org>
 <CALOAHbCV2v3X7g1TD42yve0juhRD2vhq=DMtDz9P6+mX8Dae_w@mail.gmail.com>
 <CAADnVQKGe8DN+Zs387UVwpij3ROGqNEnc5r940h5ueqQYHTYCA@mail.gmail.com>
 <fa5e9098-d6f9-48a2-bb77-2620b6bb6556@app.fastmail.com>
 <CAADnVQ+p4wpd=tKJAiwB34O1y5vv4mibtkt9D-F7sG=rQapcew@mail.gmail.com>
Date: Mon, 24 Jul 2023 20:13:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Yafang Shao" <laoar.shao@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Hou Tao" <houtao1@huawei.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yhs@fb.com>, "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@google.com>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: force inc_active()/dec_active() to be inline functions
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023, at 20:00, Alexei Starovoitov wrote:
> On Sun, Jul 23, 2023 at 11:32=E2=80=AFAM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>>
>> >> If so, why can't we improve the compiler ?
>> >
>> > Agree.
>> > Sounds like a compiler bug.
>>
>> I don't know what you might want to change in the compiler
>> to avoid this. Compilers are free to decide which functions to
>> inline in the absence of noinline or always_inline flags.
>
> Clearly a compiler bug.
> Compilers should not produce false positive warnings regardless
> how inlining went and optimizations performed.

That would be a nice idea, but until we force everyone to
migrate to clang, that's not something in our power. gcc is
well known to throw tons of warnings that depend on inlining:
-Wnull-dereference, -Wmaybe-uninitialized, -Wdiv-by-zero
and other inherently depend on how much gcc can infer from
inlining and dead code elimination.

In this case, it doesn't even require a lot of imagination,
the code is literally written as undefined behavior when
the first call is inlined and the second one is not, I don't
see what one would do in gcc to /not/ warn about passing
an uninitialized register into a function call, other than
moving the warning before inlining and DCE as clang does.

>> One difference between gcc and clang is that gcc tries to
>> be smart about warnings by using information from inlining
>> to produce better warnings, while clang never uses information
>> across function boundaries for generated warnings, so it won't
>> find this one, but also would ignore an unconditional use
>> of the uninitialized variable.
>>
>> >> If we have to change the kernel, what about the change below?
>> >
>> > To workaround the compiler bug we can simply init flag=3D0 to silen=
ce
>> > the warn, but even that is silly. Passing flag=3D0 into irqrestore =
is buggy.
>>
>> Maybe inc_active() could return the flags instead of modifying
>> the stack variable? that would also result in slightly better
>> code when it's not inlined.
>
> Which gcc are we talking about here that is so buggy?

I think I only tried versions 8 through 13 for this one, but
can check others as well.

     Arnd

