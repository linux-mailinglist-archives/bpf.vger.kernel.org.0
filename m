Return-Path: <bpf+bounces-71575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34208BF6EA5
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15D919A0D42
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9CC2877C3;
	Tue, 21 Oct 2025 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGRpbJSr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2233370EB
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054934; cv=none; b=XBozfs3emw1zz+JklI8gAipKyHWuwkKC5S+VXx8dfb0pYQlV4uBQblkTpHo4q7M7Bik3MV6Y9bobQ5YjSEB7doeYFABz3YrMiRZbqMey7Z7sQzue3DJaI7sbxXoq61FgGw3i5p9aDGIBA6yBmS0N6Wd4kGOP4HlUh89zdH1qAUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054934; c=relaxed/simple;
	bh=1C/CMYRxtvqwNM2YoYyDr1kpKiDWJNGal0fWYgTIgG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c98r6Ch2CsvbaqVcD01p+w7/XFeCaImlERBbkCVk/PtPDaAGkNu5+tWLA4clN6Uhtk4qTcHu+b4CekNBMdzL65gVc3YIm3rIjqb+RgP0JjP4OXC+aoygHxaYIyjOoK/j9Ww/qmf2mcArKKXH7GCgP4DWezPWCruQTjc1qtN7TTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGRpbJSr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so31421695e9.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761054930; x=1761659730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcLLZtq1uNDjJQb+3BVYFHiRfsHBP2vHeAmDZ4VpLlE=;
        b=YGRpbJSrK6e2K4VXAoQiBJv6HJl8CmnRESn1AZDarwO6UOGeZx/dfIcr9f2LmAYkGT
         FtphffGZpoYWpF7UzyDKDVX7FMvm+knZq6tIVVXc7hgidcJ/2m9neUDCPq+VsirvEsGp
         FPGUF+NJ/niw/nWgNHbhU8IxBG96g2uc6vnsHncg+jGO5+bgDx/igM84uFfCgxP8gw/l
         3CEqrXjYecjNtpLfkd4ryexmpkIP75eFkHEeLeF1tvUuFP4oeDgMd1eTkHAVPfzhwi6Z
         2uIKeTU+7a8th3lqcjVuD+AUhoPF8pILD94SHqs835qOtcCUEAqBcjHmejnPAFaeCCQj
         /pIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054930; x=1761659730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcLLZtq1uNDjJQb+3BVYFHiRfsHBP2vHeAmDZ4VpLlE=;
        b=OeDIHxaD/b2miL2QN7pnQAIeTudgTF+tQSZmHHydNsfrfmJOksHi42ZcJ2LXS5h1nv
         kSL+/I7ZSAE53m+Fq+LYBX8wDBFPCK3VAN5i3blrj62o+BZ6WPIu2vASEOz1D+ni/tHX
         m9/v3gD1s6trIPiHdsOOZrS3WYQ2HWQf8mdPkJBB+iQWVlznpjBy7Xr913FGJPqYovxX
         abcX//J+By+r8uTBFcT89YbPStEpMMI9MkgjphZ09tx2r90k/3lD9qILPvwJcV1+2FIu
         Dnl42M0l78H0m+CmAXcyntuNKPqzkQpqO/yW9Vyee1CdGz+YkMUXCL1/+3mwRb5cDJ9X
         EntA==
X-Forwarded-Encrypted: i=1; AJvYcCXczEWDmhrW5oPSyfrYt/Z1q7X7H9ZlIW4Z9MPl1H3cy/IWW1QL/Ht/zqHno+hgwlnKX6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZ+lyc3/FVbLxswmgfcPCvg+10AEzqmVuBLUzFPis217Sv14Z
	5ZAAVBIMRrmUilTeapNXIpPDWoVkPdST6byCNObb3L3rPvC56+k9cEcX
X-Gm-Gg: ASbGnctvx/UIUp554B7liNJMn7Ne4OAiyGPMFG/ITeeXxqJV6MElP56Aj7XdlqyWkCM
	HJzav1I4K/ohzVxD8FSrk1e3i+grKkr25z9fratjmanVK3YJ7I5+WoEifj+3+H14/2iHwa2qbRA
	gfg3+1bT43rzuYjJaURVNClTtw0L7iq1VKhJ4nwJXXxq/OUxoBj2fYXelojVp1u+WoweFCYawpm
	q8nSH3S0VHSVVzSuH4lbZFt7v4JMB1JKW2h/DfLB2HYgpmtsAY8qaWS1VqhVRPcnK1m5C+/05qm
	t0Q2CIxYe5XCWZ8eT9yMRBQX8omE9uCufP3X8wdvPF7tBDrbiToZa1wvE6KZu4Cf0j6KvHsQp+D
	o7PpmcWe9shIWXwxD2PYOE4Ehc2Xs8Fbyv5WyWyCB1p0OkHdsvS5t5DtlolTSm0UR+HPre+GqTl
	yRnTUG46aH/3k71hQGktlYpRg2IdOiuSXQ8lyojI0IRnSEBqQGwmw=
X-Google-Smtp-Source: AGHT+IFoOH6YPlVUTrrQJbntYq1SM45e7oGzQUWkQ++v0lQDkRyrdEzBL1I4aC3jKFvU+bflzqrptg==
X-Received: by 2002:a05:600c:470d:b0:45f:2cd5:5086 with SMTP id 5b1f17b1804b1-4711786d5a3mr121625135e9.3.1761054929728;
        Tue, 21 Oct 2025 06:55:29 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:4c57:4e9:b55b:f327? ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5bbc50sm20764482f8f.21.2025.10.21.06.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:55:29 -0700 (PDT)
Message-ID: <b682bacf-8b61-42b2-9f4c-d617f9f56d17@gmail.com>
Date: Tue, 21 Oct 2025 14:55:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 10/10] selftests/bpf: add file dynptr tests
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
 <20251020222538.932915-11-mykyta.yatsenko5@gmail.com>
 <006a3fe8ca7072ac35e083ee070408d9a12eadfc.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <006a3fe8ca7072ac35e083ee070408d9a12eadfc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 01:45, Eduard Zingerman wrote:
> On Mon, 2025-10-20 at 23:25 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Introducing selftests for validating file-backed dynptr works as
>> expected.
>>   * validate implementation supports dynptr slice and read operations
>>   * validate destructors should be paired with initializers
>>   * validate sleepable progs can page in.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
>> new file mode 100644
>> index 000000000000..695ef6392771
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/file_reader.c
>> @@ -0,0 +1,178 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <vmlinux.h>
>> +#include <string.h>
>> +#include <stdbool.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "bpf_misc.h"
>> +#include "errno.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARRAY);
>> +	__uint(max_entries, 1);
>> +	__type(key, int);
>> +	__type(value, struct elem);
>> +} arrmap SEC(".maps");
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_RINGBUF);
>> +	__uint(max_entries, 10000000);
>> +} ringbuf SEC(".maps");
> The test case lgtm, but a question: will it be possible to use an
> array map instead of a ringbuf?  Just to avoid the need to allocate
> and discard the pointer.
How do I use array map here? Should I set a map value to be a buffer of
needed length (256KB) or use 1 byte value and 256K elements in the map?
Honestly, both options seem a little awkward to me, but I'm not sure 
maybe it is an
expected way to get a big buffer.
I like allocation/discard, as it guarantees that this temporary buffer 
is local to the
current func execution and we need to run non-trivial deinitialization 
anyway.
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
>> new file mode 100644
>> index 000000000000..32fe28ed2439
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
> Thank you for adding these.
>
> [...]


