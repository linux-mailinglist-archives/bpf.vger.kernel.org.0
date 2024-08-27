Return-Path: <bpf+bounces-38207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C60E961899
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 22:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC902852A8
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 20:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186A6185941;
	Tue, 27 Aug 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4oecHjj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C24537F5
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791049; cv=none; b=TZ4GAWN85x2RvnmqAEesfhzBWX99W7l5ZlAb138g5FjK1KnrC32j5zOOUixuw/LT+YozvF2TjkTel0wZu+/73JG4J1q4ov7tcUz1pobmPgd3Mc84AuObPdw35msrKwFDs4TaaSjpD4T9yyS8+OpHoePCO7ggfKVzxLT2yJ92+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791049; c=relaxed/simple;
	bh=ztsug51HfQiirZ+VEQmb79qkmh5NuzqdUDQLav+F+/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pe4de2FagDq+km9MMLkx0tqmQHeY28pEHKVYEeZDxe1VWkPyaYPUd9EGW7pDUmfRnD3/DQ+GUgZts/W/Ilz+Pbg3ooCWfIMOiYEqA61saA1rwRrY28bpRYKeyapK7cr9L002rzJmg2i6kHnyv5uXpSnAn1jyv3Qe2vGfD9MTUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4oecHjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78FEC4AF0C;
	Tue, 27 Aug 2024 20:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724791049;
	bh=ztsug51HfQiirZ+VEQmb79qkmh5NuzqdUDQLav+F+/o=;
	h=From:To:Cc:Subject:Date:From;
	b=k4oecHjj9GsQuqpFRO+O2ur0nPAmZ4vCaNmj/Yw2ER0345SVbiUlOQ+thYh0IlrrB
	 DSIyu02rhc557uuGlIvPiSECQNeO+OslhA7E/txpJ22DTmOs6H2ZVXncCknGYj7RQ+
	 b9cGDL/RN+6vMzx0cksw1FxVqx/jYUxCfuusoE0NXpbf1TRfrhNvz6g8op5VFT+6nY
	 cF2wakbEfa9aVUaoR/6f7d/hei1x931vAbuznl9mvh1jqbCkQ0fH1JxcrYg+9aPHP0
	 Sh+HQl/v2ECcMw923UHXAXRs+3PVgn6AIQQiUoVTerVV8DF9Dsi24kKh10imUgHRE/
	 JkG+7YDQPj2EA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	=?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
Subject: [PATCH bpf-next] libbpf: fix bpf_object__open_skeleton()'s mishandling of options
Date: Tue, 27 Aug 2024 13:37:21 -0700
Message-ID: <20240827203721.1145494-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We do an ugly copying of options in bpf_object__open_skeleton() just to
be able to set object name from skeleton's recorded name (while still
allowing user to override it through opts->object_name).

This is not just ugly, but it also is broken due to memcpy() that
doesn't take into account potential skel_opts' and user-provided opts'
sizes differences due to backward and forward compatibility. This leads
to copying over extra bytes and then failing to validate options
properly. It could, technically, lead also to SIGSEGV, if we are unlucky.

So just get rid of that memory copy completely and instead pass
default object name into bpf_object_open() directly, simplifying all
this significantly. The rule now is that obj_name should be non-NULL for
bpf_object_open() when called with in-memory buffer, so validate that
explicitly as well.

We adopt bpf_object__open_mem() to this as well and generate default
name (based on buffer memory address and size) outside of bpf_object_open().

Fixes: d66562fba1ce ("libbpf: Add BPF object skeleton support")
Reported-by: Daniel Müller <deso@posteo.net>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 52 +++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e55353887439..d3a542649e6b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7905,16 +7905,19 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 }
 
 static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf, size_t obj_buf_sz,
