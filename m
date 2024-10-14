Return-Path: <bpf+bounces-41877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1DE99D5F9
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 19:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C709B24F3F
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 17:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E491C9ECD;
	Mon, 14 Oct 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E6rGFHgt"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA941C75F3
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928521; cv=none; b=mOgeJiLHqBKFuMNxECEFTIHgO+eSps2GD5sY+X/ElmiRbzXYTkTl/o3MG8N1nNrqXTslKc4ITlZBpJfb/0Xpp8Iq+NxFmnKMD315b4S8Yr37Oa+uSlnSrSG8kg0Ckj91nyKEKcMcfiCnuHdEX+6MeeLoFwhAOigPH9c1FDTctY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928521; c=relaxed/simple;
	bh=7F/YSsxMIxuV3Iluxq9PQ3qB6hKRBJ/7OfFSmkwS1L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8mVrrkFNDqOaJPcEhXH/iGmOUkkzRWYvw9JQ1IXWlGQ4Y7Bdeuyo9W6MLb7hHbRkzw6t7ENU5v0tMs849I7eujyX6LkK+5LDaebVLm4MHUbTYW4rcKVbBCDjnpAH1Q41oRUvMP1GFc6q+Rzgy8/zgS+CNVSm+Qj1sSd/sbJlFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E6rGFHgt; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0fc5862b-7b51-4db3-bc4d-634e7cb0333b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728928517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7F/YSsxMIxuV3Iluxq9PQ3qB6hKRBJ/7OfFSmkwS1L4=;
	b=E6rGFHgtuSFJ0Lix9uRg3G3s6Vhlu0iM6FCD+rIQ7U/XsldTrfotXSWkVbTkjfLaCYPV+b
	wt/vGSzgQlEXTNj8/M6dWyuG3Yvcycg3ZMCXb1jy3sYkl8HHGeKL3FYBAL03xrUUHI3dvD
	CZp2r4ICWbWZTZgkDQNh+4rMJOddHyE=
Date: Mon, 14 Oct 2024 10:55:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] selftests/bpf: Add test for truncation after sign
 extension in coerce_reg_to_size_sx()
Content-Language: en-GB
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
 <20241014121155.92887-3-dimitar.kanaliev@siteground.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241014121155.92887-3-dimitar.kanaliev@siteground.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/14/24 5:11 AM, Dimitar Kanaliev wrote:
> Add test that checks whether unsigned ranges deduced by the verifier for
> sign extension instruction is correct. Without previous patch that
> fixes truncation in coerce_reg_to_size_sx() this test fails.
>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


