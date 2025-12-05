Return-Path: <bpf+bounces-76183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFF9CA9805
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 23:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4718E31B7850
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 22:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83242E5418;
	Fri,  5 Dec 2025 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fDZ+ePTl"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141672E8B87
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764973912; cv=none; b=ASTZ76JlUguKk6ebDYx3G08Jkw2aJ+LXhjijlTW1TZ8+m/rFHnpWwg4kcE7LaYfdCfDeThiRbFaJqZW6HPRPQXYtep+nhSCYaVovkeExofa3fGav05WH3oJ1h+JCG+x0DeTERH5PNmZogOqwE1NCyZA2jK3cEWmi7jKBoedBdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764973912; c=relaxed/simple;
	bh=UiX1KHXAYHBqfEnpkaLtaeiHRckaGHIX0/LdcZAokkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYGzTp5EXNhlDJeIKt6rb5s74NU9VdnQtdgyGVtE6Qwxw5g7tLtlU7s7sGGTq3Ro2k/HPTVVA9JulYIzIdRbalsbwW8M/Jmrh13TvAe3G8Q838zOC/m1UiZj6WVarTTsJY+x5N6DvDGWI6xcxXa6UtU6rW0Wxvtm1H69hOtH6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fDZ+ePTl; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764973907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nm+akLsLdjhLrTZLoo5eicKi1CYuvGgFHN9rYjxvECU=;
	b=fDZ+ePTleON4PzejeNx71IO4Q+Q4z0w1/imC+MYDDc9moLAVvsL30GlcE2EIbv84TMpyDL
	X/wQ3afBsw0CwzTWEulI0T7ffEkFTsJUVjgkHZl9bNpZM40yOQbdqTzFV4H7kLGTMWSxae
	A9I0eUAstgPf6enPckQtbZ1+bV2c3qQ=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v3 2/6] resolve_btfids: Factor out load_btf()
Date: Fri,  5 Dec 2025 14:30:42 -0800
Message-ID: <20251205223046.4155870-3-ihor.solodrai@linux.dev>
In-Reply-To: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Increase the lifetime of parsed BTF in resolve_btfids by factoring
load_btf() routine out of symbols_resolve() and storing the base_btf
and btf pointers in the struct object.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 47 ++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 164f0c941f04..b4caae1170dd 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -116,6 +116,9 @@ struct object {
 	const char *btf_path;
 	const char *base_btf_path;
 
+	struct btf *btf;
+	struct btf *base_btf;
+
 	struct {
 		int		 fd;
 		Elf		*elf;
@@ -529,16 +532,10 @@ static int symbols_collect(struct object *obj)
 	return 0;
 }
 
-static int symbols_resolve(struct object *obj)
+static int load_btf(struct object *obj)
 {
-	int nr_typedefs = obj->nr_typedefs;
-	int nr_structs  = obj->nr_structs;
-	int nr_unions   = obj->nr_unions;
-	int nr_funcs    = obj->nr_funcs;
-	struct btf *base_btf = NULL;
-	int err, type_id;
-	struct btf *btf;
-	__u32 nr_types;
+	struct btf *base_btf = NULL, *btf = NULL;
+	int err;
 
 	if (obj->base_btf_path) {
 		base_btf = btf__parse(obj->base_btf_path, NULL);
@@ -546,7 +543,7 @@ static int symbols_resolve(struct object *obj)
 		if (err) {
 			pr_err("FAILED: load base BTF from %s: %s\n",
 			       obj->base_btf_path, strerror(-err));
-			return -1;
+			goto out_err;
 		}
 	}
 
@@ -555,9 +552,30 @@ static int symbols_resolve(struct object *obj)
 	if (err) {
 		pr_err("FAILED: load BTF from %s: %s\n",
 			obj->btf_path ?: obj->path, strerror(-err));
-		goto out;
+		goto out_err;
 	}
 
+	obj->base_btf = base_btf;
+	obj->btf = btf;
+
+	return 0;
+
+out_err:
+	btf__free(base_btf);
+	btf__free(btf);
+	return err;
+}
+
+static int symbols_resolve(struct object *obj)
+{
+	int nr_typedefs = obj->nr_typedefs;
+	int nr_structs  = obj->nr_structs;
+	int nr_unions   = obj->nr_unions;
+	int nr_funcs    = obj->nr_funcs;
+	struct btf *btf = obj->btf;
+	int err, type_id;
+	__u32 nr_types;
+
 	err = -1;
 	nr_types = btf__type_cnt(btf);
 
@@ -615,8 +633,6 @@ static int symbols_resolve(struct object *obj)
 
 	err = 0;
 out:
-	btf__free(base_btf);
-	btf__free(btf);
 	return err;
 }
 
@@ -824,6 +840,9 @@ int main(int argc, const char **argv)
 	if (symbols_collect(&obj))
 		goto out;
 
+	if (load_btf(&obj))
+		goto out;
+
 	if (symbols_resolve(&obj))
 		goto out;
 
@@ -833,6 +852,8 @@ int main(int argc, const char **argv)
 	if (!(fatal_warnings && warnings))
 		err = 0;
 out:
+	btf__free(obj.base_btf);
+	btf__free(obj.btf);
 	if (obj.efile.elf) {
 		elf_end(obj.efile.elf);
 		close(obj.efile.fd);
-- 
2.52.0


