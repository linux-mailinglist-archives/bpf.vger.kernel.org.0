Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED0D2A890F
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 22:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbgKEVcy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 16:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731860AbgKEVcy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 16:32:54 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F4FC0613CF;
        Thu,  5 Nov 2020 13:32:53 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id f6so2644107ybr.0;
        Thu, 05 Nov 2020 13:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wllOumUiN3CO5+JJCREJzUH1/CfdWjOhyUGmRgpPjQ=;
        b=EvpXLM6KsLrLyHRvxywH0EF4bP3w80PXXPJ14Rh+P0sTeU2/3MPnb5uzohTAg3O/qF
         8c3rAoaUZBMWh5Xiu0E5lbx3eJIJy/wjG7uQAhOe728q3LCH6XE0lOCKs9athc7yLA33
         95joDVXKMrrMvT5a5PptXnmbf9oJZvH78YOchSpnukgY2h9kha8VEZVp6K/qnVz4jMuW
         dxknwoF2p5yVv5Iy2i9eh4pdePaoVnZHPg5magLouN0pgoQzHN3b3pelByxZlwQuwgS+
         J2KjiTdVEq3HRb65TnRK8o9s24eFG/bSAmtFmHIJaXag0h/5achnVgFbuQNo8pY5K5cN
         RWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wllOumUiN3CO5+JJCREJzUH1/CfdWjOhyUGmRgpPjQ=;
        b=rnOwpVFCywXoXqnFP2XOtYD7dB6Jr2u+POkke2fQKeerK+B/NVeDHHDihw+A6K2zJp
         +UyLLDsB4tf9BPcXcnarvQza4JY5xs/pRmqEbRlzM50C7KGobCmuRvb/R9U1t7Kb0pql
         KGFE2OQunSFQQ6tBUhzJS/qm5shNdNBGrPDBlZ4qnuS99FcXNGChP1YBKsmTf4hTbkDk
         50ufypzEPRZzrxulCJeM1tkWXHcaRSkxo8sDcZijMZ1z+E8wSKP2ONVLRVwkMuM+TMnp
         zmFgQHUylntDtMmXLERqwgDxAUZJKsj6+l7NOxyyPOjCUQpIQyFXzivVS9M387Ucb6lE
         ra7A==
X-Gm-Message-State: AOAM531PnVxN+kaXiMeM0CSVP+2tzAs3DHLw48wUNSp2MiN43MF3m2Mv
        JSDV5qtt6rQFuIXYZN17/3VNhi9FiTOML/lWdok=
X-Google-Smtp-Source: ABdhPJx1hyV6TUCNTUsIOtzXgIUvoqESXjIouApwK47qqKVLg/JKGcfmMZ91dBCwzzwNKPOorH1MjZSjAqCKDDZuSUA=
X-Received: by 2002:a25:da4e:: with SMTP id n75mr6481845ybf.425.1604611973168;
 Thu, 05 Nov 2020 13:32:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604542786.git.dxu@dxuuu.xyz> <4e3e8b9b525c8bed39c0ee2aa68f2dff701f56a4.1604542786.git.dxu@dxuuu.xyz>
