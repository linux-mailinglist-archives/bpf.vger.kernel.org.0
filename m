Return-Path: <bpf+bounces-7843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC877D4AE
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 22:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B3F281623
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B51B18B0D;
	Tue, 15 Aug 2023 20:58:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D802917FEA
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 20:58:00 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A8CB9
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 13:57:58 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56463e0340cso8922283a12.2
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692133078; x=1692737878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n86duwAWI0LOgK8bqjGlw6cgAW8rDHxqYLLHJcUuTCk=;
        b=Qbns/yNc9pl3Pg56t2ZZcKlXIGzTDG2wjAdRYV4gIgElbdQzTsYH86OcdrEfve6gL8
         6sYjVJcVuK9p4UWsmSvHGLunIzs8lylYxSZO/XkIY86/pw6/gTGkV7mgYcY7CO5f2mir
         9IC0eLzrBJd3Pq/1omGlPno0Yps0/GDH4j4Il59t/fl412JO9LoxGSBJIhxNaSUIHXDi
         JJdmd5TxcjKX61muyGBOLj3p/thKDnvhlDQLSqzvSpMkR7EfgDXLVrDd4hNfDkWD8aX9
         dw09xzf4L/1J8m8lH9hNtdMhwQxmpMFnZpFfpwLYDQ9P0XweG+XrRaJ7ryrYywXLXJeh
         wHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692133078; x=1692737878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n86duwAWI0LOgK8bqjGlw6cgAW8rDHxqYLLHJcUuTCk=;
        b=EBaZ3cdVGInA9P0o41julypNsGEofZXHil/tW8bnZgQP95ec04sZvIt0i97K8vkjGj
         tdFyy5SnZfbVqi1UkIIuq/OyoQctd0fsGEfiiShqcEenB1WWhQZgVNgocOOA4Iks9oZb
         Tn0J5J2hZMR4WbM60yrDDg6AdE5MzkUjqeU5FDLg9k/dybCcOFFnUYu9mlssfmfFKFeS
         uqyd1yMWvSknIKWXiIi0ekVdkX37YC3ae86arLsVJVvwizKorzOYgmfAOFL6pYS9bh9A
         8xQ1blK/rnO5jJ4fG39E05rf6GEfkdj8dVYEHy+cxLsHLePYMT+06rHhWtwBZZ+OzrmY
         bCoA==
X-Gm-Message-State: AOJu0Yx7+E12GtnBQdhMyltgDVcHy3Qc9QJcwgrrE9Uix8py1XMAAT8O
	p1hWVEvAuygApigA1cqosytWsho=
X-Google-Smtp-Source: AGHT+IHPo+KTa6c1+9DkkBne5kg+N0xlB8ijCACk3RUxUWEzjsxtRJ/71b6yoTkMPgVwwvAs7HvCUKg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3e4c:0:b0:564:cfab:5648 with SMTP id
 l73-20020a633e4c000000b00564cfab5648mr2794pga.3.1692133078176; Tue, 15 Aug
 2023 13:57:58 -0700 (PDT)
Date: Tue, 15 Aug 2023 13:57:56 -0700
In-Reply-To: <20230815174712.660956-6-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230815174712.660956-1-thinker.li@gmail.com> <20230815174712.660956-6-thinker.li@gmail.com>
Message-ID: <ZNvm1INWVulkWM8d@google.com>
Subject: Re: [RFC bpf-next v3 5/5] selftests/bpf: Add test cases for sleepable
 BPF programs of the CGROUP_SOCKOPT type
