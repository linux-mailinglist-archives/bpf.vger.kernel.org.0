Return-Path: <bpf+bounces-36711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4978E94C56D
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 21:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86AF1F2537A
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 19:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5A4156237;
	Thu,  8 Aug 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UopAb7eA"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22938155CBF
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723146292; cv=none; b=GBr4wUQCIwRDpNLi0wzPhCNkH+1BRMSKRcev6dZeUngx/UJCqJuD9o57PW6OTLHdZyxaFEamlwz+PV9+0Ulzprv/dYhMuKUgAZoPAxtjK35q+4S6I0/We8d1lj7yCGwsq5/9jX86qlqJ6V/WOALXBGKT6FtezzsNAB5uzuENm+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723146292; c=relaxed/simple;
	bh=8t6eKgZ20h9kVEwb34ilEOegYbpwFlqPIYJs3vsToFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A30AEVgOm2Z7naNKRNmGdaZeZnAWclIQYV2TC7ajIHiqpLk6HdlCLXaDorKQxionLpGNxhODgQCd0kK5ts4tERh7uRS2KUpHvGv2HJ2/BRp9HrMV5uiH92yi9G+bApRvKQTcAMyJ9bACj3GP0wnWKKqJY2xQQ51BMwwQx0aVGm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UopAb7eA; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da319aa5-b57e-4d5a-9782-3df05a70ab0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723146288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lr+CuJr5lnkWHt+OXCjW57QsGOUsHT8BzBPk5PcXDlk=;
	b=UopAb7eAAGVBKuEfNoq1TGPO6uIF8R5NT4emv2h1KEfuXu5HMQnyVcfZTiNNRR/Rr5Cub6
	rJByMxXFvOhO8wJ1ao1oij4zWz3Uqxu/oJminMSsrJKl4spBu0obWPhcCS9hfNrBwaDl9+
	vlt4zpi/RTmgs9qWgd0UuFiT6u/RnEo=
Date: Thu, 8 Aug 2024 12:44:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/6] selftests/bpf: Add the traffic monitor
 option to test_progs.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, sinquersw@gmail.com, kuifeng@meta.com
References: <20240807183149.764711-1-thinker.li@gmail.com>
 <20240807183149.764711-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240807183149.764711-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/7/24 11:31 AM, Kui-Feng Lee wrote:
> +static bool should_tmon(struct test_selector *sel, int num, const char *name)

"int num" is not used. -m is name only, so not needed?

> +{
> +	int i;
> +
> +	for (i = 0; i < sel->whitelist.cnt; i++) {
> +		if (glob_match(name, sel->whitelist.tests[i].name) &&
> +		    !sel->whitelist.tests[i].subtest_cnt)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +


