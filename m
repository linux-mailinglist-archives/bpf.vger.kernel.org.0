Return-Path: <bpf+bounces-27734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 735528B1555
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09AAE1F24734
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 21:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2AB15FD15;
	Wed, 24 Apr 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KEvs492O"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D241586F4
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995449; cv=none; b=s4CCM5/u6jE6wFEQM5hel2bK1mStHnLWqeXIlQuTjN8Xmy012t2EVRPFm1Y6yj8RhelqOoz4Z5lTk+QcTG8AR1lHvJtL0OWhkYbMfjKSOYYni3UJDgWFRiCC7HuN74T1uJp8RpTacT/UCwXMcxL9VqJ5DP6BPq63g3J44F82UaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995449; c=relaxed/simple;
	bh=U/f0nf6h9F8yps4GjM0xDWooFK92vVOs9kuCXrbPIbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBQ7XyNkXC7wldWn3Yp2v5YUp9oH8L7Tguhi3yjwc0jXSZK1ZY/RdRMQski+i5cuVk14eopNxfJefeNooZjD9Owo+H63D/G5yUDECeGFmbNqc5HqCycOVXExYw9TtLAmGNuZjx2Io9EVQJYJMnyz7CEK5Gl1Xq2YKuUrLtEIZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KEvs492O; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc80d845-5bd1-4c09-a933-1d74bed6c416@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713995444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/f0nf6h9F8yps4GjM0xDWooFK92vVOs9kuCXrbPIbU=;
	b=KEvs492Od2v18DpUsp6LMGgNVEhYwjmRfjXkyITlp7RpSdzm8dhJ/fvERbRugVeVFQjZ0Y
	zZDV3nsegoWko02dJHYexIp3zwwuqS0jULpo7gyW9WX2wHre8GOj1WViJo3jU0e0vqC797
	yJlTq/OZGPDU3Hq+NVrkbr5WCJ79Two=
Date: Wed, 24 Apr 2024 14:50:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] bpf: update the comment for BTF_FIELDS_MAX
Content-Language: en-GB
To: Haiyue Wang <haiyue.wang@intel.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240424054526.8031-1-haiyue.wang@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240424054526.8031-1-haiyue.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/23/24 10:45 PM, Haiyue Wang wrote:
> The commit d56b63cf0c0f ("bpf: add support for bpf_wq user type")
> changes the fields support number to 11, just sync the comment.
>
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