From: Stanislav Fomichev <sdf@google.com>
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, yonghong.song@linux.dev, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/15, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Do the same test as non-sleepable ones.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  .../testing/selftests/bpf/bpf_experimental.h  |  36 +++
>  tools/testing/selftests/bpf/bpf_kfuncs.h      |  41 +++
>  .../selftests/bpf/prog_tests/sockopt_sk.c     | 112 +++++++-
>  .../testing/selftests/bpf/progs/sockopt_sk.c  | 257 ++++++++++++++++++
>  .../selftests/bpf/verifier/sleepable.c        |   2 +-
>  5 files changed, 445 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 209811b1993a..9b5dfefe65dc 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -131,4 +131,40 @@ extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *nod
>   */
>  extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
>  
> +/*
> + *     Description
> + *             Copy data from *ptr* to *sopt->optval*.
> + *     Return
> + *             >= 0 on success, or a negative error in case of failure.
> + */
> +extern int bpf_sockopt_dynptr_copy_to(struct bpf_sockopt *sopt,
> +				      struct bpf_dynptr *ptr) __ksym;
> +
> +/* Description
> + *	Allocate a buffer of 'size' bytes for being installed as optval.
> + * Returns
> + *	> 0 on success, the size of the allocated buffer
> + *	-ENOMEM or -EINVAL on failure
> + */
> +extern int bpf_sockopt_dynptr_alloc(struct bpf_sockopt *sopt, int size,
> +				    struct bpf_dynptr *ptr__uninit) __ksym;
> +
> +/* Description
> + *	Install the buffer pointed to by 'ptr' as optval.
> + * Returns
> + *	0 on success
> + *	-EINVAL if the buffer is too small
> + */
> +extern int bpf_sockopt_dynptr_install(struct bpf_sockopt *sopt,
> +				      struct bpf_dynptr *ptr) __ksym;
> +
> +/* Description
> + *	Release the buffer allocated by bpf_sockopt_dynptr_alloc.
> + * Returns
> + *	0 on success
> + *	-EINVAL if the buffer was not allocated by bpf_sockopt_dynptr_alloc
> + */
> +extern int bpf_sockopt_dynptr_release(struct bpf_sockopt *sopt,
> +				      struct bpf_dynptr *ptr) __ksym;
> +
>  #endif
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> index 642dda0e758a..772040225257 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -41,4 +41,45 @@ extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
>  extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
>  extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym;
>  
> +extern int bpf_sockopt_dynptr_copy_to(struct bpf_sockopt *sopt,
> +				      struct bpf_dynptr *ptr) __ksym;
> +
> +/* Description
> + *	Allocate a buffer of 'size' bytes for being installed as optval.
> + * Returns
> + *	> 0 on success, the size of the allocated buffer
> + *	-ENOMEM or -EINVAL on failure
> + */
> +extern int bpf_sockopt_dynptr_alloc(struct bpf_sockopt *sopt, int size,
> +				    struct bpf_dynptr *ptr__uninit) __ksym;
> +
> +/* Description
> + *	Install the buffer pointed to by 'ptr' as optval.
> + * Returns
> + *	0 on success
> + *	-EINVAL if the buffer is too small
> + */
> +extern int bpf_sockopt_dynptr_install(struct bpf_sockopt *sopt,
> +				      struct bpf_dynptr *ptr) __ksym;
> +
> +/* Description
> + *	Release the buffer allocated by bpf_sockopt_dynptr_alloc.
> + * Returns
> + *	0 on success
> + *	-EINVAL if the buffer was not allocated by bpf_sockopt_dynptr_alloc
> + */
> +extern int bpf_sockopt_dynptr_release(struct bpf_sockopt *sopt,
> +				      struct bpf_dynptr *ptr) __ksym;
> +
> +/* Description
> + *	Initialize a dynptr to access the content of optval passing
> + *      to {get,set}sockopt()s.
> + * Returns
> + *	> 0 on success, the size of the allocated buffer
> + *	-ENOMEM or -EINVAL on failure
> + */
> +extern int bpf_sockopt_dynptr_from(struct bpf_sockopt *sopt,
> +				   struct bpf_dynptr *ptr__uninit,
> +				   unsigned int size) __ksym;
> +
>  #endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> index 05d0e07da394..85255648747f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> @@ -92,6 +92,7 @@ static int getsetsockopt(void)
>  	}
>  	if (buf.u8[0] != 0x01) {
>  		log_err("Unexpected buf[0] 0x%02x != 0x01", buf.u8[0]);
> +		log_err("optlen %d", optlen);
>  		goto err;
>  	}
>  
> @@ -220,7 +221,7 @@ static int getsetsockopt(void)
>  	return -1;
>  }
>  
> -static void run_test(int cgroup_fd)
> +static void run_test_nonsleepable(int cgroup_fd)
>  {
>  	struct sockopt_sk *skel;
>  
> @@ -246,6 +247,106 @@ static void run_test(int cgroup_fd)
>  	sockopt_sk__destroy(skel);
>  }
>  
> +static void run_test_nonsleepable_mixed(int cgroup_fd)
> +{
> +	struct sockopt_sk *skel;
> +
> +	skel = sockopt_sk__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_load"))
> +		goto cleanup;
> +
> +	skel->bss->page_size = getpagesize();
> +	skel->bss->skip_sleepable = 1;
> +
> +	skel->links._setsockopt_s =
> +		bpf_program__attach_cgroup(skel->progs._setsockopt_s, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links._setsockopt_s, "setsockopt_link (sleepable)"))
> +		goto cleanup;
> +
> +	skel->links._getsockopt_s =
> +		bpf_program__attach_cgroup(skel->progs._getsockopt_s, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links._getsockopt_s, "getsockopt_link (sleepable)"))
> +		goto cleanup;
> +
> +	skel->links._setsockopt =
> +		bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links._setsockopt, "setsockopt_link"))
> +		goto cleanup;
> +
> +	skel->links._getsockopt =
> +		bpf_program__attach_cgroup(skel->progs._getsockopt, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links._getsockopt, "getsockopt_link"))
> +		goto cleanup;
> +
> +	ASSERT_OK(getsetsockopt(), "getsetsockopt");
> +
> +cleanup:
> +	sockopt_sk__destroy(skel);
> +}
> +
> +static void run_test_sleepable(int cgroup_fd)
> +{
> +	struct sockopt_sk *skel;
> +
> +	skel = sockopt_sk__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_load"))
> +		goto cleanup;
> +
> +	skel->bss->page_size = getpagesize();
> +
> +	skel->links._setsockopt_s =
> +		bpf_program__attach_cgroup(skel->progs._setsockopt_s, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links._setsockopt_s, "setsockopt_link"))
> +		goto cleanup;
> +
> +	skel->links._getsockopt_s =
> +		bpf_program__attach_cgroup(skel->progs._getsockopt_s, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links._getsockopt_s, "getsockopt_link"))
> +		goto cleanup;
> +
> +	ASSERT_OK(getsetsockopt(), "getsetsockopt");
> +
> +cleanup:
> +	sockopt_sk__destroy(skel);
> +}
> +
> +static void run_test_sleepable_mixed(int cgroup_fd)
> +{
> +	struct sockopt_sk *skel;
> +
> +	skel = sockopt_sk__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_load"))
> +		goto cleanup;
> +
> +	skel->bss->page_size = getpagesize();
> +	skel->bss->skip_nonsleepable = 1;
> +
> +	skel->links._setsockopt =
> +		bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links._setsockopt, "setsockopt_link (nonsleepable)"))
> +		goto cleanup;
> +
> +	skel->links._getsockopt =
> +		bpf_program__attach_cgroup(skel->progs._getsockopt, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links._getsockopt, "getsockopt_link (nonsleepable)"))
> +		goto cleanup;
> +
> +	skel->links._setsockopt_s =
> +		bpf_program__attach_cgroup(skel->progs._setsockopt_s, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links._setsockopt_s, "setsockopt_link"))
> +		goto cleanup;
> +
> +	skel->links._getsockopt_s =
> +		bpf_program__attach_cgroup(skel->progs._getsockopt_s, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links._getsockopt_s, "getsockopt_link"))
> +		goto cleanup;
> +
> +	ASSERT_OK(getsetsockopt(), "getsetsockopt");
> +
> +cleanup:
> +	sockopt_sk__destroy(skel);
> +}
> +
>  void test_sockopt_sk(void)
>  {
>  	int cgroup_fd;
> @@ -254,6 +355,13 @@ void test_sockopt_sk(void)
>  	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /sockopt_sk"))
>  		return;
>  
> -	run_test(cgroup_fd);
> +	if (test__start_subtest("nonsleepable"))
> +		run_test_nonsleepable(cgroup_fd);
> +	if (test__start_subtest("sleepable"))
> +		run_test_sleepable(cgroup_fd);
> +	if (test__start_subtest("nonsleepable_mixed"))
> +		run_test_nonsleepable_mixed(cgroup_fd);
> +	if (test__start_subtest("sleepable_mixed"))
> +		run_test_sleepable_mixed(cgroup_fd);
>  	close(cgroup_fd);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> index cb990a7d3d45..efacd3b88c40 100644
> --- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> @@ -5,10 +5,16 @@
>  #include <netinet/in.h>
>  #include <bpf/bpf_helpers.h>
>  
> +typedef int bool;
> +#include "bpf_kfuncs.h"
> +
>  char _license[] SEC("license") = "GPL";
>  
>  int page_size = 0; /* userspace should set it */
>  
> +int skip_sleepable = 0;
> +int skip_nonsleepable = 0;
> +
>  #ifndef SOL_TCP
>  #define SOL_TCP IPPROTO_TCP
>  #endif
> @@ -34,6 +40,9 @@ int _getsockopt(struct bpf_sockopt *ctx)
>  	struct sockopt_sk *storage;
>  	struct bpf_sock *sk;
>  
> +	if (skip_nonsleepable)
> +		return 1;
> +
>  	/* Bypass AF_NETLINK. */
>  	sk = ctx->sk;
>  	if (sk && sk->family == AF_NETLINK)
> @@ -136,6 +145,134 @@ int _getsockopt(struct bpf_sockopt *ctx)
>  	return 1;
>  }
>  
> +SEC("cgroup/getsockopt.s")
> +int _getsockopt_s(struct bpf_sockopt *ctx)
> +{
> +	struct tcp_zerocopy_receive *zcvr;
> +	struct bpf_dynptr optval_dynptr;
> +	struct sockopt_sk *storage;
> +	__u8 *optval, *optval_end;
> +	struct bpf_sock *sk;
> +	char buf[1];
> +	__u64 addr;
> +	int ret;
> +
> +	if (skip_sleepable)
> +		return 1;
> +
> +	/* Bypass AF_NETLINK. */
> +	sk = ctx->sk;
> +	if (sk && sk->family == AF_NETLINK)
> +		return 1;
> +
> +	optval = ctx->optval;
> +	optval_end = ctx->optval_end;
> +
> +	/* Make sure bpf_get_netns_cookie is callable.
> +	 */
> +	if (bpf_get_netns_cookie(NULL) == 0)
> +		return 0;
> +
> +	if (bpf_get_netns_cookie(ctx) == 0)
> +		return 0;
> +
> +	if (ctx->level == SOL_IP && ctx->optname == IP_TOS) {
> +		/* Not interested in SOL_IP:IP_TOS;
> +		 * let next BPF program in the cgroup chain or kernel
> +		 * handle it.
> +		 */
> +		return 1;
> +	}
> +
> +	if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
> +		/* Not interested in SOL_SOCKET:SO_SNDBUF;
> +		 * let next BPF program in the cgroup chain or kernel
> +		 * handle it.
> +		 */
> +		return 1;
> +	}
> +
> +	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION) {
> +		/* Not interested in SOL_TCP:TCP_CONGESTION;
> +		 * let next BPF program in the cgroup chain or kernel
> +		 * handle it.
> +		 */
> +		return 1;
> +	}
> +
> +	if (ctx->level == SOL_TCP && ctx->optname == TCP_ZEROCOPY_RECEIVE) {
> +		/* Verify that TCP_ZEROCOPY_RECEIVE triggers.
> +		 * It has a custom implementation for performance
> +		 * reasons.
> +		 */
> +
> +		bpf_sockopt_dynptr_from(ctx, &optval_dynptr, sizeof(*zcvr));
> +		zcvr = bpf_dynptr_data(&optval_dynptr, 0, sizeof(*zcvr));
> +		addr = zcvr ? zcvr->address : 0;
> +		bpf_sockopt_dynptr_release(ctx, &optval_dynptr);

This starts to look more usable, thank you for the changes!
Let me poke the api a bit more, I'm not super familiar with the dynptrs.

here: bpf_sockopt_dynptr_from should probably be called
bpf_dynptr_from_sockopt to match bpf_dynptr_from_mem?

> +
> +		return addr != 0 ? 0 : 1;
> +	}
> +
> +	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
> +		if (optval + 1 > optval_end)
> +			return 0; /* bounds check */
> +
> +		ctx->retval = 0; /* Reset system call return value to zero */
> +
> +		/* Always export 0x55 */
> +		buf[0] = 0x55;
> +		ret = bpf_sockopt_dynptr_alloc(ctx, 1, &optval_dynptr);
> +		if (ret >= 0) {
> +			bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
> +			ret = bpf_sockopt_dynptr_copy_to(ctx, &optval_dynptr);
> +		}
> +		bpf_sockopt_dynptr_release(ctx, &optval_dynptr);

