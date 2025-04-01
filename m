Return-Path: <bpf+bounces-55033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D893DA77449
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 08:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08BF3A877C
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 06:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713FC1E0DB0;
	Tue,  1 Apr 2025 06:10:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D011D54FE
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743487859; cv=none; b=u8I6DBF/3zBuCWYL4m+9CrKOJZSu+eQnspV1ZOG2Ldjn+YTapqlilAlQzNIcQu1yTep9GY7TzBwWcK54agmyuBQ7odFbYc0NAyqrAfqxc2SKFns2OLmgYW3wIoeDpXUexg0+sCW9+rJ/7p+cnzd35fmlD/pF3P/deuBy4J8Usxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743487859; c=relaxed/simple;
	bh=76D5pxDXBPUDGwERwu+d2qM4CTY6mefQZdDjbOP1UfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YyDSy/J4eiaov6gqsB8wU3x6n1uA53rFG0zzc4usKrOnpyCyhp7CuZFC/tCKxP+zzyl1ulmVgfReJEK6QRTCF9WnNevIbCmGQ+T5tmIYZ6pQ/Ph0/DMdT8Vgru5I8qEWYdyBErogL27LQWB8ZHvfpHg3QOcWbbSPMMOgVV8ijtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZRczy0L3vz4f3m7Y
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 14:10:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B0F6A1A0D1A
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 14:10:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9ig+tnpa6yIA--.16784S4;
	Tue, 01 Apr 2025 14:10:44 +0800 (CST)
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Zvi Effron <zeffron@riotgames.com>,
	Cody Haas <chaas@riotgames.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 0/6] bpf: Support atomic update for htab of maps
Date: Tue,  1 Apr 2025 14:22:44 +0800
Message-Id: <20250401062250.543403-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl9ig+tnpa6yIA--.16784S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4DZr1UWw1xuw4fKF47CFg_yoW8CF4Upa
	yI9F43Kr1ktFnFqw4fGw42ga1rJ3Wktr1UC3Zxtr15Cw40yFyxXr4xKF4Y9r93CryruryF
	vr12gFsxW34kZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The motivation for the patch set comes from the question raised by Cody
Haas [1]. When trying to concurrently lookup and update an existing
element in a htab of maps, the lookup procedure may return -ENOENT
unexpectedly. The first revision of the patch set tried to resolve the
problem by making the insertion of the new element and the deletion of
the old element being atomic from the perspective of the lookup process.
While the solution would benefit all hash maps, it does not fully
resolved the problem due to the immediate reuse issue. Therefore, in v2
of the patch set, it only fixes the problem for fd htab.

Please see individual patches for details. Comments are always welcome.

v3:
 * rebase on bpf_next/for-next
 * add Acked-by tags

v2: https://lore.kernel.org/bpf/20250308135110.953269-1-houtao@huaweicloud.com/
  * only support atomic update for fd htab

v1: https://lore.kernel.org/bpf/20250204082848.13471-1-hotforest@gmail.com

[1]: https://lore.kernel.org/xdp-newbies/CAH7f-ULFTwKdoH_t2SFc5rWCVYLEg-14d1fBYWH2eekudsnTRg@mail.gmail.com/


Hou Tao (6):
  bpf: Factor out htab_elem_value helper()
  bpf: Rename __htab_percpu_map_update_elem to
    htab_map_update_elem_in_place
  bpf: Support atomic update for htab of maps
  bpf: Add is_fd_htab() helper
  bpf: Don't allocate per-cpu extra_elems for fd htab
  selftests/bpf: Add test case for atomic update of fd htab

 kernel/bpf/hashtab.c                          | 148 +++++++-------
 .../selftests/bpf/prog_tests/fd_htab_lookup.c | 192 ++++++++++++++++++
 .../selftests/bpf/progs/fd_htab_lookup.c      |  25 +++
 3 files changed, 289 insertions(+), 76 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_htab_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/fd_htab_lookup.c

-- 
2.29.2


