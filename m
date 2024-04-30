Return-Path: <bpf+bounces-28272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9C8B7AE8
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 17:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6421C23803
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 15:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C23176FA3;
	Tue, 30 Apr 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b="pgu64Dxq"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800F175571
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489274; cv=none; b=gfu3QPU+SdNkB6U+dW8KEb5XxSzHiB3cqnwRuqSrw6qvbobewn8FF1LBIS7PYHYgJM9ldCKCoAq5xcHiVvSVbNhkfTylr8LK8UOXAfrckvpZWhntNbbpYVYGKCZjM7tpw012GxObpBjiKwtSlDmJBUI5K1fEcUreP7O6Uss0BwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489274; c=relaxed/simple;
	bh=trfn3WzaC7I2p/93AaPZ1QBie8ikuIBn0LHmOuc+PiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhrU16sPeTEf+S7uJJ15sgee0cKek9KSAnszNBt7kwppwJsMSwCdav1+j5vereGXt5W4oVS0rdygFNXnestVxljivGNZm+nO8g/0Sf1fb1KrlWwn/SAHs8QAkstwMSndfP3ATSOzgJEZdTCVaQuyT4IGUVhKDMzxxU2EO1L8G3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org; spf=pass smtp.mailfrom=vahedi.org; dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b=pgu64Dxq; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vahedi.org
Message-ID: <e9227088-f14a-4357-b0f1-b85a8403fa37@vahedi.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vahedi.org; s=key1;
	t=1714489270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtqyUjdRXozzH7nyko5UQ3YSlUhCAxwbk5121nS0yvk=;
	b=pgu64DxqY9MRs/eqLmRps/FEGjwkw9iB04s3QaDl/VHBLXQ7siv+QLgCu07P+PliLU1D1W
	wy+cFfxIDX7uTWmfxnz1jHHQkSvEzcAXItPx83wQL2lrZVVo+1G8KBvuWkYiY9k8pGyZfO
	4CbSOi4NrpEzy/ka50mqGPuk71jKM+ofkg0aq480Gf5BPEro2t1ZkIMl9VBglGIrSdQ6Sa
	Nfedmqzy7oKq/vW649bKfXX00/RqzsjBdrUNDjLGWWL4pnMYXSRiJ6FbSXofa9Vs1BatcA
	sfU3lZ/VKVf3W/OwiHc1WD2I3e/7qwEuib1Y50QFdtbVkBnrcSpoTzGIBJATsQ==
Date: Tue, 30 Apr 2024 17:01:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] ARC: Add eBPF JIT support
To: Shahab Vahedi <list+bpf@vahedi.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: bpf@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 Vineet Gupta <vgupta@kernel.org>
References: <20240213131946.32068-1-list+bpf@vahedi.org>
 <87ttlnqlmv.fsf@all.your.base.are.belong.to.us>
 <6e4cf7cc-6a2e-4396-b0d5-01ff10d6923a@vahedi.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shahab Vahedi <list+bpf@vahedi.org>
In-Reply-To: <6e4cf7cc-6a2e-4396-b0d5-01ff10d6923a@vahedi.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Shahab Vahedi writes:
> 
> Björn Töpel <bjorn@kernel.org> writes:
>>
>> Please try to avoid static inline in the C-files. The compiler usually
>> knows better.
> 
> I will replace them with "static" then.

I have tried [1] this and the test execution time took a performance hit of
35%. Therefore, I have not included it in the rework [2].


Cheers,
Shahab

[1] GCC configuration used for building the Linux image
"GCC 12.2.1 20230306" with 3 different optimisations: "-O{2,3,g}"

[2] [PATCH bpf-next v2] ARC: Add eBPF JIT support
https://lore.kernel.org/bpf/20240430145604.38592-1-list+bpf@vahedi.org/

