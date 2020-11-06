Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E122A9CC2
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 19:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgKFSzU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Nov 2020 13:55:20 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:42591 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbgKFSzT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Nov 2020 13:55:19 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A0DA3D1A;
        Fri,  6 Nov 2020 13:55:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 06 Nov 2020 13:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:cc:subject
        :from:to:date:message-id:in-reply-to; s=fm1; bh=AFtcQY/U4BWjlT6D
        ZL2HRQBj+myJ297DJ2kQlynYkUM=; b=WrBU30BUNg8l7TMurpazyRUvVhL0sN5Y
        Po4X656j/EM6VKxewq27xz1Fqojh/bLURU2w5Y+qevOPlxtrRo5vNV6mjy6y8jm8
        U5ss+MysMC+qB/cbmxEwUrJvC+lPwyoqHym+6y16eJLJqEcaPKPkk9NH5m7iGg2h
        cB5knlhIl7CpgRhfm0DFDDDRATc5cv5HZPnj4iGT4EeJuVB2bIkUSYkLXlbGkt1d
        qY7tt9r7AHsikk2zMhLtfRaZIOWKv3l714ibp1+/G+8vYBuBx6r06oBHY5lhxSP/
        /H0yaX9tcvBC2lS7Bw4SWwWGbwkMaQAFrlLhUBKtRCkk8NtfY43pJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=AFtcQY/U4BWjlT6DZL2HRQBj+myJ297DJ2kQlynYkUM=; b=E2XhQezn
        wG4bM0eRii9XW6JWWS0LZ641B6eQQ0fmOYXNg3FzaWPnnzTLMpOY/1nBuA/q5FYn
        IfLxssdGVekl5dU7T46pbD8PVDO3v2Y4X8iJhRI0hGBYIW4ExdiY1YVhufEOuxB8
        1rEN41kvw4cZA7OoQ0Jo1o7DkjNJ4sCwYr7oOCavp2r8CyFM9ujY8m3BFtDvHwDD
        oLjp4a9ahPGfvHQyrgtKPapg6W9g/KLrU3y7tf/E8+TDdoC4ZAJ0Hl3Vxbh8giRz
        RxzmaLdd33RTgLnd1FXQhZquT/KPuCT64hUCjLadDjFCTbzs0MEL52+Xd4VkBx5y
        jGdPD7UXINB6LA==
X-ME-Sender: <xms:FJylX-izGoDGjqu55S6L-7Vb6K2hP8m-tRXEilMtsVI43-zWHNEmtQ>
    <xme:FJylX_Al19qjP4Ord5Zu1Ji1KuS4oyG3BVYA1AZUMNjcJh5TiLBBcO4arrUjz-aJD
    6quy5d4p2kkq8WnIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhepggfgtgfuhffvfffkjgesthhqredttddt
    jeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpeeijeeuffekvefghfevffeugeegudffueekhfehffdtleeg
    gfdtfeehheeuudefieenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlh
    drohhrghenucfkphepieelrddukedurddutdehrdeigeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:FJylX2EfUYoX3fWtVU0P6hqNgmHGLEunzsix4U9kxOub0HgAjwDLRA>
    <xmx:FJylX3TuChe2wac7EF8KZY9n9vQkjNjFcL3QrzZje36UMGqj9wKA8g>
    <xmx:FJylX7yDF0mvhyZpE6ci6UiKlb3_9B2f7-hv6XAmDPQSXX4NRrQa2w>
    <xmx:FZylX2pVzc26ae-Yn_pSqsIIXP8Bq3s1PEpi2F7vNn3ZxJNb5ZPQHQ>
Received: from localhost (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id DE4D932801D7;
        Fri,  6 Nov 2020 13:55:15 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "bpf" <bpf@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Kernel Team" <kernel-team@fb.com>, "0day robot" <lkp@intel.com>,
        <lkp@lists.01.org>
Subject: Re: [lib/strncpy_from_user.c] 00a4ef91e8:
 BUG:KASAN:slab-out-of-bounds_in_s
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
        "kernel test robot" <oliver.sang@intel.com>
Date:   Fri, 06 Nov 2020 10:54:10 -0800
Message-Id: <C6WEQ17CF8QV.HSY7LMEWDFBX@maharaja>
In-Reply-To: <CAADnVQLcwB8ebbpuqnjvqebGp4293zd4s4nAawJ=EaU-6+wXpA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu Nov 5, 2020 at 8:32 PM PST, Alexei Starovoitov wrote:
> Daniel,
>
> the kasan complains about the previous version of your patch,
> but your v4 version looks equivalent.
> Could you try to repro this issue?
> The code looks correct, but kasan complain is concerning.
>
> On Thu, Nov 5, 2020 at 5:56 PM kernel test robot <oliver.sang@intel.com>
> wrote:
> >
> > Greeting,
> >
> > FYI, we noticed the following commit (built with clang-12):
> >
> > commit: 00a4ef91e8f5af6edceb9bd4bceed2305f038796 ("[PATCH bpf-next] lib=
/strncpy_from_user.c: Don't overcopy bytes after NUL terminator")
> > url: https://github.com/0day-ci/linux/commits/Daniel-Xu/lib-strncpy_fro=
m_user-c-Don-t-overcopy-bytes-after-NUL-terminator/20201104-103306
> > base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git mas=
ter

[...]

I'll take a look, thanks.

Seems like the original email went into my spam. I'll try to fix my spam
filter.
