Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E23300598
	for <lists+bpf@lfdr.de>; Fri, 22 Jan 2021 15:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbhAVOgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jan 2021 09:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbhAVOgh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jan 2021 09:36:37 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD1C061788
        for <bpf@vger.kernel.org>; Fri, 22 Jan 2021 06:35:50 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id e22so11442185iom.5
        for <bpf@vger.kernel.org>; Fri, 22 Jan 2021 06:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQkXkCrpyaC+AIGaG/IY48gE7Y/wuvK5j1jujmjo6ak=;
        b=TGTtYLXkk8PtuKyTgpavftYuSACm2ncnz9xcoHXYdgBRIYdBzMSgv8BzwI4+mIDMET
         2IqBmsXqjqsA+k+28JzJqOipY9wdBBY6bBQfhDshqyfe5Omuh2XQ9Ft4Xv9ZPEWHR1vq
         a14Lc5exm4acXrdYEBJ8GWc5mDHwCZQZehI5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQkXkCrpyaC+AIGaG/IY48gE7Y/wuvK5j1jujmjo6ak=;
        b=nE2BbB03ZZF1RyXzgt2Xr8JjahnsvFvhH2e2eA/OfAQv+ZxnUCxXkOWmyCkQeGdwHF
         kV8ip2iNp3YtNPdotyZzY7GPifkpk9B2FJ19WLR7MKaRzuadOU3nrEJbcVr/DAtr11Ug
         D3mrYkrfmUk5yCLfJOcfXWGpx9Pre2xDkV8Tc8W4lYLzjhrfh8FigJPMmMu6kfAXudv4
         HN5Pw/6PJNavExNFDagKHhfA6iEHZGQr85YyHEzSUoqUaJyu6m+lD3N5COAoN42MDue/
         e+irXDBVUozxVvz/JhGN3GcQ0oIOZdnDZ2fhwfvc9VhWgJDi4cRXxBwWbeATCicV68uz
         Mcgw==
X-Gm-Message-State: AOAM532WNcXdZwQhhEzlsXLC7i7pfznl52GcwHlif9ZrLnlW/MftGF8J
        Xy6jLPgSy6BUX+Wpd9CAsZBZI0FWjrQ0kPA613wIKQ==
X-Google-Smtp-Source: ABdhPJzcYnB5Ar0K5XejaBeX9r+dIBi3zsO9E0sekWCv1o6EezvzPVJi/aZ/DxPOrz6UuWeU9bFZKwNUknZuQnLIhQ8=
X-Received: by 2002:a92:6512:: with SMTP id z18mr786868ilb.220.1611326149322;
 Fri, 22 Jan 2021 06:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20210119155953.803818-1-revest@chromium.org> <20210119155953.803818-3-revest@chromium.org>
 <CAEf4BzYH26E_ASgX8rny-ZihEvD4K3PXZJvAi7nZrYLSLpKo+A@mail.gmail.com>
In-Reply-To: <CAEf4BzYH26E_ASgX8rny-ZihEvD4K3PXZJvAi7nZrYLSLpKo+A@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 22 Jan 2021 15:35:38 +0100
Message-ID: <CABRcYm+gWJcsFxqriUMHeu3sFFLWWRGy=_wQ5R6hNoYu92c0PQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] selftests/bpf: Integrate the
 socket_cookie test to test_progs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 21, 2021 at 8:55 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jan 19, 2021 at 8:00 AM Florent Revest <revest@chromium.org> wrote:
> >
> > Currently, the selftest for the BPF socket_cookie helpers is built and
> > run independently from test_progs. It's easy to forget and hard to
> > maintain.
> >
> > This patch moves the socket cookies test into prog_tests/ and vastly
> > simplifies its logic by:
> > - rewriting the loading code with BPF skeletons
> > - rewriting the server/client code with network helpers
> > - rewriting the cgroup code with test__join_cgroup
> > - rewriting the error handling code with CHECKs
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
>
> Few nits below regarding skeleton and ASSERT_xxx usage.
>
> >  tools/testing/selftests/bpf/Makefile          |   3 +-
> >  .../selftests/bpf/prog_tests/socket_cookie.c  |  82 +++++++
> >  .../selftests/bpf/progs/socket_cookie_prog.c  |   2 -
> >  .../selftests/bpf/test_socket_cookie.c        | 208 ------------------
>
> please also update .gitignore

