Return-Path: <bpf+bounces-73212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02865C2721A
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 23:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E85428A48
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD2C2EB5CF;
	Fri, 31 Oct 2025 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2kxtI4k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96522D7DC0
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761950139; cv=none; b=RVMc0I+11VOtswW3LJHMJkJtUtSTOaH8ivmTkS90q0bqVM8rH7r6xM7ACC+pwAbRLww6F9bELNvUxw7P8ICwasb4iw7ddlEI4z74K0peq2lZEcWv+f5yR7m116g4GjzZauqa72mzzYNdjYHUaaVteZ83g50cRXPqpzwIhFhyRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761950139; c=relaxed/simple;
	bh=K2G6dBGwQo2JF7e/ir529iKrKLLmz7Cb2HDnspGD+ts=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PV7fj65EqYW9y8j6AN1GiDSi2bGmECJ5jjc1LyVFig7hIWJkKQvCe72bkcLaA3RAhxA3tR+b9CIZtWdKqFDC/5tsLZI51ePSNENGnDRe2Lyqug6x9WVEoArhJNy36oBhCM1TpCgc19ubWu7sIHOfcTRdU269dj+/ZOI2meIeg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2kxtI4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BE0C4CEE7;
	Fri, 31 Oct 2025 22:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761950138;
	bh=K2G6dBGwQo2JF7e/ir529iKrKLLmz7Cb2HDnspGD+ts=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=O2kxtI4kzeXGx1UicPEr6Z/aOtlEBgeXLGR7wGGVfWk/MARhyMPeWYq7PjGr/nvdf
	 eB2QiClvlIs5PVKxzNQ4Pcjw/w8gp2mhac4GLMOVvh3+sX+NMWjr7+zWdii3T9oooS
	 YiOuysvewfxlM2o/xiUp/3sudcxYvyI99efOtryyjXzONz7R1V9FWP3BrtM6ljQPKL
	 LjQfq9grkhmdQnY4HuqlXtOuRrc7zmZGS1GkFMhSU4uvdMajieAzvX/FVkhR/8qoy1
	 +eZJ2TQSo4ZGZOwtGG6FgF1PE8J8r3SdjhgFJb6u4/IhhAacDgqBv9NAiGRbUJsFGk
	 cq26tVe/IV5VA==
Content-Type: multipart/mixed; boundary="===============3628276098707931522=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <12c9090b388155c7aaac9f503b30a1b678ac630c6f38eb0bee97feec7b6937e2@mail.kernel.org>
In-Reply-To: <20251031-timer_nolock-v1-4-bf8266d2fb20@meta.com>
References: <20251031-timer_nolock-v1-4-bf8266d2fb20@meta.com>
Subject: Re: [PATCH RFC v1 4/5] bpf: add refcnt into struct bpf_async_cb
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Oct 2025 22:35:38 +0000 (UTC)

--===============3628276098707931522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 10c6a92e712bfb1625f74ea7088ae806ccf9a91e
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: add refcnt into struct bpf_async_cb

This patch adds a refcount field to struct bpf_async_cb to manage
lifetime guarantees when no lock serializes mutations, and implements
bpf_async_tryget() and bpf_async_put() helper functions.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2eb2369ca..3d9b370e4 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1102,6 +1102,7 @@ struct bpf_async_cb {
>  		struct work_struct delete_work;
>  	};
>  	u64 flags;
> +	refcount_t refcnt;
>  };

Is the refcnt field initialized anywhere? In __bpf_async_init(), the
bpf_async_cb structure is allocated via bpf_map_kmalloc_nolock() which
uses kmalloc_nolock (not kzalloc), so the memory is not zero-filled.

After allocation, __bpf_async_init() initializes several fields (map,
prog, flags, callback_fn, value, delete_work) but I don't see where
refcnt is set to an initial value. The refcount_t APIs require proper
initialization (typically via refcount_set()) before use.

When bpf_async_tryget() or bpf_async_put() are called later, they will
operate on this uninitialized memory:

> @@ -1155,6 +1156,33 @@ static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
>
>  static void bpf_timer_delete(struct bpf_hrtimer *t);
>
> +static bool bpf_async_tryget(struct bpf_async_cb *cb)
> +{
> +	return refcount_inc_not_zero(&cb->refcnt);
> +}
> +
> +static void bpf_async_put(struct bpf_async_cb *cb, enum bpf_async_type type)
> +{
> +	if (!refcount_dec_and_test(&cb->refcnt))
> +		return;

Both refcount_inc_not_zero() in bpf_async_tryget() and
refcount_dec_and_test() in bpf_async_put() will read the uninitialized
refcnt field, leading to undefined behavior.

Should __bpf_async_init() call refcount_set(&cb->refcnt, 1) after
allocating the structure?


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `bpf: add refcnt into struct bpf_async_cb`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18986353612

--===============3628276098707931522==--

