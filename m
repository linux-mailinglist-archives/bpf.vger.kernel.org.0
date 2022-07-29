Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49B9585528
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 20:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbiG2SwP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 14:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiG2SwN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 14:52:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0403342F
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 11:52:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id rq15so4042691ejc.10
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tvk4AdZkUOaQm1s0aaGNXMMRwkwf3/Oq3bW0gr7MvWU=;
        b=F/D9DEc1FpM5SCDalihSMXfGOgqrQ0RYr4PxqraK54HEUocwgKD52f7zVPUFk7MHT9
         Z/iaSapFiP9sc1gdcBk5ULrrLyYA4jGkN9OSvwmETwJBsIUqofZXWiCfgRBIUepMi0IF
         IaoLXQImZAMwna/AtyWag19Oo9NmnrUD6P9enGjs/g9PkcPit5t6DVqdEJpzKmWYznLd
         R/a3q7ExRcTOwJcEIXeC1qkrq4BYzgHI7sQN0cBYUeXR4ywxoNoRmY5JlbrneGkw68QG
         roOZiiQhvwbSWA48js0t5hp3rDxsWHi+uastmG3aYQ0Itwwt+Gh81UOnJu/kS35y/msT
         nKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tvk4AdZkUOaQm1s0aaGNXMMRwkwf3/Oq3bW0gr7MvWU=;
        b=jR+sdWByOHztwwbH0CAGibnR04B63CDihhq0VO28Dgl/PKql8NmtBRSIcuzocxFEEl
         PHSQs34CsLMI1uAyhFf8chGvVezSiMYWd+f7GFVBdJw/gRWF2Miew9LPgpUGbuFKxX5c
         ldSKE6fMQmZI8jl/c86vRNPVnMFXtfhhTUDf2pJvfeXbBWevLU6xDOAEvrRtODg6FeAD
         48nplBzzBYooSfjg3+RKBb27ueDhC4qQZxBnUnWfziAo2USQJWDu1Fy8SSEmZo9SKiZp
         NBfqoHrSO/eyGNIGBjabtBB5ZW4SnZ3xRMAQ2mfThTf9bHiokYO1ZY0nEnn59iGNNYt/
         /xWQ==
X-Gm-Message-State: AJIora/TjwlVQejChfZBtr0IGzpJx+goHA3eWJmRZU6yIF0F0XbiIsfS
        j+w0wouHJfNdxhKpIwT1hnh4vPYMzOR39UKFNzA=
X-Google-Smtp-Source: AGRyM1ta4RBd0ONtq8QNflnRroZoAV44cy8OqHFdH9RJh4eF/N/XNCdvAmuoVybw+bQ6/3sWp0h1jOUFZL7gtsHgnIo=
X-Received: by 2002:a17:907:75ef:b0:72b:2fd:1a92 with SMTP id
 jz15-20020a17090775ef00b0072b02fd1a92mr3893163ejc.745.1659120729378; Fri, 29
 Jul 2022 11:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171836.2852247-1-roberto.sassu@huawei.com> <20220722171836.2852247-4-roberto.sassu@huawei.com>
In-Reply-To: <20220722171836.2852247-4-roberto.sassu@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 29 Jul 2022 11:51:58 -0700
Message-ID: <CAEf4Bzbdu2aMzfTWWCpo2yOF4T8xu3E6fs1nUCKWjfr_4+iqhA@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 03/15] libbpf: Introduce bpf_prog_get_fd_by_id_opts()
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 10:19 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> Define a new data structure called bpf_get_fd_opts, with the member flags,
> to be used by callers of the _opts variants of bpf_*_get_fd_by_id() and
> bpf_obj_get() to specify the permissions needed for the operations on the
> obtained file descriptor.
>
> Define only one data structure for all variants, as the open_flags field in
> bpf_attr for bpf_*_get_fd_by_id_opts() and file_flags for
> bpf_obj_get_opts() have the same meaning. Also, it would avoid the

as I replied elsewhere, bpf_obj_get_opts() is a different bpf()
command, so it makes sense to use a separate opts struct for it

> confusion when the same bpftool function calls both
> bpf_*_get_fd_by_id_opts() and bpf_obj_get_opts() (e.g. map_parse_fds()).
>
> Then, introduce the new feature FEAT_GET_FD_BY_ID_OPEN_FLAGS to determine
> whether or not the kernel supports setting open_flags for
> bpf_*_get_fd_by_id() functions (except for bpf_map_get_fd_by_id(), which
> already can get it). If the feature is not detected, the _opts variants
> ignore flags in the bpf_get_fd_opts structure and leave open_flags to zero.
>
> Finally, introduce bpf_prog_get_fd_by_id_opts(), to let the caller pass the
> newly introduced data structure. Keep the existing bpf_prog_get_fd_by_id(),
> and call bpf_prog_get_fd_by_id_opts() with NULL as opts argument.
>
> Currently, setting permissions in the data structure has no effect, as the
> kernel does not evaluate them. The new variant has been introduced anyway
> for symmetry with bpf_map_get_fd_by_id_opts(). Evaluating permissions could
> be done in future kernel versions.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  tools/lib/bpf/bpf.c             | 37 ++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/bpf.h             | 11 ++++++++++
>  tools/lib/bpf/libbpf.c          |  4 ++++
>  tools/lib/bpf/libbpf.map        |  1 +
>  tools/lib/bpf/libbpf_internal.h |  3 +++
>  5 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 5eb0df90eb2b..9014a61bca83 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -910,18 +910,53 @@ int bpf_link_get_next_id(__u32 start_id, __u32 *next_id)
>         return bpf_obj_get_next_id(start_id, next_id, BPF_LINK_GET_NEXT_ID);
>  }
>
> -int bpf_prog_get_fd_by_id(__u32 id)
> +static int
> +bpf_prog_get_fd_by_id_opts_check(__u32 id, const struct bpf_get_fd_opts *opts,
> +                                bool check_support)
>  {
>         union bpf_attr attr;
>         int fd;
>
> +       if (!OPTS_VALID(opts, bpf_get_fd_opts))
> +               return libbpf_err(-EINVAL);
> +
>         memset(&attr, 0, sizeof(attr));
>         attr.prog_id = id;
> +       if (!check_support ||
> +           kernel_supports(NULL, FEAT_GET_FD_BY_ID_OPEN_FLAGS))
> +               attr.open_flags = OPTS_GET(opts, flags, 0);

low-level APIs from libbpf/bpf.h, as a general rule, don't do such
feature detection and don't ignore user-provided flags just because
kernel doesn't support them. So I think this is wrong approach, just
pass through user flags and user will have to make sure to pass
correct value (potentially just zero, or just pass NULL as opts).

>
>         fd = sys_bpf_fd(BPF_PROG_GET_FD_BY_ID, &attr, sizeof(attr));
>         return libbpf_err_errno(fd);
>  }
>

[...]
