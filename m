Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA962F5936
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 04:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbhANDW3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jan 2021 22:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbhANDW1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jan 2021 22:22:27 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46104C061786
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 19:21:47 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id z11so5448404qkj.7
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 19:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ya+assYx472nxrdUJL89axTmbLOjSaKych4XeheAa2s=;
        b=EMLjyykGJWRudh3+f2E7EJMKpkaJEEq9CePciyYWxwE3/ZeWdOOWkCS1WudvdKVRlV
         Jo0E8UrZdMrXxxVRXt7WIFSoIAu0+1/D2xXtPhjxDGW6f+lAP4vEtZLtY0VNPsdycyUl
         Aeac8oznt6gntIuN2YjxdelvW9v7QT+aRt0zEG1+hfu0SDPv8/om2GdIxgj6PhyIjv6z
         vq7keaSc4nvAgtsa5U0hce5eQE3PvRx/q5fnSZXrLz+Zb4lTygLc5Ax4jIGKboyaRtkD
         pbfMT8hDjxFC29Y6oTdcmbk2pZ5v+Uu9UNFmeErWO1Q2TYyvqIBOmAdHwB+bpWdLzV6T
         5Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ya+assYx472nxrdUJL89axTmbLOjSaKych4XeheAa2s=;
        b=KHMAgsay8JWl8B6mshLNKa4A+oudyZLjmaaI56kGslXVuDlzW06Jfif5+qJYXj3uGN
         GFZmtuB0edLfN8nND1JUIu7DSMe2JrCYGu85wSx8ndNVDSeSQWoOMDsJGfIDhZS8nnY0
         nOmUoy84Br0oORKp2XmhvZpdheJBY/2Jv8EDZmtlI4qiNPerXLEHSJDY0tcsA1m3wLB1
         NgQS0ron1BkQ4mTJqbmBAKQ+id+/q7n1neqktQDLd6BubCRPoRTm11QB89tp4N+BHmul
         aCF+oasiUcX1yXN22Mh+CKjBD6DC1gtbhq6NqcnH/nKJvN32mmGLfp4iKT36mDpkwRDY
         J/Jg==
X-Gm-Message-State: AOAM530hrUAw7W0SDfWo6aLF8+4G5uoRV30mFjV6DgWwddNJYZOr2sTx
        TGuhaQtVcHUFfO/iRRtL6mhuWF0HiYV3NQrVBLGGorfuwEwpGw==
X-Google-Smtp-Source: ABdhPJzb5GyZfXwUGzpvLLfYJye5w6fwnaJtE6/0P/GmHRQ+MMgxJnagC/QoFkP2tQjjxeFmIjBYpsiXr29pZ86Tt6o=
X-Received: by 2002:a25:e047:: with SMTP id x68mr5551516ybg.347.1610594506530;
 Wed, 13 Jan 2021 19:21:46 -0800 (PST)
MIME-Version: 1.0
References: <B8801F77-37E8-4EF8-8994-D366D48169A3@araalinetworks.com>
 <CAEf4Bzbgw49w2PtowsrzKQNcxD4fZRE6AKByX-5-dMo-+oWHHA@mail.gmail.com>
 <CADmGQ+3_h22VmJPddhf4Vy2J4PwwkhJAj+N3qSV7vERb+PZw8Q@mail.gmail.com> <CADmGQ+0JMBm8QANoEg5V7pDF6SadSN=u0y1w8BTrYOg5OOWa0g@mail.gmail.com>
In-Reply-To: <CADmGQ+0JMBm8QANoEg5V7pDF6SadSN=u0y1w8BTrYOg5OOWa0g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jan 2021 19:21:35 -0800
Message-ID: <CAEf4BzY9VsZi4mJWy3iKRbJw4d_kOJVivPWPstWiG6xcOh6Efg@mail.gmail.com>
Subject: Re: [PATCH bpf v1] Add `core_btf_path` to `bpf_object_open_opts` to
 pass BTF path from skeleton program
To:     Vamsi Kodavanty <vamsi@araalinetworks.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 13, 2021 at 2:17 PM Vamsi Kodavanty
<vamsi@araalinetworks.com> wrote:
>
> On Mon, Jan 11, 2021 at 7:33 PM Vamsi Kodavanty
> <vamsi@araalinetworks.com> wrote:
> >
> > Andrii,
> >    Thank you for the detailed review. I will address them as well as
> > the self tests. And will send out a new patch addressing them and
> > conforming to style/expectations.
> >
> > Cheers
> > Vamsi.
> >
> Andrii,
>       I understand the `bpf` repository being a mirror of the
> `bpf-next` tools/lib/bpf. Do the patches
> to `bpf` go back into `bpf-next`. I see there is a script for
> `bpf-next` to `bpf`syncs.
>       I ask because the `btf_vmlinux_override` changes only exist in
> the `bpf` repo. So, I make my
> changes in `bpf`?. In that case what happens to the `selftests` which
> are in `bpf-next`. And they
> won't have any idea of the new open option 'core_btf_path` that is
> being introduced.
>

There are two Linux upstream repositories to which BPF and libbpf
patches are applied: bpf ([0]) and bpf-next ([1]). Fixes usually go
into bpf, while all the new features go into bpf-next. They are
periodically merged and thus converge.

Then, specifically for libbpf, there is a Github mirror ([2]), which
is synced by me periodically from bpf-next and bpf trees. This Github
repo is what is considered to be "canonical" libbpf repo for the
purposes of building libbpf packages and consuming libbpf in user
applications. You shouldn't concern yourself with this one when
submitting patches, because it's a derivative of upstream
repositories.

What is confusing to me, though, is that all three of them have code
with btf_vmlinux_override, so I'm curious which "bpf" repository did
you find that doesn't yet have btf_vmlinux_override?

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
  [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
  [2] https://github.com/libbpf/libbpf

> Thanks again. Hopefully this is my last question before I come back to
> you with a proper patch.
>
> Cheers
> Vamsi.
>
> > On Mon, Jan 11, 2021 at 2:02 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Jan 8, 2021 at 6:36 PM Vamsi Kodavanty <vamsi@araalinetworks.com> wrote:
> > > >
> > > > Andrii,
> > > >      I have made the following changes as discussed to add an option to the `open_opts`
> > > > to take in the BTF.
> > > >      Please do take a look. Also, I am not sure what the procedure is for submitting patches/reviews.
> > > > If anyone has any pointers to a webpage where this is described I can go through it. But, below are
> > > > the proposed changes.
> > > >
> > >
> > > Daniel already gave you pointers. Also make sure you add [PATCH
> > > bpf-next] prefix to email subject to identify the patch is for
> > > bpf-next kernel tree.
> > > And with all changes like this we should also add selftests,
> > > exercising new features. Please take a look at
> > > tools/testing/selftests/bpf. I think updating
> > > test_progs/test_core_reloc.c in there to use this instead of
> > > bpf_object__load_xattr() might be enough of the testing.
> > >
> > > > Best Regards,
> > > > Vamsi.
> > > >
> > > > ---
> > > >  src/libbpf.c | 56 +++++++++++++++++++++++++++++++++++++---------------
> > > >  src/libbpf.h |  4 +++-
> > > >  2 files changed, 43 insertions(+), 17 deletions(-)
> > > >

[...]
