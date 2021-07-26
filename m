Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9540A3D69CF
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 00:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhGZWJZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 18:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhGZWJY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 18:09:24 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5411BC061757
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 15:49:52 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id x192so17573685ybe.0
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 15:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=En4cdfSQAaaiPItfg3Kc9yjWGHLCniATF74AUkHAIf8=;
        b=rXml6LrGneLAj0vFNEsfSLLg593BlgH3jJrg2CnIcGOnJDbW5TA7C8WoV4KIU5zgWg
         5wNedPz6Z7VF2depmyPhbRY+QDOIud7VkPAhb36WjBeEDwMRU79gOWdmtJN3i8bA/pFR
         Ku1fc0ewcs6UMDxfXweY0n3DUAtJZp/ZFkSAkQBxYVQn6wGU6xUwjUz2gJw5q1pq3dx0
         bgPvtTMPD+4SfyWx/nmR7O0UXhjHRJJvBOwO6vwtoOjPC39UkfT0Lo3P39P6SGsEKSKH
         Dku69tTPprqmUfiY5izzJwkP+RnbBz8hnzCrrsi/ddlZRPANJb2XGuGONw3WLw2AohNR
         8MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=En4cdfSQAaaiPItfg3Kc9yjWGHLCniATF74AUkHAIf8=;
        b=h5Xthz5WptwJI4+YPJv07DxjEVoMliy4kqI7ZOMBJ5H7vwNrCtyuxGMPi0gdMbCWqd
         Azh507xyoTc7fvDLKJ0suZ6MV1dX3DGbDmRAXwfAHBNzIqSXK5DRwoJHWft/fFxaeE8t
         jAm+s9r7QzwNO8p2b2QICLtD1liZpifXSrio7ybkDJqOZN59dQaL/9fe5C2ngA264Spx
         banurDOPl7TU7h2b5HU6rs34Q3+yWi3wI81L4vgz4bN7Nux7H0jwSlrjNeU9fCNdU2yM
         SIvBRlQER9EuN7zhwpu2mQcm2vU29EI2n6Yi+g7f9iS56G8bGa01leFFVj4tLs0+DSkz
         +7yA==
X-Gm-Message-State: AOAM531D/VwrVQVgetBr0Vw+4fm/m19LHNDJUxPUNhXMa7c9XiS0UZze
        HUK/VjnymHbD8/6KApx9TkgJR68SuqhkHtloiAo=
X-Google-Smtp-Source: ABdhPJyYpDBI0tAHKSx9qbayeZ4Kh7VCV6WFcBjvF8qFopW2cPjaxhYAQdaMB7wcugFFFqi8W3iAncAqQ1tRtX+iQzk=
X-Received: by 2002:a25:cdc7:: with SMTP id d190mr26466696ybf.425.1627339791520;
 Mon, 26 Jul 2021 15:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210724051256.1629110-1-hengqi.chen@gmail.com>
In-Reply-To: <20210724051256.1629110-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 26 Jul 2021 15:49:40 -0700
Message-ID: <CAEf4BzaZEny+3iu6ZGqAaY8QGE27TJoky=pzMcyg934_cJ3QTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add libbpf_load_vmlinux_btf/libbpf_load_module_btf
 APIs
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 23, 2021 at 10:13 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add libbpf_load_vmlinux_btf/libbpf_load_module_btf APIs.
> This is part of the libbpf v1.0. [1]
>
> [1] https://github.com/libbpf/libbpf/issues/280

Saying it's part of libbpf 1.0 effort and given a link to Github PR is
not really a sufficient commit message. Please expand on what you are
doing in the patch and why.

>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/btf.c      | 24 +++++++++++++++++++++++-
>  tools/lib/bpf/btf.h      |  2 ++
>  tools/lib/bpf/libbpf.c   |  8 ++++----
>  tools/lib/bpf/libbpf.map |  2 ++
>  4 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b46760b93bb4..414e1c5635ef 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4021,7 +4021,7 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
>                  */
>                 if (d->hypot_adjust_canon)
>                         continue;
> -
> +
>                 if (t_kind == BTF_KIND_FWD && c_kind != BTF_KIND_FWD)
>                         d->map[t_id] = c_id;
>
> @@ -4395,6 +4395,11 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
>   * data out of it to use for target BTF.
>   */
>  struct btf *libbpf_find_kernel_btf(void)
> +{
> +       return libbpf_load_vmlinux_btf();
> +}
> +
> +struct btf *libbpf_load_vmlinux_btf(void)
>  {
>         struct {
>                 const char *path_fmt;
> @@ -4440,6 +4445,23 @@ struct btf *libbpf_find_kernel_btf(void)
>         return libbpf_err_ptr(-ESRCH);
>  }
>
> +struct btf *libbpf_load_module_btf(const char *mod)

So we probably need to allow user to pre-load and re-use vmlinux BTF
for efficiency, especially if they have some use-case to load a lot of
BTFs.

> +{
> +       char path[80];
> +       struct btf *base;
> +       int err;
> +
> +       base = libbpf_load_vmlinux_btf();
> +       err = libbpf_get_error(base);
> +       if (err) {
> +               pr_warn("Error loading vmlinux BTF: %d\n", err);
> +               return base;

libbpf_err_ptr() needs to be used here, pr_warn() could have destroyed
errno already

> +       }
> +
> +       snprintf(path, sizeof(path), "/sys/kernel/btf/%s", mod);
> +       return btf__parse_split(path, base);

so who's freeing base BTF in this case?

> +}
> +
>  int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx)
>  {
>         int i, n, err;

[...]
