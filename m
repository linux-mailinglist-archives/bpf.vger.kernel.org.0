Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE86E3F8FFD
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 23:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhHZVGa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 17:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbhHZVG3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 17:06:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53579C061757
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 14:05:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 17so4127323pgp.4
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqU+hLg3b3flfMsrQFuFypWXOnGk/iewwBhIz7S6sN4=;
        b=QqMO1rIFTzy3SK7W1gYER7nJPN3Z49U6okbl8GKjTdXRFOjPrfNhdDeKEtqrtgt8ly
         kIdab6uK8SrhECJ7N1VwGx1aHUnA+i9uFNp29nR6o2AxzKFivm+gg8hBxFJwIVRGsluw
         Tv2axFdW5k/RyENOe/ol45zjNxUnCdZqQAhidnWv8H3E+wcJdj8KTTAeZcMenInzVcgY
         GuIJdNmNOWNZwdibaKRWSurr4eP2FmZDzAv5S75iMZTjdtR+bEp2mJcNEYjDW5CfNBT8
         LkAsthcyj6xeDgNuO3HTDwCpkpvGouJvLNXdfGujdYL4DfmBI0jNHQvsvdDGw9N+pLbi
         ChlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqU+hLg3b3flfMsrQFuFypWXOnGk/iewwBhIz7S6sN4=;
        b=KtQhCJZPpVu9IUDowCUdSGp8psRCS3GgJo/3LlrTYtzu97X8fvlIyfjTiqnAXdFfR1
         K48xOXeHZv7u0fo9H0ygr+MmvkBoSQsgXIJngxAaI0rW33H/5ZDjySPVIuIMotUjuwcp
         sro5YhnqumV2e5LqdkpyC4vPNdsH1Nu2fBgOcgow0TNBKohoHpOMbABtKtQL5bwSXU3e
         co0L6OZ53oE2aPbKRi2ESxEIyNm+OvZ87N34mRLzP2OTyP73oDhQ1TWbfE3fvN1LVnU9
         P+/0Ml/a5LZsObrCtICw2HSNslsLeEyhrBPFRm+HbMuhUKhPS+hn8mYDjvlFJpmacFyU
         Zkqg==
X-Gm-Message-State: AOAM5310FrxejgZe8wsXlZ1Mz8Au4qy+sEWSu+9+G8qwTdggyh2NPi5K
        Yoqjo/IpRImAuVBaq3arY9iOrwMWlJtbvg2YswQ=
X-Google-Smtp-Source: ABdhPJyTgK9hR+XVRKlFMyP+6lYr9YyUtgGk1SUST9f0pS+vlaiQaXpGPFzTfzgWWpZnLFeg/EIxbo0BTpsxfWRMe74=
X-Received: by 2002:a63:d849:: with SMTP id k9mr5065435pgj.67.1630011941603;
 Thu, 26 Aug 2021 14:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
 <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
 <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com>
 <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com> <CAJygYd2aK_s6x4KO71G0KQLdMr5z07hAPqu5fsj+cQpxUw+7tw@mail.gmail.com>
In-Reply-To: <CAJygYd2aK_s6x4KO71G0KQLdMr5z07hAPqu5fsj+cQpxUw+7tw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 26 Aug 2021 14:05:30 -0700
Message-ID: <CAADnVQ+u_vzMmftV4YoTs42HSia4L6DjDc++wP9Bd03n8PVtKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 26, 2021 at 12:24 PM sunyucong@gmail.com
<sunyucong@gmail.com> wrote:
>
> I don't think it's AF_UNIX alone, I'm getting select() timeout for all family:
>
> ./test_progs:udp_redir_to_connected:1775: ingress: read: Timer expired
> udp_redir_to_connected:FAIL:1775
> #120/36 sockmap_listen/sockmap IPv4 test_udp_redir:FAIL
> ./test_progs:inet_unix_redir_to_connected:1865: ingress: read: Timer expired
> inet_unix_redir_to_connected:FAIL:1865

That's something different. It's ETIME and not EAGAIN.
Do you see IO_TIMEOUT_SEC==30 seconds elapsed between these lines?
No matter how slow the qemu setup is, the test shouldn't wait that long.

