Return-Path: <bpf+bounces-38885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC5A96BFE7
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 16:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3071C24E6C
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92651DCB10;
	Wed,  4 Sep 2024 14:17:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D11DC19A;
	Wed,  4 Sep 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459437; cv=none; b=XU+DZlalhr3CpHo6E2r1TAO2YCwmwsq5mEf9HydExoAMHz1WkEBM/0+YRizzwmjvAt8Cr8SthjO+1Ta7byNf5YrtGua0H7jQde/bIG2u8fS6LNOl9gHBCUH9qvMTrTE5s6lshU2L2DHSFl3nC0If9X7sP6n+OkX3TcZBkKtc4W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459437; c=relaxed/simple;
	bh=MAMCXxSFk/8QfgNIlep+F4klnQRMMWQm6X2qmcjw/uM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADmWDD8Af8tg8UQ14t+/kHCI1l7hTCF1ujFtyWsAml0axaFjuR7thq4GqdsaocYDL9kT4t6pna/JmpsZmSb4GB9IEj5Rrh+t+l9OyDFAdm6Ti/+2G/FeMlVJpBv4zHbaYzQvJw06xWv1vDseLpjc96RKPTDIW5OIhpntdEI+wDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WzPgs6flwz4f3jHk;
	Wed,  4 Sep 2024 22:16:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E9F6D1A094E;
	Wed,  4 Sep 2024 22:17:12 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBnvIjfa9hmXCB4AQ--.21574S12;
	Wed, 04 Sep 2024 22:17:12 +0800 (CST)
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
Subject: [PATCH bpf-next v2 10/10] selftests/bpf: Add description for running vmtest on RV64
Date: Wed,  4 Sep 2024 14:19:51 +0000
Message-Id: <20240904141951.1139090-11-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904141951.1139090-1-pulehui@huaweicloud.com>
References: <20240904141951.1139090-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnvIjfa9hmXCB4AQ--.21574S12
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7Jr4kAFWUJrWftF47urg_yoW8Cw4Upw
	s5A34akr1SgF1aqF1fCrW7XF4Fqrs3XrWUGF1xGw15u3W5JFykXrn2yayjvanxuFZYvrsI
	ya4aqFyY9w18ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
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


