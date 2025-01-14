Return-Path: <bpf+bounces-48775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3258A1089C
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76213A9095
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B01142633;
	Tue, 14 Jan 2025 14:06:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2861369AA
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863610; cv=none; b=GO/5It4kTpjYFbahoIgMZf21sEfgJNCZxODVzYg3fLDnM+l/J4+J5gcPhPLKee81Ckw9ME+OmFWUNTsj+B3cMHl1THFByZviLPDmQdCydQ+2BRbwfXC6x91WK0XdWWQNrElQU69VzHWigcVoRhg5UwoDyYroVJkm93wVgRS3bXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863610; c=relaxed/simple;
	bh=xuFFfKxlJYFjcEWfz6dNI4DjnnN6bITolBl+ACG8vks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bJ4CMz3MgYHZ0eAacYBrL8f/tZjDbNGQRH6IS+IbdvoE3jxvxGR4FAwIHLfXzi8es71iOle0D1+PzoBtTurNOsf5B8JC3XwUD4V1zkgX7jUMTSXmH8eEb4FrEIFCGOUFN1fXXzYGQYwdIi+s7TpCyaH/deMlnYex41lkdOYVmZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YXWBm3NmNz4f3jdg
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 22:06:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D213B1A157F
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 22:06:44 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgCnsWRzb4ZnzsHBAw--.3782S3;
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
Subject: [PATCH bpf 2/2] libbpf: Fix incorrect iter rounds when marking BTF_IS_EMBEDDED
Date: Tue, 14 Jan 2025 14:09:31 +0000
Message-Id: <20250114140931.3844196-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114140931.3844196-1-pulehui@huaweicloud.com>
References: <20250114140931.3844196-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnsWRzb4ZnzsHBAw--.3782S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww47Zr4DKry5tFyxWr4xtFb_yoW8Jw48pF
	47G3yxKwn5Jw4Igw1vg3WFkay3Cw4Iq3yUCrW29w1rAFsagwn8KF4xXFs5ArWfWF48tw47
	Za9I9ry5uw1kAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	vjDU0xZFpf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

When redirecting the base BTF of the split BTF from the distilled base
BTF to the vmlinux base BTF, we need to mark distilled base struct/union
members of split BTF structs/unions in id_map with BTF_IS_EMBEDDED,
which indicates that these types need to match both name and size later.
But, the current implementation uses the incorrect iter rounds, we need
to correct it to iter from nr_dist_base_types to nr_types.

Fixes: 19e00c897d50 ("libbpf: Split BTF relocation")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
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


