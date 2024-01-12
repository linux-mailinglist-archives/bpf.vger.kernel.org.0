Return-Path: <bpf+bounces-19409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75B682BA83
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 05:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E70A2873EB
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 04:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AD05B5CF;
	Fri, 12 Jan 2024 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hsgylUvC"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210C5B5B0
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 04:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca166fda-4474-4046-b098-c39fd5c42def@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705035146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ex/Ge0CgFHbKJEveG37vxYtPwIHTiM55EQzSUmtWbA=;
	b=hsgylUvCH2yVsVxExtBeX70+kSoJPh6Nzq0DTAX27r44i7hMzPWxb0JK//Tz51Yzh+Rvlf
	AF0zNhgQWGsOGCn89LOt/8NzNBS4okFXEEshcj9FQO/hM2HeRKiE0hPUZDv92NBkBqRvYs
	nLcuaUq6J4TVNfPTV/ORXYK1v0Ufz60=
Date: Thu, 11 Jan 2024 20:52:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf 1/3] bpf: iter_udp: Retry with a larger batch size
 without going back to the previous bucket
Content-Language: en-GB
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
 'Andrii Nakryiko ' <andrii@kernel.org>,
 'Daniel Borkmann ' <daniel@iogearbox.net>, netdev@vger.kernel.org,
 kernel-team@meta.com, Aditi Ghag <aditi.ghag@isovalent.com>
References: <20240110175743.2220907-1-martin.lau@linux.dev>
 <20240110175743.2220907-2-martin.lau@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240110175743.2220907-2-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/10/24 9:57 AM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> The current logic is to use a default size 16 to batch the whole bucket.
> If it is too small, it will retry with a larger batch size.
>
> The current code accidentally does a state->bucket-- before retrying.
> This goes back to retry with the previous bucket which has already
> been done. This patch fixed it.
>
> It is hard to create a selftest. I added a WARN_ON(state->bucket < 0),
> forced a particular port to be hashed to the first bucket,
> created >16 sockets, and observed the for-loop went back
> to the "-1" bucket.
>
> Cc: Aditi Ghag <aditi.ghag@isovalent.com>
> Fixes: c96dac8d369f ("bpf: udp: Implement batching for sockets iterator")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


