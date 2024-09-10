Return-Path: <bpf+bounces-39468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015EF973A7E
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE608282504
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333B1199957;
	Tue, 10 Sep 2024 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKbJ3Q5g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0CA19992A;
	Tue, 10 Sep 2024 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979660; cv=none; b=VBq1nonHd+zLZBubEN30uDLMCn4alPR+sRvPN53W26e4KCe9kSfyzo6V1YdUrb+6yMARRm/Aqcz8IrOdB9XuAAV/auLOgB5/SvkDR6gLOlMIgLFAXazgKUNZ9YwauQTIrc+mxMh38DnFBDBTRWkRa1VPZ/vVlwpgf9OsSjjkUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979660; c=relaxed/simple;
	bh=8aGhRDd28YHNWYtdIHgqzl4BLz13MpLBeZUqJSWKbRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOZsl1NeyXzwR8ji3sZk1YbcAdYnegNIlhEHBMvAJLG1bpY+MMtBnmJA7WuvfwHWFkH4Z2t0G6PDC+R0u5v3w87DmmCp6+XnWiPjo4HCCEzdlrFa4HxOwbapWJXCO26FnY2rOKMnOFBxcWF9MlR/3JP3g7xXkpZxopHzVmYTymA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKbJ3Q5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F23BC4CEC4;
	Tue, 10 Sep 2024 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979660;
	bh=8aGhRDd28YHNWYtdIHgqzl4BLz13MpLBeZUqJSWKbRg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aKbJ3Q5g2NF1noT8deAAdAyfuwIpSYF15RvNse+uyy6ccyiZZoujAUBywkvktZEtn
	 9q6qEusqC4dSDl+suD1cNEhsr9kjFSKdGKMhkdYiw1zQB+yy7D6obAI0yzbrPQP42S
	 xUhuXmHh69QaJTIdKNDfXORPssgGQS2HP/T/xHxOrvERN23iqSNGCru3Kv/Oa4c1Z0
	 hshoKCzgpjrIxLspKw6hqSJ7ALNSA2q2sfIs1kY+J2z2sqTtcswDuboXnVktct6iaz
	 e+TYYl/eFD9D5Kz6dbwklOCd54wvSdR2i4+Q3jOEFUxwZ3+55bsehEFK+VEgopmvQ4
	 xIcrL/t/6GPAw==
Message-ID: <c18fefbb-b22f-475f-9912-63162bf84765@kernel.org>
Date: Tue, 10 Sep 2024 15:47:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix undefined behavior in qsort(NULL, 0, ...)
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw
References: <20240910125826.3172950-1-visitorckw@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240910125826.3172950-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

2024-09-10 20:58 UTC+0800 ~ Kuan-Wei Chiu <visitorckw@gmail.com>
> When netfilter has no entry to display, qsort is called with
> qsort(NULL, 0, ...). This results in undefined behavior, as UBSan
> reports:
> 
> net.c:827:2: runtime error: null pointer passed as argument 1, which is declared to never be null
> 
> Although the C standard does not explicitly state whether calling qsort
> with a NULL pointer when the size is 0 constitutes undefined behavior,
> Section 7.1.4 of the C standard (Use of library functions) mentions:
> 
> "Each of the following statements applies unless explicitly stated
> otherwise in the detailed descriptions that follow: If an argument to a
> function has an invalid value (such as a value outside the domain of
> the function, or a pointer outside the address space of the program, or
> a null pointer, or a pointer to non-modifiable storage when the
> corresponding parameter is not const-qualified) or a type (after
> promotion) not expected by a function with variable number of
> arguments, the behavior is undefined."
> 
> To avoid this, add an early return when nf_link_count is 0 to prevent
> calling qsort with a NULL pointer.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>   tools/bpf/bpftool/net.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index 968714b4c3d4..13e098fa295a 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -824,6 +824,9 @@ static void show_link_netfilter(void)
>   		nf_link_count++;
>   	}
>   
> +	if (!nf_link_count)
> +		return;
> +
>   	qsort(nf_link_info, nf_link_count, sizeof(*nf_link_info), netfilter_link_compar);

Thanks! As the issue is calling qsort() with a NULL pointer, could you 
please make the check on nf_link_info rather than nf_link_count? I'd 
find it easier to follow.

Quentin

