Return-Path: <bpf+bounces-72711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C47C19A00
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 11:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5C964E79D9
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 10:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CA32F6194;
	Wed, 29 Oct 2025 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uyxwq1h5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1962F5A1B
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732913; cv=none; b=VWWbTaX9KlQE46hngSiJvq0lvGxT+kseUu8n8bn09AlLK0HtvlJgWzqoBSv7TV/glZ6MrI9CQ/gk3IYqCOZb5tA0ShLbXd8jsWaYqS1n0sb/MgZuThb0TgxK2gR1qA0+WLL/cx26nDIEUCaxCHEBZlTszhKtzxHG9KzUVdF6NeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732913; c=relaxed/simple;
	bh=IgdfxtGQKQOq4+Je4sdLPTDIwGZ2L37jlgnYN1T3JBQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tAosZfIiE/H7fmOyRuhfeLzP6lV/tyaSfVkcqe9070upk/S2QFAArNvV9MjVjN2R02ly86ECN1sp5VxGh6BcRzYYouGUhqPEoqQ4fNdorbBbilnTXZDQSgPZZl+3p/lavIbcNsGUveJy2RtUNV2KRu+83echA8fb27F1sT2SOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uyxwq1h5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92391C4CEF7;
	Wed, 29 Oct 2025 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761732911;
	bh=IgdfxtGQKQOq4+Je4sdLPTDIwGZ2L37jlgnYN1T3JBQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Uyxwq1h59qzUvOOd17M8SwRQlEJK5e3WVYp/Qhtxt7PsmVCvd2dmTIkLYokklZOiN
	 7kUl6PWxR8LLbyZbEjy5N1wSQrI5bZ+smXu3Vkq3W43DWHXr0cQCg9VMmL4qFsHWfN
	 csC7gp/CKQvUlcY7rr4JWTURrvWlrbW+Sf1LaNa6AkMWJFZcYOaNJbkEjigmZoFPzC
	 LKbcxN7XemFjbXtytpgcDECcELB0wlKzmMjbGoY/bv8gFZ9sOCdun4lUy7QZ2xVOPk
	 0T9eh1QVOhEunVWWID8zxAJlZL2/UiMQAPWkG/nERxWtm38IvmgVjD92gZ7QNVzarG
	 ++gvtCPZbw+cA==
Content-Type: multipart/mixed; boundary="===============1714424974194933712=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <498a5d7ce4624f022f8916088dc9132c3e8a02d7f84e440526bab44aa9bd275a@mail.kernel.org>
In-Reply-To: <20251029094631.1387011-3-alan.maguire@oracle.com>
References: <20251029094631.1387011-3-alan.maguire@oracle.com>
Subject: Re: [RFC bpf-next 2/2] bpftool: Use libcrypto feature test to optionally support signing
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,qmo@kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,terrelln@fb.com,dsterba@suse.com,acme@redhat.com,irogers@google.com,leo.yan@arm.com,namhyung@kernel.org,tglozar@redhat.com,blakejones@google.com,yuzhuo@google.com,charlie@rivosinc.com,ebiggers@kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Oct 2025 10:15:09 +0000 (UTC)

--===============1714424974194933712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit d2f495eb79d8b11d0ce090766e078d07cff9a826
Author: Alan Maguire <alan.maguire@oracle.com>

bpftool: Use libcrypto feature test to optionally support signing

This patch adds conditional compilation support for BPF signing
functionality, allowing bpftool to build without libcrypto v3 by
wrapping signing-related code in #ifdef USE_CRYPTO guards.

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 6daf19809..914b0fc17 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c

[ ... ]

> @@ -1931,12 +1931,10 @@ static int try_loader(struct gen_loader_opts *gen)
>  {
>  	struct bpf_load_and_run_opts opts = {};
>  	struct bpf_loader_ctx *ctx;
> -	char sig_buf[MAX_SIG_SIZE];
> -	__u8 prog_sha[SHA256_DIGEST_LENGTH];
>  	int ctx_sz = sizeof(*ctx) + 64 * max(sizeof(struct bpf_map_desc),
>  					     sizeof(struct bpf_prog_desc));
>  	int log_buf_sz = (1u << 24) - 1;
> -	int err, fds_before, fd_delta;
> +	int err = 0, fds_before, fd_delta;
>  	char *log_buf = NULL;
>
>  	ctx = alloca(ctx_sz);
> @@ -1947,7 +1945,7 @@ static int try_loader(struct gen_loader_opts *gen)
>  		ctx->log_size = log_buf_sz;
>  		log_buf = malloc(log_buf_sz);
>  		if (!log_buf)
> -			return -ENOMEM;
> +			goto out;
                        ^^^^^^^^

When malloc fails here, does err get set to -ENOMEM before the goto?
It looks like err is initialized to 0 at the top of the function, but
there's no assignment before this goto. The old code returned -ENOMEM
directly. Won't this cause malloc failure to return success (0) instead
of -ENOMEM?

>  		ctx->log_buf = (long) log_buf;
>  	}
>  	opts.ctx = ctx;

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `bpftool: Use libcrypto feature test to optionally support signing`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18904020660

--===============1714424974194933712==--

