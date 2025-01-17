Return-Path: <bpf+bounces-49169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34EFA14D32
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 11:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00D61688CF
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AB01FE469;
	Fri, 17 Jan 2025 10:06:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B951FC11D
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108376; cv=none; b=aEMOEpAVU7DKydSnvKIx0vBlXblFAKUXQMmXdhT+d1nD/nXsdjk+A8NhlN89Ok+N5bt3VOE74fQ09bEo+BcNtUjZJpJO47bL5S2lpDedeN+wUIXMIIRZPz7HNGattJon214CvGROuf31f3h5YRH8i8jvOncBrwsNJH4lQAt/Ndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108376; c=relaxed/simple;
	bh=9EpnC7z0DcMhWFEK9cu5fTEuzIVp5WTnrJ164E5cQ9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fl44CYuPEpt5hX/AUq3rRrxUWzIHCowkUIDWsY3eO/n/v03ztrDSE94CykLAElORSGKqNuGvKdFLGa6Ssji1cAUa2F7WtJzPT+Z1QDY84WcB2lg2yUoQi1mXkPgq7AiLrOm0T4VAm4h1i0s6WHW20QSJYicvwX85euAAQrTvhF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YZFjt5Vhtz4f3jss
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 18:05:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0E67D1A0D28
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 18:06:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGCNK4pnQRDPBA--.48008S4;
	Fri, 17 Jan 2025 18:06:07 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v3 0/5] Free htab element out of bucket lock
Date: Fri, 17 Jan 2025 18:18:11 +0800
Message-Id: <20250117101816.2101857-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGCNK4pnQRDPBA--.48008S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1kWrWDGF13uw1DCF4kWFg_yoW5WFyxpF
	WFkw13Gr1Igrn2qwnxK3Wv9rWrAws5XF15WFW8Kw4rZa4DXFy0qr1I9F45ua13ur9avrZI
	vr42ywn3W348Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUFku4UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set continues the previous work [1] to move all the freeings
of htab elements out of bucket lock. One motivation for the patch set is
the locking problem reported by Sebastian [2]: the freeing of bpf_timer
under PREEMPT_RT may acquire a spin-lock (namely softirq_expiry_lock).
However the freeing procedure for htab element has already held a
raw-spin-lock (namely bucket lock), and it will trigger the warning:
"BUG: scheduling while atomic" as demonstrated by the selftests patch.
Another motivation is to reduce the locked scope of bucket lock.

However, the patch set doesn't move all freeing of htab element out of
bucket lock, it still keep the free of special fields in pre-allocated
hash map under the protect of bucket lock in htab_map_update_elem(). The
patch set is structured as follows:

* Patch #1 moves the element freeing out of bucket lock for
  htab_lru_map_delete_node(). However the freeing is still in the locked
  scope of LRU raw spin lock.
* Patch #2~#3 move the element freeing out of bucket lock for
  __htab_map_lookup_and_delete_elem()
* Patch #4 cancels the bpf_timer in two steps to fix the locking
  problem in htab_map_update_elem() for PREEMPT_PRT.
* Patch #5 adds a selftest for the locking problem

Please see individual patches for more details. Comments are always
welcome.

---

v3:
 * patch #1: update the commit message to state that the freeing of
   special field is still in the locked scope of LRU raw spin lock
 * patch #4: cancel the bpf_timer in two steps only for PREEMPT_RT
   (suggested by Alexei)

v2: https://lore.kernel.org/bpf/20250109061901.2620825-1-houtao@huaweicloud.com
  * cancels the bpf timer in two steps instead of breaking the reuse
    the refill of per-cpu ->extra_elems into two steps

v1: https://lore.kernel.org/bpf/20250107085559.3081563-1-houtao@huaweicloud.com

[1]: https://lore.kernel.org/bpf/20241106063542.357743-1-houtao@huaweicloud.com
[2]: https://lore.kernel.org/bpf/20241106084527.4gPrMnHt@linutronix.de

Hou Tao (5):
  bpf: Free special fields after unlock in htab_lru_map_delete_node()
  bpf: Bail out early in __htab_map_lookup_and_delete_elem()
  bpf: Free element after unlock in __htab_map_lookup_and_delete_elem()
  bpf: Cancel the running bpf_timer through kworker for PREEMPT_RT
  selftests/bpf: Add test case for the freeing of bpf_timer

 kernel/bpf/hashtab.c                          |  60 ++++---
 kernel/bpf/helpers.c                          |  18 +-
 .../selftests/bpf/prog_tests/free_timer.c     | 165 ++++++++++++++++++
 .../testing/selftests/bpf/progs/free_timer.c  |  71 ++++++++
 4 files changed, 284 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/free_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/free_timer.c

-- 
2.29.2


