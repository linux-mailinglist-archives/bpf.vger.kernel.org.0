Return-Path: <bpf+bounces-56000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E980FA8A67A
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 20:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A7C16D36F
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C8E22171E;
	Tue, 15 Apr 2025 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lt4tN0mI"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C96FC3
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740729; cv=none; b=emCXMHhPE7gsuhZ9mKOAMvRqmeK8BNG/gOLlTU0k0wAUEO586i05M68rhL5liVN7D1YksI5pCdRbu9DEEsWaX1sRAn+uBscMrRI86vNXOzGEhcIlyHgb4n4c2qy7VaTtt5bPx6t4CpMe+U+ldgI50ogli6J7RaZ1n8UBHb78BOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740729; c=relaxed/simple;
	bh=uw2LPhcebkesXfbZ7BpKtReHdk81nUGZ/NAABXsn32M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+5h+dx1xjkD7828KeI0kMvl7y8s394sZRoTKo7DDZIngWGrkItRaGKOdx1tGFrbqthLfjXCcUBe2FltqdDabFoYt9D3fov/TNF4suEUrEI+bna1hesVmbsthwQ53YbXeEGqrAiCaBYtn95ErhZTQSRLOE7ZcRJBwPPmB4A/qLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lt4tN0mI; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d6b24457-2217-46ec-81eb-bd0b9013d20b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744740723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1rgoV+IPqOTHC6lFkBTgUDPa9A5kn3tcNPcRtDm7CA=;
	b=Lt4tN0mIg6t9+XuTQrp5vQf0yl4FhlwBm1mB+80q6oDRowD4s4WRhgdtq0G8Y+PN5oR1Ae
	XcLyxiZWKL+gfuMHIJt5or4iTcwhLb5opFGbXDJxO1lyp46Zrk5E1fPtuHHwuxxreDMorE
	oaWOX4v82rUoPUG6fWzVm7JdqgvgghM=
Date: Tue, 15 Apr 2025 11:11:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: close the file descriptor to avoid
 resource leaks
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com,
 alexei.starovoitov@gmail.com
References: <20250412183847.9054-1-malayarout91@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250412183847.9054-1-malayarout91@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/12/25 11:38 AM, Malaya Kumar Rout wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> index 0b9bd1d6f7cc..05cf66265cf1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> @@ -37,8 +37,10 @@ configure_stack(void)
>   	tc = popen("tc -V", "r");
>   	if (CHECK_FAIL(!tc))
>   		return false;
> -	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
> +	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
> +		close(tc);

It is not even compiler tested.

pw-bot: cr

>   		return false;
> +	}
>   	if (strstr(tc_version, ", libbpf "))
>   		prog = "test_sk_assign_libbpf.bpf.o";
>   	else


