Return-Path: <bpf+bounces-34595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875BC92F06C
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 22:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486AF2835EC
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 20:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5647519EEB7;
	Thu, 11 Jul 2024 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="LALj4Hv1"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA171B51;
	Thu, 11 Jul 2024 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730181; cv=none; b=b3XcGM2f2dcFOeN17IH++4vo7bVM8IPNAesi0hqmmrwu1qIoYpmRsCEB4zDoarvIeTUrWvpyco/mKdLBI0epKcviulV2Wt28T/MB0pJ4jCIqj4PYQ3NvUWhha8mTd9RQAVcNhVavYgtSbmkfsqTel+ZOC0Kkbl03aOdF/Hmsgwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730181; c=relaxed/simple;
	bh=DxYtzJNa0Vh9cYgQrJR+0cbJ+C9lIGfdZkLuHzygzVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWZoGXACJyLu0C/trf6LZZJIj3Ttme/ivXiL4EywcaLGdppi7CWswrG4FhGwQPwteJ4VsSYnbbxNP3L/4B4UFylCFQdRXOsqcUHut+lbtFyMg0AJedwgH7nrhGk8hvd3uOy2xWb2s7C7qWfnlhNc9ivBqABxawXbI5GO0RtQAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=LALj4Hv1; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sS0WW-007wCr-4l; Thu, 11 Jul 2024 22:36:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=7caZyj7OhOb5yW9FtafaXqMJoVVT/luE6lCAvdfivpg=; b=LALj4Hv1VcrIHJorno/NaOVkst
	QtxYgplrKlKxOjujZyaIBOwt0YpeXuYJ0MzLNUwtP+SHdIoybbFVlww2YBJCIT0iJbNd3KRIOy7HV
	ehBjdsLUjFcBGG2tbJRGR4eRgY9edE2IMNtdV5QbpH5xzu7o+JLeeCtTqTaBabVjWn771ORTLYQLS
	uScxbVoOb0lF7UQeUiejVhca+/MJWbnt1WbEjihRWqGJf/bAUfmRRFlSiQXdoluiLVpzlo57O2TzA
	BbHKgka5hhaBgHQYyVAlEUwpkgHgee6kaP8zdSxc9cRIJMN1MpTuWFoj1Yai47LRdLNSCjjBwBY/I
	w5iNvxsw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sS0WP-0000YV-Tb; Thu, 11 Jul 2024 22:36:10 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sS0W6-002DDM-9W; Thu, 11 Jul 2024 22:35:50 +0200
Message-ID: <c8e083de-0084-4f88-8ee6-f2d4eaab6c8b@rbox.co>
Date: Thu, 11 Jul 2024 22:35:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 4/4] selftest/bpf: Test sockmap redirect for
 AF_UNIX MSG_OOB
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com
References: <20240707222842.4119416-1-mhal@rbox.co>
 <20240707222842.4119416-5-mhal@rbox.co> <87r0c2nai8.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87r0c2nai8.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/24 12:08, Jakub Sitnicki wrote:
> On Sun, Jul 07, 2024 at 11:28 PM +02, Michal Luczaj wrote:
>> Verify that out-of-band packets are silently dropped before they reach the
>> redirection logic. Attempt to recv() stale data that might have been
>> erroneously left reachable from the original socket.
>>
>> The idea is to test with a 2 byte long send(). Should a MSG_OOB flag be in
>> use, only the last byte will be treated as out-of-band. Test fails if
>> verd_mapfd indicates a wrong number of packets processed (e.g. if OOB data
>> wasn't dropped at the source) or if it was still somehow possble to recv()
> 
> Nit: typo s/possble/possible
> 
> Something like below will catch these for you:
> 
> $ cat ~/src/linux/.git/hooks/post-commit
> exec git show --format=email HEAD | ./scripts/checkpatch.pl --strict --codespell

Heh, I have it. Just not in the right repo :) Will fix.

> This AF_UNIX MSG_OOB use case is super exotic, IMO. TBH, I've just
> learned about it. Hence, I think we could use some more comments for the
> future readers.
> 
> Also, it seems like we only need to remove peer1 from sockmap to test
> the behavior. If so, I'd stick to just what is needed to set up the
> test. Extra stuff makes you wonder what was the authors intention.
> 
> I'd also be more direct about checking return value & error. These
> selftests often serve as the only example / API documentation out there.

Yeah, all fair points. Thanks.

