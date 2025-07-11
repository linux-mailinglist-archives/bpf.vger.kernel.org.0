Return-Path: <bpf+bounces-63008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F61BB01555
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC21C4692D
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35F1E9B08;
	Fri, 11 Jul 2025 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K1dqZ6M+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R+BZoBEd"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F41F63CD
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220967; cv=none; b=Mxo/ybmTSalhBuE6lyI7FLBeZ+tlXM4OD5+yC5eyQ9i+tU5FirtMyZEO9yIv6i9RvVxKBy63y1nbqHsGauJ0B7sBEwurHs+IRFqxEP3k2kold2ao1PXqvbIDM1d55qnO5RDDRGVTrDY5nw4KI6etTApb/YwYXzkTBmvqcX7tMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220967; c=relaxed/simple;
	bh=nDv0vumelY0QBFzxENiYM4ERyLDlUMqMHZW9E7NeHZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMIF5NMDXnVU20QA6GLr7TtEK8KCbspb4z9M80VQtjLtEEzUy3L5wTeB/YwYd8BArKwXNh6p8+7yLIb+HDMR5H03ee6lCK+9JihTopnS0BdAmSXojcmtuX8siXlAleWCbXtDx0WEOR7db1l3ZuQ1vRlHua2wYOhrVGF3a3S6fn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K1dqZ6M+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R+BZoBEd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 10:02:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752220963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bFZ1IDLuf0P5MtghxDBAlCYYAF9UKN61gND6r3JMcGU=;
	b=K1dqZ6M+S2jVtnHTtSVK4zbU3GbDyU34C4U4qAsYnfAxzQ8YjLGeWXr2sdFjA+m6YZBwu1
	QS9e2tnQD6mByNYfp/BkpZMHL3h2buPTbokg3FVpf8EWpuZDbiCyZA5FThoUyH1ojeei8c
	QlJ0iHnuGNOUoB8Pfq3ivmPxCbLMrIcOah4RJFW3XPEm9B0UcfyA5S0cLQJcy25pv+nfHP
	HDuMr8SsmJHcd5qdsyvajsaXeswFs7qra6ZkYEhPn8n5Gh05dK5fuBzgi2Ntvm7YiRhKZ8
	gXWWBIryZ/2QGL54x5cG3uI28r/2RL/xmhibaJ3oyOXa+Y2OD4VyJxTarMYr4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752220963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bFZ1IDLuf0P5MtghxDBAlCYYAF9UKN61gND6r3JMcGU=;
	b=R+BZoBEd+DGiHpH6ItOhW1Dzm6QBT6XTBHeIfhHNr4x8SFr++l6oKWoL367I2Tztx8wgZZ
	9gDboTPLf8tZO5AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
	peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH v2 1/6] locking/local_lock: Expose dep_map in
 local_trylock_t.
Message-ID: <20250711080241.-_BJecVz@linutronix.de>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709015303.8107-2-alexei.starovoitov@gmail.com>

On 2025-07-08 18:52:58 [-0700], Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> lockdep_is_held() macro assumes that "struct lockdep_map dep_map;"
> is a top level field of any lock that participates in LOCKDEP.
> Make it so for local_trylock_t.

I am not very pleased with this. I would prefer one struct given that
the functions below are shared and the _Generic construct is not as I
would have preferred it. Anyway. I meant to redo it but didn't get very
far.

Since is reasonable for now

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

