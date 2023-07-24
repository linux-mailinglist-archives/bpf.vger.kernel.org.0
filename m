Return-Path: <bpf+bounces-5759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C1476009B
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 22:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66904281563
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F210951;
	Mon, 24 Jul 2023 20:41:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD61F9F2
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 20:41:52 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B537EA;
	Mon, 24 Jul 2023 13:41:51 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 588135C01DA;
	Mon, 24 Jul 2023 16:41:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 24 Jul 2023 16:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1690231307; x=1690317707; bh=cGGxbA6raeMBuCb9imH1rSv60YX9qXFYj7o
	6D1uCY4c=; b=g3FtoeKgOdtntVGG/JV4HNVZSpWgXqvLofzUtmvTemj5q+qfFf1
	XBqX4WKwS5mhTSI6sACrZjvcSzLE9O8KUtne5fkqljlPGgQTVlnJMwtIej1myfdG
	mRGA7y8NTOG9JVwIE2gKM8j+h/Tyuu8xzVcsQrT1/WJuvyhilTBzj5wMhba8CKWF
	xyg06c26F909LnY0n9p1DJBPSgoG1JEiTmY2YYOzdEXSJl7FrckuTWkzkE4ZRLNQ
	7SNRVR1dG/GmvXJyxGwI5EA0byrC/lHev+v+TbttYjOr3tRrTJsmrs1S8z9I3qxH
	13sBWcDPpu5gXu1oPOsRK+wEF/k8uITQytQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1690231307; x=1690317707; bh=cGGxbA6raeMBuCb9imH1rSv60YX9qXFYj7o
	6D1uCY4c=; b=jkd3GSriZUDFpiwrKgxlbSDTMUb1JV4wMrjsYcovZqJdQcy+2o8
	fnIOLZ5F/IyF9yiPa3kGgcGF0hVgN7gYoAMc7C0uujVMw9gQkAq91npWlsewv0tQ
	JBeobd0KO28t51ru6nqpYYEnXQuI0pGjjQtFLzBOsNjMckArIBpF1V0ML0PNiRmz
	ufC+XURKFFPCPSzBnPg8SHeEkyqx7zcxLZqaxuC+DsVHoJ1ULGBJFxJcHjaG32iX
	bvb1O6GsINSkXTeZpb2inkU6h1m1DtguGgViUK4n6dQ/8O/y4lC35dXyRW/lP4+d
	agb2tJcOidZR3cSPUbLcJE0JPNVaBB4rfiA==
X-ME-Sender: <xms:CuK-ZCyfdbofIM-tVKx3p-4OACYU0Mt-e5NpDMYzuZIKyGALd0zUAQ>
    <xme:CuK-ZORpnD1Z6B880dQMHuMh9j88H_FpXvJ0MFtIAGBE1dDP7jS5QzZzgUoWMqceT
    3K6zEruIpb1FsHbz34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheekgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeelfefgueeviefgudduueefueffkeelleeijeelkefgudfgueelledtuddu
    ieegvdenucffohhmrghinhepghhouggsohhlthdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:CuK-ZEVGTBBJ3QkB1m9LqRRA79EdACaZZuG56Mncamv0kptPB6RDNg>
    <xmx:CuK-ZIhVG1o7EV6oYeeDKpTYRX5HNhzwldbHTvYZHcTEknUHh_1kyg>
    <xmx:CuK-ZEBfH_JyFoac9bu_T-GAaZXO8RY8ugdneG_WY6yXw9AOREMSKg>
    <xmx:C-K-ZCTFR6YakNfQvlnZoVe0c6lK2QZLDpImxITLwyBvL5qXcKixOg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9E6B9B6008D; Mon, 24 Jul 2023 16:41:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <3e202277-fe74-4105-93ec-b646efaaa956@app.fastmail.com>
In-Reply-To: 
 <CAADnVQ+zdV9+UNV9NeEzY2rWd8qvW3cvHxS9mYwfhnqZOV+9=A@mail.gmail.com>
References: <20230722074753.568696-1-arnd@kernel.org>
 <CALOAHbCV2v3X7g1TD42yve0juhRD2vhq=DMtDz9P6+mX8Dae_w@mail.gmail.com>
 <CAADnVQKGe8DN+Zs387UVwpij3ROGqNEnc5r940h5ueqQYHTYCA@mail.gmail.com>
 <fa5e9098-d6f9-48a2-bb77-2620b6bb6556@app.fastmail.com>
 <CAADnVQ+p4wpd=tKJAiwB34O1y5vv4mibtkt9D-F7sG=rQapcew@mail.gmail.com>
 <679d8d63-ce92-4294-8620-e98c82365b2c@app.fastmail.com>
 <39444a4e-70da-4d17-a40a-b51e05236d23@app.fastmail.com>
 <CAADnVQ+zdV9+UNV9NeEzY2rWd8qvW3cvHxS9mYwfhnqZOV+9=A@mail.gmail.com>
Date: Mon, 24 Jul 2023 22:41:26 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Yafang Shao" <laoar.shao@gmail.com>,
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

On Mon, Jul 24, 2023, at 21:15, Alexei Starovoitov wrote:
> On Mon, Jul 24, 2023 at 11:30=E2=80=AFAM Arnd Bergmann <arnd@kernel.or=
g> wrote:
>> On Mon, Jul 24, 2023, at 20:13, Arnd Bergmann wrote:
>>
>> I have a minimized test case at https://godbolt.org/z/hK4ev17fv
>> that shows the problem happening with all versions of gcc
>> (4.1 through 14.0) if I force the dec_active() function to be
>> inline and force inc_active() to be non-inline.
>
> That's a bit of cheating, but I see your point now.
> How about we do:
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 51d6389e5152..3fa0944cb975 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -183,11 +183,11 @@ static void inc_active(struct bpf_mem_cache *c,
> unsigned long *flags)
>         WARN_ON_ONCE(local_inc_return(&c->active) !=3D 1);
>  }
>
> -static void dec_active(struct bpf_mem_cache *c, unsigned long flags)
> +static void dec_active(struct bpf_mem_cache *c, unsigned long *flags)
>  {
>         local_dec(&c->active);
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -               local_irq_restore(flags);
> +               local_irq_restore(*flags);
>  }


Sure, that's fine. Between this and the two suggestions I had
(__always_inline or passing the flags from  inc_active as a
return code), I don't have a strong preference, so pick whichever
you like.

      Arnd

