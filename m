Return-Path: <bpf+bounces-70710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C1FBCB44B
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 02:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBCD405B21
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 00:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDC342A96;
	Fri, 10 Oct 2025 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bkxkom8b"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07091DDC33
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760055696; cv=none; b=m+8Fx1ZEjOfvAl+i1GBSmp5kBoivaD5P0rDMl93X8GQxVhZOfZGbuR2HxUh5N0hzkMErSN0vDK0kZnqOVnHuOL2gu+LY2Vc0QrhZE2OxXK+bgjDOwxK/vCEc7oy/H/w58vPHVJ332iRaV6bWcT8b7gYzrZWVYVEXNNplBI5KYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760055696; c=relaxed/simple;
	bh=8Y3mVxEXWR1LT6E+MErPKslx1iIcN2FF/RYS7Qc529Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9VARTh+WSswdrzNTQNLwuT0qZjdOBxnpbZL0Xti7bdvcOn2dkzm0vxjUL6iK7pxQwmLKfi3IxisE/GI+YxC2TCaNnmK6IhtsUrSXEFYtcds4CuVmK3ls0qVfnOs+QUh98oFwQ8e7mCBDzoEsUCqeG3M4YARNy35JBB/0+wDDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bkxkom8b; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 9 Oct 2025 17:21:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760055689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53IIJXz4kiDUDquOGivJp59aqbqrO9dNAnwJmnGmeLs=;
	b=bkxkom8bhgnZML2NkiP832fn0KUUwfoY07GsDJua8CWMHrWid4nV0vq3EbcPMCY/ofpytN
	KtnuuJlbothw9oB6NCQj7rXFvqVXlTiIMg5EDz97qSJ3BkoMN1wGTLRjzoafoaIxIRt1DX
	krwjrK6+RhIcbm+zZ5w//yJ/k9hImVM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next/net 0/6] bpf: Allow opt-out from
 sk->sk_prot->memory_allocated.
Message-ID: <fw2psg37236be6taswr7plwt7qdjizza66pdebznojygxhw33n@i6edgcmyw4rj>
References: <20251007001120.2661442-1-kuniyu@google.com>
 <49b4dd53-68bd-4773-8c5c-10048f970f4a@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49b4dd53-68bd-4773-8c5c-10048f970f4a@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 09, 2025 at 11:28:05AM -0700, Martin KaFai Lau wrote:
> On 10/6/25 5:07 PM, Kuniyuki Iwashima wrote:
> > This series allows opting out of the global per-protocol memory
> > accounting if socket is configured as such by sysctl or BPF prog.
> > 
> > This series is v11 of the series below [0], but I start as a new series
> > because the changes now fall in net and bpf subsystems only.
> 
> netdev reviewers, please take a look and ack if it looks good.
> 
> Shakeel, you have reviewed the earlier revision, please take a look.

The series look good to me.

