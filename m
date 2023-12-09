Return-Path: <bpf+bounces-17300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7796080B169
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 02:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7661F21412
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB6EA2;
	Sat,  9 Dec 2023 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UbAnk2hK"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [IPv6:2001:41d0:203:375::b2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F46C10F1
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 17:27:51 -0800 (PST)
Message-ID: <e89bdb40-b385-42be-9c49-8039bf935b4f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702085269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zraGspQIXEmmFnTBHY2t8soO8id4z4C9boCojvHRKA=;
	b=UbAnk2hKDTkZPMKiPRTz0dqqbavtxB7oFczJF8Ks7YjCR54Jf9E9wGPmaZ9e2iknS02JVD
	nZY036byG+AV9qZcxeohRrk1Hs5MX0IPFlKKgAjkI/neiRQDeTEuGO3/WXkvz5wWUk0URY
	xwur7ixWutZ0kPmWMHiGBM5BXNUZIxs=
Date: Fri, 8 Dec 2023 17:27:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 3/3] selftest: bpf: Test
 bpf_sk_assign_tcp_reqsk().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, edumazet@google.com, kuni1840@gmail.com,
 netdev@vger.kernel.org
References: <7e04fc5f-30a9-468e-bf07-49b00040b6db@linux.dev>
 <20231207065656.23862-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231207065656.23862-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/6/23 10:56 PM, Kuniyuki Iwashima wrote:
>>> +#define BPF_F_CURRENT_NETNS	(-1)
>> This should be already in the vmlinux.h
> I thought so, but the kernel robot complained ...
> https://lore.kernel.org/bpf/202311222353.3MM8wxm0-lkp@intel.com/

may be the BPF_F_CURRENT_NETNS is not used in the net/core/filter.c and then not 
get into the vmlinux's btf...

just pass -1 for now.

