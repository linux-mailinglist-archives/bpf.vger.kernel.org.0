Return-Path: <bpf+bounces-36462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02704948D50
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 12:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3482D1C236AF
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921C1C0DF3;
	Tue,  6 Aug 2024 10:57:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506A17C203;
	Tue,  6 Aug 2024 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941876; cv=none; b=p0Ri7eLFNRPGOhyPjDuv/QvUbfSYneBDMfu2Dfn4/gNScWebAePiN0t1wPu6GF1d96A2J+MS7VlQZY+n67KZroazsvdo39a4wTeqe4uZSBN8sMdSN/0lZj/xpu0TKmrA3aQUGUsi8zsKvNosIrAFaZnmCUcoAp8cAJJsVDWQ2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941876; c=relaxed/simple;
	bh=17xBX1L9+CmtLxN0lWeNgrQ4qgzBzJ/G5PVCEwC0ANE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aRuWZ7mHizYGiI1gweQz4X1m5D4s+FWQGPdyTDLKDx/K8Oh0cTIf4kFx0jf3VWSQSAcTdq9uGtsF/THyn1b92uwZvnlAC6Ti+wqlig/C4Etp+Qzbn3puT4UN0HR7IsopJTC4HDe6tXGIxGLwbOGPtDMORA9cN3rcwrVOkIxTdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowACnUEA_ALJmVyfVAw--.26867S2;
	Tue, 06 Aug 2024 18:51:49 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
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
Subject: [PATCH] libbpf: check the btf_type kind to prevent error
Date: Tue,  6 Aug 2024 18:51:42 +0800
Message-Id: <20240806105142.2420140-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnUEA_ALJmVyfVAw--.26867S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF45Aw1xtFWUGF45GF1DAwb_yoWDJFg_J3
	Z7XFyxGrW0kanrAw1rCrZY9ry8t3Z3JF1kXanxXrZrAayYkr1DJF13Gas8ZrZYkw1IqF13
	CrZ7Xr15tr429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiSfO3UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

To prevent potential error return values, it is necessary to check the
return value of btf__type_by_id. We can add a kind checking to fix the
issue.

Cc: stable@vger.kernel.org
Fixes: 430025e5dca5 ("libbpf: Add subskeleton scaffolding")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a3be6f8fac09..d1eb45d16054 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13850,6 +13850,9 @@ int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
 		var = btf_var_secinfos(map_type);
 		for (i = 0; i < len; i++, var++) {
 			var_type = btf__type_by_id(btf, var->type);
+			if (!var_type)
+				return libbpf_err(-ENOENT);
+
 			var_name = btf__name_by_offset(btf, var_type->name_off);
 			if (strcmp(var_name, var_skel->name) == 0) {
 				*var_skel->addr = map->mmaped + var->offset;
-- 
2.25.1


