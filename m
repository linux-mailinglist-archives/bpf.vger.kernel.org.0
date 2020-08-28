Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF732558E4
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 12:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgH1KvC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 06:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgH1Ku5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 06:50:57 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B304C061264
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 03:50:57 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c10so744549edk.6
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=AM36sQ8gAVpI6qcpo4FYVsE/pOL8+2DwHlhq7BZByD8=;
        b=HbbxwTckLNmYZOYsTzzcP4cgXuo6tR/8EiBivQZHTzVK/ztCeEEmrkj/1fxldyP8nh
         VVC/qlSd1aWKK+Zp3AAqeBappV3aU615yT8Z2fx8iVYcDmQnVYlwSixVmhWmfp56ar08
         Pi+1JARxUz+b5HwvzH9xMmuJe+6sYZXwRGcFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=AM36sQ8gAVpI6qcpo4FYVsE/pOL8+2DwHlhq7BZByD8=;
        b=Dl5Qlyzjicg16itRo0tBBg14z4tSH0B0CVOxRe4LT7n8edtNo8b/PoES8TCqnzRMCR
         nZgykmF0zFeBKFEL91CJuLjSAxQuuql+rtfv+m7zf5UnEZ6MWAXjmmLxX66unWZh1wCs
         BKLd0SwHKS1S5TG7eq7BTtU3740vxI8sdNbqcxW5MBH7ktynEb3D4glRYhO+DzkP9WpV
         Jh7EocOI9Rrut6u+AWGk2cM5xfKY5OzfCPwC7JZ5eaZNAI6yfZmyTkB3YBmJaI3AlEe8
         PKTY+qEqqCSI7lIgjnvJ+Qi1y0C9tDUtcv7VsyGdnQZ4dgQIaQY704BFhgaGk2kBXcHu
         nR6A==
X-Gm-Message-State: AOAM531VyvETxEV67NjRn15jRxkagMfi0mkUA/vpsfVyrC8M1kWJ7wHa
        wiyfVk4H75Jd3Qwam0bqazXmkw==
X-Google-Smtp-Source: ABdhPJyXXMObWzVA4AM0pvx7/hzAZBHSQ4VuB58FyZSi0XP84lse2SHTEOaFmW/+4M7yhc+ML4QCoA==
X-Received: by 2002:a05:6402:6d9:: with SMTP id n25mr1185016edy.149.1598611855825;
        Fri, 28 Aug 2020 03:50:55 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id ar21sm592082ejc.8.2020.08.28.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:50:55 -0700 (PDT)
References: <20200828094834.23290-1-lmb@cloudflare.com> <20200828094834.23290-3-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        john.fastabend@gmail.com, bpf@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 2/3] selftests: bpf: Add helper to compare socket cookies
In-reply-to: <20200828094834.23290-3-lmb@cloudflare.com>
Date:   Fri, 28 Aug 2020 12:50:54 +0200
Message-ID: <87h7snrqlt.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 28, 2020 at 11:48 AM CEST, Lorenz Bauer wrote:
> We compare socket cookies to ensure that insertion into a sockmap worked.
> Pull this out into a helper function for use in other tests.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 51 ++++++++++++++-----
>  1 file changed, 37 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 0b79d78b98db..b989f8760f1a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -47,6 +47,38 @@ static int connected_socket_v4(void)
>  	return -1;
>  }
>  
> +static void compare_cookies(struct bpf_map *src, struct bpf_map *dst)
> +{
> +	__u32 i, max_entries = bpf_map__max_entries(src);
> +	int err, duration, src_fd, dst_fd;
> +
> +	src_fd = bpf_map__fd(src);
> +	dst_fd = bpf_map__fd(src);
                             ^^^
That looks like a typo. We're comparing src map to src map.

> +
> +	for (i = 0; i < max_entries; i++) {
> +		__u64 src_cookie, dst_cookie;
> +
> +		err = bpf_map_lookup_elem(src_fd, &i, &src_cookie);
> +		if (err && errno == ENOENT) {
> +			err = bpf_map_lookup_elem(dst_fd, &i, &dst_cookie);
> +			if (err && errno == ENOENT)
> +				continue;
> +
> +			CHECK(err, "map_lookup_elem(dst)", "element not deleted\n");
> +			continue;
> +		}
> +		if (CHECK(err, "lookup_elem(src, cookie)", "%s\n", strerror(errno)))
> +			continue;
> +
> +		err = bpf_map_lookup_elem(dst_fd, &i, &dst_cookie);
> +		if (CHECK(err, "lookup_elem(dst, cookie)", "%s\n", strerror(errno)))
> +			continue;
> +
> +		CHECK(dst_cookie != src_cookie, "cookie mismatch",
> +		      "%llu != %llu (pos %u)\n", dst_cookie, src_cookie, i);
> +	}
> +}
> +
>  /* Create a map, populate it with one socket, and free the map. */
>  static void test_sockmap_create_update_free(enum bpf_map_type map_type)
>  {
> @@ -106,9 +138,9 @@ static void test_skmsg_helpers(enum bpf_map_type map_type)
>  static void test_sockmap_update(enum bpf_map_type map_type)
>  {
>  	struct bpf_prog_test_run_attr tattr;
> -	int err, prog, src, dst, duration = 0;
> +	int err, prog, src, duration = 0;
>  	struct test_sockmap_update *skel;
> -	__u64 src_cookie, dst_cookie;
> +	struct bpf_map *dst_map;
>  	const __u32 zero = 0;
>  	char dummy[14] = {0};
>  	__s64 sk;
> @@ -124,18 +156,14 @@ static void test_sockmap_update(enum bpf_map_type map_type)
>  	prog = bpf_program__fd(skel->progs.copy_sock_map);
>  	src = bpf_map__fd(skel->maps.src);
>  	if (map_type == BPF_MAP_TYPE_SOCKMAP)
> -		dst = bpf_map__fd(skel->maps.dst_sock_map);
> +		dst_map = skel->maps.dst_sock_map;
>  	else
> -		dst = bpf_map__fd(skel->maps.dst_sock_hash);
> +		dst_map = skel->maps.dst_sock_hash;
>  
>  	err = bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
>  	if (CHECK(err, "update_elem(src)", "errno=%u\n", errno))
>  		goto out;
>  
> -	err = bpf_map_lookup_elem(src, &zero, &src_cookie);
> -	if (CHECK(err, "lookup_elem(src, cookie)", "errno=%u\n", errno))
> -		goto out;
> -
>  	tattr = (struct bpf_prog_test_run_attr){
>  		.prog_fd = prog,
>  		.repeat = 1,
> @@ -148,12 +176,7 @@ static void test_sockmap_update(enum bpf_map_type map_type)
>  		       "errno=%u retval=%u\n", errno, tattr.retval))
>  		goto out;
>  
> -	err = bpf_map_lookup_elem(dst, &zero, &dst_cookie);
> -	if (CHECK(err, "lookup_elem(dst, cookie)", "errno=%u\n", errno))
> -		goto out;
> -
> -	CHECK(dst_cookie != src_cookie, "cookie mismatch", "%llu != %llu\n",
> -	      dst_cookie, src_cookie);
> +	compare_cookies(skel->maps.src, dst_map);
>  
>  out:
>  	test_sockmap_update__destroy(skel);

