Return-Path: <bpf+bounces-76190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F8DCA98D7
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 23:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C19A63009C35
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 22:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492E12F0686;
	Fri,  5 Dec 2025 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE2wmCP3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB52673A5;
	Fri,  5 Dec 2025 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975475; cv=none; b=eUwF08txThZBEW2BjKkOG2WtWsrandlmf2BClN99C2SpYMl7eNGU6DX7aWIlJdaEgdWmRLdBOroDzLqrQilrwNb+hH+uDrnNH7YRBmyHOeWlO61ssLc6swxxNvegrG2/ZzP0ryKmw+bDI1nju2Da7954XYsJ7LJwU3uBLXLzwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975475; c=relaxed/simple;
	bh=yIpJd0rdcs/kiG7NTf1domiETaKtVAhUkGFqP01G2Ec=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uUU9qESLZp8uNZJxrCBkahW6+CgJCh/x3RFrJx+QeoQuuGKtau7j0Pu7bTKnqln3+jVNFfbZTLLYMqyb6qeenaKNSioFvcWprHwBXC1uwAHR8rVkjUQ+IIGexohBS5RxyDxaR1b9Svw5cyR2f8gZ7yP6nrRnGt9BE7uw4giT1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE2wmCP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38BCC4CEF1;
	Fri,  5 Dec 2025 22:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764975475;
	bh=yIpJd0rdcs/kiG7NTf1domiETaKtVAhUkGFqP01G2Ec=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jE2wmCP3DvpDPtTghjnjcsz7Ukgb3iHNw2NO0EILZR6d+98h/VgZ+f6q9x4qMyDln
	 KD/6pwpOjB7at4fJCKSmjYHrOHlC1FaeVycmQIBtQM/dyzpTSHdIWLE4TzdGcZY+fV
	 2gJpKuX07GeXCeQVgrGQ5BTR88pNC0tMphjGsGCI47RBcejTyCVUv7+JcKzSjzFMkY
	 nWm1y08vyHFFR3/Uzei5SXd0Jhktrx78cOw3en6P9XFaG7uI4ZtE6chwQaRCdM2x5P
	 jLM7dTpMpe2iF54pCutSTJtsa/rPa/YsjwNjH/KHBUxGqd/jsXw2GHQBi2FJiVOcDp
	 6q21409ehug7g==
Content-Type: multipart/mixed; boundary="===============2082480252635971513=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e7478657b0308d8c4c16f5f412e92a3dbf565b0777424bd6d163d1d8288cf10a@mail.kernel.org>
In-Reply-To: <20251205223046.4155870-3-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-3-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 2/6] resolve_btfids: Factor out load_btf()
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,akpm@linux-foundation.org,nathan@kernel.org,nsc@kernel.org,tj@kernel.org,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,shuah@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com,alan.maguire@oracle.com,dolinux.peng@gmail.com
Cc: bpf@vger.kernel.org,dwarves@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Dec 2025 22:57:52 +0000 (UTC)

--===============2082480252635971513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 164f0c941f04..b4caae1170dd 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -529,16 +532,10 @@ static int symbols_collect(struct object *obj)
>  	return 0;
>  }
>
> -static int symbols_resolve(struct object *obj)
> +static int load_btf(struct object *obj)
>  {
> -	int nr_typedefs = obj->nr_typedefs;
> -	int nr_structs  = obj->nr_structs;
> -	int nr_unions   = obj->nr_unions;
> -	int nr_funcs    = obj->nr_funcs;
> -	struct btf *base_btf = NULL;
> -	int err, type_id;
> -	struct btf *btf;
> -	__u32 nr_types;
> +	struct btf *base_btf = NULL, *btf = NULL;
> +	int err;
>
>  	if (obj->base_btf_path) {
>  		base_btf = btf__parse(obj->base_btf_path, NULL);
>  		err = libbpf_get_error(base_btf);
>  		if (err) {
>  			pr_err("FAILED: load base BTF from %s: %s\n",
>  			       obj->base_btf_path, strerror(-err));
> -			return -1;
> +			goto out_err;
>  		}
>  	}
>
>  	btf = btf__parse_split(obj->btf_path ?: obj->path, base_btf);
>  	err = libbpf_get_error(btf);
>  	if (err) {
>  		pr_err("FAILED: load BTF from %s: %s\n",
>  			obj->btf_path ?: obj->path, strerror(-err));
> -		goto out;
> +		goto out_err;
>  	}
>
> +	obj->base_btf = base_btf;
> +	obj->btf = btf;
> +
> +	return 0;
> +
> +out_err:
> +	btf__free(base_btf);
> +	btf__free(btf);
> +	return err;

Can btf__free() safely handle ERR_PTR values here?

When btf__parse() fails on line 541, it returns ERR_PTR(-err), and
libbpf_get_error() extracts the error code, but base_btf still holds
the ERR_PTR value. The error path then calls btf__free(base_btf)
where base_btf is ERR_PTR rather than NULL or a valid pointer.

The same issue occurs if btf__parse_split() fails on line 550, where
btf contains ERR_PTR when btf__free(btf) is called.

In the old code at symbols_resolve(), if base_btf was ERR_PTR, the
function would return -1 immediately without calling btf__free(),
avoiding this issue. The new error handling with goto out_err changes
this behavior.

> +}
> +
> +static int symbols_resolve(struct object *obj)
> +{
> +	int nr_typedefs = obj->nr_typedefs;
> +	int nr_structs  = obj->nr_structs;
> +	int nr_unions   = obj->nr_unions;
> +	int nr_funcs    = obj->nr_funcs;
> +	struct btf *btf = obj->btf;
> +	int err, type_id;
> +	__u32 nr_types;
> +
>  	err = -1;
>  	nr_types = btf__type_cnt(btf);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19978081551

--===============2082480252635971513==--

