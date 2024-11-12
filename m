Return-Path: <bpf+bounces-44626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F0A9C5B27
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 16:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1342B80D2B
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836471FF043;
	Tue, 12 Nov 2024 14:48:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE251F4FA2;
	Tue, 12 Nov 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422898; cv=none; b=Y/FNFdfwYglb5d5kHU1MIki7RdNnuVy+DIs566ekAcvL6Lc2wMn0WgNgNewloELgp3zrvw0UKF3BHFP/0gJa1YX/w87vOZWIsLszY17yCu5s2UNreFk0V1GelizlJk5T8NqTr4AdbBAtRFRbbV15wiynzQYr3oDC8nUvYBl6NVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422898; c=relaxed/simple;
	bh=RzdDctxTzqMyCSoGEwF0H4UR+OejUmtUfAjcIRuuXhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h1PEkZEV6iEdbodSaDSVgTO04lNR08KMR4iiCiwtqvWNMNO6g/NJNXNPI1nOyj8Y9iQjOPLfIZckd70FAsM7ANPNIV87zIu5VL84hlLAj/aXT9Xs4YXPHOJpYRshuzNPGfhJuQSKplSrJuu5vmkpErgeek/29CmVcdCzBSZAEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xnq5c2jqpz4f3jQv;
	Tue, 12 Nov 2024 22:47:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 93A1C1A0359;
	Tue, 12 Nov 2024 22:48:06 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgBnjoKhajNnscdXBg--.33841S2;
	Tue, 12 Nov 2024 22:48:02 +0800 (CST)
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
Subject: [PATCH bpf-next v4 0/3] Add kernel symbol for struct_ops trampoline
Date: Tue, 12 Nov 2024 22:58:46 +0800
Message-Id: <20241112145849.3436772-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnjoKhajNnscdXBg--.33841S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF45Zry7Kw48XF1fGr48Zwb_yoW8Wr47pF
	4rZr15Cr48trs7u3yfGay7CrWS93y8Xry5Wr9rJw1fCFy2qr1DCryIgr43uryaqF9Ik34r
	JF9I9FyYka4UZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07jeLvtUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

Add kernel symbol for struct_ops trampoline.

Without kernel symbol for struct_ops trampoline, the unwinder may
produce unexpected stacktraces. For example, the x86 ORC and FP
unwinder stops stacktrace on a struct_ops trampoline address since
there is no kernel symbol for the address.

v4:
- Add a separate cleanup patch to remove unused member rcu from
  bpf_struct_ops_map (patch 1)
- Use funcs_cnt instead of btf_type_vlen(vt) for links memory
  calculation in .map_mem_usage (patch 2)
- Include ksyms[] memory in map_mem_usage (patch 3)
- Various fixes in patch 3 (Thanks to Martin)

v3: https://lore.kernel.org/bpf/20241111121641.2679885-1-xukuohai@huaweicloud.com/
- Add a separate cleanup patch to replace links_cnt with funcs_cnt
- Allocate ksyms on-demand in update_elem() to stay with the links
  allocation way
- Set ksym name to prog__<struct_ops_name>_<member_name>

v2: https://lore.kernel.org/bpf/20241101111948.1570547-1-xukuohai@huaweicloud.com/
- Refine the commit message for clarity and fix a test bot warning

v1: https://lore.kernel.org/bpf/20241030111533.907289-1-xukuohai@huaweicloud.com/

Xu Kuohai (3):
  bpf: Remove unused member rcu from bpf_struct_ops_map
  bpf: Use function pointers count as struct_ops links count
  bpf: Add kernel symbol for struct_ops trampoline

 include/linux/bpf.h         |   3 +-
 kernel/bpf/bpf_struct_ops.c | 115 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c     |   3 +-
 kernel/bpf/trampoline.c     |   9 ++-
 4 files changed, 114 insertions(+), 16 deletions(-)

-- 
2.39.5


