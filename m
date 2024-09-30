Return-Path: <bpf+bounces-40591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DE598A9E6
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 18:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8451F21798
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF3B19309C;
	Mon, 30 Sep 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P8oTKHqS"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8819259E
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714118; cv=none; b=T3enE9hPtqdP5Dwq2uDlIlTn2Hk86V9/lPQL2i5Ks/zS8HIpWmEb5OmzUwjr+8EKf/TbAqoqVyCPJ1Bp99WzMXSUK3let6TDJUSmEsjjCmIzXQTN8SAewPcSufUy48MVTvRu3tlLNyCL/VQ+8UdRFDkG2qciySExDlQPiUbR9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714118; c=relaxed/simple;
	bh=WR56oJljbL/VYJ7+iW4zC3clc5fpUcWUiVCLNUn8Jmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crq6D0QsoqiUNkpI5OuE7837rc/M5asaktPl028pfq5bg1LW3q/yLWFsm1qUYDcUlcMyOZRMcOcCTqqdmh9XjIVLxrdPbjIXGw4+Ei34EmtM7HhqShlD6Ii0XBsYOKq0lxheJmVOcohUzmOKBSuA0l7JGSNT10C+6nF4FgdlGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P8oTKHqS; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3fc1e64-69b6-4447-b6ce-037d529ff609@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727714114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ng5icTrswHGtbdrXLpWp/wpfiGHFRzlmRDR5mBBmL/I=;
	b=P8oTKHqSwZC+TU0TZJDuOZ97Km7STXiN7RfeEEN4YMZgTLgxspaZyPuI+dVFDOM2fy/qDW
	TAp9ByrHXTgQPu/KSWIUJznxgWhncXJdCgZ3xaSrP8jZ1yt8UwQYAT7VfU8fy5N6JOSf4z
	W4VExYP7/HtqGO9Q47gKn+e2ndHGCs4=
Date: Mon, 30 Sep 2024 09:35:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 5/5] selftests/bpf: Add private stack tests
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jiri Olsa <olsajiri@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234531.1771024-1-yonghong.song@linux.dev> <ZvqqOTrK_0aLRolW@krava>
 <CAADnVQ+XCqenWJF+d52gtV1ZZgO=80p9jEb43OWgv1QdEUpkrw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+XCqenWJF+d52gtV1ZZgO=80p9jEb43OWgv1QdEUpkrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/30/24 8:05 AM, Alexei Starovoitov wrote:
> On Mon, Sep 30, 2024 at 6:40 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>> On Thu, Sep 26, 2024 at 04:45:31PM -0700, Yonghong Song wrote:
>>> Some private stack tests are added including:
>>>    - prog with stack size greater than BPF_PSTACK_MIN_SUBTREE_SIZE.
>>>    - prog with stack size less than BPF_PSTACK_MIN_SUBTREE_SIZE.
>>>    - prog with one subprog having MAX_BPF_STACK stack size and another
>>>      subprog having non-zero stack size.
>>>    - prog with callback function.
>>>    - prog with exception in main prog or subprog.
>>>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> hi,
>> might be some fail on my side, but I had to include bpf_experimental.h to
>> compile this.. ci seems ok
>>
>>    CLNG-BPF [test_progs-cpuv4] verifier_private_stack.bpf.o
>> progs/verifier_private_stack.c:174:2: error: call to undeclared function 'bpf_throw'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>    174 |         bpf_throw(0);
> Yeah. Let's add bpf_experimental.h for folks like Jiri
> who didn't upgrade their pahole for a long time :)
>
> bpf_throw will be in vmlinux.h ;)

Okay, will do.


