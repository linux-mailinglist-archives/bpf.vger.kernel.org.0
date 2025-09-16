Return-Path: <bpf+bounces-68571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76337B7F883
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8FF3BCC15
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939DF2E9ED7;
	Tue, 16 Sep 2025 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rsKwx+gZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339522E973D
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063575; cv=none; b=rgciQJfSYRIdW2Uc5nxBkZ/SxljT1praN9eb+BE6H2iIXZql1kA7xkxsz5RnXvetX4otuNY+urQQDeYSvwB0YDP2FedEkL/0xj6f2SneX6mbd8OVyFUQAq9k8r3d0sdywjgi2ww4HktboO/WihiekCLheVixpXDInNQSEucusl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063575; c=relaxed/simple;
	bh=URsf7dJ9zIjnpx1KCokXT+FRTqTWWhkc33R8wJNzEig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+hBRW6zyohZtMvwgWp1RuHdT/OvlrRCHJqO2veiSXeReVMsl3x7q4eROnPCBsHdCi8ubkceZPCFArBDo+LgbmQzH+bM2/A4doEPe1oUlzvqa/x3pedz97jZaqDUsAMwLPCQrcGfXmBn9rQz5Pn8DT/hJqVL2faGl20rCVavbJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rsKwx+gZ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bc297803-68e6-4f59-a32d-490398b8e590@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758063568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+kNPfu/TPu5aq52hNSPq3U+Ojj/9Lv8yDWDM0uC9GE=;
	b=rsKwx+gZ/NghNnPX4Up4X5V9Nb7bXzrTTrkTK5FPXWd3apoTTtPmKgaaz0iFFCACwxRH6o
	nMTRU0kWqxWkf5IcLa3SrAsvAQDZeUjHXRrz8Jzsseqlrf057u8WkpHfiMGWiDGnqWkSya
	Dw13fxBV29pdpQd6wXK+UrhCHaiDZcw=
Date: Tue, 16 Sep 2025 15:59:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/6] bpf: Support specifying linear xdp packet
 data size for BPF_PROG_TEST_RUN
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 paul.chaignon@gmail.com, kuba@kernel.org, stfomichev@gmail.com,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, noren@nvidia.com,
 dtatulea@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com
References: <20250915224801.2961360-1-ameryhung@gmail.com>
 <20250915224801.2961360-5-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250915224801.2961360-5-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/15/25 3:47 PM, Amery Hung wrote:
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
> xdp_buff.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>   net/bpf/test_run.c                            | 26 ++++++++++++-------
>   .../bpf/prog_tests/xdp_context_test_run.c     |  4 +--
>   2 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 4a862d605386..558126bbd180 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -660,12 +660,15 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
>   BTF_KFUNCS_END(test_sk_check_kfunc_ids)
>   
>   static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
> -			   u32 size, u32 headroom, u32 tailroom)
> +			   u32 size, u32 headroom, u32 tailroom, bool is_xdp)

Understood that the patch has inherited this function. I found it hard to read 
when it is called by xdp but this could be just me. For example, what is passed 
as "size" from the bpf_prog_test_run_xdp(), which ends up being "PAGE_SIZE - 
headroom - tailroom". I am not sure how to fix it. e.g. can we always allocate a 
PAGE_SIZE for non xdp callers also. or may be the xdp should not reuse this 
function. This probably is a fruit of thoughts for later. Not asking to consider 
it in this set.

I think at least the first step is to avoid adding "is_xdp" specific logic here.

>   {
>   	void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
>   	void *data;
>   
> -	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
> +	if (!is_xdp && user_size < ETH_HLEN)

Move the lower bound check to its caller. test_run_xdp() does not need this 
check. test_run_flow_dissector() and test_run_nf() already have its own check. 
test_run_nf() actually has a different bound. test_run_skb() is the only one 
that needs this check, so it can be explicitly done in there like other callers.

> +		return ERR_PTR(-EINVAL);
> +
> +	if (user_size > PAGE_SIZE - headroom - tailroom)
>   		return ERR_PTR(-EINVAL);
>   
>   	size = SKB_DATA_ALIGN(size);
> @@ -1003,7 +1006,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   
>   	data = bpf_test_init(kattr, kattr->test.data_size_in,
>   			     size, NET_SKB_PAD + NET_IP_ALIGN,
> -			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
> +			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
> +			     false);
>   	if (IS_ERR(data))
>   		return PTR_ERR(data);
>   
> @@ -1207,8 +1211,8 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>   {
>   	bool do_live = (kattr->test.flags & BPF_F_TEST_XDP_LIVE_FRAMES);
>   	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +	u32 retval = 0, duration, max_data_sz, data_sz;
>   	u32 batch_size = kattr->test.batch_size;
> -	u32 retval = 0, duration, max_data_sz;
>   	u32 size = kattr->test.data_size_in;
>   	u32 headroom = XDP_PACKET_HEADROOM;
>   	u32 repeat = kattr->test.repeat;
> @@ -1246,7 +1250,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>   
>   	if (ctx) {
>   		/* There can't be user provided data before the meta data */
> -		if (ctx->data_meta || ctx->data_end != size ||
> +		if (ctx->data_meta || ctx->data_end > size ||
>   		    ctx->data > ctx->data_end ||
>   		    unlikely(xdp_metalen_invalid(ctx->data)) ||
>   		    (do_live && (kattr->test.data_out || kattr->test.ctx_out)))
> @@ -1256,14 +1260,15 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	}
>   
>   	max_data_sz = PAGE_SIZE - headroom - tailroom;
> -	if (size > max_data_sz) {
> +	data_sz = (ctx && ctx->data_end < max_data_sz) ? ctx->data_end : max_data_sz;

hmm... can the "size" (not data_sz) be directly updated to ctx->data_end in the 
above "if (ctx)".

> +	if (size > data_sz) {
>   		/* disallow live data mode for jumbo frames */
>   		if (do_live)
>   			goto free_ctx;
> -		size = max_data_sz;
> +		size = data_sz;
>   	}
>   
> -	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom);
> +	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom, true);
>   	if (IS_ERR(data)) {
>   		ret = PTR_ERR(data);
>   		goto free_ctx;
> @@ -1386,7 +1391,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>   	if (size < ETH_HLEN)
>   		return -EINVAL;
>   
> -	data = bpf_test_init(kattr, kattr->test.data_size_in, size, 0, 0);
> +	data = bpf_test_init(kattr, kattr->test.data_size_in, size, 0, 0, false);
>   	if (IS_ERR(data))
>   		return PTR_ERR(data);
>   
> @@ -1659,7 +1664,8 @@ int bpf_prog_test_run_nf(struct bpf_prog *prog,
>   
>   	data = bpf_test_init(kattr, kattr->test.data_size_in, size,
>   			     NET_SKB_PAD + NET_IP_ALIGN,
> -			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
> +			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
> +			     false);
>   	if (IS_ERR(data))
>   		return PTR_ERR(data);
>   
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


