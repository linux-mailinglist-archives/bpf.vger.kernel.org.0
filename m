Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A0A6A063D
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 11:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjBWK3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 05:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjBWK3u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 05:29:50 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6BC2ED52;
        Thu, 23 Feb 2023 02:29:46 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C53413200997;
        Thu, 23 Feb 2023 05:29:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 23 Feb 2023 05:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677148182; x=
        1677234582; bh=ImfAclw8JtkER0BgVZhEUyyVgmeXkFJxZATY4r89d2A=; b=w
        44VakIQQgjQckHOo1xGw/L8SEbpAQKAKM1Ra6UAeuZeetwSEq/TEZJBb+wsSyb+H
        hJr/GgkdAJwNsyL+3qTg+t/t6HnLGyWFjjxzkM8GqBL/oyO6EC/PNpz5Q5P7GVBh
        PYveLDpdvvbGUrcID9ALAzCtN0VxjmV9o1x398q29jGqFi4d0fUPR0jJkhqb17/G
        6bPvSbCSLluEKYn9njcBwiTSvznQF/Iq+QJfAZJyEzkFlVM7aySylhTSvnKWo3hE
        J1l89t14HCAwfHP6MmvKHKGSgy3iBkKtEWX06+twn9/UtmWQFUZ2TWfJmTB0rNJS
        4A234whN+oJZwWS75dvTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677148182; x=
        1677234582; bh=ImfAclw8JtkER0BgVZhEUyyVgmeXkFJxZATY4r89d2A=; b=L
        aliKpjsDRLAWv8sFideGoJWBn9UovZ/znWIvANSx0lHMtxUpRDdYQCQ0aXOJk1fJ
        s1v1gum/RCwmHou0C2Wr9DvdoMnrZPjh02HPLneUuP/gd0LIo4uLKq9Q5MoM8BOV
        dwTng+Mr94PYTzRb9DokS9zY9c1n5XVDqByamD14dAFv4L8vAT5VJi60h25dgRQM
        QBR70m02FyUxRzbet3ZW5aJ90+HPoEo787U71Idg6Eqbp3DhTttZ6LFsHSXGyQaU
        rzFRfyGk9E1XWNJGm6KxWnN5kUZ9GGW3Bzv8T1SZu7y7LlInzrB0PTG5zWXwUGXY
        k+wXEIZjQRYxPip9mGS7g==
X-ME-Sender: <xms:FUD3Y5YqH0YH7retA9oqN5sV8IC6Oqy1avfJN45F-LCyaVUr6a-TFw>
    <xme:FUD3YwYCxnmFac4bZBLoYmMZNEmd8ec1BNsQZ2fGd6K7JGZcXCB4xbQhcXxKG1D6M
    ZuB3MDPW4uIAf_RFXY>
X-ME-Received: <xmr:FUD3Y7-YCMitVRgSMVIPCfZxVjaL8tZbSVZAPJfZsS6NHMPpE6Y_uXRG4Z7tXaquHJ8T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekuddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:FUD3Y3oP3Js9HdfYOyKeYz0L-DsB7mHzVyGF9ATbOt9a_lZPxgzNlQ>
    <xmx:FUD3Y0r3VV9Jn5qwmo5dB8TauaHIO7221K-DrYYavqbBUelSTGtV0w>
    <xmx:FUD3Y9Ri5XgX-nzYJD_Sbm6rmTrn0PMwlTw9bbUS96HsSgQL_c0RgA>
    <xmx:FkD3Y8IZbJQ3S9DFE6ub9sY3yiyFP4n3DELxfX3G6O72LJt9LAcGqw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Feb 2023 05:29:40 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 1/2] MIPS: ebpf jit: Implement DADDI workarounds
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAM1=_QQRmTaAnn0w6wteQ_FKgoF=vGX_okfbiUHdyUB0ZzNghQ@mail.gmail.com>
Date:   Thu, 23 Feb 2023 10:29:28 +0000
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7CAF04EF-FC1D-4BE1-A639-92D677525C63@flygoat.com>
References: <20230222161222.11879-1-jiaxun.yang@flygoat.com>
 <20230222161222.11879-2-jiaxun.yang@flygoat.com>
 <CAM1=_QQRmTaAnn0w6wteQ_FKgoF=vGX_okfbiUHdyUB0ZzNghQ@mail.gmail.com>
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> 2023=E5=B9=B42=E6=9C=8823=E6=97=A5 10:10=EF=BC=8CJohan Almbladh =
<johan.almbladh@anyfinetworks.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Feb 22, 2023 at 5:12 PM Jiaxun Yang <jiaxun.yang@flygoat.com> =
wrote:
>>=20
>> For DADDI errata we just workaround by disable immediate operation
>> for BPF_ADD / BPF_SUB to avoid generation of DADDIU.
>=20
> Good, this is an elegant solution to trigger fallback to the
> register-only operation. Does the DADDI errata only affect the DADDIU,
> not DADDI?

I didn=E2=80=99t see any place emitting DADDI.

>=20
>>=20
>> All other use cases in JIT won't cause overflow thus they are all =
safe.
>=20
> There are quite a few other places where DADDIU is emitted. How do you
> know those are safe? I am interested in your reasoning here, as I
> don't know what would be safe and not.

Yes I analysed all other place, most of them are just calculating memory
address offsets and they should never overflow. Other two is doing =
addition
to zero to load immediate, which should be still fine.

>=20
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> arch/mips/Kconfig            | 1 -
>> arch/mips/net/bpf_jit_comp.c | 8 ++++++++
>> 2 files changed, 8 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 37072e15b263..df0910e3895c 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -64,7 +64,6 @@ config MIPS
>>        select HAVE_DMA_CONTIGUOUS
>>        select HAVE_DYNAMIC_FTRACE
>>        select HAVE_EBPF_JIT if !CPU_MICROMIPS && \
>> -                               !CPU_DADDI_WORKAROUNDS && \
>>                                !CPU_R4000_WORKAROUNDS && \
>>                                !CPU_R4400_WORKAROUNDS
>>        select HAVE_EXIT_THREAD
>> diff --git a/arch/mips/net/bpf_jit_comp.c =
b/arch/mips/net/bpf_jit_comp.c
>> index b17130d510d4..7110a6687f7a 100644
>> --- a/arch/mips/net/bpf_jit_comp.c
>> +++ b/arch/mips/net/bpf_jit_comp.c
>> @@ -218,9 +218,17 @@ bool valid_alu_i(u8 op, s32 imm)
>>                /* All legal eBPF values are valid */
>>                return true;
>>        case BPF_ADD:
>> +#ifdef CONFIG_64BIT
>=20
> DADDI/DADDIU are only available on 64-bit CPUs, so the errata would
> only be applicable to that. No need for the CONFIG_64BIT conditional.

It=E2=80=99s possible to compile a 32bit kernel for R4000 with =
CONFIG_CPU_DADDI_WORKAROUNDS
enabled.

Thanks
- Jiaxun



