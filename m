Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832AB3F8EB0
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbhHZTZH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhHZTZH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 15:25:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7681C061757
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:24:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m4so7039046ljq.8
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLTG16qAj+DTwV4iBdyU++VvXNdZ/04pbHW8TEszuf8=;
        b=PCksBL1WbIFUll6m3sNTO3tPA0Xz6QAkRDR+u58g+BETQf2c0WAx8Q54oE3KdjyOHB
         EZ8ofRzTVhAiuSrnU0qQFtUOrw1bZ1DY2SXZoRk8QkHSRUol92XMSInqiSKjRPoEglbx
         gvGLfZ+IzFkUYhXo5fF5pTg4PPbFjVVM6c5YT2YZ3t/cYLHFRcaDXbPOBoNUgUs9NaCu
         nyKbqC+1DmYNxpeRv3Z6YsPs+GSehtJvV47NOs252VFSU8ozL5+VtgnlGa9B+nttKy+o
         hcqqkoNTeKKuiZuYOwON//V5CWOtwydAAj6vtYgZX7GMS4nQACyiopuTHvbdvdodRhGL
         Hw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLTG16qAj+DTwV4iBdyU++VvXNdZ/04pbHW8TEszuf8=;
        b=aQ7kTLL0HLVHLrnoj4oYQ60E8RpQHVFRmXr1oHZda/Wa4fHEZqgH+BUGTPTO2ig7hj
         ULxBHrUZJlItMjzzLernMBXlPWKfcmOT25RTqJ1zfcbrfqRXIXmQ6UTaZq18A/lvymjN
         fFJ0E0T4ZggrLyqSoEGFmuDhZDMcsIxYYExCgp8j1AiHl8PkfJQNTDsVR+byIlld0d1u
         NAk8GJENXVcTaJULB0qvctMDa7ho5COfj8KXsgAMYuCCVbGg7cunNuyAj4UyCkVPxaRo
         LuVO9/uvwl7LMrS5YAQ/IKUJAom9yawK+Fhew9j2IVmg9U4SLltQbCmlskh4WosrPOxd
         5leg==
X-Gm-Message-State: AOAM531HxOggt763d/qUhhifXl6rKETOe0mr0WL/CYMtBuYTVgpcwIII
        fKDYeqkO6rP2VobxOXxOZKvwmnpfPQUJkY1JXNI=
X-Google-Smtp-Source: ABdhPJwVkbk5yMa6ZVLmRtFGghren9shXtP0awPqTyo+6ZAx7g3Wa4Xdzwlsu+lXbKyBjzmiaJDj4PKAETpdBuso2YQ=
X-Received: by 2002:a05:651c:1601:: with SMTP id f1mr4523521ljq.112.1630005857786;
 Thu, 26 Aug 2021 12:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
 <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
 <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com> <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com>
In-Reply-To: <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Thu, 26 Aug 2021 12:23:51 -0700
Message-ID: <CAJygYd2aK_s6x4KO71G0KQLdMr5z07hAPqu5fsj+cQpxUw+7tw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I don't think it's AF_UNIX alone, I'm getting select() timeout for all family:

./test_progs:udp_redir_to_connected:1775: ingress: read: Timer expired
udp_redir_to_connected:FAIL:1775
#120/36 sockmap_listen/sockmap IPv4 test_udp_redir:FAIL
./test_progs:inet_unix_redir_to_connected:1865: ingress: read: Timer expired
inet_unix_redir_to_connected:FAIL:1865
./test_progs:inet_unix_redir_to_connected:1865: ingress: read: Timer expired
inet_unix_redir_to_connected:FAIL:1865
./test_progs:unix_inet_redir_to_connected:1947: ingress: read: Timer expired
unix_inet_redir_to_connected:FAIL:1947
./test_progs:unix_inet_redir_to_connected:1947: ingress: read: Timer expired
unix_inet_redir_to_connected:FAIL:1947
...
./test_progs:udp_redir_to_connected:1775: ingress: read: Timer expired
udp_redir_to_connected:FAIL:1775
#120/73 sockmap_listen/sockmap IPv6 test_udp_redir:FAIL
./test_progs:inet_unix_redir_to_connected:1865: ingress: read: Timer expired
inet_unix_redir_to_connected:FAIL:1865
./test_progs:inet_unix_redir_to_connected:1865: ingress: read: Timer expired
inet_unix_redir_to_connected:FAIL:1865
./test_progs:unix_inet_redir_to_connected:1947: ingress: read: Timer expired
unix_inet_redir_to_connected:FAIL:1947
./test_progs:unix_inet_redir_to_connected:1947: ingress: read: Timer expired
unix_inet_redir_to_connected:FAIL:1947
#120/74 sockmap_listen/sockmap IPv6 test_udp_unix_redir:FAIL
./test_progs:unix_redir_to_connected:1605: ingress: read: Timer expired
unix_redir_to_connected:FAIL:1605
#120/75 sockmap_listen/sockmap Unix test_unix_redir:FAIL
./test_progs:unix_redir_to_connected:1605: ingress: read: Timer expired
unix_redir_to_connected:FAIL:1605

