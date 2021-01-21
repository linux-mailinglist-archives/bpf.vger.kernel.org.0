Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B162FF56E
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 21:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbhAUITH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 03:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbhAUH4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 02:56:42 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174CC0613C1;
        Wed, 20 Jan 2021 23:55:19 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id f6so1168155ybq.13;
        Wed, 20 Jan 2021 23:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4lNFXBT7h1XnSuVTSvJiA2b5ZRCvtBxL/9v1E3sqAjE=;
        b=ah+5PMH19H+3oVfD+kvK7tMI4tI18TzAamFtq+rsuGo+uUs7KrK51E8nvBq2CF4Mbh
         P/gAvqZTK7WY/wbvn7kP40ho5xmFLpW6C4FFREi5lb2YRpaRjKWJnucVaYsm8LzVyA/3
         C/Y+CtWxYhax/KdgGhH9zZTUfyN2jenPHDEyq0pU/NI92yurXE2aQcyyjijjtW20yHPx
         MT4ePuhTbiGhWTQwQ6Il/3ksc0zNpE7o1wrPb1RM4ou4eBT/2063eX6QH3IItEcyRo2/
         nxlPIuggayAlBklldS80NR2ckWQNm3E7HUF2klFfW1FSwsOZcjNTwr4oSk8pD3Ks5kQG
         PeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lNFXBT7h1XnSuVTSvJiA2b5ZRCvtBxL/9v1E3sqAjE=;
        b=fdT10ovXSN1/sCsUzsRrJM6/3Nki2E6DgM2USDx49IXItub7dGfItkt9Y4Vxqd220A
         iSjIRXZvbgQ+BcIxdPKIHTwHVqM0pB8w+jUF5wZSieD4OFdEmbRJxcga3dY3hgpLOpyv
         u4L4Dz688eYy3pu6Pn3gZBxZEvE6aoZxXaLulruC8H3eamlqhf+pbG8iEn+57qDze9cX
         MA05QRkLv/9XRqDYQPdaHYIUUlI4EtEwwnt4fZ4IdKVFqi+87qMJ4Q1vMaScIpNko0ij
         ethNOXzn/67yvaIKTvHcpoIVMFYZmC6II288DWuQD0IhSKmxS0oB3vmSEyRtgpmIlRXs
         NYQA==
X-Gm-Message-State: AOAM531J5MYD/nTmMENby+UMD3dNlmj8lqqJbDxIiYFrgDjnxhNxcXjW
        /dTvIglspH8HVyzP0w9HMnUDdwHuDxdzJZSRo4E=
X-Google-Smtp-Source: ABdhPJz/w/tlOI7mw9G4noI3yCpWCfdiJ0eP3JCiNVORg/0QzaHi2/7kEoKkmQROXP3BkZzIQ2mX3E/koXE14SLxif4=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr19705711ybd.230.1611215718778;
 Wed, 20 Jan 2021 23:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20210119155953.803818-1-revest@chromium.org> <20210119155953.803818-3-revest@chromium.org>
In-Reply-To: <20210119155953.803818-3-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Jan 2021 23:55:07 -0800
Message-ID: <CAEf4BzYH26E_ASgX8rny-ZihEvD4K3PXZJvAi7nZrYLSLpKo+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] selftests/bpf: Integrate the
 socket_cookie test to test_progs
To:     Florent Revest <revest@chromium.org>
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

On Tue, Jan 19, 2021 at 8:00 AM Florent Revest <revest@chromium.org> wrote:
>
> Currently, the selftest for the BPF socket_cookie helpers is built and
> run independently from test_progs. It's easy to forget and hard to
> maintain.
>
> This patch moves the socket cookies test into prog_tests/ and vastly
> simplifies its logic by:
> - rewriting the loading code with BPF skeletons
> - rewriting the server/client code with network helpers
> - rewriting the cgroup code with test__join_cgroup
> - rewriting the error handling code with CHECKs
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---

Few nits below regarding skeleton and ASSERT_xxx usage.

>  tools/testing/selftests/bpf/Makefile          |   3 +-
>  .../selftests/bpf/prog_tests/socket_cookie.c  |  82 +++++++
>  .../selftests/bpf/progs/socket_cookie_prog.c  |   2 -
>  .../selftests/bpf/test_socket_cookie.c        | 208 ------------------

please also update .gitignore

>  4 files changed, 83 insertions(+), 212 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_cookie.c
>  delete mode 100644 tools/testing/selftests/bpf/test_socket_cookie.c
>

[...]

> +
> +       skel = socket_cookie_prog__open_and_load();
> +       if (CHECK(!skel, "socket_cookie_prog__open_and_load",
> +                 "skeleton open_and_load failed\n"))

nit: ASSERT_PTR_OK

> +               return;
> +
> +       cgroup_fd = test__join_cgroup("/socket_cookie");
> +       if (CHECK(cgroup_fd < 0, "join_cgroup", "cgroup creation failed\n"))
> +               goto destroy_skel;
> +
> +       set_link = bpf_program__attach_cgroup(skel->progs.set_cookie,
> +                                             cgroup_fd);

you can use skel->links->set_cookie here and it will be auto-destroyed
when the whole skeleton is destroyed. More simplification.

> +       if (CHECK(IS_ERR(set_link), "set-link-cg-attach", "err %ld\n",
> +                 PTR_ERR(set_link)))
> +               goto close_cgroup_fd;
> +
> +       update_link = bpf_program__attach_cgroup(skel->progs.update_cookie,
> +                                                cgroup_fd);

same as above, no need to maintain your link outside of skeleton


> +       if (CHECK(IS_ERR(update_link), "update-link-cg-attach", "err %ld\n",
> +                 PTR_ERR(update_link)))
> +               goto free_set_link;
> +
> +       server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
> +       if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
> +               goto free_update_link;
> +
> +       client_fd = connect_to_fd(server_fd, 0);
> +       if (CHECK(client_fd < 0, "connect_to_fd", "errno %d\n", errno))
> +               goto close_server_fd;

nit: ASSERT_OK is nicer (here and in few other places)

> +
> +       err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.socket_cookies),
> +                                 &client_fd, &val);
> +       if (CHECK(err, "map_lookup", "err %d errno %d\n", err, errno))
> +               goto close_client_fd;
> +
> +       err = getsockname(client_fd, (struct sockaddr *)&addr, &addr_len);
> +       if (CHECK(err, "getsockname", "Can't get client local addr\n"))
> +               goto close_client_fd;
> +
> +       cookie_expected_value = (ntohs(addr.sin6_port) << 8) | 0xFF;
> +       CHECK(val.cookie_value != cookie_expected_value, "",
> +             "Unexpected value in map: %x != %x\n", val.cookie_value,
> +             cookie_expected_value);

nit: ASSERT_NEQ is nicer

> +
> +close_client_fd:
> +       close(client_fd);
> +close_server_fd:
> +       close(server_fd);
> +free_update_link:
> +       bpf_link__destroy(update_link);
> +free_set_link:
> +       bpf_link__destroy(set_link);
> +close_cgroup_fd:
> +       close(cgroup_fd);
> +destroy_skel:
> +       socket_cookie_prog__destroy(skel);
> +}

[...]
