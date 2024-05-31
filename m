Return-Path: <bpf+bounces-31027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7868D63F5
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655D3288740
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9899215B975;
	Fri, 31 May 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MvwYYmfI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MMyDTBqz"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C70155C8E
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164267; cv=none; b=G7vDxKQbsuL1zecI5LTwKv/taKK5bX1qoTn/kYmpGCeE+sxMkklWfBrFFqjYxi+teBc/HMTtrPARpfrJE30gfQLdpwQRabIpT630+aoV4eK7/wkKXGNS9WGK0P/d9MfqQiwFyTVxZDF4fEwJz6J0huscU4Tt9XQh1QqvmqwpFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164267; c=relaxed/simple;
	bh=8GRCQRREu/a8suBoLZZudj2TNv9gRvaeYKvdE0P7F/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB7fiDo1SBvfhIi9deuT0bgV0qhiRm99ExpZYJDUEkd6ZGxDk08qMevqYNgCK7/6DbqMTnNKvbb0AHCHrHaz3vUH/il7rOM5YtvMe0NGjcHKUJu0IHpqFKgz0bEgDaar3ELLEN/6q1mICX5XqLQJYrR4VHPDTvEwVYx0qm59+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MvwYYmfI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MMyDTBqz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 May 2024 16:04:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717164264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yirm/bZIzspb7k1OWDprXVCQbgxdulBR1AgIM8MxfXc=;
	b=MvwYYmfI1ywEVsvpkazVHfpoOs2Tv7OIqdbGkj4NicKrF5C3FLhKHCY/6FPLoNJRs2fEDw
	SJDL2PaqRHjRqC13QKARzbwdW1JKp3QTPN7dhaQz7GrK1/BA3pym/7DWADNmiAG3kGzfxw
	mDvu18/fnY3b70Q2kTGFn7koV/XnDoL2vG+OVk5KIHQzACXXEjBg0yGexJDdYOqIl1HmvA
	LVABwrQCcYcQvotFbdy24yktKuzQXVHksJpU4LPsp9aanILDoCG6xifB9AMcMBcYRTh9bw
	0lcze4R0QtIUIl3ceaRqF7qhOJ/GaJgTdGJCqAindKTZsSmIYZFNzt+Xc7Ul5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717164264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yirm/bZIzspb7k1OWDprXVCQbgxdulBR1AgIM8MxfXc=;
	b=MMyDTBqzQcQzjGJV6zQfGfocqbSDrjRfvfqFRUpQ7TyvXkfp3F9lsBcg/ollOWjIFduYAP
	2Ul0XOGkcHUZIDDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Make session kfuncs global
Message-ID: <20240531140422.w6TjGRAt@linutronix.de>
References: <20240531101550.2768801-1-jolsa@kernel.org>
 <20240531103931.p4f3YsBZ@linutronix.de>
 <ZlmpoWed0NmeZblH@krava>
 <20240531104922.ZgOadg-G@linutronix.de>
 <ZlmzmstEQSMp-6_i@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlmzmstEQSMp-6_i@krava>

On 2024-05-31 13:25:14 [+0200], Jiri Olsa wrote:
> ah there's also CONFIG_KPROBE=n
> 
> kernel/trace/bpf_trace.c is enabled with CONFIG_BPF_EVENTS,
> which has:
> 
>         depends on BPF_SYSCALL
>         depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
> 
> so I think we chould combine both like below

Yes, this would work.

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> jirka

Sebastian

