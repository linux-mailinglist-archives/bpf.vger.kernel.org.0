Return-Path: <bpf+bounces-56442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F959A974A3
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 20:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BF4175FFF
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 18:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DCB27BF86;
	Tue, 22 Apr 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MtMK2l6Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5962980CA
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347776; cv=none; b=XYrXghnu304RgHtxS9UafPCbFubgWKx1OeVaLq/IuwwO26x/6P+Cz6MCuBzx7Z+WTXnsZ0g3PX8E2M6iD3cdjPkTLHoQzQDMoO0FwWtdBAOz1OOVNxjpE+gWuZd0zFVmsjSHFn/bXKpWi95Ao9Jgy6JdTmPVXrzbJaP0eq2LFi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347776; c=relaxed/simple;
	bh=RWoWEtAf7f+7io/364/s7GfQqzo3lkhR6B0rZgvXcxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ysp3ECD5b9RBy3wRokP9vE645kKlceTTm8WpepP0vDhZaZf5imsA90Vj5ZmDGbW8ThlHHlJSmlrFvn/CVyzeQbq1t4mcvKQ6dhx1fDHiAMgK/qb2gO7na+g2GaVQPsCEVK2c/8KWowR34+kxmDVrjnyr0de9ltqLrSPkHp0zQ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MtMK2l6Q; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <35f0089e-57a6-4f40-a278-aee4bcfeafac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745347771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhgdkHrICyQW4O8yX6lvFSiloeTjU1LbOh9CjFLXlJs=;
	b=MtMK2l6QIMZPloVF21C6KQJolqy0G8ntUQXZ4lS9zmRs3ehhc80XRUdfeLE9NqlKFdYzOk
	d9lXh55ryL0zBNg4j5HVok/jLP0TuiN2ywklnaYc01st5fnLf2KpLJSppDXND/uNCKCjdT
	VK0Sn+INywGbY6xtbx9S3uFfSsi8QCQ=
Date: Tue, 22 Apr 2025 11:49:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: pull-request: bpf-next 2025-04-17
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Amery Hung <ameryhung@gmail.com>
References: <20250417184338.3152168-1-martin.lau@linux.dev>
 <20250421185450.6fde6f84@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250421185450.6fde6f84@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/21/25 6:54 PM, Jakub Kicinski wrote:
> On Thu, 17 Apr 2025 11:43:37 -0700 Martin KaFai Lau wrote:
>> 1) bpf qdisc support, from Amery Hung.
>>     A qdisc can be implemented in bpf struct_ops programs and
>>     can be used the same as other existing qdiscs in the
>>     "tc qdisc" command.
> 
> Hm, it doesn't build in allmodconfig. Is there a strong reason for it?

The bpf_qdisc.c is enforcing some correctness in the bpf 
Qdisc_op.{init,reset,destroy}. For example, it ensures that 
qdisc_watchdog_cancel is done in reset/destroy.

It is done by patching the bpf .reset prog and call a kfunc to ensure the 
cleanup work is done. Patching with mod kfunc is not supported now. We can 
consider to directly use BPF_EMIT_CALL to support mod helper call which should 
be simpler verifier changes.

