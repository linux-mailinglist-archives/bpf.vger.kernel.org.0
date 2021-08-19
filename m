Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7C33F206F
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 21:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhHSTQ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhHSTQy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 15:16:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82093C061575
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 12:16:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y34so15133145lfa.8
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 12:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yxEWjkJKg8sN3x34m+D3yQMsxPzVx2dzZR8KkArsVik=;
        b=H38tEphFLvAAwDz0DRv71SkF4KnW0mK2Zs5gdAuMxcz6T0wie72QU7pH4LyasXpiNt
         jEI5M8PMFblnBIQ8DsSSIxxCDuRwTmogr2eVgu41gjb8c99J1GsV9LZsO2xuTrTd29nR
         SDwbPzyUP5AXsdZyzcQEfsHCoVWEYxjHAyllWxmIWc9rmjaEfkIShrQPr921rSc17fFG
         2T0neon2ceZIpaZ55Sf8AX1qBnUT3u3CTx9nidLGHxBL7ppORibDLOPBmv163tH632ZJ
         HdEah41Yht7cKVqcH2eFggS005Aai3DpT/Vl11q82MqxDr0wAf+RxpjESoSjyrFqGhUk
         jy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yxEWjkJKg8sN3x34m+D3yQMsxPzVx2dzZR8KkArsVik=;
        b=s0HVciAtb9BBmFlWGCLtE4b/HKvllUQysDnESRjAAC26TyysjC1veFjkSuK2mkou7n
         45B6fKTe4sDvDYSwnEJzV4vy7HDBDUuS/4MViU3IZXZuRMimN56QDddoweOy7reExOsZ
         HmQafhY+LEK/oqzzMhcQpkBTFnFTPXWk2K8uO6ShqEmfJUB0q+dEggHjmu2I94GMZzXk
         8mtQ9Vju3cxtzoQp48V/ZLOkCQ4VG5hnXpxYHGh/TNysi9EqD58YDwFzwmpNyz4n4Sv3
         WocuufbSh4YH96gNzb/bprHJ186CMXO3z7D5er9gDI00HJCWkdJHbrj4Assvt99ygbU3
         rVTA==
X-Gm-Message-State: AOAM531qqQJUHDK87kwjHg90o00wDF8xEyFIZVtwArs9Nsa1/TsJkGVv
        cCMnN9kSemU74kt8F44WY8Qre86Yci7e0IUfZG0=
X-Google-Smtp-Source: ABdhPJwzvZEM0RxVWtWBfMqclvGn/DgPKl6aUs/W4OoZLElcNycrWPyCpYyqNWMjV1VadiFpZlqE4u3tjcNZxlBHZrE=
X-Received: by 2002:a05:6512:1295:: with SMTP id u21mr12068533lfs.384.1629400575589;
 Thu, 19 Aug 2021 12:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210819163609.2583758-1-fallentree@fb.com> <CAEf4BzZyiZ3Q4Q=VSRZD0_8Wf-2-T8Ti_NyghC4eAoRGoH-F4g@mail.gmail.com>
In-Reply-To: <CAEf4BzZyiZ3Q4Q=VSRZD0_8Wf-2-T8Ti_NyghC4eAoRGoH-F4g@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Thu, 19 Aug 2021 12:15:49 -0700
Message-ID: <CAJygYd2FpcennyFp+JabOEsgNj+oGBentf_Kbj-QcNs0csv-uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: adding delay in socketmap_listen
 to reduce flakyness
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 19, 2021 at 11:45 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 19, 2021 at 9:36 AM Yucong Sun <fallentree@fb.com> wrote:
> >
> > This patch adds a 1ms delay to reduce flakyness of the test.
> >
> > Signed-off-by: Yucong Sun <fallentree@fb.com>
> > ---
>
> Any reasons to not implement exponential back-off, like we did for test_m=
aps?

for simplicity, since there are no contention involved here I figured
we don=E2=80=99t need random delay and back-offs.

(sorry for resending, I was fooled by the mobile gmail client that it
doesn't do plain text).


>
> >  .../selftests/bpf/prog_tests/sockmap_listen.c        | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/=
tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > index afa14fb66f08..6a5df28f9a3d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > @@ -1603,8 +1603,10 @@ static void unix_redir_to_connected(int sotype, =
int sock_mapfd,
> >  again:
> >         n =3D read(mode =3D=3D REDIR_INGRESS ? p0 : c0, &b, 1);
> >         if (n < 0) {
> > -               if (errno =3D=3D EAGAIN && retries--)
> > +               if (errno =3D=3D EAGAIN && retries--) {
> > +                       usleep(1000);
> >                         goto again;
> > +               }
> >                 FAIL_ERRNO("%s: read", log_prefix);
> >         }
> >         if (n =3D=3D 0)
> > @@ -1776,8 +1778,10 @@ static void udp_redir_to_connected(int family, i=
nt sock_mapfd, int verd_mapfd,
> >  again:
> >         n =3D read(mode =3D=3D REDIR_INGRESS ? p0 : c0, &b, 1);
> >         if (n < 0) {
> > -               if (errno =3D=3D EAGAIN && retries--)
> > +               if (errno =3D=3D EAGAIN && retries--) {
> > +                       usleep(1000);
> >                         goto again;
> > +               }
> >                 FAIL_ERRNO("%s: read", log_prefix);
> >         }
> >         if (n =3D=3D 0)
> > @@ -1869,8 +1873,10 @@ static void inet_unix_redir_to_connected(int fam=
ily, int type, int sock_mapfd,
> >  again:
> >         n =3D read(mode =3D=3D REDIR_INGRESS ? p0 : c0, &b, 1);
> >         if (n < 0) {
> > -               if (errno =3D=3D EAGAIN && retries--)
> > +               if (errno =3D=3D EAGAIN && retries--) {
> > +                       usleep(1000);
> >                         goto again;
> > +               }
> >                 FAIL_ERRNO("%s: read", log_prefix);
> >         }
> >         if (n =3D=3D 0)
> > --
> > 2.30.2
> >
