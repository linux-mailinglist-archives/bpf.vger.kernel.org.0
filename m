Return-Path: <bpf+bounces-75032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F9CC6C7A6
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 03:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 84D8F2C827
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 02:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1992B7082F;
	Wed, 19 Nov 2025 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iI0K4CF8"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB64271A9A
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520936; cv=none; b=SGAhMXu0PZIgjN+v3EArgFWdfsFmBfXsbfRJpKMTKjEndB6WxW4k6QoPm4fmjhUz7st9K59rOz1xOkvYYwVeYlNi0dx1UdxQVyeQA5MmB82PPuN/Alw5BtG7dFSmP0lEZkDAgb4qKVECkdHLXzvlAce/yw5Kvx2xcakt7dMn53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520936; c=relaxed/simple;
	bh=dVSDNy+DPQdDSMwW6icZnlkNgzbJHoHYB4a8VWDsAaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaynIxsytxNli8Y83sbKOHg2etlvrS9Egq9fU4ETrf8UKTh3e0E14eVMWqlqsbiBMAARbBFUxQsAKHfSJgxc6rWPAl6fL87pWkZrFLZu8xyIKPYLZ3fDw33RswSBytx0RXfwdqLpXKBbAfZOz450aSPxs75bjjwbiVcEHszTNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iI0K4CF8; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <97c8e49c-ca27-40ec-8ff6-18b1b9061240@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763520931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYOi8yKGJknMfqscK3XJCAosx9iyRQ0/XGaFEVpfjzk=;
	b=iI0K4CF8Yr+i4/s9Pl3AduYCV/WxD98Z+hw06/lA6hsyefYszHcJLJjA4oPzsOYmlxI4Lm
	hB8pq7oi6iV3gbGzt1q+EngKeY+IKHYZ87cl5KySiGKSs/GxeOp7C9NaTRMdZvM+dfQzoP
	OQv/BxKHxn7r5OUp+DL3zZX8e7CysLU=
Date: Wed, 19 Nov 2025 10:55:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/6] bpf trampoline support "jmp" mode
Content-Language: en-US
To: Menglong Dong <menglong.dong@linux.dev>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <CAADnVQJF5qkT8J=VJW00pPX7=hVdwn2545BzZPEi=mPwFouThw@mail.gmail.com>
 <8606158.T7Z3S40VBb@7950hx>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <8606158.T7Z3S40VBb@7950hx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 19/11/25 10:47, Menglong Dong wrote:
> On 2025/11/19 08:28, Alexei Starovoitov wrote:
>> On Tue, Nov 18, 2025 at 4:36 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>>
>>> As we can see above, the performance of fexit increase from 80.544M/s to
>>> 136.540M/s, and the "fmodret" increase from 78.301M/s to 159.248M/s.
>>
>> Nice! Now we're talking.
>>
>> I think arm64 CPUs have a similar RSB-like return address predictor.
>> Do we need to do something similar there?
>> The question is not targeted to you, Menglong,
>> just wondering.
> 
> I did some research before, and I find that most arch
> have such RSB-like stuff. I'll have a look at the loongarch
> later(maybe after the LPC, as I'm forcing on the English practice),
> and Leon is following the arm64.

Yep, happy to take this on.

I'm reviewing the arm64 JIT code now and will experiment with possible
approaches to handle this as well.

Thanks,
Leon

> 
> For the other arch, we don't have the machine, and I think
> it needs some else help.
> 
> Thanks!
> Menglong Dong



