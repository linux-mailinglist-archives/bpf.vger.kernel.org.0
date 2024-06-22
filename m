Return-Path: <bpf+bounces-32796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D5F9131B8
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 05:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8961F235D8
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 03:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C85944E;
	Sat, 22 Jun 2024 03:03:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB64A3E;
	Sat, 22 Jun 2024 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719025388; cv=none; b=EkJjU1/cO2CXnTwnnhAzzx8jdWIVn317zqiRNFVAkqoR/FRFZwCJDSrCkAv1LxhM3wh0UaJyOurHksIT3px3WAzjHNy5UQYpjirwsR4dvSMS5gm904S1/HnL56JkDSgloBCyhYYWFH8qsoduvwnolHfL/1ndLU9L33+y1bfvrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719025388; c=relaxed/simple;
	bh=KldK1Do+NzU9yPXnEUpSwUlsweS5dKV8/imy6lmdY0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bK+sn5shvwU6YnBOlFSEhqXLqiI1lHsZbx9OJrM3H/HHg177/d/Etn0Gsfgv9rxyXOeBbxV6UzwgBkXtxnMqxAOEdpO3uZvpV7CxPXUplGosOpxkTKe52FbYASYJJ5QferFpeNL2Hn8EdSbMaemViXRsfZO0hPeYMOuPN9SvPmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W5fDC1hR3z4f3kw6;
	Sat, 22 Jun 2024 11:02:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2CEAE1A0187;
	Sat, 22 Jun 2024 11:03:03 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgDXa63kPnZmMh5lAg--.15052S2;
	Sat, 22 Jun 2024 11:03:01 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH RESEND bpf-next v2 0/3] Use bpf_prog_pack for RV64 bpf trampoline
Date: Sat, 22 Jun 2024 03:04:34 +0000
Message-Id: <20240622030437.3973492-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXa63kPnZmMh5lAg--.15052S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr43KF1rCFy8Ww4xtw1DZFb_yoW8GFy3pF
	43Ww13Cw1UXr9rWws3W3yUZF1Sqw48X347GrnrJ34rCF4YvFW8urnY9FWFvFyrWF95C3W0
	yr1j9Fy5u3WUZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
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

v2:
- Emit max number of insns for the "im" addr during dry run to solve OOB issue. (Song)

v1: https://lore.kernel.org/all/20240123103241.2282122-1-pulehui@huaweicloud.com/

Pu Lehui (3):
  bpf: Use precise image size for struct_ops trampoline
  riscv, bpf: Fix out-of-bounds issue when preparing trampoline image
  riscv, bpf: Use bpf_prog_pack for RV64 bpf trampoline

 arch/riscv/net/bpf_jit_comp64.c | 57 +++++++++++++++++++++++----------
 kernel/bpf/bpf_struct_ops.c     |  2 +-
 2 files changed, 41 insertions(+), 18 deletions(-)

-- 
2.34.1


