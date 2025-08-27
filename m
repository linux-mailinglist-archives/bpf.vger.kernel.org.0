Return-Path: <bpf+bounces-66620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF59B37867
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 04:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B047A5F27
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 02:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F76A304BB2;
	Wed, 27 Aug 2025 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wutdG5GW"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F28259CB3
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 02:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756263535; cv=none; b=kIsfGNsl1oZXdQbwc8TH9CChL96zsCo8QBYY94CVOEvqsKBf7dXJ7YW1rsCFyrlKlWfjWWEGtspmefsEVM3CjfJu/cmaPduKxs/7G7FWmdybwKdNV4lSg1u3C8NKmCKzA/M6fs6Gms0jLic//VYtfAXBXG9I/UhuLrhyW4oGY3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756263535; c=relaxed/simple;
	bh=vqG7ouXav2ngCAr1JLyQjzcxAMdqNOzomPMiTEQrOFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHyd2M/HIuE8M93OQqlbZsTcVFIqMSSPqFHWQVVfL0xhNk9WQ0vnwUIh5U+5ZbufceR1CTrAeOo671Mar4Yr6PhWW/TXXhKRvDQRk52z2567ROSW1M+1hTJKCUOXULTefxDxAZnd3ZRQtjkemIXO1ZoK55721L2Pa9y4Nm7V/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wutdG5GW; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8dcc144e-3142-4e0d-a852-155781e41eb4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756263530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZZMIAYYTeVSb9zhtAvnomw5E/mCjgCodHITY7yc5mE=;
	b=wutdG5GW7YGJRHBfJOdIuaNZ9AvIzOEzKikK4i0IY/M9OTOq+KIFx0Yqhf+prqeiMMPATT
	GBv4uDi55843zr9towFnCHtqRHfnKhqsaP/mNr02ZKTaDpQ1u/EZMXQxN6Zt0xD87l0S6X
	wZggHVTOIlqPeqUU3KPM+KVRNAQR3Uo=
Date: Wed, 27 Aug 2025 10:58:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] Deadlock triggered by bpfsnoop funcgraph feature
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jiri Olsa <jolsa@kernel.org>
References: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
 <CAADnVQJz9ekB_LjSjRzJLmM_fvdCbeA+pFY20xviJ-qgwFtXWw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJz9ekB_LjSjRzJLmM_fvdCbeA+pFY20xviJ-qgwFtXWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 27/8/25 10:23, Alexei Starovoitov wrote:
> On Tue, Aug 26, 2025 at 7:13 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Hi,
>>
>> I’ve encountered a reproducible deadlock while developing the funcgraph
>> feature for bpfsnoop [0].
> 
> debug it pls.

It’s quite difficult for me. I’ve tried debugging it but didn’t succeed.

> Sounds like you're implying that the root cause is in bpf,
> but why do you think so?
> 
> You're attaching to things that shouldn't be attached to.
> Like rcu_lockdep_current_cpu_online()
> so effectively you're recursing in that lockdep code.
> See big lock there. It will dead lock for sure.

If a function that acquires a lock can be traced by a tracing program,
bpfsnoop’s funcgraph will attempt to trace it as well. In such cases, a
deadlock is highly likely to occur.

With bpfsnoop I try my best to avoid such deadlock issues. But what
about other bpf tracing tools? If they don’t handle this properly, the
kernel is very likely to crash.

Thanks,
Leon


