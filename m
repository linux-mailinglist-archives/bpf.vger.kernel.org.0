Return-Path: <bpf+bounces-79329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F69D38751
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 21:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 344DD302CA3F
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 20:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740F3A640E;
	Fri, 16 Jan 2026 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q+pd9Ocr"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2D3A4F20
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594663; cv=none; b=vFvq9hlFTwvOlqSb3+K3/oI7OjG8ZuQAsAGhO36Nctwalha4icaJhQ3toYj1BtRcRoZQt3+9uSnumk+9qgE+Knf9i962Y1xFDJZfymPKG+Zlludq3K9Re8lvAziGbiRKtwPYPFgopIviUDKL/vJYyUoPWZY4cpXFD6HYYWB8s/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594663; c=relaxed/simple;
	bh=CPAA3gY2QB9GNzfqq6/eeY2mCprs3fUSvuy03pJBlPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+Yfrlg8aNipPiwglW1Y3/ibPUIHShLu32pqzfrdIN8ZDxebCD4ehipZOkKZ5HO+L+jacM7QNgmK6JiL+RiORLwiSsTFTYBWJkVC2RPGft9pzbovo3yTMvPTqxOPh+zGti7gBdr0S/iutZw1sGwPWAAvnG/sXRTK/HdYyR46c7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q+pd9Ocr; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768594659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rMnbmbYZ8Ww7o1IYuKhcfISB8bXYaOAEGc1eum/Jik=;
	b=q+pd9OcrBldSBgR71GQ6zrsxMbvEXAO+fewXQnonJcDS8zwCTDp3Kw3xRjC/u3hLfdZdmI
	WmxIhRxTTdfkRkSlEqpFf9EjUA4k6sNozUo0/GxsN6h8TWtq377Cyo5gciDpTmopbvs1nQ
	4dPjdDH+WUlPXGmrLfXstevSxfgLN+Q=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v2 04/13] resolve_btfids: Introduce finalize_btf() step
Date: Fri, 16 Jan 2026 12:16:51 -0800
Message-ID: <20260116201700.864797-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260116201700.864797-1-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since recently [1][2] resolve_btfids executes final adjustments to the
kernel/module BTF before it's embedded into the target binary.

To keep the implementation simple, a clear and stable "pipeline" of
how BTF data flows through resolve_btfids would be helpful. Some BTF
modifications may change the ids of the types, so it is important to
maintain correct order of operations with respect to .BTF_ids
resolution too.

This patch refactors the BTF handling to establish the following
sequence:
  - load target ELF sections
  - load .BTF_ids symbols
    - this will be a dependency of btf2btf transformations in
      subsequent patches
  - load BTF and its base as is
  - (*) btf2btf transformations will happen here
  - finalize_btf(), introduced in this patch
    - does distill base and sort BTF
  - resolve and patch .BTF_ids

This approach helps to avoid fixups in .BTF_ids data in case the ids
change at any point of BTF processing, because symbol resolution
happens on the finalized, ready to dump, BTF data.

This also gives flexibility in BTF transformations, because they will
happen on BTF that is not distilled and/or sorted yet, allowing to
freely add, remove and modify BTF types.

[1] https://lore.kernel.org/bpf/20251219181321.1283664-1-ihor.solodrai@linux.dev/
[2] https://lore.kernel.org/bpf/20260109130003.3313716-1-dolinux.peng@gmail.com/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 69 +++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 343d08050116..1fcf37af6764 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -563,19 +563,6 @@ static int load_btf(struct object *obj)
 	obj->base_btf = base_btf;
 	obj->btf = btf;
 
-	if (obj->base_btf && obj->distill_base) {
-		err = btf__distill_base(obj->btf, &base_btf, &btf);
-		if (err) {
-			pr_err("FAILED to distill base BTF: %s\n", strerror(errno));
-			goto out_err;
-		}
-
-		btf__free(obj->base_btf);
-		btf__free(obj->btf);
-		obj->base_btf = base_btf;
-		obj->btf = btf;
-	}
-
 	return 0;
 
 out_err:
@@ -911,6 +898,41 @@ static int sort_btf_by_name(struct btf *btf)
 	return err;
 }
 
+static int finalize_btf(struct object *obj)
+{
+	struct btf *base_btf = obj->base_btf, *btf = obj->btf;
+	int err;
+
+	if (obj->base_btf && obj->distill_base) {
+		err = btf__distill_base(obj->btf, &base_btf, &btf);
+		if (err) {
+			pr_err("FAILED to distill base BTF: %s\n", strerror(errno));
+			goto out_err;
+		}
+
+		btf__free(obj->base_btf);
+		btf__free(obj->btf);
+		obj->base_btf = base_btf;
+		obj->btf = btf;
+	}
+
+	err = sort_btf_by_name(obj->btf);
+	if (err) {
+		pr_err("FAILED to sort BTF: %s\n", strerror(errno));
+		goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	btf__free(base_btf);
+	btf__free(btf);
+	obj->base_btf = NULL;
+	obj->btf = NULL;
+
+	return err;
+}
+
 static inline int make_out_path(char *buf, u32 buf_sz, const char *in_path, const char *suffix)
 {
 	int len = snprintf(buf, buf_sz, "%s%s", in_path, suffix);
@@ -1054,6 +1076,7 @@ int main(int argc, const char **argv)
 	};
 	const char *btfids_path = NULL;
 	bool fatal_warnings = false;
+	bool resolve_btfids = true;
 	char out_path[PATH_MAX];
 
 	struct option btfid_options[] = {
@@ -1083,12 +1106,6 @@ int main(int argc, const char **argv)
 	if (btfids_path)
 		return patch_btfids(btfids_path, obj.path);
 
-	if (load_btf(&obj))
-		goto out;
-
-	if (sort_btf_by_name(obj.btf))
-		goto out;
-
 	if (elf_collect(&obj))
 		goto out;
 
@@ -1099,12 +1116,22 @@ int main(int argc, const char **argv)
 	if (obj.efile.idlist_shndx == -1 ||
 	    obj.efile.symbols_shndx == -1) {
 		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols resolution\n");
-		goto dump_btf;
+		resolve_btfids = false;
 	}
 
-	if (symbols_collect(&obj))
+	if (resolve_btfids)
+		if (symbols_collect(&obj))
+			goto out;
+
+	if (load_btf(&obj))
 		goto out;
 
+	if (finalize_btf(&obj))
+		goto out;
+
+	if (!resolve_btfids)
+		goto dump_btf;
+
 	if (symbols_resolve(&obj))
 		goto out;
 
-- 
2.52.0


