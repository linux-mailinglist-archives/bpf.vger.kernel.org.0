Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410A82AFC0C
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 02:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgKLBcC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 20:32:02 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58531 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbgKKWo4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Nov 2020 17:44:56 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0C255953;
        Wed, 11 Nov 2020 17:44:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 11 Nov 2020 17:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:from:to:cc
        :subject:date:message-id:in-reply-to; s=fm2; bh=UJhI0Jwd4ebO9DiK
        T8gR7UB5jh1vkIQ9vDaGY4SHBqw=; b=vQitJ22qA12PE2xaTRHybhEyAvUo9B6F
        A4HP+0Xsmrof300UnTjpUMhJXLhXFvouE/g7hBJU+dqlnbcQ32CJcOtXNEu3dscL
        T0A9e1j6RPn5utRVTMF0sGVXhtS/GbBgoK1W8YQuuZA3X0cJ5xf+F+x+q9oN7W0u
        MLFRjvruCsR1AN5lo+6BRFNrPbsMFidLGD36yy/dtkMPD/n6YhO4wugy3mEoblkN
        yt3tkeJDzxuv/O5R8JHglCmCEfCsSMemrtMEEqS5EPhNd80DR5B2htNcFySva1rC
        PUi/OnT3KPbnZeyN+27SekCIdDE0+nvsV2nDwvQc4fDfjqbtFMWMCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=UJhI0Jwd4ebO9DiKT8gR7UB5jh1vkIQ9vDaGY4SHBqw=; b=Q6UYuzcx
        J8D4Gqu1SCh5maOmvhUf2MyhXF0FA1YdehqC0BK68EJAxClzGpBvMeuBNXqWn/wA
        3f+OEEkateqqBc6zSuTxOsusj5miAD+5/NIs5qA+p6hApRppyXCvliANKmfRw27f
        k+DSXh9CqgrD9dvXotmz+J849wBx7937+tM8N08FIVVjxIZmzfCbtlFbTb8Ew8MG
        Bwa+CT7vH0F5CxbIHMceRTg7MsTDJBzQHXnFj/QXiVvNzz+XzDekjse11+LSZhYu
        2McQQuWETzA3nHo6lmGCE0jAXJolI7kLoXm4dlLZtK/4oylVe22enyr6wHxtUUhR
        cxK266REE72awA==
X-ME-Sender: <xms:ZWmsX-uZDxNuDA56SPRrwf6sYv64VGf6SAajjov6t4SKhCgfhafPtA>
    <xme:ZWmsXzfHhxgj_TrJghsCA75-bIBFZSiLtv1Ar3otQVpfrYcC0fxwvNbfGC2bcN5S5
    rq4hI2A2MvM3xIwWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvuddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpegggfgthffvufffkfgjsehtqhertddttdej
    necuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepgeejffduieffgeduveeuvdffieehgfdtueduieelfedvgeeu
    gfeludejteelueelnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrd
    horhhgnecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:ZWmsX5yU374o0QGalsfHLNXK25YXe0OJKK2P8KU3r0ZDMkIq_WWsSg>
    <xmx:ZWmsX5PaabFWwcYfxESMwQhu9rQ1fk8PSgMggGXpvdmURcjmGLYcbg>
    <xmx:ZWmsX-_mOdqp2gq_ilTrCeaZiCIIOn91h1nKPT1C3TpQtgczBhAB-Q>
    <xmx:ZWmsX-xPE4CrMbPf8sM_GWLQRClgkr2XnYL8zfe7jqvvopn0Cj4fvw>
Received: from localhost (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 493FC3280068;
        Wed, 11 Nov 2020 17:44:52 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Daniel Borkmann" <daniel@iogearbox.net>,
        "kernel test robot" <oliver.sang@intel.com>
Cc:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ast@kernel.org>, <songliubraving@fb.com>, <kernel-team@fb.com>,
        "0day robot" <lkp@intel.com>, <lkp@lists.01.org>
Subject: Re: [selftest/bpf] b83590ee1a: BUG:KASAN:slab-out-of-bounds_in_l
Date:   Wed, 11 Nov 2020 14:43:31 -0800
Message-Id: <C70SQCX55VG2.195MNJP5XSCJ9@maharaja>
In-Reply-To: <8f040468-f45f-d272-af37-b7e634aeefa9@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On Mon Nov 9, 2020 at 8:54 AM PST, Daniel Borkmann wrote:
> Hi Daniel,
>
> On 11/9/20 3:54 PM, kernel test robot wrote:
> > Greeting,
> >=20
> > FYI, we noticed the following commit (built with gcc-9):
> >=20
> > commit: b83590ee1add052518603bae607b0524632b7793 ("[PATCH bpf v3 2/2] s=
elftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes after NUL=
")
> > url: https://github.com/0day-ci/linux/commits/Daniel-Xu/Fix-bpf_probe_r=
ead_user_str-overcopying/20201106-033210
> > base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf.git master
>
> I've tossed them from the tree for now as it looks like these are adding
> regressions
> for regular strncpy_from_user() calls, please take a look.
>
> Thanks!

Sorry about the KASAN issue.

I spent a day reproing. The kasan warnings seem a bit misleading but I
think I have a fix. I'll put a v5 shortly. I'll see if any of the bots
find errors on it.

Thanks,
Daniel
