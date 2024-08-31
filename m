Return-Path: <bpf+bounces-38658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3321966F41
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 06:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E1E2B21B99
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 04:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613471494C1;
	Sat, 31 Aug 2024 04:16:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051FEF4EB;
	Sat, 31 Aug 2024 04:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725077819; cv=none; b=fODFCvQQ9FCakv6083M3nmjvxK3XcEYPIU5tlqWrcimr9HckKsNbzksftS/Eod5NNCbN1kx6tlxz5w9/EgbIHYaBXAGEYMQ7vkIYBWM9fXnAyu2Uy9EuxvsIhXRqGytiQvaUjrJXyODycBsVF+LGsF1SuC3ZO3+RK8twNX1ES2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725077819; c=relaxed/simple;
	bh=M6vpxdCNP6fEjaROEY5jwyIvUXJz2q9yocQGi5vV1wA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h5ApeSwAnz2pvnNJM1FjeHr+oCvxbtRJMucyXvr6eG5ePA2/KlbA78q17as4QARhj41egNLfXgvzQTkGsDZwM6EYdIKx5XMAm4nNY1abMKdyCdZm05SlP3MRyvV1HREu6z7RYKgORYMVtqBR6fwwaG850PxigdPaQWreHwgzkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WwhY11GR2z4f3l2C;
	Sat, 31 Aug 2024 12:16:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C53CA1A018D;
	Sat, 31 Aug 2024 12:16:52 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgBnT74ymdJmoSHHDA--.65422S2;
	Sat, 31 Aug 2024 12:16:51 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v3 0/4] Fix accessing first syscall argument on RV64
Date: Sat, 31 Aug 2024 04:19:30 +0000
Message-Id: <20240831041934.1629216-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnT74ymdJmoSHHDA--.65422S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1xAr4xGry8Wr4DWr1UGFg_yoWkZrcEkw
	42yr93JrWrCrZxtF4fWr15CrWDK3yUJF18GF4DtrWfCw1xAr97XFsY9r90yas8Wa10gFZx
	Ga9rX34FvrnIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

On RV64, as Ilya mentioned before [0], the first syscall parameter should be
accessed through orig_a0 (see arch/riscv64/include/asm/syscall.h),
otherwise it will cause selftests like bpf_syscall_macro, vmlinux,
test_lsm, etc. to fail on RV64.

Link: https://lore.kernel.org/bpf/20220209021745.2215452-1-iii@linux.ibm.com [0]

v3:
- Fix test case error.

v2: https://lore.kernel.org/all/20240831023646.1558629-1-pulehui@huaweicloud.com/
- Access first syscall argument with CO-RE direct read. (Andrii)

v1: https://lore.kernel.org/all/20240829133453.882259-1-pulehui@huaweicloud.com/

Pu Lehui (4):
  libbpf: Access first syscall argument with CO-RE direct read on s390
  libbpf: Access first syscall argument with CO-RE direct read on arm64
  selftests/bpf: Enable test_bpf_syscall_macro:syscall_arg1 on s390 and
    arm64
  libbpf: Fix accessing first syscall argument on RV64

 tools/lib/bpf/bpf_tracing.h                     | 17 ++++++++++++-----
 .../bpf/prog_tests/test_bpf_syscall_macro.c     |  4 ----
 .../selftests/bpf/progs/bpf_syscall_macro.c     |  2 --
 3 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.34.1


