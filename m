Return-Path: <bpf+bounces-57560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337ABAACECC
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 22:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22667503BA1
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A21B72613;
	Tue,  6 May 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gxTfRViS"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFC86348
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746563091; cv=none; b=mx8JDEywxy2ilF6OBLqosoIq0ErSUPwh8P4RQq6Xjkn1WOTuN1C8vWIn+UHlorPGPHHcZ1jhM3CgWhr/s+xtptA5Ho+Of7rB7Paqrykbr6bhITPxSn8OtlYCzdKW7JV7XHZtGI+kvmce8cnasE2+uKgCsmELFsNMBud9wMChXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746563091; c=relaxed/simple;
	bh=T6Wn0W3bK/1o7arEYvDyYgs/pRvSEyZXJEsHapHRN2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNlaDJR5zk3HdM7gQqS1PjrVAKYtJa0+N5IikvIqcvtZvxR9vj5WHhkZ0ddKNPVWKa40t1E+pppvqWXyogIKjJI7O35WyZ2oduqREh7LLxNOq1kP4ULkDfdBsYhk9n+rqrvLpfz1qvIGktP1tw9TTrirVD96dSy2ahlawaj1cEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gxTfRViS; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b776fa07-de4b-44be-ae68-8bc8c362ea81@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746563077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Hk5IHJL/i2F/azVD9h3zUcZRECd4/4rkqvBQlEnV/Y=;
	b=gxTfRViStprrOmcu7JJz5WEsS2Dghtsju8+yo4jRYyZ+TQeG6SwHKeWl7jL22tksOIzZKw
	3vOGN3bHFte2d6c6a5Yx70UJ7+FORIygOCEOX7ohwG8D5J8/PY8NjWTszBY7db4bz1AiJt
	oaGx4pwDPvYQOw/RGr0UGotKfdGgdRM=
Date: Tue, 6 May 2025 13:24:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH bpf-next v4 1/2] bpf, sockmap: Introduce tracing
 capability for sockmap
To: Jiayuan Chen <jiayuan.chen@linux.dev>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250506025131.136929-1-jiayuan.chen@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250506025131.136929-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/5/25 7:51 PM, Jiayuan Chen wrote:
> Sockmap has the same high-performance forwarding capability as XDP, but
> operates at Layer 7.
> 
> Introduce tracing capability for sockmap, to trace the execution results
> of BPF programs without modifying the programs themselves, similar to
> the existing trace_xdp_redirect{_map}.

There were advancements in bpf tracing since the trace_xdp_xxx additions.

Have you considered the fexit bpf prog and why it is not sufficient ?

> 
> It is crucial for debugging sockmap programs, especially in production
> environments.
> 
> Additionally, the new header file has to be added to bpf_trace.h to
> automatically generate tracepoints.
> 
> Test results:
> $ echo "1" > /sys/kernel/tracing/events/sockmap/enable
> 
> msg/skb:
> '''
> sockmap_redirect: sk=000000000ec02a93, netns=4026531840, inode=318, \
> family=2, protocol=6, prog_id=59, len=8192, type=msg, action=REDIRECT, \
> redirect_type=ingress
> 
> sockmap_redirect: sk=00000000d5d9c931, netns=4026531840, inode=64731, \
> family=2, protocol=6, prog_id=91, len=8221, type=skb, action=REDIRECT, \
> redirect_type=egress
> 
> sockmap_redirect: sk=00000000106fc281, netns=4026531840, inode=64729, \
> family=2, protocol=6, prog_id=94, len=8192, type=msg, action=PASS, \
> redirect_type=none
> '''
> 
> strparser:
> '''
> sockmap_strparser: sk=00000000f15fc1c8, netns=4026531840, inode=52396, \
> family=2, protocol=6, prog_id=143, in_len=1000, full_len=10
> '''
> 
> Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> ---
> v3 -> v4: Resending this patch as v3 was incorrectly closed by Patchwork.
>            Additionally, carrying the Reviewed-by tag.

John and JakubS, please take a look.


