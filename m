Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8319C2CDD17
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 19:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgLCSHA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 13:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgLCSG7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 13:06:59 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60914C061A4F
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 10:06:19 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id x2so2838234ybt.11
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 10:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8zJr7paC9y+ZoYhdgsESxhoc+L9jYHk/0XNHPVT690=;
        b=lRZRGYMANBRpPKmliEfz+D2mrLUbeAETdYmHECILovBx3RXaivfrCCXwdFBSGLh/P5
         rZU16I/+tSZ4EtbWtjvontKPqiZWFGCWjGTxgBfyGxO6zrWhRINSuu1AHa7F5F0KQsi1
         lTBbdilq5/rGFQXNjDEgJOmryko1aweU8LTAndy9qPuYrnKgbYc8NFSVYM3fRxD9mQrz
         u48c+6qv/JiWx66FDJ0fTVUm9KCa8Pq3JDO+dyPDGIcfz8SwvvrJ5p6ouCnuezr06jVC
         kt1jjzh56HmLaCHllA2/Qlsn2XKK5SRe6W6W9oAxrGlWAwudVL0mw4cmxj8e+qB8Wc14
         2j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8zJr7paC9y+ZoYhdgsESxhoc+L9jYHk/0XNHPVT690=;
        b=rQJfoMHB/B2EZfkP85aO47HTqpJBRjv2Sy0OaonP8dFcm7ie9ug+WVhoiTE1yhZ6Aa
         gx6rWpNXqdq8TCbGj516aiDpLASJwFniGMffgOUVovp0ZVeRWl/rogvNOSuNsWrTrn7C
         v/NgDLrwrsqf9CVo5obTjVZuTNEMZwHvwXkVBXlDE0/+t2GZYXGLNfa4b8NjAy36UVR5
         wjZhNiDG5PR6YRQVMKmVnNnwx1ATxVdJewNO7dvOQc4/GNZgcA/6Oj+OrTRwfOyG69Uz
         9IKEsA+UvKYf/rI4ZJ/W51jYqSGxfZuYIPPElHT63SREVMZnvw4NqrFrDLYNu7Wa6LL1
         wIDg==
X-Gm-Message-State: AOAM531P5Unt9pwkU/TO8ibef84KLicSHNi5Qa68/g9X/HZ28FoSFbHy
        k3xnsSBGcxr/VlmID/6bZIA8Lca4/l1mebrwgjs=
X-Google-Smtp-Source: ABdhPJzGFX765bl9wNzLbf13LF44biNdes70MhfMctzryLQ3IqOJfZvNtA0ZmoKeLe9CTKgWmv0vPp/XTomvANmTn0k=
X-Received: by 2002:a25:c089:: with SMTP id c131mr439437ybf.510.1607018778659;
 Thu, 03 Dec 2020 10:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <20201203005807.486320-4-kpsingh@chromium.org>
 <CAEf4BzbXA-az9cAKwy=bpqFOkX+6mtirm0TRxkyTmZdm+bXxoQ@mail.gmail.com>
 <CACYkzJ6PYgmkZg_=q3Yi300esXmjB_gnX4urmcLxSQFxf+QyuQ@mail.gmail.com> <CACYkzJ6rtH7mJ1mr3VsyvDjkM1tkpvd0XxvHPCuQAbyKBfNx-Q@mail.gmail.com>
In-Reply-To: <CACYkzJ6rtH7mJ1mr3VsyvDjkM1tkpvd0XxvHPCuQAbyKBfNx-Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Dec 2020 10:06:07 -0800
Message-ID: <CAEf4BzYtstd6wPcUYWrDax2ykowVpfrqhOpYGnSObUjEVME1pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Add config dependency on BLK_DEV_LOOP
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 9:35 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On Thu, Dec 3, 2020 at 11:56 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On Thu, Dec 3, 2020 at 6:56 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
> > > >
> > > > From: KP Singh <kpsingh@google.com>
> > > >
> > > > The ima selftest restricts its scope to a test filesystem image
> > > > mounted on a loop device and prevents permanent ima policy changes for
> > > > the whole system.
> > > >
> > > > Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> > > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/config | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> > > > index 365bf9771b07..37e1f303fc11 100644
> > > > --- a/tools/testing/selftests/bpf/config
> > > > +++ b/tools/testing/selftests/bpf/config
> > > > @@ -43,3 +43,4 @@ CONFIG_IMA=y
> > > >  CONFIG_SECURITYFS=y
> > > >  CONFIG_IMA_WRITE_POLICY=y
> > > >  CONFIG_IMA_READ_POLICY=y
> > > > +CONFIG_BLK_DEV_LOOP=y
> > > > --
> > >
> > >
> > > You mentioned also that CONFIG_LSM="selinux,bpf,integrity" is needed,
> > > no? Let's add that as well?
> >
> > I did not add it because we did not do it when we added "bpf" to the list and
> >
> > I also don't think selinux is really required here which might be worse in
> > some cases (e.g. when the required config options for
> > SELinux are not selected).
> >
> > Also, when one selects CONFIG_BPF_LSM or CONFIG_IMA from make
> > menuconfig / nconfig, we get "bpf" and "integrity" appended by default:
> >
> > We can add a comment that says that says:
> >
> >   "Please ensure "bpf" and "integrity" are present in CONFIG_LSM"
> >
> > Now, I was not sure if adding a comment would break any scripts that people

Any infra I'm in charge of is not using this config in an automated
fashion, so adding

# CONFIG_LSM="bpf,integrity"

would work just fine. But I can't know if anyone else relies on this.
But # comments are part of Kconfig "spec", so probably is ok to add.

> > have that parse this file, so I avoided it. But overriding the string
> > completely
> > might not be a good idea.
>
> If it's okay, I can send the v4 out now and we can add the comment or CONFIG_LSM
> in a separate patch?

Sure.
