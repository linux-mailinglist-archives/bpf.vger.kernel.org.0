Return-Path: <bpf+bounces-63298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC1DB05138
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 07:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5E27A779A
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 05:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1AB2D238B;
	Tue, 15 Jul 2025 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ea1jjHx7"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C04501A
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558587; cv=none; b=PKPIE0juNp9FjhkEda8vbsGX+ZfzgqOqdjjcQN27IZ9mtt0ctXMdLDk3pN/y9ZDSyuWKiWFGWL28EfjlMv44U4z5Ztqtc9dgiS5CyOvgbJzOU5wNz2VxUDgMqEZ7OapcFbjx98G2521Pe7ApFIkxe1brk/DxGXFlw84emeBSr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558587; c=relaxed/simple;
	bh=LIeyK/2QM2YrkwMZzmOBymmg/tpyPgZFMjUEk6TblII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYS9XEkGB5VT+aBx+1mYiUCYwKzPxaQOXRePEGb34xntam6Eq53kml/Ra6SzKSQbUVNe2S7AoFd75ANBwMjiLIOezYWykGwPYdXaxPnaKcL7R5ht/5d8Qz1R1HGyrnFama5O8lT2fo7xPSdrPmVbtwy35SbjYQXhRnfx7OKsV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ea1jjHx7; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <21970a1e-dcda-4c23-af84-553419007a38@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752558582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCUpv2SK5CMGdJCQSvTooC7yLADWxi2e3sIA550QsOQ=;
	b=ea1jjHx7uUXost6kJd6a+23CzlToM5nrApGHzh/FsKNBgxvARbj6Y5FQmInJBEm7cHFOmn
	3za9HMfSTgRCln650pPwm65YM4XDH1aM4joAKHztTEJbkEtTHUJHwTo6hAHYwACp0iurfJ
	rdGldEgAFXtBCr3u6a26Il63t0c7GeM=
Date: Tue, 15 Jul 2025 13:48:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 15/18] libbpf: add skip_invalid and
 attach_tracing for tracing_multi
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, jolsa@kernel.org,
 bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kernel@vger.kernel.org
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-16-dongml2@chinatelecom.cn>
 <CAEf4BzZb793wAXROPNcE_EggfU1U3g80jdDsvP5sr86uDBhgmA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <CAEf4BzZb793wAXROPNcE_EggfU1U3g80jdDsvP5sr86uDBhgmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/15/25 06:07, Andrii Nakryiko wrote:
> On Thu, Jul 3, 2025 at 5:23 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>> We add skip_invalid and attach_tracing for tracing_multi for the
>> selftests.
>>
>> When we try to attach all the functions in available_filter_functions with
>> tracing_multi, we can't tell if the target symbol can be attached
>> successfully, and the attaching will fail. When skip_invalid is set to
>> true, we will check if it can be attached in libbpf, and skip the invalid
>> entries.
>>
>> We will skip the symbols in the following cases:
>>
>> 1. the btf type not exist
>> 2. the btf type is not a function proto
>> 3. the function args count more that 6
>> 4. the return type is struct or union
>> 5. any function args is struct or union
>>
>> The 5th rule can be a manslaughter, but it's ok for the testings.
>>
>> "attach_tracing" is used to convert a TRACING prog to TRACING_MULTI. For
>> example, we can set the attach type to FENTRY_MULTI before we load the
>> skel. And we can attach the prog with
>> bpf_program__attach_trace_multi_opts() with "attach_tracing=1". The libbpf
>> will attach the target btf type of the prog automatically. This is also
>> used to reuse the selftests of tracing.
>>
>> (Oh my goodness! What am I doing?)
> exactly...
>
> Let's think if we need any of that, as in: take a step back, and try
> to explain why you think any of this should be part of libbpf's UAPI.

I know it's weird. The "attach_tracing" is used for selftests, which I can
use something else instead. But the "skip_invalid" is something that we
need.

For example, we have a function list, which contains 1000 kernel functions,
and we want to attach fentry-multi to them. However, we don't know which
of them can't be attached, so the attachment will fail. And we need a way to
skip the functions that can't be attached to make the attachment success.

This should be a common use case. And let me do more research to see if
we can do such filter out of the libbpf.

Thanks!
Menglong Dong


>
>> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>> ---
>>   tools/lib/bpf/libbpf.c | 97 ++++++++++++++++++++++++++++++++++++------
>>   tools/lib/bpf/libbpf.h |  6 ++-
>>   2 files changed, 89 insertions(+), 14 deletions(-)
>>
> [...]
>

