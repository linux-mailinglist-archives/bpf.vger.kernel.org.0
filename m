Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1791B2577D5
	for <lists+bpf@lfdr.de>; Mon, 31 Aug 2020 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgHaK6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Aug 2020 06:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgHaK6i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Aug 2020 06:58:38 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9E3C061573
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2020 03:58:37 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z17so3218720lfi.12
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2020 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=IMcYBprP0b9U7wZJdjxxz1C2zPDmUF1GEZ569s+5iUQ=;
        b=trxflmQN/OVDL0Nd0KDoqPXvmtGCoPT7JuT8LW+V0W5ZsJ5SDBti2nBgUgG3gvu7it
         wWf0+Enny1gpcUggSZEG5fS6dDGHpqHUiaBZeni+4BvY5Igj8jeQG83C/3kgBANJ+8m7
         xvlgHD+2pJXPrgoO+rrMrHrr+M4jKsVjzOps4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=IMcYBprP0b9U7wZJdjxxz1C2zPDmUF1GEZ569s+5iUQ=;
        b=C7JFxNH/gVCiufrRBDvZ5TNpd6KX6tGZXNYKIUN1bvlqtKtC53rz+Zih67+Bf0pEqS
         NGtGFX3bNA2CXBXCOfInAKKy3V6z3LP8PhErviRYTxlDaidG1+zHfCwHxrjP5WVhpHoW
         EHHe+rEs/kos611U0X6BDR8nbhEKaXcX52X01doZMDd4S3Aav73/jeKG1PZ0DVvGLevl
         f63L4gzOxOww0S9lGw4nWHQqZfZdU0BP7iB6EkUyhzChg9y0eZOj59PFzFVVm9BM0MKJ
         foYXU+NnSMVAFP3m/9F+XsFJsuy+0mQJz5bxCAS4EjaulQg2X/jPmP/OKrdkMg1pzmIV
         T16g==
X-Gm-Message-State: AOAM5334DZHWgpOF0bBkWroLhUwsORl/YJCm8SeY4A1kMgewGzeeZolP
        WvG9rYq6fdsmzTHaL6IK88DomA==
X-Google-Smtp-Source: ABdhPJyXru83n7PyM8J4ijHtwm06G3sR70e6EXcOl2kRzYN7daF2vNRQVdKxHgbYdFQuLwCbTcD1jA==
X-Received: by 2002:a19:818a:: with SMTP id c132mr452710lfd.76.1598871516235;
        Mon, 31 Aug 2020 03:58:36 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id i16sm1497632ljn.100.2020.08.31.03.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:58:35 -0700 (PDT)
References: <20200828094834.23290-1-lmb@cloudflare.com> <20200828094834.23290-4-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        john.fastabend@gmail.com, bpf@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 3/3] selftests: bpf: Test copying a sockmap via bpf_iter
In-reply-to: <20200828094834.23290-4-lmb@cloudflare.com>
Date:   Mon, 31 Aug 2020 12:58:34 +0200
Message-ID: <87d037rsit.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 28, 2020 at 11:48 AM CEST, Lorenz Bauer wrote:
> Add a test that exercises a basic sockmap / sockhash copy using bpf_iter.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 78 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/bpf_iter.h  |  9 +++
>  .../selftests/bpf/progs/bpf_iter_sockmap.c    | 50 ++++++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index b989f8760f1a..386aecf1f7ff 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -6,6 +6,7 @@
>  #include "test_skmsg_load_helpers.skel.h"
>  #include "test_sockmap_update.skel.h"
>  #include "test_sockmap_invalid_update.skel.h"
> +#include "bpf_iter_sockmap.skel.h"
>
>  #define TCP_REPAIR		19	/* TCP sock is under repair right now */
>
> @@ -194,6 +195,79 @@ static void test_sockmap_invalid_update(void)
>  		test_sockmap_invalid_update__destroy(skel);
>  }
>
> +static void test_sockmap_copy(enum bpf_map_type map_type)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	int err, i, len, src_fd, iter_fd, num_sockets, duration;
> +	struct bpf_iter_sockmap *skel;
> +	struct bpf_map *src, *dst;
> +	union bpf_iter_link_info linfo = {0};
> +	__s64 sock_fd[2] = {-1, -1};

With just two sockets and sockhash max_entries set to 3 (which means 4
buckets), we're likely not exercising walking the bucket chain in the
iterator code.

How about a more generous value?

