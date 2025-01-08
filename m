Return-Path: <bpf+bounces-48242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CADAAA05C24
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 13:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9A3165F9C
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2377F1FBC8D;
	Wed,  8 Jan 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s8wLm6Z+"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CCA1F9F5A
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340834; cv=none; b=jw/8LhWrdur/+w22+JHVe5WREu9bf/yQX6gUreSXRrh7ZrtLBlryT73UghrB1ViIJPhnBcB4tVrxpjQ8RViTLtPH/4DBwjx7/YyyEYWSEgCtWjCWXXc2hq6dqHzLzFRWpoOAomv4mku8m7uyOO4Z6ymB250yPbAWPyMYWko+99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340834; c=relaxed/simple;
	bh=0VjtVFI6xqqCipkCiidkXWW95elv1wFlrDP2v1i8YOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS2Yb6+zr8dwBiKvx0Z3+j9/UiTCp1SHOkAbxz/oNF4TBbiA35B5yUGvqU5Ki9vv6iDmBAJY81OO/5gYaUjnmBKqOdvHtyxoVZaZfMpQvfGa808RaonS88F472J3WAQHbYCbCkuOKcz1veNbdJBdvR4XBBnJedYpPs7f+ehfLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s8wLm6Z+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fxpWY+Ce2Ih6icbYJ0d0ZobEBPpTKT8HK1hooWW0OAU=; b=s8wLm6Z+xC7Iko1B4iCDXOrusb
	cFxNpRvYdRfWY7KD/Dbd51giHJ/CmkQwNKeO6mUbXZctb7/6iOeNEX4k4NI2T0kp/XD80C08GSw7f
	mGi84JHljIJGeuki4AWuXHGJewmjf1d3IcjSZoBF8Uw8aPwaJ0tIspQREAiFxI2Cy9Wg4FlX6xRKs
	NuJZrOmvfgKVPwyOu7UFRFnc5VDKLGLVpb/xhv4M6OHZIwjJHVytUU9brmOT8SHvzQCAFI7hP0PEj
	wxCuD5CldFl2X/B+ZRZ6aFy8dcpkUkAc55yimPtohwkZgNCU2qTshPqAAnZSY5gGWTdF588SevPgK
	ilR6wEHw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVVWL-0000000H6Aq-30D9;
	Wed, 08 Jan 2025 12:51:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBCD33005D6; Wed,  8 Jan 2025 13:50:48 +0100 (CET)
Date: Wed, 8 Jan 2025 13:50:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jann Horn <jannh@google.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v2] bpf: Move out synchronize_rcu_tasks_trace
 from mutex CS
Message-ID: <20250108125048.GG23315@noisy.programming.kicks-ass.net>
References: <20250104013946.1111785-1-pulehui@huaweicloud.com>
 <Z35gz9q8z7LBNssS@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z35gz9q8z7LBNssS@krava>

On Wed, Jan 08, 2025 at 12:26:07PM +0100, Jiri Olsa wrote:
> On Sat, Jan 04, 2025 at 01:39:46AM +0000, Pu Lehui wrote:
> > From: Pu Lehui <pulehui@huawei.com>
> > 
> > Commit ef1b808e3b7c ("bpf: Fix UAF via mismatching bpf_prog/attachment
> > RCU flavors") resolved a possible UAF issue in uprobes that attach
> > non-sleepable bpf prog by explicitly waiting for a tasks-trace-RCU grace
> > period. But, in the current implementation, synchronize_rcu_tasks_trace
> > is included within the mutex critical section, which increases the
> > length of the critical section and may affect performance. So let's move
> > out synchronize_rcu_tasks_trace from mutex CS.
> 
> lgtm, adding peter

Yeah, I don't immediately see anything funny there either. Carry on.

