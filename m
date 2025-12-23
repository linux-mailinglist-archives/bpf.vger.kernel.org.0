Return-Path: <bpf+bounces-77356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1114CD8865
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 10:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ED0630198AC
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 09:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EDB3242D7;
	Tue, 23 Dec 2025 09:12:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2963019B6
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481153; cv=none; b=sCXFXhhOJGOK0kF/4pvxSOCnE928pacr6KQieBYmypjrCATQdGfrodoZCodcsKv7Wc4Akpter1oENcUp3guqHK7D/iuXY3VB+vKZaYPR/hzVR7NWJpi9mxnpfEwZN6SOncwGERRR2hR0dkjIVp5zzUUXYV6DXp3F/QpsY7/ucC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481153; c=relaxed/simple;
	bh=ImLjBvUeOZOK9n1nuj+y0C1OOr3ZtfTULWzsqUJu9wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDh5Maxb8R9p7F8cKclol81KuiBvLRGnLWjujpZ1IGNFjdek7MLl4jYHUPCxklx9xPYI/KYTmBV6cfY8dSt5KWbzeODRCZ+AsZ2jTyUYQ+Xy/L3mGhz7R6T0J+bCnvk3QziB8Ef9mreHLe57ly+vpORLUpBUDgDnv+Ldgi/SyKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.146.110])
	by mtasvr (Coremail) with SMTP id _____wBnYCPLXEppOTo7AQ--.6850S3;
	Tue, 23 Dec 2025 17:11:40 +0800 (CST)
Received: from lutetium.localdomain (unknown [10.162.146.110])
	by mail-app4 (Coremail) with SMTP id zi_KCgCniH_HXEppBNUDBA--.44618S2;
	Tue, 23 Dec 2025 17:11:35 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
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
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next v2 0/2] bpf: Add value tracking for BPF_DIV
Date: Tue, 23 Dec 2025 17:10:48 +0800
Message-ID: <20251223091120.2413435-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCniH_HXEppBNUDBA--.44618S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhIJCmlJnwMiRAACsP
X-CM-DELIVERINFO: =?B?mPdacAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BF8DE4vll40/IW/Z/fxYo8TLqgeu2IJL1I/S9RpJ7dxljLEQgw9gcVMbXsJ6QNC7KgH
	bZldIZAFtbm/mytG7zSKpecmJD0PjieDgQVonp+ztpxoHP4b9Myb6c9Um8nAbA==
X-Coremail-Antispam: 1Uk129KBj9xXoWrKr48Kry3GFWDJr17WFWUKFX_yoWkKFg_Ka
	1FvrykXr4UKF17ZFyI9F17XryDt3yDtF1fAa13try7ur17Zrs8WF4kJry8XasrWa1YyrZx
	ZF90ka4vvrnruosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbTkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x0EwI
	xGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jj7KsUUUUU=

From: Yazhou Tang <tangyazhou518@outlook.com>

Add value tracking (range and bitwise tracking) for BPF_DIV. Please
see commit log of 1/2 for more details.

---

Changes v1 => v2:
1. Fixed 2 bugs in sdiv32 analysis logic and corrected the associated
   selftest cases (AI reviewer).
2. Renamed `tnum_bottom` to `tnum_empty` for better clarity, and updated
   commit message to explain its role in signed BPF_DIV analysis.

v1:
https://lore.kernel.org/bpf/tencent_717092CD734D050CCD93401CA624BB3C8307@qq.com/
https://lore.kernel.org/bpf/tencent_7C98FAECA40C98489ACF4515CE346F031509@qq.com/

Yazhou Tang (2):
  bpf: Add interval and tnum analysis for signed and unsigned BPF_DIV
  selftests/bpf: Add tests for BPF_DIV analysis

 include/linux/tnum.h                          |   4 +
 kernel/bpf/tnum.c                             | 159 ++++++-
 kernel/bpf/verifier.c                         | 225 ++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_div_bounds.c | 404 ++++++++++++++++++
 .../bpf/progs/verifier_value_illegal_alu.c    |   7 +-
 6 files changed, 797 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_div_bounds.c

-- 
2.52.0


