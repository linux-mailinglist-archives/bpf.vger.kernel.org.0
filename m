Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1727485C66
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 00:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245493AbiAEXom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 18:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245492AbiAEXog (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 18:44:36 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B669C061245
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 15:44:36 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id u8so1067460iol.5
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 15:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwJbPh5sbmudTzcApQn9X86LFA/PBXlnMKO0rcxsPU0=;
        b=MNhWyhHn1yHjBRgdJnn/vDJQEBeU4TqwQvn6rjo+qolzKnoxU9SNbFFVWi173C2IJz
         WvVoRGdGGmeJ5ZPn8iSXFj70rfZXwum1dJwQ7JvBHc8v6839UL64/PiyAb730h49d4XD
         Zpn6IF5/Zfm39evN8kPb6CBf6vy2RSgOxPlGmNNpSxrEzV/uKmQ8nWuI88C/GqMDyA8g
         NWK7BDPsh5m6+Zis/Ok58FE2TnXESLiBv6U5TYNBwDZsj+A3gWZX8lffrd8GLzVlUJQ0
         4pkdwETRQNgHZMKgt/H+nbTqNO22V5wkvO1GXVw46hf6iF3p2ge0kVBIlBURmiDQkdzQ
         jijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwJbPh5sbmudTzcApQn9X86LFA/PBXlnMKO0rcxsPU0=;
        b=2rIObR0VfWrYOWHS1zvG9X1AS9RSe+UrmNoAk+bZ0ZjW0+3hAJ3huQY771Rl1IZ8/z
         OToQIpzhyDWSweRz7amtJ9PY66skbQCOqSfEztpIfuJ1n3OOMrNKgSzxk8zyl4UbStMg
         7Oxu05/27lWV2TTKvXP2YZvVIZYgT8ZCwXuG9ROejy5Xf/dIWMjPCAcRNDnSxINM2JMK
         m1Mf4pQllvACZNEoQ9IVvFemIxm6iXKlMNwKDHr+qR0+wQT2EjtX3CgK33u3ZbT6lMNf
         aAq6I8oPdObEZ999Pj3NFAFklReozVblyLm5Sz55N9Aa3JuuLjKhfnhPST7vPmGCXCfB
         WONA==
X-Gm-Message-State: AOAM533ZRW/UQFMDjystzymaqiAEFv/IF9l1QWDbngHhe6PX62Kr7aL8
        4pueOz7ZXck7B8cHXt6RjDjjUUHjYjVx89JV56E=
X-Google-Smtp-Source: ABdhPJzZBAKC119RSZJ8+d3QRAwXfyfgbIK2uvA1xs1Nxo5VD4NO78pLKurg/YBudMWVQtN5CSC/tsy0bSaw/aupIgA=
X-Received: by 2002:a05:6638:1193:: with SMTP id f19mr26978255jas.237.1641426275182;
 Wed, 05 Jan 2022 15:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20211230000110.1068538-1-christylee@fb.com>
In-Reply-To: <20211230000110.1068538-1-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jan 2022 15:44:23 -0800
Message-ID: <CAEf4BzYicMqdsEN72gqO7OHM3gPx1VVvB0gb_jH1+S_enLAUeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: rename bpf_prog_attach_xattr to bpf_prog_attach_opts
To:     Christy Lee <christylee@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 29, 2021 at 4:01 PM Christy Lee <christylee@fb.com> wrote:
>
> All xattr APIs are being dropped, let's converge to the convention used in
> high-level APIs and rename bpf_prog_attach_xattr to bpf_prog_attach_opts.
>
> [0] Closes: https://github.com/libbpf/libbpf/issues/285

nit: please add two spaces in front of [0]

>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---
>  tools/lib/bpf/bpf.c                                  | 11 +++++++++--
>  tools/lib/bpf/bpf.h                                  |  4 ++++
>  tools/lib/bpf/libbpf.map                             |  1 +
>  .../selftests/bpf/prog_tests/cgroup_attach_multi.c   | 12 ++++++------
>  4 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9b64eed2b003..19741cfcaf11 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -754,10 +754,10 @@ int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
>                 .flags = flags,
>         );
>
> -       return bpf_prog_attach_xattr(prog_fd, target_fd, type, &opts);
> +       return bpf_prog_attach_opts(prog_fd, target_fd, type, &opts);
>  }
>
> -int bpf_prog_attach_xattr(int prog_fd, int target_fd,
> +int bpf_prog_attach_opts(int prog_fd, int target_fd,
>                           enum bpf_attach_type type,
>                           const struct bpf_prog_attach_opts *opts)
>  {
> @@ -778,6 +778,13 @@ int bpf_prog_attach_xattr(int prog_fd, int target_fd,
>         return libbpf_err_errno(ret);
>  }
>
> +int bpf_prog_attach_xattr(int prog_fd, int target_fd,
> +                         enum bpf_attach_type type,
> +                         const struct bpf_prog_attach_opts *opts)
> +{
> +       return bpf_prog_attach_opts(prog_fd, target_fd, type, opts);
> +}

let's use alias instead

> +
>  int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
>  {
>         union bpf_attr attr;
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 00619f64a040..5dc9fefe73f3 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -280,6 +280,10 @@ struct bpf_prog_attach_opts {
>
>  LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
>                                enum bpf_attach_type type, unsigned int flags);
> +LIBBPF_API int bpf_prog_attach_opts(int prog_fd, int attachable_fd,
> +                                    enum bpf_attach_type type,
> +                                    const struct bpf_prog_attach_opts *opts);
> +LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_prog_attach_opts() instead")
>  LIBBPF_API int bpf_prog_attach_xattr(int prog_fd, int attachable_fd,
>                                      enum bpf_attach_type type,
>                                      const struct bpf_prog_attach_opts *opts);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 529783967793..be2bb69d1a12 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -246,6 +246,7 @@ LIBBPF_0.0.8 {
>                 bpf_link__update_program;
>                 bpf_link_create;
>                 bpf_link_update;
> +               bpf_prog_attach_opts;

keep the list sorted

>                 bpf_map__set_initial_value;
>                 bpf_program__attach_cgroup;
>                 bpf_program__attach_lsm;
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> index d3e8f729c623..38b3c47293da 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> @@ -194,14 +194,14 @@ void serial_test_cgroup_attach_multi(void)
>
>         attach_opts.flags = BPF_F_ALLOW_OVERRIDE | BPF_F_REPLACE;
>         attach_opts.replace_prog_fd = allow_prog[0];
> -       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> +       if (CHECK(!bpf_prog_attach_opts(allow_prog[6], cg1,
>                                          BPF_CGROUP_INET_EGRESS, &attach_opts),
>                   "fail_prog_replace_override", "unexpected success\n"))
>                 goto err;
>         CHECK_FAIL(errno != EINVAL);
>
>         attach_opts.flags = BPF_F_REPLACE;
> -       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> +       if (CHECK(!bpf_prog_attach_opts(allow_prog[6], cg1,
>                                          BPF_CGROUP_INET_EGRESS, &attach_opts),
>                   "fail_prog_replace_no_multi", "unexpected success\n"))
>                 goto err;
> @@ -209,7 +209,7 @@ void serial_test_cgroup_attach_multi(void)
>
>         attach_opts.flags = BPF_F_ALLOW_MULTI | BPF_F_REPLACE;
>         attach_opts.replace_prog_fd = -1;
> -       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> +       if (CHECK(!bpf_prog_attach_opts(allow_prog[6], cg1,
>                                          BPF_CGROUP_INET_EGRESS, &attach_opts),
>                   "fail_prog_replace_bad_fd", "unexpected success\n"))
>                 goto err;
> @@ -217,7 +217,7 @@ void serial_test_cgroup_attach_multi(void)
>
>         /* replacing a program that is not attached to cgroup should fail  */
>         attach_opts.replace_prog_fd = allow_prog[3];
> -       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> +       if (CHECK(!bpf_prog_attach_opts(allow_prog[6], cg1,
>                                          BPF_CGROUP_INET_EGRESS, &attach_opts),
>                   "fail_prog_replace_no_ent", "unexpected success\n"))
>                 goto err;
> @@ -225,14 +225,14 @@ void serial_test_cgroup_attach_multi(void)
>
>         /* replace 1st from the top program */
>         attach_opts.replace_prog_fd = allow_prog[0];
> -       if (CHECK(bpf_prog_attach_xattr(allow_prog[6], cg1,
> +       if (CHECK(bpf_prog_attach_opts(allow_prog[6], cg1,
>                                         BPF_CGROUP_INET_EGRESS, &attach_opts),
>                   "prog_replace", "errno=%d\n", errno))
>                 goto err;
>
>         /* replace program with itself */
>         attach_opts.replace_prog_fd = allow_prog[6];
> -       if (CHECK(bpf_prog_attach_xattr(allow_prog[6], cg1,
> +       if (CHECK(bpf_prog_attach_opts(allow_prog[6], cg1,
>                                         BPF_CGROUP_INET_EGRESS, &attach_opts),
>                   "prog_replace", "errno=%d\n", errno))
>                 goto err;

please split out selftests changes into a separate patch, doing this
after libbpf change doesn't break the build nor generates compilation
warnings (because deprecation is deferred), so it's ok to have it in a
separate patch

> --
> 2.30.2
>
