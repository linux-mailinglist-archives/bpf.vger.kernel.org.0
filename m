Return-Path: <bpf+bounces-51472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F61A3520F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099993AADE3
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 23:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DFE211A3E;
	Thu, 13 Feb 2025 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uFdAUC8K"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669252753F5
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739488660; cv=none; b=s52o6j2atpwl+g9fw443yl0zWfhekuHQ2emV+zp00fHKNqXMBIQgCzyfx+huAKZmaWGXJuflZdCE3pFeGEf90PWuZ0AE9F8XuMT7B8sR++e3UiNj38zLkM/+ckp9hCa6ErmkPD+QUSf+7Pbb34J7VgKE5WNbIHmORJEOPEdrm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739488660; c=relaxed/simple;
	bh=ibgD1KeBBDE/o54XbTGqByob9azk22roqc7uZ+b0BRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VszBKT2Xvje6CE76br8N5qBieIo7lmiqcnMbk8wBQvDBLZta6CwlXxpGCn1rnbTuQL1mNfmPCP1Vu7fc1BidIE0GdFDs5VcPWd1XJnpOGL+cdu7jXxZ/j4xkGigPC8vWUdTPKdww1kEOUudHjDwWGGaLDXJQdRBdru+uLlYYXa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uFdAUC8K; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <05bdfc57-5a6c-46ff-aa35-75f8d28b8942@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739488655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//TYarwPNNs0x+KmQ7TGUkWmAS6bODOFzsKMNtGO9ig=;
	b=uFdAUC8KiZJ/d34+RJTJ/SD2ufFnYM5Nl5PDyfj4UwWWxhEg7AjM2zKR5I3fWwVRhEt/YE
	fZaEUQIxywn/BY4/mf7pXcfEd3dLHg2/4o4dd4LEYcrUbTi1rZEa88hhYZrGdXH6Mgq32z
	AES/FZxfQUgM9jHV9sNrLT1c6rSugxc=
Date: Thu, 13 Feb 2025 15:17:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] bpf-next: Introduced to support the ULP to get or
 set sockets
To: zhangmingyi <zhangmingyi5@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 yanan@huawei.com, wuchangye@huawei.com, xiesongyang@huawei.com,
 liuxin350@huawei.com, liwei883@huawei.com, tianmuyang@huawei.com
References: <20250210134550.3189616-1-zhangmingyi5@huawei.com>
 <20250210134550.3189616-2-zhangmingyi5@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250210134550.3189616-2-zhangmingyi5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/10/25 5:45 AM, zhangmingyi wrote:
> From: Mingyi Zhang <zhangmingyi5@huawei.com>
> 
> Note that tcp_getsockopt and tcp_setsockopt support TCP_ULP, while
> bpf_getsockopt and bpf_setsockopt do not support TCP_ULP.
> I think we can add the handling of this case.

The commit message should talk about the "bool load" related changes in v2 and 
why it is needed.

The subject line is confusing. How about,
"Support TCP_ULP in bpf_get/setsockopt"

The code changes lgtm.

> 
> We want call bpf_setsockopt to replace the kernel module in the TCP_ULP
> case. The purpose is to customize the behavior in connect and sendmsg.
> We have an open source community project kmesh (kmesh.net). Based on
> this, we refer to some processes of tcp fastopen to implement delayed
> connet and perform HTTP DNAT when sendmsg.In this case, we need to parse
> HTTP packets in the bpf program and set TCP_ULP for the specified socket.


