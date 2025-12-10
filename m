Return-Path: <bpf+bounces-76439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A40CB4010
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 230753034727
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E024A32ABF7;
	Wed, 10 Dec 2025 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ1XZ0Qp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5866F324714;
	Wed, 10 Dec 2025 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400153; cv=none; b=KlbTCAgWQ8KW2GVgRN+2S5TyjysPltflpWUXdSX/KTyeoLxFJpk0ELKV/7I1XkxNzebHbSDdrP4PR7vMq9vmkYNMPNj/Dy227l8yYOlgsIv+dlt+Ut10XWd1eX16XnJKJlC3qMqzIpv8xTdCXK66gvPgLSzZyp7RCmsJ2LaS51E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400153; c=relaxed/simple;
	bh=uyIkShaLcoqZpx6snh+flXxvjp6/m7h117LlmkMB2+w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hgjrQwWuWIiA9I4NKqwVfIYjksINqtGMgtFw/neukTCmEDKZXUC/eawoDtreT3KCoIQW9FUr1WTbszeXMGa5T38X9xWmc0jZ0hxot81udBjkDIIJoHzhwtwVJqLu6E+7SNRTEqgN9hIgHqXH0cmfrGssBH5D24ElEaDOkdQ7n30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ1XZ0Qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9F7C4CEF1;
	Wed, 10 Dec 2025 20:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765400153;
	bh=uyIkShaLcoqZpx6snh+flXxvjp6/m7h117LlmkMB2+w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=SQ1XZ0QpbEzKQeLvtMCfwb8xlKdPsfAX2kwvvbX2QJlWCes8EdVoIVulW6qz26P3c
	 qC+87Mij0Dcfk0jXzCfMF0uU/Kqk+U1aKZLoNE2L2lQ5TUmiNDLk+EHbtmbKf4xXdV
	 E3beA/bO/KD5IC4O3z6GEb9xbRdDOmIg8OQnYgI7itrzHamyGwjztlNEcX7iJ//UmJ
	 DLw5VEy1Zl1YBE3ozZiBzRK0usYM58hrk7/4g2FXSiED8XE8YKoT704HwExeJiNIX0
	 jwKld5N+uboojnQqRVtF58j/x2H11tycE9FvcWTJVKwk+wNT/qdwvNh80pMaCPkKZa
	 inElC1+djpB6w==
Content-Type: multipart/mixed; boundary="===============1423129802722490830=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6afdd2cf0740a9bcd03977565c9f02ed9e5490254e88b2ecd473c22cda6367dc@mail.kernel.org>
In-Reply-To: <20251210203243.814529-6-alan.maguire@oracle.com>
References: <20251210203243.814529-6-alan.maguire@oracle.com>
Subject: Re: [PATCH v6 bpf-next 05/10] libbpf: BTF validation can use kind layout for unknown kinds
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,dwarves@vger.kernel.org,bpf@vger.kernel.org,ttreyer@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Dec 2025 20:55:51 +0000 (UTC)

--===============1423129802722490830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2133e976cb9c..19e37a543e9a 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -691,8 +691,12 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
>  		break;
>  	}
>  	default:
> -		pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
> -		return -EINVAL;
> +		/* Kind may be represented in kind layout information. */
> +		if (btf_type_size_unknown(btf, t) < 0) {
> +			pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
> +			return -EINVAL;
> +		}
> +		break;
>  	}
>  	return 0;
>  }

The btf_type_size_unknown() function is called to validate unknown kinds
by checking the kind_layout array. Can the bounds check in
btf_type_size_unknown() read past the end of the kind_layout array?

In btf_type_size_unknown():

    if (btf->kind_layout)
        k = &((struct btf_kind_layout *)btf->kind_layout)[kind];

    if (!k || (void *)k > ((void *)btf->kind_layout + btf->hdr->kind_layout_len)) {
        pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
        return -EINVAL;
    }

    size += k->info_sz;
    size += vlen * k->elem_sz;

The check uses '>' to test if k exceeds the array bounds. If kind equals
the number of elements in the array (kind == kind_layout_len /
sizeof(struct btf_kind_layout)), then k points exactly at the array
boundary. The check evaluates k > end as false (since k == end), so the
validation passes and the code proceeds to dereference k, reading
out-of-bounds memory.

For comparison, btf__type_by_id() uses '>=' for its bounds check:

    if (type_id >= btf->start_id + btf->nr_types)
        return errno = EINVAL, NULL;

Should the bounds check in btf_type_size_unknown() use '>=' instead of
'>' to prevent reading one element past the end of the kind_layout array?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20112692486

--===============1423129802722490830==--