On Thu, Aug 26, 2021 at 12:07 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 26, 2021 at 11:18 AM sunyucong@gmail.com
> <sunyucong@gmail.com> wrote:
> >
> > Reporting back: I tried a select() based approach, (as attached below)
> >  but unfortunately it doesn't seem to work. During testing,  I am
> > always getting full timeout errors as the socket never seems to become
> > ready to read(). My guess is that this has something to do with the
> > sockets being created through sockpair() , but I am unable to confirm.
> >
> > On the other hand, the previous patch approach works perfectly fine, I
> > would still like to request to apply that instead.
>
> Ok. Applied your earlier patch, but it's a short term workaround.
> select() should work for af_unix.
> I suspect something got broken with the redirect.
> Cong, Jiang,
> could you please take a look ?
>
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > index 5c5979046523..247e8b7a6911 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> > @@ -949,7 +949,6 @@ static void redir_to_connected(int family, int
> > sotype, int sock_mapfd,
> >         int err, n;
> >         u32 key;
> >         char b;
> > -       int retries = 100;
> >
> >         zero_verdict_count(verd_mapfd);
> >
> > @@ -1002,15 +1001,12 @@ static void redir_to_connected(int family, int
> > sotype, int sock_mapfd,
> >                 goto close_peer1;
> >         if (pass != 1)
> >                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> > -again:
> > +
> > +       if (poll_read(c0, IO_TIMEOUT_SEC))
> > +             FAIL_ERRNO("%s: read", log_prefix);
> >         n = read(c0, &b, 1);
> > -       if (n < 0) {
> > -               if (errno == EAGAIN && retries--) {
> > -                       usleep(1000);
> > -                       goto again;
> > -               }
> > +       if (n < 0)
> >                 FAIL_ERRNO("%s: read", log_prefix);
> > -       }
> >         if (n == 0)
> >                 FAIL("%s: incomplete read", log_prefix);
> >
> > @@ -1571,7 +1567,6 @@ static void unix_redir_to_connected(int sotype,
> > int sock_mapfd,
> >         const char *log_prefix = redir_mode_str(mode);
> >         int c0, c1, p0, p1;
> >         unsigned int pass;
> > -       int retries = 100;
> >         int err, n;
> >         int sfd[2];
> >         u32 key;
> > @@ -1606,15 +1601,11 @@ static void unix_redir_to_connected(int
> > sotype, int sock_mapfd,
> >         if (pass != 1)
> >                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> >
> > -again:
> > +       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC))
> > +             FAIL_ERRNO("%s: read", log_prefix);
> >         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
> > -       if (n < 0) {
> > -               if (errno == EAGAIN && retries--) {
> > -                       usleep(1000);
> > -                       goto again;
> > -               }
> > +       if (n < 0)
> >                 FAIL_ERRNO("%s: read", log_prefix);
> > -       }
> >         if (n == 0)
> >                 FAIL("%s: incomplete read", log_prefix);
> >
> > @@ -1748,7 +1739,6 @@ static void udp_redir_to_connected(int family,
> > int sock_mapfd, int verd_mapfd,
> >         const char *log_prefix = redir_mode_str(mode);
> >         int c0, c1, p0, p1;
> >         unsigned int pass;
> > -       int retries = 100;
> >         int err, n;
> >         u32 key;
> >         char b;
> > @@ -1781,15 +1771,11 @@ static void udp_redir_to_connected(int family,
> > int sock_mapfd, int verd_mapfd,
> >         if (pass != 1)
> >                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> >
> > -again:
> > +       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC * 10))
> > +               FAIL_ERRNO("%s: read", log_prefix);
> >         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
> > -       if (n < 0) {
> > -               if (errno == EAGAIN && retries--) {
> > -                       usleep(1000);
> > -                       goto again;
> > -               }
> > +       if (n < 0)
> >                 FAIL_ERRNO("%s: read", log_prefix);
> > -       }
> >         if (n == 0)
> >                 FAIL("%s: incomplete read", log_prefix);
> >
> > @@ -1841,7 +1827,6 @@ static void inet_unix_redir_to_connected(int
> > family, int type, int sock_mapfd,
> >         const char *log_prefix = redir_mode_str(mode);
> >         int c0, c1, p0, p1;
> >         unsigned int pass;
> > -       int retries = 100;
> >         int err, n;
> >         int sfd[2];
> >         u32 key;
> > @@ -1876,15 +1861,11 @@ static void inet_unix_redir_to_connected(int
> > family, int type, int sock_mapfd,
> >         if (pass != 1)
> >                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> >
> > -again:
> > +       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC))
> > +             FAIL_ERRNO("%s: read", log_prefix);
> >         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
> > -       if (n < 0) {
> > -               if (errno == EAGAIN && retries--) {
> > -                       usleep(1000);
> > -                       goto again;
> > -               }
> > +       if (n < 0)
> >                 FAIL_ERRNO("%s: read", log_prefix);
> > -       }
> >         if (n == 0)
> >                 FAIL("%s: incomplete read", log_prefix);
> >
> > @@ -1932,7 +1913,6 @@ static void unix_inet_redir_to_connected(int
> > family, int type, int sock_mapfd,
> >         int sfd[2];
> >         u32 key;
> >         char b;
> > -       int retries = 100;
> >
> >         zero_verdict_count(verd_mapfd);
> >
> > @@ -1963,15 +1943,11 @@ static void unix_inet_redir_to_connected(int
> > family, int type, int sock_mapfd,
> >         if (pass != 1)
> >                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> >
> > -again:
> > +       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC))
> > +             FAIL_ERRNO("%s: read", log_prefix);
> >         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
> > -       if (n < 0) {
> > -               if (errno == EAGAIN && retries--) {
> > -                       usleep(1000);
> > -                       goto again;
> > -               }
> > +       if (n < 0)
> >                 FAIL_ERRNO("%s: read", log_prefix);
> > -       }
> >         if (n == 0)
> >                 FAIL("%s: incomplete read", log_prefix);
