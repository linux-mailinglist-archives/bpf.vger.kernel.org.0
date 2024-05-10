Return-Path: <bpf+bounces-29528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEF08C2A8B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09560282566
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029C51C40;
	Fri, 10 May 2024 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiJDmb7y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44C502AE;
	Fri, 10 May 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369063; cv=none; b=bEstblHrVlv02oKEc7muCNjDT8dK3CwRQjlDPyZ7Db2nK8/vQWGSg5NVGz9Lr+5AVm02jjmbuK7QBFdVPxbJ3j4hnlDLrV91BjiM81mFPx0P2NYnaMgAbdfZHViSZ+qxKTp3D/6xJTGd/ko0A9j4D4wnx1LgchSdReTLsn0Ek8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369063; c=relaxed/simple;
	bh=kTydXBETpjr1D6XSLVXfwnOa/+Brli4WffZu0T51Xcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ClY5ii+gTKJTNSftcJ5FYXhtdOOW8iS1xkGE/ciS0Ufs3xDUm+rCW5TC+QL+zgxt3mEQ34QokSV9MaFOe7NKICdCS7xEdC3ZlO1LYSs4Qrfy7jyJIsfawmUlz5aQpT1EyxhZ5fNB+D5QTlSt8vBabYmmsw44R116Z2HnCcWXRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiJDmb7y; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43ddbdf2439so15427251cf.0;
        Fri, 10 May 2024 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369059; x=1715973859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hveCu8ucfpTFonbjNBtsRxV1gZi43mXbiPaT0dPNXp0=;
        b=ZiJDmb7yHLGoQXPfP2+TiGJp0b7qvTf0lfW4dPox75TJWhN4GII0Dh6RpE/1yhDhvJ
         4tUBqNfF5YHFn2qXlH7bnU6dYfxMeBbZmwFXOv7/YUkUmpg6codlRjnnGb4R2eM0vBQU
         gFD8FkD34LotUb2cn+hcQE3tWvqCEgJH/nBsJEYSizPzSvp35BQs4a4LhjnbpUlUc5Ym
         iNExZyAk3yNaeafLMRt2TwAFjWGgPzyyZZ624MVq9JXBaOQd94y6TfNo2XYtA5hMt3cG
         puWDh3mQvvNwLn5lxXvrwdrQ1rUnmoic75aryniswcUCkQgf+6U0vCBvYMPQZu2uV1zx
         CZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369059; x=1715973859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hveCu8ucfpTFonbjNBtsRxV1gZi43mXbiPaT0dPNXp0=;
        b=q08qTMIK4kvK1Q18NQpe34jwAGgi+u+F8Alte4zPnNvx4pBm6pKBcGkGjJarVjwq/R
         X0Wgtvnwcm6gBOr7G4299HWNquXMbLlM14YpvPNs1elDuoNsBB6Kf6gaFyJqnVNtVFgv
         EfjOTDvqpApKEKBR9RV8+4+0nd3kZFHmv0/FcID6QWRXi4vtJtMvOJAobrf811i0ODcT
         7fuy6OdMOyWtfDOwCC9EEMrKJCL1CGqWHqsbp1lDpXGa89Wph59gnhUbisWT5R9I08RF
         a3Yi3KEqgwOEKGBJtHZzb7PVxXrdTdQOYFqGmBa7D7UEhnbM0lbtd3ksLbPd4pBqDDe0
         1+ow==
X-Gm-Message-State: AOJu0YyjpAjZl0s9CAJSHeuFO6Xs06L7B6tryR9bb9o2eIS2ZLcnXRKt
	xiqcsNlG8XZiuvoiOGCBXtoq6Edoh4iy5CEqm/7SNowh3f08tfhQnDAYiw==
X-Google-Smtp-Source: AGHT+IEEHrBSdl5u3GgPumiQKHpYQuCPrumgKyDcajkj29MvZpj15ouVgIcL2/m2WJY86iJ5NeCucg==
X-Received: by 2002:ac8:7f51:0:b0:43d:d970:b3f1 with SMTP id d75a77b69052e-43dfdd0c647mr36136851cf.61.1715369059163;
        Fri, 10 May 2024 12:24:19 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:18 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 09/20] bpf: Find special BTF fields in union
Date: Fri, 10 May 2024 19:24:01 +0000
Message-Id: <20240510192412.3297104-10-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch looks into unions when parsing BTF. While we would like to
support adding a skb to bpf collections, the bpf graph node in sk_buff
will happen to be in a union due to space constraint. Therefore,

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 kernel/bpf/btf.c | 74 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 37fb6143da79..25a5dc840ac3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3305,7 +3305,7 @@ static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
 			   u32 off, int sz, enum btf_field_type field_type,
 			   struct btf_field_info *info)
 {
-	if (!__btf_type_is_struct(t))
+	if (!btf_type_is_struct(t))
 		return BTF_FIELD_IGNORE;
 	if (t->size != sz)
 		return BTF_FIELD_IGNORE;
@@ -3497,6 +3497,24 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 	return type;
 }
 