In-Reply-To: <4e3e8b9b525c8bed39c0ee2aa68f2dff701f56a4.1604542786.git.dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 5 Nov 2020 13:32:42 -0800
Message-ID: <CAEf4BzZN3v0Lb=XBKag3+EJANvAA=ei+ot3zNxuQc_HqYEdScw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftest/bpf: Test bpf_probe_read_user_str()
 strips trailing bytes after NUL
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 4, 2020 at 8:51 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Previously, bpf_probe_read_user_str() could potentially overcopy the
> trailing bytes after the NUL due to how do_strncpy_from_user() does the
> copy in long-sized strides. The issue has been fixed in the previous
> commit.
>
> This commit adds a selftest that ensures we don't regress
> bpf_probe_read_user_str() again.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  .../bpf/prog_tests/probe_read_user_str.c      | 60 +++++++++++++++++++
>  .../bpf/progs/test_probe_read_user_str.c      | 34 +++++++++++
>  2 files changed, 94 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
> new file mode 100644
> index 000000000000..597a166e6c8d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "test_probe_read_user_str.skel.h"
> +
> +static const char str[] = "mestring";
> +
> +void test_probe_read_user_str(void)
> +{
> +       struct test_probe_read_user_str *skel;
> +       int fd, err, duration = 0;
> +       char buf[256];
> +       ssize_t n;
> +
> +       skel = test_probe_read_user_str__open_and_load();
> +       if (CHECK(!skel, "test_probe_read_user_str__open_and_load",
> +                 "skeleton open and load failed\n"))
> +               goto out;
> +
> +       err = test_probe_read_user_str__attach(skel);
> +       if (CHECK(err, "test_probe_read_user_str__attach",
> +                 "skeleton attach failed: %d\n", err))
> +               goto out;
> +
> +       fd = open("/dev/null", O_WRONLY);
> +       if (CHECK(fd < 0, "open", "open /dev/null failed: %d\n", fd))
> +               goto out;
> +
> +       /* Give pid to bpf prog so it doesn't read from anyone else */
> +       skel->bss->pid = getpid();
> +
> +       /* Ensure bytes after string are ones */
> +       memset(buf, 1, sizeof(buf));
> +       memcpy(buf, str, sizeof(str));
> +
> +       /* Trigger tracepoint */
> +       n = write(fd, buf, sizeof(buf));
> +       if (CHECK(n != sizeof(buf), "write", "write failed: %ld\n", n))
> +               goto fd_out;
> +
> +       /* Did helper fail? */
> +       if (CHECK(skel->bss->ret < 0, "prog ret", "prog returned: %d\n",
> +                 skel->bss->ret))
> +               goto fd_out;
> +
> +       /* Check that string was copied correctly */
> +       err = memcmp(skel->bss->buf, str, sizeof(str));
> +       if (CHECK(err, "memcmp", "prog copied wrong string"))
> +               goto fd_out;
> +
> +       /* Now check that no extra trailing bytes were copied */
> +       memset(buf, 0, sizeof(buf));
> +       err = memcmp(skel->bss->buf + sizeof(str), buf, sizeof(buf) - sizeof(str));
> +       if (CHECK(err, "memcmp", "trailing bytes were not stripped"))
> +               goto fd_out;
> +
> +fd_out:
> +       close(fd);
> +out:
> +       test_probe_read_user_str__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
> new file mode 100644
> index 000000000000..41c3e296566e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#include <sys/types.h>
> +
> +struct sys_enter_write_args {
> +       unsigned long long pad;
> +       int syscall_nr;
> +       int pad1; /* 4 byte hole */

I have a hunch that this explicit padding might break on big-endian
architectures?..

Can you instead include "vmlinux.h" in this file and use struct
trace_event_raw_sys_enter? you'll just need ctx->args[2] to get that
buffer pointer.

Alternatively, and it's probably simpler overall would be to just
provide user-space pointer through global variable:

void *user_ptr;


bpf_probe_read_user_str(buf, ..., user_ptr);

From user-space:

skel->bss->user_ptr = &my_userspace_buf;

Full control. You can trigger tracepoint with just an usleep(1), for instance.

> +       unsigned int fd;
> +       int pad2; /* 4 byte hole */
> +       const char *buf;
> +       size_t count;
> +};
> +
> +pid_t pid = 0;
> +int ret = 0;
> +char buf[256] = {};
> +
> +SEC("tracepoint/syscalls/sys_enter_write")
> +int on_write(struct sys_enter_write_args *ctx)
> +{
> +       if (pid != (bpf_get_current_pid_tgid() >> 32))
> +               return 0;
> +
> +       ret = bpf_probe_read_user_str(buf, sizeof(buf), ctx->buf);
> +
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.28.0
>
