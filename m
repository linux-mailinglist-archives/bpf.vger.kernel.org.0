Return-Path: <bpf+bounces-44189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5929BFB3A
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 02:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4041C2188B
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 01:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1C17485;
	Thu,  7 Nov 2024 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nevxPbGf"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3440624
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942099; cv=none; b=Ee91G7sMl28wq2cfVZOyRlXBO/v5166RxbeRZxItecOm0N83Aw7H0cCJWCDt7+pPOKOloDvRg8T7lsjZEh0xIp53Iztic6x+MHYfFwz2tbRDULfwn0LetUnA9olf8l6AJdDeRAEoXwSZhbmOlvFGr5JuK4uXrXEBWVnvRuIZHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942099; c=relaxed/simple;
	bh=DAZUNkG3kizkEUJgbSk9EdDmXbiqKkTYBpgusTAhSqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLrCWjMKhsKEuKVHlZ5FnBRmTpZ8tBtKJfi3hjBGXkzB6Ea2q1ZISSLauYHyXUu6Pu1WpdhI+MkCTup+Kj3fZ/ZqOxP37BD5VvhZE0SXdX/aF+Ua1A6MNmn3M6T2xNcDCUXHqTrDJnHqqmoTiP3ZfN5FXkXprdRcIDgm0N1iYfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nevxPbGf; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730942094; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NJUnkDcdV0LcTxTGYTFXlQhT0I9a/2JQdFANf7mTgLE=;
	b=nevxPbGfC76jnxFOtoolxPyOLU6luNVgOcqEwLSQq2EQ8IWkWtVFDTnzVSTxtcDyy1lIwn2v0qHCjxbxjv1K7CuHBEWqjG7VR6POEqb8UIYrJZIQl8aB7lZ4Z23Cl8THuZh5SdgRuMNGqKCMnmSAlk9vj53ts5ro5+2enqupYWg=
Received: from 30.221.128.108(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WItX0zv_1730942093 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 09:14:54 +0800
Message-ID: <be112074-a921-4f0f-aaad-77318ae39618@linux.alibaba.com>
Date: Thu, 7 Nov 2024 09:14:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/bpf: Add a test for the type checking of
 iter args
To: Tao Lyu <tao.lyu@epfl.ch>, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, song@kernel.org, yonghong.song@linux.dev,
 haoluo@google.com, martin.lau@linux.dev, memxor@gmail.com
Cc: bpf@vger.kernel.org
References: <20241106201849.2269411-1-tao.lyu@epfl.ch>
 <20241106201849.2269411-3-tao.lyu@epfl.ch>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20241106201849.2269411-3-tao.lyu@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/7 04:18, Tao Lyu wrote:
> This is a selftest for the type checking of iter arguments.
> When passing a PTR_TO_MAP_VALUE to bpf_iter_num_* kfuncs, the program should be rejected.
> 
> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> ---
>   tools/testing/selftests/bpf/progs/iters.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
> index ef70b88bccb2..0a2df20afa30 100644
> --- a/tools/testing/selftests/bpf/progs/iters.c
> +++ b/tools/testing/selftests/bpf/progs/iters.c
> @@ -1486,4 +1486,25 @@ int iter_subprog_check_stacksafe(const void *ctx)
>   	return 0;
>   }
>   
> +SEC("raw_tp")
> +__failure __msg("arg#0 expected pointer to the iterator")
> +int iter_check_arg_type(const void *ctx)
> +{
> +        struct bpf_iter_num it;
> +        int *v;
> +
> +        int *map_val = NULL;
> +        int key = 0;
> +
> +        map_val = bpf_map_lookup_elem(&arr_map, &key);
> +        if (!map_val)
> +                return 0;
> +
> +        bpf_iter_num_new(&it, 0, 3);
> +        while ((v = bpf_iter_num_next((struct bpf_iter_num*)map_val))) {}
> +        bpf_iter_num_destroy(&it);
> +
> +        return 0;
> +}
> +
>   char _license[] SEC("license") = "GPL";

Hi, Tao. There are some style issues such as using spaces as 
indentations. It's recommended to run `scripts/checkpatch.pl` before 
commit patches.

-- 
Philo