> +	struct bpf_link *link;
> +	char buf[64];
> +	__u32 max_elems;
> +
> +	skel = bpf_iter_sockmap__open_and_load();
> +	if (CHECK(!skel, "bpf_iter_sockmap__open_and_load",
> +		  "skeleton open_and_load failed\n"))
> +		return;
> +
> +	if (map_type == BPF_MAP_TYPE_SOCKMAP)
> +		src = skel->maps.sockmap;
> +	else
> +		src = skel->maps.sockhash;
> +
> +	dst = skel->maps.dst;
> +	src_fd = bpf_map__fd(src);
> +	max_elems = bpf_map__max_entries(src);
> +
> +	num_sockets = ARRAY_SIZE(sock_fd);
> +	for (i = 0; i < num_sockets; i++) {
> +		sock_fd[i] = connected_socket_v4();
> +		if (CHECK(sock_fd[i] == -1, "connected_socket_v4", "cannot connect\n"))
> +			goto out;
> +
> +		err = bpf_map_update_elem(src_fd, &i, &sock_fd[i], BPF_NOEXIST);
> +		if (CHECK(err, "map_update", "map_update failed\n"))

Nit: No need to repeat what failed in the message when the tag already
says it. In this case the message will look like:

test_sockmap_copy:FAIL:map_update map_update failed

What would be useful is to include the errno in the message. CHECK()
doesn't print it by default.

> +			goto out;
> +	}
> +
> +	linfo.map.map_fd = src_fd;
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +	link = bpf_program__attach_iter(skel->progs.copy_sockmap, &opts);
> +	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
> +		goto out;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
> +		goto free_link;
> +
> +	/* do some tests */
> +	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
> +		;
> +	if (CHECK(len < 0, "read", "failed: %s\n", strerror(errno)))
> +		goto close_iter;
> +
> +	/* test results */
> +	if (CHECK(skel->bss->elems != max_elems, "elems", "got %u expected %u\n",
> +		  skel->bss->elems, max_elems))
> +		goto close_iter;
> +
> +	compare_cookies(src, dst);
> +
> +close_iter:
> +	close(iter_fd);
> +free_link:
> +	bpf_link__destroy(link);
> +out:
> +	for (i = 0; i < num_sockets; i++) {
> +		if (sock_fd[i] >= 0)
> +			close(sock_fd[i]);
> +	}
> +	bpf_iter_sockmap__destroy(skel);
> +}
> +
>  void test_sockmap_basic(void)
>  {
>  	if (test__start_subtest("sockmap create_update_free"))
> @@ -210,4 +284,8 @@ void test_sockmap_basic(void)
>  		test_sockmap_update(BPF_MAP_TYPE_SOCKHASH);
>  	if (test__start_subtest("sockmap update in unsafe context"))
>  		test_sockmap_invalid_update();
> +	if (test__start_subtest("sockmap copy"))
> +		test_sockmap_copy(BPF_MAP_TYPE_SOCKMAP);
> +	if (test__start_subtest("sockhash copy"))
> +		test_sockmap_copy(BPF_MAP_TYPE_SOCKHASH);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
> index c196280df90d..ac32a29f5153 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
> @@ -13,6 +13,7 @@
>  #define udp6_sock udp6_sock___not_used
>  #define bpf_iter__bpf_map_elem bpf_iter__bpf_map_elem___not_used
>  #define bpf_iter__bpf_sk_storage_map bpf_iter__bpf_sk_storage_map___not_used
> +#define bpf_iter__sockmap bpf_iter__sockmap___not_used
>  #include "vmlinux.h"
>  #undef bpf_iter_meta
>  #undef bpf_iter__bpf_map
> @@ -26,6 +27,7 @@
>  #undef udp6_sock
>  #undef bpf_iter__bpf_map_elem
>  #undef bpf_iter__bpf_sk_storage_map
> +#undef bpf_iter__sockmap
>
>  struct bpf_iter_meta {
>  	struct seq_file *seq;
> @@ -96,3 +98,10 @@ struct bpf_iter__bpf_sk_storage_map {
>  	struct sock *sk;
>  	void *value;
>  };
> +
> +struct bpf_iter__sockmap {
> +	struct bpf_iter_meta *meta;
> +	struct bpf_map *map;
> +	void *key;
> +	struct bpf_sock *sk;
> +};
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
> new file mode 100644
> index 000000000000..1b4268c9cd31
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020 Cloudflare */
> +#include "bpf_iter.h"
> +#include "bpf_tracing_net.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> +	__uint(max_entries, 3);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} sockmap SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> +	__uint(max_entries, 3);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} sockhash SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SOCKHASH);
> +	__uint(max_entries, 3);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} dst SEC(".maps");
> +
> +__u32 elems = 0;
> +
> +SEC("iter/sockmap")
> +int copy_sockmap(struct bpf_iter__sockmap *ctx)
> +{
> +	__u32 tmp, *key = ctx->key;
> +	struct bpf_sock *sk = ctx->sk;
> +
> +	if (key == (void *)0)
> +		return 0;
> +
> +	elems++;
> +	tmp = *key;

Is the tmp variable needed? We never inspect its value directly.
Or it illustrates that they key can be modified on copy?

> +
> +	if (sk != (void *)0)
> +		return bpf_map_update_elem(&dst, &tmp, sk, 0) != 0;
> +
> +	bpf_map_delete_elem(&dst, &tmp);

map_delete_elem in theory can fail too. Not sure why were ignoring the
error here.

> +	return 0;
> +}
