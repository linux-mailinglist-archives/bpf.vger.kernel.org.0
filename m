Return-Path: <bpf+bounces-63932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D49D4B0C946
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACAD1AA845B
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84C2E0B6E;
	Mon, 21 Jul 2025 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rcB2Qu52"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF72E092A
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118003; cv=none; b=fOfhNqMuE1wIrD2m8jLFfdfdFPBEjb6bJkDmuxOiuVjCClQPxP5VWTtWTqgidwDZCNmXfF8sZBJViOUyYF3g2kI5SEXiuP/4SKnd0RYXdBZyfVkrOUfX3BWTxmsvdMOJm+EPYjm8kENKyoAdEDvLnIKJky0RbPTAyk3wmktSztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118003; c=relaxed/simple;
	bh=w5zDb/4/o4vKjzWPghOdfFVDeJ4Gzyv+YjO6AyGR6cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHYTkbV3ojPGPP8P1cEElycrUeC4ypi4nxHp+aMtInOQXuY6Moh6Kv2dJ2pnUzXgtUx7jcctH6CpeOSkcKSfZ6tVzTH5CMy5i97ff9tdqgj0/e6rWxpwwGBs8qB03LG6+hSgnl3iSsU244cbZThuOay9cRmF/ZR89ud3KBpdNyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rcB2Qu52; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f05cb3d9-b9dd-4ef6-9943-b98224be2f13@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753117996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lftOTbQM0VCHLMgO9/broFkNiukV7PD7T8FUSe0rtR0=;
	b=rcB2Qu52qlXPQZnDpyr3s5PVVwL/cE+YvyYdDtkJagI7LwWppVcB4pVZt4ubPV5oO/iUy7
	Q+XQLhzcChGvcEfn2vMZ/agzv7KQ+uibk80r0uOUNAOZmuVwnXQCT3ZUyuq5gc7O7wtB0u
	qEQt9WYJQndbwRIYt+60JrglcxNRA+A=
Date: Tue, 22 Jul 2025 01:13:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf, libbpf: Support BPF_F_CPU for
 percpu_array map
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, kernel-patches-bot@fb.com
References: <20250717193756.37153-1-leon.hwang@linux.dev>
 <20250717193756.37153-3-leon.hwang@linux.dev>
 <CAEf4BzYNRwgqbBN3QiPxMbsbtYOoV1Da3mqMhtgE8jPw6eYUXw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYNRwgqbBN3QiPxMbsbtYOoV1Da3mqMhtgE8jPw6eYUXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/18 23:57, Andrii Nakryiko wrote:
> On Thu, Jul 17, 2025 at 12:38 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch adds libbpf support for the BPF_F_CPU flag in percpu_array maps,
>> introducing the following APIs:
>>
>> 1. bpf_map_update_elem_opts(): update with struct bpf_map_update_elem_opts
>> 2. bpf_map_lookup_elem_opts(): lookup with struct bpf_map_lookup_elem_opts
>> 3. bpf_map__update_elem_opts(): high-level wrapper with input validation
>> 4. bpf_map__lookup_elem_opts(): high-level wrapper with input validation
>>
>> Behavior:
>>
>> * If opts->cpu == (u32)~0, the update is applied to all CPUs.
>> * Otherwise, it applies only to the specified CPU.
>> * Lookup APIs retrieve values from the target CPU when BPF_F_CPU is used.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
> 
> please use "libbpf: " prefix, not "bpf,libbpf:"
> 

Ack.

> 
> Then see my comment on flags vs separate field for cpu passing. If we
> go with just using flags, then I'd probably drop all the new libbpf
> APIs, because we already have bpf_map_lookup_elem_flags() and
> bpf_map_update_elem() (the latter accepts flags), so as far as
> low-level API we are good.
> 

All the new libbpf APIs are unnecessary when pass the cpu through flags.

> The comment describing the new BPF_F_CPU flag is good, so let's add
> it, but place it into bpf_map__lookup_elem() description (which, btw,
> also accepts flags, so no changes to API itself is necessary). Same
> for bpf_map__update_elem().
> 

No problem.

> validate_map_op() logic will stay, but just will extract cpu from flags, right?
> 

Yes, it is.

> So overall less API churn, but same possibilities for users (plus we
> get better documentation, which is always nice).
> 

When users want to use this feature, they should follow the libbpf API's
documentation, no matter whether the cpu is separated or flags-embedded.

Thanks,
Leon

>>  tools/lib/bpf/bpf.c           | 23 ++++++++++++++
>>  tools/lib/bpf/bpf.h           | 36 +++++++++++++++++++++-
>>  tools/lib/bpf/libbpf.c        | 56 +++++++++++++++++++++++++++++++----
>>  tools/lib/bpf/libbpf.h        | 53 ++++++++++++++++++++++++++++-----
>>  tools/lib/bpf/libbpf.map      |  5 ++++
>>  tools/lib/bpf/libbpf_common.h | 14 +++++++++
>>  6 files changed, 173 insertions(+), 14 deletions(-)
>>
> 
> [...]


