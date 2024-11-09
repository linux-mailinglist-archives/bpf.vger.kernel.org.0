Return-Path: <bpf+bounces-44426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1884A9C2DFB
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 16:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D2DB2116F
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57C4199943;
	Sat,  9 Nov 2024 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JXWFXW02"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B3149C52;
	Sat,  9 Nov 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164686; cv=none; b=OOExmvhiTTp4DwNECKofu5WXEDzqKLOEJz5cI8+NgU43wlXWRQDeXMC/vm7m4fzr3RFk6qGrKEqMwXQ+li8GfPHY7kXB/kiUSE0vU1dDv+uwsqkMP+x4o0FAW4H63/JNUGAonun4abKD7GtLmhd3lFYSKBGg3+4tqYMLkRgYC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164686; c=relaxed/simple;
	bh=hmmAR7e5+647p7Fs/Jv1P24CAJ33zQACNo6+L2RZFs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4cDULFBATMaiUZLKuzZ4KvQDtOuIImsqFxPUcp+1Zeo8EST3mCkymbNqZnTfe2HGVCBMC/iABmBe8ZkTEHJoF9OUE89LfVEc3InNAkNYRrSizZVVpQqmwBdsvT5+pJ3NfDcJX7fJiVjhcMFqCrwqRh+FsgqZljA1vE5SFoQ4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JXWFXW02; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=0ajtu
	/pCXIweYkbzhFHSyXPuS7DEQVG9KAt0GfVfTj4=; b=JXWFXW02wrxU3ycDK6np9
	iAc0G0E30wcBk9cxHsNEHXuQfnztBKoOGdKVHSVTihIg/P+AFm3hpvenSnfPRd55
	gFpvsI7O9J0LyP2+th+rIy4xehnHv681k4MMXxWjfc2LT8HMXxWDmuZW9125qaC2
	fSNJcilRaDRQveAZGTD1LQ=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnT4exeS9n3Jk_GA--.36911S2;
	Sat, 09 Nov 2024 23:03:19 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: martin.lau@linux.dev,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	daniel@iogearbox.net
Cc: Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v2 0/2] bpf: fix recursive lock and add test
Date: Sat,  9 Nov 2024 23:03:03 +0800
Message-ID: <20241109150305.141759-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnT4exeS9n3Jk_GA--.36911S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4rWF1fKFyDXF1kAFWkZwb_yoW3urg_ur
	Wav34kJ347GF4YyFyUXanY9Fy29ay8t348AFW7tr12vr47ZrW5XF4vgr90y34UXa1xA39I
	q3W5urZ2vr43XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMhFxUUUUUU==
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwKSp2cvb9J3owAAsZ

1. fix recursive lock when ebpf prog return SK_PASS.
2. add selftest to reproduce recursive lock.

Note that if just the selftest merged without first
patch, the test case will definitely fail, because the
issue of deadlock is inevitable.

---
v1->v2: 1.inspired by martin.lau to add selftest to reproduce the issue.
        2. follow the community rules for patch.
        v1: https://lore.kernel.org/bpf/55fc6114-7e64-4b65-86d2-92cfd1e9e92f@linux.dev/T/#u
---

Jiayuan Chen (2):
  bpf: fix recursive lock when verdict program return SK_PASS
  selftests/bpf: Add some tests with sockmap SK_PASS

 net/core/skmsg.c                              |  4 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 53 +++++++++++++++++++
 .../bpf/progs/test_sockmap_pass_prog.c        |  2 +-
 3 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.43.5


