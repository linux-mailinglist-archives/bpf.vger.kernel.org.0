Return-Path: <bpf+bounces-69263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EADB92C3C
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 21:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045ED2A5345
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 19:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8998131A576;
	Mon, 22 Sep 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lofOSRSU"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2926F28B
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758568877; cv=none; b=sSs1Ud04b9ODqkNNi+9PYr8VQ1unLPLH3sMvrYvec/fk/9It+kTYkiG1+fNb0JR6BBT88itWFY8HwZGW+e5uIvoGf858wKo+G+S1uZy8gPELkw0giFEDKjAMTwPx55PoHSuv0LdjJdG6p9e4l1GY9kRS6EIi3r8inq1nYWTl/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758568877; c=relaxed/simple;
	bh=SpL/uf++UHe5WDMUpJYCJVLQO/aSX2Z3xHfA+ranpok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqXrggZadFxmoG013HPIVpHta7luoQeoSS4PHQshuaZR3OKIuMCCFXoGT1JG4ngs6ATz8St1FJs1YZYjwU2pKgRMZg0GNdSQFmqoT/THNybREwj4gMkBLjI580zykivGfjaUwN8aCexdWcj8nfMGC1XE3Fw9QtGD0jS8T9gp2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lofOSRSU; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <10e5dd51-701d-498b-b1eb-68b23df191d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758568862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/z9s/O02Aw+bHocCKmsc2CUboSX1ulbDMtafBZOvbI=;
	b=lofOSRSUsEQxfGJYbETwlFItBkuRmJYQJJSqNhbmv/W+1hIJ4Dz0Os5ARdW/5jHxQRtSDv
	rqdx/3pMHLZfpsSw6rOPkf1A+HAhVB1GH27ElUZcBtIUT7lUkAFDFW6xCGZ31jUA+MemuG
	JOnELSiWY2p15KdbaUoZKGhHNd576xg=
Date: Mon, 22 Sep 2025 12:20:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 5/7] bpf: Support specifying linear xdp packet
 data size for BPF_PROG_TEST_RUN
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 paul.chaignon@gmail.com, kuba@kernel.org, stfomichev@gmail.com,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, noren@nvidia.com,
 dtatulea@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com
References: <20250919230952.3628709-1-ameryhung@gmail.com>
 <20250919230952.3628709-6-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250919230952.3628709-6-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/19/25 4:09 PM, Amery Hung wrote:
> To test bpf_xdp_pull_data(), an xdp packet containing fragments as well
> as free linear data area after xdp->data_end needs to be created.
> However, bpf_prog_test_run_xdp() always fills the linear area with
> data_in before creating fragments, leaving no space to pull data. This
> patch will allow users to specify the linear data size through
> ctx->data_end.
> 
> Currently, ctx_in->data_end must match data_size_in and will not be the
> final ctx->data_end seen by xdp programs. This is because ctx->data_end
> is populated according to the xdp_buff passed to test_run. The linear
> data area available in an xdp_buff, max_data_sz, is alawys filled up
> before copying data_in into fragments.
> 
> This patch will allow users to specify the size of data that goes into
> the linear area. When ctx_in->data_end is different from data_size_in,
> only ctx_in->data_end bytes of data will be put into the linear area when
> creating the xdp_buff.
> 
> While ctx_in->data_end will be allowed to be different from data_size_in,
> it cannot be larger than the data_size_in as there will be no data to
> copy from user space. If it is larger than the maximum linear data area
> size, the layout suggested by the user will not be honored. Data beyond
> max_data_sz bytes will still be copied into fragments.
> 
> Finally, since it is possible for a NIC to produce a xdp_buff with empty
> linear data area, allow it when calling bpf_test_init() from
> bpf_prog_test_run_xdp() so that we can test XDP kfuncs with such
> xdp_buff. This is done by moving lower-bound check to callers as most of
> them already do except bpf_prog_test_run_skb().
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>   net/bpf/test_run.c                                       | 9 +++++++--
>   .../selftests/bpf/prog_tests/xdp_context_test_run.c      | 4 +---
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 4a862d605386..0cbd3b898c45 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -665,7 +665,7 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
>   	void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
>   	void *data;
>   
> -	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
> +	if (user_size > PAGE_SIZE - headroom - tailroom)
>   		return ERR_PTR(-EINVAL);
>   
>   	size = SKB_DATA_ALIGN(size);
> @@ -1001,6 +1001,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	    kattr->test.cpu || kattr->test.batch_size)
>   		return -EINVAL;
>   
> +	if (size < ETH_HLEN)
> +		return -EINVAL;
> +
>   	data = bpf_test_init(kattr, kattr->test.data_size_in,
>   			     size, NET_SKB_PAD + NET_IP_ALIGN,
>   			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
> @@ -1246,13 +1249,15 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,

I just noticed it. It still needs a "size < ETH_HLEN" test at the beginning of 
test_run_xdp. At least the do_live mode should still needs to have ETH_HLEN bytes.

>   
>   	if (ctx) {
>   		/* There can't be user provided data before the meta data */
> -		if (ctx->data_meta || ctx->data_end != size ||
> +		if (ctx->data_meta || ctx->data_end > size ||
>   		    ctx->data > ctx->data_end ||
>   		    unlikely(xdp_metalen_invalid(ctx->data)) ||
>   		    (do_live && (kattr->test.data_out || kattr->test.ctx_out)))
>   			goto free_ctx;
>   		/* Meta data is allocated from the headroom */
>   		headroom -= ctx->data;
> +
> +		size = ctx->data_end;
>   	}
>   
>   	max_data_sz = PAGE_SIZE - headroom - tailroom;
It still needs to avoid multi-frags/bufs in do_live and the "if (size > 
max_data_sz)" needs some adjustments. I think it is cleaner to specifically test 
"kattr->test.data_size_in". Something like this (untested) ?

-	if (size > max_data_sz) {
-		/* disallow live data mode for jumbo frames */
-		if (do_live)
-			goto free_ctx;
-		size = max_data_sz;
-	}
+	size = min_t(u32, size, max_data_sz);
+
+	if (kattr->test.data_size_in > size && do_live)
+		goto free_ctx;

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 46e0730174ed..178292d1251a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -97,9 +97,7 @@ void test_xdp_context_test_run(void)
>   	/* Meta data must be 255 bytes or smaller */
>   	test_xdp_context_error(prog_fd, opts, 0, 256, sizeof(data), 0, 0, 0);
>   
> -	/* Total size of data must match data_end - data_meta */
> -	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
> -			       sizeof(data) - 1, 0, 0, 0);
> +	/* Total size of data must be data_end - data_meta or larger */
>   	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
>   			       sizeof(data) + 1, 0, 0, 0);
>   


