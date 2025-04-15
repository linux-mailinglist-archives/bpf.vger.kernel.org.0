Return-Path: <bpf+bounces-55943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCE5A89865
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 11:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED5F17756A
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC2628E608;
	Tue, 15 Apr 2025 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nz+AdkLm"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB328E5F3;
	Tue, 15 Apr 2025 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710056; cv=none; b=ReueItpzl+e6MWlgMKD84sZruxM+zo37pvvB5CgsKPu/N0NlFDV8ftlLDpCk5/ciuy57zulbVg1bqfnLI8bb9ZCVHZVpWvk7ycKgo1VDREpX25YKhwlsHTvTybnlNzbnySyeyMbzaOBRyLl42F2dLL9l36+GQ917Tn2yYWnNgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710056; c=relaxed/simple;
	bh=2pwZ1qlDG4JfSwKSgm3Af0VqkWqbaKQSew+pT9ECKyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AUKw2H3GUxhMg9hWkL5ayGHpo93TZBg7OobtmRAxjGoGwMsec9D4XmCAKuC3yD/4nz+ToMGOgl4HSUuPkm54WnZFv2bquL0WPROerJvLlVJG3MRcEzygDxkrWSaH3VNUvXgmQzWxwZUuL8wiGsnr/8IguCs1kI7piLaq/Q5v+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nz+AdkLm; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=srFyC
	TLP91LEogQ1QKxiPD2wzCBvVsdcpUotC9gEJ8U=; b=Nz+AdkLmn3GlyPDzkibsX
	1AYTCJ8KDDwGbMxcI3IaTese4FU2cecoUK0zEIyDgiJ1cs46egVV7rUB4ObxBi1S
	BBhmMkXq9/aPZ1dzP12C7EM6OCZ3ZOg5j5wgh6asMXv4jox3rXVrBYejTx5ORKU7
	LBVeoPfrdCOFdf5ib8HW5c=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnT4k_Kf5ncYDjAA--.39887S2;
	Tue, 15 Apr 2025 17:39:12 +0800 (CST)
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
Subject: [PATCH v4 bpf-next 0/3] libbpf: Fix event name too long error and add tests
Date: Tue, 15 Apr 2025 17:39:04 +0800
Message-Id: <20250415093907.280501-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT4k_Kf5ncYDjAA--.39887S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryUWF4DGrW3CF17CF4DJwb_yoW8AF43pF
	ZrArn0grs3JF1xXFZ3J3yxZr95Can3JFyktF1ktw15Z3WUZ3yUZ34Iyw45WFnxWrZ29w45
	Z3WqqF9IgFyjvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKzuZUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTR4weGf+JBHCCQAAs8

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

 tools/lib/bpf/libbpf.c                        | 41 ++++-----
 .../selftests/bpf/prog_tests/attach_probe.c   | 84 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 +
 3 files changed, 103 insertions(+), 26 deletions(-)

-- 
2.43.0


