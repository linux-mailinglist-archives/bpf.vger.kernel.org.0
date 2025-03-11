Return-Path: <bpf+bounces-53855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0978A5CE03
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 19:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED339179302
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679F0263C7F;
	Tue, 11 Mar 2025 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="woDyER38"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7625D208
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718409; cv=none; b=WagHKLuGeq4Ibv2zwjQ0Az8LxRlX7FCYGDm1IdSD3vkVnhmEd/KVWaw1xo0JY+7wk2xm01gCC4TidJxJs3tvSsU6oB1k2fnvKqTtvxRe6KDjMfk18X9K78K8/PgkwAE3KKnHVclFDjZiLMWGguNmnym81fiftHZ7pepNZaDf+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718409; c=relaxed/simple;
	bh=9xG9QTQtQBmQNV6osS3BrPTWwfFv3/a2c7igUB5Sf1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frF0LMnS95oJH0Hti2R8uXA+LTa1GHKiokqHe1ryocmt/Uk1h6O3Ye7C4+NHX0WKAt6YWuhHHCqwh+XrLsJk7z51bIc4KMrzrr1ijVY85tuitv3Fk1zoixauqjHTFK5wH3hWtYV3tBs15Qf9XOqaeVa7yyLjjuG+cD3WPJn8d+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=woDyER38; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5e9fc094-8baf-4b67-b58e-dae5ff9ce350@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741718403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2wN/fiHfypcf4PZ+bKJhIj9eRvIZOyOB7F1A6T/pwo=;
	b=woDyER383WptjcGRxnEO1LItHudHvpUHuMzzw8MMmbK1FQa9bAn5kx4ARjZPEcbF1+HK+v
	Bcf9xfVZdgLrXSE9BHLSA+kjuhlaHvfKbCzd1c07mobdPCcx1l3MRAlATAz58z4hOpzz+l
	vlJvqeoxPhOiZTtZrmleiiT2SIO6lCA=
Date: Tue, 11 Mar 2025 11:39:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/6] tcp: add some RTO MIN and DELACK MAX
 {bpf_}set/getsockopt supports
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bot+bpf-ci@kernel.org, kernel-ci@meta.com, andrii@kernel.org,
 daniel@iogearbox.net, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <20250311085437.14703-1-kerneljasonxing@gmail.com>
 <80e745a45391cb8bb60b49978c0a9af5f51bec183f01a7b8f300992a4b14aa6f@mail.kernel.org>
 <CAL+tcoD8TAWT-_mU8wMT3zt-Thh5ZVfmBear5m=G4MbCbBS9XA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoD8TAWT-_mU8wMT3zt-Thh5ZVfmBear5m=G4MbCbBS9XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/11/25 4:07 AM, Jason Xing wrote:
> On Tue, Mar 11, 2025 at 10:26 AM <bot+bpf-ci@kernel.org> wrote:
>>
>> Dear patch submitter,
>>
>> CI has tested the following submission:
>> Status:     FAILURE
>> Name:       [bpf-next,v2,0/6] tcp: add some RTO MIN and DELACK MAX {bpf_}set/getsockopt supports
>> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=942617&state=*
>> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/13784214269
>>
>> Failed jobs:
>> test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/13784214269/job/38548852334
>> test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/13784214269/job/38548853075
>> test_progs-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/13784214269/job/38548829871
>> test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/13784214269/job/38548830246
> 
> I see https://netdev.bots.linux.dev/static/nipa/942617/apply/desc that

It cannot apply, so it applied to bpf-next/net.

I just confirmed by first checking this:
https://github.com/kernel-patches/bpf/pulls

then find your patches and figure out bpf-net_base:
https://github.com/kernel-patches/bpf/pull/8649

> says the patch can not be applied. Could it be possible that CI
> applied it on the wrong branch? I targeted the net branch.
> 
> I have no clue this series is affecting the following tests

The test is changing the exact same test setget_sockopt and it failed, so it 
should be suspicious enough to look at the details of the bpf CI report.

The report said it failed in aarch64 and s390 but x86 seems to be fine.
When the test failed, it pretty much failed on all tests. It looks like some of 
the new set/getsockopt checks failed in these two archs. A blind guess is the 
jiffies part.


> (./test_progs -t setget_sockopt). It seems it has nothing to do with
> this series. And I'm unable to reproduce it locally.

