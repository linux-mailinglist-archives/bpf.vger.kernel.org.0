Return-Path: <bpf+bounces-66782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B7B3939A
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7093A7D13
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDF927B330;
	Thu, 28 Aug 2025 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gtymtKOb"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8327A927
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756361071; cv=none; b=jP+LeJFhbLJMIjkF4SncX9WKYI8bmAgv1XwcWFBMDcqNXoGdOfDno6iaJUHXNpfcveHUNXaTeCX1GxKy+I0i5Hbd7CihNhhz5JDWjN6zKCbI7dGRgWvbtkHhbmd1juU5Dp+k9svvB2bs9cPjPNmI+bLOKoCGGXHbjmLB+znBTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756361071; c=relaxed/simple;
	bh=QNQvynZlOOH8IMgTmEdWcYET2p/CChKWnmzoWhxeMd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Za7vsKYAa2ek9dC+wcpJqXoccvWK0VKv13fASdkicMqqyuIb/nuavX2quvvIZhfNNtjZfuwNoq++98ftXvmloEncMP4M0lnMFry+x2qMI19Mr7cFFk7aAbr+OWNHRY995HYTgBbdDlg+0FwVOuFxqQH/JRgFM+Li6uLc84oAmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gtymtKOb; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756361068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e59v+VK1meCsMZeLVvoLFn49I9lv/VnXIPMZZBibqP4=;
	b=gtymtKObbmhJU277WdmkrSfFaQjJRg7Hy5T8I+atRCNj/JR5AycubvjfbC9cSQ2LBwbWl0
	DpI1uD54yfkpBtEqMCi5wwDpPLrpKF3M4BIN+Jnerk+TLK9FK2LsPsXj/E9i+fEORU/hgh
	uTkJZ8jmfyYhannw10cVXJMPS/kBoFE=
From: Menglong Dong <menglong.dong@linux.dev>
To: peterz@infradead.org,
	ast@kernel.org
Cc: mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tzimmermann@suse.de,
	simona.vetter@ffwll.ch,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Menglong Dong <menglong.dong@linux.dev>
Subject: [PATCH v4 3/3] sched: fix some typos in include/linux/preempt.h
Date: Thu, 28 Aug 2025 14:03:54 +0800
Message-ID: <20250828060354.57846-4-menglong.dong@linux.dev>
In-Reply-To: <20250828060354.57846-1-menglong.dong@linux.dev>
References: <20250828060354.57846-1-menglong.dong@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are some typos in the comments of migrate in
include/linux/preempt.h:

  elegible -> eligible
  it's -> its
  migirate_disable -> migrate_disable
  abritrary -> arbitrary

Just fix them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/preempt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 92237c319035..102202185d7a 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -372,7 +372,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 /*
  * Migrate-Disable and why it is undesired.
  *
- * When a preempted task becomes elegible to run under the ideal model (IOW it
+ * When a preempted task becomes eligible to run under the ideal model (IOW it
  * becomes one of the M highest priority tasks), it might still have to wait
  * for the preemptee's migrate_disable() section to complete. Thereby suffering
  * a reduction in bandwidth in the exact duration of the migrate_disable()
@@ -387,7 +387,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
  * - a lower priority tasks; which under preempt_disable() could've instantly
  *   migrated away when another CPU becomes available, is now constrained
  *   by the ability to push the higher priority task away, which might itself be
- *   in a migrate_disable() section, reducing it's available bandwidth.
+ *   in a migrate_disable() section, reducing its available bandwidth.
  *
  * IOW it trades latency / moves the interference term, but it stays in the
  * system, and as long as it remains unbounded, the system is not fully
@@ -399,7 +399,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
  * PREEMPT_RT breaks a number of assumptions traditionally held. By forcing a
  * number of primitives into becoming preemptible, they would also allow
  * migration. This turns out to break a bunch of per-cpu usage. To this end,
- * all these primitives employ migirate_disable() to restore this implicit
+ * all these primitives employ migrate_disable() to restore this implicit
  * assumption.
  *
  * This is a 'temporary' work-around at best. The correct solution is getting
@@ -407,7 +407,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
  * per-cpu locking or short preempt-disable regions.
  *
  * The end goal must be to get rid of migrate_disable(), alternatively we need
- * a schedulability theory that does not depend on abritrary migration.
+ * a schedulability theory that does not depend on arbitrary migration.
  *
  *
  * Notes on the implementation.
-- 
2.51.0


