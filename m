Return-Path: <bpf+bounces-44509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E949C3DEE
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 13:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4BF1F21F8F
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B831991CB;
	Mon, 11 Nov 2024 12:05:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013C15539A;
	Mon, 11 Nov 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326757; cv=none; b=s3tpSmtSqAZp1ZPPclevrzSKUObYihCC4cbuIVsvH4RnZHW7QyVQdp5htgCJgumGzw3qplYApvl3dP+yJEMvqegtubbT/4O/sxmQukR6rs6gEkaiFC7sRuPI85HcC8FoanhEP0YrD0sb2spJ78WFCxPCTWBpG8yhRSj/51S9yes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326757; c=relaxed/simple;
	bh=MYhkEuGlLnWIHEQEeZArJBwqVSZO65IHRjZwLQcRsNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dCyFqs4fN/xYy8VNk3rCDbh2ToxohO3xFXPswwAtXMHEX28zTmSw5RxKtXN8g+pgTXqMU2f4KkPuolW+Nto67yVjbJo77Bp9ha0CfjEgGb83NKM+gHZAhMQgOi1WQTM/owDVpuzbGjyBN5Tl/wAPCnOifJLHExfkxmlfmgqmNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xn7Xs1BDXz4f3jcx;
	Mon, 11 Nov 2024 20:05:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 520ED1A0359;
	Mon, 11 Nov 2024 20:05:51 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgBH9uIc8zFnxbLkBQ--.11390S2;
	Mon, 11 Nov 2024 20:05:50 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v3 0/2] Add kernel symbol for struct_ops trampoline
Date: Mon, 11 Nov 2024 20:16:39 +0800
Message-Id: <20241111121641.2679885-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBH9uIc8zFnxbLkBQ--.11390S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyfZFyfAr45Kr1UAr1UZFb_yoWkurXEkr
	W3try3Gr1kG3ZagFWF9r1xWFWvkw45JryrXF4UtrW3Zrn8Xw1xJrn8GFy3XFyDXa97KrWU
	X3s3Zwn7Zr13XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
	IYCTnIWIevJa73UjIFyTuYvjxU2MmhUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add kernel symbol for struct_ops trampoline.

Without kernel symbol for struct_ops trampoline, the unwinder may
produce unexpected stacktraces. For example, the x86 ORC and FP
unwinder stops stacktrace on a struct_ops trampoline address since
there is no kernel symbol for the address.

v3:
- Add a separate cleanup patch to replace links_cnt with funcs_cnt
- Allocate ksyms on-demand in update_elem() to stay with the links
  allocation way
- Set ksym name to prog__<struct_ops_name>_<member_name>

v2: https://lore.kernel.org/bpf/20241101111948.1570547-1-xukuohai@huaweicloud.com/
- Refine the commit message for clarity and fix a test bot warning

v1: https://lore.kernel.org/bpf/20241030111533.907289-1-xukuohai@huaweicloud.com/

Xu Kuohai (2):
  bpf: Use function pointers count as struct_ops links count
  bpf: Add kernel symbol for struct_ops trampoline

 include/linux/bpf.h         |   3 +-
 kernel/bpf/bpf_struct_ops.c | 114 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c     |   3 +-
 kernel/bpf/trampoline.c     |   9 ++-
 4 files changed, 114 insertions(+), 15 deletions(-)

-- 
2.39.5


