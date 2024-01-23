Return-Path: <bpf+bounces-20076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF5B838C17
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 11:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68782B214C0
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA545D738;
	Tue, 23 Jan 2024 10:32:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0CD5C917;
	Tue, 23 Jan 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005935; cv=none; b=AAnPMaqNn3oSVM2EAZq2GNjVcs1j0QDCM0qTWXXA4c92VfHo0w1xfZTPPPR80aSOrG1R/XHFBUJV8EgjY7pXrVHpc+ZOMmNpxUA2qtjczilYy/9kVK+k1k1P8tSEpcoJyz8lq6IvUKlOFrrYe04ezRQNxcQcUGnEWR57S8ahwq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005935; c=relaxed/simple;
	bh=jdMRE8lFMQG8fdBwiSq4AL+aa9l5xL9dqapHhgCB238=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hA4zZ7Jm0jDmad2ZNoRS1DY9a9gDIDgh/uJwmg9uJeF7hexKAwG2MClobhT0+dGbhVL7sgri+cW5/ugCrGe1QaCkjPYNQy9xFmWEuOscuRna9EYzYm+GeX4g9oa+CSLvKXMQkCKWKhah4yz58BhzZNcpblrNg2NuDv1Gd7qCPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TK3L60HvVz4f3m6r;
	Tue, 23 Jan 2024 18:31:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4FF3D1A01E9;
	Tue, 23 Jan 2024 18:32:04 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgBHaQyfla9ldy79Bg--.53064S2;
	Tue, 23 Jan 2024 18:32:01 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Song Liu <song@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 0/3] Use bpf_prog_pack for RV64 bpf trampoline
Date: Tue, 23 Jan 2024 10:32:38 +0000
Message-Id: <20240123103241.2282122-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHaQyfla9ldy79Bg--.53064S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr43KF1rCFy8Ww4xtw1DZFb_yoW8Gw15pF
	43uw13Cr4jqr9rWrZ3Wa18Zr1Sqw48u3y7Gr9rt34rCasYvFy8ZrnYgr4rAFWrGr95uw1r
	Zryj9ry5ua4UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_
	WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7VUbmsjUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

We used bpf_prog_pack to aggregate bpf programs into huge page to
relieve the iTLB pressure on the system. We can apply it to bpf
trampoline, as Song had been implemented it in core and x86 [0]. This
patch is going to use bpf_prog_pack to RV64 bpf trampoline. Since Song
and Puranjay have done a lot of work for bpf_prog_pack on RV64,
implementing this function will be easy. But one thing to mention is
that emit_call in RV64 will generate the maximum number of instructions
during dry run, but during real patching it may be optimized to 1
instruction due to distance. This is no problem as it does not overflow
the allocated RO image.

Tests about regular trampoline and struct_ops trampoline have passed, as
well as "test_verifier" with no failure cases.

Link: https://lore.kernel.org/all/20231206224054.492250-1-song@kernel.org [0]

Pu Lehui (3):
  bpf: Use precise image size for struct_ops trampoline
  bpf: Keep im address consistent between dry run and real patching
  riscv, bpf: Use bpf_prog_pack for RV64 bpf trampoline

 arch/arm64/net/bpf_jit_comp.c   |  7 ++--
 arch/riscv/net/bpf_jit_comp64.c | 66 +++++++++++++++++++++++----------
 arch/s390/net/bpf_jit_comp.c    |  7 ++--
 arch/x86/net/bpf_jit_comp.c     |  7 ++--
 include/linux/bpf.h             |  4 +-
 kernel/bpf/bpf_struct_ops.c     |  4 +-
 kernel/bpf/trampoline.c         | 43 +++++++++++----------
 7 files changed, 81 insertions(+), 57 deletions(-)

-- 
2.34.1


