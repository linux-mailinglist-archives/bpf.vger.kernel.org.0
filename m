Return-Path: <bpf+bounces-52226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F616A403D1
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 00:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209B63B8B69
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB7E255E20;
	Fri, 21 Feb 2025 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An7zZ0d1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB3288CC;
	Fri, 21 Feb 2025 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740182238; cv=none; b=rVW3D9LSTO+zKoXxtZNe1cS/9wCMmBnKxNxlKOpPpLJWqfH0Ri84Bu0wKM+bNOiBo0pwK25Te+pUedP7uC9OX75JmFS0+gwQFRlVsYRDNhJyWh97QjaAJPoK1a0jB6d2VTm1OUbW7ALEhw/zA+VP/ttqHCqYDs/8vhr7aL05JU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740182238; c=relaxed/simple;
	bh=L0VHKCCf9Oc2sXebp77b4fkzcNDhu4FC+uOb4RnYl5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNkrnaylAvTbOIAVfCP343GHTidK2JkjRVSf5iHJDk+/tIKGZH8XRymYyjsOc4f+B+QAc4KD/fZHIDyB39ao7pnoVmec6QdWqymQgp9V3NWfdgOZoOySdBeHVahv0cGJAUesjfuJXPbZgxGbajZ5aGOwscQUE+4V4StaFCyaW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An7zZ0d1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22113560c57so53848835ad.2;
        Fri, 21 Feb 2025 15:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740182236; x=1740787036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAekMXdTSKn8c6lPE6DiIDA18/OUujWD2ZQpt3BEMpc=;
        b=An7zZ0d1/GTQRy5POIX0zlLwQg2jGKQKe46QV55TrNgSps2HVibtzS9V2/CWyUX08K
         BgD0KuxrBv86rbWWHKGNmJthruuAPsyrlBoBQ/W/ahxNR4Bcv0agR+AQUo776nU2cEA1
         pm1KO7szHdoPfJ1+6GrrSlkvTjwmtNUE48WbpbT85OO6PaEZbtzDbJY8eGuiqwqyUiqr
         lhiJ6nSR/HEfBeN7pN8yCahbrUsMdzRmqJSw4Tjif4efzWLMqoXE0aoWEtT7hQXqKfcJ
         CiojMGrIIrUb3JK12R8h8cYbmQ0ie4vMmAQlEd6iQ3zNmSBgE/Hz3a/LUznnqiq197QE
         DQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740182236; x=1740787036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAekMXdTSKn8c6lPE6DiIDA18/OUujWD2ZQpt3BEMpc=;
        b=lDVIN2asUOyOPezE4llsB1iPAXIZpW+zExeu/DOhRoIzm/dUZv+7N07RfPUQ85ihd3
         ohVzHQlLSN7BeFLSeMyGoSrjqQpQXCYf80wfTWYLDnPXzGGzH5aI5b9rtzGOoPiLRMie
         HezcXXgM8zJsS38uyphTUKOAXVae77SejGHbcsn8Xy3zzCDVqRKiHs5/4VDwxpRYbIUC
         LCtOSpGP/LH2Dex58efa1eekJdBHEuElFCzNLRpNhfiF5jJ0U9Sxb70raZvvvz8f/RS1
         XcmlTSObbaSwXT9lueb4jL+9n9c6zK54cfch8vw02u2p2tMGAvr14VAmgDCMW5v3ab7/
         62MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvA4U/YyEgHKbbydK47Lg+jOu9KIAZv2c0cetO56OoxhavRb3A67yKBu+vDvdZ0LWGvZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm2QWdWDuCDV//d1YQejuCfu9i0OcRuleUlu8NYeD5VkAtNpyp
	a76RotOan6a3neRkZNG+jtSZHqNL2vPFBoARogjTdDnrDJya81V1
X-Gm-Gg: ASbGncu2TKNTkgyApK9qrzDlSrbKNM0a+xGNF8Ab/NIjmdzIzR2DkboZT0n3wQn3FzH
	7JdSAr9mPjgYTgeYKw5J9GMF4sT2npT4Pk4JTLwqtd/PvC9qE8LCIPindcZBLIXkz5ywSRmQ7IE
	OTP1J4FlTZnhIXSio+gHUnaA/VT4afJeaSnVZOiRJznxWw99QCEr6tPH9J5bdxgXA0dzFUYYe6o
	3NyTKiSTJexpjJppEj6d9LnQSfAwbDiBgWvxvQpmEKbykEpag60fUnCLBl6+qyW12cJ8ebM5HP5
	7d+17gbfykd5WcITgt4IVvNsxB8soFLYYHuAVqkmE9g64Jff66TA1aJ81w==
