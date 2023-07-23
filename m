Return-Path: <bpf+bounces-5687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77475E428
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 20:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95F92815AE
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FCA442C;
	Sun, 23 Jul 2023 18:32:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16761869
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 18:32:21 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70DDE64;
	Sun, 23 Jul 2023 11:32:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 4441832000CC;
	Sun, 23 Jul 2023 14:32:15 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 23 Jul 2023 14:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1690137134; x=1690223534; bh=I9RSoe//b4ycHDRnGCvMAXsUqlibqpvp2uB
	p438sHeY=; b=e4TXkkcWbWz6yBNLaJC1OByZ7wyGB8ZHjBdnVMXzTiNJmQFP+j3
	1HKYnTGdJYJfyCW7/15WLXb2svArER93X0VuUOb9qAHdv/drPmPxc5Qierlqpp0D
	L9NY1Lf7Z1LxM9KHZhxJ7tOu9OQgtu3CeCQ/SxgXt+WJDPNiUIrkg/J6/wpTGicS
	sjuVtpQe2Bz4+h8As3EkmczUmupk3FJDgo+SHGTsRc3vOFOlmINa5npQi07V6Jwk
	mts22k4D3mbC6IUfearoRVJOs/bXkh1rnqig6GLAsT/JcAvzRwi7/MqWnF9sKdtD
	8RxObdz+b3tKScBOSOeS72kDAWuwsoCFzuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1690137134; x=1690223534; bh=I9RSoe//b4ycHDRnGCvMAXsUqlibqpvp2uB
	p438sHeY=; b=iy0OHW/iPBafJ4HFPialW/SWLCnNtA/tdmRjvT0zA9jNUKGAHXN
	C/Ci/OAOvcpFtVD/G9joAblG5ZDOkOqCoopZpf69xS/wupE5aSNGIJI8DYY2slOg
	xB9PUP2jXddP8gZGAjvZdLTPEExNjq92DzbvMfdu/cpk/lARTTkLePS+1/V90AMv
	jqGJ7iO02CXV8dmxoMAGqy3vCiSRkrDqP6vItp+RQuVNOncCcl+eCqpcmYY/ZZ59
	PwDy4fwVnaTfMDZ9GnvjsgjJEhVWV3Mf/xWqIRfq01rfARAYMZZFBhPUrHOLbs5z
	me38osYz1ExqPVCM9a7gjDm5SK0sI1JxXPQ==
X-ME-Sender: <xms:LnK9ZNTWyp8vza3di3G8dBYEN2rn3b0-leVwuiIMOsfTuPS9qvA7yA>
    <xme:LnK9ZGwMxnGPoT1EhWfZs4B2vflT-mUq5YbLybfhFhBsqEoxcKAJeUikYDQlzUl4o
    3wrVjANeYhd62MZs6E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheeigdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:LnK9ZC2qbHNUwr1X6LCDoDOQvBASXL_4otLEqOx43vTTddZB24KZjA>
    <xmx:LnK9ZFBPiPJgnltIEC_esuy-erU5EHM6GgQqjRSSnX2UHVy9UgJHjA>
    <xmx:LnK9ZGhpT3W7-W1SC8nZhISp8X8KYDKMcHWx5ttXMduH9cC81nAhWw>
    <xmx:LnK9ZKwi0plV43caelWj49tQ-SUoysDDtCcN1M5MX_z5GWcho-g5Bg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EFC76B60089; Sun, 23 Jul 2023 14:32:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <fa5e9098-d6f9-48a2-bb77-2620b6bb6556@app.fastmail.com>
In-Reply-To: 
 <CAADnVQKGe8DN+Zs387UVwpij3ROGqNEnc5r940h5ueqQYHTYCA@mail.gmail.com>
References: <20230722074753.568696-1-arnd@kernel.org>
 <CALOAHbCV2v3X7g1TD42yve0juhRD2vhq=DMtDz9P6+mX8Dae_w@mail.gmail.com>
 <CAADnVQKGe8DN+Zs387UVwpij3ROGqNEnc5r940h5ueqQYHTYCA@mail.gmail.com>
Date: Sun, 23 Jul 2023 20:31:47 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Yafang Shao" <laoar.shao@gmail.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
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
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 23, 2023, at 18:46, Alexei Starovoitov wrote:
> On Sun, Jul 23, 2023 at 7:25=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
>> On Sat, Jul 22, 2023 at 3:48=E2=80=AFPM Arnd Bergmann <arnd@kernel.or=
g> wrote:
>> > From: Arnd Bergmann <arnd@arndb.de>
>> >
>> > Splitting these out into separate helper functions means that we
>> > actually pass an uninitialized variable into another function call
>> > if dec_active() happens to not be inlined, and CONFIG_PREEMPT_RT
>> > is disabled:
>>
>> Do you mean that the compiler can remove the flags automatically when
>> dec_active() is inlined, but can't remove it automatically when
>> dec_active() is not inlined ?

My educated guess is that it's fine when neither of them are inlined,
since then gcc can assume that 'flags' gets initialized by
inc_active(), and it's fine when both are inlined since dead code
elimination then gets rid of both the initialization and the use.

The only broken case should be when inc_active() is inlined and
gcc can tell that there is never an initialization, but=20
dec_active() is not inlined, so gcc assumes it is actually used.

>> If so, why can't we improve the compiler ?
>
> Agree.
> Sounds like a compiler bug.

I don't know what you might want to change in the compiler
to avoid this. Compilers are free to decide which functions to
inline in the absence of noinline or always_inline flags.

One difference between gcc and clang is that gcc tries to
be smart about warnings by using information from inlining
to produce better warnings, while clang never uses information
across function boundaries for generated warnings, so it won't
find this one, but also would ignore an unconditional use
of the uninitialized variable.=20

>> If we have to change the kernel, what about the change below?
>
> To workaround the compiler bug we can simply init flag=3D0 to silence
> the warn, but even that is silly. Passing flag=3D0 into irqrestore is =
buggy.

Maybe inc_active() could return the flags instead of modifying
the stack variable? that would also result in slightly better
code when it's not inlined.

     Arnd

