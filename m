Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A3A4595A5
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 20:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbhKVThT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 14:37:19 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:34747 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239773AbhKVThS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 14:37:18 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CE34B3200BD2;
        Mon, 22 Nov 2021 14:34:10 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute3.internal (MEProxy); Mon, 22 Nov 2021 14:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=M0LBZhwrKJSvJLT+hpyoAQDW6qi3
        y8IQpjggqXGVcmU=; b=0phJ5rLAz3TA56jugxQ6Wq1QOikGl49e95n1zvAx34dc
        23IfutiegzNWNP8z7lgId05f128IJM1v72B/OLh5pn1GtiMS0m2CsvezJwVC+QFY
        BNFH/Kn7JlMc6Hc55pGsug6pmXqIeUmO4uTWnTM8VrgFNIHXjZrDkB9JEILA9z1B
        wDqaRJRB/VBvEm2A/oY2Bn5elO8ON4kMv/DLkuxaP36vBZH2CmQ+C1MKadWaA/HW
        JGLGGqmw8zWWQmcvpaL6WJEXrsElw0fmrttpDEPCA/bc7sYEiDe/CBJ97RmiIvdU
        4dWymTJ+xVHJViTapsf1VCeIffpVz0QEtlUnbqOxlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=M0LBZh
        wrKJSvJLT+hpyoAQDW6qi3y8IQpjggqXGVcmU=; b=U08Z3Z49ZrSjCxXqKLCxC3
        KS69y1Fk7E5WWdfgOaVAvQeFLH9gZrDReApaQXZtz8cyi/A3UXI2O7+B/aEU7zuU
        MiFgPHKGrOQLouRmgVssVDgr4Arvombpor0a79LQMh9Vb1K48HHADXpFpcIrdAi2
        szTmGwbNESmnOYVj9FlUMYXZCbvj6QDBbMr+zWVlcj0na6d498gAYDj7wyCzh+GM
        OCFZ+2vH3x134+Jto4Z8qRtIxy/TiOM6sxsF2Pv5Cnaf+HS9l6CrKQ7uSXEEL+xl
        6Cid91VygL/d06n8+97cBC2SkzK/kkVAPW0g0m57BEyezMKHGlxLYk0NGtQDOJhg
        ==
X-ME-Sender: <xms:svCbYU8kKBASklPpHfX_8MadM53-AL5gZ4geT0Ws1iaGcycLigW1PQ>
    <xme:svCbYcuLgDQPkoMzXwPu6Dduj63W_xSkd5p7nf15PKsCRWcUmyxfw9xzF6YGfAW9H
    TLNyKDUDF0OLPIirQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeggdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdffrghv
    vgcuvfhutghkvghrfdcuoegurghvvgesughtuhgtkhgvrhdrtghordhukheqnecuggftrf
    grthhtvghrnhepkeevveejueehuefhtdfgveeljeevvdegfedvhffgffefiedtvedtlefh
    jedtudfgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegurghvvgesughtuhgtkhgvrhdrtgho
    rdhukh
X-ME-Proxy: <xmx:svCbYaA_2LhiP4GMl8rcsbKIpz56Ke4n0hvK3vKYS-puEcY5iapHfw>
    <xmx:svCbYUdDoKnAukd2EsQ80DAGpp6jQ1aIyLZUDRmepdtk5sUgfDbDxw>
    <xmx:svCbYZMzZgmXnRXeB7Z5bQDXHTsMqoMQ1Nmm_HBl2abShbNqbd0lSw>
    <xmx:svCbYceeIMBToakHVsgRdAHVRp-XOMe_9LeZgHxsXyDYR_HXWVq74w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 087782180078; Mon, 22 Nov 2021 14:34:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <d1ab737c-5e00-4781-90d4-495400d90b0f@www.fastmail.com>
In-Reply-To: <87ee78vw76.fsf@meer.lwn.net>
References: <cover.1637601045.git.dave@dtucker.co.uk>
 <5da383bc01c66e6c1342cdb2b3dc53196214e003.1637601045.git.dave@dtucker.co.uk>
 <87ee78vw76.fsf@meer.lwn.net>
Date:   Mon, 22 Nov 2021 19:33:23 +0000
From:   "Dave Tucker" <dave@dtucker.co.uk>
To:     "Jonathan Corbet" <corbet@lwn.net>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 22 Nov 2021, at 19:15, Jonathan Corbet wrote:
> Dave Tucker <dave@dtucker.co.uk> writes:
>
> When you add a new BPF file, you need to add it to the corresponding
> index.rst file as well.  Otherwise it won't be part of the docs build
> and will, instead, generate the warning you surely saw when you tested
> the build...:)

I did test the build and I don't think I introduced any new warnings :)

This file is included in the docs build via the glob pattern that I added to 
the toctree in Documentation/bpf/maps.rst, which was recently applied to
bpf-next [1].

- Dave

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=5931d9a3d0529dc803c792a10e52f0de1d0b9991
