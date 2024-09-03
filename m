Return-Path: <bpf+bounces-38785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FA296A471
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332D41F24A95
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3913C18BC21;
	Tue,  3 Sep 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlgHmer5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851918BBAD;
	Tue,  3 Sep 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381172; cv=none; b=Wpm7qDq64s6avfeFJkn48m21XBiWLNnXL/7qbbtVzHDcPGfkyrTSIlIUkWRUNL8LbcwPq4rx/uu/dYCp3O1cDsJOvnxMS9bMp40dYAc7/YbweB0Sz6R5D6cFmbKemwW+WXTXrlnByhUltne25sFxqsm93Mi4l+vuE/gsV2qcF4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381172; c=relaxed/simple;
	bh=/vWt0seM/bqrbRZPwPwirpLCbfrjQFufofH1X6LBpKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V6ZTX2ltvTo2X0H5NHlDr4J/beLg6RylUmCysA+XOkqVppA2eWwT41pbl8qNjnF6OusfqnWcZ8M5P5ddaFzTJWZ50xflBsaNcPqycNFBiOouB3JOeEVIHwj6F2LnGFGiw2dLZS73V2Pq3ugbbHVDcKudytfsRiHv3Sq5czRJnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlgHmer5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2544DC4CECA;
	Tue,  3 Sep 2024 16:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381172;
	bh=/vWt0seM/bqrbRZPwPwirpLCbfrjQFufofH1X6LBpKA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=MlgHmer59WevTW29Svy/Nc25xmYiQp7/W4fLvOcqyqhWh9RPV+gsbPSSpZc3P2MKF
	 CDwzegX+LusqcBvDjwfAwPN+CZepsCLJhHca+S/vbxyGdeHKQZ/G/YdtkDG5gFwvXs
	 rA39BVZpdujcSLIARDy6bEkVjEamSKK+cYnUQp03w2SU0DWQkC0lZoqPCWURLvzkEO
	 Suiew4UF81AbrKlrXzjew3pT99ks5Gy/fIsLYPSctHwxLI1H8jJEq9Oq+Q5FxQE2Wg
	 JeALRSgQEojkydd9rb5hmJFdDdOSpWlNvNWa9G+D8LNYtggiveoRNqI9hqUJCvyEbt
	 G265oMvWojDsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BE973CE1D36; Tue,  3 Sep 2024 09:32:51 -0700 (PDT)
Date: Tue, 3 Sep 2024 09:32:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH rcu 0/11] Add light-weight readers for SRCU
Message-ID: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
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

This series provides light-weight readers for SRCU.  This lightness
is selected by the caller by using the new srcu_read_lock_lite() and
srcu_read_unlock_lite() flavors instead of the usual srcu_read_lock() and
srcu_read_unlock() flavors.  Although this passes significant rcutorture
testing, this should still be considered to be experimental.

There are a few restrictions:  (1) If srcu_read_lock_lite() is called
on a given srcu_struct structure, then no other flavor may be used on
that srcu_struct structure, before, during, or after.  (2) The _lite()
readers may only be invoked from regions of code where RCU is watching
(as in those regions in which rcu_is_watching() returns true).  (3)
There is no auto-expediting for srcu_struct structures that have
been passed to _lite() readers.  (4) SRCU grace periods for _lite()
srcu_struct structures invoke synchronize_rcu() at least twice, thus
having longer latencies than their non-_lite() counterparts.  (5) Even
with synchronize_srcu_expedited(), the resulting SRCU grace period
will invoke synchronize_rcu() at least twice, as opposed to invoking
the IPI-happy synchronize_rcu_expedited() function.  (6)  Just as with
srcu_read_lock() and srcu_read_unlock(), the srcu_read_lock_lite() and
srcu_read_unlock_lite() functions may not (repeat, *not*) be invoked
from NMI handlers (that is what the _nmisafe() interface are for).
Although one could imagine readers that were both _lite() and _nmisafe(),
one might also imagine that the read-modify-write atomic operations that
are needed by any NMI-safe SRCU read marker would make this unhelpful
from a performance perspective.

All that said, the patches in this series are as follows:

1.	Rename srcu_might_be_idle() to srcu_should_expedite().

2.	Introduce srcu_gp_is_expedited() helper function.

3.	Renaming in preparation for additional reader flavor.

4.	Bit manipulation changes for additional reader flavor.

5.	Standardize srcu_data pointers to "sdp" and similar.

6.	Convert srcu_data ->srcu_reader_flavor to bit field.

7.	Add srcu_read_lock_lite() and srcu_read_unlock_lite().

8.	rcutorture: Expand RCUTORTURE_RDR_MASK_[12] to eight bits.

9.	rcutorture: Add reader_flavor parameter for SRCU readers.

10.	rcutorture: Add srcu_read_lock_lite() support to
	rcutorture.reader_flavor.

11.	refscale: Add srcu_read_lock_lite() support using "srcu-lite".

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |    4 
 b/Documentation/admin-guide/kernel-parameters.txt |    8 +
 b/include/linux/srcu.h                            |   21 +-
 b/include/linux/srcutree.h                        |    2 
 b/kernel/rcu/rcutorture.c                         |   28 +--
 b/kernel/rcu/refscale.c                           |   54 +++++--
 b/kernel/rcu/srcutree.c                           |   16 +-
 include/linux/srcu.h                              |   86 +++++++++--
 include/linux/srcutree.h                          |    5 
 kernel/rcu/rcutorture.c                           |   37 +++-
 kernel/rcu/srcutree.c                             |  168 +++++++++++++++-------
 11 files changed, 308 insertions(+), 121 deletions(-)

