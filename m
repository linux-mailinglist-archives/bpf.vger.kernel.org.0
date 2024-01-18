Return-Path: <bpf+bounces-19837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479198320EE
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 22:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9771F25CF6
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912E02EB11;
	Thu, 18 Jan 2024 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AFhkIZrN"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6228B2E85F
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613794; cv=none; b=LplnzrZbqyu2d9zko6ZqXK4Lql0lBiTtCNDD7292raHL20H03qswSVIFM3TdIBkQWrQAaZzMQotKoIh3XAjdZKo8/3NMvFjZ5+pVkyDJIBJTMegpRYr4V4bdXKRFxnRwGcij2ECOqH5eSEZZz2Y0l3raahyOs7lp0kvgiQF+B6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613794; c=relaxed/simple;
	bh=NFX5z8ocbGU4205ZmpCnfDPugoQzn+JqEp0GyyHrjwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZpmAX1F1ql2lW236Tl/C+knsPa2H128LAKFn8aynBoi4Q6Bb6MO3TdWwgKJJku8YWf8Zyv3YtLRHg3MXh+Z/QY6uWV0MnHnBaEgX5DGZy8UUcx8++m4MawmiXRizkpkrZ0s3a9T8efl8hmE73iCjZzahQAZFz7X//64PIA0HMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AFhkIZrN; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f9160cb0-c461-4006-bdea-0536cbaff917@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705613791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnmYAnAT82ygc7doFRNb4zNVtPcI5J2NHFmiq1Q44KY=;
	b=AFhkIZrNR/YvuLuldZyH+pbLq1I7JlxeLTqi+LSXxco5zGFUJ0SOQ8rfeN9iz7pF4DSGGo
	vKf9/HFUTZhq2YtsC4mp8ehHnW+27GCBocGIiEca8TnkbxfShNos2In/rK1HZpyHCz2RjM
	5QmnkubQPPUecO0gxXWv8cc3Qk7EcIg=
Date: Thu, 18 Jan 2024 13:36:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v16 04/14] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-5-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240118014930.1992551-5-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 1d852dad7473..a68604904f4e 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -584,4 +584,6 @@ static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type
>   	return btf_type_is_struct(t);
>   }
>   
> +struct bpf_struct_ops_desc;

A forward declaration at the end of a .h file is suspicious....
Not needed also?

> +
>   #endif


