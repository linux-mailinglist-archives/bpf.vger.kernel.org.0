Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584E730658F
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 22:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhA0VAM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 16:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhA0U7L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 15:59:11 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E1C061573;
        Wed, 27 Jan 2021 12:58:31 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id k4so3366854ybp.6;
        Wed, 27 Jan 2021 12:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EeHewh5pGKBh8qs4wXc8sC79goadHCBw7K8atkuUirU=;
        b=XnJfn3XyyigQGCfPXVqnB/GqUgMGY5yJc822a2Bg+VoOPOksAHQxe06vBZ2seJzFbB
         idOVoA1vywZCcJS2kGgVu/HYufqIUoeq5dmOAuebuXVbhSqhkh00d0NrYeN0uiHGuJ6Q
         0dx8GzoonAHmcObXDr6UT7Wq7pcrxzUxY7zOJIoyXVh2KX7/gWL2VH80Sqox1BsF9vz5
         J5U+a2HGpiQrdOC0IamcPwe73nDkmAW7FjISVWXyUNNP5vp8w9oInxPPrDFtOggIwKNs
         +tBgxDD7HeZt/EDIEs0geRewuj1k6C6ic8ABQkr7uXBWH+KmfnmbemmXW8SabLTtZXQs
         kFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EeHewh5pGKBh8qs4wXc8sC79goadHCBw7K8atkuUirU=;
        b=sb8uxlAA/BacSKmLEUYdKYeYz+Ipc03dR9X8LMgXH9T8EdJFIDndBXwmQSOxECbEO5
         QSAUP+iDHF2sCCiCLZXT5u4wvMBWDOtY7+ufhTHanU6vsumOoehosONEWIRr+HczzfoG
         8NRRKiKmKwI+33ZF2OzFPz2E+42XNjq1sCRD7H3cG0lWSHXEYqm3fv4usUydeS/w9Oqt
         xxYxhu9i4XwnQtfl72KgFfTrorGIXb1cMy3KT+8iw+o8WXiQQsufOkTVXQf8VjJh4/Vg
         Y4XjW62yZs8aGFWk1EJSADaoHvWCwkMnkLG8ogkYUGoIjEE11uMFdUHKGZsDnud9ud8n
         6MNQ==
X-Gm-Message-State: AOAM532XbIXHwM9B1o+VzuXHim38acPXFYeT23MvbqpzAsgs34UT0emc
        y6b0sFqUNG5ekga/yISDmX/QWsYIIaJYZvx4toM=
X-Google-Smtp-Source: ABdhPJwEO15BqjZTtrBJ9+DOkewhqRu9luTn2+nLNJ27JwFjDVUDsNBma4dmpufNYpsD6wR34mUSMveh0hxjNq2t0yE=
X-Received: by 2002:a25:4b86:: with SMTP id y128mr18487747yba.403.1611781106006;
 Wed, 27 Jan 2021 12:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20210126183559.1302406-1-revest@chromium.org> <20210126183559.1302406-3-revest@chromium.org>
In-Reply-To: <20210126183559.1302406-3-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Jan 2021 12:58:15 -0800
Message-ID: <CAEf4BzbhQY7-+aqUMcEPzHQP9hznzDNn5QrntqOyx=6NSQBxiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/5] selftests/bpf: Integrate the
 socket_cookie test to test_progs
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 26, 2021 at 10:36 AM Florent Revest <revest@chromium.org> wrote:
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
> Acked-by: KP Singh <kpsingh@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/.gitignore        |   1 -
>  tools/testing/selftests/bpf/Makefile          |   3 +-
>  .../selftests/bpf/prog_tests/socket_cookie.c  |  71 ++++++
>  .../selftests/bpf/progs/socket_cookie_prog.c  |   2 -
>  .../selftests/bpf/test_socket_cookie.c        | 208 ------------------
>  5 files changed, 72 insertions(+), 213 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_cookie.c
>  delete mode 100644 tools/testing/selftests/bpf/test_socket_cookie.c
>

[...]
