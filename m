Return-Path: <bpf+bounces-37107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AD4950F20
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 23:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED2AB20C1C
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 21:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C51AAE07;
	Tue, 13 Aug 2024 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jfig55Sn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD96A8CF
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584275; cv=none; b=RBJR7rI9K6+BtG5Wpbk9oxzyvzrOoOYh92A6+g8oQkPJg/LMu1kZycRBjN6Sm0gb3g0GwqdzP2iRBuFbqBPP5RBL+SGiu8RvmVzHGBurhoPo8jHcDCKJcISFMC6xfHuujsCTxSX5JGbKfXreN6duWQD20M3/0wtoCoZ0cvirx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584275; c=relaxed/simple;
	bh=QTQzYRe4h83jE6M5+olMf5O80fRE+6prUmVFhyU0eB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MbjJRn/QQmrOINNEqVOIq7gzUQ4Y8bEDuDHN3EJRhaHCyM1ERPjGMVre6ZyuNg/dnhxYMho35F0Oh6DxSCujpjeZ+V/49//ln/0U1fh6eHLRGB1ZlHyB1sJmwb6khj780lJbot6aeP5RTxebUy82UWBUxUeVstlKr76EzNg9wn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jfig55Sn; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so2770096d6.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723584272; x=1724189072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGaWHW0YkJek/nHgtPyy2GmojNTQU/G0zc+vDmOrCsk=;
        b=jfig55SnGc5YkSQh1NOxzFioTGzWik0sbiFXro2KrSV1Mxu0h3eq8/ELelMmZCAiib
         VJBd484oa/Vl087Eox9dpLwST/iCLWSlH7/2IDmyQtahZUG0ruWfmSK6XN74vW5vqGAl
         5FVA9WJijRKQWJNVCaNCb6m24YBvgBzCL5+0gfpU/MhDOGDuXwF4tISaSkN+70prqOp9
         HygdKpAtemUJyiXxpzX+pOkomJwEvPGaSR+5hkI/Qp8q42T7PRdTSRWN0ebfC+gs27Zy
         ZsLlhAQGkIfZK8xd0MZxK2gbo8Mvr41DfamL1NjnWQHj4LwLSApL9oxoLJ5dIa43LzpQ
         t2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723584272; x=1724189072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGaWHW0YkJek/nHgtPyy2GmojNTQU/G0zc+vDmOrCsk=;
        b=HnqAzwvZqQSpRvGYPumGUx2iy5HqDTayVAThwkQfiR/W/xj4ZfWAPNCDZBbviX/xaI
         kYQxTSa0uNqViKnPfrqLUk8BIVYCnMKX1qGVEpZCXl1Gep6eHTTesvgkvqnxM59W+5FQ
         Q/J5WSkvneeyUMTppguYnS+xb/+KaMiIpr6Vf1yqRiwzrRNfkKMN8WUdbKUX1Z/2GUtG
         Cliw1o8EU5Erv7JUJI4TOi0lp4JDwWZBAFtwkcmVbj9LgTf8IDB+sGbJf0q07i6p2RZc
         SecumWnK4JnUmMWqThdaCsNwqibI5l4QZEItZaZGa62WsAXEiStUs44KfWkb8npeVW9P
         LFUA==
X-Gm-Message-State: AOJu0Yx3ikS2uWzDS2KpteuRM9CiPjB1OJYDSeH8uYLWxqznxNQeMuub
	hKAPIgvhBrMi9Tmg4GPW6j8wVIRHcIgfPjHYCFvWBGkQjRMBnYwKs7mbbwKivY/CjRWNU4WACso
	G8EM=
X-Google-Smtp-Source: AGHT+IHt7ZXVs2AH96FOh6Pke1sLaH3j+YnGUcjX0ZZovLLxnfo4LY6WW3btJo3QUhzWSA9VhEYc1w==
X-Received: by 2002:a05:6214:3c9f:b0:6b5:d95c:692d with SMTP id 6a1803df08f44-6bf5f9c0984mr1111586d6.13.1723584272055;
        Tue, 13 Aug 2024 14:24:32 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf432fb61dsm21390786d6.52.2024.08.13.14.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 14:24:31 -0700 (PDT)
From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	houtao@huaweicloud.com,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Hou Tao <houtao1@huawei.com>,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v4 bpf-next 2/5] bpf: Search for kptrs in prog BTF structs
Date: Tue, 13 Aug 2024 21:24:21 +0000
Message-Id: <20240813212424.2871455-3-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240813212424.2871455-1-amery.hung@bytedance.com>
References: <20240813212424.2871455-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

Currently btf_parse_fields is used in two places to create struct
btf_record's for structs: when looking at mapval type, and when looking
at any struct in program BTF. The former looks for kptr fields while the
latter does not. This patch modifies the btf_parse_fields call made when
looking at prog BTF struct types to search for kptrs as well.

Before this series there was no reason to search for kptrs in non-mapval
types: a referenced kptr needs some owner to guarantee resource cleanup,
and map values were the only owner that supported this. If a struct with
a kptr field were to have some non-kptr-aware owner, the kptr field
might not be properly cleaned up and result in resources leaking. Only
searching for kptr fields in mapval was a simple way to avoid this
problem.

