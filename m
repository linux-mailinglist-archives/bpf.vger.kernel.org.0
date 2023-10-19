Return-Path: <bpf+bounces-12694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A17CF9C3
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 14:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700C51C20ECF
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 12:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D691A225B6;
	Thu, 19 Oct 2023 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iYYwDelQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mjx3p4xy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A785225A4;
	Thu, 19 Oct 2023 12:54:02 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB691FD7;
	Thu, 19 Oct 2023 05:53:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id C215C3200ACE;
	Thu, 19 Oct 2023 08:53:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 19 Oct 2023 08:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1697720003; x=1697806403; bh=c+
	OQf9mXsocdxZsSc7Qg9I7aF5FCLMuGCb54DwDnDIE=; b=iYYwDelQB/1pQrjDqD
	+wxGOVgX15b5fVhHulX5D1KgWssBiLtEWMUm88IdtPhTBXrrU9TAAhOpVPuIRXAd
	haM0sz6u4GsmCMqTZnboeJ19b/464N1s4W9XOb/c+kQl+rjHcxyug0YtC0Z0G7fH
	Lo1s+nzXVPBk6KSGQdaPQ5YSYTSTI1X0Qjrv4O96eWvkvB73sNDiGS4ENUnryZxA
	NNC2CKuqGgMR2DBoAh1Y6wCkll44M0s0+mvq8IPRFUF0zB/O8RxRjhGypTK9EpbC
	lLqUFX0K6H9h4Rrot0pMdqcUgLY05kdLNbZn0kdKfwfrT6T7lgqX5rH4gqrofkIh
	PiwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697720003; x=1697806403; bh=c+OQf9mXsocdx
	ZsSc7Qg9I7aF5FCLMuGCb54DwDnDIE=; b=mjx3p4xyhc148ce0bmL6NGiNVF1PH
	2meSQ1Y0xo9jkztYxxZFxoOx17sAyptr3psxKQqa0+BItwMMmC1FBeHMJltK7+Fw
	zwx9HSmRJfmu5jO+yLEZ5PToLdjzHgM94u006RLdD9ovfMO3O+bGeLmnazuCaYx5
	ciN2DuwDBblj09x3ph3Sdnko+BJjvPWL36HJ1UPSmiF8I0X3UHv0gEwGHeI3EXd2
	yPtWh7jXY83BOvm1qRWUG68wjzryk0qQyj9ON0OEmBRziZPp5RkXiNbD1iUlMcd2
	2GTxSJiLqzT2C4DDykOJACpAXeIC+tfbFm0sNSgHElPCIED44huQMMFkQ==
X-ME-Sender: <xms:wiYxZfvAYJ87OzL9VJN9VajqrAd9mgWFUIqvh_ipRUCu-oDhieqG8A>
    <xme:wiYxZQfJ7aLYw3RUOtljHcmchazyXW_2og17Uv9qdFEdGeBWvD90Z6CJ1xuSNYCcU
    NZBv0Z-xolbQEy2UFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeigdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:wiYxZSw6r134fUYOgOhgv3ngUAo50bNAGvSy1QLaIZNf49-vBL7Cbg>
    <xmx:wiYxZeO4Ul-zvjp16Ul8GX0sKIdVXOp2j_Z0qhNLwYD_8-gua6JlzA>
    <xmx:wiYxZf9u3G-k4Z-_FQ-mwH9HDOaPIijI0xYy-wXAB9T3ew_sRQDhgg>
    <xmx:wyYxZVFsp_WBSxC4d5aZFDo0KbDS7UHeT8xw3LEAywvqBYOea_Hrnw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2D5DEB60089; Thu, 19 Oct 2023 08:53:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22580470-7def-4723-b836-1688db6da038@app.fastmail.com>
In-Reply-To: 
 <CAG_fn=XcJ=rZEJN+L1zZwk=qA90KShhZK1MA6fdW0oh7BqSJKw@mail.gmail.com>
References: <20231018182412.80291-1-hamza.mahfooz@amd.com>
 <CAMuHMdXSzMJe1zyJu1HkxWggTKJj_sxkPOejjbdRjg3FeFTVHQ@mail.gmail.com>
 <d764242f-cde0-47c0-ae2c-f94b199c93df@amd.com>
 <CAMuHMdXYDQi5+x1KxMG0wnjSfa=A547B9tgAbgbHbV42bbRu8Q@mail.gmail.com>
 <CAG_fn=XcJ=rZEJN+L1zZwk=qA90KShhZK1MA6fdW0oh7BqSJKw@mail.gmail.com>
Date: Thu, 19 Oct 2023 14:53:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexander Potapenko" <glider@google.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Hamza Mahfooz" <hamza.mahfooz@amd.com>, linux-kernel@vger.kernel.org,
 "Rodrigo Siqueira" <rodrigo.siqueira@amd.com>,
 "Harry Wentland" <harry.wentland@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>, stable@vger.kernel.org,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Nick Terrell" <terrelln@fb.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Tom Rix" <trix@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Kees Cook" <keescook@chromium.org>,
 "Zhaoyang Huang" <zhaoyang.huang@unisoc.com>,
 "Li Hua" <hucool.lihua@huawei.com>, "Rae Moar" <rmoar@google.com>,
 rust-for-linux@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] lib/Kconfig.debug: disable FRAME_WARN for kasan and kcsan
Content-Type: text/plain

On Thu, Oct 19, 2023, at 12:04, Alexander Potapenko wrote:
>> > > Are kernels with KASAN || KCSAN || KMSAN enabled supposed to be bootable?
>> >
>> > They are all intended to be used for runtime debugging, so I'd imagine so.
>>
>> Then I strongly suggest putting a nonzero value here.  As you write
>> that "with every release of LLVM, both of these sanitizers eat up more and more
>> of the stack", don't you want to have at least some canary to detect
>> when "more and more" is guaranteed to run into problems?
>
> FRAME_WARN is a poor canary. First, it does not necessarily indicate
> that a build is faulty (a single bloated stack frame won't crash the
> system).

I agree it's flawed, but it does catch a lot of bugs, both in the
driver and the compiler. What we should probably have is some better
runtime debugging in addition to FRAME_WARN, but it's better than
nothing.

One idea that I've suggested in the past is to add a soft stack
limit that is lower than THREAD_SIZE, using VMAP_STACK with a custom
stack start and a read-only page at the end to catch a thread
exceeding the soft limit and print a backtrace before marking
the page writable.

> Second, devs are unlikely to fix a function because its stack frame is
> too big under some exotic tool+compiler combination.

I've probably sent hundreds of fixes for these in the past. Most
of the time there is an actual driver bug, and almost always
the driver maintainers are responsive and treat the report with
the appropriate urgency: even if only some configurations actually
push it over the limit, the general case is some data structure that
is hundreds of bytes long and was not actually meant to be on
the stack.

The gcc bug reports also usually get addressed quickly, though
we've had problems with clang not making progress on known
bugs for years. It sounds like Nick has made some important
progress on clang very recently, so we should be able to
raise the minimum clang version for kasan and kcsan once
there is a known good release.

> So the remaining option would be to just increase the frame size every
> time a new function surpasses the limit.

That is clearly not an option, though we could try to
add Kconfig dependencies that avoid the known bad combinations,
such as annotating the AMD GPU driver as

      depends on (CC_IS_GCC || CLANG_VERSION >=180000) || !(KASAN || KCSAN)

    Arnd

