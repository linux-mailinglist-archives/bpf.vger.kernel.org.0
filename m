Return-Path: <bpf+bounces-37718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AA2959EB1
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 15:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1472827BD
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 13:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39EA19ABA0;
	Wed, 21 Aug 2024 13:31:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7CB1D12F3;
	Wed, 21 Aug 2024 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247101; cv=none; b=DG5cBkbBCJpYbhpyeWkRc03BuHKr4Dbyu/JV6syMh4WllbfdeNduIRK4zYUkv1175JTFL8GgjEHtUGr2iAPjDqGYrwLe3SLrbziHu81vkAU2IV9VuK3xC663pS9Oi6W3yz5fbnQJGi7D0i5NqyOnoZZwb+G9L8QsU9rHn/WwXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247101; c=relaxed/simple;
	bh=tGU73bn1Apngqpjo+6k3rz2NFTzdWknBDBBrfIeKJak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GExxmfI0Y8hNyE/xgo48t7bPSJFWmqiZBDkoTFAw+jspb7YaEHiEShv/0QrgzlvW60pux1Y9zGbguYiaR8U6CzK4wpIx+Kmc194B3HOqkr0tjv30viIiHz8bfSXingA++INpzdh5iSqufIx0gjKZJUHtzDtp8ht9tNtfhJ8GSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowACnEUEi7MVmMRi4CA--.52723S2;
	Wed, 21 Aug 2024 21:31:20 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	delyank@fb.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] bpftool: check for NULL ptr of btf in codegen_subskel_datasecs
Date: Wed, 21 Aug 2024 21:31:12 +0800
Message-Id: <20240821133112.1467721-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnEUEi7MVmMRi4CA--.52723S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw18Zw1fXrW3Jr4kJw45Awb_yoWfAwb_W3
	48Zrn7XF4DJr9rGr4rCryxWry8JFZ5Xa4qyr42qry5JFWYq3W7JF18CrZayFy3Cr9xCry3
	tFZ3Wr98Ka1ayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiWE_tUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

bpf_object__btf() can return NULL value.  If bpf_object__btf returns null,
do not progress through codegen_subskel_datasecs(). This avoids a null ptr
dereference.

Found by code review, complie tested only.

Cc: stable@vger.kernel.org
Fixes: 00389c58ffe9 ("bpftool: Add support for subskeletons")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 tools/bpf/bpftool/gen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 5a4d3240689e..7ce62f280310 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -334,6 +334,9 @@ static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name
 	const char *sec_name, *var_name;
 	__u32 var_type_id;
 
+	if (!btf)
+		return -EINVAL;
+
 	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
 	if (!d)
 		return -errno;
-- 
2.25.1


