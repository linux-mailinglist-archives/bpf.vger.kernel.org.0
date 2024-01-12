Return-Path: <bpf+bounces-19459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE80082C2E1
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 16:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73062B22907
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79FC6EB61;
	Fri, 12 Jan 2024 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1GGf1DU6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fvlnJbYL"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B9141C62;
	Fri, 12 Jan 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Jan 2024 16:37:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705073851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BbMbE7TF8i1sZXppGrqoHHjUY3M11JhDxCtzDdAUuRw=;
	b=1GGf1DU68xr+ui1Avv/QWcHvqsdOuManS53L5hKHadiHJXCRP3Y8kk99lV9FjsQNjSF1nO
	nd7IXO8qvMHZcOmpIelxtpx32TDUeBOVEp1/kXueuR1rPRQ9XvlgQfZmn+Z/I2dC8JsgIr
	1MUL3nBT/t6g/FU0b9WPzkss5hz5wQCruZHqnZTUs/o0V4Z6GIj4lDVJnisVRC8l0qgGx7
	mXi0mJ00yAkRAG26UCcMiCcBNLXf6PaujYD6CNKC13FNEltl/MWVGqXp5sUx8NZqswynxn
	KMFIocRjpwH0NGzuCJnFJe/y5AAxWHlKqVgIFlQDtBRw4v0YNjcU6DEFx27kKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705073851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BbMbE7TF8i1sZXppGrqoHHjUY3M11JhDxCtzDdAUuRw=;
	b=fvlnJbYLOwIgdowsO9OyVTF9juUCvJAx60fsmA5ZO/FIGj8AXSun0fRnqtBhGeFwd4GU/P
	FS9aiBohTk/VYFAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Hao Luo <haoluo@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Juergen Gross <jgross@suse.com>, KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Wei Liu <wei.liu@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org
Subject: Re: [PATCH net-next 16/24] net: netkit, veth, tun, virt*: Use
 nested-BH locking for XDP redirect.
Message-ID: <20240112153729.A68q4xsA@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-17-bigeasy@linutronix.de>
 <74feb818-7109-cb1e-8eec-a037c17a2871@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74feb818-7109-cb1e-8eec-a037c17a2871@iogearbox.net>

On 2023-12-18 09:52:05 [+0100], Daniel Borkmann wrote:
> Hi Sebastian,
Hi Daniel,

> Please exclude netkit from this set given it does not support XDP, but
> instead only accepts tc BPF typed programs.

okay, thank you.

> Thanks,
> Daniel

Sebastian