+static int btf_get_union_field_types(const struct btf *btf, const struct btf_type *u,
+				     u32 field_mask, u32 *seen_mask, int *align, int *sz)
+{
+	int i, field_type, field_types = 0;
+	const struct btf_member *member;
+	const struct btf_type *t;
+
+	for_each_member(i, u, member) {
+		t = btf_type_by_id(btf, member->type);
+		field_type = btf_get_field_type(__btf_name_by_offset(btf, t->name_off),
+						field_mask, seen_mask, align, sz);
+		if (field_type == 0 || field_type == BPF_KPTR_REF)
+			continue;
+		field_types = field_types | field_type;
+	}
+	return field_types;
+}
+
 #undef field_mask_test_name
 
 static int btf_find_struct_field(const struct btf *btf,
@@ -3512,8 +3530,12 @@ static int btf_find_struct_field(const struct btf *btf,
 		const struct btf_type *member_type = btf_type_by_id(btf,
 								    member->type);
 
-		field_type = btf_get_field_type(__btf_name_by_offset(btf, member_type->name_off),
-						field_mask, &seen_mask, &align, &sz);
+		field_type = BTF_INFO_KIND(member_type->info) == BTF_KIND_UNION ?
+			btf_get_union_field_types(btf, member_type, field_mask,
+						  &seen_mask, &align, &sz) :
+			btf_get_field_type(__btf_name_by_offset(btf, member_type->name_off),
+					   field_mask, &seen_mask, &align, &sz);
+
 		if (field_type == 0)
 			continue;
 		if (field_type < 0)
@@ -3521,8 +3543,7 @@ static int btf_find_struct_field(const struct btf *btf,
 
 		off = __btf_member_bit_offset(t, member);
 		if (off % 8)
-			/* valid C code cannot generate such BTF */
-			return -EINVAL;
+			continue;
 		off /= 8;
 		if (off % align)
 			continue;
@@ -3737,6 +3758,20 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
 	return ret;
 }
 
+static const struct btf_type *
+btf_find_member_by_name(const struct btf *btf, const struct btf_type *t,
+			const char *member_name)
+{
+	const struct btf_member *member;
+	int i;
+
+	for_each_member(i, t, member) {
+		if (!strcmp(member_name, __btf_name_by_offset(btf, member->name_off)))
+			return btf_type_by_id(btf, member->type);
+	}
+	return NULL;
+}
+
 static int btf_parse_graph_root(struct btf_field *field,
 				struct btf_field_info *info,
 				const char *node_type_name,
@@ -3754,18 +3789,27 @@ static int btf_parse_graph_root(struct btf_field *field,
 	 * verify its type.
 	 */
 	for_each_member(i, t, member) {
-		if (strcmp(info->graph_root.node_name,
-			   __btf_name_by_offset(btf, member->name_off)))
+		const struct btf_type *member_type = btf_type_by_id(btf, member->type);
+
+		if (BTF_INFO_KIND(member_type->info) == BTF_KIND_UNION) {
+			member_type = btf_find_member_by_name(btf, member_type,
+							      info->graph_root.node_name);
+			if (!member_type)
+				continue;
+		} else if (strcmp(info->graph_root.node_name,
+				  __btf_name_by_offset(btf, member->name_off))) {
 			continue;
+		}
+
 		/* Invalid BTF, two members with same name */
 		if (n)
 			return -EINVAL;
-		n = btf_type_by_id(btf, member->type);
+		n = member_type;
 		if (!__btf_type_is_struct(n))
 			return -EINVAL;
 		if (strcmp(node_type_name, __btf_name_by_offset(btf, n->name_off)))
 			return -EINVAL;
-		offset = __btf_member_bit_offset(n, member);
+		offset = __btf_member_bit_offset(member_type, member);
 		if (offset % 8)
 			return -EINVAL;
 		offset /= 8;
@@ -5440,7 +5484,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		const struct btf_member *member;
 		struct btf_struct_meta *type;
 		struct btf_record *record;
-		const struct btf_type *t;
+		const struct btf_type *t, *member_type;
 		int j, tab_cnt, id;
 
 		id = btf_is_base_kernel ?
@@ -5462,6 +5506,16 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		cond_resched();
 
 		for_each_member(j, t, member) {
+			member_type = btf_type_by_id(btf, member->type);
+			if (BTF_INFO_KIND(member_type->info) == BTF_KIND_UNION) {
+				const struct btf_member *umember;
+				int k;
+
+				for_each_member(k, member_type, umember) {
+					if (btf_id_set_contains(&aof.set, umember->type))
+						goto parse;
+				}
+			}
 			if (btf_id_set_contains(&aof.set, member->type))
 				goto parse;
 		}
-- 
2.20.1