> ./test_progs:inet_unix_redir_to_connected:1865: ingress: read: Timer expired
> inet_unix_redir_to_connected:FAIL:1865
> ./test_progs:unix_inet_redir_to_connected:1947: ingress: read: Timer expired
> unix_inet_redir_to_connected:FAIL:1947
> ./test_progs:unix_inet_redir_to_connected:1947: ingress: read: Timer expired
> unix_inet_redir_to_connected:FAIL:1947
> ...
> ./test_progs:udp_redir_to_connected:1775: ingress: read: Timer expired
> udp_redir_to_connected:FAIL:1775
> #120/73 sockmap_listen/sockmap IPv6 test_udp_redir:FAIL
> ./test_progs:inet_unix_redir_to_connected:1865: ingress: read: Timer expired
> inet_unix_redir_to_connected:FAIL:1865
> ./test_progs:inet_unix_redir_to_connected:1865: ingress: read: Timer expired
> inet_unix_redir_to_connected:FAIL:1865
> ./test_progs:unix_inet_redir_to_connected:1947: ingress: read: Timer expired
> unix_inet_redir_to_connected:FAIL:1947
> ./test_progs:unix_inet_redir_to_connected:1947: ingress: read: Timer expired
> unix_inet_redir_to_connected:FAIL:1947
> #120/74 sockmap_listen/sockmap IPv6 test_udp_unix_redir:FAIL
> ./test_progs:unix_redir_to_connected:1605: ingress: read: Timer expired
> unix_redir_to_connected:FAIL:1605
> #120/75 sockmap_listen/sockmap Unix test_unix_redir:FAIL
> ./test_progs:unix_redir_to_connected:1605: ingress: read: Timer expired
> unix_redir_to_connected:FAIL:1605
>
> On Thu, Aug 26, 2021 at 12:07 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Aug 26, 2021 at 11:18 AM sunyucong@gmail.com
> > <sunyucong@gmail.com> wrote:
> > >
> > > Reporting back: I tried a select() based approach, (as attached below)
> > >  but unfortunately it doesn't seem to work. During testing,  I am
> > > always getting full timeout errors as the socket never seems to become
> > > ready to read(). My guess is that this has something to do with the
> > > sockets being created through sockpair() , but I am unable to confirm.
> > >
> > > On the other hand, the previous patch approach works perfectly fine, I
> > > would still like to request to apply that instead.
> >
> > Ok. Applied your earlier patch, but it's a short term workaround.
> > select() should work for af_unix.
> > I suspect something got broken with the redirect.
> > Cong, Jiang,
> > could you please take a look ?
> >
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > > b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > > index 5c5979046523..247e8b7a6911 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > > @@ -949,7 +949,6 @@ static void redir_to_connected(int family, int
> > > sotype, int sock_mapfd,
> > >         int err, n;
> > >         u32 key;
> > >         char b;
> > > -       int retries = 100;
> > >
> > >         zero_verdict_count(verd_mapfd);
> > >
> > > @@ -1002,15 +1001,12 @@ static void redir_to_connected(int family, int
> > > sotype, int sock_mapfd,
> > >                 goto close_peer1;
> > >         if (pass != 1)
> > >                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> > > -again:
> > > +
> > > +       if (poll_read(c0, IO_TIMEOUT_SEC))
> > > +             FAIL_ERRNO("%s: read", log_prefix);
> > >         n = read(c0, &b, 1);
> > > -       if (n < 0) {
> > > -               if (errno == EAGAIN && retries--) {
> > > -                       usleep(1000);
> > > -                       goto again;
> > > -               }
> > > +       if (n < 0)
> > >                 FAIL_ERRNO("%s: read", log_prefix);
> > > -       }
> > >         if (n == 0)
> > >                 FAIL("%s: incomplete read", log_prefix);
> > >
> > > @@ -1571,7 +1567,6 @@ static void unix_redir_to_connected(int sotype,
> > > int sock_mapfd,
> > >         const char *log_prefix = redir_mode_str(mode);
> > >         int c0, c1, p0, p1;
> > >         unsigned int pass;
> > > -       int retries = 100;
> > >         int err, n;
> > >         int sfd[2];
> > >         u32 key;
> > > @@ -1606,15 +1601,11 @@ static void unix_redir_to_connected(int
> > > sotype, int sock_mapfd,
> > >         if (pass != 1)
> > >                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> > >
> > > -again:
> > > +       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC))
> > > +             FAIL_ERRNO("%s: read", log_prefix);
> > >         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
> > > -       if (n < 0) {
> > > -               if (errno == EAGAIN && retries--) {
> > > -                       usleep(1000);
> > > -                       goto again;
> > > -               }
> > > +       if (n < 0)
> > >                 FAIL_ERRNO("%s: read", log_prefix);
> > > -       }
> > >         if (n == 0)
> > >                 FAIL("%s: incomplete read", log_prefix);
> > >
> > > @@ -1748,7 +1739,6 @@ static void udp_redir_to_connected(int family,
> > > int sock_mapfd, int verd_mapfd,
> > >         const char *log_prefix = redir_mode_str(mode);
> > >         int c0, c1, p0, p1;
> > >         unsigned int pass;
> > > -       int retries = 100;
> > >         int err, n;
> > >         u32 key;
> > >         char b;
> > > @@ -1781,15 +1771,11 @@ static void udp_redir_to_connected(int family,
> > > int sock_mapfd, int verd_mapfd,
> > >         if (pass != 1)
> > >                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> > >
> > > -again:
> > > +       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC * 10))
> > > +               FAIL_ERRNO("%s: read", log_prefix);
> > >         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
> > > -       if (n < 0) {
> > > -               if (errno == EAGAIN && retries--) {
> > > -                       usleep(1000);
> > > -                       goto again;
> > > -               }
> > > +       if (n < 0)
> > >                 FAIL_ERRNO("%s: read", log_prefix);
> > > -       }
> > >         if (n == 0)
> > >                 FAIL("%s: incomplete read", log_prefix);
> > >
> > > @@ -1841,7 +1827,6 @@ static void inet_unix_redir_to_connected(int
> > > family, int type, int sock_mapfd,
> > >         const char *log_prefix = redir_mode_str(mode);
> > >         int c0, c1, p0, p1;
> > >         unsigned int pass;
> > > -       int retries = 100;
> > >         int err, n;
> > >         int sfd[2];
> > >         u32 key;
> > > @@ -1876,15 +1861,11 @@ static void inet_unix_redir_to_connected(int
> > > family, int type, int sock_mapfd,
> > >         if (pass != 1)
> > >                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> > >
> > > -again:
> > > +       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC))
> > > +             FAIL_ERRNO("%s: read", log_prefix);
> > >         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
> > > -       if (n < 0) {
> > > -               if (errno == EAGAIN && retries--) {
> > > -                       usleep(1000);
> > > -                       goto again;
> > > -               }
> > > +       if (n < 0)
> > >                 FAIL_ERRNO("%s: read", log_prefix);
> > > -       }
> > >         if (n == 0)
> > >                 FAIL("%s: incomplete read", log_prefix);
> > >
> > > @@ -1932,7 +1913,6 @@ static void unix_inet_redir_to_connected(int
> > > family, int type, int sock_mapfd,
> > >         int sfd[2];
> > >         u32 key;
> > >         char b;
> > > -       int retries = 100;
> > >
> > >         zero_verdict_count(verd_mapfd);
> > >
> > > @@ -1963,15 +1943,11 @@ static void unix_inet_redir_to_connected(int
> > > family, int type, int sock_mapfd,
> > >         if (pass != 1)
> > >                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> > >
> > > -again:
> > > +       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC))
> > > +             FAIL_ERRNO("%s: read", log_prefix);
> > >         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
> > > -       if (n < 0) {
> > > -               if (errno == EAGAIN && retries--) {
> > > -                       usleep(1000);
> > > -                       goto again;
> > > -               }
> > > +       if (n < 0)
> > >                 FAIL_ERRNO("%s: read", log_prefix);
> > > -       }
> > >         if (n == 0)
> > >                 FAIL("%s: incomplete read", log_prefix);
