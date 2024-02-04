Return-Path: <bpf+bounces-21160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A25CD848FDE
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 19:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D39B21EC6
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 18:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655CC241E5;
	Sun,  4 Feb 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a9au3i4K"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61724A07
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707070539; cv=none; b=JUU5aPNm0u23osRo10UAxqS2vVF8YujG/CbQSB0CYki9l22YayfgdSYluZhDvwhswBVLDrxuH/OIeFEBHORzT0SQIiauBm6orZiqfpvvST727LHhGWpe3Ji4JLlYpv0ucgLA1OkPGyyiLAlAMRfyhAXB6aqhegMiyGixOeGGhr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707070539; c=relaxed/simple;
	bh=jZZrS6uaXEB/SASLT3YiJpiufxteZ9I2V744WO7n0mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9wmwNy3XI+Wb8YDG7WTiImf9GYikdUNjMFG1BXeQAGKt/BkY5OgGVt9vLMH8P5qdinXJw7npgSEth+z149QZZ0P4AYJmvOd8sRA7hq5q2YNFftqcesU0LPV1u8vEnLPyBuBaSp2KLA4IBqSGhClzRMjVReUp1OvIJs4KrZfhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a9au3i4K; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <174111ff-451f-417f-a4ac-b749157cd31a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707070535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZZrS6uaXEB/SASLT3YiJpiufxteZ9I2V744WO7n0mk=;
	b=a9au3i4KYM7pQbeUhCQe735+wOIK+fsUOemwpkI9kZN4qDY7SwzYFNRVmfL1ZsP0BG5KYx
	VTboo2KtJPD9m4s/RUgZmRNl6iVg4XuOXfL10v23L9wtYjg6Bi6t/0FM2Vt4me6ZBfGXoL
	Sp4UuIJFmfzEv2Rr+emlfXsikihOfgw=
Date: Sun, 4 Feb 2024 10:15:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Remove an unnecessary check.
Content-Language: en-GB
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240203055119.2235598-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240203055119.2235598-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/2/24 9:51 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> The "i" here is always equal to "btf_type_vlen(t)" since
> the "for_each_member()" loop never breaks.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