In practice, though, searching for BPF_KPTR when populating
struct_meta_tab does not expose us to this risk, as struct_meta_tab is
only accessed through btf_find_struct_meta helper, and that helper is
only called in contexts where recognizing the kptr field is safe:

  * PTR_TO_BTF_ID reg w/ MEM_ALLOC flag
    * Such a reg is a local kptr and must be free'd via bpf_obj_drop,
      which will correctly handle kptr field

  * When handling specific kfuncs which either expect MEM_ALLOC input or
    return MEM_ALLOC output (obj_{new,drop}, percpu_obj_{new,drop},
    list+rbtree funcs, refcount_acquire)
     * Will correctly handle kptr field for same reasons as above

  * When looking at kptr pointee type
     * Called by functions which implement "correct kptr resource
       handling"

  * In btf_check_and_fixup_fields
     * Helper that ensures no ownership loops for lists and rbtrees,
       doesn't care about kptr field existence

So we should be able to find BPF_KPTR fields in all prog BTF structs
without leaking resources.

Further patches in the series will build on this change to support
kptr_xchg into non-mapval local kptr. Without this change there would be
no kptr field found in such a type.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 kernel/bpf/btf.c | 70 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index deacf9d7b276..ed7758936424 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5517,36 +5517,70 @@ static const char *alloc_obj_fields[] = {
 static struct btf_struct_metas *
 btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 {
-	union {
-		struct btf_id_set set;
-		struct {
-			u32 _cnt;
-			u32 _ids[ARRAY_SIZE(alloc_obj_fields)];
-		} _arr;
-	} aof;
 	struct btf_struct_metas *tab = NULL;
+	struct btf_id_set *aof;
 	int i, n, id, ret;
 
 	BUILD_BUG_ON(offsetof(struct btf_id_set, cnt) != 0);
 	BUILD_BUG_ON(sizeof(struct btf_id_set) != sizeof(u32));
 
-	memset(&aof, 0, sizeof(aof));
+	aof = kmalloc(sizeof(*aof), GFP_KERNEL | __GFP_NOWARN);
+	if (!aof)
+		return ERR_PTR(-ENOMEM);
+	aof->cnt = 0;
+
 	for (i = 0; i < ARRAY_SIZE(alloc_obj_fields); i++) {
 		/* Try to find whether this special type exists in user BTF, and
 		 * if so remember its ID so we can easily find it among members
 		 * of structs that we iterate in the next loop.
 		 */
+		struct btf_id_set *new_aof;
+
 		id = btf_find_by_name_kind(btf, alloc_obj_fields[i], BTF_KIND_STRUCT);
 		if (id < 0)
 			continue;
-		aof.set.ids[aof.set.cnt++] = id;
+
+		new_aof = krealloc(aof, offsetof(struct btf_id_set, ids[aof->cnt + 1]),
+				   GFP_KERNEL | __GFP_NOWARN);
+		if (!new_aof) {
+			ret = -ENOMEM;
+			goto free_aof;
+		}
+		aof = new_aof;
+		aof->ids[aof->cnt++] = id;
+	}
+
+	n = btf_nr_types(btf);
+	for (i = 1; i < n; i++) {
+		/* Try to find if there are kptrs in user BTF and remember their ID */
+		struct btf_id_set *new_aof;
+		struct btf_field_info tmp;
+		const struct btf_type *t;
+
+		t = btf_type_by_id(btf, i);
+		if (!t) {
+			ret = -EINVAL;
+			goto free_aof;
+		}
+
+		ret = btf_find_kptr(btf, t, 0, 0, &tmp);
+		if (ret != BTF_FIELD_FOUND)
+			continue;
+
+		new_aof = krealloc(aof, offsetof(struct btf_id_set, ids[aof->cnt + 1]),
+				   GFP_KERNEL | __GFP_NOWARN);
+		if (!new_aof) {
+			ret = -ENOMEM;
+			goto free_aof;
+		}
+		aof = new_aof;
+		aof->ids[aof->cnt++] = i;
 	}
 
-	if (!aof.set.cnt)
+	if (!aof->cnt)
 		return NULL;
-	sort(&aof.set.ids, aof.set.cnt, sizeof(aof.set.ids[0]), btf_id_cmp_func, NULL);
+	sort(&aof->ids, aof->cnt, sizeof(aof->ids[0]), btf_id_cmp_func, NULL);
 
-	n = btf_nr_types(btf);
 	for (i = 1; i < n; i++) {
 		struct btf_struct_metas *new_tab;
 		const struct btf_member *member;
@@ -5556,17 +5590,13 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		int j, tab_cnt;
 
 		t = btf_type_by_id(btf, i);
-		if (!t) {
-			ret = -EINVAL;
-			goto free;
-		}
 		if (!__btf_type_is_struct(t))
 			continue;
 
 		cond_resched();
 
 		for_each_member(j, t, member) {
-			if (btf_id_set_contains(&aof.set, member->type))
+			if (btf_id_set_contains(aof, member->type))
 				goto parse;
 		}
 		continue;
@@ -5585,7 +5615,8 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		type = &tab->types[tab->cnt];
 		type->btf_id = i;
 		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
-						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT, t->size);
+						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
+						  BPF_KPTR, t->size);
 		/* The record cannot be unset, treat it as an error if so */
 		if (IS_ERR_OR_NULL(record)) {
 			ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
@@ -5594,9 +5625,12 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		type->record = record;
 		tab->cnt++;
 	}
+	kfree(aof);
 	return tab;
 free:
 	btf_struct_metas_free(tab);
+free_aof:
+	kfree(aof);
 	return ERR_PTR(ret);
 }
 
-- 
2.20.1


