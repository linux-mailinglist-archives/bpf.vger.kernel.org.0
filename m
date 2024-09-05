Return-Path: <bpf+bounces-38987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC2796D1AB
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8771C22D05
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4273199251;
	Thu,  5 Sep 2024 08:11:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E05199922;
	Thu,  5 Sep 2024 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523885; cv=none; b=BP9sS2HR6FTVFxin8qyG9iShvBDE1832vvkg5HqUqZTB5hMPX5C+4BkB2CLxQwEsM0Nx0BrwrONXTWOurN1iY+VpWoReJOymJCImAukwOMbdk/RWe+13SvAFEdxuoZ5EGDUz/6OmyxYCa4/wtiUvqahAJeUXL+lTLioB2GvHHN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523885; c=relaxed/simple;
	bh=MAMCXxSFk/8QfgNIlep+F4klnQRMMWQm6X2qmcjw/uM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p890ihvffWBg9cV3JobLaWP5ZZl/C5vmCxBN5MyIuP8rKmdUb7SZ8+rYDNTbPsLMj//w2YuHWuG0INNdUcxs8n0E1SC1kuXfmBqSwCvdkv9ZFZUAyPOuA1DpEii+SADLjKgIMXaXVBrL5yqceOAqyQYcJPHQgVDUeW/Y5GmVvbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WzsWF6BQwz4f3jYR;
	Thu,  5 Sep 2024 16:11:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E3F0B1A018D;
	Thu,  5 Sep 2024 16:11:20 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgD3Ii+gZ9lmMQ7AAQ--.26932S12;
	Thu, 05 Sep 2024 16:11:20 +0800 (CST)
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
Subject: [PATCH bpf-next v3 10/10] selftests/bpf: Add description for running vmtest on RV64
Date: Thu,  5 Sep 2024 08:14:01 +0000
Message-Id: <20240905081401.1894789-11-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905081401.1894789-1-pulehui@huaweicloud.com>
References: <20240905081401.1894789-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3Ii+gZ9lmMQ7AAQ--.26932S12
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7Jr4kAFWUJrWftF47urg_yoW8Cw4Upw
	s5A34akr1SgF1aqF1fCrW7XF4Fqrs3XrWUGF1xGw15u3W5JFykXrn2yayjvanxuFZYvrsI
	ya4aqFyY9w18ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jIPfQUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Add description in tools/testing/selftests/bpf/README.rst
for running vmtest on RV64.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/README.rst | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index 4a1e74b17109..776fbe3cb8f9 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -85,6 +85,38 @@ In case of linker errors when running selftests, try using static linking:
           If you want to change pahole and llvm, you can change `PATH` environment
           variable in the beginning of script.
 
+Running vmtest on RV64
+======================
+To speed up testing and avoid various dependency issues, it is recommended to
+run vmtest in a Docker container. Before running vmtest, we need to prepare
+Docker container and local rootfs image. The overall steps are as follows:
+
+1. Create Docker container as shown in link [0].
+
+2. Use mkrootfs_debian.sh script [1] to build local rootfs image:
+
+.. code-block:: console
+
+  $ sudo ./mkrootfs_debian.sh --arch riscv64 --distro noble
+
+3. Start Docker container [0] and run vmtest in the container:
+
+.. code-block:: console
+
+  $ PLATFORM=riscv64 CROSS_COMPILE=riscv64-linux-gnu- \
+    tools/testing/selftests/bpf/vmtest.sh \
+    -l <path of local rootfs image> -- \
+    ./test_progs -d \
+        \"$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 \
+            | cut -d'#' -f1 \
+            | sed -e 's/^[[:space:]]*//' \
+                  -e 's/[[:space:]]*$//' \
+            | tr -s '\n' ',' \
+        )\"
+
+Link: https://github.com/pulehui/riscv-bpf-vmtest.git [0]
+Link: https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh [1]
+
 Additional information about selftest failures are
 documented here.
 
-- 
2.34.1


