Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F2A3F8E73
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243241AbhHZTIq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhHZTIp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 15:08:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43862C061757
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:07:58 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x16so3593483pfh.2
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mf4UmSK3/FFWe3dVJs4Xhc3jgFCYAcPdFUpEVjrjWds=;
        b=j4/I9HrhAiOCELN1r18SrGwIFT5fNg7ebePUX1qz5BaWPmZd5qR0nntz1OtG/mbWir
         XAzJ4m1hDE/pPFvV9+rFbDUomt/Ba1M28377Av74qmSmw9Asg54VaO2ZZr0vdyi6Lk+9
         BE9OAxw6dd3qtcTejAzDX50gtYtmnJZdqMQFQ0LX7HpiJFUlkX0UY+Sxn4qopKFuZEP0
         IxoqDdoa5Ea81DqgpoQOFRWOEk2bhbZnBGkF1VbGp9mx3u840fBqd72u7Y2jCemeAruK
         KfVyh9Lhszacu2hKwlj65G/N8n71pzpDyjIeSSKeGnKhhAdI3vKyuIJwCL8LO5jG6A6t
         QJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mf4UmSK3/FFWe3dVJs4Xhc3jgFCYAcPdFUpEVjrjWds=;
        b=qTQbTzbpwj7UvhLglAaZRnPLxU/1ZFTcYe3rGs97GI3VzLN+5wrMYYAo7pRsPuwVUz
         9zebOH+NfVlf1k1wuhYT4KR+5Ef0nEJjhB8gx8SEEKEy3P14eYXhM/YJwMEHnKUxbw0W
         IUwCL70QuTbNGaoukUkB/Aal7yk3TITyEVVNjV7/eH7Acf2YKF/0ofDs1rhfHPWJBBNd
         Mwovv9oH4RY7FrEx6IJkJ56aeN6PVUwK4gmqNG9Nv1a2cp02davWeQr81BDQRkmzcMSG
         C4MSY4S+SYepwRdde/bUdoz3NMo/gr/0Co8GEVMiYk55aUeb7BRpInMkAGvtsLZspRzT
         4WoQ==
X-Gm-Message-State: AOAM5322Jv8I5nmfJOVC8g97nSjsJZDsv7oQLwK8d0joda25b+ca6RLy
        lm3AefWijpMwJdIZdCD/3tulBjY2TmEHXp0CcSY=
X-Google-Smtp-Source: ABdhPJyl41GM1cypJGTq3W0nfyXzEU+kAXWSbjdWTGOFlyrsoq8RfMJtWOX1ce5DNrBha8yL1V5Wzp2wqs8o2/s7hlA=
X-Received: by 2002:a62:8407:0:b029:39a:59dc:a237 with SMTP id
 k7-20020a6284070000b029039a59dca237mr5315350pfd.30.1630004877650; Thu, 26 Aug
 2021 12:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
 <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com> <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com>
In-Reply-To: <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 26 Aug 2021 12:07:46 -0700
Message-ID: <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>
Cc:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 26, 2021 at 11:18 AM sunyucong@gmail.com
<sunyucong@gmail.com> wrote:
>
> Reporting back: I tried a select() based approach, (as attached below)
>  but unfortunately it doesn't seem to work. During testing,  I am
> always getting full timeout errors as the socket never seems to become
> ready to read(). My guess is that this has something to do with the
> sockets being created through sockpair() , but I am unable to confirm.
>
> On the other hand, the previous patch approach works perfectly fine, I
> would still like to request to apply that instead.

Ok. Applied your earlier patch, but it's a short term workaround.
select() should work for af_unix.
I suspect something got broken with the redirect.
Cong, Jiang,
could you please take a look ?

