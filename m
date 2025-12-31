Return-Path: <bpf+bounces-77549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBF3CEAF55
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 01:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B66530245D5
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 00:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C6A81ACA;
	Wed, 31 Dec 2025 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZESjWDdV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EFA139D;
	Wed, 31 Dec 2025 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767140770; cv=none; b=Y08+T9feR6HvfFf1s8QfExfRUbHEXbZFR5c4ChdoPxnETVYm/otqN9rNPWYTC+/0LpIrgweCxp/VFNu3QiezT4dkXcmZZCNJXuD+Rm0rRLNDaxpuGIowTIyQQRvWZa8++NG4BsHnPjGw9CmLLfglMBr0tTCen9ZPAsbld/baonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767140770; c=relaxed/simple;
	bh=PFwLlogIu4R2ajnsWqW1SZ/tzhd5KMKkpBQoje0WF2M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iH6ZVkG8By9uQMa+/d92CkxXrUjut08qmWE+hZvpTRQ/im/ICt2lrB9f04woab9G1HakmLc88/4tmpuXyKkNW5WCppItthaCSviIK0bi4ChDHsPCF7nqXFsaowGYQnajbghA+aj9mIQ3JIgpsXQoZZMrcvfkDKfeEyRc1R3PN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZESjWDdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FBDC4CEFB;
	Wed, 31 Dec 2025 00:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767140770;
	bh=PFwLlogIu4R2ajnsWqW1SZ/tzhd5KMKkpBQoje0WF2M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ZESjWDdVRQhPogntnsXAhXXaF2dNs7ViIPrZjKMTj37+Ls9Kawe2+CmbxTah9m8aJ
	 ReDbTcVtVeqmYtzPBANMxWnnKNseC82L7c7lZydPMq1gMdVdS7lNdpYjF/c13vVRud
	 Dgr+917WXkxu5EI0daZ63j72fqJAbhpuF89XfhbdNTO/+m97soK1HPVRNygS5rrYpl
	 nnLmBm/iGijFpolRwfv53r4Jiyr6xtNr7toTTJFyzEGmmndfobXfyf4VxkV9FAcLDx
	 NL7mCx7LH8nY9QfLZ8Xi9ZWog53ddDHiodFfAcnv6sebaVA9mKTMyl2eI73N0j4y2z
	 Ij+lxjdU7WmKQ==
Content-Type: multipart/mixed; boundary="===============3641706620742822020=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bba828ccd8d2ef3871375809d56c8d66c161bc453f03df80090dc03cf31f50aa@mail.kernel.org>
In-Reply-To: <20251231000702.1625600-1-ihor.solodrai@linux.dev>
References: <20251231000702.1625600-1-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1] resolve_btfids: Implement --patch_btfids
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,nathan@kernel.org,nsc@kernel.org
Cc: bpf@vger.kernel.org,linux-kbuild@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 31 Dec 2025 00:26:09 +0000 (UTC)

--===============3641706620742822020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 2cbc252259be..1269efa06853 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> +static int patch_btfids(const char *btfids_path, const char *elf_path)
> +{
> +	Elf_Scn *scn = NULL;
> +	FILE *btfids_file;
> +	size_t shdrstrndx;
> +	int fd, err = -1;
> +	Elf_Data *data;
> +	struct stat st;
> +	GElf_Shdr sh;
> +	char *name;
> +	Elf *elf;
> +
> +	elf_version(EV_CURRENT);
> +
> +	fd = open(elf_path, O_RDWR, 0666);
> +	if (fd < 0) {
> +		pr_err("FAILED to open %s: %s\n", elf_path, strerror(errno));
> +		return -1;
> +	}
> +
> +	elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
> +	if (!elf) {
> +		close(fd);
> +		pr_err("FAILED cannot create ELF descriptor: %s\n", elf_errmsg(-1));
> +		return -1;
> +	}

[ ... ]

> +	err = 0;
> +out:
> +	elf_end(elf);
> +	return err;
> +}

Should the file descriptor fd be closed here? Looking at elf_collect() and its
cleanup in main(), the pattern is to call elf_end() and then close(fd)
separately. Without close(fd), error paths that reach 'goto out' after
successful open() and elf_begin() will leak the file descriptor.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20608784032

--===============3641706620742822020==--

