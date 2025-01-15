Return-Path: <bpf+bounces-48954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A71A1293F
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3AA1649E2
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA98192D69;
	Wed, 15 Jan 2025 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ITtO8J33"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C081791F4
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960157; cv=none; b=oknupASuwj52zHVZ1bhmy9ToZffi9dHfyobbta/TAfp+JjfasN6/d5dOj4SnRXk5p4bUjFEr07XSPUnWTlRW5nR1l8jipHbebv2Dq8gq6+OtU30zZSxPAEU7oilYxSrktAObQ9O9h6wn/2ADnOfJ37LS279P1MQ1kBwTYnPA1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960157; c=relaxed/simple;
	bh=EkZMOS8lXQVrePsY1zs/c2ht67Jf2ytlmPkCyb7euc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LjaiWnSDM2POXeDw3BUoYXo6JrqB9V774/8P/+mGyhRIk+Sfy2LCPABWACe695F75J/RWlE+TgvIFlOngqfZ5N3Y2KK9Dg/rNCRSq7FYj2XSG9hJMPIs41K+uS2UOobhXG3hjD/H6ZTgv9okSV2n1pvMNYtr5ivb3p7iaGpD/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ITtO8J33; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34f1132b-43de-44d2-9bc0-e25b49598711@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736960137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkZMOS8lXQVrePsY1zs/c2ht67Jf2ytlmPkCyb7euc0=;
	b=ITtO8J33ygW8Kz9rurcxjs5IexSyB/zqDcA0ccHS/S0Z+Cwx1rHHF9NWRsecqO5fX8srTA
	SX+ZGRwXhwPCJ3spPUj9F4iJdn1pQbHQjEZO6STmr4mRWpecapLhxzsSt1knKFtINieJsy
	0D38IQYBa9tHb/GMWruYpkwqVtMvvHc=
Date: Wed, 15 Jan 2025 08:55:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: trace: send signals asynchronously if
 !preemptible
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, puranjay12@gmail.com
References: <20250115103647.38487-1-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250115103647.38487-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 1/15/25 2:36 AM, Puranjay Mohan wrote:
> BPF programs can execute in all kinds of contexts and when a program
> running in a non-preemptible context uses the bpf_send_signal() kfunc,
> it will cause issues because this kfunc can sleep.
>
> So change `irqs_disabled()` to `!preemptible()` that covers all edge
> cases: preempt_count() == 0 and irqs_disabled()
>
> Reported-by: syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67486b09.050a0220.253251.0084.GAE@google.com/
> Fixes: 1bc7896e9ef4 ("bpf: Fix deadlock with rq_lock in bpf_send_signal()")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


