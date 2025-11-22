Return-Path: <bpf+bounces-75279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E56C7C0CD
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1453A4160
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52823EAB7;
	Sat, 22 Nov 2025 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1BXMDJn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5921F09AD;
	Sat, 22 Nov 2025 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763773092; cv=none; b=Xtv0Y+nOZqrft64jr8mQvnFvNY2yO9uAksxeNfkQPRc1N9XcbW8fz9I1liTPziXlu8Wq0pDiafJKno6ZDO9hftt8D5wxp5/kqEoP3wKgnN3+8F1gckX1eQ8r1MyAw4BUHytHiqSn3vthQjKno9SF8pzuEXikEamxXX6RklwR9fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763773092; c=relaxed/simple;
	bh=7dOS1urwg7ekPGlLg8CEDeNygH4QNwE9tnPY363vY0c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E94MAFihJOXNSDfBrc/il44KWfR/K3T737zyBpN/Q8vv0kRjV5AO2/TT09NC9kPDedAHc6+vxJfFmbFwgnc/zv9m3MTwfXEiOejVcfRrXdcqCP7HmG714D3kr+SuSZdGi9qkDPQx1kdLZzG95wXd5FR/Q5eSJqaAVxfi9jfvLZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1BXMDJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90797C4CEF1;
	Sat, 22 Nov 2025 00:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763773087;
	bh=7dOS1urwg7ekPGlLg8CEDeNygH4QNwE9tnPY363vY0c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=M1BXMDJnzWKoq/RhWeSRF1xxTV9r3LuMyB0EukCY/boNCO7u77FviLFEEHuedGxF9
	 s9p5oKYEV5CNdN1Y6D2pE3YPpJ2TgVkC70fdaOdi70S1Gi0c+ktwZ8tGAlWYAyawBb
	 EwTs+lHr06hKDFKefC+osX0t5nXn7fZ5CfaEN9b9kpgDeY8tuOj1bpHm0FMWiWy4IH
	 zTlmh7R5uElcZHTbWUME5tteF4kTvOV/8u3ECODXKBouQzHkh4sLCSXAj0PQwyBG/3
	 AiiEG5OyJ3Xvy643aRHThS1aGGgfEAlky4K05vNJ1UkZaFHmiohF12ii8eIcgsv064
	 RyKyS/SstnmOQ==
Content-Type: multipart/mixed; boundary="===============8715300661097654828=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b277d408a2a94c37fb452fef7192ce1c1fcc0ef5288e9a26e3c7373db18c1f7a@mail.kernel.org>
In-Reply-To: <20251121231352.4032020-4-ameryhung@gmail.com>
References: <20251121231352.4032020-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v7 3/6] libbpf: Add support for associating BPF program with struct_ops
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,tj@kernel.org,martin.lau@kernel.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 22 Nov 2025 00:58:07 +0000 (UTC)

--===============8715300661097654828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index b66f5fbfb..21b57a629 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 706e7481b..1d5424276 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -14137,6 +14137,37 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
>  	return 0;
>  }
>
> +int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map *map,
> +				  struct bpf_prog_assoc_struct_ops_opts *opts)
> +{
> +	int prog_fd, map_fd;
> +
> +	prog_fd = bpf_program__fd(prog);
> +	if (prog_fd < 0) {
> +		pr_warn("prog '%s': can't associate BPF program without FD (was it loaded?)\n",
> +			prog->name);

Can prog->name be accessed here when prog is NULL?  The function
bpf_program__fd() returns libbpf_err(-EINVAL) when prog is NULL,
which makes prog_fd < 0 true, then prog->name is dereferenced.

Similarly for the map parameter below:

> +		return -EINVAL;
> +	}
> +
> +	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
> +		pr_warn("prog '%s': can't associate struct_ops program\n", prog->name);
> +		return -EINVAL;
> +	}
> +
> +	map_fd = bpf_map__fd(map);
> +	if (map_fd < 0) {
> +		pr_warn("map '%s': can't associate BPF map without FD (was it created?)\n", map->name);

The function bpf_map__fd() returns libbpf_err(-EINVAL) when map is
NULL, making this condition true, then map->name is dereferenced.

The function bpf_program__set_attach_target() above checks for NULL
explicitly before accessing the prog pointer.  Should this function
follow the same pattern?

> +		return -EINVAL;
> +	}
> +
> +	if (!bpf_map__is_struct_ops(map)) {
> +		pr_warn("map '%s': can't associate non-struct_ops map\n", map->name);
> +		return -EINVAL;
> +	}
> +
> +	return bpf_prog_assoc_struct_ops(prog_fd, map_fd, opts);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19586343154

--===============8715300661097654828==--

