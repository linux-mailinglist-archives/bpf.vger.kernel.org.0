Return-Path: <bpf+bounces-64285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC475B10F58
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 18:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F9A1CC097C
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628F14430;
	Thu, 24 Jul 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lj3kW/JF"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16381DEFDD
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372890; cv=none; b=F/DD3ArfqaLQf/d3FyKjAACvejsyNxOsePYu656TUuK/RZQvB0yxfT7FctGIoMG7d4cK6WzilLTcsdRjtisJod4/Rx3qOnW/0jy6FBSME+uvYDjXY2f2S8ziyBL5zLEF4v8NUPAzaExQzzGHEZfpq7XLiXOcTHnyx8W3NSp0Lpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372890; c=relaxed/simple;
	bh=gikTh2WztXqD07CQ3v0B35UpxUJVSCJ8VdXOx7vfrYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rj7JDu6RveOfF+f4cSJZdqiT8drIdayGJC4AS+6We6tKV4kJIlsoX4DCLUo92HNvuk5k5mOCpk9Yt0rmsDrhDoiYNF7BHluOet+1+DF1J14gp1xVXC8jHlN3MPqQkovpHQovv725CIsTAMDQmHXu6fw//FDsi7L/oDVIVpVUiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lj3kW/JF; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <68b0312b-c412-4cb9-992e-df7b66e02447@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753372876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gikTh2WztXqD07CQ3v0B35UpxUJVSCJ8VdXOx7vfrYY=;
	b=Lj3kW/JFbbQ/ViYS2+vO1ep/HvuTNaIs5916Ci0bTk7uplH6TEn7nJJrFXU+tH7fjcGcUd
	ESuz0X7/MsnZjx/s9/v19B6mdQlripGbYbcoykZIFUBPpa49JPELvInTFm7BdoUeP8PpiK
	AzG6mYtnbm1qpLUyrW6wM65B4hjbWPo=
Date: Thu, 24 Jul 2025 09:01:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpf: move bpf_jit_get_prog_name() to
 core.c
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org
References: <20250724120257.7299-1-puranjay@kernel.org>
 <20250724120257.7299-2-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250724120257.7299-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/24/25 5:02 AM, Puranjay Mohan wrote:
> bpf_jit_get_prog_name() will be used by all JITs when enabling support
> for private stack. This function is currently implemented in the x86
> JIT.
>
> Move the function to core.c so that other JITs can easily use it in
> their implementation of private stack.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


