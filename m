Return-Path: <bpf+bounces-69444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9837AB96A8C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4373A4849D9
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8EF2638BC;
	Tue, 23 Sep 2025 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+jpx7Qe"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4225CC74
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642657; cv=none; b=PcRlNMaqSqojGYUCEtwtcNDu+5/KqhznNhzlEqRAfJDyuvIphM86ZyJtqHmFOoA6E6jXlxgctNMoXqlwv3FR/2BpESuQVxeJnlgtDKZzH63Iqof66viLICfBblEWe8z1dDSDWQ/MxUhTwE4c8dzuXqRBSyCscSWae7USceD5Bb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642657; c=relaxed/simple;
	bh=cNyaxbwcmBd6LcfYKm37piNrlp8cYPFscsp4t7oBp+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7K5Ynci4t50n7Dwfqa7jL/l1Ev9TPCgqgVYb0ALzvhTmhIAljf0g98/qUhCoYUN0AJRAeXtVn30nM/JsbItGgCR+vxDUn1VMcRbsfCRGspTOrjcL/G1aNzK8sIfXWkS1y91HrLFYenzPd6Yn/pEKqL0oDkbemGfPCQLlAJjS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+jpx7Qe; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b16183df-2915-4369-a0ae-ea484924ad79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758642653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNyaxbwcmBd6LcfYKm37piNrlp8cYPFscsp4t7oBp+A=;
	b=A+jpx7QeZ4zqP3c+TKdtQjYPK4VLsrK8JM5AJ+12jNd+ZWgeDGsRqDHFiO8S6Pf8k6tfaQ
	lHhsqk5aXdvlkLrX0xNHvwsH8gKCRpgvRGh3/4ryfGY5U/G/9g+/1JfJWgm1KeAIsvnKYf
	+DGEfpSUZD/GveYfJ6sUspMEJVlCPAU=
Date: Tue, 23 Sep 2025 23:50:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 3/6] bpf: Add common attr support for
 prog_load and btf_load
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, menglong8.dong@gmail.com
References: <20250911163328.93490-1-leon.hwang@linux.dev>
 <20250911163328.93490-4-leon.hwang@linux.dev>
 <CAEf4BzaRYeT4wzU7uCuYLF-7THnXL2KgbF3kkg-8fLE3phM-5w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzaRYeT4wzU7uCuYLF-7THnXL2KgbF3kkg-8fLE3phM-5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/18 05:12, Andrii Nakryiko wrote:
> On Thu, Sep 11, 2025 at 9:33 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> The log buffer of common attributes would be confusing with the one in
>> 'union bpf_attr' for BPF_PROG_LOAD and BPF_BTF_LOAD.
>>
>> In order to clarify the usage of these two 'log_buf's, they both can be
>> used for logging if:
>>
>> * They are same, including 'log_buf', 'log_level' and 'log_size'.
>> * One of them is missing, then another one will be used for logging.
>>
>
> I agree with the logic above, but I'm not sure whether we need to
> plumb common_attrs all the way into bpf_vlog_init, tbh. There are only
> two commands that can have log specified through both bpf_attr and
> bpf_common_attrs. I'd have those two commands check and resolve the
> log buffer pointer, size and flags on their own (sure, a bit of
> duplicated logic, but we won't have any new command having to do that,
> so that's fine in my book).
>
> And then I'd keep bpf_vlog_init completely unaware of common_attrs
> (which eventually have more stuff in it that's irrelevant to logging).
>

To avoid modifying bpf_vlog_init directly, one option would be to
introduce a new helper, e.g. bpf_vlog_init2 or
bpf_vlog_init_with_cattrs, to handle the case with common_attrs.

This way, bpf_vlog_init_with_cattrs could be used for BPF_PROG_LOAD and
BPF_BTF_LOAD, while the existing bpf_vlog_init remains unchanged and
could be used for BPF_MAP_CREATE.

That would avoid duplicating the log handling logic, while also keeping
the separation between the two cases clear.

> This seems cleaner than plumbing this through so deeply.
>
>> If they both have 'log_buf' but they are not same, a log message will be
>> written to the log buffer of 'union bpf_attr'.
>>
>
> Meh, whatever, this is unlikely user error, just error out with
> -EINVAL or something. Let's not invent "log here, but not here" logic.
>

In that case, we can return -EUSERS, as Alexei suggested earlier.

Thanks,
Leon

