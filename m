Return-Path: <bpf+bounces-38194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09389617E5
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 21:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F27F284591
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC7F1D2F5E;
	Tue, 27 Aug 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J5zDMNk+"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC921CFECE
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786369; cv=none; b=d+zn/0ED/ycjsTiiqG6ZOXlzR7ltAp+bhn8hj1Aq9EEKsvrOXoFb+XcS7t2u7Oz9Ob3Lwnqh8GCg/sLI43sGKmefgjy+OiAH59wIhOeYWRsw/APe0UBt+ioih+RgcRdJ3LXAgBOwYNLPSsB4iz7OKFAA3+KOaZIYb/+0Z/Kn4Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786369; c=relaxed/simple;
	bh=RNpY+ADgJedDrarH/WzwLBWQri7RLOphFIRQ2hVeLhI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LJBOsTXOMfjtAFo1VtjddlQk16tL8eMW8IRbURtUrJdiQlC5jU84jgNqFMEo0NSfkIDRb5FIFP8XePOMCQnlSAgomWfVWOdsaHrC2AV+ltKymXbIiWMOnPoMT8RaAiwpFRlIAWgapkoiqQh9HQNd9ku3xUbSczTDEZD3ig5cGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J5zDMNk+; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d6101cc4-5c8a-4854-adb6-89e2523aa6a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724786365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MCENj+0A+dw7HJ0QAxDvu8zrQXa2zbkYxpJHV5UeLs=;
	b=J5zDMNk+RsWcywgNDsZgnmiXpe4YcLKJlLsIqlXS7lOQy5Tj7Ksrf7bfgZwX+hbV7EjatS
	+mg/hQhAjlsbBD+1b4AVcHTAz+HiQmIV3V7gZfstYG6HqGP0Y0HYVX04HxjXI8zM7vb5MV
	oAYqxcDf5XGtEuifOK8sos6Smbw9ldA=
Date: Tue, 27 Aug 2024 12:19:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 3/9] bpf: Add gen_epilogue to bpf_verifier_ops
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 Amery Hung <ameryhung@gmail.com>, kernel-team@meta.com
References: <20240827181647.847890-1-martin.lau@linux.dev>
 <20240827181647.847890-4-martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240827181647.847890-4-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/27/24 11:16 AM, Martin KaFai Lau wrote:
> +				memcpy(insn_buf, epilogue_buf, INSN_BUF_SIZE);

There is a bug in INSN_BUF_SIZE. My bad on testing in an older kernel before 
this change. I will re-spin.

pw-bot: cr

