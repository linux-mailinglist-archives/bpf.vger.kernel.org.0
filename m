Return-Path: <bpf+bounces-29829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBF28C702A
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 04:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9934A2832E7
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 02:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C26138E;
	Thu, 16 May 2024 02:02:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A121366
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715824929; cv=none; b=QU48iYQwJChHwjEtLH/yc+rEqupxv05AIv0TtX2G00AQ+CmzEj3NJWkCa85zf0eH7XlqVVP8VKvdpqLuMBLFCC2dTpzBjqyj80gfrD6utLi1qgcOrW+kmMXMy0QsyecflSWan0POnJVbJ3Z+opJVrduENPYjda+Y72XVWhMdRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715824929; c=relaxed/simple;
	bh=ZdfQtgll+RXEod5WN7aVWcux8brf8rPhsc4fymG14cw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=o2AjghExm2CUk7qbQm2d6gkmyFN5fSzoqeiZi1/f1LyOsEA8a9PQbvnPfpFiVADsKc+1OvN42Ry2sZ9TKTrQYbX+R1pkW6GINx/e7udxrnWanoicDGTueO0u4iUgT9sLcFXMM/BHjMi3CFdNjBLTTmg2I+ZEgRrLVXD+L6gzqxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vftcw6dSGz4f3jdV
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 10:01:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9E2B91A0B39
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 10:02:01 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgAnd2kYaUVmfBsfNA--.14397S2;
	Thu, 16 May 2024 10:02:01 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf] MAINTAINERS: Add myself as reviewer of ARM64 BPF JIT
Date: Thu, 16 May 2024 10:09:28 +0800
Message-Id: <20240516020928.156125-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnd2kYaUVmfBsfNA--.14397S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5d7kC6x804xWl14x267AKxVWUJVW8JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

I am working on ARM64 BPF JIT for a while, hence add myself
as reviewer.

Signed-off-by: Xu Kuohai <xukuohai@huaweicloud.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index be7f72766dc6..c626df550480 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3778,6 +3778,7 @@ BPF JIT for ARM64
 M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Puranjay Mohan <puranjay@kernel.org>
+R:	Xu Kuohai <xukuohai@huaweicloud.com>
 L:	bpf@vger.kernel.org
 S:	Supported
 F:	arch/arm64/net/
-- 
2.30.2


