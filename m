Return-Path: <bpf+bounces-76947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87704CC9ECB
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 640303053086
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75212264CD;
	Thu, 18 Dec 2025 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7ZenOoM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565BA1DFDA1;
	Thu, 18 Dec 2025 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018851; cv=none; b=t0kPGVq0U/03IVZerxsR7XqsJKu8q4OcD7ACKx5JTtkorUxFaSKrZgJ8G1mRKJMs2S/C+R873zraJjQkFvsudo4+2XPAPYxZVeElts50H22DeJkj5B9DXebLUSfvGKMpkqVweoWT0LES316pMxGcQbfw9pKP7kUZhq+54fc2494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018851; c=relaxed/simple;
	bh=E8sAIcVg1PzVskIljHV4RS3WEpZOWSUATNnW7aZI7/E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ou0YBCqTE4VagG7u6vL/1OvcR0ndinmHXyTPWd6uqknjkoCTw/+xyBSX/WAQ8A08fJp79opYGiVodkNGZUhOVcq0TfIuqopFHmkupIRLSlEuYmBo5kyb0HDLUhU0tPMrjnIrJWyThO1gC92IPgY4YCi2v+Zzct6RnO0iswp3S+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7ZenOoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC22C4CEF5;
	Thu, 18 Dec 2025 00:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766018850;
	bh=E8sAIcVg1PzVskIljHV4RS3WEpZOWSUATNnW7aZI7/E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=k7ZenOoMZ+SZnya3iTdP17V5YV9lyv6jRs5Elr1HeLqhUVTdtWgrKFB4vrQtyC28p
	 i5yXVcRhPdVL7a3D1nDxyte4/8j5bwfyR4k/rnygmflIo3hgTapJAI+ItvfGFMclC6
	 JObuECDmkRs8gsm3CFwZXr5Pc/a9RLs32IkRP+HINeoR/lfiZgFuHlkAwU7gK3s1CV
	 ZwRIcXmdo3gTwDMIQHkZdu/xUnJ6S9qkOeov1FcYyHZCCh0lNZQp8nZRHRyFx26mzQ
	 5kE2Z0IJ8AsNLlSQXh+4uor8NgVjnEZniOVrTjbo1rM95VHwBWogloTWW2YW1uv5wj
	 M866+OPMhdU1w==
Content-Type: multipart/mixed; boundary="===============8902308381200231805=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <106b6e71bce75b8f12a85f2f99e75129e67af7287f6d81fa912589ece14044f9@mail.kernel.org>
In-Reply-To: <20251218003314.260269-4-ihor.solodrai@linux.dev>
References: <20251218003314.260269-4-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 3/8] resolve_btfids: Introduce enum btf_id_kind
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,alan.maguire@oracle.com,ast@kernel.org,arighi@nvidia.com,akpm@linux-foundation.org,andrii@kernel.org,morbo@google.com,changwoo@igalia.com,daniel@iogearbox.net,void@manifault.com,dolinux.peng@gmail.com,eddyz87@gmail.com,haoluo@google.com,jolsa@kernel.org,john.fastabend@gmail.com,corbet@lwn.net,justinstitt@google.com,kpsingh@kernel.org,martin.lau@linux.dev,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,nsc@kernel.org,shuah@kernel.org,song@kernel.org,sdf@fomichev.me,tj@kernel.org,yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,dwarves@vger.kernel.org,linux-kbuild@vger.kernel.org,linux-kernel@vger.kernel.org,sched-ext@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 18 Dec 2025 00:47:30 +0000 (UTC)

--===============8902308381200231805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index b4caae1170dd..da8c7d127632 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -260,22 +279,36 @@ static char *get_id(const char *prefix_end)
>  	return id;
>  }
>
> -static struct btf_id *add_set(struct object *obj, char *name, bool is_set8)
> +static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind kind)
>  {
> +	int len = strlen(name);
> +	int prefixlen;
> +	char *id;
> +
>  	/*
>  	 * __BTF_ID__set__name
>  	 * name =    ^
>  	 * id   =         ^
>  	 */
> -	char *id = name + (is_set8 ? sizeof(BTF_SET8 "__") : sizeof(BTF_SET "__")) - 1;
> -	int len = strlen(name);
> +	switch (kind) {
> +	case BTF_ID_KIND_SET:
> +		prefixlen = sizeof(BTF_SET "__") - 1;
> +		break;
> +	case BTF_ID_KIND_SET8:
> +		prefixlen = sizeof(BTF_SET8 "__") - 1;
> +		break;
> +	default:
> +		pr_err("Unexpected kind %d passed to %s() for symbol %s\n", kind, __func__, name);
> +		return NULL;
> +	}
> +
> +	id = name + prefixlen - 1;

Is this off by one? The original code computed:

    id = name + sizeof(BTF_SET "__") - 1

For BTF_SET ("set"), this gives: name + sizeof("set__") - 1 = name + 6 - 1 = name + 5

The new code computes:

    prefixlen = sizeof(BTF_SET "__") - 1 = 6 - 1 = 5
    id = name + prefixlen - 1 = name + 5 - 1 = name + 4

The -1 appears to be applied twice now, once in the prefixlen assignment and
again when computing id. Should this line be:

    id = name + prefixlen;

>  	if (id >= name + len) {
>  		pr_err("FAILED to parse set name: %s\n", name);
>  		return NULL;
>  	}
>
> -	return btf_id__add(&obj->sets, id, true);
> +	return btf_id__add_unique(&obj->sets, id, kind);
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20321956014

--===============8902308381200231805==--

