Return-Path: <bpf+bounces-48494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBB9A083E1
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 01:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A004188BC92
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 00:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF90E175AB;
	Fri, 10 Jan 2025 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ijwNKMtp"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2031539A;
	Fri, 10 Jan 2025 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736468667; cv=none; b=AL/fIKq59WqIqm9b4GIZ+j/40KOFV9JD0a6Y1XXgArwE1z7qOUYWQHXsuyidwwd8+BgyGAk3IO0MIEfv9uIeJ633Zsyx3k9GtWc+V4cG3It44zqf4j7VBY+9it8tj3ofWDe0nNP58e6bgMNWEgXwKfm2fTsGE9f//2xGjfSKw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736468667; c=relaxed/simple;
	bh=GS8BWGPxquM/BII+eB79T7iRWhu/QSsN8EF9McZCijI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNjsQ0H9UGsNhm+UM/lNEiv24mOqwALoKsvWJCXSSnSXl5lExhGWauO9dVSZHoDKwYG9lTOggwsGJAHk66ixjf79pMHOrGngLITQaZ3CwD/qeuDCJ/rH8gcsx8Ju35vVhZAXz5xH7KYMFCjr1z6r8Jn5/Ws5YwocLrdtf6J4mY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ijwNKMtp; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5e1c5729-9bc0-4cb7-969a-a334fb544595@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736468654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0YT8NFz2QAIyxzQyrqX30oKrIEInlbH0xRGRMTJDx0=;
	b=ijwNKMtpj/xhtDlK0iUV6Kz3H6NOfK8W3HxdG7kfUKbMdXL3nZdSsKBECP5F5ACKSe1lIR
	hVKU2CSSguzb4q4Qh6vmIhKZPJQ12imxbPBIZUjbsi74eAQF/h60Ujay9TT/mQIiXDTZy+
	jUXVYYPu0wFQJjUAKkwyJ6aKlEc04g4=
Date: Thu, 9 Jan 2025 16:24:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 06/14] bpf: net_sched: Add basic bpf qdisc
 kfuncs
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20241220195619.2022866-1-amery.hung@gmail.com>
 <20241220195619.2022866-7-amery.hung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241220195619.2022866-7-amery.hung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/20/24 11:55 AM, Amery Hung wrote:
> +BTF_KFUNCS_START(qdisc_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_skb_get_hash, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(qdisc_kfunc_ids)
> +
> +BTF_SET_START(qdisc_common_kfunc_set)
> +BTF_ID(func, bpf_skb_get_hash)
> +BTF_ID(func, bpf_kfree_skb)

I think bpf_dynptr_from_skb should also be here.

> +BTF_SET_END(qdisc_common_kfunc_set)
> +
> +BTF_SET_START(qdisc_enqueue_kfunc_set)
> +BTF_ID(func, bpf_qdisc_skb_drop)
> +BTF_SET_END(qdisc_enqueue_kfunc_set)
> +
> +static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (bpf_Qdisc_ops.type != btf_type_by_id(prog->aux->attach_btf,
> +						 prog->aux->attach_btf_id))
> +		return 0;
> +
> +	/* Skip the check when prog->attach_func_name is not yet available
> +	 * during check_cfg().

Instead of using attach_func_name, it is better to directly use the 
prog->expected_attach_type provided by the user space. It is essentially the 
member index of the "struct Qdisc_ops". Take a look at the prog_ops_moff() in 
bpf_tcp_ca.c.

> +	 */
> +	if (!btf_id_set8_contains(&qdisc_kfunc_ids, kfunc_id) ||
> +	    !prog->aux->attach_func_name)
> +		return 0;
> +
> +	if (!strcmp(prog->aux->attach_func_name, "enqueue")) {
> +		if (btf_id_set_contains(&qdisc_enqueue_kfunc_set, kfunc_id))
> +		       return 0;
> +	}
> +
> +	return btf_id_set_contains(&qdisc_common_kfunc_set, kfunc_id) ? 0 : -EACCES;
> +}

