Return-Path: <bpf+bounces-48916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0F1A11EBD
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 11:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77491886754
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890E2361C9;
	Wed, 15 Jan 2025 10:00:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71091DB14D
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935200; cv=none; b=AwTZGfbwjhj1/cN6BIY0hTqillb+1DXzxIbrzsCl9K2mflmfk2a+pmYlUIc1ufG0zvdYhdKFggvw37CYJ10/gWD9LpaDGNi5l2DUDi4toUb7yEYO+1ZA3p7hCcCkaS6HQqgi9XI+9fMU4KtkOO46AgOE/XgCECkEv/9HZkcVNGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935200; c=relaxed/simple;
	bh=WVdQNMNpanAWC0NScMZ8KYPhzeEMN3+PJRlQcWSgLVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qnyEx+QDVyrM3We9nvpJVPOP8MJF5D/b4pXrpNCEEWwkzMHXm0q+Ean/VSVvl9XSoUb2F1RbWcv9W23YSqPoUaG7tCLGJkCBedDRM8gvGj6DW0bN6xgAcD0oTeYYsBHoW1GfXcZBd9JOubnIn7RJ+8ZHzQsYKu7Wdw88JeoHSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YY1gT48vxz4f3khQ
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 17:59:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id F05211A14DA
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 17:59:53 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgAHWcMYh4dnLOEBBA--.46150S4;
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
Subject: [PATCH bpf v2 3/4] libbpf: Fix incorrect traversal end type ID when marking BTF_IS_EMBEDDED
Date: Wed, 15 Jan 2025 10:02:40 +0000
Message-Id: <20250115100241.4171581-3-pulehui@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAHWcMYh4dnLOEBBA--.46150S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy7AFW8GF18WrW7Gw17KFg_yoW8GFykpF
	47G3y8Kw1rJw4Iqw1vg3WFyay3Gw4Sq3yjkrWqgw4FvFs0gwn8KF4xZFs5Ar4fWr48t3y7
	ZFZI9ryY9w1kAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

When redirecting the split BTF to the vmlinux base BTF, we need to mark
the distilled base struct/union members of split BTF structs/unions in
id_map with BTF_IS_EMBEDDED. This indicates that these types must match
both name and size later. Therefore, we need to traverse the entire
split BTF, which involves traversing type IDs from nr_dist_base_types to
nr_types. However, the current implementation uses an incorrect
traversal end type ID, so let's correct it.

Fixes: 19e00c897d50 ("libbpf: Split BTF relocation")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v2: make commit description more sense.

 tools/lib/bpf/btf_relocate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index b72f83e15156..53d1f3541bce 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -212,7 +212,7 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 	 * need to match both name and size, otherwise embedding the base
 	 * struct/union in the split type is invalid.
 	 */
-	for (id = r->nr_dist_base_types; id < r->nr_split_types; id++) {
+	for (id = r->nr_dist_base_types; id < r->nr_dist_base_types + r->nr_split_types; id++) {
 		err = btf_mark_embedded_composite_type_ids(r, id);
 		if (err)
 			goto done;
-- 
2.34.1


