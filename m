Return-Path: <bpf+bounces-48774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E6FA10896
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A2518839CF
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760501411EB;
	Tue, 14 Jan 2025 14:06:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D23C130E58
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863610; cv=none; b=f41Dc3pLLeUIPGC0NXQOVCWTBMFA949FToyhhyJGWvOz+MQR+V9OOaXQJgbjbnVX/o1k0GbQF4tYnVkFESXEhAa6HqbNsOgI86fHhDqOkudbGx3FiwUi2ljZCznaKYYj3jbp8r2CgAkpUw0FKiF3EaJHLHfiZHwvYLzpOYC89lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863610; c=relaxed/simple;
	bh=N2h2t85gdytpw1ZRM8jnukQd03nHoS20+cpXsdKi43Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iXEJz81VBZXOQ+3Lh7itPlQKI/8+NtvMa3s+10yWc2EHbHJq6vT63kBtZiRkqCFW8263iXHBdPd6THECzxIbdL5KOsgFY8VPPfKgdia8bU3J02ltpkFD/iQvTJOdqurFR6AZn+/kgNQFmmfwgvXEZiYlnMhEOuE0Y1Y1hDPHLEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YXWBm30jHz4f3jdS
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 22:06:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C708C1A1586
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 22:06:44 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgCnsWRzb4ZnzsHBAw--.3782S2;
	Tue, 14 Jan 2025 22:06:44 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf 1/2] libbpf: Fix return zero when elf_begin failed
Date: Tue, 14 Jan 2025 14:09:30 +0000
Message-Id: <20250114140931.3844196-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnsWRzb4ZnzsHBAw--.3782S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr17uw18GFykuF47CF1kuFg_yoW3WrcEka
	4xGr1fKrW5Gry3Zw15CrZIgFW8GFs0gFnaqFs8trZ0ka1DKwn5CFsrZ3s7tFZxG3y2qFya
	gF95Wr4fXr43KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

The error number of elf_begin is omitted when encapsulating the
btf_find_elf_sections function.

Fixes: c86f180ffc99 ("libbpf: Make btf_parse_elf process .BTF.base transparently")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/lib/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 12468ae0d573..7e810fa468ea 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1186,6 +1186,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 
 	elf = elf_begin(fd, ELF_C_READ, NULL);
 	if (!elf) {
+		err = -LIBBPF_ERRNO__FORMAT;
 		pr_warn("failed to open %s as ELF file\n", path);
 		goto done;
 	}
-- 
2.34.1