X-Google-Smtp-Source: AGHT+IHgFu4I1rR0xrCBxhus26+PsVcXk64NKKo/4m2Bv21v86IZjmbCuWYeM03AMd0j9VdXoToopw==
X-Received: by 2002:a05:6a00:2e05:b0:730:8a5b:6e61 with SMTP id d2e1a72fcca58-73426c908bcmr8296317b3a.2.1740182236242;
        Fri, 21 Feb 2025 15:57:16 -0800 (PST)
Received: from [192.168.1.101] (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73271a02648sm11667898b3a.107.2025.02.21.15.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 15:57:15 -0800 (PST)
Message-ID: <48711fd9-5430-43bf-a6ec-27bcac67c780@gmail.com>
Date: Fri, 21 Feb 2025 15:57:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] bpf: add kfunc for skb refcounting
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, martin.lau@linux.dev
References: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
 <20250220134503.835224-3-maciej.fijalkowski@intel.com>
Content-Language: en-US
From: Amery Hung <ameryhung@gmail.com>
In-Reply-To: <20250220134503.835224-3-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Norton (VPS 250221-8, 2/21/2025), Outbound message
X-Antivirus-Status: Clean



On 2/20/2025 5:45 AM, Maciej Fijalkowski wrote:
> These have been mostly taken from Amery Hung's work related to bpf qdisc
> implementation. bpf_skb_{acquire,release}() are for increment/decrement
> sk_buff::users whereas bpf_skb_destroy() is called for map entries that
> have not been released and map is being wiped out from system.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   net/core/filter.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2ec162dd83c4..9bd2701be088 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12064,6 +12064,56 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
>   
>   __bpf_kfunc_end_defs();
>   
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global functions as their definitions will be in vmlinux BTF");
> +
> +/* bpf_skb_acquire - Acquire a reference to an skb. An skb acquired by this
> + * kfunc which is not stored in a map as a kptr, must be released by calling
> + * bpf_skb_release().
> + * @skb: The skb on which a reference is being acquired.
> + */
> +__bpf_kfunc struct sk_buff *bpf_skb_acquire(struct sk_buff *skb)
> +{
> +	if (refcount_inc_not_zero(&skb->users))

Any reason to use refcount_inc_not_zero instead of refcount_inc here?

> +		return skb;
> +	return NULL;
> +}
> +
> +/* bpf_skb_release - Release the reference acquired on an skb.
> + * @skb: The skb on which a reference is being released.
> + */
> +__bpf_kfunc void bpf_skb_release(struct sk_buff *skb)
> +{
> +	skb_unref(skb);
> +}
> +
> +/* bpf_skb_destroy - Release an skb reference acquired and exchanged into
> + * an allocated object or a map.
> + * @skb: The skb on which a reference is being released.
> + */
> +__bpf_kfunc void bpf_skb_destroy(struct sk_buff *skb)
> +{
> +	(void)skb_unref(skb);
Actually, there might be a dtor that work for both cls and qdisc. This 
skb_unref() seems redundant, consume_skb() already unref once.

> +	consume_skb(skb);

consume_skb() indicates that the skb is consumed, but if the skb here is 
being dropped by dtor. kfree_skb() or maybe  kfree_skb_reason() with a 
proper reason should be better.

Here is the comments for consume_skb() in skbuff.c
  *      Functions identically to kfree_skb, but kfree_skb assumes that 
the frame
  *      is being dropped after a failure and notes that

So the dtor would be basically the same as the qdisc one.

> +}
> +
> +__diag_pop();
> +
> +BTF_KFUNCS_START(skb_kfunc_btf_ids)
> +BTF_ID_FLAGS(func, bpf_skb_acquire, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
> +BTF_KFUNCS_END(skb_kfunc_btf_ids)
> +
> +static const struct btf_kfunc_id_set skb_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &skb_kfunc_btf_ids,
> +};
> +
> +BTF_ID_LIST(skb_kfunc_dtor_ids)
> +BTF_ID(struct, sk_buff)
> +BTF_ID_FLAGS(func, bpf_skb_destroy, KF_RELEASE)
> +
>   int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
>   			       struct bpf_dynptr *ptr__uninit)
>   {
> @@ -12117,6 +12167,13 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
>   
>   static int __init bpf_kfunc_init(void)
>   {
> +	const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
> +		{
> +			.btf_id       = skb_kfunc_dtor_ids[0],
> +			.kfunc_btf_id = skb_kfunc_dtor_ids[1]
> +		},
> +	};
> +
>   	int ret;
>   
>   	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb);
> @@ -12133,6 +12190,11 @@ static int __init bpf_kfunc_init(void)
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
>   					       &bpf_kfunc_set_sock_addr);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &skb_kfunc_set);
> +
> +	ret = ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
> +						 ARRAY_SIZE(skb_kfunc_dtors),
> +						 THIS_MODULE);
>   	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
>   }
>   late_initcall(bpf_kfunc_init);


