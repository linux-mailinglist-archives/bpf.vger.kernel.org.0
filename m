Return-Path: <bpf+bounces-49795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9828A1C2DB
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660EB188C5AA
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF8C208965;
	Sat, 25 Jan 2025 10:59:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDE82080D6
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802758; cv=none; b=iZfuw5UXJ1DQpS9tR6FuX9d5R93O+mnHUXFqHUzxDtBUTnxJQmfDGiGAfr6VjoWQIehJxKNQz839Pfr4lPggsiHAv/qrU7pwsAnCbCm05B/DDpAWtjUaRSQzt4ALEf49rk9+XT+o76lbJtTq38H9GIug4CIfPtDul1/P+iod+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802758; c=relaxed/simple;
	bh=PpFo6WYjgz7E18d2RYyWG3VXRlh7WW82nRQZ+wTjcOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aI92AY47no8OSmI0M8qOYduMTscsOkV0rITVFevULUz66MrR6zNTb+UQWk/lFA+boJ9Nww3ZbL4S2rPrIp44hn4SXOUFYbm46mNLvTmyk58mo6SwhSjbdOsrKrN6iXSatzJ3JhOxgYTKzp0bSglneLL9pgE52iYahKaD9/2OWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YgBWH0hh2z4f3jks
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9D6F21A1658
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S10;
	Sat, 25 Jan 2025 18:59:06 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v2 06/20] bpf: Set BPF_INT_F_DYNPTR_IN_KEY conditionally
Date: Sat, 25 Jan 2025 19:10:55 +0800
Message-Id: <20250125111109.732718-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250125111109.732718-1-houtao@huaweicloud.com>
References: <20250125111109.732718-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4UKF1kJr43JryDur1ftFb_yoW8AFyDpr
	4rGFWS9r4FkFZFvrsxJa1Y93yYyw4xG34UCry2934SkFnrJry2gw1IgayrWr13KryUGrZa
	qF4qgFyrK34xZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When there is bpf_dynptr field in the map key btf type or the map key
btf type is bpf_dyntr, set BPF_INT_F_DYNPTR_IN_KEY in map_flags.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 07c67ad1a6a07..46b96d062d2db 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1360,6 +1360,34 @@ static struct btf *get_map_btf(int btf_fd)
 	return btf;
 }
 
+static int map_has_dynptr_in_key_type(struct btf *btf, u32 btf_key_id, u32 key_size)
+{
+	const struct btf_type *type;
+	struct btf_record *record;
+	u32 btf_key_size;
+
+	if (!btf_key_id)
+		return 0;
+
+	type = btf_type_id_size(btf, &btf_key_id, &btf_key_size);
+	if (!type || btf_key_size != key_size)
+		return -EINVAL;
+
+	/* For dynptr key, key BTF type must be struct */
+	if (!__btf_type_is_struct(type))
+		return 0;
+
+	if (btf_type_is_dynptr(btf, type))
+		return 1;
+
+	record = btf_parse_fields(btf, type, BPF_DYNPTR, key_size);
+	if (IS_ERR(record))
+		return PTR_ERR(record);
+
+	btf_record_free(record);
+	return !!record;
+}
+
 #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
@@ -1398,6 +1426,14 @@ static int map_create(union bpf_attr *attr)
 		btf = get_map_btf(attr->btf_fd);
 		if (IS_ERR(btf))
 			return PTR_ERR(btf);
+
+		err = map_has_dynptr_in_key_type(btf, attr->btf_key_type_id, attr->key_size);
+		if (err < 0)
+			goto put_btf;
+		if (err > 0) {
+			attr->map_flags |= BPF_INT_F_DYNPTR_IN_KEY;
+			err = 0;
+		}
 	}
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
-- 
2.29.2


