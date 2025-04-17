Return-Path: <bpf+bounces-56092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F5A91164
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 03:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D8C3BE96F
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 01:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0041A8F71;
	Thu, 17 Apr 2025 01:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ROe5GIDb"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51418185935;
	Thu, 17 Apr 2025 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744854792; cv=none; b=o9/T2InbTqH99/CBe4ikhqa3xEN3azEjsSIUgb8X1AnI347p4K8izTBx1M5RhsBp1nbS5UWjOkwWMvHg8ECdWh6yt75akZ7jImYSuuncmSjgacuOjv+4lBqTetvqAGnvugI3GhJrZTiQAGYDLoHd8FwCrmt1UAifXPdYhprETjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744854792; c=relaxed/simple;
	bh=MB+MxPpXAuIzLDo09KPW+VgynqMxMs1EVsV3ALo4im8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LvnVEF0m53xMIiAPhgk5SIE4szD+oayvC5yKK2eDUi58aUx1BQcPKus2z/G4JUQs7IHHxs65eJMzWYdbl3A1px1KT5st6h+hKk0j4rZqSsCwjEP59W0YMSr+jMKFR//xVILN0B8mL/fMTwyqA5a/p3x2BuecbUx1uS+yYXk65hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ROe5GIDb; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Z4iBH
	wEC4FlP3od+exjDiL3SgVGK/PrThBkYTkOqmZ8=; b=ROe5GIDbIhjfl5uQeb+f9
	/BD/H0daeNpIcgJ1zy47wi3dX1+XqP0D6qKwWhyuWYhmMmycQlKJEZ315rkhvdsJ
	C+89ch4UXhnenivxvSho0r2b1GzMyp5jb3534GIEZIXzFfkZZDCtMRRPP6xlvcvz
	LHCO6TWgm+WZSR/kymuZnE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3kaEGXgBopyyzAg--.31710S2;
	Thu, 17 Apr 2025 09:48:56 +0800 (CST)
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
	hengqi.chen@gmail.com,
	olsajiri@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 bpf-next 0/3] libbpf: Fix event name too long error and add tests
Date: Thu, 17 Apr 2025 09:48:45 +0800
Message-Id: <20250417014848.59321-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3kaEGXgBopyyzAg--.31710S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryUWF4DGrW3CF17CF4DJwb_yoW8Zry3pF
	ZrAr98Kr4fJF1xXa93Jw4xZr95Gan3J34ktF1ktw15Z3WUZ3yUZ34Ikw45WFnxWrZ29w45
	Z3Z2qF9xKFyjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UK-ewUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwgYxeGgAIC65JgACs2

From: Feng Yang <yangfeng@kylinos.cn>

Hi everyone,

This series tries to fix event name too long error and add tests.

When the binary path is excessively long, the generated probe_name in libbpf
exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
This causes legacy uprobe event attachment to fail with error code -22.

The fix reorders the fields to place the unique ID before the name.
This ensures that even if truncation occurs via snprintf, the unique ID
remains intact, preserving event name uniqueness. Additionally, explicit
checks with MAX_EVENT_NAME_LEN are added to enforce length constraints.
---
Changes in v5:
- use strrchr instead of basename.
- kprobe_test add __weak. Thanks, Andrii Nakryiko!
- Link to v4: https://lore.kernel.org/all/20250415093907.280501-1-yangfeng59949@163.com/

Changes in v4:
- add changelog. 
- gen_uprobe_legacy_event_name and gen_kprobe_legacy_event_name are combined into a function
- kprobe_test use normal module function. Thanks, Jiri Olsa!
- Link to v3: https://lore.kernel.org/bpf/20250414093402.384872-1-yangfeng59949@163.com/

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

 tools/lib/bpf/libbpf.c                        | 43 ++++------
 .../selftests/bpf/prog_tests/attach_probe.c   | 84 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 +
 3 files changed, 104 insertions(+), 27 deletions(-)

-- 
2.43.0


