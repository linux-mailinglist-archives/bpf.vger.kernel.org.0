Return-Path: <bpf+bounces-39428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A16972F39
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0DEB27782
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F308313AD09;
	Tue, 10 Sep 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CR998XMH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CFEEC9;
	Tue, 10 Sep 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961752; cv=none; b=p5QhvFYo14QoauMdAwrQsGERIjBYn8u2iKg0I3L6092pzoUwGg7plLtTZ0d+Pqb5Ftk0UQstALhg75F8pwEpvx/SX+bN5SCuey7IHGj5qPeKf/KVJcbp5uFk8MN/hyqhn/hF4b+Ot4/mkck0SjBruGXybTcbiSKe8GFi6/gazR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961752; c=relaxed/simple;
	bh=lupSH6x0eVPPc8WQr7Gn4FRJWeqYOhgQHJaEvPAegDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRxONc8ashmh3C+EAO0R5QyMohaZ+8l+NH4I5z7XN3QXq4Km9YSdNiuD1Bp/M/2Gfc6U1UsZ2H8/cnISpU0V9d2evgH64nb8ETlVKSA6fdNPmArRIhgBDm3BwbrhENMNNibCnwBETzkBdczFCHVT66GX/Cow4Dja7sv6q/Elyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CR998XMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F069EC4CEC3;
	Tue, 10 Sep 2024 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961752;
	bh=lupSH6x0eVPPc8WQr7Gn4FRJWeqYOhgQHJaEvPAegDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CR998XMH+6WfGtsfXtqm76USuVSnRoud04L9dOcP3ODRj7irp/R+oalI2m/VpUahv
	 xK7E10+WFP3I1g2wqCkjhDxtS+bcGVx9C0At3BT4D+ZUnkqGpBZTXyGC4e0JhPxUcm
	 ucNYys1KQ+bTyxXa9bIAuBLNmPTeDXWz7ecxMKWw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xi Wang <xii@google.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 177/375] perf lock contention: Fix spinlock and rwlock accounting
Date: Tue, 10 Sep 2024 11:29:34 +0200
Message-ID: <20240910092628.425618468@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 287bd5cf06e0f2c02293ce942777ad1f18059ed3 ]

The spinlock and rwlock use a single-element per-cpu array to track
current locks due to performance reason.  But this means the key is
always available and it cannot simply account lock stats in the array
because some of them are invalid.

In fact, the contention_end() program in the BPF invalidates the entry
by setting the 'lock' value to 0 instead of deleting the entry for the
hashmap.  So it should skip entries with the lock value of 0 in the
account_end_timestamp().

Otherwise, it'd have spurious high contention on an idle machine:

  $ sudo perf lock con -ab -Y spinlock sleep 3
   contended   total wait     max wait     avg wait         type   caller

           8      4.72 s       1.84 s     590.46 ms     spinlock   rcu_core+0xc7
           8      1.87 s       1.87 s     233.48 ms     spinlock   process_one_work+0x1b5
           2      1.87 s       1.87 s     933.92 ms     spinlock   worker_thread+0x1a2
           3      1.81 s       1.81 s     603.93 ms     spinlock   tmigr_update_events+0x13c
           2      1.72 s       1.72 s     861.98 ms     spinlock   tick_do_update_jiffies64+0x25
           6     42.48 us     13.02 us      7.08 us     spinlock   futex_q_lock+0x2a
           1     13.03 us     13.03 us     13.03 us     spinlock   futex_wake+0xce
           1     11.61 us     11.61 us     11.61 us     spinlock   rcu_core+0xc7

I don't believe it has contention on a spinlock longer than 1 second.
After this change, it only reports some small contentions.

  $ sudo perf lock con -ab -Y spinlock sleep 3
   contended   total wait     max wait     avg wait         type   caller

           4    133.51 us     43.29 us     33.38 us     spinlock   tick_do_update_jiffies64+0x25
           4     69.06 us     31.82 us     17.27 us     spinlock   process_one_work+0x1b5
           2     50.66 us     25.77 us     25.33 us     spinlock   rcu_core+0xc7
           1     28.45 us     28.45 us     28.45 us     spinlock   rcu_core+0xc7
           1     24.77 us     24.77 us     24.77 us     spinlock   tmigr_update_events+0x13c
           1     23.34 us     23.34 us     23.34 us     spinlock   raw_spin_rq_lock_nested+0x15

Fixes: b5711042a1c8 ("perf lock contention: Use per-cpu array map for spinlocks")
Reported-by: Xi Wang <xii@google.com>
Cc: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20240828052953.1445862-1-namhyung@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index b4cb3fe5cc25..bc4e92c0c08b 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -286,6 +286,9 @@ static void account_end_timestamp(struct lock_contention *con)
 			goto next;
 
 		for (int i = 0; i < total_cpus; i++) {
+			if (cpu_data[i].lock == 0)
+				continue;
+
 			update_lock_stat(stat_fd, -1, end_ts, aggr_mode,
 					 &cpu_data[i]);
 		}
-- 
2.43.0




