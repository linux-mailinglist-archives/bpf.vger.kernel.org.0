Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518404A54BD
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 02:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiBABiG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 20:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiBABiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 20:38:05 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A53C061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 17:38:05 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p63so18474335iod.11
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 17:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=poJfGET8hyBovtj83eO2jFHvzD+bAmvDzIwihkMXMPY=;
        b=dNozvOOxMiXlwlJQA3rTIfQMWrOON0/7lTtZZrI9Zme2eOk2WZmeJ1CQEjQqp/5R/8
         G7kqvVjSs9hq0hHeCKSc03h36vYIw0fh20qVrZNZJFLRKkvN5iy4bRttJSAAAaVeLHd4
         +y1LLNTJ3zyL7tGalguierhWKtvC1gDa05m9Gz2ONULhAOn9PnUqxrzAwrl0m+zT36aA
         dFYi3QOH4ReJRK10mNNwQUwAAycsnv1dgWBQ2DeASAfeGJNTExpHOp7NUnbX4w17g7SH
         RKRRZvFQpzZNv7T+q7Uc4NZ4Ufy3xnXRSjy5C4cvr0RVQIZB9oj2iqi7klVxjx7eHPRq
         e4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=poJfGET8hyBovtj83eO2jFHvzD+bAmvDzIwihkMXMPY=;
        b=Yf25/fQfqEjYkOjW/+6KB2DfZYTbh4aLB2VDXJQLAoHrywfQ3eeo5ngOB5U5jWywpQ
         qlMMSL4YgwGLcF60J9W73TVWGhisP2yoWqEo1QsueDG7R5dO/4DDAzrpXyeon1KJBEBS
         79copvJYvyv/6PxcCi/EaQ+6oQ19ARleDMdQ9WWzK6NItkPzwiRY5q+NVcaMLYTtSt2m
         UQ3HQn5/YDE1KzWy2cfibnMnZAhUMLEJ8/OvtQsSxJfwBi2SD0xbkeHhH30yv8sXpmOS
         ssd50SaS7kUMOAzrRi6SVPl3nAMHqdSgSUSXF+5+ohF0RVan0+8OEz1IWZZVV4FKKKCn
         euFQ==
X-Gm-Message-State: AOAM5311baznh9Ouyw9vO17GXA5aIpu8yWwQd2hVwGuVsxIBnG7z3Dos
        oSwbrW6rsXG4eLGNq99RrXPa6ogluR/nEmP/3f4=
X-Google-Smtp-Source: ABdhPJxvp8Cjgwk9pAeqjO4gEIiqQEpOgfe0k3C/qpRBe5E16rg1yD2+KxhcVIK5e1iA8z3v63K4sWwcOVmvfzt0SgU=
X-Received: by 2002:a5e:a806:: with SMTP id c6mr12451973ioa.112.1643679484955;
 Mon, 31 Jan 2022 17:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20220128012319.2494472-1-delyank@fb.com> <20220128012319.2494472-5-delyank@fb.com>
In-Reply-To: <20220128012319.2494472-5-delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 31 Jan 2022 17:37:53 -0800
Message-ID: <CAEf4BzaGXMt+3W1wkCT7OncKqezqhwcER5ppF3F+ZGmzHP5V6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] libbpf: Deprecate bpf_prog_test_run_xattr
 and bpf_prog_test_run
To:     Delyan Kratunov <delyank@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 27, 2022 at 5:23 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Closes: https://github.com/libbpf/libbpf/issues/286

As Daniel mentioned, please add non-empty commit message. As for the
"Closes: ", it's not one of "supported" tags in Linux repo, so we've
been using a "reference" syntax to introduce it. So something like
this commit message would do the trick:

Deprecate non-extendable bpf_prog_test_run_xattr() in favor of
OPTS-based bpf_prog_test_run_opts() ([0]).

  [0] Closes: https://github.com/libbpf/libbpf/issues/286

> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/lib/bpf/bpf.h |  8 +++++---
>  tools/lib/bpf/xsk.c | 11 +++++++----
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index c2e8327010f9..e3d87b35435d 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -453,13 +453,15 @@ struct bpf_prog_test_run_attr {
>                              * out: length of cxt_out */
>  };
>
> -LIBBPF_API int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test_attr);
> +LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_test_run_opts() instead")

please don't remove LIBBPF_API, it still has to be marked with
LIBBPF_API for proper shared library visibility

> +int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test_attr);
>
>  /*
>   * bpf_prog_test_run does not check that data_out is large enough. Consider
> - * using bpf_prog_test_run_xattr instead.
> + * using bpf_prog_test_run_opts instead.
>   */
> -LIBBPF_API int bpf_prog_test_run(int prog_fd, int repeat, void *data,
> +LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_test_run_opts() instead")
> +int bpf_prog_test_run(int prog_fd, int repeat, void *data,
>                                  __u32 size, void *data_out, __u32 *size_out,
>                                  __u32 *retval, __u32 *duration);
>  LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
> diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
> index edafe56664f3..843d03b8f58c 100644
> --- a/tools/lib/bpf/xsk.c
> +++ b/tools/lib/bpf/xsk.c

don't bother with xsk.c, entire file is marked as deprecated and will
be removed in libbpf v1.0. It already has deprecation suppressing
pragma, so you shouldn't see any compilation warning.

> @@ -369,8 +369,7 @@ int xsk_umem__create_v0_0_2(struct xsk_umem **umem_ptr, void *umem_area,
>  static enum xsk_prog get_xsk_prog(void)
>  {
>         enum xsk_prog detected = XSK_PROG_FALLBACK;
> -       __u32 size_out, retval, duration;
> -       char data_in = 0, data_out;
> +       char data_in = 0;
>         struct bpf_insn insns[] = {
>                 BPF_LD_MAP_FD(BPF_REG_1, 0),
>                 BPF_MOV64_IMM(BPF_REG_2, 0),
> @@ -378,6 +377,10 @@ static enum xsk_prog get_xsk_prog(void)
>                 BPF_EMIT_CALL(BPF_FUNC_redirect_map),
>                 BPF_EXIT_INSN(),
>         };
> +       LIBBPF_OPTS(bpf_test_run_opts, test_opts,
> +               .data_in = &data_in,
> +               .data_size_in = 1,
> +       );
>         int prog_fd, map_fd, ret, insn_cnt = ARRAY_SIZE(insns);
>
>         map_fd = bpf_map_create(BPF_MAP_TYPE_XSKMAP, NULL, sizeof(int), sizeof(int), 1, NULL);
> @@ -392,8 +395,8 @@ static enum xsk_prog get_xsk_prog(void)
>                 return detected;
>         }
>
> -       ret = bpf_prog_test_run(prog_fd, 0, &data_in, 1, &data_out, &size_out, &retval, &duration);
> -       if (!ret && retval == XDP_PASS)
> +       ret = bpf_prog_test_run_opts(prog_fd, &test_opts);
> +       if (!ret && test_opts.retval == XDP_PASS)
>                 detected = XSK_PROG_REDIRECT_FLAGS;
>         close(prog_fd);
>         close(map_fd);
> --
> 2.30.2
>
