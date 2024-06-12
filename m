Return-Path: <bpf+bounces-31934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EFC9055B2
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A610A1C2236C
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C376C17F368;
	Wed, 12 Jun 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkcsX7xd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4207917B417;
	Wed, 12 Jun 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203759; cv=none; b=bMkIv96VM7gNbgNDIHR/vh/hKIgebicJIypX5tFesxIlIoriBw9z+w+PJC/gqWKrcHSuJWhCBbpNqoMBUVOw1CtN3Felt6+v9FC6o56ssoWwQfQb6ARdwyHCXvolCgpbSKkOxqWBesXk3eV1+BdQEiOLybjzwGrwlyqN7ZO8sUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203759; c=relaxed/simple;
	bh=r7qfZrLqDjs9EnVfGqwSfY34hfqcxRGH4gzVrkeOe2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fofwkXs1wFlXAnf+egCMpBuGmKiQbOaobGPxAsgdG6zna52i0diSZZp6pYPTmm8iio3LFKwp5lRqJ0HLrlzfuJ2cSFO/i8GbBBIfryqdT7qw6lrxqwQ0/mBJ0z7NIMxRCzO72pbfdnsVBNor1G5hCMVpGJz8PDIQDiKRI/d4WSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkcsX7xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2418C3277B;
	Wed, 12 Jun 2024 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718203759;
	bh=r7qfZrLqDjs9EnVfGqwSfY34hfqcxRGH4gzVrkeOe2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gkcsX7xdKOtKxDNnBgkEthnUHDTObEPBFTjN57QarrXKFwwuXhyARtno1Rmv+T+hB
	 c31iWT6mUpu959MJgLRqts8gH/cMfO2NCyYwXz+jNAk0PDgiduSMaFwfWIztku/9Df
	 ctsxTljTKPoJ5GseM1vj24459xPRDHwd3FobuyCV3lGeA8pi8uab+4zxjHvdwxophx
	 ic1wMuJAFhFVtKy0TF5k+I6U9C8DGxVi10g07CW13nREZx+6WvdzEOosP7G64Dif58
	 qTJlEfluRDpByFc1dxO8+eQY2i21UODcLg84tKSCKGE8QAA/04TbRqHv8W8Q/Eh8ow
	 AdQUbvGESB6DQ==
Date: Wed, 12 Jun 2024 07:49:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: add CHECKSUM_COMPLETE to bpf test
 progs
Message-ID: <20240612074917.1afacc42@kernel.org>
In-Reply-To: <20240606145851.229116-1-vadfed@meta.com>
References: <20240606145851.229116-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 07:58:50 -0700 Vadim Fedorenko wrote:
> @@ -1060,9 +1062,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  		__skb_push(skb, hh_len);
>  	if (is_direct_pkt_access)
>  		bpf_compute_data_pointers(skb);
> +
>  	ret = convert___skb_to_skb(skb, ctx);
>  	if (ret)
>  		goto out;
> +
> +	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
> +		const int off = skb_network_offset(skb);
> +		int len = skb->len - off;
> +
> +		skb->csum = skb_checksum(skb, off, len, 0);
> +		skb->ip_summed = CHECKSUM_COMPLETE;
> +	}

Looks good, overall, although I'd be tempted to place this before 
the L2 is pushed, a few lines up, so that we don't need to worry
about network offset. Then again, with you approach there is a nice
symmetry between the pre- and post- if blocks so either way is fine:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

