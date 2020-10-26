Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA05299361
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 18:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786860AbgJZQ7A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 12:59:00 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:52885 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1786532AbgJZQvH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Oct 2020 12:51:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 426435803A5;
        Mon, 26 Oct 2020 09:54:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 26 Oct 2020 09:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=kSlmCz4sMFUpsf1HbCzP26yHEmE
        YsedB9bo55NEitI0=; b=N4fIzdPOUD1FSZrnwa2E7VEULe6OJqrA2CsQZlPvzjn
        A4K4V8+EJas1kemxLgNUuhsVKO0VEtLEQHUwL0qNs9wjnkW18+qh9UPQzw+DcKo8
        rYniR/ZEdcoE5geH4YpVShEPL0jnKr4U9YNmZgduQ2laP7uftOMUHNUypMzpqiYL
        zsGqBH8gZR6iIJ9p3Auas3F1spAE58zuLCGS3ghT54lKR+L1OJqDcofB7ZHQ0A1k
        N0SHC6wpJvnC1xofdLgwGAjTCHyO+8pPqwYfT8SPTaVGY3OqmKA/XQKRSaTzg6HN
        umdfBxJwIaQld1u/QhCxRIWhgWaRu+g9VD43Re0c9Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kSlmCz
        4sMFUpsf1HbCzP26yHEmEYsedB9bo55NEitI0=; b=YuQfMmAWddZ6lzY9qWi8De
        EevwqyqTBdJRixuGyQIT6/ZmQFtn9T4cRS7b7P+UeP+zQ/mDkA3y0ORseuhX/i1b
        MuUulsY7k7lSpnVuD7fljwxY9AEpjYGoLgay7pe8T12QH8E3sRoVLcfcGHlmIjog
        6JVamt9TXagKIBNFIJr620UlxSLgoaCqv3jWQoDC2VrOVpX3wOmLtot4HGPCo7v+
        REgLdwBAMbl/4sAXoDvJ5yv8EbevdsT7K3CU5/H15r0iC+Zof5ikWozdr3c228uP
        wzogu2ZY1Q2Fd+/s//ek2xKslyKmTgNG02Xvz/viuOD9RG6p9RlP6hYO71AC5shg
        ==
X-ME-Sender: <xms:EdWWX5VaK4tBn26X7NRJAKNR621-QVwQ6-3Jj6tLOaxVMKa3NWS2oA>
    <xme:EdWWX5mLKTTvbV7HVXTcnZ_mJwqu0kbBRieTjN6T1UlmI2--M-3PXEE_hDSCXDfB5
    H-HU4goxbfazN2Q28I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeejgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghhohcu
    tehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrfgrth
    htvghrnhepffeukeekudejfefhjeevgeejgffhkefhffetleduvddufeekteelkeekhfef
    udejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvkedruddtjedrvd
    eguddrudejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:EdWWX1Y-iN_dPhavTsiWDhW8O14gI07LeLWCiMZcd-nvUA0pTi8Lag>
    <xmx:EdWWX8U6L-Vgl4RDX8wGC_x1DdmA6O2Zm44U4ZRWolHfVPh-Q0qqJA>
    <xmx:EdWWXznIyENZ5PuS1xp4fHcM5gl2Kp9-xEqU1FVGQLgiwOuLn0oFbg>
    <xmx:EtWWX48Duu-mXEqntjuYz12lM5eQhpxwIb5Ar9N9tnpiIz_u6v0_NA>
Received: from cisco (unknown [128.107.241.174])
        by mail.messagingengine.com (Postfix) with ESMTPA id 555F5306467E;
        Mon, 26 Oct 2020 09:54:21 -0400 (EDT)
Date:   Mon, 26 Oct 2020 07:54:18 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
Message-ID: <20201026135418.GN1884107@cisco>
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 26, 2020 at 10:55:04AM +0100, Michael Kerrisk (man-pages) wrote:
> Hi all (and especially Tycho and Sargun),
> 
> Following review comments on the first draft (thanks to Jann, Kees,
> Christian and Tycho), I've made a lot of changes to this page.
> I've also added a few FIXMEs relating to outstanding API issues.
> I'd like a second pass review of the page before I release it.
> But also, this mail serves as a way of noting the outstanding API
> issues.
> 
> Tycho: I still have an outstanding question for you at [2].
> [2] https://lore.kernel.org/linux-man/8f20d586-9609-ef83-c85a-272e37e684d8@gmail.com/

I don't have that thread in my inbox any more, but I can reply here:
no, I don't know any users of this info, but I also don't anticipate
knowing how people will all use this feature :)

Tycho
