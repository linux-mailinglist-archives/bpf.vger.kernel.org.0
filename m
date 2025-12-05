Return-Path: <bpf+bounces-76188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62608CA989B
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 23:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFED316DB4F
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 22:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784A62F3614;
	Fri,  5 Dec 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDzS2g7q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD50C29C33F;
	Fri,  5 Dec 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764974983; cv=none; b=LchLBJ7d3j8+MBHcMVmhKojZKHIOnOFAkReR8k/F5ZwHQLuiErH0jA238Zch9/RdlQvyXFlfde7HmIENf8IZYYyVVs4uiSG2syq8igbb6k8vnEwanu5sHNTCLLwCjClll5mKWFbIMuAHt9JQ3DWlxj7j7WKUgVEaz4CYxxYdb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764974983; c=relaxed/simple;
	bh=Gm7jo7eEYyf9Zz8Pc4OyJQMc3Y8CYH5hlPog4/Vvfw0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QE9oiFQECH5ehgRH4EqT+1v82zYGoiFRY8fsRsnAVWXAYA8aXLrSdvv8psjxtOvBYdjld6M78gg80uAPDZ/+XFwDjJdeQxxcWYv5OEplulrSH2rOXyWRwYFJpJGyiQbM5XVC2+6P7HiA7Ujz7j2N4kNdYLUm/OO/OPG8cz5TID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDzS2g7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0443C4CEF1;
	Fri,  5 Dec 2025 22:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764974982;
	bh=Gm7jo7eEYyf9Zz8Pc4OyJQMc3Y8CYH5hlPog4/Vvfw0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EDzS2g7qTm9mI1DabNZXYmkFyFjOc5iB0Lhi10+4Jsd5sHs6eIwkPRQjTqTJnyTJ6
	 Dwm+EwMvBQbzcSYMbxzlbwFajmK/wZ31y71Culyu8CSoWIiEkriHsH+4mn4A3uR6zO
	 jVBJGwlBrCYcPadVmkzKf37qf6ZpVmL5VbPLWMP1dDuBlQM2IoruDvJsfy4iXtx/pf
	 uypIIPGQfHVi4jkU3AtFC0/5MPtFdmYCmRPRwBr95+6y1+vnGyG1yGDH/vi/mcrwrG
	 4VCHciD3F+23/b0xNuPnYTvH3rR81WgHyoIuLO6XPvmYCPpqEqdoXDmakYsPjrTavx
	 MmfMftXKEjWcw==
Content-Type: multipart/mixed; boundary="===============4496188185226421115=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2475b1c6ce4e9249129ca007de68b80cc4d32a0949e391a2de4467bf599f25f7@mail.kernel.org>
In-Reply-To: <20251205223046.4155870-5-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-5-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 4/6] lib/Kconfig.debug: Set the minimum required pahole version to v1.22
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,akpm@linux-foundation.org,nathan@kernel.org,nsc@kernel.org,tj@kernel.org,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,shuah@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com,alan.maguire@oracle.com,dolinux.peng@gmail.com
Cc: bpf@vger.kernel.org,dwarves@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Dec 2025 22:49:39 +0000 (UTC)

--===============4496188185226421115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 742b23ef0d8b..3abf3ae554b6 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug

[ ... ]

> -config PAHOLE_HAS_SPLIT_BTF
> -	def_bool PAHOLE_VERSION >= 119

The PAHOLE_HAS_SPLIT_BTF config option was removed here.

[ ... ]

> diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
> index 16a42e4060f6..56a9d1557ac4 100644
> --- a/tools/sched_ext/README.md
> +++ b/tools/sched_ext/README.md
> @@ -65,7 +65,6 @@ It's also recommended that you also include the following Kconfig options:
>  ```
>  CONFIG_BPF_JIT_ALWAYS_ON=y
>  CONFIG_BPF_JIT_DEFAULT_ON=y
> -CONFIG_PAHOLE_HAS_SPLIT_BTF=y
>  CONFIG_PAHOLE_HAS_BTF_TAG=y
>  ```

The PAHOLE_HAS_SPLIT_BTF reference was removed from
tools/sched_ext/README.md, but Documentation/scheduler/sched-ext.rst
still contains this config option at line 46. Should that documentation
file also be updated to remove this obsolete config option?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19978081551

--===============4496188185226421115==--

