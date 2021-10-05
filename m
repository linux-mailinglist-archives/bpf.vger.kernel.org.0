Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0B42336F
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 00:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhJEWZF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 18:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhJEWZD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 18:25:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEB5F610CA
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 22:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633472592;
        bh=FcJSkIGXJyjjwkrF4ayoUsZ2OP6b7UU3E8urJNCaXBw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PfhSc1sLRF/aSLmuvULKpBmUrIIyvZe6pRtVK6wssUP98HAntDcZZRKIa5IdRmiPR
         yvK8bM/e5X83weBf2p7C5bXZCLKYLXWbVlQj8E0XBneKkyvrP72AswC8I3GhnQHxtz
         x3JO20YMp9PfwYcojjwDZBgJSzz0iv6nmgrdRSbBqpvRQ96GN+W/0XW41VqYCw3fQd
         YyekIO7gzSsKzzGzz6nK2ExGjglTvePuW9B+8v/VbkXBfQ6Og0i/Ec4qrqOO3e0PCv
         gB1z8hHdrInVi2fqz8w9a1GHM6BdRR+x9dhxgvswmSVOUbYs6FX3OjECucv1lITt56
         q4clzFp9j2eCw==
Received: by mail-lf1-f54.google.com with SMTP id n8so2041131lfk.6
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 15:23:12 -0700 (PDT)
X-Gm-Message-State: AOAM531I3P3Sl+iHxzdITzKi/kceudbb/MQnkiFHc5v9bY7ByufsndQy
        4iRwsnqGfd9M7Hp/dmSgpeB19d2dS7SeTSEmmr8=
X-Google-Smtp-Source: ABdhPJzxWZQS/8rLSsqLJNRC2hz/9fODy/nVnmsGLFuaFalaYvoTXbizBc96b8zk2pBuMMy07PbSfapYZ6S5PPduxCI=
X-Received: by 2002:a2e:321a:: with SMTP id y26mr25357899ljy.234.1633472591202;
 Tue, 05 Oct 2021 15:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211003165844.4054931-1-hengqi.chen@gmail.com> <20211003165844.4054931-3-hengqi.chen@gmail.com>
In-Reply-To: <20211003165844.4054931-3-hengqi.chen@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 5 Oct 2021 15:22:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7b7tud2TN891xNC_4O0UZRNDS8tX+Y=cc6mC88jr_rBA@mail.gmail.com>
Message-ID: <CAPhsuW7b7tud2TN891xNC_4O0UZRNDS8tX+Y=cc6mC88jr_rBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2 v2] selftests/bpf: Switch to new
 bpf_object__next_{map,program} APIs
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 3, 2021 at 10:00 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Replace deprecated bpf_{map,program}__next APIs with newly added
> bpf_object__next_{map,program} APIs, so that no compilation warnings
> emit.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/btf.c              | 2 +-
>  tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c    | 6 +++---
>  tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 2 +-
>  tools/testing/selftests/bpf/prog_tests/tcp_rtt.c          | 2 +-
>  tools/testing/selftests/bpf/xdping.c                      | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index 9c85d7d27409..acd33d0cd5d9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -4511,7 +4511,7 @@ static void do_test_file(unsigned int test_num)
>         if (CHECK(err, "obj: %d", err))
>                 return;
>
> -       prog = bpf_program__next(NULL, obj);
> +       prog = bpf_object__next_program(obj, NULL);
>         if (CHECK(!prog, "Cannot find bpf_prog")) {
>                 err = -1;
>                 goto done;
> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> index c7c1816899bf..2839f4270a26 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> @@ -285,7 +285,7 @@ static void test_fmod_ret_freplace(void)
>         if (!ASSERT_OK_PTR(freplace_obj, "freplace_obj_open"))
>                 goto out;
>
> -       prog = bpf_program__next(NULL, freplace_obj);
> +       prog = bpf_object__next_program(freplace_obj, NULL);
>         err = bpf_program__set_attach_target(prog, pkt_fd, NULL);
>         ASSERT_OK(err, "freplace__set_attach_target");
>
> @@ -302,7 +302,7 @@ static void test_fmod_ret_freplace(void)
>                 goto out;
>
>         attach_prog_fd = bpf_program__fd(prog);
> -       prog = bpf_program__next(NULL, fmod_obj);
> +       prog = bpf_object__next_program(fmod_obj, NULL);
>         err = bpf_program__set_attach_target(prog, attach_prog_fd, NULL);
>         ASSERT_OK(err, "fmod_ret_set_attach_target");
>
> @@ -352,7 +352,7 @@ static void test_obj_load_failure_common(const char *obj_file,
>         if (!ASSERT_OK_PTR(obj, "obj_open"))
>                 goto close_prog;
>
> -       prog = bpf_program__next(NULL, obj);
> +       prog = bpf_object__next_program(obj, NULL);
>         err = bpf_program__set_attach_target(prog, pkt_fd, NULL);
>         ASSERT_OK(err, "set_attach_target");
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> index 4efd337d6a3c..d40e9156c48d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> +++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> @@ -114,7 +114,7 @@ static int prepare_bpf_obj(void)
>         err = bpf_object__load(obj);
>         RET_ERR(err, "load bpf_object", "err:%d\n", err);
>
> -       prog = bpf_program__next(NULL, obj);
> +       prog = bpf_object__next_program(obj, NULL);
>         RET_ERR(!prog, "get first bpf_program", "!prog\n");
>         select_by_skb_data_prog = bpf_program__fd(prog);
>         RET_ERR(select_by_skb_data_prog < 0, "get prog fd",
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
> index d207e968e6b1..265b4fe33ec3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
> @@ -109,7 +109,7 @@ static int run_test(int cgroup_fd, int server_fd)
>                 return -1;
>         }
>
> -       map = bpf_map__next(NULL, obj);
> +       map = bpf_object__next_map(obj, NULL);
>         map_fd = bpf_map__fd(map);
>
>         err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
> diff --git a/tools/testing/selftests/bpf/xdping.c b/tools/testing/selftests/bpf/xdping.c
> index 79a3453dab25..30f12637f4e4 100644
> --- a/tools/testing/selftests/bpf/xdping.c
> +++ b/tools/testing/selftests/bpf/xdping.c
> @@ -187,7 +187,7 @@ int main(int argc, char **argv)
>                 return 1;
>         }
>
> -       map = bpf_map__next(NULL, obj);
> +       map = bpf_object__next_map(obj, NULL);
>         if (map)
>                 map_fd = bpf_map__fd(map);
>         if (!map || map_fd < 0) {
> --
> 2.25.1
