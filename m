Return-Path: <bpf+bounces-19960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF378331E2
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 01:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E17FB236BF
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162FB1FD6;
	Sat, 20 Jan 2024 00:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mPWZtuo9"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECC1C30
	for <bpf@vger.kernel.org>; Sat, 20 Jan 2024 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711183; cv=none; b=KtxtE0u8Wc0mhP8E7qoNj1UGMwsUiq2meN03b6v9B259h+nZlyysnR2bDxtkMFIHaS0jwTJgomxtnzMMmTaX8+RX80wL7QpwbiwjSfI35sRsbKlcW6NNXOygdUmsi89w9AZgISbxYzvJhzvE1GPzyXVU3eb3xzvHevuEHw1d1ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711183; c=relaxed/simple;
	bh=vlQgyIc7NE9JTe4r0MQQejEJX3K1E5w5c4Xequ0xBeo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MPszSjdkO+xtieph+Jy2o44cHwuV1/1uEdvAt9dYH5ypmGGQsWP/mIedGSa/1x4LHx/biOMOx890SeLVFKyfCCf3Kw3ps2MIyAP6q2i1lX1O6J3r9xUWYtaniffTm1JOsxK/LDGHEUllYmhVWCVSlzlbUO8qsZ5BIDEVezYJtz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mPWZtuo9; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <88a6a00a-73dd-4855-8244-2b8d76eaa4d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705711178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ1B2AzAsZJORgdfEKqPnLpIrwS2tYiZa8Wtb4GrnBA=;
	b=mPWZtuo9ceg0rwEAECtO9+SuWBwBrXLZgf7NzDJhND319J9qXU+uq1jFvcljuLuN+UivJC
	dVO5a3s3VOAzW2YMoI0F4AYXC7K/BpRb2VkiUWzkz3nRvCcq8Idwvs9LMvT/OZ0uGBS4OD
	E5yn06WecgTq9HPuD4HEfA1OPYzoIAY=
Date: Fri, 19 Jan 2024 16:39:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix the flaky tc_redirect_dtime
 test
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20240119235143.1835178-1-martin.lau@linux.dev>
In-Reply-To: <20240119235143.1835178-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/19/24 3:51 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> BPF CI has been reporting the tc_redirect_dtime test failing
> from time to time:
> 
> test_inet_dtime:PASS:setns src 0 nsec
> (network_helpers.c:253: errno: No route to host) Failed to connect to server
> close_netns:PASS:setns 0 nsec
> test_inet_dtime:FAIL:connect_to_fd unexpected connect_to_fd: actual -1 < expected 0
> test_tcp_clear_dtime:PASS:tcp ip6 clear dtime ingress_fwdns_p100 0 nsec

The test continued forward but hits another error:

rcv tstamp unexpected pkt rcv tstamp: actual 0 == expected 0

This seems unrelated to this fix but I will continue to debug first.

--

pw-bot: cr


