Return-Path: <bpf+bounces-67829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBC5B49EE3
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358184E424B
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 01:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9969323BD1B;
	Tue,  9 Sep 2025 01:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa4H41bq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D823ABA9;
	Tue,  9 Sep 2025 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757382890; cv=none; b=CXSpbEpxpjERG7OKPdmENCbAFaY69jXoyfaTiVGognri9uD2PXClpq7LrNJx5IUugP4ol9MI1LvB1lWWD8GwRtKCUjf0MC15nMhrw6PVbxNRaX2Y8EkI1Te+KY1OQUWMHq+ArAyy4CgfSySuCCPxJmWfsJAsz0hYTB9btK1UzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757382890; c=relaxed/simple;
	bh=eEWE839hB51pgDwSW7DeefwIoPMWaGYXGak7Af9RxlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MH5RavWrVuYsO7V7PaZMNZ+7W8dpIGVXIO43nnIJ5xj+vFjkDt/Xl57M0KJE2psS37EBAEh8P78d+Gq+zTvxNCfOku0a22vyn+TpWA8Iw23BdGVBTExoj9RrpWkOdx6TOChd/LFKwxWsyNhmzl4oOq1ttbIdMJh/O15Mb7BRURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pa4H41bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C85BC4CEF1;
	Tue,  9 Sep 2025 01:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757382889;
	bh=eEWE839hB51pgDwSW7DeefwIoPMWaGYXGak7Af9RxlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pa4H41bqxoum4kjDcCCMcrVZz9AVUaBZkoIgNqK8cFooDShnyX26niENC6x4KKRDi
	 d+B3r06KiyWi/uk4S6jnOGTToPo72wBUQNPGrK46vlIRrfqXe8+oWl3DcG5AWhXUOe
	 Ot+MBTWe0LR5seLXAeRgaA5aiTYJoGYF12jzwp7Xk2iiOCmtCA/8Qly/UfXQ9Psm9R
	 CIn+DbLPVEsZk0zPPfyBFqT1BrDODTsyW0zQHRZnvkCpGnoP9vASf1pznOWwizAblQ
	 JKoiPEQQCmlHz04SFc7A7l+akj+2JpKQr5Dzmb3GzmfVnkFgJQ8rYCXQ1Tr6Al9FPE
	 HN5ABjVSHRpow==
Date: Mon, 8 Sep 2025 18:54:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 stfomichev@gmail.com, martin.lau@kernel.org, mohsin.bashr@gmail.com,
 noren@nvidia.com, dtatulea@nvidia.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Support pulling non-linear xdp
 data
Message-ID: <20250908185447.233963c5@kernel.org>
In-Reply-To: <20250905173352.3759457-4-ameryhung@gmail.com>
References: <20250905173352.3759457-1-ameryhung@gmail.com>
	<20250905173352.3759457-4-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Sep 2025 10:33:47 -0700 Amery Hung wrote:
> + * Direct packet access allows reading and writing linear XDP data through
> + * packet pointers (i.e., &xdp_md->data + offsets). 

Add:
 The amount of data which ends up in the linear part of the xdp_buf
 depends on the NIC and its configuration. 

> When an eBPF program wants
> + * to directly access data that may be in the non-linear area, call this kfunc
                         ^^^^
          maybe s/data/headers

> + * to make sure the data is available in the linear area.

Should we add a mention here of the copy helpers and dynptr for
accessing data without pulling?

> + * This kfunc can also be used with bpf_xdp_adjust_head() to decapsulate
> + * headers in the non-linear data area.
> + *
> + * A call to this kfunc is susceptible to change the underlying packet buffer.

Maybe:
 A call to this kfunc will modify the buffer geometry.

> + * Therefore, at load time, all checks on pointers previously done by the
> + * verifier are invalidated and must be performed again, if the kfunc is used
> + * in combination with direct packet access.

>	void *data_end = xdp->data + len;

nit: I think the code would be easier to follow if we renamed this 
to "new_end"?


Larger note: I wonder if we should support "shifting the buffer down"
if there's insufficient tailroom. XDP has rather copious headroom,
but tailroom may be pretty tight, and it may depend on the length of
the headers. So if there's not enough tailroom but there's enough
headroom -- should we try to memmove the existing headers?

