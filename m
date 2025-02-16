Return-Path: <bpf+bounces-51699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC74A3760B
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 17:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC87C3AC594
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2139C19CC28;
	Sun, 16 Feb 2025 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7yboXjw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3D450FE;
	Sun, 16 Feb 2025 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724859; cv=none; b=ER2+IeFRxy83jAtinHSAuEDTr5I3oHclvyNTLwEYfYUFdGQQ5u5fTu3VbYnCnjT80EZZg5FHXmSvGlPS/rv8UoagPtCjkGpRqlMSppLelV6RFL3o0CveJrS4rIwckeYQ3mL26cY2bJLz7xmRFk7DNswjSvlbwSiEJAjSr9pcQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724859; c=relaxed/simple;
	bh=pTlZ14AnOX+J+ZoO/hKr1nC/IBpBU/25GV1jkqIE8A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXsk6LKOv4hZXCd7rQvL2XxrsCn48cE8EbuUys9YDXuNCfFlAoJwuXep40FERK+UudXMw7yZ3kW0jHur5ZBz/jsvQU0zPdhqJ4vDJTTo64IMzPHRl9nMGLzUpnVNEHgeEDmtA7hyMNwUhjmbf0jDlZPHhNXLmAFRhrvuLxHwx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7yboXjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6966C4CEDD;
	Sun, 16 Feb 2025 16:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739724858;
	bh=pTlZ14AnOX+J+ZoO/hKr1nC/IBpBU/25GV1jkqIE8A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7yboXjw4BMW5zsi0GF/0TZR65srPHVJr2yte36QBHktyNm/thmCjpyMV1iAH13/b
	 evp5Qm4CARBJsxTWVCnrXBTEWlKADDmt/DluCFOqYg4O9tvOzwP4KXxwB3e545H81E
	 lTF7S4h7BZmZilqwgtHEyLqGhWXfxsKxoN8S3vqM9TFRyWaG2Q8PiEHAlTdF7pg16z
	 yrVxYQNgHB3Kb0ss1IK0Q3g1Bd7iCNRFs0HIkX20JyIpuvCT0dNiYiX1LrKygS/wGN
	 6CbY6r1AQFeFfa0A1qCIsBVhAINd6ZOTDngbl5a0rWEn19IhMFdEcIMemYcQ8imURy
	 8ibGffRUK8HYg==
Date: Sun, 16 Feb 2025 06:54:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v12 sched_ext/for-6.15] sched_ext: split global idle
 cpumask into per-NUMA cpumasks
Message-ID: <Z7IYOHDLVUTiYuI5@slm.duckdns.org>
References: <20250214194134.658939-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214194134.658939-1-arighi@nvidia.com>

On Fri, Feb 14, 2025 at 08:39:59PM +0100, Andrea Righi wrote:
> = Overview =
> 
> As discussed during the sched_ext office hours, using a global cpumask to
> keep track of the idle CPUs can be inefficient and it may not scale really
> well on large NUMA systems.
> 
> Therefore, split the idle cpumask into multiple per-NUMA node cpumasks to
> improve scalability and performance on such large systems.
> 
> Scalability issues seem to be more noticeable on Intel Sapphire Rapids
> dual-socket architectures.

Applied 1-7 to sched_ext/for-6.15.

Thanks.

-- 
tejun

