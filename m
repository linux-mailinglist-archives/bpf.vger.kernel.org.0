Return-Path: <bpf+bounces-74592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD4BC5F8A6
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AB7A4E2659
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858F430AD13;
	Fri, 14 Nov 2025 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flG+wGhK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D8304BC4;
	Fri, 14 Nov 2025 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763161135; cv=none; b=L8Qo1p0edwrHQKM2Qaq6lH6Q08umdAKZmLMeniK0cc8dh7tDPQtaJTTBr6L8CDzmmtryVL4VK3OcRJ3k+7XCbr1Ns1bgSoPhcDzC+p8Mv17UQhIsh4n5nsDOO/gTKn47kWQVWsWQCjog+XbUIWTrOct446ArpzkHuXSuTV9EQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763161135; c=relaxed/simple;
	bh=UK2/RGXrtuN+aWxxMx7vp0pWryOiraTw48WILwPFn9o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ph05XkZ/q2jRw9WUtq6NtW92cDxJ+zccVhG8pmcJeRCI5KPCfI8w+hnqULtl9KkKct1kqD3FTzcGfwnE8PgOPHBZBmQJs+fO8zQx01Z1oSfmLYa7wXWvqGXfdZMqLVco0NOErhawxnWsXyKcHFxjHGuepBCNN7yHMFIXtS9n/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flG+wGhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458A5C16AAE;
	Fri, 14 Nov 2025 22:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763161134;
	bh=UK2/RGXrtuN+aWxxMx7vp0pWryOiraTw48WILwPFn9o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=flG+wGhK41qW596pdygaolXJ1Gp4yVI3yxEK1fP5GSKjyDYUWk7FnoLTXQECP3Yh6
	 BMYbKgJQLFqMZPZc/c/T9bLn5DSbHq1Sdb5WQb9dbHktNJ+12BvBDPFC6gqSkjHKfG
	 X6wlA9zGpA+DH6OiN2r0/W8lmA2Xd5SCPSg/88nJqZmSFGSGxhGoI+vZICNlU0Zlwr
	 78tys4yfqUff7sxIJDMp2gMbTFg02ptiu7tdDLKiBmIqae4GAoQrb9PlBh6QFYqR2A
	 XwA4xIsqDbFu5buESkgBLTvvEtePIC1JpCNinbNg32oNQ9HAZBYk++NeMnrDbWdKrs
	 pzgOn1Z+JU70w==
Content-Type: multipart/mixed; boundary="===============6247975378476743638=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <90d4a3da144059c5d680eef68ca0979662e35e31adc0f8076fff364ed80757b0@mail.kernel.org>
In-Reply-To: <20251114221741.317631-4-ameryhung@gmail.com>
References: <20251114221741.317631-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v6 3/6] libbpf: Add support for associating BPF program with struct_ops
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,tj@kernel.org,martin.lau@kernel.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Nov 2025 22:58:54 +0000 (UTC)

--===============6247975378476743638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index b66f5fbfb..21b57a629 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c

[ ... ]

> +int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
> +			      struct bpf_prog_assoc_struct_ops_opts *opts)
> +{
> +	const size_t attr_sz = offsetofend(union bpf_attr, prog_assoc_struct_ops);
> +	union bpf_attr attr;
> +	int err;
> +
> +	if (!OPTS_VALID(opts, bpf_prog_assoc_struct_ops_opts))
> +		return libbpf_err(-EINVAL);
> +
> +	memset(&attr, 0, attr_sz);
> +	attr.prog_assoc_struct_ops.map_fd = map_fd;
> +	attr.prog_assoc_struct_ops.prog_fd = prog_fd;
> +	attr.prog_assoc_struct_ops.flags = OPTS_GET(opts, flags, 0);
> +
> +	err = sys_bpf(BPF_PROG_ASSOC_STRUCT_OPS, &attr, attr_sz);
> +	return libbpf_err_errno(err);
> +}

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 706e7481b..1d5424276 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map *map,
> +				  struct bpf_prog_assoc_struct_ops_opts *opts)
> +{
> +	int prog_fd, map_fd;
> +
> +	prog_fd = bpf_program__fd(prog);
> +	if (prog_fd < 0) {
> +		pr_warn("prog '%s': can't associate BPF program without FD (was it loaded?)\n",
> +			prog->name);
                     ^^^^^^^^^^
Can this crash if prog is NULL? bpf_program__fd() handles NULL by
returning libbpf_err(-EINVAL), so prog_fd will be negative and we
enter this error path. Then prog->name dereferences the NULL pointer.

> +		return -EINVAL;
> +	}
> +
> +	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
            ^^^^^^^^^
Similarly, is prog guaranteed non-NULL here? We know prog_fd is valid,
but that doesn't prove prog itself was checked.

> +		pr_warn("prog '%s': can't associate struct_ops program\n", prog->name);
> +		return -EINVAL;
> +	}
> +
> +	map_fd = bpf_map__fd(map);
> +	if (map_fd < 0) {
> +		pr_warn("map '%s': can't associate BPF map without FD (was it created?)\n", map->name);
                    ^^^^^^^^^^
Same issue with map - bpf_map__fd() handles NULL by returning an error,
but then we dereference map->name in the error message.

> +		return -EINVAL;
> +	}
> +
> +	if (!bpf_map__is_struct_ops(map)) {
            ^^^^^^^^^^^^^^^^^^^^^^^^
bpf_map__is_struct_ops() also dereferences map->def.type without a NULL
check, which would crash here if map is NULL.

> +		pr_warn("map '%s': can't associate non-struct_ops map\n", map->name);
> +		return -EINVAL;
> +	}
> +
> +	return bpf_prog_assoc_struct_ops(prog_fd, map_fd, opts);
> +}

Note: This follows the same pattern as existing functions like
bpf_program__pin() which also dereference prog->name without checking
prog for NULL. However, since the helper functions (bpf_program__fd,
bpf_map__fd) do handle NULL, it seems inconsistent to crash in the
error message when reporting that NULL was passed.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19379369447

--===============6247975378476743638==--

