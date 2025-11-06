Return-Path: <bpf+bounces-73906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD8C3D84D
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 22:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166DE18887F2
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B97A306B0F;
	Thu,  6 Nov 2025 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JCLbRSPA"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7613433B3
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762465301; cv=none; b=RxxiLxW15uIjaMX1CuHAtDp/u7098caTreuq550rIUMDGKMmGBjAD8TfSsuOWmOMOs/DeeXy8mxJMygVRKoJXkHPKZE4Z5ePS6xFPUmFKpDI7eR3BXmuXBDtrxaSrkoUnv538x+oJB5OzPtkM4HxMWyy2F1FnWgo4wI0GeZPa/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762465301; c=relaxed/simple;
	bh=TA2FT0KMjOKykDlMhhMjR2oo6ErEjOgldGqVGJ7GeXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5Ft6p+a9fVVE4vphn8sTx6LzFg9CX6RSTDUZmuPY3Zg9I8pJ8g9IkJo/hUrc772kIVVZy3X8xmmVlqyWhbT+wie2v9PB3JlC8w/ZI95UISdLRqJF0AjqnpfjEKJpjYjq9xJo/N1dBbICuke34x+F/q5TUwX0u23sfflDCA6el4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JCLbRSPA; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <79f2f8d6-f8dd-41a6-90fe-2464397a0c6c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762465297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpr/bD/vitVGDgbOcmyXh0Zx40rc+Gf9D4ayZf2k6lQ=;
	b=JCLbRSPA+odf82LGwUXL2oweS4c6nbAXrl5fnT2UYNwWwtPXre3MMlq+owc6A0xb0wckXX
	+cKjYP2fwkfgVT6169c2F7SYz0VGb1HigPkC0r0IL9EUlMmTR74jRud1PQAeAeWVidgOOF
	mSgotSGtZuVfVEd2EgDIpb2WJIQzpko=
Date: Thu, 6 Nov 2025 13:41:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC v2 4/5] bpf: add refcnt into struct bpf_async_cb
Content-Language: en-GB
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
 <20251105-timer_nolock-v2-4-32698db08bfa@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251105-timer_nolock-v2-4-32698db08bfa@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/5/25 7:59 AM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> To manage lifetime guarantees of the struct bpf_async_cb, when
> no lock serializes mutations, introduce refcnt field into the struct.
> Implement bpf_async_tryget() and bpf_async_put() to handle the refcnt.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>   kernel/bpf/helpers.c | 39 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2eb2369cae3ad34fd218387aa237140003cc1853..1cd4011faca519809264b2152c7c446269bee5de 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1102,6 +1102,7 @@ struct bpf_async_cb {
>   		struct work_struct delete_work;
>   	};
>   	u64 flags;
> +	refcount_t refcnt;
>   };
>   
>   /* BPF map elements can contain 'struct bpf_timer'.
> @@ -1155,6 +1156,33 @@ static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
>   
>   static void bpf_timer_delete(struct bpf_hrtimer *t);
>   
> +static bool bpf_async_tryget(struct bpf_async_cb *cb)
> +{
> +	return refcount_inc_not_zero(&cb->refcnt);
> +}

Looks like bpf_async_tryget() is not used in this patch and it is
actually used in the next patch. Should we move it to the next patch?

> +
> +static void bpf_async_put(struct bpf_async_cb *cb, enum bpf_async_type type)
> +{
> +	if (!refcount_dec_and_test(&cb->refcnt))
> +		return;
> +
> +	switch (type) {
> +	case BPF_ASYNC_TYPE_TIMER:
> +		bpf_timer_delete((struct bpf_hrtimer *)cb);
> +		break;
> +	case BPF_ASYNC_TYPE_WQ: {
> +		struct bpf_work *work = (void *)cb;
> +		/* Trigger cancel of the sleepable work, but *do not* wait for
> +		 * it to finish if it was running as we might not be in a
> +		 * sleepable context.
> +		 * kfree will be called once the work has finished.
> +		 */
> +		schedule_work(&work->delete_work);
> +		break;
> +	}
> +	}
> +}
> +
>   static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>   {
>   	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
> @@ -1304,6 +1332,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
>   	cb->prog = NULL;
>   	cb->flags = flags;
>   	rcu_assign_pointer(cb->callback_fn, NULL);
> +	refcount_set(&cb->refcnt, 1); /* map's own ref */
>   
>   	WRITE_ONCE(async->cb, cb);
>   	/* Guarantee the order between async->cb and map->usercnt. So
> @@ -1642,7 +1671,7 @@ void bpf_timer_cancel_and_free(void *val)
>   	if (!t)
>   		return;
>   
> -	bpf_timer_delete(t);
> +	bpf_async_put(&t->cb, BPF_ASYNC_TYPE_TIMER); /* Put map's own reference */
>   }
>   
>   /* This function is called by map_delete/update_elem for individual element and
> @@ -1657,12 +1686,8 @@ void bpf_wq_cancel_and_free(void *val)
>   	work = (struct bpf_work *)__bpf_async_cancel_and_free(val);
>   	if (!work)
>   		return;
> -	/* Trigger cancel of the sleepable work, but *do not* wait for
> -	 * it to finish if it was running as we might not be in a
> -	 * sleepable context.
> -	 * kfree will be called once the work has finished.
> -	 */
> -	schedule_work(&work->delete_work);
> +
> +	bpf_async_put(&work->cb, BPF_ASYNC_TYPE_WQ); /* Put map's own reference */
>   }
>   
>   BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
>


