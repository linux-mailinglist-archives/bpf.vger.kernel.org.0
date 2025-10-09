Return-Path: <bpf+bounces-70687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382D2BCA59D
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 19:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69003B6054
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD59123B615;
	Thu,  9 Oct 2025 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dwKOo25t"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC62248A0
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030064; cv=none; b=brGwiZTR76XJrJs2vPQJn4IeWT72PKzmCiNBEeWnnHfhgGH3FBCp5JX5mqj4FzmDIO7kcys2YMnKuLTPi8kz4zHS0HmXoFqxJU68wlDC461cOS+icKlyw2ci6kCvHb/wpfe1Y6zVNZrEph/9fQkx7QAf6oqUBQlYALkTAEhdyo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030064; c=relaxed/simple;
	bh=nRLygUh6i1b4o1egyfA2xv0J9BYmTM29T78mX8Q8h54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNBzywmAa5WKuoh0Z2DT3RybBv/Xpvpc+Zom2DYQrCfk8/ArIAciXm9mXaZ9b8O8f97Ju6/wsnm0delpsTgtvKfyseGqWERMxBHomDm02NrEVU7chgGinqNCSD/GiPrxiGQjGosAhFfCM81DFnEIswB3WiMEhugxZSpNYRniTWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dwKOo25t; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b0f728a-d8f7-4829-ad58-d1b023796639@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760030055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyLrV3ee94MJXcTpPpE3mPgLhGYGDaAgaD6/LxgwcFk=;
	b=dwKOo25t1NoY1OAFiu/AnXRaBQ0bWCpRltGSpOC13UNonn+9lW6La/IfJ5PyTCj002Qg9Z
	PrvRYkxdc5IMWq1xOqU/xMm3VrTU0zp57qQEBg/gRDzuP90emhAWVismXgkfX2JkNGK0zH
	Rm3V6c3y1iqOtiFyrq+FtRkqGJNXYTg=
Date: Thu, 9 Oct 2025 10:14:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org
References: <cover.1760015985.git.paul.chaignon@gmail.com>
 <8bf24a59c3cfc7cc70c6bc272a039149cc8202b7.1760015985.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <8bf24a59c3cfc7cc70c6bc272a039149cc8202b7.1760015985.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/9/25 7:02 AM, Paul Chaignon wrote:
> This patch adds support for crafting non-linear skbs in BPF test runs
> for tc programs. The size of the linear area is given by ctx->data_end,
> with a minimum of ETH_HLEN always pulled in the linear area. If ctx or
> ctx->data_end are null, a linear skb is used.
> 
> This is particularly useful to test support for non-linear skbs in large
> codebases such as Cilium. We've had multiple bugs in the past few years
> where we were missing calls to bpf_skb_pull_data(). This support in
> BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
> BPF tests.
> 
> LWT program types are currently excluded in this patch. Allowing
> non-linear skbs for these programs would require a bit more care because
> they are able to call helpers (ex., bpf_clone_redirect, bpf_redirect)
> that themselves call eth_type_trans(). eth_type_trans() assumes there
> are at least ETH_HLEN bytes in the linear area. That may not be true
> for LWT programs as we already pulled the L2 header via the
> eth_type_trans() call in bpf_prog_test_run_skb().

Thanks for the details on lwt.

> @@ -1023,9 +1034,24 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	if (IS_ERR(ctx))
>   		return PTR_ERR(ctx);
>   
> -	data = bpf_test_init(kattr, kattr->test.data_size_in,
> -			     size, NET_SKB_PAD + NET_IP_ALIGN,
> -			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
> +	if (ctx) {
> +		if (ctx->data_end > kattr->test.data_size_in || ctx->data || ctx->data_meta) {
> +			ret = -EINVAL;
> +			goto out;

The "void *data" is still not initialized. There is a kfree(data) at "out:".

> +		}
> +		if (ctx->data_end) {
> +			/* Non-linear LWT test_run is unsupported for now. */
> +			if (is_lwt) {
> +				ret = -EINVAL;
> +				goto out;

same here.

pw-bot: cr


