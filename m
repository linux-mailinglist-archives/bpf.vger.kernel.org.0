Return-Path: <bpf+bounces-19046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4E982470B
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 18:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E0B2877F6
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 17:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3452557A;
	Thu,  4 Jan 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EO5SUwWL"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4D25578
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <01e43663-6df6-4563-9b0b-985f6787847f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704388422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKo0jhK8Yl0VZxNvx9Bj3ZRR5MFglBWNDZE0ifEkTlM=;
	b=EO5SUwWL7PtB8QEBhjHfY3QMI95xAAtM4gzLqQ6Nct9aowtqTTyCYq6CXte0IUn3WA8V9d
	vrE3uhi8ngWLmLsYtKAMEH6LHqIqTcdS3/m3dI192XEm3XzXsUC9F44bhW5qmfesSCKtcH
	1pUlPHBc1L+Rj8Wl7zo/ygeRW/A3kWA=
Date: Thu, 4 Jan 2024 09:13:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as imprecise
 spilled registers
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
 <63b227a753c6e6e18acf808d1ac5a77fa922a655.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <63b227a753c6e6e18acf808d1ac5a77fa922a655.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/4/24 8:37 AM, Eduard Zingerman wrote:
> On Wed, 2024-01-03 at 15:26 -0800, Yonghong Song wrote:
>> With patch set [1], precision backtracing supports register spill/fill
>> to/from the stack. The patch [2] allows initial imprecise register spill
>> with content 0. This is a common case for cpuv3 and lower for
>> initializing the stack variables with pattern
>>    r1 = 0
>>    *(u64 *)(r10 - 8) = r1
>> and the [2] has demonstrated good verification improvement.
>>
>> For cpuv4, the initialization could be
>>    *(u64 *)(r10 - 8) = 0
>> The current verifier marks the r10-8 contents with STACK_ZERO.
>> Similar to [2], let us permit the above insn to behave like
>> imprecise register spill which can reduce number of verified states.
>> The change is in function check_stack_write_fixed_off().
> Hi Yonghong,
>
> I agree with this change, but I don't understand under which conditions
> current STACK_ZERO logic is sub-optimal.
> I tried executing test case from patch #2 w/o applying patch #1 and it passes.
> Could you please elaborate / conjure a test case that would fail w/o patch #1?

The logic is similar to
   https://lore.kernel.org/all/20231205184248.1502704-9-andrii@kernel.org/

STACK_ZERO logic is sub-optimal in some cases only w.r.t. the number of
verifier states. So there is no correctness issue.

Patch 2 is added in response to Andrii's request in
   https://lore.kernel.org/all/CAEf4BzaWets3fHUGtctwCNWecR9ASRCO2kFagNy8jJZmPBWYDA@mail.gmail.com/
Since with patch 1 the original STACK_ZERO case is converted to STACK_SPILL,
Patch 2 is added to cover STACK_ZERO case. So with or with patch 1, patch 2
will succeed since it uses STACK_ZERO logic.


>
> Thanks,
> Eduard
>
> [...]

