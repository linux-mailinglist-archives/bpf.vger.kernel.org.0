Return-Path: <bpf+bounces-44107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420A19BDECA
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 07:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BF21C20A99
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 06:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6E719258B;
	Wed,  6 Nov 2024 06:23:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB81917EB
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874218; cv=none; b=WH8GQ0t9l+8IsBpVq8yBnHSCi5us/jIaXH9TM1gPX9AVGqtBLd/ZctCEhkpMFB+uW8K/MXkfM8WpjEI/upHrb03nIG3nn3RckC6uztneqVESVUllb033u+r/eVN8HFs63N695/uA3JeXmB+c4+vEAo3mtJ0RMea7BkUK9QghzOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874218; c=relaxed/simple;
	bh=cUkWZSFd4O/5LYpiy4hUWCGPL2wb05UiCWNCS8ZbM08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QYtRqp3zTk71zYGsFnOW18JK5Q191TT+GcEC9ytsogFncLcJ22dhnF5rRYCzK8tLxDmHJ961Sg3nJDG1qssT3JK3X2ngbY1G+Xf+DgIiqu8KnZdy7oJJBiDwGpdadp5uSDVKJkQjeQmP0prJSQ5C2xI1WTKH/Ab8Q3VjTlhSKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XjwB90BS7z4f3nJm
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 14:23:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D58341A058E
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 14:23:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCngYVhCytn_SX4Aw--.24568S4;
	Wed, 06 Nov 2024 14:23:31 +0800 (CST)
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
Subject: [PATCH bpf-next 0/3] Fix lockdep warning for htab of map
Date: Wed,  6 Nov 2024 14:35:39 +0800
Message-Id: <20241106063542.357743-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngYVhCytn_SX4Aw--.24568S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF47Xw45Jr1xWrW3KFy5CFg_yoW8Gr1xpa
	ykG3W3KFn7AF1aq3W3Ja129rWfG3Z5W3y5Ar1rtr98Zw1DXryxXr1xKFW5ur9xtFZ3ZFn5
	Z34xK3Z3Ga1kArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1aFAJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set fixes a lockdep warning for htab of map. The
warning is found when running test_maps. The warning occurs when
htab_put_fd_value() attempts to acquire map_idr_lock to free the map id
of the inner map while already holding the bucket lock (raw_spinlock_t).

The fix moves the invocation of free_htab_elem() after
htab_unlock_bucket() and adds a test case to verify the solution. Please
see the individual patches for details. Comments are always welcome.

Hou Tao (3):
  bpf: Call free_htab_elem() after htab_unlock_bucket()
  selftests/bpf: Move ENOTSUPP from bpf_util.h
  selftests/bpf: Test the update operations for htab of maps

 kernel/bpf/hashtab.c                          |  56 +++++---
 tools/testing/selftests/bpf/bpf_util.h        |   4 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |   4 -
 .../selftests/bpf/prog_tests/lsm_cgroup.c     |   4 -
 .../selftests/bpf/prog_tests/map_in_map.c     | 132 +++++++++++++++++-
 .../selftests/bpf/prog_tests/sock_addr.c      |   4 -
 .../selftests/bpf/progs/update_map_in_htab.c  |  30 ++++
 tools/testing/selftests/bpf/test_maps.c       |   4 -
 tools/testing/selftests/bpf/test_verifier.c   |   4 -
 9 files changed, 204 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/update_map_in_htab.c

-- 
2.29.2


