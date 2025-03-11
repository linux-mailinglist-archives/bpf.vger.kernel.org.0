Return-Path: <bpf+bounces-53804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20341A5BEF6
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 12:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBF63B15C8
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8724E4B7;
	Tue, 11 Mar 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oc8bFDsU"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857A2505AF
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692526; cv=none; b=szCiQ4oERE1VLc1K4RrmOd0ii0G3FktX13aGspr9rYuqa7Mysf1MWbLEzcP0r8Y6FNq38sKStNAXqS7TwsddROHNGO8yPRlIb//urUmvs0Z0L+HUk53SoMxqgTOd9TfLJK6lvfvh31jKJGl/gAdlYuaKv84BUoXGg66x6/HPPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692526; c=relaxed/simple;
	bh=vZKB+VYuZ9GryeRSnkZ4/uoZM1vfW+Pds6WrMcYSb6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSN+3gy2ArtaaUzbas51N9JCMr9b6JZEjxzupGAUpfZD0HIJvnRhMN7BIGCZv8hNR6tc6RBUpMob5ArOJ+w5x37IecMsBhYRNqTaQEs1IgBDEapSu+3FhRsCfEIACPffFesK8ixRn/LD+2Ev/2P0Zj3FZf/gmYhKq20E9NQkCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oc8bFDsU; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741692522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d3vZE7uRuzVj0uP/0LnpqKL9RFMjWgQLyco27Jd0EMo=;
	b=Oc8bFDsUYzMu844muNpZ1O08MRsqBIEPI13yqPstIzpok3hlt86JwNGkwAqlmfU/8MC/G2
	Ph9cLk66aWv7BSj4x0zqAbGUIK6UKvUMEiTud2p21v/u9mCwTq+/YFOM8C7sb/oDjpp73R
	J9DUOxeSULzb/VZur4O2tbMmVHCW6nI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	qmo@kernel.org
Cc: daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
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
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf-next v2 0/2] bpftool: Using the right format specifiers
Date: Tue, 11 Mar 2025 19:28:07 +0800
Message-ID: <20250311112809.81901-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds the -Wformat-signedness compiler flag to detect and
prevent format string errors, where signed or unsigned types are
mismatched with format specifiers. Additionally, it fixes some format
string errors that were not fully addressed by the previous patch [1].

[1] https://lore.kernel.org/bpf/20250207123706.727928-1-mrpre@163.com/T/#u

---
v1->v2:
https://lore.kernel.org/bpf/20250310142037.45932-1-jiayuan.chen@linux.dev/ 
---
Jiayuan Chen (2):
  bpftool: Add -Wformat-signedness flag to detect format errors
  bpftool: Using the right format specifiers

 kernel/bpf/disasm.c                |  4 ++--
 tools/bpf/bpftool/Makefile         |  7 ++++++-
 tools/bpf/bpftool/btf.c            | 14 +++++++-------
 tools/bpf/bpftool/btf_dumper.c     |  2 +-
 tools/bpf/bpftool/cgroup.c         |  2 +-
 tools/bpf/bpftool/common.c         |  4 ++--
 tools/bpf/bpftool/jit_disasm.c     |  3 ++-
 tools/bpf/bpftool/map_perf_ring.c  |  6 +++---
 tools/bpf/bpftool/net.c            |  4 ++--
 tools/bpf/bpftool/netlink_dumper.c |  6 +++---
 tools/bpf/bpftool/prog.c           | 12 ++++++------
 tools/bpf/bpftool/tracelog.c       |  2 +-
 tools/bpf/bpftool/xlated_dumper.c  |  6 +++---
 13 files changed, 39 insertions(+), 33 deletions(-)

-- 
2.47.1