Does bpf_sockopt_dynptr_alloc and bpf_sockopt_dynptr_release need to be
sockopt specific? Seems like we should provide, instead, some generic
bpf_dynptr_alloc/bpf_dynptr_release and make
bpf_sockopt_dynptr_copy_to/install work with them? WDYT?

> +		if (ret < 0)
> +			return 0;
> +		ctx->optlen = 1;
> +
> +		/* Userspace buffer is PAGE_SIZE * 2, but BPF
> +		 * program can only see the first PAGE_SIZE
> +		 * bytes of data.
> +		 */
> +		if (optval_end - optval != page_size && 0)
> +			return 0; /* unexpected data size */
> +
> +		return 1;
> +	}
> +
> +	if (ctx->level != SOL_CUSTOM)
> +		return 0; /* deny everything except custom level */
> +
> +	if (optval + 1 > optval_end)
> +		return 0; /* bounds check */
> +
> +	storage = bpf_sk_storage_get(&socket_storage_map, ctx->sk, 0,
> +				     BPF_SK_STORAGE_GET_F_CREATE);
> +	if (!storage)
> +		return 0; /* couldn't get sk storage */
> +
> +	if (!ctx->retval)
> +		return 0; /* kernel should not have handled
> +			   * SOL_CUSTOM, something is wrong!
> +			   */
> +	ctx->retval = 0; /* Reset system call return value to zero */
> +
> +	buf[0] = storage->val;
> +	ret = bpf_sockopt_dynptr_alloc(ctx, 1, &optval_dynptr);
> +	if (ret >= 0) {
> +		bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
> +		ret = bpf_sockopt_dynptr_copy_to(ctx, &optval_dynptr);
> +	}
> +	bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
> +	if (ret < 0)
> +		return 0;
> +	ctx->optlen = 1;
> +
> +	return 1;
> +}
> +
>  SEC("cgroup/setsockopt")
>  int _setsockopt(struct bpf_sockopt *ctx)
>  {
> @@ -144,6 +281,9 @@ int _setsockopt(struct bpf_sockopt *ctx)
>  	struct sockopt_sk *storage;
>  	struct bpf_sock *sk;
>  
> +	if (skip_nonsleepable)
> +		return 1;
> +
>  	/* Bypass AF_NETLINK. */
>  	sk = ctx->sk;
>  	if (sk && sk->family == AF_NETLINK)
> @@ -236,3 +376,120 @@ int _setsockopt(struct bpf_sockopt *ctx)
>  		ctx->optlen = 0;
>  	return 1;
>  }
> +
> +SEC("cgroup/setsockopt.s")
> +int _setsockopt_s(struct bpf_sockopt *ctx)
> +{
> +	struct bpf_dynptr optval_buf;
> +	struct sockopt_sk *storage;
> +	__u8 *optval, *optval_end;
> +	struct bpf_sock *sk;
> +	__u8 tmp_u8;
> +	__u32 tmp;
> +	int ret;
> +
> +	if (skip_sleepable)
> +		return 1;
> +
> +	optval = ctx->optval;
> +	optval_end = ctx->optval_end;
> +
> +	/* Bypass AF_NETLINK. */
> +	sk = ctx->sk;
> +	if (sk && sk->family == AF_NETLINK)
> +		return -1;
> +
> +	/* Make sure bpf_get_netns_cookie is callable.
> +	 */
> +	if (bpf_get_netns_cookie(NULL) == 0)
> +		return 0;
> +
> +	if (bpf_get_netns_cookie(ctx) == 0)
> +		return 0;
> +
> +	if (ctx->level == SOL_IP && ctx->optname == IP_TOS) {
> +		/* Not interested in SOL_IP:IP_TOS;
> +		 * let next BPF program in the cgroup chain or kernel
> +		 * handle it.
> +		 */
> +		ctx->optlen = 0; /* bypass optval>PAGE_SIZE */
> +		return 1;
> +	}
> +
> +	if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
> +		/* Overwrite SO_SNDBUF value */
> +
> +		ret = bpf_sockopt_dynptr_alloc(ctx, sizeof(__u32),
> +					       &optval_buf);
> +		if (ret < 0)
> +			bpf_sockopt_dynptr_release(ctx, &optval_buf);
> +		else {
> +			tmp = 0x55AA;
> +			bpf_dynptr_write(&optval_buf, 0, &tmp, sizeof(tmp), 0);
> +			ret = bpf_sockopt_dynptr_install(ctx, &optval_buf);

One thing I'm still slightly confused about is
bpf_sockopt_dynptr_install vs bpf_sockopt_dynptr_copy_to. I do
understand that it comes from getsockopt vs setsockopt (and the ability,
in setsockopt, to allocate larger buffers), but I wonder whether
we can hide everything under single bpf_sockopt_dynptr_copy_to call?

For getsockopt, it stays as is. For setsockopt, it would work like
_install currently does. Would that work? From user perspective,
if we provide a simple call that does the right thing, seems a bit
more usable? The only problem is probably the fact that _install
explicitly moves the ownership, but I don't see why copy_to can't
have the same "consume" semantics?

