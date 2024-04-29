Return-Path: <bpf+bounces-28174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FF88B6494
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3D3287423
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4D51836E8;
	Mon, 29 Apr 2024 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AbHh93+X"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8E8177986
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426182; cv=none; b=KjrfwMl8VEp++4wwtU9TzSuX3GJnIEV4izNwJK4+P/+VQYhm8wXhQOrLUvHtMRlUBE7B564skM/H3AJ2etIc9vHPgZV2SYpOEVQ4+u7U/zkZu8Wmbs4iDxuOqZ4iyu8dTbNw871DD24nbKeU2k2W8i6a/YCkTwBCdqCEZidWVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426182; c=relaxed/simple;
	bh=gezgwSLFbg9jkHzQ6DXkspq5YPuAri72kaP/o29XpbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7nuoaOoS2gsIENbYE7od50pGiV6E2t0Zz0lY9z3oVfq53EEHZiwAjNRIBC4alTvaOWzCbpfnRqg3cNdLOe7mvwr/gr17K99wj6dgCV7YG6TIrDcT89VWdxmCPf1zZxytWYF8FdPq3lEUXYyVQE5D3t3oAnb0p7Q5xk5k0+DJzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AbHh93+X; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b3e2db0-1582-4f35-9cee-069de799aa41@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714426176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOjII7YcAH8YrF1iqQv78p3c+SYkVz/5StE7TIU64ME=;
	b=AbHh93+XaIMQNMhVmZZDBcwU/ismfzRVX1HK1C1V3B0Lpi4r2OvG1Go0HU5rADiY4Xb/gc
	xivJqiVEsCXs7XsqByu4L4KnUPWzmRVBs49ZvQ3pEYRloNCJcHgq3Z54pChPhO2hqkfT8c
	DlskL3lBj/ZuM8ENW6pgEkGmJ4fXp4A=
Date: Mon, 29 Apr 2024 14:29:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: validate nulled-out
 struct_ops program is handled properly
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com
References: <20240428030954.3918764-1-andrii@kernel.org>
 <20240428030954.3918764-2-andrii@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240428030954.3918764-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/27/24 8:09 PM, Andrii Nakryiko wrote:
> Add a selftests validating that it's possible to have some struct_ops
> callback set declaratively, then disable it (by setting to NULL)
> programmatically. Libbpf should detect that such program should be

such program should be /not/ loaded ?

> loaded, even if host kernel doesn't have type information for it.
> 

> @@ -103,6 +104,10 @@ static void test_struct_ops_not_zeroed(void)
>   	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
>   		return;
>   
> +	skel->struct_ops.testmod_zeroed->zeroed = 0;
> +	/* zeroed_op prog should be not loaded automatically now */
> +	skel->struct_ops.testmod_zeroed->zeroed_op = NULL;
> +
>   	err = struct_ops_module__load(skel);
>   	ASSERT_OK(err, "struct_ops_module_load");
>   
> @@ -118,6 +123,7 @@ static void test_struct_ops_not_zeroed(void)
>   	 * value of "zeroed" is non-zero.
>   	 */
>   	skel->struct_ops.testmod_zeroed->zeroed = 0xdeadbeef;
> +	skel->struct_ops.testmod_zeroed->zeroed_op = NULL;
>   	err = struct_ops_module__load(skel);
>   	ASSERT_ERR(err, "struct_ops_module_load_not_zeroed");
>   


