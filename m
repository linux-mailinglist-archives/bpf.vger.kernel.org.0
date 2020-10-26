Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCB02992B4
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 17:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780313AbgJZQmv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 12:42:51 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:41297 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1780057AbgJZQgH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Oct 2020 12:36:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2244A580146;
        Mon, 26 Oct 2020 10:32:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 26 Oct 2020 10:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=64+TAaOwh1IPJrs0ew/aA4+odj3
        25YN8/5rfD/oYrDM=; b=LT8cpr5Kh6K0Ro6/cKplrnfXH3isKEpTudX+6zrtaMH
        rLT6ENT8D6m5Ls3tAEPHkIGxwjzxn+c6bOsRXMcUR1Zn867zOOI1EG22nItmsh1J
        8t6NamCrambbUlKLR+xYCCHHeIVfz6FBhleOZgrp5FiDxjn+ogGl+3lPVOs4SSqC
        f+uiWMyXYlmuFtaYnTUIOLYITt1twmTNLJZ+jDoobhr0H4jKXL8llE57tYGQltqK
        umeGNV2KvX/WGZ1IBRKhHIQDX7/IyKKARLOV8/AZtmBnkatzOKo/ZZliu0jFhlFH
        ArQH7A7KodlOewJHxRul/sx1zmvT3frTgVE9/iNB5gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=64+TAa
        Owh1IPJrs0ew/aA4+odj325YN8/5rfD/oYrDM=; b=NEUcPj6XHhh3kOzAu3ag/s
        nPNkkMGeXt5W27d2BLHGXr0MkuBotIoRp1sLCzdvw/bjOTkUeVcwV0J1LVyYpaAa
        Rc98WepKd+XaG2XU9w3WumMNLY7FnqmY7J0O2Xx1vKKODqNnDh3VTP/UU2HDRotL
        9Nr8mSDPj5pFccM2hXmj8JDYqANVK9V3ck4o9yPTAzKx3ZCcHTxFgy7qGnpd3BJs
        LRZouGJw9Y642r/7eMLyLcECaAD7MipxSQeqQT5rJIhcopR33yLDXW3BzsiZ6u95
        vPi1pU4En6jkV37PXHo1Rg190XEL0Mr0f4sooFBeK2zBnrTxs0+ePt0vKu/UKuaw
        ==
X-ME-Sender: <xms:9N2WX6PPOt4w9dmLyTrvwF431bcJjjboqsm_d0A8rZOhAeDwE4EzWQ>
    <xme:9N2WX4_20IFlSXcU4GQ8wn_pxGBjObeQ_MG5CKK3i-Hoj6Cs_cFczo5vZo95ZH3pE
    o-j-jBUU_z1D7Zxn-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeejgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghhohcu
    tehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrfgrth
    htvghrnhepffeukeekudejfefhjeevgeejgffhkefhffetleduvddufeekteelkeekhfef
    udejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvkedruddtjedrvd
    eguddrudejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:9N2WXxTNsUh_shhWVhMb0akcOziwH4cOttFK5z3kgrEWKdw11el7iQ>
    <xmx:9N2WX6u1R11wX9PMoWrNC21SQLxb16_y0XwsjRlRkBF-1uE_QHMqcg>
    <xmx:9N2WXyfApyQJzyOKT-d13Wos4LwRv33_wyIAQ9YMAGwCpxZi571hVw>
    <xmx:9d2WX92bTXYLWO2P8bM6B32xPbmcdZJ4_nmk59JpTQc7lEF42DYGrw>
Received: from cisco (unknown [128.107.241.174])
        by mail.messagingengine.com (Postfix) with ESMTPA id 129D53064684;
        Mon, 26 Oct 2020 10:32:15 -0400 (EDT)
Date:   Mon, 26 Oct 2020 08:32:13 -0600
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
Message-ID: <20201026143213.GO1884107@cisco>
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <20201026135418.GN1884107@cisco>
 <CAKgNAkgbvuEJ0rkLrZGgCf0OTC8YH2vxemNic8SsDxjh=Z22uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkgbvuEJ0rkLrZGgCf0OTC8YH2vxemNic8SsDxjh=Z22uw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 26, 2020 at 03:30:29PM +0100, Michael Kerrisk (man-pages) wrote:
> Hi Tycho,
> 
> Thanks for getting back to me.
> 
> On Mon, 26 Oct 2020 at 14:54, Tycho Andersen <tycho@tycho.pizza> wrote:
> >
> > On Mon, Oct 26, 2020 at 10:55:04AM +0100, Michael Kerrisk (man-pages) wrote:
> > > Hi all (and especially Tycho and Sargun),
> > >
> > > Following review comments on the first draft (thanks to Jann, Kees,
> > > Christian and Tycho), I've made a lot of changes to this page.
> > > I've also added a few FIXMEs relating to outstanding API issues.
> > > I'd like a second pass review of the page before I release it.
> > > But also, this mail serves as a way of noting the outstanding API
> > > issues.
> > >
> > > Tycho: I still have an outstanding question for you at [2].
> > > [2] https://lore.kernel.org/linux-man/8f20d586-9609-ef83-c85a-272e37e684d8@gmail.com/
> >
> > I don't have that thread in my inbox any more, but I can reply here:
> > no, I don't know any users of this info, but I also don't anticipate
> > knowing how people will all use this feature :)
> 
> Yes, but my questions were:
> 
> [[
> [1] So, I think maybe I now understand what you intended with setting
> POLLOUT: the notification has been received ("read") and now the
> FD can be used to NOTIFY_SEND ("write") a response. Right?
> 
> [2] If that's correct, I don't have a problem with it. I just wonder:
> is it useful? IOW: are there situations where the process doing the
> NOTIFY_SEND might want to test for POLLOUT because the it doesn't
> know whether a NOTIFY_RECV has occurred?
> ]]
> 
> So, do I understand right in [1]? (The implication from your reply is
> yes, but I want to be sure...)

Yes.

> For [2], my question was not about users, but *use cases*. The
> question I asked myself is: why does the feature exist? Hence my
> question [2] reworded: "when you designed this, did you have in mind
> scenarios here the process doing the NOTIFY_SEND might need to test
> for POLLOUT because it doesn't know whether a NOTIFY_RECV has
> occurred?"

I did not.

Tycho
