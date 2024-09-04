Return-Path: <bpf+bounces-38887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37596BFEA
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429DE1C2313A
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E269A1DEFC0;
	Wed,  4 Sep 2024 14:17:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400F1DCB0C;
	Wed,  4 Sep 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459439; cv=none; b=MKeLQLnwObelDrhah7b/6t/uRklwsltobjKgS4mg9DreMCcf1bK0p3asZpGWbrdXSpznFW8CFxr6RIbCxMu9id27ndA+hAkJSvWHoT0EUHDSmIn5jvkENC4wJ89Q8n2FC9tudy3VAoqPj1oxuZJBxnnIjmtADawl4dddXeOtGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459439; c=relaxed/simple;
	bh=ttF0Nb3+Dw+vOf1SBhB/FoPmd3s2a6Sjbaba0B+eIr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OA4e2IDEIsQlIEThva6fZCWt0MfTpmIrPzNk9G9fjBS34cfoIilsMq/q4fJH0+QUB6ZpXX3qFjk6iewRTzKZfoLz0kV35MTQfqz1X/bHkqAxOMY8km9/2oIBPtCkOyowUvvjcMn5YLu9XTqqxBihFAn1U9dayqTceK8p5TdV2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WzPgt1WjNz4f3k6f;
	Wed,  4 Sep 2024 22:16:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7F74E1A09FC;
	Wed,  4 Sep 2024 22:17:08 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBnvIjfa9hmXCB4AQ--.21574S2;
	Wed, 04 Sep 2024 22:17:04 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v2 00/10] Local vmtest enhancement and RV64 enabled
Date: Wed,  4 Sep 2024 14:19:41 +0000
Message-Id: <20240904141951.1139090-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnvIjfa9hmXCB4AQ--.21574S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGryfJFWUtw1ftr4xZFW5Wrg_yoW5AF4fpa
	y8Gw1Ykr1SqF13tFnrCrWUWF1ftF4kZrW3Cw1xJw15A3WDtFyktrs29F4rXwnxWF95Xr4r
	A3s2kFy3u3W8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

Patch 1-3 fix some problem about bpf selftests. Patch 4 add local rootfs
image support for vmtest. Patch 5 enable cross-platform testing for
vmtest. Patch 6-10 enable vmtest on RV64.

We can now perform cross platform testing for riscv64 bpf using the
following command:

PLATFORM=riscv64 CROSS_COMPILE=riscv64-linux-gnu- \
  tools/testing/selftests/bpf/vmtest.sh \
  -l <path of local rootfs image> -- \
  ./test_progs -d \
      \"$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 \
          | cut -d'#' -f1 \
          | sed -e 's/^[[:space:]]*//' \
                -e 's/[[:space:]]*$//' \
          | tr -s '\n' ',' \
      )\"

For better regression, we rely on commit [0] [1]. And since the work of riscv
ftrace to remove stop_machine atomic replacement is in progress, we also
need to revert commit [2] [3].

The test platform is x86_64 architecture, and the versions of relevant
components are as follows:
    QEMU: 8.2.0
    CLANG: 17.0.6 (align to BPF CI)
    ROOTFS: ubuntu noble (generated by [4])

Link: https://lore.kernel.org/all/20240831071520.1630360-1-pulehui@huaweicloud.com/ [0]
Link: https://lore.kernel.org/all/20240831041934.1629216-1-pulehui@huaweicloud.com/ [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3308172276db [2]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7caa9765465f [3]
Link: https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh [4]

v2:
- Drop patch about relaxing Zbb insns restrictions.
- Add local rootfs image support
- Add description about running vmtest on RV64 
- Fix some problem about bpf selftests

v1: https://lore.kernel.org/all/20240328124916.293173-1-pulehui@huaweicloud.com/

Pu Lehui (10):
  selftests/bpf: Adapt OUTPUT appending logic to lower versions of Make
  selftests/bpf: Rename fallback in bpf_dctcp to avoid naming conflict
  selftests/bpf: Disable feature-llvm for vmtest
  selftests/bpf: Limit URLS parsing logic to actual scope in vmtest
  selftests/bpf: Support local rootfs image for vmtest
  selftests/bpf: Enable cross platform testing for vmtest
  selftests/bpf: Add config.riscv64
  selftests/bpf: Add DENYLIST.riscv64
  selftests/bpf: Add riscv64 configurations to local vmtest
  selftests/bpf: Add description for running vmtest on RV64

 tools/testing/selftests/bpf/DENYLIST.riscv64  |   3 +
 tools/testing/selftests/bpf/Makefile          |   8 ++
 tools/testing/selftests/bpf/README.rst        |  32 ++++-
 tools/testing/selftests/bpf/config.riscv64    |  84 ++++++++++++++
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |   2 +-
 tools/testing/selftests/bpf/progs/bpf_dctcp.c |   8 +-
 tools/testing/selftests/bpf/vmtest.sh         | 109 ++++++++++++------
 7 files changed, 205 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.riscv64
 create mode 100644 tools/testing/selftests/bpf/config.riscv64

-- 
2.34.1


