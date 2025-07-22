Return-Path: <bpf+bounces-64119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D6BB0E66B
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF31AC17D8
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EB22882CE;
	Tue, 22 Jul 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i2CbnfTC"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102076025
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753223337; cv=none; b=DGaY/mfZ1VMajv77+57fQ0X2L+P1SRFU9aHERWp1Kj8lAY1FRq6psd6Y+s/I4NHvJ1o4MHTgfzpFkDycioI2SUZhuO4XE47dgFJThNgx1ePKgc+0gyx1seIkrx6EWK6IHA2TadISLakH4EMIpDZhrvNLfN3MaTJXIMWhCMv6sHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753223337; c=relaxed/simple;
	bh=hix1rMRswxjQXNwO5+nPFqIa6Q4dcNSzZSjeZJnOEo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPs8BvDs6iIu9aPEXcXl9wbQi8nbYmNB9u1fDU0//Bf6TKgSDfkIdowWdKFabjv8+TxXFY49QjM0zQIkIp+jTX5LE2yZ1PXs4OGgJVxfgNWEpGdsvslMzk+Bh2Nm4x2g01X1OwinpakUZ7I4tonI+CVbAcwyIoeVgBxUjIufMoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i2CbnfTC; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0e81620a-a03f-4a95-9f7d-45ca63813368@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753223332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xKyQqRMGqz6gSElQLRF8oRqi07R7uUiy593EGZezUY=;
	b=i2CbnfTCdzhzjfRLgVsqhSrczQftq9qFEAqisV5hOerBgPVOaw6BSyqtjThwl9I3jFyaSG
	ELo+mjk8OMijSchST5cXwN3f8Zzh2U7ityNfeT2dOiJ2CjsyAw8qUZ3bNevYGlNHHMGBEw
	wRZsoerbcQ0+pw6utVQCB5hWT+DhREQ=
Date: Tue, 22 Jul 2025 15:28:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject narrower access to pointer
 ctx fields
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>
References: <3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/22/25 7:32 AM, Paul Chaignon wrote:
> The following BPF program, simplified from a syzkaller repro, causes a
> kernel warning:
> 
>      r0 = *(u8 *)(r1 + 169);
>      exit;
> 
> With pointer field sk being at offset 168 in __sk_buff. This access is
> detected as a narrower read in bpf_skb_is_valid_access because it
> doesn't match offsetof(struct __sk_buff, sk). It is therefore allowed
> and later proceeds to bpf_convert_ctx_access. At that point,
> target_size is null and the verifier errors with a kernel warning and:

I think it meant target_size is 0. I suspect !cnt is the condition causing the 
'verifier bug: ...'. Please check. No need to resend. The patch lgtm.


