Return-Path: <bpf+bounces-38891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737196BFF4
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 16:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5494628608F
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF261DFE1D;
	Wed,  4 Sep 2024 14:17:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764541DEFD1;
	Wed,  4 Sep 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459443; cv=none; b=LkF9sOTz6aiZ+ZWpimYqJNmWxJiXiL2MqLzww/mRZwXGR9GMYHMC/apSgBWsuc1ULnInrODnwvBmgi+EtDasY28f2bn8ZDHv70OH82qJswApcy/ZHM5KYVSkVHvUgdBoPyHXjgLskuC1cMdwucGaNcm5KIhCpxkAkpTVMwEPj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459443; c=relaxed/simple;
	bh=hpJy3cS+1YGQz+sxKYG4OYLjajVPhz9jkx7zR1Xvjjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XL1POPE+1JLkNJ9hpVYKX6Bax861iiF7eQJrMlbLLICXtxDUFKzOUOnJ/Xx/EDtsMEcxhwoVR+jj7Sf0ZXxbXumMLP2HuCSGpiNlGFkKBYd43sLrSCKJi4X0QnW2Ozy8VbVFrbjpbQOqSu7m76Pj6CI9vcwoXl/wULKJrAqwEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WzPgr6t4Mz4f3lfr;
	Wed,  4 Sep 2024 22:16:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CD4461A1774;
	Wed,  4 Sep 2024 22:17:12 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBnvIjfa9hmXCB4AQ--.21574S11;
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
Subject: [PATCH bpf-next v2 09/10] selftests/bpf: Add riscv64 configurations to local vmtest
Date: Wed,  4 Sep 2024 14:19:50 +0000
Message-Id: <20240904141951.1139090-10-pulehui@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBnvIjfa9hmXCB4AQ--.21574S11
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4xJw13ZryDJw4kCF1xZrb_yoW8Gryxpw
	s5ZryakryFgr1agFn7CrWjgFW5KFs5ur4fX3y8X343Zr1SqFyxXr93t3W8trs8WFWFqrW5
	Aa4xKry5ur18Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Add riscv64 configurations to local vmtest.

We can now perform cross platform testing for riscv64 bpf using the
following command:

PLATFORM=riscv64 CROSS_COMPILE=riscv64-linux-gnu- vmtest.sh \
    -l ./libbpf-vmtest-rootfs-2024.08.30-noble-riscv64.tar.zst -- \
    ./test_progs -d \
        \"$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 \
            | cut -d'#' -f1 \
            | sed -e 's/^[[:space:]]*//' \
                  -e 's/[[:space:]]*$//' \
            | tr -s '\n' ','\
        )\"

Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 3f8cd7ff891c..8aa9a3030f30 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -34,6 +34,15 @@ aarch64)
 	BZIMAGE="arch/arm64/boot/Image"
 	ARCH="arm64"
 	;;
+riscv64)
+	# required qemu version v7.2.0+
+	QEMU_BINARY=qemu-system-riscv64
+	QEMU_CONSOLE="ttyS0,115200"
+	HOST_FLAGS=(-M virt -cpu host -enable-kvm -smp 8)
+	CROSS_FLAGS=(-M virt -cpu rv64,sscofpmf=true -smp 8)
+	BZIMAGE="arch/riscv/boot/Image"
+	ARCH="riscv"
+	;;
 *)
 	echo "Unsupported architecture"
 	exit 1
-- 
2.34.1


