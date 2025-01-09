Return-Path: <bpf+bounces-48362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DF5A06DFB
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 07:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79FD18893B9
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 06:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C77214A6D;
	Thu,  9 Jan 2025 06:07:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C3F25949C;
	Thu,  9 Jan 2025 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736402826; cv=none; b=vB7qAJSf2sw6qAVH/QtelXQ2my5EJ1KbMxYwFI50Kaxs7UNXJFrI1IdOJvQGeTOXaoKFfPBXuKLidamEHA5nyAylxJq9CN1NCEszyiJl/us+F2tjPPgY/fwI6ar/r/+Hw+KySUIKJHnmcHfWubUCu6Id9vA7ovZPk7wtKzmz+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736402826; c=relaxed/simple;
	bh=+w0ikBjCKJWVRtaVV5gxhAxXNOz8jhk5coyiupP5qVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G+BIleEc9Qlqi+W2lTIJMe2CCdlRd+6egxq8p+3qLAjuowEjIsC9iO7ThRfkM+df82UsPaA/skBXeg0YMRYezq53EfR9+oXNzl0jZL+rNlRphB/P3aXLD1wu5DuQxP3y9UCSQ3OdyEECOLu14PMP1DCjt3dPFHlmf5CByeUPHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YTDnN5TY1z4f3jLP;
	Thu,  9 Jan 2025 14:06:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2E9E41A13F0;
	Thu,  9 Jan 2025 14:06:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAni196Z39nvD3QAQ--.4010S4;
	Thu, 09 Jan 2025 14:06:52 +0800 (CST)
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
Subject: [PATCH bpf-next v2 0/5] Free htab element out of bucket lock
Date: Thu,  9 Jan 2025 14:18:56 +0800
Message-Id: <20250109061901.2620825-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni196Z39nvD3QAQ--.4010S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4xKryUuF1fXrWrurWrGrg_yoW8tr1kpF
	WrKw13Kr1vgFn2qw1ag3Z5GryrAws5JF15GF4UKw45Aas5XFyktr1I9F4YqF4fAr93ZrZa
	va17trs3W348C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
However, the patch set still keep the free of special fields in
pre-allocated hash map under the protect of bucket log in
htab_map_update_elem().

The patch set is structured as follows:

* Patch #1 moves the element freeing out of lock for
  htab_lru_map_delete_node()
* Patch #2~#3 move the element freeing out of lock for
  __htab_map_lookup_and_delete_elem()
* Patch #4 cancels the bpf_timer in two steps to fix the locking
  problem in htab_map_update_elem().
* Patch #5 adds a selftest for the locking problem

Please see individual patches for more details. Comments are always
welcome.

v2:
  * cancels the bpf timer in two steps instead of breaking the reuse
    the refill of per-cpu ->extra_elems into two steps

v1: https://lore.kernel.org/bpf/20250107085559.3081563-1-houtao@huaweicloud.com

Hou Tao (5):
  bpf: Free special fields after unlock in htab_lru_map_delete_node()
  bpf: Bail out early in __htab_map_lookup_and_delete_elem()
  bpf: Free element after unlock in __htab_map_lookup_and_delete_elem()
  bpf: Cancel the running bpf_timer through kworker
  selftests/bpf: Add test case for the freeing of bpf_timer

 kernel/bpf/hashtab.c                          |  60 ++++---
 kernel/bpf/helpers.c                          |  17 +-
 .../selftests/bpf/prog_tests/free_timer.c     | 165 ++++++++++++++++++
 .../testing/selftests/bpf/progs/free_timer.c  |  71 ++++++++
 4 files changed, 280 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/free_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/free_timer.c

-- 
2.29.2


