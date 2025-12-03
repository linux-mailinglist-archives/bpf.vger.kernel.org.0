Return-Path: <bpf+bounces-76003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07690CA2014
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 00:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07038300F9FD
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 23:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BE32ECD39;
	Wed,  3 Dec 2025 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd1KNMsh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EFD186E40;
	Wed,  3 Dec 2025 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764806261; cv=none; b=IwcbRm/yBng21AXuoqYKmO6HptX73/hNFYeHtTruU7o+LILetBQoDlTa0d0kxnMZbtD88A4kMBZcQHBdBcr2SWnrD7MkMdL9QAcorlr2aoTYttQ6D9ecNRpD1DLcot0LTa/J6O7PdbpywWjOCHcD8d/j6ZlPCsPT/cRIl35pCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764806261; c=relaxed/simple;
	bh=HdY6rsnxlIOYvn49bQNPs0TKOD8JYNVKKPRDrRmB5ho=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RydAnAPskuVOxCS2xgeP2FHaOUe2+L7SifkfW4bO8h87G/3S1gQVsUV2RxVyqsS3kowxRzVkUpcbYcCmdaYyCu5IdU65bXz/O9/hNdQA4RUXSAalvudpoS2ohMT+HnOcC594CrifmLf08mqZyMuQ+L3p9ZR5Q7Pyej8sNsMUghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qd1KNMsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C6EC4CEF5;
	Wed,  3 Dec 2025 23:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764806260;
	bh=HdY6rsnxlIOYvn49bQNPs0TKOD8JYNVKKPRDrRmB5ho=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=qd1KNMshPr1fZZgtG9DtJPCCTX/GrYS3PAFmPozKRKkiolFbCIxzwrdGx/EeJOjAe
	 un4ejMVg8nojOTxuD+dcfwwnyOPc8qm5uwuJZSrx7xlyyMkrnYAivK8TklBIXGQOoW
	 zruqVmFg+eRnvMjvK7wTC1IzgVwaZMBXlkgkE9kvRlJe4KNP0Vgv0Euu82kyOj/iEX
	 +Q++fb83wG1ArgzJfm653ksYq8Djoz0QWUxBAdmJdG+9cgH9QVqlbX6SYvmCZisVUs
	 zOGU/GRhaVDlUW3rADlraZPpvGFUvxHQFxGLX5mbSu/ZwidArCebfpJAc1kO/2AGUp
	 q7u8EKIEYZ8PA==
Content-Type: multipart/mixed; boundary="===============4476200724671562845=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f7708afd314b93994ea6bef80b24442016742820e59f57bac0b793cddf37076d@mail.kernel.org>
In-Reply-To: <20251203233748.668365-4-ameryhung@gmail.com>
References: <20251203233748.668365-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v8 3/6] libbpf: Add support for associating BPF program with struct_ops
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,tj@kernel.org,martin.lau@kernel.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Dec 2025 23:57:39 +0000 (UTC)

--===============4476200724671562845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index b66f5fbfb..21b57a629 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 706e7481b..076dc6b79 100644
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
                        ^^^^^^^^^^
Can this dereference prog->name when prog is NULL?  If prog is NULL,
bpf_program__fd() returns -EINVAL, entering this error path, but
prog->name dereferences the NULL pointer before the error can be
returned.

> +		return libbpf_err(-EINVAL);
> +	}
> +
> +	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
> +		pr_warn("prog '%s': can't associate struct_ops program\n", prog->name);
                                                                        ^^^^^^^^^^
Same issue here - prog->name is dereferenced after we already know
prog_fd is invalid, which includes the case where prog is NULL.

> +		return libbpf_err(-EINVAL);
> +	}
> +
> +	map_fd = bpf_map__fd(map);
> +	if (map_fd < 0) {
> +		pr_warn("map '%s': can't associate BPF map without FD (was it created?)\n", map->name);
                                                                                             ^^^^^^^^^
Similar issue with map->name when map is NULL?  If map is NULL,
bpf_map__fd() returns -EINVAL, and then map->name is dereferenced.

> +		return libbpf_err(-EINVAL);
> +	}
> +
> +	if (!bpf_map__is_struct_ops(map)) {
> +		pr_warn("map '%s': can't associate non-struct_ops map\n", map->name);
                                                                         ^^^^^^^^^
And again here with map->name after checking the map is not a
struct_ops type.

> +		return libbpf_err(-EINVAL);
> +	}
> +
> +	return bpf_prog_assoc_struct_ops(prog_fd, map_fd, opts);
> +}
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19912520845

--===============4476200724671562845==--

