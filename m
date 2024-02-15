Return-Path: <bpf+bounces-22099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E5B856C5E
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 19:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000201F22B11
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 18:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C052D1386A4;
	Thu, 15 Feb 2024 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uFC15lFc"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D413472F
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021415; cv=none; b=Fqot+DqxsYMu2VqS5E8QcTDlhvWrsWqNnPYjM3CWMEJcgVnhSly5+DCnpWVNbDh+T+OtaOSW1tlMrqHk3TsanZwr7IKnZadAdDEaT/l20ZB9KrhonKg6WO8xDQYKNBhAIr8XCaZE4bkj+h7+cdccbPML6BhEPVAqCqUV/k6mzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021415; c=relaxed/simple;
	bh=5LvFRRn8w2JBf1aiz0S7OWvEA09LuF3ReVEk+HE1IQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGKXmrPWGqmSJgDLt/jGQLfWwl4rE79FO6rnnYhL4LlHcmnVw40buWfm85Yo+qBdbsE+Pcuq6ExI6joTlJ1JCyFBkSC7GdVTZy5vkUppjQBdXFqQxCgOlbRFCRU9HaBmIBpJniE3oxWInymGnRsoMz0Agy5EvYaN3JfqBHNIT1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uFC15lFc; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <32dd0715-1f36-4de2-ab69-0e21019eade5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708021411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGPah5lZm8XSIH2ARdZF4PNIZxNHH8SxcFmQTLjKZlM=;
	b=uFC15lFcq/GYmeNpkLL1JFosQ0HHotD5jlwBaWoRG0doHCZyPhjNUz8MSF123QqNR/EssO
	/9LFbebp8NttMU7tcLnEYuSrWr8XIHqHIMBMo8xijm6l83S9LPMAylJUJEmTBkUWBJeu5L
	WxStWjAkBceet+xDT2DUpW9Axza8s1o=
Date: Thu, 15 Feb 2024 10:23:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Check cfi_stubs before registering a
 struct_ops type.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240215022401.1882010-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240215022401.1882010-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/24 6:24 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Recently, cfi_stubs were introduced. However, existing struct_ops types
> that are not in the upstream may not be aware of this, resulting in kernel
> crashes. By rejecting struct_ops types that do not provide cfi_stubs during
> registration, these crashes can be avoided.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 0d7be97a2411..e35958142dce 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -302,6 +302,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   	}
>   	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
>   
> +	if (!st_ops->cfi_stubs) {

How about *(void **)(st_ops->cfi_stubs + moff) ? Does it need a NULL check?

Please add a test.

> +		pr_warn("The struct_ops %s has no cfi_stubs\n", st_ops->name);
> +		return -EINVAL;
> +	}
> +
>   	type_id = btf_find_by_name_kind(btf, st_ops->name,
>   					BTF_KIND_STRUCT);
>   	if (type_id < 0) {


