Return-Path: <bpf+bounces-51741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C4DA3875D
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 16:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67643A92C4
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B6B2248B3;
	Mon, 17 Feb 2025 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QQiBXNEl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZzpnzEOP"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E25B212B3A
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805463; cv=none; b=FVhueAXfRqlJCnxV1wQPgDrAH89OwMXzNhqa9aW+JDU9T/94zEQN89bj62YTZkVVocOl7rC4ikdgTzR1bbgJnr3Ed3S8lNGXNNilfV5UkPIWZN0PDNgNx4l+hIYDTpUkYZe36P57vjWmEnKm3sYGQ0GEmV6YkQWNXvW1Fa/7T3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805463; c=relaxed/simple;
	bh=QH4CLyvUtj2myCiL+AGIL8zhxAUpphhLYy3L4Q56YrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdoVCWVuiwPYf1lHLDYkYNDGajwW2czr9oOHtqBcw+YGWIL6Q6y84qzjw4g85TonvgcpNYaGy/08VUatUaIFpZTD1VqXOCcvKj5FQn/+NTTeNiz3sH9w4XCH72OSMl0qAdSXQAuFskPWPL+LVdja7v2OlRyM7NgRYMqcR99duXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QQiBXNEl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZzpnzEOP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Feb 2025 16:17:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739805460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXz+1xfA/nUs8zoxifiPbndHLW+oFSXvL5m2c2Ir/W8=;
	b=QQiBXNElSxw0/N7hWEIE9VvA6tb140yosfDpuj7XKhyOQsuwH7mAXVMSHwNTOxrazHwpM3
	0GPVRTsvAd2R5C+2UuqaxSICW7NC1sSR399EWNJwmiFfQUSxd3fZVhIx5Tr2QpLVIAK0qw
	lulZBR+zk5wNeQ+w0MlHh5ZGMvgFVqPTaHgpcZWo1CpOe9XqLYYqLCVD9mBk3qlP5md5eC
	dqo9zUDdp8r/UtsJs9C6c1TS2g62zrMA/bqy2vt4oAbZKa2ADiZjjNTKr9gkiz7qhtPi+k
	xQmtcY4k2wLdOXiXw7BOuLsESGGgpaJpn3HPtPeCFh6lEsFZ9219FXOHJj3QwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739805460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXz+1xfA/nUs8zoxifiPbndHLW+oFSXvL5m2c2Ir/W8=;
	b=ZzpnzEOPGoGR0ACmokT03YTcyfQ49K/cI01XRDwjOrgKXZUzYJMZvLbaU1FRrKdJO+RTrS
	wT0f84gmDiX8cRBQ==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v8 3/6] locking/local_lock: Introduce
 localtry_lock_t
Message-ID: <20250217151738.KQeT4994@linutronix.de>
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
 <20250213033556.9534-4-alexei.starovoitov@gmail.com>
 <efc30cf9-8351-4889-8245-cc4a6893ebf4@suse.cz>
 <CAADnVQKaTg1zxCbX9Kum4ZmcvLkxQJOyDLV8zdUcQWUyOb4Q4A@mail.gmail.com>
 <69dd9d1b-0a8e-4e39-b37a-20f60d0928b6@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69dd9d1b-0a8e-4e39-b37a-20f60d0928b6@suse.cz>

On 2025-02-14 19:48:57 [+0100], Vlastimil Babka wrote:
> > Since respin is needed, I can fold the above fix/feature and
> > push it into a branch with stable sha-s that we both can
> > use as a base ?
> 
> I doubt sheaves will be included in 6.15 so it's fine enough for me if you
> fold this and perhaps order the result as patch 1?
> 
> > Or you can push just this one patch into a stable branch and I can pull it
> > and apply the rest on top.
> 
> Ideally we'd have PeterZ blessing before we get to stable commit id's...

Yes. As noted in the other thread, I'm all fine with the propose
changes.

> Thanks.

Sebastian

