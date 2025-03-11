Return-Path: <bpf+bounces-53856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD981A5CE29
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 19:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19DC27AC504
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 18:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7467D263F46;
	Tue, 11 Mar 2025 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aeSLI2vE"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65FC263F40
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718687; cv=none; b=X1KH8w48pqv0FqvYg0rOz/RmkbF6exVoFk90SlLK7kK6vgeMuyBursCwzeTE75WlNm49l1Vv47ccUU7Zfu46dXwEM7KlqmtgKoRloCgbOyqLDX4uesKEVxJDiSOzpLtF8DC7bolPg4Bt0QV5jSlo5x2FZEYDK6o0D564wS5LLyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718687; c=relaxed/simple;
	bh=7qeGGRF+Bs5Onbx2FBtdVg+e+PTGen7ZavhW6KRP0Ao=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NRdJZKuzEm7LQ3BNa29GFA8KUJ7f5jInksYGQfYrflTBdIjE+bMrujVZA/H7GpjosHNaMGlMvRjvtbGP4Q0IEafI5kU0hkupNG7LKsfTg4xR6MrfpexCR/5ahM2jlBMlZoJPr8Xm79spTZYYL/2tIDdrQrdQtm+FHHnNSpTkrsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aeSLI2vE; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6aec870-5c13-4d84-bca2-3b77513071b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741718673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUhgHWWJxUiOctQLZQHiTTEWSG04rbmNqKqbpd7zrzs=;
	b=aeSLI2vEbtMvRZQ9zq14qfucPBo4bUgalaKBcXf/WJuCWxoLJPBUzCITyY3PknZZOmV5XL
	rKlaFDmgxJvP/eVnvwUKX3Va+6vbOE5ZB7qZkJfCw0WAGeY8YxberuExY3wIIO3h6+A7I3
	ai+1tNMU2E0Quz7dAvtm4O6X1EWmZH8=
Date: Tue, 11 Mar 2025 11:44:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/6] tcp: add some RTO MIN and DELACK MAX
 {bpf_}set/getsockopt supports
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bot+bpf-ci@kernel.org, kernel-ci@meta.com, andrii@kernel.org,
 daniel@iogearbox.net, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <20250311085437.14703-1-kerneljasonxing@gmail.com>
 <80e745a45391cb8bb60b49978c0a9af5f51bec183f01a7b8f300992a4b14aa6f@mail.kernel.org>
 <CAL+tcoD8TAWT-_mU8wMT3zt-Thh5ZVfmBear5m=G4MbCbBS9XA@mail.gmail.com>
 <5e9fc094-8baf-4b67-b58e-dae5ff9ce350@linux.dev>
Content-Language: en-US
In-Reply-To: <5e9fc094-8baf-4b67-b58e-dae5ff9ce350@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/11/25 11:39 AM, Martin KaFai Lau wrote:
> On 3/11/25 4:07 AM, Jason Xing wrote:
>> On Tue, Mar 11, 2025 at 10:26 AM <bot+bpf-ci@kernel.org> wrote:
>>>
>>> Dear patch submitter,
>>>
>>> CI has tested the following submission:
>>> Status:     FAILURE
>>> Name:       [bpf-next,v2,0/6] tcp: add some RTO MIN and DELACK MAX {bpf_}set/ 
>>> getsockopt supports
>>> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/? 
>>> series=942617&state=*
>>> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/13784214269
>>>
>>> Failed jobs:
>>> test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/ 
>>> runs/13784214269/job/38548852334
>>> test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/ 
>>> actions/runs/13784214269/job/38548853075
>>> test_progs-s390x-gcc: https://github.com/kernel-patches/bpf/actions/ 
>>> runs/13784214269/job/38548829871
>>> test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/ 
>>> runs/13784214269/job/38548830246
>>
>> I see https://netdev.bots.linux.dev/static/nipa/942617/apply/desc that
> 
> It cannot apply, so it applied to bpf-next/net.
> 
> I just confirmed by first checking this:
> https://github.com/kernel-patches/bpf/pulls
> 
> then find your patches and figure out bpf-net_base:
> https://github.com/kernel-patches/bpf/pull/8649
> 
>> says the patch can not be applied. Could it be possible that CI
>> applied it on the wrong branch? I targeted the net branch.
>>
>> I have no clue this series is affecting the following tests
> 
> The test is changing the exact same test setget_sockopt and it failed, so it 
> should be suspicious enough to look at the details of the bpf CI report.
> 
> The report said it failed in aarch64 and s390 but x86 seems to be fine.
> When the test failed, it pretty much failed on all tests. It looks like some of 
> the new set/getsockopt checks failed in these two archs. A blind guess is the 
> jiffies part.

and forgot to mention that you can run bpf CI before posting. This may be easier 
to test other archs. Take a look at Documentation/bpf/bpf_devel_QA.rst. The 
section "How do I run BPF CI on my changes before sending them out for review?"

> 
> 
>> (./test_progs -t setget_sockopt). It seems it has nothing to do with
>> this series. And I'm unable to reproduce it locally.
> 


