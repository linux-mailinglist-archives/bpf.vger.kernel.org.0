Return-Path: <bpf+bounces-48058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3144A039FF
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 09:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBCE3A5590
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CCC1E3765;
	Tue,  7 Jan 2025 08:44:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2401DFDB3;
	Tue,  7 Jan 2025 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239442; cv=none; b=kX9ZaCugit8cPpocthJ/Yd9rH4A9HjKprej9pHVfQHLmrK9mkByuECHjl27sJWggoN17RxiosepE/YH9SNMlGEaL1TwejZRGjsrboFBmDsNEsNnAUi4+QDEHnwSHj0KcZNpGna7nXH9uP6liXOtlWqSiua5Vpj4axx4TcEm/meQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239442; c=relaxed/simple;
	bh=c28yAgCtAW8jU71BTxomvQJuFrFHygqaNnBgurg2OJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bjx3famrlAcq+s4uSdqX5VUCS4OE19q1nUCqSHgnqjxK3mqYywqLcEvie8ufkS8OYxj4ntYmNcVH7VyguPRhD2xCSLhe0rsqf77iJZ42h2FgYvWRCfJrz82Rt5yXzxKuWNuOi2VxzRz14sMADyUQE9jWexjypN/N1RHDxAzgeR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YS4MY73yqz4f3jqL;
	Tue,  7 Jan 2025 16:43:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EF88B1A09E3;
	Tue,  7 Jan 2025 16:43:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9E6XxnpFgeAQ--.43336S4;
	Tue, 07 Jan 2025 16:43:50 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
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
Subject: [PATCH bpf-next 0/7] Free htab element out of bucket lock
Date: Tue,  7 Jan 2025 16:55:52 +0800
Message-Id: <20250107085559.3081563-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl9E6XxnpFgeAQ--.43336S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1kWrW7KrWkWFWxKryrXrb_yoW5WrWrpF
	WrKw15Kr1kJF9FqwnFv3Z5GrWrAwn5Xr4UGr4kKryYkas8WF18tr1I9F4aqFWfAr93AF9a
	vw42yw1fG348u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
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

The patch set is structured as follows:

* Patch #1 moves the element freeing out of lock for
  htab_lru_map_delete_node()
* Patch #2~#3 move the element freeing out of lock for
  __htab_map_lookup_and_delete_elem()
* Patch #4~#6 move the element freeing out of lock for
  htab_map_update_elem()
* Patch #7 adds a selftest for the locking problem

The changes for htab_map_update_elem() require some explanation. The
reason that the previous work [1] can't move the element freeing out of
the bucket lock for preallocated hash table is due to ->extra_elems
optimization. When alloc_htab_elem() returns, the existed-old element
has already been stashed in per-cpu ->extra_elems. To handle that, patch
#5~#7 break the reuse of ->extra_elems and the refill of ->extra_elems
into two independent steps, do resue with bucket lock being held and do
refill after unlocking the bucket lock. The downside is that concurrent
updates on the same CPU may need to pop free element from per-cpu list
instead of reusing ->extra_elems directly, but I think such case will be
rare.

Please see individual patches for more details. Comments are always
welcome.

[1]: https://lore.kernel.org/bpf/20241106063542.357743-1-houtao@huaweicloud.com
[2]: https://lore.kernel.org/bpf/20241106084527.4gPrMnHt@linutronix.de

Hou Tao (7):
  bpf: Free special fields after unlock in htab_lru_map_delete_node()
  bpf: Bail out early in __htab_map_lookup_and_delete_elem()
  bpf: Free element after unlock in __htab_map_lookup_and_delete_elem()
  bpf: Support refilling extra_elems in free_htab_elem()
  bpf: Factor out the element allocation for pre-allocated htab
  bpf: Free element after unlock for pre-allocated htab
  selftests/bpf: Add test case for the freeing of bpf_timer

 kernel/bpf/hashtab.c                          | 170 ++++++++++--------
 .../selftests/bpf/prog_tests/free_timer.c     | 165 +++++++++++++++++
 .../testing/selftests/bpf/progs/free_timer.c  |  71 ++++++++
 3 files changed, 332 insertions(+), 74 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/free_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/free_timer.c

-- 
2.29.2


