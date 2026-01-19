Return-Path: <bpf+bounces-79465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36267D3ABEB
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 15:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F1BD3012A68
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3987B387376;
	Mon, 19 Jan 2026 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KoPGdF5E"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A83803C2
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832637; cv=none; b=CghsCpl7pZpa7ysTQr0m59soCgaKv37+1G2ed1coNeSyPzp7X6VTsVLAqjOwxmQhZNY1/3sjRrDeUxlZRHAIsLICxSUjMVFO8l4xfQ+KpnF303YX5JcWJyBZ+wIfnxFO/S4mNO6R+rriC+wXhl28LyblpdYe/rHPyba8RWzRFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832637; c=relaxed/simple;
	bh=zVGZh7eFDDPz8YwCWOxi/FDxpsyLCNTp4r0ypycyE+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZRvkzc9favahn2AlnZT84HJTntL57wMPkrIZl8aDl8H34FccTiS2gjholB+TalQ7kR6Kme6GBd2SM1+y/672jdg0YrlBoFWTVTO5RoXuRTxcgXnrTnlzyUM//kOOD/YovtmOf4LC7ZlD7OB1wRK7cTgSLvFmoPodbWwlvLVD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KoPGdF5E; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768832623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3T80oN8F5GALi0Utz+Tw6OTmbiEVk1RUB4ZQwlgHphc=;
	b=KoPGdF5EZZ7HlwpXKoAv0qVESjP/Sbh4uL6L/VcRMqyJ0mgCXmUnFjCynxsilJEMJK17it
	pF5xBNu4tGBGv27+tBe8LKcApkPQT7ZHGghcn8PhJDpqpFUgJXFsQSLZJcMeEQI53fXbS9
	ldaR2YmCGNdWdFgk3bjX7wnCITiW2OY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/3] bpf: Avoid deadlock using trylock when popping LRU free nodes
Date: Mon, 19 Jan 2026 22:21:17 +0800
Message-ID: <20260119142120.28170-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Switch the free-node pop paths to raw_spin_trylock*() so callers don't block
on contended LRU locks. This is a narrower change than Menglong's approach [1],
which aimed to eliminate the deadlock entirely.

The trylock-based approach avoids deadlocks in long-lived critical
sections, while still allowing locking in short-lived ones. Although it
does not completely eliminate the possibility of deadlock, it
significantly reduces the likelihood in practice.

LRU-related deadlocks have been observed multiple times, including:

 - [syzbot] [bpf?] possible deadlock in bpf_lru_push_free (2) [2]
 - Re: [PATCH bpf v3 0/4] bpf: Free special fields when update hash and local storage maps [3]
 - Raw log of CI failure [4]

BTW, this series also factors out the bpf_lru_node_set_hash() helper, along with
a comment describing the required ordering and locking constraints.

Links:
[1] https://lore.kernel.org/bpf/20251030030010.95352-1-dongml2@chinatelecom.cn/
[2] https://lore.kernel.org/bpf/69155df5.a70a0220.3124cb.0018.GAE@google.com/
[3] https://lore.kernel.org/bpf/CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com/
[4] https://github.com/kernel-patches/bpf/actions/runs/20943173932/job/60181505085

Leon Hwang (3):
  bpf: Factor out bpf_lru_node_set_hash() helper
  bpf: Avoid deadlock using trylock when popping LRU free nodes
  selftests/bpf: Allow -ENOMEM on LRU map updates

 kernel/bpf/bpf_lru_list.c                     | 35 ++++++++++++++-----
 .../bpf/map_tests/map_percpu_stats.c          |  3 +-
 2 files changed, 28 insertions(+), 10 deletions(-)

--
2.52.0


