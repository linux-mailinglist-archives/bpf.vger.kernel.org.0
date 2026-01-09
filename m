Return-Path: <bpf+bounces-78297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C53D08948
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 11:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EBDF3029D1E
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE5933557C;
	Fri,  9 Jan 2026 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKy4c/zf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E602E762C
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954814; cv=none; b=P9uL2PjRO0z+LUbJpYYiH3uXlIoAk6pBiL9q6lERlTFFEUN/q17yTbomp1ZdMdcsgV+T2cB1dW5XL1kfNCvpsLdGLTvQratR+ukEFdgjO3DDwT6xIi74fJc9BBpRa+UXB3WmxwI9Y/M6VCrsonF7xDz4PTIP+QTDTwRv1lhwYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954814; c=relaxed/simple;
	bh=Nl1yZ5+uDfyJeMqFW6duXjW+AjbzoqZ8ML+mcmwIx4I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aw69Z5uzn1SufVNQt4/hf2BM04/nOciZNThCE8eRaHMyrPyOD4a4B+Aqr4Jn0toDAQ8x3aDiU+O/nIZi6jTV1bRnrDLafHzRVltRxM6dRbc7VVewjLvqfAp0rW08zoRNyj8FHRy4C1Ln6xKF3+2BLNMum/1qLNTBerDZHfqHNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKy4c/zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E342C4CEF1;
	Fri,  9 Jan 2026 10:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767954814;
	bh=Nl1yZ5+uDfyJeMqFW6duXjW+AjbzoqZ8ML+mcmwIx4I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rKy4c/zftrvhuA+uoZ2Kw+vwAGQfA6jxwKAWTk5hs7t32r0rGDrrKQzgNZGzJnyeu
	 ssEwxyU4c+elHux5mbZ2L5vVGxZXFTwGGNunOOb7h4RKiWqB3sY8b2eIQ7hlaFbM6Y
	 9uitl3pbplayTSfRGmZ7By2QRYRkWkrvRhG9IWLsfcdsRJABt+ZfP3S1Sw8ESQ22M4
	 VIdOoJHV4ZbG98l3Qut6fj3CsE4ji+21jGPJzlsTx4Mm86VTcDMiNG2x3z5J8O2O0C
	 j1LrJPToTN2QFYVIvP6mmxAxZ5joXtQCqAg71gobhE42isy1GffphDUaNK3G2fl/UW
	 WRmE2IFLL04BA==
Content-Type: multipart/mixed; boundary="===============1385388474747249984=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <30e36e721900df2580a112faeba7c725911347d2bc925656d241a7a42d754727@mail.kernel.org>
In-Reply-To: <20260109101325.47721-1-alan.maguire@oracle.com>
References: <20260109101325.47721-1-alan.maguire@oracle.com>
Subject: Re: [PATCH bpf] libbpf: BTF dedup should ignore modifiers in type equivalence checks
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org
Cc: ast@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,nilay@linux.ibm.com,bvanassche@acm.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  9 Jan 2026 10:33:34 +0000 (UTC)

--===============1385388474747249984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 84a4b0abc8be..8ef0354e66cc 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -4688,7 +4686,24 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>  		return fwd_kind == real_kind;
>  	}
>
> -	if (cand_kind != canon_kind)
> +	/*
> +	 * Types are considered equivalent if modifiers (const, volatile,
> +	 * restrict) are present for one but not the other.
> +	 */
> +	if (cand_kind != canon_kind) {
> +		__u32 next_cand_id = cand_id;
> +		__u32 next_canon_id = canon_id;
> +
> +		if (btf_is_mod(cand_type) && !btf_is_type_tag(cand_type))
> +			next_cand_id = cand_type->type;
> +		if (btf_is_mod(canon_type) && !btf_is_type_tag(canon_type))
> +			next_canon_id = canon_type->type;
> +		if (cand_id == next_cand_id && canon_id == next_canon_id)
> +			return 0;
> +		return btf_dedup_is_equiv(d, next_cand_id, next_canon_id);
> +	}

Can this recursive call fail when there are multiple levels of modifiers?

Consider comparing "volatile const int" (cand_id=20) against "int" (canon_id=5):

1. The first call adds hypot_map[5] = 20 via btf_dedup_hypot_map_add()
   earlier in btf_dedup_is_equiv() before the kinds are checked.

2. btf_is_mod(VOLATILE) is true, so next_cand_id becomes the underlying
   "const int" (ID=15), while next_canon_id stays at 5 since INT is not
   a modifier.

3. The recursive call btf_dedup_is_equiv(d, 15, 5) is made.

4. In the recursive call, hypot_map[5] is already set to 20 (from step 1).
   Since 20 != 15, the code falls through to btf_dedup_identical_types().

5. btf_dedup_identical_types(d, 20, 15) compares VOLATILE vs CONST kinds,
   which differ, so it returns false.

6. The function returns 0, incorrectly reporting the types as not equivalent.

This appears to break the intended behavior for types with nested modifiers
like "volatile const X" vs "X", even though single modifiers like
"volatile X" vs "X" would work correctly (because next_cand_id and
next_canon_id would both resolve to the same underlying type).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20848783658

--===============1385388474747249984==--

