Return-Path: <bpf+bounces-50940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60757A2E830
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1F03AA188
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB381C4A17;
	Mon, 10 Feb 2025 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qqagFlWp"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB661C54BE;
	Mon, 10 Feb 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180967; cv=none; b=MHHKkUtxCpB69ONjz3PVG0dS2AjXZC/B+oEfy5cQlRfLLoxq4nt5S5I1HhN59tWIbSmhgGh0GnLBZ01jmvi9yeT1jjAOjMGCjzIVL8a5zc4rvbknYXIaBLM6k9VpNLRXoBqVk4uSebxKKE8hgOvINBRTSgR6kcTm8w50hDyCwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180967; c=relaxed/simple;
	bh=IYo7mb1ZykaJJPoWxh4tWYrTUM39JJlinSAZCQsZuk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBfwQ3tJXlBUBRjzUjojIYXHfrf5Vrk0sZq0AtTbeVcT7t3jXKNx9Osb/RErqLto/DW7qxGo6Xyn65wRzKU01DnbvQmsDFoZAkJGOVHeBFuAD/a4x8RMWCFHxSc08xRQ9v07/VLJQ375H6mbdB0p3EMSTk6BzseGdbbP5/uN8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qqagFlWp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ytub/ABhcHAGBMlswmK9bBHTCNc+843SkpYmie3uZSU=; b=qqagFlWpGiC7s1kMia0gIKijlN
	degAWsQOLPxd5BTt2tcdwc0UY/0zj07lzu01pCW+NCaCtjbVN/uByyftaO1rGaB5j+2Di6akbxPa8
	y6ObBM0qhYBwdCpZtp3d45MsCEqfnytyYcr+OWbhQewqc+7R/OCRU+WHfzmUz0Au3bmCo3qy3vgTD
	V4aRyy5iVb7SodDLRcA+TzWpI0nVODXviPCYN8M/AZ3aPYaq35gtsrcPiKXTZBlJwiIQ5ypPG/VME
	kQdN5oIqwi2SK+R8DUF1SgRgfWMlZKuimcwiJTNbd/KUvIwIOtYtrK6zLrlpRQ6xc2HgqJvxU0EFl
	YvbM9dpg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thQPn-0000000FTCe-16Mo;
	Mon, 10 Feb 2025 09:49:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 401B1300318; Mon, 10 Feb 2025 10:49:18 +0100 (CET)
Date: Mon, 10 Feb 2025 10:49:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 00/26] Resilient Queued Spin Lock
Message-ID: <20250210094918.GF10324@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>

On Thu, Feb 06, 2025 at 02:54:08AM -0800, Kumar Kartikeya Dwivedi wrote:
> Changelog:
> ----------
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20250107140004.2732830-1-memxor@gmail.com
> 
>  * Address nits from Waiman and Peter
>  * Fix arm64 WFE bug pointed out by Peter.

What's the state of that smp_cond_relaxed_timeout() patch-set? That
still seems like what you're needing, right?

