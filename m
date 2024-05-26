Return-Path: <bpf+bounces-30604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448078CF25A
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 03:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D1528135B
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 01:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF39A23;
	Sun, 26 May 2024 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GC9rVlLk"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148B622
	for <bpf@vger.kernel.org>; Sun, 26 May 2024 01:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716685749; cv=none; b=HpU706YodfeAMnjvyF84x64o10fp7VdOS62y+wt3qnRBdxifIzzg1lrTSQWab3Y9vumYgvuAbd5R/kDY2fHB4gpZ8uxwwHE1ROdXdua9vPHyW7t6A2FzWF/ZrO2qeqUyY2z5wSuitqUz3y5BDyRqZpwTceKplYkS/gpGOTtzfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716685749; c=relaxed/simple;
	bh=a/qBxrIRGAvKgWMJowSxFwuyroleHYZA1LoDLhiodHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INJyn5LjkOtzZ9VQoKM06u1D62R9DKIGVMvHRr6JNf0KA8ItuHktEYcxcmJQpvBugLnErPKjhIVN3EQPYMIcfBVaYcni1HBe2prwYTtaga0SR13xRFaPIWeN6+d1DSPRoWInGWcDpADWImYAla8XGm6ITsDf3U+QPeEr5u0vEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GC9rVlLk; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: toke@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716685745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjF4PaQmMOkZ8ewohtNjQZlMtJ3vjjKesq8dsxP4kS0=;
	b=GC9rVlLkuHcwUmMtRUv/FNg9Ufq0PVzdV2/0NIntFtPLLKPTOH++HpCaazTfYjbn4x+TRz
	0ioEuNkmF/y+oakpNPt8H+I8fSEq5pN6NIdN0UU8fgmtmOJQavRd5erpSZMME5aCK5u3iF
	AML9A2ex79IKZRUBiPZhTmPYsNu1x5U=
X-Envelope-To: ameryhung@gmail.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: yangpeihao@sjtu.edu.cn
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: jhs@mojatatu.com
X-Envelope-To: jiri@resnulli.us
X-Envelope-To: sdf@google.com
X-Envelope-To: xiyou.wangcong@gmail.com
X-Envelope-To: yepeilin.cs@gmail.com
Message-ID: <d178f981-a4fe-443f-b8d0-4a86aaea026b@linux.dev>
Date: Sat, 25 May 2024 18:08:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v8 18/20] selftests: Add a bpf fq qdisc to selftest
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 sinquersw@gmail.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-19-amery.hung@bytedance.com>
 <6ad06909-7ef4-4f8c-be97-fe5c73bc14a3@linux.dev> <87fru7ody3.fsf@toke.dk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87fru7ody3.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/24/24 12:40 AM, Toke Høiland-Jørgensen wrote:
> I think behaviour like this is potentially quite interesting and will
> allow some neat optimisations (skipping a redirect to a different
> interface and just directly enqueueing it to a different place comes to

hmm... I am not sure it is a good/safe optimization. From looking at 
skb_do_redirect, there are quite a few things bypassed from __dev_queue_xmit 
upto the final dequeue of the redirected dev. I don't know if all of them is not 
dev dependent.

> mind). However, as you point out it may lead to weird things like a
> mismatched skb->dev, so if we allow this we should make sure that the
> kernel will disallow (or fix) such behaviour.

Have been thinking about the skb->dev "fix" but the thought is originally for 
the bpf_skb_set_dev() use case in patch 14.

Note that the struct_ops ".dequeue" is actually realized by a fentry trampoline 
(call it fentry ".dequeue"). May be using an extra fexit ".dequeue" here. The 
fexit ".dequeue" will be called after the fentry ".dequeue". The fexit 
".dequeue" has the function arguments (sch here that has the correct dev) and 
the return value (skb) from the fentry ".dequeue". This will be an extra call 
(to the fexit ".dequeue") and very specific to this use case but may be the less 
evil solution I can think of now...


