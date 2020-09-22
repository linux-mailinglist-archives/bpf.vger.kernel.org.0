Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E9D274692
	for <lists+bpf@lfdr.de>; Tue, 22 Sep 2020 18:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgIVQZq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Sep 2020 12:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVQZn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Sep 2020 12:25:43 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C5E2395C;
        Tue, 22 Sep 2020 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600791942;
        bh=Zy3XcAZEuXN9x3ObhUD0OY7DYKY3IewXpXT4gnrZLFk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ri3+yqDmAouwXMzNVoMrn+apPOU3KeYF+QJwAGX4CFY0tK6fLjZnliX2qVuTYM+l+
         eX8iUz9BYmB0JRbdWuGpjlnMDG4T2cidrq+lSDwhddV5cH8+DpliLu8c/fngYKbGTk
         T7TCMB4MkGqM/q0BnfAYqr6ecXYK2zASoeE8ei0c=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7B79B35227BD; Tue, 22 Sep 2020 09:25:42 -0700 (PDT)
Date:   Tue, 22 Sep 2020 09:25:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     ast@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, daniel@iogearbox.net,
        jolsa@redhat.com, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [GIT PULL rcu-tasks-trace] 50x speedup for
 synchronize_rcu_tasks_trace()
Message-ID: <20200922162542.GA18664@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello, Alexei,

This pull request contains eight commits that speed up RCU Tasks Trace
grace periods by a factor of 50, fix a few race conditions exposed
by this speedup, and clean up a couple of minor issues.  These have
been exposed to 0day and -next testing, and have passed well over 1,000
hours of rcutorture testing, some of which has contained ad-hoc changes
to further increase race probabilities.  So they should be solid!
(Famous last words...)

I would normally have sent this series up through -tip, but as we
discussed, going up through the BFP and networking trees provides the
needed exposure to real-world testing of these changes.  Please note
that the first patch is already in mainline, but given identical SHA-1
commit IDs, git should have no problem figuring this out.  I will also
be retaining these commits in -rcu in order to continue exposing them
to rcutorture testing, but again the identical SHA-1 commit IDs will
make everything work out.

The fact that these commits will reside in multiple trees is of course
what motivates inclusion of the otherwise unrelated minor-issue cleanups.
Including these cleanups allows all the various trees to keep synchronized
SHA-1 commit IDs.  And so, without further ado:

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rtt-speedup.2020.09.16a

for you to fetch changes up to f747c7e15d7bc71a967a94ceda686cf2460b69e8:

  rcu-tasks: Enclose task-list scan in rcu_read_lock() (2020-09-16 16:32:38 -0700)

----------------------------------------------------------------
Paul E. McKenney (8):
      rcu-tasks: Prevent complaints of unused show_rcu_tasks_classic_gp_kthread()
      rcu-tasks: Mark variables static
      rcu-tasks: Use more aggressive polling for RCU Tasks Trace
      rcu-tasks: Selectively enable more RCU Tasks Trace IPIs
      rcu-tasks: Shorten per-grace-period sleep for RCU Tasks Trace
      rcu-tasks: Fix grace-period/unlock race in RCU Tasks Trace
      rcu-tasks: Fix low-probability task_struct leak
      rcu-tasks: Enclose task-list scan in rcu_read_lock()

 include/linux/rcupdate_trace.h |  4 +++
 kernel/rcu/tasks.h             | 55 ++++++++++++++++++++++++++++++++----------
 2 files changed, 46 insertions(+), 13 deletions(-)
