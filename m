Return-Path: <bpf+bounces-79546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB12D3BD8E
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 03:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A822302C21E
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8937B221F15;
	Tue, 20 Jan 2026 02:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik+c3HKa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14535966
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 02:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768876779; cv=none; b=UWuMfn1oHE/+2C9/+wpeAKWJARalLdKT2h2FOSSv0biD5jgROrCxnfwjnfKKt2NMqyTnKjjPSAk6Txd8MWQW5uvec1R5YZn5SNvlRPyOsK6aNjPgpIzvpXr5wMF/faiaisT+QU4A6Za2b+Yp4EoE2IlvE4MP9dvOOVzJp2s5JfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768876779; c=relaxed/simple;
	bh=If41zOkOP0scm5TZMIBjYL64Hb+I+qeK3M1HiwITHfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+Jl11pQVG+V9/z6vxAruoDRARqzkP3/oFpogMnf+S5Dx8EIFXFc8tGQ+XjkIENPmDETjobbbhZ7LKcNMJnSTOdxUuU1npoZwuOgsdUmMCQKis59TDCPQJ7R3WrmmWmIJxRdHPp+qv7E3I/rpFNHy91j5t4ZVixk9wfu17OZCbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik+c3HKa; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ad70765db9so5252821eec.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 18:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768876777; x=1769481577; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3odNBdrf6aEyMBCFvJIVDjybvUoKRUaMAkhxu2qWeKU=;
        b=ik+c3HKamVHlhaHcWAEv2ipNMs5lN7fUKMJbuxtIkz4iyzmMAhmOw73mg4YEaNKq9w
         rfoqa75VZj5eMc80Ww0Yn/rzu/cpIXBDO8O/iDZbiW2OTsHpq0cATNPW8JnqMJG/m+qz
         D3P+SuSIWkmcBGblP3W+o4pMYfxV1UthJ4+0YKuvEc/C+kv+f+EKKXajxYQI0Ac+xjxJ
         +ZO2ViRb0ghWm/pmi/ai4QpCsqxGWHw8jrIRDu/bi0xODkmNwHZtjsJQVgJPbhYxGBql
         MzfdUD7zdweBaoEoNDBmi8yDlxuqmbSMrTZCM61a0Wwa6yLmg5iX4Y4nDnFFex4Q1AXM
         Y85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768876777; x=1769481577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3odNBdrf6aEyMBCFvJIVDjybvUoKRUaMAkhxu2qWeKU=;
        b=h7FdciKDxyhNCnNmXMYmk0xlrwOLsWi2xsaDaIAYXXSMSPOkrdxm0JFlrLTkT7I+7K
         Siy2HWpeeOcqCRxe2ZrwhhEwJWuhMpzbT5FCRJ0+bAfVZdDO9uurWmpPOdwDDpZXgZ6m
         srwASuCZMTzn3YId3JNxBtSGjiMnPzze5A4e5adwAQeDpQvtNXqN25fv3e3MFTnJPt9M
         kcJK0oXz0x7h/92OE96QvqTptB1m+69dPtBL64OBO9c1Z8SZ9D9d6k0rzSm5Z+qCo+Cm
         08bGJNIZJ84Cy1bEwV+ZVPzUYdsvEUgDWUh1VGiPCjN/2LLnmlo9/SewcFwHV68SNKEY
         A4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW51mQt4rzubPUlPB2BNCUPQdZIADFbin1qhIfjv9bt2IimWL1gMC5G5Q88c3My4Ysw2gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX13SHpWK0C7RMtRZVjNs7/VvscSSAxu3ZJvlUDjCR5BR5OddU
	b1RMA/l3tiEm6wqJnh4hr2XJj/OKzJG7LwtJsy/ibQzyETYLB3GqDo2F4q5KJ7JJ
X-Gm-Gg: AZuq6aL3uLq2lPJmIEgDjmkcI/kFppALmz9a+iLU9pxpBqnO2xDxNpED90YdwrO4P4q
	7uS6TLK/nqSbuVQu0dfhyyzs+xPXl9jN0MUXg3Y7/NV9FDRuc8ie5jSXr+/Ph1UA+TRU1jCTjTB
	gXlb4J8gidFnpZxaaqsZQw+PmLeyGD/gRHQRhqxl90fc59DSDUOOvySXD2pmYoLBENW7XI3lJGq
	rViUjXh42GmvsZCQVy12kusq8XUhtKqhdPOdZbu6DZosWGcErXchxZPpTse7D58KMOblmwTzVb9
	4RqaoBjbgHC3D8dRKiXnmZzO/co6ND3Fs/z7OFhWssFZqbThxPOTHjHj9HMw0vQn9FEJL5LNBo7
	wy1OphrAtn8pzkPrii6YrBvsSb5SlQH5jAty3DunWjY8f7oeiW38TfqIImeo8+Bm0122crkzXSj
	FrA6DaVzIyVho3pPOC7UvDdizpjiKq0NfV8FZy+6XCxsX4JJDxYScIxQvQM9GkfmWuaw==
X-Received: by 2002:a05:7022:6084:b0:11b:9386:a3bf with SMTP id a92af1059eb24-1244b394b96mr9022978c88.42.1768870562325;
        Mon, 19 Jan 2026 16:56:02 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad740c5sm19462181c88.8.2026.01.19.16.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 16:56:01 -0800 (PST)
Message-ID: <c370026bdcb3c2684a5c5c5a9e173f8c3e2189e5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/13] resolve_btfids: Support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 16:55:59 -0800
In-Reply-To: <20260116201700.864797-6-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> Implement BTF modifications in resolve_btfids to support BPF kernel
> functions with implicit arguments.
>=20
> For a kfunc marked with KF_IMPLICIT_ARGS flag, a new function
> prototype is added to BTF that does not have implicit arguments. The
> kfunc's prototype is then updated to a new one in BTF. This prototype
> is the intended interface for the BPF programs.
>=20
> A <func_name>_impl function is added to BTF to make the original kfunc
> prototype searchable for the BPF verifier. If a <func_name>_impl
> function already exists in BTF, its interpreted as a legacy case, and
> this step is skipped.
>=20
> Whether an argument is implicit is determined by its type:
> currently only `struct bpf_prog_aux *` is supported.
>=20
> As a result, the BTF associated with kfunc is changed from
>=20
>     __bpf_kfunc bpf_foo(int arg1, struct bpf_prog_aux *aux);
>=20
> into
>=20
>     bpf_foo_impl(int arg1, struct bpf_prog_aux *aux);
>     __bpf_kfunc bpf_foo(int arg1);
>=20
> For more context see previous discussions and patches [1][2].
>=20
> [1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@=
linux.dev/
> [2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@li=
nux.dev/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Patch logic looks good to me, modulo LLM's memory management concern
and nit from Andrii.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -837,6 +854,369 @@ static int dump_raw_btf(struct btf *btf, const char=
 *out_path)
>  	return 0;
>  }
> =20
> +static const struct btf_type *btf_type_skip_qualifiers(const struct btf =
*btf, s32 type_id)
> +{
> +	const struct btf_type *t =3D btf__type_by_id(btf, type_id);
> +
> +	while (btf_is_mod(t))
> +		t =3D btf__type_by_id(btf, t->type);
> +
> +	return t;
> +}
> +
> +static const struct btf_decl_tag *btf_type_decl_tag(const struct btf_typ=
e *t)
> +{
> +	return (const struct btf_decl_tag *)(t + 1);
> +}

Nit: there is a utility function btf_decl_tag() in bpf/btf.h
     which does exactly the same.

[...]

