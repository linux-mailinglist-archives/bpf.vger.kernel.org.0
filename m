Return-Path: <bpf+bounces-30477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E1C8CE1D4
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 09:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C682B28263B
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF2183CCC;
	Fri, 24 May 2024 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uMeyXc1H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+ZG5WGa9"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41006FCC;
	Fri, 24 May 2024 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716537282; cv=none; b=dIPd1Z6QMq6vHPLOn94zqgVCRj1c/Y+2XWQxWtRKuixADenKZ9E7VHjEykI1GeAPNFb24Rju/6oKRRrzKOQ/cjEDpoF2b8yW+YzeaPrmtL5utOi7Vu+S4pHWJmwRSpaUc81SeDL6MCGqsiBANBhK6tCv6XHBQX0qMDfHM9Dzp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716537282; c=relaxed/simple;
	bh=AQWIfTfzqOdbhk0hDPdwIJF63BEKo8joJ/woMW6honc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZuw7v9ORP7t0L3yA8g6iTDSYQFQKKsP0W/F5gdqXeFz4sz3NdVojmjjAo3VsR22aJGWte6PgATzRPzcIe5MK5Nps+vLZbmp/vU/1xXk0EfzxWp7veediN7BsSej736EdazVoi7U0HlYcZEmUfS65HFCqFUBsevl3PmjxJnmEtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uMeyXc1H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+ZG5WGa9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 May 2024 09:54:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716537278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Quo18N2mmMPeVXpuHfcBQuoUjpytv9zJfnyZAoBrUVk=;
	b=uMeyXc1HjFcnaUyLvgRwOwm82KtAhhWBKQNpBghl0LQW5k/ovxecYJa1N42lABtcqiG3LZ
	ClT8pFrFZLMC9ZC6SCJNvQSHvm3nPqTy4AavHN0jkqnRz+RfhaljuE0WAEqRJ3jJq987vR
	wegatQnhb2wLNBEurd5bPdVDTPU09fnOM3MA9O1OBpuwlRyYGtZviJMuq59aLYoY5EnETQ
	VqktWrcPqYjH3HjUNGblDowgLnrpfFAdjN1nU2RYCvEkPsECk+YbfUpesr7KSsRCEegObA
	Hf7JuGckCav82Y29coefjsTNi7fb/Yu+Fsns/EcLmmYQdm4JCjXiQRvL3XpY6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716537278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Quo18N2mmMPeVXpuHfcBQuoUjpytv9zJfnyZAoBrUVk=;
	b=+ZG5WGa9tN7ZP5kLzEFpKTRaySsoOrRKvi2ByisggOcrg1bQAPSjmZVZTFUnfVp2u0ooYJ
	WeM2muSII4AOL+Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH net-next 14/15 v2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240524075436.YmcT7GSd@linutronix.de>
References: <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>
 <20240507123636.cTnT7TvU@linutronix.de>
 <93062ce7-8dfa-48a9-a4ad-24c5a3993b41@kernel.org>
 <20240510162121.f-tvqcyf@linutronix.de>
 <20240510162214.zNWRKgFU@linutronix.de>
 <4949dca0-377a-45b1-a0fd-17bdf5a6ab10@kernel.org>
 <20240514054345.DZkx7fJs@linutronix.de>
 <e4123697-3e6e-4d4a-8b06-f69e1c453225@kernel.org>
 <20240517161553.SSh4BNQO@linutronix.de>
 <e3e21c87-d210-4360-8beb-25c6a04ce581@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3e21c87-d210-4360-8beb-25c6a04ce581@kernel.org>

On 2024-05-22 09:09:45 [+0200], Jesper Dangaard Brouer wrote:
> 
> Yes, except I had to guess how the workload was split between CPUs ;-)
> 
> Thanks for doing these benchmarks! :-)

Thank you for all the explanations and walking me through it.
I'm going to update the patches as discussed and redo the numbers as
suggested here.
Thanks.

> --Jesper

Sebastian

