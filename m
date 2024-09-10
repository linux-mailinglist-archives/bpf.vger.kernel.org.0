Return-Path: <bpf+bounces-39426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D52B1972DE7
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5C0285FA7
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C23C18A928;
	Tue, 10 Sep 2024 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rRb2lPSo"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B935446444;
	Tue, 10 Sep 2024 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961049; cv=none; b=m6lvPIDNGMF0qNnbXNhO6pdBXtLQT5NX0ucF+dp17DmR1agXfBfkq3b0o7YVp1vP+Wn65VetIJhxV9vHhWR4MbsnqnlEHoTHtKZC7/zEWYaQxN9BpxyWUNSzDhf671a5TZvH8S9SwkWI0sxGSuzPX/YFKkodG0NAcSPsm1TnGn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961049; c=relaxed/simple;
	bh=+iG+n0TJjUKSUiUDtlfOu602G5ENawr41nEnLynMi2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMsikxv1rTgtpqUEHoKaV8q4QDYA6w3A/1Li0h2NNmuqkJXooUTQAow0WZX2Yki3g96aCTooNa0V8njlhcbpO2P+L4lRWZehJgkSCAAkf9SOMKG2LI+mg6U/dFiHKdQI09U0y+WTNf5juSWuAT2f5O5lSO1fBIUeEs7lt3UKyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rRb2lPSo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NoszZ3ibiLQWoHRI5jcoRagamakk8RTbfw90akHsUd0=; b=rRb2lPSoJlJox+ik7ArJj4EcfK
	k3Ta+7gTQygItsUR/feX384V5FOcNTkxrVC3Bwcrwb++18RNFGBiTkiAZXz2y2h/20zJrimH4DtkT
	dcabaJveVkGFlM15/uXBp4LK86iOadZGApKn3nSDboGXZ35DXfH13V3KGWizrN+g97PZumaV04E13
	K3Rbpy2YzZZ9h5eWdj03auZ8uPXBTBJELfZYgOxAfA5ooprP5N8oExEDpeS+dRK2aePw/jxw2f6w+
	YGVHThmvoB22M4rku65BRMeJeUhuwXtjIt/qGrgypZkyqN4G5pZEgitsbIz24y2LYNbeFR4y3TykY
	gVSOQOvA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snxJM-00000008LFH-18z2;
	Tue, 10 Sep 2024 09:37:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 492A2300321; Tue, 10 Sep 2024 11:37:23 +0200 (CEST)
Date: Tue, 10 Sep 2024 11:37:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-tip-commits@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>, bpf <bpf@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [tip: perf/core] uprobes: switch to RCU Tasks Trace flavor for
 better performance
Message-ID: <20240910093723.GH15400@noisy.programming.kicks-ass.net>
References: <20240903174603.3554182-9-andrii@kernel.org>
 <172554860322.2215.10385397228202759078.tip-bot2@tip-bot2>
 <CAEf4BzbytuSpro9wT7cZY2Qf98zpDz+V0hTwwKP3ZDa866s1tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbytuSpro9wT7cZY2Qf98zpDz+V0hTwwKP3ZDa866s1tA@mail.gmail.com>

On Sun, Sep 08, 2024 at 06:11:04PM -0700, Andrii Nakryiko wrote:
> On Thu, Sep 5, 2024 at 8:03 AM tip-bot2 for Andrii Nakryiko
> <tip-bot2@linutronix.de> wrote:
> >
> > The following commit has been merged into the perf/core branch of tip:
> >
> > Commit-ID:     c4d4569c41f9cda745cfd1d8089ea3d3526bafe5
> > Gitweb:        https://git.kernel.org/tip/c4d4569c41f9cda745cfd1d8089ea3d3526bafe5
> > Author:        Andrii Nakryiko <andrii@kernel.org>
> > AuthorDate:    Tue, 03 Sep 2024 10:46:03 -07:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Thu, 05 Sep 2024 16:56:15 +02:00
> >
> 
> Hm... This commit landed in perf/core, but is gone now (the rest of
> patches is still there). Any idea what happened?

IIRC Ingo popped it because he was seeing build failures with it. Ingo,
I thought you would share the build fail so Andrii could deal with it?