>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 5c5979046523..247e8b7a6911 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -949,7 +949,6 @@ static void redir_to_connected(int family, int
> sotype, int sock_mapfd,
>         int err, n;
>         u32 key;
>         char b;
> -       int retries = 100;
>
>         zero_verdict_count(verd_mapfd);
>
> @@ -1002,15 +1001,12 @@ static void redir_to_connected(int family, int
> sotype, int sock_mapfd,
>                 goto close_peer1;
>         if (pass != 1)
>                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> -again:
> +
> +       if (poll_read(c0, IO_TIMEOUT_SEC))
> +             FAIL_ERRNO("%s: read", log_prefix);
>         n = read(c0, &b, 1);
> -       if (n < 0) {
> -               if (errno == EAGAIN && retries--) {
> -                       usleep(1000);
> -                       goto again;
> -               }
> +       if (n < 0)
>                 FAIL_ERRNO("%s: read", log_prefix);
> -       }
>         if (n == 0)
>                 FAIL("%s: incomplete read", log_prefix);
>
> @@ -1571,7 +1567,6 @@ static void unix_redir_to_connected(int sotype,
> int sock_mapfd,
>         const char *log_prefix = redir_mode_str(mode);
>         int c0, c1, p0, p1;
>         unsigned int pass;
> -       int retries = 100;
>         int err, n;
>         int sfd[2];
>         u32 key;
> @@ -1606,15 +1601,11 @@ static void unix_redir_to_connected(int
> sotype, int sock_mapfd,
>         if (pass != 1)
>                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
>
> -again:
> +       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC))
> +             FAIL_ERRNO("%s: read", log_prefix);
>         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
> -       if (n < 0) {
> -               if (errno == EAGAIN && retries--) {
> -                       usleep(1000);
> -                       goto again;
> -               }
> +       if (n < 0)
>                 FAIL_ERRNO("%s: read", log_prefix);
> -       }
>         if (n == 0)
>                 FAIL("%s: incomplete read", log_prefix);
>
> @@ -1748,7 +1739,6 @@ static void udp_redir_to_connected(int family,
> int sock_mapfd, int verd_mapfd,
>         const char *log_prefix = redir_mode_str(mode);
>         int c0, c1, p0, p1;
>         unsigned int pass;
> -       int retries = 100;
>         int err, n;
>         u32 key;
>         char b;
> @@ -1781,15 +1771,11 @@ static void udp_redir_to_connected(int family,
> int sock_mapfd, int verd_mapfd,
>         if (pass != 1)
>                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
>
> -again:
> +       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC * 10))
> +               FAIL_ERRNO("%s: read", log_prefix);
>         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
> -       if (n < 0) {
> -               if (errno == EAGAIN && retries--) {
> -                       usleep(1000);
> -                       goto again;
> -               }
> +       if (n < 0)
>                 FAIL_ERRNO("%s: read", log_prefix);
> -       }
>         if (n == 0)
>                 FAIL("%s: incomplete read", log_prefix);
>
> @@ -1841,7 +1827,6 @@ static void inet_unix_redir_to_connected(int
> family, int type, int sock_mapfd,
>         const char *log_prefix = redir_mode_str(mode);
>         int c0, c1, p0, p1;
>         unsigned int pass;
> -       int retries = 100;
>         int err, n;
>         int sfd[2];
>         u32 key;
> @@ -1876,15 +1861,11 @@ static void inet_unix_redir_to_connected(int
> family, int type, int sock_mapfd,
>         if (pass != 1)
>                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
>
> -again:
> +       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC))
> +             FAIL_ERRNO("%s: read", log_prefix);
>         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
> -       if (n < 0) {
> -               if (errno == EAGAIN && retries--) {
> -                       usleep(1000);
> -                       goto again;
> -               }
> +       if (n < 0)
>                 FAIL_ERRNO("%s: read", log_prefix);
> -       }
>         if (n == 0)
>                 FAIL("%s: incomplete read", log_prefix);
>
> @@ -1932,7 +1913,6 @@ static void unix_inet_redir_to_connected(int
> family, int type, int sock_mapfd,
>         int sfd[2];
>         u32 key;
>         char b;
> -       int retries = 100;
>
>         zero_verdict_count(verd_mapfd);
>
> @@ -1963,15 +1943,11 @@ static void unix_inet_redir_to_connected(int
> family, int type, int sock_mapfd,
>         if (pass != 1)
>                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
>
> -again:
> +       if (poll_read(mode == REDIR_INGRESS ? p0 : c0, IO_TIMEOUT_SEC))
> +             FAIL_ERRNO("%s: read", log_prefix);
>         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
> -       if (n < 0) {
> -               if (errno == EAGAIN && retries--) {
> -                       usleep(1000);
> -                       goto again;
> -               }
> +       if (n < 0)
>                 FAIL_ERRNO("%s: read", log_prefix);
> -       }
>         if (n == 0)
>                 FAIL("%s: incomplete read", log_prefix);
