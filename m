Return-Path: <bpf+bounces-53729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB6A59768
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC9E188CAC8
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC4E22B8CD;
	Mon, 10 Mar 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JJchKHzH"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9A22B8AA
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616460; cv=none; b=PI5PIDr9qTs6bOIiXij71g4ehN9b1qJW/eQ4XHV8ugHmU4mcM95I2l66eskljj4Lg56XQ2RYP/Bh6i/9KhBxPjNplwtUQrprIP2YygWa3aWxzZYzomR7QM8WAQXu9ftKOaf5ConF7puHMozRHeYJDKAtXBEa+kl2dTdWxjWAQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616460; c=relaxed/simple;
	bh=mIv5Wqu3QOJsZQZWRs7TmKsn4yWI20rQHtYvAoK2M8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ieTdsYefHOjJaUSge8TWcpgmtvK+l1nlKgJLND4xBP0EVX5+65nRwkKSzpclGk0z9B/NCFiPZGPGyjC62/ZtA1nKdid0okg19+rzYRB1cnxHNiscXCyIIjSdn/kSLdYfNZXiDkspXQ7pZtNRguhY+Qol49HadIxeH3IWSxMr9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JJchKHzH; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741616456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ICiNP7fiGGOS+dJlGwjHfX6msknfaoabh2apeLXLkmk=;
	b=JJchKHzHNQp4llO40Pmqh6nbaTWzj65Pc30BlocsRxiklfLu3uKsUgio3JAGS+wAnJWjrr
	9t8vETPGpHaMAJMIGpyMMC+1dCKFDjNsOT/BiGtW+MAj/fZlT1lKnj1Nx+ii6sJMnjto8q
	2kzml6Bb6qYYYp2ybwZEoT2snGUv5d8=
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
Subject: [PATCH bpf-next v1 0/2] bpftool: Using the right format specifiers
Date: Mon, 10 Mar 2025 22:20:35 +0800
Message-ID: <20250310142037.45932-1-jiayuan.chen@linux.dev>
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

Jiayuan Chen (2):
  bpftool: Add -Wformat-signedness flag to detect format errors
  bpftool: Using the right format specifiers

 kernel/bpf/disasm.c                |  4 ++--
 tools/bpf/bpftool/Makefile         |  2 +-
 tools/bpf/bpftool/btf.c            | 14 +++++++-------
 tools/bpf/bpftool/btf_dumper.c     |  2 +-
 tools/bpf/bpftool/cgroup.c         |  2 +-
 tools/bpf/bpftool/common.c         |  4 ++--
 tools/bpf/bpftool/jit_disasm.c     |  3 ++-
 tools/bpf/bpftool/map_perf_ring.c  |  6 +++---
 tools/bpf/bpftool/net.c            |  4 ++--
 tools/bpf/bpftool/netlink_dumper.c |  5 ++---
 tools/bpf/bpftool/prog.c           | 12 ++++++------
 tools/bpf/bpftool/tracelog.c       |  2 +-
 tools/bpf/bpftool/xlated_dumper.c  |  6 +++---
 13 files changed, 33 insertions(+), 33 deletions(-)

-- 
2.47.1


