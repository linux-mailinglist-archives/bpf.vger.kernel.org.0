Return-Path: <bpf+bounces-56218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F478A930C2
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 05:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CE146698F
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 03:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA9E267B61;
	Fri, 18 Apr 2025 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kPspP58d"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6408518871F;
	Fri, 18 Apr 2025 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744946841; cv=none; b=dM1CkOUjYtF48pG1xLpS7bJNMQd/dTWqf5JylX/07JxvuKbnzf+KpEGpMr9wN4zrd/mtFDGL1KN4ZAAV3smJUTywT+TN/bpob8ULsjkW+0AJGW89tIcJPH1T3PMVrrnygDIRv2CcXEL1gop4nr2v4DNUL97Z+sO8yHL0sVIFecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744946841; c=relaxed/simple;
	bh=ppY350V0+svbZzHsEZdQVGX9rPhPSs3KzB/WqLIZM4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jfHESmOFwtWZ7U7A43SCrYxlCmn0W72vLxuoonUn2huGpDDL66ElYHLD2Kf3SEjUib8JQpWVXn2eEftIi4yDmBdNCfsC9JOLVf+AOqa9iEoV10njspnKTjwvcnOXbq845VgJqj9+Ekp4xCLOeWADJEXa+mz61SJ8sG/yXkulbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=kPspP58d; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qtPcl
	/B2RSB8VuMPGCmuJwljszoHk1RGRMG3a7CDqtA=; b=kPspP58dWZ7oSOwboSlHB
	mSYoyKaBj+dydzMc7ADMi+uDWDQf5wAfYkdOy6+9c/jsz72H9N4zOEXFIBs/mpoY
	Quhwvt0FGtTzQj0RLUrunhDJnewUrFqEjmn7//ybtsc5p1cLE1O/Bgw8CnoYK00h
	aFkq1agG2PYoPPcmnwy2I4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3l2pNxgFodOZBDA--.38467S2;
	Fri, 18 Apr 2025 11:26:06 +0800 (CST)
From: Honglei Wang <jameshongleiwang@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	joshdon@google.com,
	brho@google.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	jameshongleiwang@126.com
Subject: [PATCH v2 0/2] rename var for slice refill event and add helper
Date: Fri, 18 Apr 2025 11:26:01 +0800
Message-Id: <20250418032603.61803-1-jameshongleiwang@126.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgD3l2pNxgFodOZBDA--.38467S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw48Xr18GF4fuF4rJFy5Arb_yoWxZFgEqF
	93uFZ3JanrZFyUGFWayF15Jr97KFW8Jrs5JF4UKrsFyr43trsrKr1kKrWkXr10gay2ywnr
	KrnYyFy8uwnxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU6VbDUUUUU==
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbirwIzrWgBwHqE8QABsU

SCX_EV_ENQ_SLICE_DFL gives the impression that the event only occurs
when the tasks were enqueued, which seems not accurate. So rename the
variable to SCX_EV_REFILL_SLICE_DFL.

The slice refilling with default slice always come with event
statistics together, add a helper routine to make it cleaner.

Changes in v2:
Refine the comments base on Andrea's suggestion.

Honglei Wang (2):
  sched_ext: change the variable name for slice refill event
  sched_ext: add helper for refill task with default slice

 kernel/sched/ext.c             | 36 +++++++++++++++++-----------------
 tools/sched_ext/scx_qmap.bpf.c |  4 ++--
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.45.2


