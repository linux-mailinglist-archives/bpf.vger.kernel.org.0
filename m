Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D0423853
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 08:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbhJFGv1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 02:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhJFGv1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 02:51:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D54C061749
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 23:49:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m3so6159743lfu.2
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 23:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=bJ6SvdyRwRKdysAyT2fbVJrSRKhX7W6R6xrV3Dn2W+o=;
        b=BIj6vJm28lgQPSrEcBmpFho5A3x/q3WoxefUEizG72sj8cvXP/1dHjVqD4KA65sDsG
         b21wrycFFBeCEqyN+HSbiFNBatA2mn6WuuhnIiqlv4ltkyg3/tT4plpyFUtfC00MTwG9
         G+qbeOBjhXmMLlUi5DJyybhXx2WAwMxoTDpr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=bJ6SvdyRwRKdysAyT2fbVJrSRKhX7W6R6xrV3Dn2W+o=;
        b=eTviPG7a4+o48+qTHi9KE+N56Zzp6XBenhp9r3OAm8xsRfmBEhGAlKt5eBtpC7Rob9
         TNb8QZaVLXsHXCYnhIAQrsOuo5c85KUFy2Tx2q1xpcYkEzOde2B8aeNutbZrAVM9HZIA
         xgaq22haB7d6BjSIankXvaD8c1NaL/DFEkLdUKQUCVD/ZLuqyD3D+iLw7mtC8SdxdJcv
         Z1MKJn2jIVEFtMD/IuzevBLk9AI/HS20Zv1ZvnRKMTyYvM7sDi6XgCusEdwLl1Hy4cDB
         Deno0ZSSslYYsW2drCZn63nXbqPsBEA8Qgtuvw8FwePpaKnIc7Wh6vx0g4aB5MfgvNJU
         k2kA==
X-Gm-Message-State: AOAM530utZPiY/mGm85/SVNQlsn9Q257t8EskFbXrcgoOr1qukz0Cif5
        z+mWSEg7ec3bGdO6aekslwsY7g==
X-Google-Smtp-Source: ABdhPJymPB1JcFfM++3OidjIDJx0Co/Ywo/VQNYopO3fCtoVEBt8CoPmkozXr0xvSScc15JHge4/+g==
X-Received: by 2002:a05:6512:158a:: with SMTP id bp10mr7908302lfb.122.1633502973225;
        Tue, 05 Oct 2021 23:49:33 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:480d:6f00:ff34:bf12:ef2:5071])
        by smtp.gmail.com with ESMTPSA id j15sm2177637lfp.181.2021.10.05.23.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 23:49:32 -0700 (PDT)
References: <20211006002853.308945-1-memxor@gmail.com>
 <20211006002853.308945-6-memxor@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 5/6] bpf: selftests: Fix fd cleanup in
 sk_lookup test
In-reply-to: <20211006002853.308945-6-memxor@gmail.com>
Date:   Wed, 06 Oct 2021 08:49:32 +0200
Message-ID: <87zgrmfy0z.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 06, 2021 at 02:28 AM CEST, Kumar Kartikeya Dwivedi wrote:
> Similar to the fix in commit:
> e31eec77e4ab (bpf: selftests: Fix fd cleanup in get_branch_snapshot)
>
> We use memset to set fds to -1 without breaking on future changes to
> the array size (when MAX_SERVER constant is bumped).
>
> The particular close(0) occurs on non-reuseport tests, so it can be seen
> with -n 115/{2,3} but not 115/4. This can cause problems with future
> tests if they depend on BTF fd never being acquired as fd 0, breaking
> internal libbpf assumptions.
>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Fixes: 0ab5539f8584 (selftests/bpf: Tests for BPF_SK_LOOKUP attach point)
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/sk_lookup.c      | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> index aee41547e7f4..572220065bdf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> @@ -598,11 +598,14 @@ static void query_lookup_prog(struct test_sk_lookup *skel)
>
>  static void run_lookup_prog(const struct test *t)
>  {
> -	int server_fds[MAX_SERVERS] = { -1 };
>  	int client_fd, reuse_conn_fd = -1;
>  	struct bpf_link *lookup_link;
> +	int server_fds[MAX_SERVERS];
>  	int i, err;
>
> +	/* set all fds to -1 */
> +	memset(server_fds, 0xFF, sizeof(server_fds));
> +
>  	lookup_link = attach_lookup_prog(t->lookup_prog);
>  	if (!lookup_link)
>  		return;
> @@ -663,8 +666,9 @@ static void run_lookup_prog(const struct test *t)
>  	if (reuse_conn_fd != -1)
>  		close(reuse_conn_fd);
>  	for (i = 0; i < ARRAY_SIZE(server_fds); i++) {
> -		if (server_fds[i] != -1)
> -			close(server_fds[i]);
> +		if (server_fds[i] == -1)
> +			break;
> +		close(server_fds[i]);
>  	}
>  	bpf_link__destroy(lookup_link);
>  }
> @@ -1053,11 +1057,14 @@ static void run_sk_assign(struct test_sk_lookup *skel,
>  			  struct bpf_program *lookup_prog,
>  			  const char *remote_ip, const char *local_ip)
>  {
> -	int server_fds[MAX_SERVERS] = { -1 };
> +	int server_fds[MAX_SERVERS];
>  	struct bpf_sk_lookup ctx;
>  	__u64 server_cookie;
>  	int i, err;
>
> +	/* set all fds to -1 */
> +	memset(server_fds, 0xFF, sizeof(server_fds));
> +
>  	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
>  		.ctx_in = &ctx,
>  		.ctx_size_in = sizeof(ctx),
> @@ -1097,8 +1104,9 @@ static void run_sk_assign(struct test_sk_lookup *skel,
>
>  close_servers:
>  	for (i = 0; i < ARRAY_SIZE(server_fds); i++) {
> -		if (server_fds[i] != -1)
> -			close(server_fds[i]);
> +		if (server_fds[i] == -1)
> +			break;
> +		close(server_fds[i]);
>  	}
>  }

My mistake. Thanks for the fix.

Alternatively we can use an extended designated initializer:

int server_fds[] = { [0 ... MAX_SERVERS] = -1 };

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
