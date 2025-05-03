Return-Path: <bpf+bounces-57309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8B2AA8159
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 17:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F781B602ED
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67190DDD2;
	Sat,  3 May 2025 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oPvmRh2d"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF01D516F
	for <bpf@vger.kernel.org>; Sat,  3 May 2025 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285359; cv=none; b=qMw1XBZTOgMJUGwDQqIL5qDhk2XWku/8bSvHHCrKhioiNGkymZmXTm3TuWjNIMPEoGfXdS1D0yPjQb8y1hf6jghiaQRcYEIqnJ7yAxm5pswxNw3wHIkCLj/KvWGwWeuO4wL1KJFwuUKHjOZiaKYkS80t2wLDJXerk0wGjrtfo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285359; c=relaxed/simple;
	bh=I7e3GB6IUa/XuLF7Kd9aD7odrpym0DqX1XI6f3QWp10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K9TDOQUCKf/qT+pm8wpUv04ZwLWM/fadH/aQ64uOjJMlce8fW4eZmAtMsEn2Qk3es9vcZi6klQ796ZGwfp9zMJEkZmdn85WMkXbrREIoa10b4fKGGXVxaqyLMYRS+P94om8gEzvu/tCA4kUvGtA8TUFHImFGaIBtycHP7A0KPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oPvmRh2d; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746285352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qtU2w2qO3IG5Z29H4TSJsKZX1m7pA3HLi2M7q0PaMbg=;
	b=oPvmRh2deE3U8i7xyX2iKc1V19tQ3RUfnAyXm8lbx6+c51oSPMGTCCOPRt9FB9ajcPs8IU
	oj6X2PDjp1UgxrMav/l7q8tXSP7/JB8hyK+ltHq0uKU3+v3ApAlZ4pTUANlrJS3ytK1KsQ
	OMY/tdtLqT30hqS6Poo/sXTHBiZ5FeI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Replace offsetof() with struct_size()
Date: Sat,  3 May 2025 17:15:13 +0200
Message-ID: <20250503151513.343931-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Compared to offsetof(), struct_size() provides additional compile-time
checks for structs with flexible arrays (e.g., __must_be_array()).

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/bpf/btf.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 16ba36f34dfa..58a6092a7ff8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -26,6 +26,7 @@
 #include <linux/bsearch.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/overflow.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 
@@ -3957,7 +3958,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	/* This needs to be kzalloc to zero out padding and unused fields, see
 	 * comment in btf_record_equal.
 	 */
-	rec = kzalloc(offsetof(struct btf_record, fields[cnt]), GFP_KERNEL | __GFP_NOWARN);
+	rec = kzalloc(struct_size(rec, fields, cnt), GFP_KERNEL | __GFP_NOWARN);
 	if (!rec)
 		return ERR_PTR(-ENOMEM);
 
@@ -5583,7 +5584,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		if (id < 0)
 			continue;
 
-		new_aof = krealloc(aof, offsetof(struct btf_id_set, ids[aof->cnt + 1]),
+		new_aof = krealloc(aof, struct_size(new_aof, ids, aof->cnt + 1),
 				   GFP_KERNEL | __GFP_NOWARN);
 		if (!new_aof) {
 			ret = -ENOMEM;
@@ -5610,7 +5611,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		if (ret != BTF_FIELD_FOUND)
 			continue;
 
-		new_aof = krealloc(aof, offsetof(struct btf_id_set, ids[aof->cnt + 1]),
+		new_aof = krealloc(aof, struct_size(new_aof, ids, aof->cnt + 1),
 				   GFP_KERNEL | __GFP_NOWARN);
 		if (!new_aof) {
 			ret = -ENOMEM;
@@ -5647,7 +5648,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		continue;
 	parse:
 		tab_cnt = tab ? tab->cnt : 0;
-		new_tab = krealloc(tab, offsetof(struct btf_struct_metas, types[tab_cnt + 1]),
+		new_tab = krealloc(tab, struct_size(new_tab, types, tab_cnt + 1),
 				   GFP_KERNEL | __GFP_NOWARN);
 		if (!new_tab) {
 			ret = -ENOMEM;
@@ -8563,7 +8564,7 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 
 	/* Grow set */
 	set = krealloc(tab->sets[hook],
-		       offsetof(struct btf_id_set8, pairs[set_cnt + add_set->cnt]),
+		       struct_size(set, pairs, set_cnt + add_set->cnt),
 		       GFP_KERNEL | __GFP_NOWARN);
 	if (!set) {
 		ret = -ENOMEM;
@@ -8849,7 +8850,7 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 	}
 
 	tab = krealloc(btf->dtor_kfunc_tab,
-		       offsetof(struct btf_id_dtor_kfunc_tab, dtors[tab_cnt + add_cnt]),
+		       struct_size(tab, dtors, tab_cnt + add_cnt),
 		       GFP_KERNEL | __GFP_NOWARN);
 	if (!tab) {
 		ret = -ENOMEM;
@@ -9407,8 +9408,7 @@ btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops,
 
 	tab = btf->struct_ops_tab;
 	if (!tab) {
-		tab = kzalloc(offsetof(struct btf_struct_ops_tab, ops[4]),
-			      GFP_KERNEL);
+		tab = kzalloc(struct_size(tab, ops, 4), GFP_KERNEL);
 		if (!tab)
 			return -ENOMEM;
 		tab->capacity = 4;
@@ -9421,8 +9421,7 @@ btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops,
 
 	if (tab->cnt == tab->capacity) {
 		new_tab = krealloc(tab,
-				   offsetof(struct btf_struct_ops_tab,
-					    ops[tab->capacity * 2]),
+				   struct_size(tab, ops, tab->capacity * 2),
 				   GFP_KERNEL);
 		if (!new_tab)
 			return -ENOMEM;
-- 
2.49.0


