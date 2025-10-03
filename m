Return-Path: <bpf+bounces-70287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BEBB642A
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 10:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6ECD3AC47E
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595B8275860;
	Fri,  3 Oct 2025 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uey/iW69"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C21D7E4A
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759481230; cv=none; b=f1OvSGtBJtA0tpHP/kAV8ZA9ryTv7/YODaFFJpZtRb+Pyjvs8GX9FDekg3L2Q1k9MhFqJ9tcDep4huLDxzR8xkVRUXVIDOTAoP/RwvFS5kReUht8BCZvOEdQ8LcjpnTC3WMkAhnEO5/POaReQPNvC/tmuOSBNeknpE1cK4Va6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759481230; c=relaxed/simple;
	bh=tTJ99chusfJiteqfuym/kCa8qHxp0d9Wz8vIYGHukfU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Io5vx1NCP3eVsoP1OIFRaDlgADvAz4wJV0cVBKUNyDLKRGMNvf0bVXn8fu9TO9k1CC9IHzjzZX/vaSBPnPHs8xjHm2Qp7mzLKpHQ0lqCm6s8eyrvyAuoJsnDJ0nDA4Fg6CXYbav29avuQTLBOUTONXKaMuDZ64OKsr5cltNGYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uey/iW69; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759481222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EhHu6K/dYNo4nWH+u4BIU6qkc0knEsqyxs6KkV95FdY=;
	b=Uey/iW69jB+au7kAb/O6iuxwf0wrwg0H/wDLnQnDnl+170tvqvJ0shoKwLGh68hxaQL9Fu
	qE8kGUN8sbuXDRHyyJvr773VVpvv79BfUQYNOHKZUK03lM++U12kUvocelCZM6u3UlbIIG
	Z0B6xc++gY7vqC09Ioe+q+w2biPtGEw=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	toke@redhat.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 0/2] bpf: Avoid RCU context warning when unpinning htab with internal structs
Date: Fri,  3 Oct 2025 16:45:26 +0800
Message-ID: <20251003084528.502518-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid RCU context warning when unpinning
htab with internal structs (timer, workqueue, or task_work).

---
KaFai Wan (2):
  bpf: Avoid RCU context warning when unpinning htab with internal
    structs
  selftests/bpf: Add test for unpinning htab with internal timer struct

 kernel/bpf/inode.c                            |  2 +-
 .../selftests/bpf/prog_tests/pinning_htab.c   | 37 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinning_htab.c   | 25 +++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_htab.c

-- 
2.43.0


