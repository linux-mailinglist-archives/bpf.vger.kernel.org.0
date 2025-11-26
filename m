Return-Path: <bpf+bounces-75529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05AC87C88
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 03:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 030A74E324F
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F041C30C629;
	Wed, 26 Nov 2025 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hni/0795"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564AB3093AE;
	Wed, 26 Nov 2025 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764122981; cv=none; b=AH6FmylsKLEgCqu18n8zNwV2LQhZQ3xqDr01zURhQZ200Toqz8oCdhy3jT/V6JJuiEdlL+mrHJb5iykjq0yLF5B4k75InJY+1dtxAy/Sayx4ChRVCAwLJpiPN7Q/h6CHw8Wg4hk0O6TOT5TDsUS3sf8nVn9TN7ZspJE0XnuHsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764122981; c=relaxed/simple;
	bh=GNRouItlwhEhXARnY6Uq9pIJfsOtOCCqaYXtT6Z/ye0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JM+3kyarRc0wwCZO7Ads/3zoAnF9z8JuyksCPqqLwpQHLp03TahDM9o7gQ/fLd2bmTkkfxTooedxk/TE3AC8g8n74kUgm2Icv0KCxSAkHKnX8hvYsKi5mWkwGgdyICZjQzGkDU5bkzo4X0wAaByCSCZ7T71ufrwEGDewOB4qFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hni/0795; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496A8C4CEF1;
	Wed, 26 Nov 2025 02:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764122980;
	bh=GNRouItlwhEhXARnY6Uq9pIJfsOtOCCqaYXtT6Z/ye0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Hni/0795yBUCUdwVg4H1BEQQT6BBSckFajoCjnTEpZBkjPEM3wxuFjIeW1CFqUu/B
	 LO1UKVcz7k9EkVj3HFQYLB+6AGnJISfXNZhQa8vwMknQ5n9J/diZcYfkcYN0rXVIso
	 utCDWpxSLE52AebqB+dCrXTP0CT356F+NuVEsp20XGDidIsrJEnSg5ZGRFolqC3Xac
	 07RrOgBdehKCyH3ZNw4i0kcgOaBlc75m20SE6ZqOfCF8q0q2JsqYL2eBwkfNuxY4dH
	 VAeRF5Lnazt/AxcpSGJY3A+uoSVBXTt6ns9eavqES6qBevp1s44to+C6a+Xdp+x9xW
	 hdQXKmvJnEd7w==
Content-Type: multipart/mixed; boundary="===============6839250700952787150=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3d0b94b9fdd5150c136784b5e6904264e5fb09a00d8512e459ec6c3046ed9abb@mail.kernel.org>
In-Reply-To: <20251126012656.3546071-4-ihor.solodrai@linux.dev>
References: <20251126012656.3546071-4-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 3/4] resolve_btfids: introduce enum btf_id_kind
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,nathan@kernel.org,nicolas.schier@linux.dev,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,dwarves@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,alan.maguire@oracle.com,dolinux.peng@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Nov 2025 02:09:40 +0000 (UTC)

--===============6839250700952787150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index b7b44e72e..7f5a9f7dd 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -260,26 +266,33 @@ static char *get_id(const char *prefix_end)
>  	return id;
>  }
>
> -static struct btf_id *add_set(struct object *obj, char *name, bool is_set8)
> +static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind kind)
>  {
>  	/*
>  	 * __BTF_ID__set__name
>  	 * name =    ^
>  	 * id   =         ^
>  	 */
> -	char *id = name + (is_set8 ? sizeof(BTF_SET8 "__") : sizeof(BTF_SET "__")) - 1;
> +	int prefixlen = kind == BTF_ID_KIND_SET8 ? sizeof(BTF_SET8 "__") : sizeof(BTF_SET "__");
> +	char *id = name + prefixlen - 1;
>  	int len = strlen(name);
> +	struct btf_id *btf_id;
>
>  	if (id >= name + len) {
>  		pr_err("FAILED to parse set name: %s\n", name);
>  		return NULL;
>  	}
>
> -	return btf_id__add(&obj->sets, id, true);
> +	btf_id = btf_id__add(&obj->sets, id, true);
> +	if (btf_id)
> +		btf_id->kind = kind;
> +
> +	return btf_id;
>  }
>
>  static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
>  {
> +	struct btf_id *btf_id;
>  	char *id;
>
>  	id = get_id(name + size);
> @@ -288,7 +301,10 @@ static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
>  		return NULL;
>  	}
>
> -	return btf_id__add(root, id, false);
> +	btf_id = btf_id__add(root, id, false);
> +	btf_id->kind = BTF_ID_KIND_SYM;
                 ^^^^

Can add_symbol() dereference a NULL pointer here? The function
btf_id__add() can return NULL on allocation failure (when zalloc fails),
but the new code sets btf_id->kind before checking if btf_id is NULL.

In contrast, add_set() checks for NULL before setting the kind field.
Should add_symbol() do the same?

> +
> +	return btf_id;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19689674924

--===============6839250700952787150==--

