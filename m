Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63213F2095
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 21:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhHSTaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 15:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhHSTaJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 15:30:09 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC29DC061575
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 12:29:29 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a93so14369312ybi.1
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X9jw6CPrpGHVBlkY4COXG3pwQ3PBeyvh5B8y2STTGyc=;
        b=E/V3CaT2jSQgMum6/C+BF1Afqr6YbCkzFUS1xHlX/ORVEDVlVnKt9GLDtiDbicUgXk
         jhvP03eD4XOV3LiyftcHUFZzZJwJLLSgKm1iI3SFaVfJuitj6vNO0yM9j61SKLE/k7HN
         QImzvTxQXwLqPm4jOOfQLuAgFTK4J8to82JAu2HF1lWUDxFp9cQ4x/ykIWWWiRnqI6eB
         MgMy5yoQppXEJyZaNFxODZYMCv5pICqfFLbc7IH5FOUSLq/uc1zhy2YxsNJx2ujMrrz9
         e+J5tCl6TboPxRaocQ9WqW3WXriv1X2XzyQfzcjTGtQsIZ6v2O6CXzEitR4uEq9JZYBd
         YOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X9jw6CPrpGHVBlkY4COXG3pwQ3PBeyvh5B8y2STTGyc=;
        b=Bgh4SInXaDMk/08zRzbY3OiXyLwN74ck05+SDxKsqUYlqvpIaX1rIPoU5QAp5T3wzA
         3jfG4ENcrSLCo+U5/jPm05DqpdBgpokiMxwrQd44ecP3i16g8yKyz/R7weh2aJ95U8GZ
         aEc9CJegl9iTOgGLFWveYBJNduSsWQb300YnlfWr3AE+vlKnYzkq503cy82G3hKpGh5C
         pVTXCn31aqwP2HZz0Bi95YRWOU3x8YPYkRe2DCRNgiVW497oX1m05xtRHQ7Zfz741S9j
         1U3Hxty50LRl3ucpF6ZY7XKU7X7/dgf6NWrUPZO655+Hz74IHEptz5rID+4wRh8ofeIb
         oMpQ==
X-Gm-Message-State: AOAM532QguEskAU8/6tpnS/gQA6MVAUaoDOHTlR0CvpJnM7tpa24CmIC
        J8X7a3KR1YhqMNYc3JB7wyGRI3JnHsoGfF2SDco=
X-Google-Smtp-Source: ABdhPJx4w8seZf2tPFeZt1m913748EYI1wwgLRkO7BzkphYPMEVSDjCi1MRbvOz6rn9Uef6aV6jbYlcp95nPz8ZZMlI=
X-Received: by 2002:a25:5054:: with SMTP id e81mr20335408ybb.510.1629401369233;
 Thu, 19 Aug 2021 12:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210819163609.2583758-1-fallentree@fb.com> <CAEf4BzZyiZ3Q4Q=VSRZD0_8Wf-2-T8Ti_NyghC4eAoRGoH-F4g@mail.gmail.com>
 <CAJygYd2FpcennyFp+JabOEsgNj+oGBentf_Kbj-QcNs0csv-uw@mail.gmail.com>
In-Reply-To: <CAJygYd2FpcennyFp+JabOEsgNj+oGBentf_Kbj-QcNs0csv-uw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Aug 2021 12:29:17 -0700
Message-ID: <CAEf4Bza-Oj4fQ9xboiXNEFJN0Pmpyr3BW=RAQQGByx=CUyfF9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: adding delay in socketmap_listen
 to reduce flakyness
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 19, 2021 at 12:16 PM sunyucong@gmail.com
<sunyucong@gmail.com> wrote:
>
> On Thu, Aug 19, 2021 at 11:45 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Aug 19, 2021 at 9:36 AM Yucong Sun <fallentree@fb.com> wrote:
> > >
> > > This patch adds a 1ms delay to reduce flakyness of the test.
> > >
> > > Signed-off-by: Yucong Sun <fallentree@fb.com>
> > > ---
> >
> > Any reasons to not implement exponential back-off, like we did for test=
_maps?
>
> for simplicity, since there are no contention involved here I figured
> we don=E2=80=99t need random delay and back-offs.

Alright, it's an improvement anyways. Let's see if it still causes
problem. Applied to bpf-next, thanks!

>
> (sorry for resending, I was fooled by the mobile gmail client that it
> doesn't do plain text).
>

AFAIK, mobile client doesn't support plain text

>
> >
> > >  .../selftests/bpf/prog_tests/sockmap_listen.c        | 12 +++++++++-=
--
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c =
b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > > index afa14fb66f08..6a5df28f9a3d 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > > @@ -1603,8 +1603,10 @@ static void unix_redir_to_connected(int sotype=
, int sock_mapfd,
> > >  again:
> > >         n =3D read(mode =3D=3D REDIR_INGRESS ? p0 : c0, &b, 1);
> > >         if (n < 0) {
> > > -               if (errno =3D=3D EAGAIN && retries--)
> > > +               if (errno =3D=3D EAGAIN && retries--) {
> > > +                       usleep(1000);
> > >                         goto again;
> > > +               }
> > >                 FAIL_ERRNO("%s: read", log_prefix);
> > >         }
> > >         if (n =3D=3D 0)
> > > @@ -1776,8 +1778,10 @@ static void udp_redir_to_connected(int family,=
 int sock_mapfd, int verd_mapfd,
> > >  again:
> > >         n =3D read(mode =3D=3D REDIR_INGRESS ? p0 : c0, &b, 1);
> > >         if (n < 0) {
> > > -               if (errno =3D=3D EAGAIN && retries--)
> > > +               if (errno =3D=3D EAGAIN && retries--) {
> > > +                       usleep(1000);
> > >                         goto again;
> > > +               }
> > >                 FAIL_ERRNO("%s: read", log_prefix);
> > >         }
> > >         if (n =3D=3D 0)
> > > @@ -1869,8 +1873,10 @@ static void inet_unix_redir_to_connected(int f=
amily, int type, int sock_mapfd,
> > >  again:
> > >         n =3D read(mode =3D=3D REDIR_INGRESS ? p0 : c0, &b, 1);
> > >         if (n < 0) {
> > > -               if (errno =3D=3D EAGAIN && retries--)
> > > +               if (errno =3D=3D EAGAIN && retries--) {
> > > +                       usleep(1000);
> > >                         goto again;
> > > +               }
> > >                 FAIL_ERRNO("%s: read", log_prefix);
> > >         }
> > >         if (n =3D=3D 0)
> > > --
> > > 2.30.2
> > >
