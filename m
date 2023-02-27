Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0636A4666
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjB0Prc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjB0Prb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:47:31 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE49E078;
        Mon, 27 Feb 2023 07:47:30 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E0BB85C00D3;
        Mon, 27 Feb 2023 10:47:27 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute2.internal (MEProxy); Mon, 27 Feb 2023 10:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677512847; x=
        1677599247; bh=JU1LAyxBo+olX19UudHZaal6iEsZpC8v/IZIn+tLd90=; b=u
        0gFNR+SHetNdTLCeA2537k9ySTxVy2ep0IiOuOF+vxKGh9FT+gU5G8cIDqXkntbY
        GGBfVTf2bkGJ/plbAI7dsvjVSrlxlRkemNKfyksPqvoYoaqYPcPxI/FUtYXrbE/8
        W3wRDv2ALHsxX2fT032eGwMl3X6sP2ohRRiC6iJCvhCEyoaz3SbFnBkqzQplhSMg
        CWi1O6YbLmna/fltMnVOE+5stLKx6b8T+kJRbBuGpS8MFHHMCYykUjpYPa4JcFZ/
        b+TC+bYLroxpurpHr8Fg1qBkOKIjdvyBgIKBI7gVpf9x4I7MoBfbus2VMexFUk0k
        ixgKIVMTOLeg32RzDmp3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677512847; x=
        1677599247; bh=JU1LAyxBo+olX19UudHZaal6iEsZpC8v/IZIn+tLd90=; b=K
        wp1Do38lHB22Z5U2WXZmODC/G8LmM8vuCj2KPqBCI7wz7fr/UOQ0ZxieV1C5n+7q
        rQRRO72Y4pO4hVG8M5HYArQVp5rAN9KGzIwUVLSDmJAB9HyuOueY61VY7WNikYAZ
        xTp+x0PYtokRNwicVoAl5Jf4Zj5nk42KTAAC+HBcC6/itLMq0xrGGED9shbEI240
        hZRf+9G82hfHSwZv0rBuLdMVDgbqdQGnQujPbZkWEruYj1UiLFhIRKa+jd11MUN1
        biZBRRikdP+bD7qvcZJJKNHlCK4uZDZshvE1gLIVrbStSYZmgSpjY8GRGOJ2bRJd
        wT7k/oBC+oOCm5D7xRATw==
X-ME-Sender: <xms:j9D8Y5YsH6gG66oigmXwuQSmPEhtkjb4wW2Q0nnLl16xHkYmbqNSYw>
    <xme:j9D8Ywbckg1q6jUR8DbiU-CnY5cUzNhcaBAtR9xaDgpTqPj9EznnthWIS7DLsinaQ
    QmTjFFffvnLqdL_18c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:j9D8Y79qHbp9n8VTVIUyRn-xEy-9yVbcR_DJfBoVNkEAeKNIOr88bw>
    <xmx:j9D8Y3p5Zfvol0XXonhxkiJuopSXkzIUeZvczC4qIpL4xLXp9ywBjA>
    <xmx:j9D8Y0oZFDrGgBmaRnJa_TIZJYVJrc2m09fw8EWU2bbOQEPMb6bu2Q>
    <xmx:j9D8Y8JzI306BIdJSyZEQC5b1ycDX41EYa0r1g5_HmqDkpYW63D2JQ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0AAA936A0073; Mon, 27 Feb 2023 10:47:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <c36effcb-5a5f-49b0-8bbe-cc46addf2959@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2302271515100.63909@angie.orcam.me.uk>
References: <20230222161222.11879-1-jiaxun.yang@flygoat.com>
 <20230222161222.11879-3-jiaxun.yang@flygoat.com>
 <CAM1=_QTDkYJANgxYwkgPZB+hUX6Rr_Pvnn7cFwSJFHQtLrpQMA@mail.gmail.com>
 <70C80F6D-A727-48FD-A767-A2CA54AA7C1E@flygoat.com>
 <CAM1=_QS_ewcFdrZ1ypV15wOkK_SKkb0UUe5_Ozi_CDBdxF5JmA@mail.gmail.com>
 <alpine.DEB.2.21.2302271515100.63909@angie.orcam.me.uk>
Date:   Mon, 27 Feb 2023 15:47:05 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "Johan Almbladh" <johan.almbladh@anyfinetworks.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        bpf@vger.kernel.org, "Alexei Starovoitov" <ast@kernel.org>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>
Subject: Re: [PATCH 2/2] MIPS: ebpf jit: Implement R4000 workarounds
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



=E5=9C=A82023=E5=B9=B42=E6=9C=8827=E6=97=A5=E4=BA=8C=E6=9C=88 =E4=B8=8B=E5=
=8D=883:18=EF=BC=8CMaciej W. Rozycki=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, 27 Feb 2023, Johan Almbladh wrote:
>
>> > > R4000 is a 64-bit CPU, so the 32-bit JIT implementation will not =
be
>> > > used. From the Makefile:
>> > >
>> > > ifeq ($(CONFIG_32BIT),y)
>> > >        obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp32.o
>> > > else
>> > >        obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp64.o
>> > > endif
>> >
>> > It=E2=80=99s common practice to run 32-bit kernel on R4000 based sy=
stems to save some memory :-)
>>=20
>> Ok, I understand.
>
>  Likewise:
>
> 	select CPU_R4000_WORKAROUNDS if 64BIT
> 	select CPU_R4400_WORKAROUNDS if 64BIT
>
> This only applies to 64-bit operations, which are not used in 32-bit c=
ode=20
> (one reason why these early silicon revisions were originally used wit=
h=20
> 32-bit software only).

Thanks for the info.
Will drop 32bit part from both patch.

>
>   Maciej

--=20
- Jiaxun
