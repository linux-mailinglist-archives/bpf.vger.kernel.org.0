Return-Path: <bpf+bounces-5868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3E4762351
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 22:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFAB1C20F78
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 20:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C282D26B36;
	Tue, 25 Jul 2023 20:28:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992BB1F186
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 20:28:01 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F910F7;
	Tue, 25 Jul 2023 13:27:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 7F84F320090A;
	Tue, 25 Jul 2023 16:27:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 25 Jul 2023 16:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1690316873; x=1690403273; bh=za3mSnmYbr5Vnxd+8OQOza/6YO1UkcBgVZ/
	nw5zjFf0=; b=gUv3ZGzWiEACvhk9H2JVkhbcDQzc7XHyBi2UFpooefyveVMr+iH
	j4ZFZFCCHWvPzpyKW/JlvVHNdCDeMseTtDdDX4mmSPOJPwA4xWfsuN7neVlLl9n5
	avKHp0zsz5ZZBhv3RgUk3Z2QwOBBuHQCzsKQYrADbCqsRdjMK4X1/gsB9u1JVBqy
	0Li0eQ8fSqHDguCR3uACAV0lbEb3CZpljskYNu9v+69v2OpJ7rjKz2Ap6+bGCWxZ
	3ejFwgQuYkypKeWPO3uubxF5O079vRN0nlDBOxj1mOikNhBmdUnyPIidqTmEo7iU
	kG73tSGuhlDW92A/LO5dNGEsM6MonMaerpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1690316873; x=1690403273; bh=za3mSnmYbr5Vnxd+8OQOza/6YO1UkcBgVZ/
	nw5zjFf0=; b=mZbvVjhuG8A6WVYwLWtM0oOdNXz/Po6kitjw/sjcnMyaddR17kS
	82fwTCmu6mwq8shI+HTyrzZ++7tsz2NXSkM8uEXOTEG8KOh/JLmIZJRY59fbdgBV
	HguwC7R6PPlEeCXFXxGzXCdqsc/4FOpyYvapKe2KYdI0S3XHzs+q8AI5A7S9/zsr
	oT+MD93z8VMIHdjt1YUCBxfltA4PldUqaVqf9WcXyQEsl2LFcNvv72JkQLOrIbz+
	dnS2WnQHZ9/7FPN/S9Mjo2xz4l2i5hM91+IUvd56VSPT92a5mJOJ/yVIYQU069rU
	xO9IenpuaHP9XdSmSlA7DELd5MeySNAgtoQ==
X-ME-Sender: <xms:SDDAZColMs7JJ2gpI_NttN1WavzGuGgUh0uFa7zitdPwDvzrCp47ew>
    <xme:SDDAZAqra8-nhliEKK7eCrqY1eslc7i_ottNSGr_Tb3JKEMtE-qX67AlHldmkXB7-
    iGo77MbspiwOLKs5eM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:SDDAZHMnG11Qi5Ho45Os5te9C2XqP0HLheSwWC4LQZSlk1LsTNyOSQ>
    <xmx:SDDAZB6K6Ga_79LCe9AjWL2pRipSfHZqrCsdoSxGObmuYeH9j9MInQ>
    <xmx:SDDAZB6HBVGi6mtULZX75_MBOdNkO2lvnU0ipNgPaGWETxap_Nda_g>
    <xmx:STDAZIqKKyfBCTb1pOFNxUhQY17sjj9FpK1kG4-PlOuNm5WqNuz7Rw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 70774B60089; Tue, 25 Jul 2023 16:27:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <49e860d2-941c-4e66-90af-d9fb7ddcd401@app.fastmail.com>
In-Reply-To: 
 <CAADnVQJWfQVGWsruzTHB9v=kztkDeRbJJDANafVScEE4EJ1jbg@mail.gmail.com>
References: <20230722074753.568696-1-arnd@kernel.org>
 <CALOAHbCV2v3X7g1TD42yve0juhRD2vhq=DMtDz9P6+mX8Dae_w@mail.gmail.com>
 <CAADnVQKGe8DN+Zs387UVwpij3ROGqNEnc5r940h5ueqQYHTYCA@mail.gmail.com>
 <fa5e9098-d6f9-48a2-bb77-2620b6bb6556@app.fastmail.com>
 <CAADnVQ+p4wpd=tKJAiwB34O1y5vv4mibtkt9D-F7sG=rQapcew@mail.gmail.com>
 <679d8d63-ce92-4294-8620-e98c82365b2c@app.fastmail.com>
 <39444a4e-70da-4d17-a40a-b51e05236d23@app.fastmail.com>
 <CAADnVQ+zdV9+UNV9NeEzY2rWd8qvW3cvHxS9mYwfhnqZOV+9=A@mail.gmail.com>
 <3e202277-fe74-4105-93ec-b646efaaa956@app.fastmail.com>
 <CAADnVQJWfQVGWsruzTHB9v=kztkDeRbJJDANafVScEE4EJ1jbg@mail.gmail.com>
Date: Tue, 25 Jul 2023 22:27:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Yafang Shao" <laoar.shao@gmail.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023, at 20:15, Alexei Starovoitov wrote:
> On Mon, Jul 24, 2023 at 1:41=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>
>> Sure, that's fine. Between this and the two suggestions I had
>> (__always_inline or passing the flags from  inc_active as a
>> return code), I don't have a strong preference, so pick whichever
>> you like.
>
> I think:
> static void dec_active(struct bpf_mem_cache *c, unsigned long *flags)
> is cleaner.
> Could you send a patch?

Ok, done,

     Arnd