Good catch!

> >  4 files changed, 83 insertions(+), 212 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> >  delete mode 100644 tools/testing/selftests/bpf/test_socket_cookie.c
> >
>
> [...]
>
> > +
> > +       skel = socket_cookie_prog__open_and_load();
> > +       if (CHECK(!skel, "socket_cookie_prog__open_and_load",
> > +                 "skeleton open_and_load failed\n"))
>
> nit: ASSERT_PTR_OK

Ah great, I find the ASSERT semantic much easier to follow than CHECKs.

> > +               return;
> > +
> > +       cgroup_fd = test__join_cgroup("/socket_cookie");
> > +       if (CHECK(cgroup_fd < 0, "join_cgroup", "cgroup creation failed\n"))
> > +               goto destroy_skel;
> > +
> > +       set_link = bpf_program__attach_cgroup(skel->progs.set_cookie,
> > +                                             cgroup_fd);
>
> you can use skel->links->set_cookie here and it will be auto-destroyed
> when the whole skeleton is destroyed. More simplification.

Sick. :)

> > +       if (CHECK(IS_ERR(set_link), "set-link-cg-attach", "err %ld\n",
> > +                 PTR_ERR(set_link)))
> > +               goto close_cgroup_fd;
> > +
> > +       update_link = bpf_program__attach_cgroup(skel->progs.update_cookie,
> > +                                                cgroup_fd);
>
> same as above, no need to maintain your link outside of skeleton
>
>
> > +       if (CHECK(IS_ERR(update_link), "update-link-cg-attach", "err %ld\n",
> > +                 PTR_ERR(update_link)))
> > +               goto free_set_link;
> > +
> > +       server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
> > +       if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
> > +               goto free_update_link;
> > +
> > +       client_fd = connect_to_fd(server_fd, 0);
> > +       if (CHECK(client_fd < 0, "connect_to_fd", "errno %d\n", errno))
> > +               goto close_server_fd;
>
> nit: ASSERT_OK is nicer (here and in few other places)

Did you mean ASSERT_OK for the two following err checks ?

ASSERT_OK does not seem right for a fd check where we want fd to be
positive. ASSERT_OK does: "bool ___ok = ___res == 0;"

I will keep my "CHECK(fd < 0" but maybe there could be an
ASSERT_POSITIVE that does "bool ___ok = ___res >= 0;"

> > +
> > +       err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.socket_cookies),
> > +                                 &client_fd, &val);
> > +       if (CHECK(err, "map_lookup", "err %d errno %d\n", err, errno))
> > +               goto close_client_fd;
> > +
> > +       err = getsockname(client_fd, (struct sockaddr *)&addr, &addr_len);
> > +       if (CHECK(err, "getsockname", "Can't get client local addr\n"))
> > +               goto close_client_fd;
> > +
> > +       cookie_expected_value = (ntohs(addr.sin6_port) << 8) | 0xFF;
> > +       CHECK(val.cookie_value != cookie_expected_value, "",
> > +             "Unexpected value in map: %x != %x\n", val.cookie_value,
> > +             cookie_expected_value);
>
> nit: ASSERT_NEQ is nicer

Indeed.

> > +
> > +close_client_fd:
> > +       close(client_fd);
> > +close_server_fd:
> > +       close(server_fd);
> > +free_update_link:
> > +       bpf_link__destroy(update_link);
> > +free_set_link:
> > +       bpf_link__destroy(set_link);
> > +close_cgroup_fd:
> > +       close(cgroup_fd);
> > +destroy_skel:
> > +       socket_cookie_prog__destroy(skel);
> > +}
>
> [...]
