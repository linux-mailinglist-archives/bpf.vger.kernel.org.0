Return-Path: <bpf+bounces-63272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC04B04B11
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 00:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5A74A5A8A
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 22:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70B0277CB3;
	Mon, 14 Jul 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c0uetxNg"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36622083
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533491; cv=none; b=YKEH15nmfLNBMngsu05klj9U9oy+agkCmo8ydnW4B+0G3YRoUbB0MLvoCs2v5AXPwytJyMH1ZIX/nLJRB4NoX4dYB7el7JleE9A8lNP1hDedRBxaxWqGGVhkKDKWfFffYvkD67g3hQD7+TBqFMRWtrHgR8oeNRc+VzQAmufi4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533491; c=relaxed/simple;
	bh=qGEGGsLEkfCd2TcIxz7+VuvOfdgrAfBQKt0q4ngZHg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wm6bUmDIFWKGFNJNeLHKtJncns5mQps73qP+r+cjXQAseMCkoM+AHjHiGPRfgGy56Iftht724m1kT0u83lIo5lk1c1y6vmnxUn+0Atvq9QnvbuXqfafY7YqIeNyEAorE+oDLzTSVQ32fPQ9owTSkZKW0pcvTuqo+WkmXkJZzqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c0uetxNg; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2fe9d096-846c-4cb6-ac7e-a9e072cb3281@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752533486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUs7rSl9OOabs5zzmuV58HHyP49Xlu4Muu7/qo2/NcA=;
	b=c0uetxNgQLzyjiFZBsX4MJUCl9BohZuUDyeEtfEafRG0rtJBtuPPz96S2kIYnGXLAXcgWh
	fm+iBbYMWo49MPtFYe/mqUAI/Q/8ig3rSH9UnXHfj+XsQw1NtLpo6MwuNrYIMvnEXjcGHm
	b4K9WOaKpgOxZfag+qLT6UaddvK6sGQ=
Date: Mon, 14 Jul 2025 15:51:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v1 2/4] bpf: Support cookie for linked-based
 struct_ops attachment
To: Amery Hung <ameryhung@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Tejun Heo <tj@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
 Kernel Team <kernel-team@meta.com>, bpf <bpf@vger.kernel.org>
References: <20250708230825.4159486-1-ameryhung@gmail.com>
 <20250708230825.4159486-3-ameryhung@gmail.com>
 <68f4b77c-3265-489e-9190-0333ed54b697@linux.dev>
 <CAMB2axO3Ma7jYa00fbSzB8ZFZyekS13BNJ87rsTfbfcSZhpc6w@mail.gmail.com>
 <2d1b45f3-3bde-415d-8568-eb4c2a7dd219@linux.dev>
 <CAMB2axMDUr+s+f9K-4sj-5vSkPQV4RXHo8y73VH9V2JQbKZOxQ@mail.gmail.com>
 <CAEf4BzaUK0i7QFkKi800TQhAKw2WL+FyoG3eFP6nq_r-TUPBKw@mail.gmail.com>
 <CAMB2axONnVJ5BY-YOASWGUGpaZa-P64Yf5f6AbX+O8fjCiZNfw@mail.gmail.com>
 <CAADnVQJxu5hsDw0iCP68eRW3v2CXRBos8asfN1x9F=gVyGmqbw@mail.gmail.com>
 <CAMB2axMw0uEojfdq33KbjqZXAtRSJwR2=f1Y1S4ma01sWJFNfg@mail.gmail.com>
 <CAEf4BzaoUCapHxdVJj6vyx=Ai_tCO+HY3kaD2ZNK2v0R0zuTMw@mail.gmail.com>
 <CAMB2axNXLm2mWnSv4EL_YxexYa97_OnRD9Nj7ww9Qq_3dAp5hg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axNXLm2mWnSv4EL_YxexYa97_OnRD9Nj7ww9Qq_3dAp5hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/14/25 2:02 PM, Amery Hung wrote:
>>> It should work. Currently, it makes sense to have cookie in struct_ops
>>> map as all struct_ops implementers (hid, tcp cc, qdisc, sched_ext) do
>>> not allow multi-attachment of the same map. A struct_ops map is
>>> effectively an unique attachment for now.
>>
>> Is there any conceptual reason why struct_ops map shouldn't be allowed
>> to be attached to multiple places? If not, should we try to lift this
>> restriction and not invent struct_ops-specific BPF cookie APIs?

bpf_struct_ops map currently does allow attaching multiple times through the 
link interface. It is up to the subsystem tcp-cc/hid/qdisc/scx how to handle it.

> I am fixing the patchset by moving trampoline and ksyms to
> bpf_struct_ops_link. It shouldn't complicate struct_ops code too much
> (finger cross).

seems reasonable. I think it will be useful to have comments in v2 on how their 
lifecycle will be handled.

