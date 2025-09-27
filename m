Return-Path: <bpf+bounces-69904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4224BA60C1
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 16:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D267A3108
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07FC2E54AA;
	Sat, 27 Sep 2025 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F5iRasoC"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BBF34BA44
	for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984598; cv=none; b=MaPwZQZxbpazc5l8jKy3rWq5vL+5RxO9vkXuiJem9Fc9UJswjEjWMPYniS+tkF2APfP2y9k4P7GLYATVJQKrsczYIGC4sPuD1POK+WWfAHyw3eW4cl2aGx+nZYT47nmk/yv8lSYzF4QDiDUi2dwYZxenj5iCCSifpBGHZeR+zzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984598; c=relaxed/simple;
	bh=TYhI2zz2EntqMQqiL0goZp8lyeCNBCnleWw1qPrT4jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCcNQQcRK4St/cvEMeR3Bf2IzI0EEgVWEWoyZ1ORr4ac42QwREnXz/VWrhrj1HRQVfjZ9odk9oCU6nFNa+Xo7GwuC/59w7uDl2dedbzdssNjLnHtaa/BcyrLlsoI5R94AMgw6a+ccB3Ns9ojkh3HNGP5G6A9w1zP+GsljOUx3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F5iRasoC; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f81fa440-4a89-4d80-9707-86db76141969@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758984592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jzm56twg8sUvb2HEl+dtjwCrRZ/Y3Lmy4YgouX3KRBI=;
	b=F5iRasoCwgX0G/MSFzAlumAcgZ2OMQe7DB3QET6ejcQfqyCgrESV0f7gxRFjJ5HUMRCvYx
	nUhiEeuQKUBnw+fLXdE9JGIGu5+jC1AmuBzu3huVBjZQqueupopOp9hlTeEUfo/jIPrYrl
	sqNQoTWFHZT7ZXohN9dwSCDlTNIZbEA=
Date: Sat, 27 Sep 2025 07:49:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 bpf-next/net 2/6] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250920000751.2091731-1-kuniyu@google.com>
 <20250920000751.2091731-3-kuniyu@google.com>
 <ddrg3ex7rbogxeacbegm3e7bewb2rmnxccw4jsyhdpdksz2qng@2xbs7jvhzzhk>
 <CAAVpQUDxSwjegw1UgieGOF+YGF=j2_FK=M1ZEKP1KGdtCdEBkw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAAVpQUDxSwjegw1UgieGOF+YGF=j2_FK=M1ZEKP1KGdtCdEBkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/25/25 3:40 PM, Kuniyuki Iwashima wrote:
> On Fri, Sep 19, 2025 at 10:25 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> On Sat, Sep 20, 2025 at 12:07:16AM +0000, Kuniyuki Iwashima wrote:
>>> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
>>> buffers and charge memory to per-protocol global counters pointed to by
>>> sk->sk_proto->memory_allocated.
>>>
>>> If a socket has sk->sk_memcg, this memory is also charged to memcg as
>>> "sock" in memory.stat.
>>>
>>> We do not need to pay costs for two orthogonal memory accounting
>>> mechanisms.  A microbenchmark result is in the subsequent bpf patch.
>>>
>>> Let's decouple sockets under memcg from the global per-protocol memory
>>> accounting if mem_cgroup_sk_exclusive() returns true.
>>>
>>> Note that this does NOT disable memcg, but rather the per-protocol one.
>>>
>>> mem_cgroup_sk_exclusive() starts to return true in the following patches,
>>> and then, the per-protocol memory accounting will be skipped.
>>>
>>> In __inet_accept(), we need to reclaim counts that are already charged
>>> for child sockets because we do not allocate sk->sk_memcg until accept().
>>>
>>> trace_sock_exceed_buf_limit() will always show 0 as accounted for the
>>> memcg-exclusive sockets, but this can be obtained in memory.stat.
>>>
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>>> Nacked-by: Johannes Weiner <hannes@cmpxchg.org>

The patch cannot move on (i.e. land or respin) until the NACK concern is resolved.

>>
>> This looks good to me now, let's ask Johannes to take a look again and if
>> he still has any concerns.
>>
>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Hi Johannes,
> 
> It would be really appreciated if you have a look again.
> 

Hi Johannes,

Can you take a look if the clarified reason in the commit message has addressed 
the concern ?

Thanks,
Martin

