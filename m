Return-Path: <bpf+bounces-26909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9408A6423
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EDA1F22501
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA166D1AF;
	Tue, 16 Apr 2024 06:39:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED026D1B3
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249560; cv=none; b=SqhJz43gzFj8F284q4Lj6HqcPctlF+5u8KOUStK5ByFcoGUHL4+v+haRfkYurc839lEG50cPzHDILAInfMyMB2ET7QycP4VGOUgRpQo3MS49/Yj1F45L4UBHmtATHmumFafw7Arak+ykfyFDd+jPKmu7D9va+IQzcsoilcZbOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249560; c=relaxed/simple;
	bh=xIUFQTDbWPDAbEUk/Aze0JjPjYILInqmwZkgepw2cRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JytujA864UGNmjP7G23S3AEozXSf9yfL+lunHOgRIkTGTlnKqOz/iNcdUQqfv8GpynAtD7BmOCuHfcknojrS16Bo5txqGzAIMxPdAm3RELkLJ9mRr3IlQyVmRiPqOA3AFqZjSRHKY8GWldIVf5M9ZmpnTeTQn4J/425py/SaLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VJZBg3gKJz4f3jdt
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 14:39:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 96FE91A016E
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 14:39:14 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgDnAQsRHR5mMjd4KA--.14140S2;
	Tue, 16 Apr 2024 14:39:14 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: Ivan Babrou <ivan@cloudflare.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 0/2] Fix incorrect bpf runtime stats for arm64 and riscv64
Date: Tue, 16 Apr 2024 14:42:06 +0800
Message-Id: <20240416064208.2919073-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnAQsRHR5mMjd4KA--.14140S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5L7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Fix incorrect bpf runtime stats for arm64 and riscv64.

Xu Kuohai (2):
  bpf, arm64: Fix incorrect runtime stats
  riscv, bpf: Fix incorrect runtime stats

 arch/arm64/net/bpf_jit_comp.c   | 6 +++---
 arch/riscv/net/bpf_jit_comp64.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.40.1


