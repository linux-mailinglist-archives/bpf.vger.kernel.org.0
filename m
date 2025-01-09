Return-Path: <bpf+bounces-48453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F28A081DB
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800131694F9
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 20:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A97202F71;
	Thu,  9 Jan 2025 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rKOfzcFI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4r3RNMjI"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F01F8F01;
	Thu,  9 Jan 2025 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456086; cv=none; b=bY0UnN/24msU8n7tJ5SGER4SiER8+q8p8xy6taO9uR7ef+wDl/qkiCh2R+AUoSoHvTmsH9RWxTqZx0csDaJIOwAu/IcwlXucPs4L3X4g3pYOtlklGdc67J+lYWID805GsrJg1Tm+A/XuGrNltN4RSkkjMD5MXe3zkNHajy1qlaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456086; c=relaxed/simple;
	bh=vPLSYiO1kyA23GjWU3ikmOVfaggML8gWpAq6shW2gF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smfHy4BgJ6KS7WIsu/KSA4cxKiXfbmI23ZR/v9erPt/HdzHQErEK+U4aW+2tkf4nS+edzxPlJTDwDuy652lkb7oSJAqyOOQP9wt8DvrQE/uqGJs+SMoLJs6OFsKzdLrb/ecdoBQtWFH5oBQf0OutCfw08BI8nK5adfJ6GFDSE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rKOfzcFI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4r3RNMjI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 9 Jan 2025 21:54:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736456082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vPLSYiO1kyA23GjWU3ikmOVfaggML8gWpAq6shW2gF0=;
	b=rKOfzcFIjS/kpCvZ/OTZs0UFB8c2k8N2G7CB4zy7Jur7pFsApJvGks1E3hztWmsyKxoE0k
	ITmCz7vo6t/sKwFJsnOIQgGgNJYBsG9nt81TAn0YM7B3fwsq5N8uXH3SYKT17z+/C1PG/9
	K3hYpql4U/k/L7gCamAFZFR/8/eRoVVvvaEZ942BHufYzB6KiYUzZvkuQ0Xcd8eViSYDI6
	76Otc0/qFwNuXXHnhjImkE8rH7GC/btiT2VuCwgkw7MJi8EVSds8aD2P3CmT/P0rdReCzf
	3uFpy3szyI4leAtM6h25okbCG23YoxJfvyKYru+aRG6yy2E7gjlIWu2Qgd39aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736456082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vPLSYiO1kyA23GjWU3ikmOVfaggML8gWpAq6shW2gF0=;
	b=4r3RNMjIDeEHr0YiKyydSw+JPaP9SAcLTd7A2wpJU06w5s5Zt0MI5u1QqpS5PYAgeozAPX
	4P7cQ+eFd5ByzPCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Steven Rostedt <rostedt@goodmis.org>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 25/28] bpf: Use RCU in all users of
 __module_text_address().
Message-ID: <20250109205440.J5EYqOuu@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
 <20250108090457.512198-26-bigeasy@linutronix.de>
 <CAADnVQJPf9N1THd4DXbOC=UthYvaPmOm5xQD2rcFunGXp6h5_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQJPf9N1THd4DXbOC=UthYvaPmOm5xQD2rcFunGXp6h5_g@mail.gmail.com>

On 2025-01-09 10:38:03 [-0800], Alexei Starovoitov wrote:
> lgtm.
> Should we take into bpf-next or the whole set is handled together
> somewhere?

If you don't mind, I would hope to route the whole series via the
modules tree. Some of the lower functions (__module_address()) check for
disabled preemption and will trigger warnings at runtime if this gets
applied before (earlier in the series) the check gets replaced.

Sebastian

