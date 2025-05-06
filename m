Return-Path: <bpf+bounces-57488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D80AABB64
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 09:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251715057FF
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 07:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA0422C33A;
	Tue,  6 May 2025 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JVMilv+6"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01322A4FC;
	Tue,  6 May 2025 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512139; cv=none; b=r1ocGOSsQjHQAt98GyngnIjmuwReOMQCG8WVKap0iN+Lc+7P/pHqGu8BvYTPuqOIHCPxrO7IZY7mVaqX5Vvf74fTBdE/pgiMk4n1jZ1Uh8GGu/9rbZlgRcZZ+Y4BYVec11eF3G6r7GM4lyE05Pt7PbVuTQjV/t9ecFpqICljXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512139; c=relaxed/simple;
	bh=nw1kahHre1VwEQ37NEjmJ9Mw5nfgc6IkGsb1/bQmEQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BoEqwf86OBqQqiFTSHJlQG4HW4Z4MjTnWC4y8lRo4rP0PzkLxukb5tF7cC6ibw6VViQh9elSx6fTDGlTseWYRsCQW67aFQRbBGrstZZEXHoWNTVVh1lTPLsBMQxhTI7oiaMgwrlHeBoRL6iLGwUgxnN6MPLIQGjzM5qT+WcnCuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JVMilv+6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Ry+u2
	fa0e/nRAuyUY9cFErGjlXkzFJwMz7cC3AUA+q4=; b=JVMilv+6mMDUxUc2aePFM
	qsG37i86TxsSymDqQ/KDBk7hPEIhb/dSrR5ARagBM6pR0BQ7m5WV9ejw1ftkffR0
	aR/dJHyp+TA/2iw93DGBcHX1mfQUCmUPiVIXkkSNN9YRPHPMnfOT5lM/mRP6XREa
	LEDGGK1riLKYWmf/9qhvBY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBnylfLqBlovwXpBw--.23593S2;
	Tue, 06 May 2025 14:14:37 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 bpf-next 0/2] bpf: Allow some trace helpers for all prog types
Date: Tue,  6 May 2025 14:14:32 +0800
Message-Id: <20250506061434.94277-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBnylfLqBlovwXpBw--.23593S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF48Kw4rAFyxJry3Aw4DCFg_yoW8XrWUpF
	s3Jry3Gr1rtr17AwsxJw4Iq3WrJw4rJw17GwnrJw4rAr1UZryUJryIgr4rWryDXFy2grWr
	Ar1qqr1UKa4jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ja4E_UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwg9FeGgZovWwYgAAsE

From: Feng Yang <yangfeng@kylinos.cn>

This series allow some trace helpers for all prog types.

if it works under NMI and doesn't use any context-dependent things,
should be fine for any program type. The detailed discussion is in [1].

[1] https://lore.kernel.org/all/CAEf4Bza6gK3dsrTosk6k3oZgtHesNDSrDd8sdeQ-GiS6oJixQg@mail.gmail.com/

---
Changes in v3:
- cgroup_current_func_proto clean.
- bpf_scx_get_func_proto clean. Thanks, Andrii Nakryiko.
- Link to v2: https://lore.kernel.org/all/20250427063821.207263-1-yangfeng59949@163.com/

Changes in v2:
- not expose compat probe read APIs to more program types.
- Remove the prog->sleepable check added for copy_from_user,
- or the summarization_freplace/might_sleep_with_might_sleep test will fail with the error "program of this type cannot use helper bpf_copy_from_user"
- Link to v1: https://lore.kernel.org/all/20250425080032.327477-1-yangfeng59949@163.com/

Feng Yang (2):
  bpf: Allow some trace helpers for all prog types
  sched_ext: Remove bpf_scx_get_func_proto

 include/linux/bpf-cgroup.h |  8 --------
 kernel/bpf/cgroup.c        | 32 -----------------------------
 kernel/bpf/helpers.c       | 42 ++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext.c         | 15 +-------------
 kernel/trace/bpf_trace.c   | 41 ++++---------------------------------
 net/core/filter.c          | 14 -------------
 6 files changed, 47 insertions(+), 105 deletions(-)

-- 
2.43.0


