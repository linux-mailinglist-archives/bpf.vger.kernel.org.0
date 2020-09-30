Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7932927EC04
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 17:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgI3PNS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 11:13:18 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:57611 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbgI3PLy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 11:11:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id AE4DB95D;
        Wed, 30 Sep 2020 11:11:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 30 Sep 2020 11:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=E
        L5sx8RuoZj7gSNiP+bO7IO5IrlnZDRHjiqW2UexN58=; b=lgrCTRBQtI384ttJB
        EaGaSORN9CO37k0pE2HgpZNdxHdwjNi10UapsjMN0DY00HuchKB2uzbu3+pfJIxO
        +2GPHGN/phwh4AejNbUT4+nr3Ppm9izphP48wYOT5NR+W1v8/ryHsg0lQ7fjAQ7D
        zKFOt2mbDTMex2+4A44biJNLvWeH2tdzs0NU3XiTJlJcy8FHOwXJSmBvuuTZJmeV
        zASWiV3TSuWEGG3g1WcFb/cb29JHeTZ30OoXisdY2T7UnECSu88TbeneEg51hk0F
        ZQkzCzegvnvepyhSBlOaM7nSZAkgzNO3JdCX+OddV7H/+3oouE78wE9I7YQ/25lw
        BRKHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=EL5sx8RuoZj7gSNiP+bO7IO5IrlnZDRHjiqW2UexN
        58=; b=AzJgziXqSAm35rHR7EaqtWZiZ2nD7s1lJLEeZmIZw6dDL6RdI7abMEAYD
        WP5u96RaWrf2gC0sCP2JJR66/npDkKI0+YJnuCnCVJDhTeRc42Y2VcZmwn+vtziY
        4YHYqMbpEjgGERlXjsuqb7aVBraJEh4AmLKQDXLqbvChffZczBOnm2HqopJO7J9u
        ySa3Dsxe71+EPquOYR0x7UqRyPDRYwr5nkE2ZvrfrFpeh+sBhoIfmRyk8IwHQVW5
        ioNTEp4G75dfh3M7948pMtsxDFm8GN+ypDr0cO+O3TMdDGkSu48VJ2BxQiWsYqIO
        +gYtNhT003hOMlIaJfgAp4RFgcz2Q==
X-ME-Sender: <xms:JqB0X4e6PWppnCqXxNxF3mOm5ttPwy8W2GT79Ii_CxvLLNkP-KMPaQ>
    <xme:JqB0X6PRRwAux96_7JVGDN7gWPdnLYIJN7dGRkn-jY7xvFKFBlQyKhzIMu7C6OwOT
    qlnwB_EY0kMcN8zCQM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedvgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpefhuedvvdelieevgeegjeeukeeuleejtdejfeetfeeujeefvdeltdethffh
    ueekffenucfkphepuddvkedruddtjedrvdeguddrudekgeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:JqB0X5gMkTgI8miHeoANz2NCls4Ok4OOBXylnLGhmQq3XSx-eg_DHQ>
    <xmx:JqB0X99YFhiYDJmRAeIaKwKmlAoQMVtCpXoRRQpiyKvdTy78EMk-bw>
    <xmx:JqB0X0v1M-F7jEEKW75tPFHWVS12pOR0wTzHdgJJCjYxdSoYBf_CSw>
    <xmx:KKB0X0EglajguDHqeiD-YJxQEdZNi0jAqTy92KB_3QzOlUcnCI6lJyHfrAQO--nl>
Received: from cisco (unknown [128.107.241.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9099B3280059;
        Wed, 30 Sep 2020 11:11:31 -0400 (EDT)
Date:   Wed, 30 Sep 2020 09:11:28 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>, wad@chromium.org,
        bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
Message-ID: <20200930151128.GD284424@cisco>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930150330.GC284424@cisco>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 09:03:36AM -0600, Tycho Andersen wrote:
> On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pages) wrote:
> >        ┌─────────────────────────────────────────────────────┐
> >        │FIXME                                                │
> >        ├─────────────────────────────────────────────────────┤
> >        │Interestingly, after the event  had  been  received, │
> >        │the  file descriptor indicates as writable (verified │
> >        │from the source code and by experiment). How is this │
> >        │useful?                                              │
> 
> You're saying it should just do EPOLLOUT and not EPOLLWRNORM? Seems
> reasonable.

If we make this change, I suppose we should also drop EPOLLRDNORM from
things which have not been received yet, since they're not really
readable.

Tycho
