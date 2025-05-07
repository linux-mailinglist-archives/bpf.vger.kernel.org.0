Return-Path: <bpf+bounces-57612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F6AAD394
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 04:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2577B7839
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108EC1C84AA;
	Wed,  7 May 2025 02:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Tluk4+OC"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB3E1A0BF1;
	Wed,  7 May 2025 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746586132; cv=none; b=RJ9qWS6evw7Dj/aIseuFto/akvn56biAAU+PTqPiTPZtKDzmvjH9/9AhxFzH80XomnnVmBX2knEyi1yeOAnWXiQxznpumOzZCBKNAXrxz8w7neafSDHglpvrz+OGXbbsX/8tKR/Fb2NR79o8TMcuHUU8te1Zs2x325k93X2bKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746586132; c=relaxed/simple;
	bh=ppY350V0+svbZzHsEZdQVGX9rPhPSs3KzB/WqLIZM4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YpkWoAkBWAMzsHp8XvAGIrhPbez75Ojl15RZs3xJUDulDn+BWqNFtSGori2fvKOWCmvHRZb57zIxkQBQEyjftM3kNmHuqQOv/ysAwnHDi2s1ysV8FHc2EU4Ot/Bw2sGnyylF+KQ6uXOqC6sghtIBz9i3n69vXN/GAiV0ZiV5R+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Tluk4+OC; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qtPcl
	/B2RSB8VuMPGCmuJwljszoHk1RGRMG3a7CDqtA=; b=Tluk4+OC26c85N2rS+k00
	JGakQM5vZdOENIAQnRIGAidFpzQnETRE2Vyk+KJa3R0sqBFWNbwlPJW2GSH/eyOs
	w30MBLcHXXNuOJdtDof3o70T4Yv3r35WEKrQfJh//bnbQ+uUsVoFLNJ0IfCk5Wax
	LW+A3GLh/yVlh70zW9LLsU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3P8x2tBpocz5dBw--.62210S2;
	Wed, 07 May 2025 09:16:39 +0800 (CST)
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
Subject: [RESEND PATCH v2 0/2] sched_ext: rename var for slice refill event and add helper
Date: Wed,  7 May 2025 09:16:35 +0800
Message-Id: <20250507011637.77589-1-jameshongleiwang@126.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P8x2tBpocz5dBw--.62210S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw48Xr18GF4fuF4rJFy5Arb_yoWxZFgEqF
	93uFZ3JanrZFyUGFWayF15Jr97KFW8Jrs5JF4UKrsFyr43trsrKr1kKrWkXr10gay2ywnr
	KrnYyFy8uwnxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUyE_tUUUUU==
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiYBVGrWgatD0D8gACsW

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


