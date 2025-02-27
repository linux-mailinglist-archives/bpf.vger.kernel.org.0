Return-Path: <bpf+bounces-52757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45E5A48177
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 15:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4572D189FE15
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE58232364;
	Thu, 27 Feb 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fT7O/9qk"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA77234989
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666434; cv=none; b=VLVvzGn9Sn7BHryopHgauN8NPDkoNvRrgKy6A9RFuAfmhydWR3T8H5AUinKQ2D0UVU3FC8DUQ419mw/HWJ2+SGaY2DWzHhjdaw7mGtERD0FajuuT3oLt/WsyfVdVRaxHB/RTAf/8h75XCfQBA7De0VypFQbm6b/zfD+d5cOXDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666434; c=relaxed/simple;
	bh=3Q/8NY2SrIgt2b3sV8RIf9HNevVZp7vM9NtNBn8vW18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xyk6/POd7eRWUcilviffoSlruv8DnkOgURLA1OrIBFDOyk/SXWYIwPmkBbe7PXKYp9oexCQRcKP2nRdxChPQZzkWXjJvmMl0lxj4wn1/cqg+DF3mykua3UOqSSthmJ48lcIW7ocWg8873oAXRuUjGHzK4kxdKE9G2rB//GTzaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fT7O/9qk; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740666429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vs9vXYTdcS8F45fqup/G8Nl4E6Z/Osp2FFL8xUBkHDY=;
	b=fT7O/9qkV2csontrbjal4dBrdUn2fuA/E51mpyGMTGKF5TQBNR0BVOPH9FiLGXpBx/T+gl
	N5d4jh4RrSJIqLFHQBTOLWIwcSq5OqKhJn/9QKo3v4y/uCGg1EcHKwaBMNz+PfGR7rvdRB
	JML78qqhpaBOV+xCUkQq+dXdM7ZmAvE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf-next v1 0/3] Optimize bpf selftest to increase CI success rate
Date: Thu, 27 Feb 2025 22:26:43 +0800
Message-ID: <20250227142646.59711-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

1. Optimized some static bound port selftests to avoid port occupation
when running test_progs -j.
2. Optimized the retry logic for test_maps.

Some Failed CI:
https://github.com/kernel-patches/bpf/actions/runs/13275542359/job/37064974076
https://github.com/kernel-patches/bpf/actions/runs/13549227497/job/37868926343
https://github.com/kernel-patches/bpf/actions/runs/13548089029/job/37865812030
https://github.com/kernel-patches/bpf/actions/runs/13553536268/job/37883329296
(Perhaps it's due to the large number of pull requests requiring CI runs?)

Jiayuan Chen (3):
  selftests/bpf: Allow auto port binding for cgroup connect
  selftests/bpf: Allow auto port binding for bpf nf
  selftests/bpf: Fixes for test_maps test

 tools/testing/selftests/bpf/prog_tests/bpf_nf.c     |  9 ++++++---
 .../testing/selftests/bpf/prog_tests/cgroup_v1v2.c  | 13 +++++++++----
 .../testing/selftests/bpf/progs/connect4_dropper.c  |  4 +++-
 tools/testing/selftests/bpf/test_maps.c             |  9 +++++----
 4 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.47.1


