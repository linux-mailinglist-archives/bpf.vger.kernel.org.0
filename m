Return-Path: <bpf+bounces-73476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF46C3276F
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF273B9ADC
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B933BBA8;
	Tue,  4 Nov 2025 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFVjg8pp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20A279DA2;
	Tue,  4 Nov 2025 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278894; cv=none; b=sTJ4HlNgFa3N1saBlL5jV3cCe+700NYM/t21FtV5hC8ydIcQBNUXE/qdgCwFtupYKwWjvIlGDkIuGwFUt/Oo9qiYTSr4Gw9XjHKJz2DwO0K9oru7kVj9u7oxCOUw4KSgHYk64oUWEMOL9BFVYMMraq8k3BNfqvo172vlDnnpNZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278894; c=relaxed/simple;
	bh=oXV3ZPtbgwEKVizT1FYJBTXIT7LT8NAvR85URp09Tn4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YMUdYMGYA40aFgX5Niph5WvcQbv77gHFtLUzlojaD4YQn0twc0POlsgK/A+I4e0BCoA/tUpRl6jJNvjLz5vfuN7q0x7xvz3MNRk6C4tvT3e/2ETeQ7cEuficC+uFmwkMtZxF8jbhdW6b/dAvsAOgdRLkh4tqumjv88OHPpv+lHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFVjg8pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EE5C4CEF7;
	Tue,  4 Nov 2025 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762278893;
	bh=oXV3ZPtbgwEKVizT1FYJBTXIT7LT8NAvR85URp09Tn4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pFVjg8ppSqGe48n6XSiiDbASFvMHoeZXvYsxsvBg1kUPbBhc+tVWLdnx6wutw9q8A
	 lu5M23+q+xwmv49yPzzgdz23tmplMfG1uDWXDEjdETI/gDewFDXVNJRwuIQrj9VMTT
	 /xmuuO0A75H0DB97r+xvRsG1sdrMgcEiiKTGiY1sihM0x7kyZukWG+z1xdDR+j/YGt
	 Ka+dbYZJrgzvckKOD63gwilyAy8NoM02MJfc2PFDGE/W3lQ+7A69DCXudjpBYAi7Fb
	 Z55TH2ABU/zmOc0CqC+R9++WApCcIqu79digtU9zp/6nN+/rsX1LlJ2TZo5k9QjRlg
	 bg7KdSeTjYs6g==
Content-Type: multipart/mixed; boundary="===============6840592455215910572=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b4c70f2af7001ee36b8d3702f280ca11e3ba281ba29cdcb63434ee28e0a8060a@mail.kernel.org>
In-Reply-To: <20251104172652.1746988-5-ameryhung@gmail.com>
References: <20251104172652.1746988-5-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] libbpf: Add support for associating BPF program with struct_ops
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,tj@kernel.org,martin.lau@kernel.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  4 Nov 2025 17:54:53 +0000 (UTC)

--===============6840592455215910572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fbe74686c..260e1feaa 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -13891,6 +13891,36 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
>  	return 0;
>  }
>
> +int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map *map,
> +				  struct bpf_prog_assoc_struct_ops_opts *opts)
> +{
> +	int prog_fd;
> +
> +	prog_fd = bpf_program__fd(prog);
> +	if (prog_fd < 0) {
> +		pr_warn("prog '%s': can't associate BPF program without FD (was it loaded?)\n",
> +			prog->name);
                     ^^^^^^^^^^

Can prog be NULL here? If bpf_program__fd() returns -EINVAL because prog
was NULL, this dereferences prog->name without a NULL check. Looking at
bpf_program__set_attach_target() just above, it checks "if (!prog)"
before any dereferences.

> +		return -EINVAL;
> +	}
> +
> +	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
           ^^^^^^^^^^

Same issue - prog->type is dereferenced without verifying prog is not
NULL.

> +		pr_warn("prog '%s': can't associate struct_ops program\n", prog->name);
> +		return -EINVAL;
> +	}
> +
> +	if (map->fd < 0) {
           ^^^^^^

Can map be NULL? There's no NULL check before dereferencing map->fd.
Other map APIs like bpf_map__fd() and bpf_map__name() check for NULL
before use.

> +		pr_warn("map '%s': can't associate BPF map without FD (was it created?)\n", map->name);
> +		return -EINVAL;
> +	}
> +
> +	if (!bpf_map__is_struct_ops(map)) {
> +		pr_warn("map '%s': can't associate non-struct_ops map\n", map->name);
> +		return -EINVAL;
> +	}
> +
> +	return bpf_prog_assoc_struct_ops(prog_fd, map->fd, opts);
> +}
> +


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19077679684

--===============6840592455215910572==--

