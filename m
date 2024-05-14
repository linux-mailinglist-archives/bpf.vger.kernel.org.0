Return-Path: <bpf+bounces-29687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DA78C4C07
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 07:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1970B1F24C38
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 05:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C505518AEA;
	Tue, 14 May 2024 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5Ekx+uP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7LbllTbg"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385217FF;
	Tue, 14 May 2024 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715665428; cv=none; b=H2mRRgc09XJxe/+Uag98xiMwdlVXktXHPynbug/q7+X77KztY2JjYCxX4BNYiqJIAOMPQgFdbdJDIBzSoKx0zJFyEJF1z5aXZLz5mr4Y0gsUaYqy4F5Z1kHwpanOQD1N+fd4RTBMMpDXinbvQ41CpAsXNf/WqzJXOA4fciNhwUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715665428; c=relaxed/simple;
	bh=UJ0ZvK/WSzetvXXNGTyaHtYTIc+ARlYjLld/hzVS+Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xam6H+rbWvo3HaBCfrD4JSF6u3DRvJjY1NBRVg8vTHDFzL0T5CZB0AI8fsegKRJSqXMgGvQFmZ8eW9MQfpZ5bAVU7Y4oBHL4QJlJVRjVZw5H6UPcRdXnL7HC2Bvs7PLdpN1/DnTRfu5z+6r/SDoiWTIUgrUtqQt0Te6QoldLAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5Ekx+uP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7LbllTbg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 07:43:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715665424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9O9Ejw22nDJ+XJ+5sgwYg4fopr3qkoG1FgsTPvT968U=;
	b=Y5Ekx+uPvpFUOBQdfxueDtmM2GHFez2zSU71zsXGSTvyC1Iha5A4Zb6IXE+nvZyJyuiOa7
	cSGEzWevZcnnJdLGCJTE/POcINFVE5e4yXQZgYHWw+QA1fLVeipye8tiy8da4wVo0TapVz
	+g1ZUj9skwCRVE9Bi7K43oY34SrnPs1oumoxHkrMZe7Le44XYOQS6YHDGRMEfjUUxebADB
	Hfz4ZYThqeb4hhjGD+COEgHby8wv0Q5BzUKfw0mJuOdQnddDSj6nrRkHU8Tmvj3KXsoLhe
	IlF6WqDGSbl2G4k1SDadOTDijQsznmjgJ8/a2UG/iw5zpu/vxP6amr9IscUC1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715665424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9O9Ejw22nDJ+XJ+5sgwYg4fopr3qkoG1FgsTPvT968U=;
	b=7LbllTbgkamC+qJqVaY87jy5HU7T3t65CvMCyr6Per5fjFpPDRHgSszV9x9/aLahtJ4qIW
	p768q+BCI0o9b/Bw==
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
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 14/15 v2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240514054345.DZkx7fJs@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de>
 <87y18mohhp.fsf@toke.dk>
 <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>
 <20240507123636.cTnT7TvU@linutronix.de>
 <93062ce7-8dfa-48a9-a4ad-24c5a3993b41@kernel.org>
 <20240510162121.f-tvqcyf@linutronix.de>
 <20240510162214.zNWRKgFU@linutronix.de>
 <4949dca0-377a-45b1-a0fd-17bdf5a6ab10@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4949dca0-377a-45b1-a0fd-17bdf5a6ab10@kernel.org>

On 2024-05-14 07:07:21 [+0200], Jesper Dangaard Brouer wrote:
> > pktgen_sample03_burst_single_flow.sh has been used to send packets and
> > "xdp-bench drop $nic -e" to receive them.
> > 
> 
> Sorry, but a XDP_DROP test will not activate the code you are modifying.
> Thus, this test is invalid and doesn't tell us anything about your code
> changes.
> 
> The code is modifying the XDP_REDIRECT handling system. Thus, the
> benchmark test needs to activate this code.

This was a misunderstanding on my side then. What do you suggest
instead? Same setup but "redirect" on the same interface instead of
"drop"?

Sebastian

