Return-Path: <bpf+bounces-71596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED209BF7DC2
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 904424EB14D
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3134F27C;
	Tue, 21 Oct 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iBWJ4DlF"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9A34D4FB;
	Tue, 21 Oct 2025 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067148; cv=none; b=klJWpZutBrUeh8YT8WVA2g9C5WrME8HFAEwUS9WOfjT3lzoJERy62T9yggUmn6RiEBkOJVuRNU80jOpix7tua8somVeBLqJufiUE1ThfQssqovbX5sRI4fqf/jkxOstfS7up2Si7sLmH3fEC6OvJWXc6GebVyuqnLvCkSpdCvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067148; c=relaxed/simple;
	bh=yURzac9KMzB9ZsEyg8nrlXPtNzXKKYJPZ7C2cpnL6EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5JoB2pManh3Nvvz+BA+jY7fbup00YgtoiTouEATu6LUKVanVNt+p1Rvcjz6EqDzcRrZ2NS1z8xSoLn8JHygeaYrGMlO1Wc8rfTHHDLEHBTs18pNkKnKg0rblG5Hi71a6YZdawfLYpIQORF/I97Z8Usxo3Cm2d/Md0xYrWUhtaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iBWJ4DlF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=711OZIflRvId5Y2Hiv2KpTzjypqNjJv75tCJMSUJMYg=; b=iBWJ4DlFOrW6evyRXJdF0R1xMj
	6NY1xP7tsSHBE6YzKeHCwpSR73+1Wcl/ToAIFTrjsZZILcJ2cbfpkmStQ9D+d3dKpfSKRDaAoOGNV
	6Bin2UVMRsc0dRljK99FSbOMxpHUCvw3eCMvvrtrtq64NtZiQpYk0oh0TYln7SJ+M0V4r88cRgFVs
	990H+q1eqQ4MqeXz4xsVpYuQSAAVY+i0elPZ54jdy71aOkP7tgUWmquR+oPDQxdg1hvUpGSew8WkN
	tlxmTA0aIOmeuSBF4+UyGltFD9WiH/cb1vrFbEl4PDHRwwxIJk38oIlV+9Q0AvPeWmh2BzqPC7HZw
	VcEQpvnw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBF8u-00000000tC3-17fx;
	Tue, 21 Oct 2025 16:23:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1FAF33030EB; Mon, 20 Oct 2025 14:49:50 +0200 (CEST)
Date: Mon, 20 Oct 2025 14:49:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] sched: Add a server arg to
 dl_server_update_idle_time()
Message-ID: <20251020124950.GF4067720@noisy.programming.kicks-ass.net>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-6-arighi@nvidia.com>

On Fri, Oct 17, 2025 at 11:25:52AM +0200, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Since we are adding more servers, make dl_server_update_idle_time()
> accept a server argument than a specific server.
> 
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Can you run s/rq_dl_server/dl_server/g on the thing please?


