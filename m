Return-Path: <bpf+bounces-73514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A11EC333F2
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 23:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7F6B4E8B9E
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 22:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7602531329D;
	Tue,  4 Nov 2025 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MVnkouY2"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86A2D0638
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295899; cv=none; b=WLjjkjwe5K4pmupKwEvtHXLXmxwnVQCRTWM+NFeCZsQU5NcMGJ9lEJtgdRXD6MrELffhnewISwKiDqhaR5lccVRetNv/eqBlQoevAyoQkQS3OyiXDwAIgpylunYzd886NrUpMcGMuODBbCbH1J/J0Y/v8y33YBv9UoiGvc92tZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295899; c=relaxed/simple;
	bh=7MF25Q3wGEEdGh4DIpFO74rrmUwNRw+dQhOkjPEMyv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyRjmOXEgr+PRBsyuQKq0lmaZRCvYmtlzFykn99xvHOF6Wc9ThkYR/yrVMoZ0Ewf7ztZT2b9Q6qx4NynVyr950vJL4SKzuuIHGyTnPwHxYJae+/A8ji4jJ7zkcgNGCHpX/FKhzJxAA15DMDezl2qqDgPaMe8/YEJYtfW/KHs4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MVnkouY2; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4f4df9b-839b-4939-a413-f88eba562a9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762295886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QNbliKAyYhVskCt0RxnSd6MsBLzbaJ7Vz7N7Wd9qUk=;
	b=MVnkouY2EKqMrWBWXYOtKdS51DptXK1CWOZrbPw0jMycU1s0No4L0sohkltPPQv2S6QMp4
	qQqUED3GgkpnphkfBsQBc6FVZdhPWtGWASLO1hhEqS/y1ap2ZxWSqHaMO5T9bV2ya9YKcK
	RuGpt5cuqooOuAhTzZyyNLHbTDXtMcE=
Date: Tue, 4 Nov 2025 14:37:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v1 0/3] btf_encoder: support for BPF magic kernel
 functions
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 dwarves@vger.kernel.org, acme@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, tj@kernel.org, kernel-team@meta.com
References: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
 <517837f0-127e-42bc-83f4-2c85203ef468@oracle.com>
 <ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev>
 <0db4e51eed95f9d4616ff5936d335ae71ac2a016.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <0db4e51eed95f9d4616ff5936d335ae71ac2a016.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/4/25 2:33 PM, Eduard Zingerman wrote:
> On Tue, 2025-11-04 at 14:25 -0800, Ihor Solodrai wrote:
>> On 11/4/25 12:59 PM, Alan Maguire wrote:
>>> On 29/10/2025 19:02, Ihor Solodrai wrote:
>>>> This series implements BTF encoding of BPF kernel functions marked
>>>> with KF_MAGIC_ARGS flag in pahole.
>>>>
>>>> The kfunc flag indicates that the arguments of a kfunc with __magic
>>>> suffix are implicitly set by the verifier, and so pahole must emit two
>>>> functions to BTF:
>>>>   * kfunc_impl() with the arguments matching kernel declaration
>>>>   * kfunc() with __magic arguments omitted
>>>>
>>>> For more details see relevant patch series for BPF:
>>>> "bpf: magic kernel functions"
>>>>
>>>> This series is built upon KF_IMPLICIT_PROG_AUX_ARG support [1],
>>>> although the approach changed signifcantly to call it a v2.
>>>>
>>>> [1] https://lore.kernel.org/dwarves/20250924211512.1287298-1-ihor.solodrai@linux.dev/
>>>>
>>>> Ihor Solodrai (3):
>>>>   btf_encoder: refactor btf_encoder__add_func_proto
>>>>   btf_encoder: factor out btf_encoder__add_bpf_kfunc()
>>>>   btf_encoder: support kfuncs with KF_MAGIC_ARGS flag
>>>>
>>>>  btf_encoder.c | 292 ++++++++++++++++++++++++++++++++++++++------------
>>>>  1 file changed, 222 insertions(+), 70 deletions(-)
>>>>
>>>
>>> seems like we could potentially pull in patches 1 and 2 as cleanups
>>> prior to handling the KF_MAGIC/IMPLICIT change; would that be worthwhile?
>>>
>>
>> Hi Alan.
>>
>> Feel free to merge in the refactoring patches if you think they are
>> useful. No objections.
> 
> Hi Alan, Ihor,
> 
> If you thinking about merging patch #1, please consider my comment:
> 
>   > > +static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder, struct btf_encoder_func_state *state)
> 
>   > You can get rid of the `encoder` parameter here.
>   > See https://github.com/acmel/dwarves/commit/080d1f27ae71e30c269a1e26e85bb86c3683f195 .
> 
> I sound a bit like a broken record, sorry.

Oh, thanks for the ping, I missed this comment.

Alan, let me re-spin the refactoring patches separately.

> 
> [...]


