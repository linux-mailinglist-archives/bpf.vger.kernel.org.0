Return-Path: <bpf+bounces-37825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E8395AD98
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61381C2207A
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 06:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A9149C6D;
	Thu, 22 Aug 2024 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BbVA7a4j"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C71448EA
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308528; cv=none; b=CPAcnDvCFTVTBl3m5dpfKVKzzrz14igx9q4JupRqvtAmKRdRIy0+e+3Qa2wdkv1mvQFnp2PfotJz+FS28NiexM2WQQVLuph3uu3YfcU6g+2yT6FuI0K+z7qV0kFC8hqtKUlb3HXszd6rnvYYraepzs/N6gyD00Y72GTGg07V4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308528; c=relaxed/simple;
	bh=eJEH0zy2+7UivNPH/b5loo7i+3Uf4cU4yQN58eQklbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQiDMYYkzQEWfHaQWdiHNSrqVaq4ykLOys+FtJCpk077o9pgZC89+qjq/2yKmGPGWk8HX5Tc2+yy8aFYMrhmhh4Chk7U1d77XWbZsZKqOL53oz0t5dBsWGYLGPfDCbjl1imLbHzUW6DIK+0ZZMmN2Zlwm0Y9OXP7YSEuv0a+wSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BbVA7a4j; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f23ff95-dce3-4ee1-b387-72adf0060b47@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724308524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6tH7Zuexupd/X8Llr8CIYE70UcMjn2DCBQCE3pAOtU=;
	b=BbVA7a4jMXC1EiejbJxv4Qzm3hZWP/IES1f/VDo8ZX8Yk0FaDA2z+nAtcRFjw9OhOvLEVx
	Zbk5oRwvk2U9/95gseut2lOaiZCaVqAhgxtr7nuLDD3zTBMI6JRDuhmfOd3/GxnBwquH9D
	AzvNNe0QlzF9oOk6qNdfi8mJIX5s3q0=
Date: Wed, 21 Aug 2024 23:35:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next] selftest: bpf: Remove mssind boundary check
 in test_tcp_custom_syncookie.c.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240821013425.49316-1-kuniyu@amazon.com>
 <82ae0ebb-b56f-4a91-a5f8-65f48b4da1ce@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <82ae0ebb-b56f-4a91-a5f8-65f48b4da1ce@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/21/24 7:54 AM, Yonghong Song wrote:
> 
> On 8/20/24 6:34 PM, Kuniyuki Iwashima wrote:
>> Smatch reported a possible off-by-one in tcp_validate_cookie().
>>
>> However, it's false positive because the possible range of mssind is
>> limited from 0 to 3 by the preceding calculation.
>>
>>    mssind = (cookie & (3 << 6)) >> 6;
>>
>> Now, the verifier does not complain without the boundary check.
>> Let's remove the checks.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/bpf/6ae12487-d3f1-488b-9514- 
>> af0dac96608f@stanley.mountain/
>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Applied to bpf-next/net. Thanks.

