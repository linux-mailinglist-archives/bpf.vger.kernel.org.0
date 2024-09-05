Return-Path: <bpf+bounces-38980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7396D19F
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118261F2A2E7
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB790199943;
	Thu,  5 Sep 2024 08:11:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C172198A2A;
	Thu,  5 Sep 2024 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523883; cv=none; b=M897cW6tETssvsS+0ukP2/6koQukDkinn8r18Dr0V2n1jXeVIAqyPmuH8928tx1b0jVw1YNbJvX8/D7GLAVs1d/HYU2VrXU8ko+yqjjxnIuKd5L+sYNa7Y/wUlqla2gN+6HxvKmBSkaNuJIf1ro2OE1p3qxoBlwYxrFuPgZvXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523883; c=relaxed/simple;
	bh=1f2OmTCaCNMXcN7o8Ou68Z6+cXUNdpu7aj1uCcspoGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VExnjg451U33ZOwe8rBarE0UhoIv/7RNI61OEYxronwcyCOZXqL2rlcYdfpQHchKLSfAC3vsKbXZ1FIk1GJ9gbj3q8ba9GUSKN9/nGUlRcLFsmIInVjllklnJZccQrm9wfemJlggCose6LOt/Zhck9NGG7sHZQDrrTLE37N1OEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WzsWC31QRz4f3jHc;
	Thu,  5 Sep 2024 16:11:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 777931A018D;
	Thu,  5 Sep 2024 16:11:18 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgD3Ii+gZ9lmMQ7AAQ--.26932S3;
	Thu, 05 Sep 2024 16:11:15 +0800 (CST)
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
Subject: [PATCH bpf-next v3 01/10] selftests/bpf: Adapt OUTPUT appending logic to lower versions of Make
Date: Thu,  5 Sep 2024 08:13:52 +0000
Message-Id: <20240905081401.1894789-2-pulehui@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgD3Ii+gZ9lmMQ7AAQ--.26932S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urWxuFyDtFWkArWDXryrWFg_yoW8GF4fpa
	nYkw1Ykr9aqrZrt3WkZrWFgr4rKr4kJay8XF1jqryUXr1xJF97Jr4IkFWjqrn3G3yYqrWf
	Z34xKF9xZ348A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3cTm
	DUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

The $(let ...) function is only supported by GNU Make version 4.4 [0]
and above, otherwise the following exception file or directory will be
generated:

	tools/testing/selftests/bpfFEATURE-DUMP.selftests
	tools/testing/selftests/bpffeature/

Considering that the GNU Make version of most Linux distributions is
lower than 4.4, let us adapt the corresponding logic to it.

Link: https://lists.gnu.org/archive/html/info-gnu/2022-10/msg00008.html [0]
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7660d19b66c2..9905e3739dd0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -187,8 +187,14 @@ FEATURE_TESTS := llvm
 FEATURE_DISPLAY := $(FEATURE_TESTS)
 
 # Makefile.feature expects OUTPUT to end with a slash
+ifeq ($(shell expr $(MAKE_VERSION) \>= 4.4), 1)
 $(let OUTPUT,$(OUTPUT)/,\
 	$(eval include ../../../build/Makefile.feature))
+else
+OUTPUT := $(OUTPUT)/
+$(eval include ../../../build/Makefile.feature)
+OUTPUT := $(patsubst %/,%,$(OUTPUT))
+endif
 endif
 
 ifeq ($(feature-llvm),1)
-- 
2.34.1


