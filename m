Return-Path: <bpf+bounces-19411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B929182BADD
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 06:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7361C24B2D
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 05:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A85B5CC;
	Fri, 12 Jan 2024 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZUhi6ZZy"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2105B5B1
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2c6fb29f-0256-4dec-a7d4-ce7bc24f091b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705037348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olJJoh74YNDnVyYlYpi6LYwF5U07AYoZ87hKzuLvNMw=;
	b=ZUhi6ZZyoafizIicETikY6nSLIMi3XTPsj/piIVLCQ1u6WZOv0GwLdUwJo5HH+PaN0jpyR
	m6yzfdF588T/GR1Pa67l91P5MZKNi4WBREIEWoeiR1crKLtYK4pTTg6oasBcOoepPzkI8Q
	i+E3UzocCBwKhy8zaV71ZHz8qAI49YA=
Date: Thu, 11 Jan 2024 21:29:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Fix a 'unused function' compilation error
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240112041649.2891872-1-yonghong.song@linux.dev>
 <CAADnVQLH66gFbyqekSEbpzc+CRYkbMxcCAtBvMcCJo+8tfauqg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLH66gFbyqekSEbpzc+CRYkbMxcCAtBvMcCJo+8tfauqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/11/24 8:59 PM, Alexei Starovoitov wrote:
> On Thu, Jan 11, 2024 at 8:17 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Building the kernel with latest llvm18, I hit the following error:
>>
>>   /home/yhs/work/bpf-next/kernel/bpf/verifier.c:4383:13: error: unused function '__is_scalar_unbounded' [-Werror,-Wunused-function]
>>    4383 | static bool __is_scalar_unbounded(struct bpf_reg_state *reg)
>>         |             ^~~~~~~~~~~~~~~~~~~~~
>>   1 error generated.
>>
>> Patches [1] and [2] are in the same patch set. Patch [1] removed
>> the usage of __is_scalar_unbounded(), and patch [2] re-introduced
>> the usage of the function. Currently patch [1] is merged into
>> bpf-next while patch [2] does not, hence the above compilation
>> error is triggered.
>>
>> To fix the compilation failure, let us temporarily make
>> __is_scalar_unbounded() not accessible through macro '#if 0'.
>> It can be re-introduced later when [2] is ready to merge.
>>
>>    [1] https://lore.kernel.org/bpf/20240108205209.838365-11-maxtram95@gmail.com/
>>    [2] https://lore.kernel.org/bpf/20240108205209.838365-15-maxtram95@gmail.com/
> Ouch. Sorry. This interaction between patches was unexpected.
> Instead of this particular if 0 patch, is there a way to amend pushed
> patches to avoid this issue?

Another option is that in merged patch [1] removing the function __is_scalar_unbounded().
And the function can be re-introduced later if needed.