+					  const char *obj_name,
 					  const struct bpf_object_open_opts *opts)
 {
-	const char *obj_name, *kconfig, *btf_tmp_path, *token_path;
+	const char *kconfig, *btf_tmp_path, *token_path;
 	struct bpf_object *obj;
-	char tmp_name[64];
 	int err;
 	char *log_buf;
 	size_t log_size;
 	__u32 log_level;
 
+	if (obj_buf && !obj_name)
+		return ERR_PTR(-EINVAL);
+
 	if (elf_version(EV_CURRENT) == EV_NONE) {
 		pr_warn("failed to init libelf for %s\n",
 			path ? : "(mem buf)");
@@ -7924,16 +7927,12 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	if (!OPTS_VALID(opts, bpf_object_open_opts))
 		return ERR_PTR(-EINVAL);
 
-	obj_name = OPTS_GET(opts, object_name, NULL);
+	obj_name = OPTS_GET(opts, object_name, NULL) ?: obj_name;
 	if (obj_buf) {
-		if (!obj_name) {
-			snprintf(tmp_name, sizeof(tmp_name), "%lx-%lx",
-				 (unsigned long)obj_buf,
-				 (unsigned long)obj_buf_sz);
-			obj_name = tmp_name;
-		}
 		path = obj_name;
 		pr_debug("loading object '%s' from buffer\n", obj_name);
+	} else {
+		pr_debug("loading object from %s\n", path);
 	}
 
 	log_buf = OPTS_GET(opts, kernel_log_buf, NULL);
@@ -8017,9 +8016,7 @@ bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts)
 	if (!path)
 		return libbpf_err_ptr(-EINVAL);
 
-	pr_debug("loading %s\n", path);
-
-	return libbpf_ptr(bpf_object_open(path, NULL, 0, opts));
+	return libbpf_ptr(bpf_object_open(path, NULL, 0, NULL, opts));
 }
 
 struct bpf_object *bpf_object__open(const char *path)
@@ -8031,10 +8028,15 @@ struct bpf_object *
 bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
 		     const struct bpf_object_open_opts *opts)
 {
+	char tmp_name[64];
+
 	if (!obj_buf || obj_buf_sz == 0)
 		return libbpf_err_ptr(-EINVAL);
 
-	return libbpf_ptr(bpf_object_open(NULL, obj_buf, obj_buf_sz, opts));
+	/* create a (quite useless) default "name" for this memory buffer object */
+	snprintf(tmp_name, sizeof(tmp_name), "%lx-%zx", (unsigned long)obj_buf, obj_buf_sz);
+
+	return libbpf_ptr(bpf_object_open(NULL, obj_buf, obj_buf_sz, tmp_name, opts));
 }
 
 static int bpf_object_unload(struct bpf_object *obj)
@@ -13761,29 +13763,13 @@ static int populate_skeleton_progs(const struct bpf_object *obj,
 int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
 			      const struct bpf_object_open_opts *opts)
 {
-	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, skel_opts,
-		.object_name = s->name,
-	);
 	struct bpf_object *obj;
 	int err;
 
-	/* Attempt to preserve opts->object_name, unless overriden by user
-	 * explicitly. Overwriting object name for skeletons is discouraged,
-	 * as it breaks global data maps, because they contain object name
-	 * prefix as their own map name prefix. When skeleton is generated,
-	 * bpftool is making an assumption that this name will stay the same.
-	 */
-	if (opts) {
-		memcpy(&skel_opts, opts, sizeof(*opts));
-		if (!opts->object_name)
-			skel_opts.object_name = s->name;
-	}
-
-	obj = bpf_object__open_mem(s->data, s->data_sz, &skel_opts);
-	err = libbpf_get_error(obj);
-	if (err) {
-		pr_warn("failed to initialize skeleton BPF object '%s': %d\n",
-			s->name, err);
+	obj = bpf_object_open(NULL, s->data, s->data_sz, s->name, opts);
+	if (IS_ERR(obj)) {
+		err = PTR_ERR(obj);
+		pr_warn("failed to initialize skeleton BPF object '%s': %d\n", s->name, err);
 		return libbpf_err(err);
 	}
 
-- 
2.43.5


