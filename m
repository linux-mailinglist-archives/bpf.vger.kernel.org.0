Return-Path: <bpf+bounces-49097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369F9A14301
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D80165491
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE52236A62;
	Thu, 16 Jan 2025 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWf1tLaZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209791993B2;
	Thu, 16 Jan 2025 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058867; cv=none; b=b9m4GXiGTsLg/E9DTrAVro9DiXfe8GXXRKpZiamnYGQV/M8ew1yg9kw1fLBrZHufaMlYReN7uWJmQ7kxTb84b8XxTLgk79gc4R4jDmcRQ3onCXhrvzzjL2c5Plo50jUsqoaX1TVnghL0Ad6TLYvVRV6ntvXpY+S6X94tq4gM36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058867; c=relaxed/simple;
	bh=IujXZ/V4JeCkW+cP57v01+Vzkrp2BtP99eLZJ8FICcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F2jvScpuaQPCXZGev04bkC8cBsSi3kwmKflZ7e3/2MhNG5HnnvIDWTPx+S44DInleqnRWMva4Tcy6cBw8wLfmc+9hzWnmkGd+YI+tyxG3IqGQ+LuR5oaQdk3DMRM0xmgmCvWpViLPbUIW3jQusUk24dyv5LZ/m+UvKolfIl7R6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWf1tLaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0681C4CED6;
	Thu, 16 Jan 2025 20:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058866;
	bh=IujXZ/V4JeCkW+cP57v01+Vzkrp2BtP99eLZJ8FICcU=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=GWf1tLaZOEAWvqBJXa9VEc+ZCbo3V8bBuNNybdf1brdjtrdRoZRhz6Uhwvn4Bql3G
	 /SoUWBo3YUaKn522QuELtPO63TUDzVB812cMVZQkGceAuyfVFESj7QJi7cfz4hJX4T
	 Zdm55elNY9Hld2fkW5kmC6OIC2IW+Qr4P9ldc6CsElHjTxJjUTfJFxyb9uoxdiFKIR
	 cP8ssre9hG/17hICGZQuU/pOesyBsi6KExxBIDwxNgflm9+jTmsh5PhwcQ+H5EsB0D
	 FahDbMRcNkVmGqZ1jhz4IsUfMGqYhk0CfEntetI09bQtyIQX5aL9bKxDxGj571MA6X
	 MC2YSvAOe8u2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5B811CE13C4; Thu, 16 Jan 2025 12:21:06 -0800 (PST)
Date: Thu, 16 Jan 2025 12:21:06 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	ast@kernel.org, andrii@kernel.org, peterz@infradead.org,
	kent.overstreet@linux.dev, bpf@vger.kernel.org
Subject: [PATCH rcu 0/17] SRCU updates, including SRCU-fast
Message-ID: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

The series is as follows:

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
 include/linux/srcu.h                                         |   66 ++-
 include/linux/srcutiny.h                                     |   25 +
 include/linux/srcutree.h                                     |   77 +++
 kernel/rcu/rcutorture.c                                      |    9 
 kernel/rcu/srcutree.c                                        |  233 +++++------
 14 files changed, 332 insertions(+), 148 deletions(-)

