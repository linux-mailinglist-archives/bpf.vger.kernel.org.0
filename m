Return-Path: <bpf+bounces-50138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5576BA23448
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58D37A2DE7
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EC31EE00E;
	Thu, 30 Jan 2025 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN6ss70A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75798137C35;
	Thu, 30 Jan 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263794; cv=none; b=BJR7z8JLRhE1BjXA3YqeHs+eEDJXvCaWuaBi4924KuJhZUpwf4yV3rjFc5HkzCeUoRENsguXPzOEw2Nxc8tWSQmul+hQsR7uHCQgpeOKV0VfFk4vBAcupaJB9IAp95Jd1aQZGXrR9398gm2ZTdwqvr27fr/sBU4v715NF0Gxo0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263794; c=relaxed/simple;
	bh=HomH98WWPyye3CVTK7Pojf8nPvZKHhCCal76Jr2J8S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbB7qqH+9fx+QaVw577GGM8CwiZxj3ExzuCEUNR2w5aj0ioyiUob8ilpTkIztOkGPZE4IgudCgwvCBP6HOWoTLgD/svXliZlhbxBmaVHMrxWdvannDyJBD5kUB1O/a1VL++x6iMFwNcY+PepNttUKXcuTfVCeIvHZ5ulcmAVI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN6ss70A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A1AC4CED3;
	Thu, 30 Jan 2025 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263793;
	bh=HomH98WWPyye3CVTK7Pojf8nPvZKHhCCal76Jr2J8S0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dN6ss70AjzJhUGDvcOi7D99RZAi9mcL2KOJQSjw9fMYbgsFPR88KeiQB7X6b2TzKu
	 +jv1TpoXGGqMOPqQy1hbNyFIW+QKiApolDtVovdzFBz1jyf8b03uiid/zzu7un8fc9
	 K7hrClKxaLbtQjDWEPs7iJKPJi1aHdaU12GscRNpf1IY2gowSc4wxIC/iY70lhqEIX
	 1e99T3Alqq8pmgjO+yjO4WGuriLRJRGZXeIv5EVj8hzhW5zu61O1RBcS8dkAiAkR3l
	 Dhonc/mx3gyjmylvcQNZHEZgL2GHgVA0XO9WOSuiNiZEpCHYuoy66MyRk78V79tk8/
	 AEAwImbsRylGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7331BCE37D9; Thu, 30 Jan 2025 11:03:13 -0800 (PST)
Date: Thu, 30 Jan 2025 11:03:13 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	ast@kernel.org, andrii@kernel.org, peterz@infradead.org,
	kent.overstreet@linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 0/17] SRCU updates, including SRCU-fast
Message-ID: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>

Hello!

This series contains SRCU updates, perhaps most notably the addition of
srcu_read_lock_fast() and srcu_read_unlock_fast(), which on my laptop are
about 20% faster than rcu_read_lock_trace() and rcu_read_unlock_trace().
There are of course drawbacks:

o	Lack of CPU stall warnings.
o	SRCU-fast readers permitted only where rcu_is_watching().
o	A pointer-sized return value from srcu_read_lock_fast() must
	be passed to the corresponding srcu_read_unlock_fast().
o	In the absence of readers, a synchronize_srcu() having _fast()
	readers will incur the latency of at least two normal RCU grace
	periods.
o	RCU Tasks Trace priority boosting could be easily added.
	Boosting SRCU readers is more difficult.

Whether or not this can replace RCU Tasks Trace, it should replace the
SRCU-lite API, where the only drawback is a pointer-sized return value
from srcu_read_lock_fast() compared to the int-sized return value from
srcu_read_lock_lite().  And yes, I should have thought harder before
doing that SRCU-lite...

This series is as follows:

1.	Make Tiny SRCU able to operate in preemptible kernels.

2.	Define SRCU_READ_FLAVOR_ALL in terms of symbols.

3.	Use ->srcu_gp_seq for rcutorture reader batch.

4.	Pull ->srcu_{un,}lock_count into a new srcu_ctr structure.

5.	Make SRCU readers use ->srcu_ctrs for counter selection.

6.	Make Tree SRCU updates independent of ->srcu_idx.

7.	Force synchronization for srcu_get_delay().

8.	Rename srcu_check_read_flavor_lite() to
	srcu_check_read_flavor_force().

9.	Add SRCU_READ_FLAVOR_SLOWGP to flag need for synchronize_rcu().

10.	Pull pointer-to-integer conversion into __srcu_ptr_to_ctr().

11.	Pull integer-to-pointer conversion into __srcu_ctr_to_ptr().

12.	Move SRCU Tree/Tiny definitions from srcu.h.

13.	Add SRCU-fast readers.

14.	Add ability to test srcu_read_{,un}lock_fast().

15.	Add srcu_read_lock_fast() support using "srcu-fast".

16.	Make scenario SRCU-P use srcu_read_lock_fast().

17.	Fix srcu_read_unlock_{lite,nmisafe}() kernel-doc.

18.	Document that srcu_{read_lock,down_read}() can share srcu_struct.

19.	Add srcu_down_read_fast() and srcu_up_read_fast().

20.	Make SRCU-fast also be NMI-safe.

Changes since v1:

o	Explicitly document that  srcu_{read_lock,down_read}() can share
	an srcu_struct.

o	Add srcu_down_read_fast() and srcu_up_read_fast() based on
	feedback from Andrii Nakryiko.

o	Make SRCU-fast readers NMI-safe based on feedback from Alexei
	Starovoitov.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h                                       |    3 
 b/include/linux/srcutiny.h                                   |    2 
 b/include/linux/srcutree.h                                   |   13 
 b/kernel/rcu/rcu.h                                           |    9 
 b/kernel/rcu/rcutorture.c                                    |    2 
 b/kernel/rcu/refscale.c                                      |   32 +
 b/kernel/rcu/srcutiny.c                                      |    6 
 b/kernel/rcu/srcutree.c                                      |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot |    1 
 include/linux/srcu.h                                         |  103 ++++
 include/linux/srcutiny.h                                     |   25 +
 include/linux/srcutree.h                                     |  111 ++++-
 kernel/rcu/rcutorture.c                                      |    9 
 kernel/rcu/srcutree.c                                        |  233 +++++------
 14 files changed, 392 insertions(+), 159 deletions(-)

