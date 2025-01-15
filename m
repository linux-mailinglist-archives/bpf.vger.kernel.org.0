Return-Path: <bpf+bounces-48918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C5BA11EC0
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 11:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50351678CE
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EE923F27A;
	Wed, 15 Jan 2025 10:00:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F204623F271
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935205; cv=none; b=oiXF3yip2jLy4SCzC6xEEIUzinzYRkH48ox5soKygaUSbHInl56HB0X2XvUMzBr+6VgTJdN0Eloz/4StQ6B9lpDVXWt8AOdD0iFFQq6ozHnW8XofpwgEILpuXoYkt4E5yH03O8c2EbYqHBqeNnnlD/4jIG1bOY42YEmBnGYmgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935205; c=relaxed/simple;
	bh=N2h2t85gdytpw1ZRM8jnukQd03nHoS20+cpXsdKi43Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GR7cKOCFz3g29VnEdM/ZnN32+4TYyyTImtfYQeM3HyWp0VeoEJadWAawrTCfsfqRqLluuKwYKfMytuPAzJHic7O1RIf6voHdWaVODp2SFMImwhxhixj4kPdhJOGXcSB590Exfa4lFtWupjIlTdupf8SSTLgEJsTLfIXJsPlFmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YY1gZ5CSWz4f3jt0
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 17:59:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E42E71A0CBF
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 17:59:53 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgAHWcMYh4dnLOEBBA--.46150S3;
	Wed, 15 Jan 2025 17:59:53 +0800 (CST)
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
Subject: [PATCH bpf v2 2/4] libbpf: Fix return zero when elf_begin failed
Date: Wed, 15 Jan 2025 10:02:39 +0000
Message-Id: <20250115100241.4171581-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115100241.4171581-1-pulehui@huaweicloud.com>
References: <20250115100241.4171581-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHWcMYh4dnLOEBBA--.46150S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZr17uw18GFykuF47CF1kuFg_yoW3WrcEka
	4xGr1fKrW5Gry3Zw15CrZIgFW8GFs0gFnaqFs8trZ0ka1DKwn5CFsrZ3s7tFZxG3y2qFya
	gF95Wr4fXr43KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUjrHUDUUUUU==
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


