Return-Path: <bpf+bounces-78146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45802CFF4A7
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D5D43000DFA
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE251335BAF;
	Wed,  7 Jan 2026 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKl3+A28"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA183385B3
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767809292; cv=none; b=Vq3dI/8KFMh4mLxhMDrc0DFI0PL3LW9/SJvGi/efTqSXdZMaRnCoGYjiUbffZwksMi3DlF2E0IRtWe5J4fOxhdODLIohtD3OLecjWYZ/Ynf4MvWeDc6PZl7hXkr+0ZSpOf9cp0oreZB7YjXtOg0oTP8P8LAvz8GQIbtAYBf5buw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767809292; c=relaxed/simple;
	bh=+g+NKEx7tWKhm5+SLjoaSYYRyJwJD6n6NYk+q4LHdRA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ph9OIgSzq2xdYsrmsORpLQDZm6p5pxLBTOF1pHRMm2PbYutrv+Um+Q/4hii+ph7F8bR56mxXgG1kAiZM1fboc3v4n+hDLHA68RqvJRBj2EK2HBJ5/NbgkQJ8S2AEwZqL7iZYgjW5rbMBmREpztV9cOxljY59cjtH1/K3XO4ixfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKl3+A28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6A2C4CEF1;
	Wed,  7 Jan 2026 18:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767809291;
	bh=+g+NKEx7tWKhm5+SLjoaSYYRyJwJD6n6NYk+q4LHdRA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=JKl3+A28qTV4P+E+upNTecTg3mtyW5fdPe/02M69i0JnW5OIpT5fkjM8fXzW5mdHb
	 NW/Lu+X3bOQG0Ux1j7eoAOBbVk2R5Bgl5n1AVjSlliZBNmaP+1jOQb18Qyng4Dfgr+
	 d7U4/Av9S6cgF+dHUKubmJwgW9KYLdcupG/E+HFjEFq7LpJEsWqsOlGeq5ZlWZnrbK
	 Kn88U3xZUL1w/4Kac+3/ZhK3meV0FrIhUbUFdxEJHdwEJwu+RMTmXXeaAPan5+2h/K
	 i+SSoY6Qkm1dWWKAG27+zAQO3sscgETPdD7w72fcqzDtiMAsi0nkA05ppz2s8ch6RN
	 WhE7sIDyJHE8A==
Content-Type: multipart/mixed; boundary="===============2682747788224255827=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fb0b4b7a235f51ad07038f9d9b074561c4302e6f0df950be35477c80e4ae5076@mail.kernel.org>
In-Reply-To: <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com>
Subject: Re: [PATCH RFC v3 04/10] bpf: Add lock-free cell for NMI-safe async operations
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,memxor@gmail.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  7 Jan 2026 18:08:11 +0000 (UTC)

--===============2682747788224255827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/mpmc_cell.h b/kernel/bpf/mpmc_cell.h
> new file mode 100644
> index 000000000000..8b57226927a6
> --- /dev/null
> +++ b/kernel/bpf/mpmc_cell.h
> @@ -0,0 +1,112 @@

[ ... ]

> + * Typical usage:
> + *
> + *   // Writer (from NMI or any context):
> + *   cell = bpf_mpmc_cell_write_begin(ctl);
> + *   if (!IS_ERR(cell)) {
> + *       memcpy(cell, data, size);
> + *       bpf_mpmc_cell_write_commit(ctl);
> + *   }

Should this check be "if (cell)" instead of "if (!IS_ERR(cell))"?

bpf_mpmc_cell_write_begin() returns NULL when another writer is active,
not an ERR_PTR. Since IS_ERR(NULL) returns false, "!IS_ERR(cell)" will
evaluate to true when cell is NULL, causing the memcpy to execute with
a NULL pointer.

The function documentation correctly states "Return: Pointer to the
write cell, or NULL if another writer is active", but the example code
here uses the wrong check pattern.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20791345842

--===============2682747788224255827==--

