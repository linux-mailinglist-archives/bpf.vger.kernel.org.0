Return-Path: <bpf+bounces-68592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5FEB7C79A
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FBE27AD04B
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 00:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6A11C3314;
	Wed, 17 Sep 2025 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJRn9QkW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45C1ADC83;
	Wed, 17 Sep 2025 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758068234; cv=none; b=stBhXluKUS8zHWtaMwKCb35JnVAM74CmyF+uQP5ShEOWCMBYd+ALpp/77OQMySCrfI/JQdHWxgHWslXUATd1MeKpv58YV0fNpJaKjS5M8hbrfN9GQaLb+KG1Pop6EXO4cmhTy/sClcDyc8L5SJGGep0dwr8Ap+n4G75cEDHQ32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758068234; c=relaxed/simple;
	bh=mEul8jQTOkU94mBq+7NiagJVKM5XCiIvGTEPa5OsxNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipaNquiAXrjnrAfUdPcH63o03WoXAfkixpqd5gONdVkDBXnuwEiuacXRlNBRX0DriVXnujn/5s/RuXFqtuhBb7qlG9r6KzvAM9LdkO69An++NXngzGfUJBpokJVhXxZg7sj1UGNbrqIeAXq/XEsOtDd4JD/HKMVfXY2baH1q10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJRn9QkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81437C4CEEB;
	Wed, 17 Sep 2025 00:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758068233;
	bh=mEul8jQTOkU94mBq+7NiagJVKM5XCiIvGTEPa5OsxNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uJRn9QkWz2maCP9RrO73znk28cDmphYDt/ibXkkJFHlZ5BxXfyc4opgVmogBxPjsU
	 NtguJ/WPgxC4eBDcRc4v/ePeC475dXq0BFn3wdBeHsEsJCwBGdNe6n8DviAsQHPsMI
	 fZvmzScorpQCYuv0Gb8Td5UVmteTPZ9qvhM7OD3sHB+dbZ+PB9nLYZDzzSlSKeIBg0
	 WpHvmasJ6NrCzBB3tgPdP0Oj1vPzUp9pRk7rQ+RaKkrEqgIp8dFe08Sqatz2asqQYL
	 nSrioiCvjBtuaBEGLWgGGil+SMULyES5nmpOtRhwr28XrMTuoFnPhEPJ3qYZMsxho2
	 SAuteLwZsSb6Q==
Date: Tue, 16 Sep 2025 17:17:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 paul.chaignon@gmail.com, stfomichev@gmail.com, martin.lau@kernel.org,
 mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Support pulling non-linear xdp
 data
Message-ID: <20250916171711.1b0d0bc4@kernel.org>
In-Reply-To: <20250915224801.2961360-3-ameryhung@gmail.com>
References: <20250915224801.2961360-1-ameryhung@gmail.com>
	<20250915224801.2961360-3-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 15:47:57 -0700 Amery Hung wrote:
> +/**
> + * bpf_xdp_pull_data() - Pull in non-linear xdp data.
> + * @x: &xdp_md associated with the XDP buffer
> + * @len: length of data to be made directly accessible in the linear part
> + *
> + * Pull in non-linear data in case the XDP buffer associated with @x is

looks like there will be a v4, so nit, I'd drop the first non-linear:

	Pull in data in case the XDP buffer associated with @x is

we say linear too many times, makes the doc hard to read

> + * non-linear and not all @len are in the linear data area.
> + *
> + * Direct packet access allows reading and writing linear XDP data through
> + * packet pointers (i.e., &xdp_md->data + offsets). The amount of data which
> + * ends up in the linear part of the xdp_buff depends on the NIC and its
> + * configuration. When an eBPF program wants to directly access headers that

s/eBPF/frag-capable XDP/ ?

> + * may be in the non-linear area, call this kfunc to make sure the data is
> + * available in the linear area. Alternatively, use dynptr or
> + * bpf_xdp_{load,store}_bytes() to access data without pulling.
> + *
> + * This kfunc can also be used with bpf_xdp_adjust_head() to decapsulate
> + * headers in the non-linear data area.
> + *
> + * A call to this kfunc may reduce headroom. If there is not enough tailroom
> + * in the linear data area, metadata and data will be shifted down.
> + *
> + * A call to this kfunc is susceptible to change the buffer geometry.
> + * Therefore, at load time, all checks on pointers previously done by the
> + * verifier are invalidated and must be performed again, if the kfunc is used
> + * in combination with direct packet access.
> + *
> + * Return:
> + * * %0         - success
> + * * %-EINVAL   - invalid len
> + */
> +__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
> +{
> +	struct xdp_buff *xdp = (struct xdp_buff *)x;
> +	int i, delta, shift, headroom, tailroom, n_frags_free = 0, len_free = 0;
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	void *data_hard_end = xdp_data_hard_end(xdp);
> +	int data_len = xdp->data_end - xdp->data;
> +	void *start, *new_end = xdp->data + len;
> +
> +	if (len <= data_len)
> +		return 0;
> +
> +	if (unlikely(len > xdp_get_buff_len(xdp)))
> +		return -EINVAL;
> +
> +	start = xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_meta;
> +
> +	headroom = start - xdp->data_hard_start - sizeof(struct xdp_frame);
> +	tailroom = data_hard_end - xdp->data_end;
> +
> +	delta = len - data_len;
> +	if (unlikely(delta > tailroom + headroom))
> +		return -EINVAL;
> +
> +	shift = delta - tailroom;
> +	if (shift > 0) {
> +		memmove(start - shift, start, xdp->data_end - start);
> +
> +		xdp->data_meta -= shift;
> +		xdp->data -= shift;
> +		xdp->data_end -= shift;
> +
> +		new_end = data_hard_end;
> +	}
> +
> +	for (i = 0; i < sinfo->nr_frags && delta; i++) {
> +		skb_frag_t *frag = &sinfo->frags[i];
> +		u32 shrink = min_t(u32, delta, skb_frag_size(frag));
> +
> +		memcpy(xdp->data_end + len_free, skb_frag_address(frag), shrink);
> +
> +		len_free += shrink;
> +		delta -= shrink;
> +		if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
> +			n_frags_free++;
> +	}
> +
> +	if (unlikely(n_frags_free)) {
> +		memmove(sinfo->frags, sinfo->frags + n_frags_free,
> +			(sinfo->nr_frags - n_frags_free) * sizeof(skb_frag_t));
> +
> +		sinfo->nr_frags -= n_frags_free;
> +
> +		if (!sinfo->nr_frags)
> +			xdp_buff_clear_frags_flag(xdp);
> +	}
> +
> +	sinfo->xdp_frags_size -= len_free;
> +	xdp->data_end = new_end;

Not sure I see the benefit of maintaining the new_end, and len_free.
We could directly adjust

	xdp->data_end += shrink;
	sinfo->xdp_frags_size -= shrink;

as we copy from the frags. But either way:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

The whole things actually looks pretty clean, I was worried 
the shifting down of the data would add a lot of complexity :)

