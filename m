Return-Path: <bpf+bounces-50064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC4A22591
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 22:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED0616712E
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 21:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F85A1E2838;
	Wed, 29 Jan 2025 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qCwBoij2"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C919CC33
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738185638; cv=none; b=CDv+zruSM0DvdHTwBK1h9EheiUC4iaeWQgvd6nD7nNeOhFArFGU82KW+ypKy++zWLXf2nxHrF//YjrxgG1ADLTngzabRkc2aRtoIEt2E63hEROHGNr33T1scfr79kjg1OCEmTqm8X+a71Z+13fCQO734TNM7Y8NhLj+bQi3VvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738185638; c=relaxed/simple;
	bh=X4Vt1hgB0RIXoAXaBj053a1Hzi/IcGW3aTYft6oZQN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyClSXeNLBbQM+ous5pso1300GfXhYJbFjkdedEQRzI0lLDgs+REgUS/qVmjnQK/nw+M5SlYPkfBUSp3BYTgDSVDXEEakAzPXWJ6NAtjtoNmxiYYPMdcY0trle3tpOly/3LKYgPjak4NmNsFuI0D6ogFAagDPuZnFQZ2vHiVG04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qCwBoij2; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bf0e9c67-b1c9-4e39-8af0-ff2bdc493359@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738185633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9huOPBN/p8VtKMZYUp1GteZOwJEA24wLhGfKuj4zrQc=;
	b=qCwBoij2yV+m3sYW9BABT7t8GyvT6DpFy2iGZxfnIlgGtLE1GuvnebkKWj6rW++k9ve0hF
	Qp+zloVlB7CI5tu/Kz/BhcHntAjhgzYibohhT0vXLWt5APetbeDagiPckx2l89jWVHMiC+
	FLn/amf8j8mMdUGJdyNkLdt5KA7rzMk=
Date: Wed, 29 Jan 2025 13:20:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] ipv4, bpf: Introduced to support the ULP to get or
 set sockets
To: zhangmingyi <zhangmingyi5@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, yanan@huawei.com, wuchangye@huawei.com,
 xiesongyang@huawei.com, liuxin350@huawei.com, liwei883@huawei.com,
 tianmuyang@huawei.com
References: <20250127090724.3168791-1-zhangmingyi5@huawei.com>
 <20250127090724.3168791-2-zhangmingyi5@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250127090724.3168791-2-zhangmingyi5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/27/25 1:07 AM, zhangmingyi wrote:
> Note that tcp_getsockopt and tcp_setsockopt support TCP_ULP, while
> bpf_getsockopt and bpf_setsockopt do not support TCP_ULP.
> I'm not sure why there is such a difference, but I noticed that
> tcp_setsockopt is called in bpf_setsockopt.I think we can add the
> handling of this case.
> 
> Signed-off-by: zhangmingyi <zhangmingyi5@huawei.com>

A nit that I found it useful to recognize different authors of the mailing list. 
It would be easier to have a formatted name. It seems "Mingyi Zhang" was used 
earlier, as seen by searching the git log history.

