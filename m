Return-Path: <bpf+bounces-31279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DACD8FA656
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 01:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF0F0B218BE
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE113CF9A;
	Mon,  3 Jun 2024 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqQsb26/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6B8288C
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717456662; cv=none; b=PZ6PV2wfVC3xyXNrkWqauuk3GR/9MROABubsCFZ2J4bGW6RrTUMM9TXfzLgDTTPoT0swFQKjDqtK6K/BIHdRLtsK5XTPnwQh0we5cTREevv/5hT30zDi39oscXm/G26IfL4yQ3PtvvNaS+vQpQU3buDPSHgJFRIB9aVoevXy6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717456662; c=relaxed/simple;
	bh=ggdkdBldqpULad9DarJ0PtFEQgMPEPDUz5Ll1eNrAqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYepT59N9+fIzC60AkA1SxNVLxRe4JRQCMdG7CC2Q015Ogg47qb50XVafCVXe50l0YAoaB/sz4iW0JUMG1DemCLZiti3FgoMXNC+IShBtaLoUrIOBwcTIiMb5k1d4N7sm+OVFtBCabqeMcFtuv/jgv3uX87H1qw0/ARWLaEu7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqQsb26/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDB6C2BD10;
	Mon,  3 Jun 2024 23:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717456661;
	bh=ggdkdBldqpULad9DarJ0PtFEQgMPEPDUz5Ll1eNrAqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CqQsb26/7OliP/IWm3pHWOf3kAabR5YfMtvgjoT3tta5UNRW7v5KDRqkLoOAnZVbv
	 IfDgtzZR1K6B5QY6WMRoATZJ4A4ScIilEuFQ3CdEt4rK+2OPWqkZADxlW8t303+rvi
	 4AS2S1oXk/rFF0TfWKajyOIAiTZyAOY92XgERmixweWDC/F5w0OPsoboiTIV684zyu
	 Pqa7Tp1QNnSoJSG67BS1v3PxQSuILAukrvuxns7CKU2bIb3v4tPkmkngfb6s3aoqr6
	 +bbCmGcR8E6CR2GYsYQInC1EExwRartndrcUggAt4eoUyLZB8E9A4mAI30pPiCPvyv
	 JgpXL4sUZKZ4A==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: alan.maguire@oracle.com,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 5/5] libbpf: remove callback-based type/string BTF field visitor helpers
Date: Mon,  3 Jun 2024 16:17:19 -0700
Message-ID: <20240603231720.1893487-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603231720.1893487-1-andrii@kernel.org>
References: <20240603231720.1893487-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all libbpf/bpftool code switched to btf_field_iter, remove
btf_type_visit_type_ids() and btf_type_visit_str_offs() callback-based
helpers as not needed anymore.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c             | 130 --------------------------------
 tools/lib/bpf/libbpf_internal.h |   2 -
 2 files changed, 132 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3fe20a902b42..1de7579f2a08 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5035,136 +5035,6 @@ struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_bt
 	return btf__parse_split(path, vmlinux_btf);
 }
 
-int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx)
-{
-	int i, n, err;
-
-	switch (btf_kind(t)) {
-	case BTF_KIND_INT:
-	case BTF_KIND_FLOAT:
-	case BTF_KIND_ENUM:
-	case BTF_KIND_ENUM64:
-		return 0;
-
-	case BTF_KIND_FWD:
-	case BTF_KIND_CONST:
-	case BTF_KIND_VOLATILE:
-	case BTF_KIND_RESTRICT:
-	case BTF_KIND_PTR:
-	case BTF_KIND_TYPEDEF:
-	case BTF_KIND_FUNC:
-	case BTF_KIND_VAR:
-	case BTF_KIND_DECL_TAG:
-	case BTF_KIND_TYPE_TAG:
-		return visit(&t->type, ctx);
-
-	case BTF_KIND_ARRAY: {
-		struct btf_array *a = btf_array(t);
-
-		err = visit(&a->type, ctx);
-		err = err ?: visit(&a->index_type, ctx);
-		return err;
-	}
-
-	case BTF_KIND_STRUCT:
-	case BTF_KIND_UNION: {
-		struct btf_member *m = btf_members(t);
-
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->type, ctx);
-			if (err)
-				return err;
-		}
-		return 0;
-	}
-
-	case BTF_KIND_FUNC_PROTO: {
-		struct btf_param *m = btf_params(t);
-
-		err = visit(&t->type, ctx);
-		if (err)
-			return err;
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->type, ctx);
-			if (err)
-				return err;
-		}
-		return 0;
-	}
-
-	case BTF_KIND_DATASEC: {
-		struct btf_var_secinfo *m = btf_var_secinfos(t);
-
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->type, ctx);
-			if (err)
-				return err;
-		}
-		return 0;
-	}
-
-	default:
-		return -EINVAL;
-	}
-}
-
-int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit, void *ctx)
-{
-	int i, n, err;
-
-	err = visit(&t->name_off, ctx);
-	if (err)
-		return err;
-
-	switch (btf_kind(t)) {
-	case BTF_KIND_STRUCT:
-	case BTF_KIND_UNION: {
-		struct btf_member *m = btf_members(t);
-
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->name_off, ctx);
-			if (err)
-				return err;
-		}
-		break;
-	}
-	case BTF_KIND_ENUM: {
-		struct btf_enum *m = btf_enum(t);
-
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->name_off, ctx);
-			if (err)
-				return err;
-		}
-		break;
-	}
-	case BTF_KIND_ENUM64: {
-		struct btf_enum64 *m = btf_enum64(t);
-
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->name_off, ctx);
-			if (err)
-				return err;
-		}
-		break;
-	}
-	case BTF_KIND_FUNC_PROTO: {
-		struct btf_param *m = btf_params(t);
-
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->name_off, ctx);
-			if (err)
-				return err;
-		}
-		break;
-	}
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t, enum btf_field_iter_kind iter_kind)
 {
 	it->p = NULL;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 80f3d346db33..9f4a04367287 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -535,8 +535,6 @@ __u32 *btf_field_iter_next(struct btf_field_iter *it);
 
 typedef int (*type_id_visit_fn)(__u32 *type_id, void *ctx);
 typedef int (*str_off_visit_fn)(__u32 *str_off, void *ctx);
-int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx);
-int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit, void *ctx);
 int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn visit, void *ctx);
 int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void *ctx);
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
-- 
2.43.0


