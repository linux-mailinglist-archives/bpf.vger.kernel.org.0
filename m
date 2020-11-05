Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3992A7560
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 03:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgKECZB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 21:25:01 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53059 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727986AbgKECZB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 21:25:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FDF05C0109;
        Wed,  4 Nov 2020 21:25:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 04 Nov 2020 21:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:cc:subject
        :from:to:date:message-id:in-reply-to; s=fm1; bh=6C+S5ismEnJ8FFZV
        0Bvx1CEwW13OCruBU+1cltV7kqk=; b=ZM6mzI9AoFRe3b/0TTjids5+5MrZYVLG
        M6qpZirzLpEuNbH4zJoqRuKVLYmZDddkqR3m2IJecT6zFXZDNvsvcyP5RDpoTzDt
        elqEQRWJCmvZDW1p9vokhnwHljvKFNqQHs9MjuRPWiBNDqRBsbfbvWFUtv3Yzmmz
        5QPcxV4jZkjkyvKI+qvoMgpLUmvJr0Syx9DTG2uj0yyGJ0ayJdBgp499u9JT/8TQ
        kMVsPtQvCBdAkAfXxJNyptbM8RAuHHtfbgyIPQsHx1LHKeBeOwRboHUm4W62ycPQ
        ahCqe5iqAjqB7b6uDUeaHphc1KcLlY/I/QRpi+8IWx+0ayLb/X0zHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=6C+S5ismEnJ8FFZV0Bvx1CEwW13OCruBU+1cltV7kqk=; b=cBR9FtTc
        Yazuyf0thz9G9EQ06GIRnibOoBnOijV+EbCxVvi9Y4yo9FHu1TsvhpA7PjziRvri
        yH41Qz3n5QDXj25txC8S+mTXUs9L98kA6QmpEQRY8EB2N/a55Otj30CMMu53SFAy
        XRELBmxbWA7D/v5w/iR8oGeTymvcGBGjxQ8XO3d0G/zwUA1rixbvPlqOFNhJEqn2
        qsqnPsqiOTx8QUiLBBUSf0uqce82Tz/hQvEZ8W74fn8xuc1Uw4O+h3t7eSAXDFmO
        4sP5d7N9ZEAbEXbYpQFvxeyy/n1qktKB69Pi7FEVfOnDkAXuRV5PqeGgmC3ctFju
        7B6l6myxcLreow==
X-ME-Sender: <xms:e2KjX91K74K6gd134BG_xSA4-fON3XvUyvMx7nP723UdyOiAZ4LoCg>
    <xme:e2KjX0GK165wNWoYuBDJiJr44Fc41S9XlxT7eHXJL6RjQ5FGT6C3mmflYm__aFksI
    BuctxcQnMtye8xRIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpegggfgtuffhvfffkfgjsehtqhertddttdej
    necuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepjeefhfdufeefhfejvdevhfehudeltdeujeevudegvdejvdej
    leejgfegtdejjeevnecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:e2KjX96bSOHpBKoo3vuSSXr4r-CgOTaqWe5lSTxpjMlHcYJkPr1exQ>
    <xmx:e2KjX609f6GBMxZNM0p0CRkZmfhS8OubGlW8gtHz_I7h_CVW7xM7Zg>
    <xmx:e2KjXwF1VjLuL9A4dguSexvbsgggujvgM3GGNvwWNtIgmiyT6k6UoQ>
    <xmx:fGKjX0DSMgRfnFaR99bc0sEmXhqSlYpLwOhQG0hHRo_pUvz9AAa6rA>
Received: from localhost (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F4443064684;
        Wed,  4 Nov 2020 21:24:58 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <kernel-team@fb.com>, <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Daniel Borkmann" <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ast@kernel.org>
Date:   Wed, 04 Nov 2020 18:21:57 -0800
Message-Id: <C6UYZS8KPY7V.23QPWOJX7R50T@maharaja>
In-Reply-To: <7d1a34fa-2475-0958-37fe-ed416249bc4b@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed Nov 4, 2020 at 2:36 PM PST, Daniel Borkmann wrote:
> On 11/4/20 9:18 PM, Daniel Xu wrote:
> > On Wed Nov 4, 2020 at 8:24 AM PST, Daniel Borkmann wrote:
> >> On 11/4/20 3:29 AM, Daniel Xu wrote:
> >>> do_strncpy_from_user() may copy some extra bytes after the NUL
> >>> terminator into the destination buffer. This usually does not matter =
for
> >>> normal string operations. However, when BPF programs key BPF maps wit=
h
> >>> strings, this matters a lot.
> >>>
> >>> A BPF program may read strings from user memory by calling the
> >>> bpf_probe_read_user_str() helper which eventually calls
> >>> do_strncpy_from_user(). The program can then key a map with the
> >>> resulting string. BPF map keys are fixed-width and string-agnostic,
> >>> meaning that map keys are treated as a set of bytes.
> >>>
> >>> The issue is when do_strncpy_from_user() overcopies bytes after the N=
UL
> >>> terminator, it can result in seemingly identical strings occupying
> >>> multiple slots in a BPF map. This behavior is subtle and totally
> >>> unexpected by the user.
> >>>
> >>> This commit uses the proper word-at-a-time APIs to avoid overcopying.
> >>>
> >>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> >>
> >> It looks like this is a regression from the recent refactoring of the
> >> mem probing
> >> util functions?
> >=20
> > I think it was like this from the beginning, at 6ae08ae3dea2 ("bpf: Add
> > probe_read_{user, kernel} and probe_read_{user, kernel}_str helpers").
> > The old bpf_probe_read_str() used the kernel's byte-by-byte copying
> > routine. bpf_probe_read_user_str() started using strncpy_from_user()
> > which has been doing the long-sized strides since ~2012 or earlier.
> >=20
> > I tried to build and test the kernel at that commit but it seems my
> > compiler is too new to build that old code. Bunch of build failures.
> >=20
> > I assume the refactor you're referring to is 8d92db5c04d1 ("bpf: rework
> > the compat kernel probe handling").
>
> Ah I see, it was just reusing 3d7081822f7f ("uaccess: Add non-pagefault
> user-space
> read functions"). Potentially it might be safer choice to just rework
> the
> strncpy_from_user_nofault() to mimic strncpy_from_kernel_nofault() in
> that
> regard?

I'm a little reluctant to do that b/c it would introduce less efficient,
duplicated code. The word-at-a-time API already has the zero_bytemask()
API so it's clear that it was designed to handle this issue -- we're not
really hacking anything here.

I'll send out a V2 with the selftest shortly. Happy to change things
after that.

Thanks,
Daniel
