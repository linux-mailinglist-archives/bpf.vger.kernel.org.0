Return-Path: <bpf+bounces-55847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB69A87C65
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 11:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572C11894B9C
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 09:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FAD264FAE;
	Mon, 14 Apr 2025 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hR6RA9Yj"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A1263F2D;
	Mon, 14 Apr 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624281; cv=none; b=nepTbWmBi8O6YmqzD/gGCf3+NOLgZzk4x+ZSErGeweBpqd8JUIv7nuID43OFpqKWHs/KjnSVhwGFC+cxFgKe4db9HeVni1iczIoCcvA+d0bfcsRgXqBrWxGjuxl+GJUPcDJp3idG7f/Gw1SgLpev+h/nc7NJXBO+d+E1lvq8WQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624281; c=relaxed/simple;
	bh=bJERvzwt8lFvjafQMnAIDQx6RUz9z9GWqAZ6pUMXq+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=paErnx9JFqm7cBXe3OQdBioz3YGNX3ehvoxm7vEGlJ8ktFcAcxfKqG6Vft1lEbLjUol2R1DdMfGPmS61NBOmn0xJkEh1+I9eiI1+/cmp8cyzbPzl5a+lzjlnie+4HslPn8ewCkBKtEEQF4h8qu5hsmjky0pOUFENui2qkjBt2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hR6RA9Yj; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+/bZ0
	t5xx/bRKSJ/CIXOrmqoGr0Nv1gsvyR4jn3Pp9c=; b=hR6RA9YjcPsG2kXfVO6T4
	3t9tKDy0mgwFS3K3En2LLVtj01/Ru6k4+sRZFud/sMzFqyJldsB10HkuLxsdcinl
	3fO1bPshKnAspimOuequcYaXC7AWLs7M3ckIWM5KT6JxWDv446CGlnERT4v6j6eg
	WyKV4uxs+Rt5zLAWy3BTd8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnj1Sb1vxnxkYWGg--.23370S2;
	Mon, 14 Apr 2025 17:34:21 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
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
	hengqi.chen@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 bpf-next 0/3] libbpf: Fix event name too long error and add tests
Date: Mon, 14 Apr 2025 17:33:59 +0800
Message-Id: <20250414093402.384872-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj1Sb1vxnxkYWGg--.23370S2
X-Coremail-Antispam: 1Uf129KBjvJXoWruw43Zw18GF17CF1UCFW5GFg_yoW8Jr17pF
	ZrGr15Krn5J3WxXFZxGrW7AryrJan3J34ktFnrt345Za4UZ3yUXw12kw45WFnxWrZ29a1r
	Z34ktF90ga4xZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbAwsUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTRsveGf80G-QiwAAs+

From: Feng Yang <yangfeng@kylinos.cn>

Hi everyone,

This series tries to fix event name too long error and add tests.

When the binary path is excessively long, the generated probe_name in libbpf
exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
This causes legacy uprobe event attachment to fail with error code -22.

---
Changes in v3:
- add __sync_fetch_and_add(&index) and let snprintf() do the trimming. Thanks, Andrii Nakryiko!
- add selftests.
- Link to v2: https://lore.kernel.org/all/20250411080545.319865-1-yangfeng59949@163.com/

Changes in v2:
- Use basename() and %.32s to fix. Thanks, Hengqi Chen!
- Link to v1: https://lore.kernel.org/all/20250410052712.206785-1-yangfeng59949@163.com/

Feng Yang (3):
  libbpf: Fix event name too long error
  selftests/bpf: Add test for attaching uprobe with long event names
  selftests/bpf: Add test for attaching kprobe with long event names

 tools/lib/bpf/libbpf.c                        | 19 +++--
 .../selftests/bpf/prog_tests/attach_probe.c   | 84 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  5 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 +
 4 files changed, 103 insertions(+), 7 deletions(-)

-- 
2.43.0


