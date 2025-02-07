Return-Path: <bpf+bounces-50813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6B3A2D02E
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6FD188D90A
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D543C1BC062;
	Fri,  7 Feb 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/D4WOwR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0F19CC0C;
	Fri,  7 Feb 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965392; cv=none; b=G33nBtBBJubsUBdNl+IyTY4Gscrd7EovlvCdEjFDR/wq5qgkU+/E7vb4jK+AivT0AMOz+FMsbBLG8Vq6wlNWgsJ8xhsbSt3qo0vTQVGyJB5M7zcfV6duBtfNK8irIST4hfS3QF0G59kNBes9j3Yo9ohLNZH1Z9+zDNXcF/Xqj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965392; c=relaxed/simple;
	bh=w19YHssixYy4w51cERXldSSzi+VNKm3vBun+LjkMS+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9GzcuM37EAHsMrTVCWeCFJBwe5E5gVGeoKTYaX6eRuHNkkOx88wq5hr922raeYiWceEiaZI4okwqiqcUpDyON90D5olto6RpDzZJS3yGbhj1rs291Pb1lWm2ZwcMoqSFKzxvj0O3HgFoDiYVXOkyeytH0NtnnhAIF6upvJoFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/D4WOwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32E6C4CED1;
	Fri,  7 Feb 2025 21:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965391;
	bh=w19YHssixYy4w51cERXldSSzi+VNKm3vBun+LjkMS+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/D4WOwRSydkDlTy7Yf8MQFtLbkBSqy+in986fJVw9U0BX0Z0EAhOpvgt+3zHSIXt
	 I2OE1tjl/qoP3ov3wzw49gQ33+2CdQmytVD1KJ42kCIMHOEZsDhyeDmd+0J1PqTEt9
	 3Va0NHmxPlp8VT83OYAaho5pe1G8xx+5Nto7mNq4BrVeAbktbv/0lBXv5X1iNJiGeC
	 +sF7+HAFQ3Uxt027Ck9e+wxNYp2a1OX2VOlxsfPWWiIVtU4sq7ci68kggQ5aaNzWKW
	 kkDNXA77Fr9T1cQCCUvfgGWIJUu9IrmaoSlbBI8r1axV88a+4iPYmdKNdta6uMoG2a
	 kvbwizC38WPdA==
Date: Fri, 7 Feb 2025 11:56:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 2/6] sched/topology: Introduce for_each_numa_node()
 iterator
Message-ID: <Z6aBjoWa3CGvp68U@slm.duckdns.org>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-3-arighi@nvidia.com>
 <Z6Z_S6UDg80LUQEi@slm.duckdns.org>
 <Z6aBRs3STxI7DzYk@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6aBRs3STxI7DzYk@gpd3>

On Fri, Feb 07, 2025 at 10:55:18PM +0100, Andrea Righi wrote:
> How about for_each_node_state_by_dist()? It's essentialy a variant of
> for_each_node_state(), as it also accepts a state, with the only difference
> that node IDs are returned in increasing distance order.

Sounds fine by me. Yury?

Thanks.

-- 
tejun

