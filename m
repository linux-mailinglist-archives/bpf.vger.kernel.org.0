Return-Path: <bpf+bounces-78203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6394D00F0C
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 963273079C90
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59528288517;
	Thu,  8 Jan 2026 03:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKXBgpKz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E528689A;
	Thu,  8 Jan 2026 03:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843978; cv=none; b=tM8Skxcq5BjHbc5PYOxcwwsZhYqtzVj8tanRdejPNuaHt0dVt7TNnpHzBjvlKm637G9xa98T22d2kmg/g1GCV4hyiqDwkVVRmNu1+u3HqsSNfk8b079K8+KLCml0g0c4Hqnq/hd+tLQByuLC3a1GO7yLrZL3LUJ4nADYmnLu/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843978; c=relaxed/simple;
	bh=wHo7BpmW7oADz2KvCcu7ctEoBYPEwqptvUhon0SxSd8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=naciN+UGSD+IcbGZq3n5Ro7z4fyRX6eVEIRhADeKQsKAIdPUSREUQCgx5I+3YrudiADf0vubVKBeVGRBqEbvDttNeF05Atrr8vGnRqX5pD48/jlpLUW8A7qDIdKp/tdZ6R8vMIXBWgrhS4Q3er3fQ0wtoxn1EN421//aD8GhlCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKXBgpKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FEDC116C6;
	Thu,  8 Jan 2026 03:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767843978;
	bh=wHo7BpmW7oADz2KvCcu7ctEoBYPEwqptvUhon0SxSd8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tKXBgpKz5XVC9MdaMPygbPV/6Rb4D+lwdXlrmJoYDYxMOTHGKPe62dFLG7obKFku0
	 zMohGyIysiDC+1vEe/hQUb5CXCWBDAzcEBSLCHtGwxioyZMaWDz8EFpThAoiTWle6j
	 Tlf94JZhgtAQIzJKDNWR5cmyLiZX2GTYqtmQ3d48nRLOZoAn42BT9tY7y+O2io3x7r
	 WD3ylzrpL02wwlur+oPW0vftpc+21PA2QCsrdQlZTT3CXGwkrLYd5HBP+Fcu+1jZtW
	 NW6w5yKE+9sLawatuezD2qx/TU0L7qzxI3v4UxnzuEgX29XkWHOhDQgfTK6ELTzm3x
	 kH0/bcKCNNTQw==
Content-Type: multipart/mixed; boundary="===============5555159130815298173=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4741560dd9cff0cf2643b9ea291154e91a2ce3e57370f020d0b346230a98efb1@mail.kernel.org>
In-Reply-To: <20260108031645.1350069-5-dolinux.peng@gmail.com>
References: <20260108031645.1350069-5-dolinux.peng@gmail.com>
Subject: Re: [PATCH bpf-next v11 04/11] libbpf: Optimize type lookup with binary search for sorted BTF
From: bot+bpf-ci@kernel.org
To: dolinux.peng@gmail.com,ast@kernel.org,andrii.nakryiko@gmail.com,eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,pengdonglin@xiaomi.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  8 Jan 2026 03:46:17 +0000 (UTC)

--===============5555159130815298173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index bf75f770d29a..60ff8eafea83 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -897,46 +899,83 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
>  	return type_id;
>  }
>
> -__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> -{
> -	__u32 i, nr_types = btf__type_cnt(btf);
> -
> -	if (!strcmp(type_name, "void"))
> -		return 0;
> -
> -	for (i = 1; i < nr_types; i++) {
                  ^
The original btf__find_by_name() started iteration from ID 1, which meant
it would search through ALL types including those in base BTF for split
BTF scenarios. The btf__type_by_id() call would transparently access
base BTF types when i < btf->start_id.

> -		const struct btf_type *t = btf__type_by_id(btf, i);
> -		const char *name = btf__name_by_offset(btf, t->name_off);
> -
> -		if (name && !strcmp(type_name, name))
> -			return i;
> -	}
> -
> -	return libbpf_err(-ENOENT);
> -}

[ ... ]

> +/* the kind value of -1 indicates that kind matching should be skipped */
> +__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> +{
> +	return btf_find_by_name_kind(btf, btf->start_id, type_name, -1);
                                        ^^^^^^^^^^^^^^^
Is this intended to change the split BTF lookup behavior? The new
implementation passes btf->start_id as the start_id parameter, which
means for split BTF the search will only cover types in the current BTF
instance, not the base BTF.

In btf_find_by_name_kind(), the base BTF is only searched when
start_id < btf->start_id, but here start_id == btf->start_id so that
condition is never true.

Compare with btf__find_by_name_kind() which still passes 1 as start_id:

  __s32 btf__find_by_name_kind(const struct btf *btf, ...)
  {
      return btf_find_by_name_kind(btf, 1, type_name, kind);
  }

This creates an inconsistency where btf__find_by_name_kind() searches
base BTF but btf__find_by_name() does not. Was this behavior change
intentional? If so, perhaps the commit message should mention it.

> +}
> +
>  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
>  				 __u32 kind)
>  {
>  	return btf_find_by_name_kind(btf, btf->start_id, type_name, kind);
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20804442135

--===============5555159130815298173==--

