Return-Path: <bpf+bounces-76441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7EFCB4013
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 321C9300A6FF
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6132AAAE;
	Wed, 10 Dec 2025 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyJ7EWVy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63419CD06;
	Wed, 10 Dec 2025 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400162; cv=none; b=XqLVPr//LK51qPlMDhulyLhGbZyEVFLoxYmNzMqQ7EoVf9hmYJPc/dzo4BDpYm7LxXaJyKGbsRWTJJwp0PcCvroY/kMB0esxUiQDP47M/Saam0yjGcvjSJVrcLTiW9lTtsMbR3Opdtzr9N3nRsz91Qdy2V1A+9/1AC2Z9Taq/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400162; c=relaxed/simple;
	bh=rWzHSq1z5ZT1pSzR91JNC1UsPxVrGqOokrqFDyrHbuM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JxAMZ624tDNfDUYY5fGNFAZkQ515Qhy8LdwSJXCPLiHwrtOLtsolL1qYESakxyUZKAgNbzFOFj7CciG9ORFiC9+0kalX0MhU9rKfOtoz62VjGnjQptmwG7Anp6oW4wZVrXDGx3D08OQhgRz21u7bPjSUVnHOaGRxzeMUBevLKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyJ7EWVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23FEC4CEF1;
	Wed, 10 Dec 2025 20:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765400160;
	bh=rWzHSq1z5ZT1pSzR91JNC1UsPxVrGqOokrqFDyrHbuM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hyJ7EWVySElandZULPJcsszPT0WAiMSkM1aomCyguMidCGzpZn16SPqjrhvhQ1CZc
	 s3smYJMFp5BXwDPmWOo6Om7ekflcGfr+kT4qiIrz2esQYTmefs50BMv+Stn8MYuo+W
	 XGfL+gcjhVgOGy/Zu49M4mRfTNwqIS8rMOohBNCYqAWwNO+PXmIVSsSH7ZmVW7OgzJ
	 6AomQ/RD1w8Wz+4ys3lpw+oC3E4qNOQb7capbY+AEJqdhTRtnfPsh+ybZXb1FXeepd
	 IPY/CmsBIoxtjM17OEjGm6IGz1EesELuSXHWCKhGSqmbcoOMbS4bD/IAi0Ff7NrQQo
	 yBZAr/88e3kNw==
Content-Type: multipart/mixed; boundary="===============3776280526717215492=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aa32deb9e8e7ee4895f4884d375153f5fcf90b5b319e3f7052f4b14f47bb8504@mail.kernel.org>
In-Reply-To: <20251210203243.814529-3-alan.maguire@oracle.com>
References: <20251210203243.814529-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v6 bpf-next 02/10] libbpf: Support kind layout section handling in BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,dwarves@vger.kernel.org,bpf@vger.kernel.org,ttreyer@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Dec 2025 20:55:58 +0000 (UTC)

--===============3776280526717215492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b136572e889a..737adc560818 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -994,6 +1048,7 @@ void btf__free(struct btf *btf)
>
>  static struct btf *btf_new_empty(struct btf *base_btf)
>  {
> +	struct btf_header *hdr;
>  	struct btf *btf;
>
>  	btf = calloc(1, sizeof(*btf));
> @@ -1022,14 +1077,20 @@ static struct btf *btf_new_empty(struct btf *base_btf)
>  		return ERR_PTR(-ENOMEM);
>  	}
>
> -	btf->hdr = btf->raw_data;
> -	btf->hdr->hdr_len = sizeof(struct btf_header);
> -	btf->hdr->magic = BTF_MAGIC;
> -	btf->hdr->version = BTF_VERSION;
> +	hdr = btf->raw_data;
> +	hdr->hdr_len = sizeof(struct btf_header);
> +	hdr->magic = BTF_MAGIC;
> +	hdr->version = BTF_VERSION;
>
> -	btf->types_data = btf->raw_data + btf->hdr->hdr_len;
> -	btf->strs_data = btf->raw_data + btf->hdr->hdr_len;
> -	btf->hdr->str_len = base_btf ? 0 : 1; /* empty string at offset 0 */
> +	btf->types_data = btf->raw_data + hdr->hdr_len;
> +	btf->strs_data = btf->raw_data + hdr->hdr_len;
> +	hdr->str_len = base_btf ? 0 : 1; /* empty string at offset 0 */
> +	btf->hdr = calloc(1, sizeof(struct btf_header));
> +	if (!btf->hdr) {
> +		free(btf);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	memcpy(btf->hdr, hdr, sizeof(*hdr));
>
>  	return btf;
>  }

Does this leak btf->raw_data when the btf->hdr allocation fails? The
btf->raw_data was allocated earlier (at line 1074 in the new code), but
if we reach the error path here, we only free(btf) without freeing
btf->raw_data first.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20112692486

--===============3776280526717215492==--

