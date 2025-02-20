Return-Path: <bpf+bounces-52115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C983A3E860
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBEC17F6DF
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 23:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF122676C7;
	Thu, 20 Feb 2025 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I63Z23J/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED825266F1D;
	Thu, 20 Feb 2025 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093909; cv=none; b=Zvpe36jJK0fLfVpOIEoG8+sp80h2Tlqz63DYF5VBvVu+4kCNFBg6TD/uqzzOjHJ2KhhLbS2efE8XpeVAPyGB04W0NY/D+oc7fb+acgkoLyD7XJayyv5YLhCpZhd/N0wux98MTAuDw7LG4LUDsiw4I7VLQjFEhCIVeJV9P/Qz/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093909; c=relaxed/simple;
	bh=Tr9i5oFLNWr8QZbdaiVtyBE4F/KHBJtqM1XeQBJbgsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNQFysFeWv7RshFRTXB/+KCiNDDbmgU8iPD5iK1iGeptLqcQ7nboUGC84tPdlmhGM+hqGLF04fsTPmCJ9nguG8r0Bg9Z7vfilwH6F+GRqA7t5/PSaNnH39kKWM9i2f9Hw3EYukKZCAUmIs0v5b0gh7jtzyuZaq3fjiHGGdsoDNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I63Z23J/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e83d65e5so29361455ad.1;
        Thu, 20 Feb 2025 15:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740093907; x=1740698707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSHegRPqzKWDCQNMzg7J1hAVgtGzX79ycFsm084tjLI=;
        b=I63Z23J/4Smu8q5lugu1deuXxxn5k2vqebPuvEjFIEmjyEPY12FWrZ3h66evQMLMTl
         VuKLJncw7U4QokFovNXkzCm1XR3Guyp4cPFbQOAjZOme4DTNORb0xd5CIw99N/+kxNMK
         b4pfAthEo3bV2S8sjIoXq5TEQ8C1IGccJ+cTJdG+zA1sidsmTUWaASniOdTU0v+xChBa
         opoJMxub2L16TKSQxOjLxxrSoSuEoGZUOgatFpz/0gPTGoK0OnzNf8ebLZheLdef6Cfm
         Av9NMjEPHccVMaudsTRXQJoUkG7ENw86yn0jZcQK+HJHSrM5rDGq7egzZNvbAhvpcVzw
         xUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740093907; x=1740698707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSHegRPqzKWDCQNMzg7J1hAVgtGzX79ycFsm084tjLI=;
        b=boHffBMx7rt9wNCg0JGshwLIpalTvZMWct7dMg31LlatlFIRCIKqlaGJJ1FeLZFx0s
         xCPoudrBHAYmlhlQ6yKzQdMQNC1SyFB4UIqittYuoRC65KR8NzQVkNFFuOA3NsbKeNXZ
         ruggY2h0+woEdh3fQrGITTieLqzxB9TiiepGhmjqozap8xBflrUeUrW87Iz7AnKUWpp0
         wYMg98Mts1sRalItqDIZOqUfKAlwKUydCqpR4fewKEPp1sSAw48/lj0zVpyVw3MncHNM
         BtIskj2+ANFaS9XfVtgZQA/kS83rSeDSNpQ5mU73l3us39lZCWHpwyaN+obTiGyqjjr2
         i/PA==
X-Forwarded-Encrypted: i=1; AJvYcCUaLucZlfY4+QqeAgtCDw/bsvOrRiIPRNpfELAHZG6T7LAvUeVIdd7l04r7p6dL951HMFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoldXeMozFFv2QAwezErS1kA/2/xOxbLx49Sh4oXxr2/xniZYJ
	jQPS8jOdUmbnPJnYq+KfjqCyLeWXjJCZ/fJMUF1QSf6FifQZb7x+
X-Gm-Gg: ASbGncvtAkpqz6Ow3hNmFc5FAz8fcRPm+6/8u3+74qZLT6z42UrtTEHB5AhV+IPgxcr
	b+etvsAyh9rvUiTkKk7s0pIWZwmUOQixMIJfmIr9/zfAVD3rKdENJ6Ve76MqcHOewUwwjCPSxA5
	Hw30y8zOTEqfUg8pLa0w8XVsPktcFm9afEdaEac2QYmHUrvecvu6wQCFmvuj5eBqxTakpvz+NtJ
	nFh7Cprzwsm34gvaHnBRI4IVumwaeSTxkzntr8alrXNzdJkEvGnPbHtKrtz1HJy6lIDCuc9YxGv
	uoi1yRHTC4QKUqz35Hs0iwoh7wb7+RHGuSQbtIkIQyxN
X-Google-Smtp-Source: AGHT+IE/jrt4DG1J1YBVY17QEL/EtmLqvn5izcbTuN/URK7fs0Rf4TLe6H80tBGweORrSw/nRzPb5A==
X-Received: by 2002:a17:902:ccca:b0:220:d272:5343 with SMTP id d9443c01a7336-2219ff61dbemr16887605ad.27.1740093907076;
        Thu, 20 Feb 2025 15:25:07 -0800 (PST)
Received: from [192.168.2.3] (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add21f2149fsm10966530a12.1.2025.02.20.15.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 15:25:06 -0800 (PST)
Message-ID: <0e66379b-3b37-4bbd-9e9d-1f934cb1fdc8@gmail.com>
Date: Thu, 20 Feb 2025 15:25:03 -0800
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
X-Antivirus: Norton (VPS 250220-4, 2/20/2025), Outbound message
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
> +	consume_skb(skb);
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

I think we will need to deal with two versions of skb dtors here. Both 
qdisc and cls will register dtor associated for skb. The qdisc one just 
call kfree_skb(). While only one can exist for a specific btf id in the 
kernel if I understand correctly. Is it possible to have one that work
for both use cases?

>   	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
>   }
>   late_initcall(bpf_kfunc_init);


