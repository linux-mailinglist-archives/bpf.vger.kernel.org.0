Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2F32C7D94
	for <lists+bpf@lfdr.de>; Mon, 30 Nov 2020 05:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgK3EhL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Nov 2020 23:37:11 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58675 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbgK3EhL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 29 Nov 2020 23:37:11 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D2845C008D;
        Sun, 29 Nov 2020 23:36:05 -0500 (EST)
Received: from imap3 ([10.202.2.53])
  by compute1.internal (MEProxy); Sun, 29 Nov 2020 23:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ongy.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=D5t+xFEh7qtr8Or4gDAM5WuzxrhLZvm
        F2HUaPD6CPlc=; b=oOxB5gI6gQ1iRKra3k1g0NoJ8YT1nUfcEF+Kpms8nFsoMKs
        6BezbPK0zz8W5Q0cN08K3xOxHG0faX0NVoiN+sfH8i/TBU5yqS8WOZbosGiq1/Yl
        6uCtDMvPHiQ/ps7KtMDgx9FTdMszOJqLjqO/7vbRPY8m7kHykMcNMJbr93GYZ/C7
        Gl/LKBxVVtJuMMWWbHbx4wJ328ErGaLcsULpOPSZQ7eXSqATQjPhI6XVHKUhsAIr
        hOr9B2KZPldBYvOAPx6Je/s8WTJSLz3gxbnYOlqMSBXptEhqvA2ZG5FlhIem5DQL
        oEnF7TFqUB3ykIhEA58c4PBPa5fJ4qMAEA6rm4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=D5t+xF
        Eh7qtr8Or4gDAM5WuzxrhLZvmF2HUaPD6CPlc=; b=Bu0gqXMpG03S2cR+BKI7Tz
        9gpaMJv6HPlj/5HXRma2sZUSKbaQRH+XPu0kOnaQbeHr1qf4yD3noDkgnHWMd3fy
        BF2uLVJVU7ytdIcAK5JAVpcbmSLCwahEgMjm+6BCm0j/CZOTE5FLCkcMXVEl1BXI
        a+LzIe1CBQuqcEIW4HNB1S7WaDyGDIs4D1CdjK/emv/Ie7QF4jkmhTSdajgWPyky
        1gaYOVKrcpcf+5hMx+1p3G/jS7+J34ztm3QAsro5shtgoEbMqjKYDDCKhtEXlWDT
        xouDo39T9+Naha+I0xiz55THYA0Sa/zPBKBZFH3Yj7WQ8coUgHDH3+e85KusKGAA
        ==
X-ME-Sender: <xms:tHbEX2L02dIbnvw275Gro1VfphAAJEpZtSRiNe-cAN5trYyLP_wmpw>
    <xme:tHbEX-I1qyaEAuX22EJ46RAoyYcI1xqEObQ1IgxlJKTyTBD9vMg8G7QCYtWecKpDz
    nyNGojo_xmPxJ980us>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehledgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdforghr
    khhushcuqfhnghihvghrthhhfdcuoegsphhfsehonhhghidrnhgvtheqnecuggftrfgrth
    htvghrnhepgedvfeehheeuueetjeeutdffuddvffeiteehjeehieevheejleetkefgteev
    ledunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hpfhesohhnghihrdhnvght
X-ME-Proxy: <xmx:tHbEX2tVB-njjkJiCgwpDTLBd8yYfum4xOdYHG-Qqgb_x1356b9fFg>
    <xmx:tHbEX7bsZJzP5a-T-7hQotSCntuW6bYgabKC-a5VDVWPXqwoeYOONw>
    <xmx:tHbEX9YRsItG4lAPCaClG6WeSsCF0QS89-CUosHgqpTFW9uC2U-JlA>
    <xmx:tXbEX_2C9-kV3a2pW48YxnIGhth8hq35nNl86iTKDZF7xSn_eklndg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BE2164E05C7; Sun, 29 Nov 2020 23:36:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <3bb48133-2853-41fd-9bc4-8ea7c6d5bd5b@www.fastmail.com>
In-Reply-To: <CAADnVQ+2DiSH42cSjQ2fNEEc217c6C+SPEqSEzBJb22aZdm3kA@mail.gmail.com>
References: <eea9673f-5ee4-4adc-bc64-fcc88f715cc8@www.fastmail.com>
 <CAADnVQ+2DiSH42cSjQ2fNEEc217c6C+SPEqSEzBJb22aZdm3kA@mail.gmail.com>
Date:   Mon, 30 Nov 2020 05:33:27 +0100
From:   "Markus Ongyerth" <bpf@ongy.net>
To:     "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: HELP: bpf_probe_user_write for registers
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 29, 2020, at 23:22, Alexei Starovoitov wrote:
> On Sun, Nov 29, 2020 at 10:38 AM Markus Ongyerth <bpf@ongy.net> wrote:
> >
> > Hi,
> >
> > I've been looking into introspecting and possibly convincing an application to behave slightly different with bpf measures.
> >
> > I found `bpf_probe_user_write` but as far as I can tell, that only works for memory areas.
> > Is there an alternative that can be used on registers as well?
> 
> fyi bpf_probe_write_user() warns in dmesg.
I've seen the note about that. I don't really mind, since it's not spammy but once when the code is loaded.
> That was done on purpose to avoid usage of this helper in production code.
> A new helper can be added to adjust user regs, but it will have similar warning.
> It's better to discuss the use case first.
> Do you envision user regs to be changed after uprobe in an arbitrary location
> or in some fixed place and only particular regs?
My current usecase needs to be able to set PT_REGS_PARM2 and PT_REG_PARM4 I think in specific function entry uprobes to modify an argument usually passed in a register by ABI.
And that's what I'd use for playing around with things in general I think. Arbitrary registers at arbitrary points sounds like fund but also way more dangerous.
