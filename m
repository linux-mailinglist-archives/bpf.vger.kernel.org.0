Return-Path: <bpf+bounces-49247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21888A15B09
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 03:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62463A97FC
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 02:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C7844C94;
	Sat, 18 Jan 2025 02:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BF2QgqXO"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B14C76
	for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 02:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737166630; cv=none; b=Q6eVWhPk/NS2PS6xZGhPZwzLJWlPjoQA3bCN2qi5uTSgk6YTsTnOBy4p4e0LIOweX18lyBL0AwILASAdpZrveImSTI7lF3zG+kpXNpO13QMuyPWMIoAfwYLJ9yi7cY1nUHn8U/HIw1pm63Y6KyC/h4otq8PhyWNwZrTjs8eVBBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737166630; c=relaxed/simple;
	bh=vIPBsoMDjFHSkDZDUt2LyephDQYYlD/+Q+78kJG0GdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYujCvMnBqPuxUPe1ro6kt+sqQ7SMaRE9yEwU3Mdomd+q8jOaDhgE9Ro4uG2T7St3/zc4NMiikVV5JIbF8gFFU5neVUKIvZpk/QptNhFEveBeOqK8oRGgBI9l9wuTanHVPiLVrKhGjjnvu3ZiDOb+uBss1BP3vm0VWLzRBWmuF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BF2QgqXO; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <060c5a50-85b6-4f1c-b458-33084858db12@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737166626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Wj7uhgBd6iH4mnu3+7AQ89HSzoTr/XsE+vzt6D3OTQ=;
	b=BF2QgqXOVhXcZwv1RvGLd7C6MpIaLrQyddyREttAYvWUJrUmmKI5fDbcLzc8WNODU03ekB
	mX7o1LGpnsG2O4ouXrqMBW4SPICE1NkKbMLJdtYgQwaLMuZ65T8/sJZrXdx0FhNJtsqKI3
	jYXSm1mz06sgkNqZCY+xVKYs1Kj0wOM=
Date: Fri, 17 Jan 2025 18:16:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 03/15] bpf: introduce timestamp_used to allow
 UDP socket fetched in bpf prog
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-4-kerneljasonxing@gmail.com>
 <02031003-872e-49bf-a658-c22bc7e1a954@linux.dev>
 <CAL+tcoD6MqBfbpM+ESkiNoRwsQqWsxMwMb4b0qvO=Cf8s52JyA@mail.gmail.com>
 <CAL+tcoDS6H4SMDRs9r+cOM_2bdbNRFRQpuYmpVFyxoMcQJDXLQ@mail.gmail.com>
 <ba353503-bfd3-4de0-bb99-9c7e865e8a73@linux.dev>
 <CAL+tcoChGB3vA7LMm0VHb9OjmXHUw0--f6v4Crz5R7U+EPo+cg@mail.gmail.com>
 <41688754-20fc-4789-879f-60f763b3a9db@linux.dev>
 <CAL+tcoCpWs0f145_d+KLmAnuKhQ-83bANkiXXLHE_hoyhGj6Pw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoCpWs0f145_d+KLmAnuKhQ-83bANkiXXLHE_hoyhGj6Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/17/25 5:58 PM, Jason Xing wrote:
>> On 1/15/25 5:12 PM, Jason Xing wrote:
>>>>> Also, I need to set allow_direct_access to one as long as there is
>>>>> "sock_ops.is_fullsock = 1;" in the existing callbacks.
>>>> Only set allow_direct_access when the sk is fullsock in the "existing" sockops
>>>> callback.
>>> Only "existing"? Then how can the bpf program access those members of
>>> the tcp socket structure in the current/new timestamping callbacks?
>> There is at least one sk write:
>>
>>          case offsetof(struct bpf_sock_ops, sk_txhash):
>>                  SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
>>                                           struct sock, type);
>>
>> afaict, the kernel always writes sk->sk_txhash with the sk lock held. The new
>> timestamping callbacks cannot write because it does not hold the lock.
> Surely, I will handle the sk_txhash case as you suggested 🙂

to be clear, not setting the allow_tcp_access in the new timestamping cb should do.

