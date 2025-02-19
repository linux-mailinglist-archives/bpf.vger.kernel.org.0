Return-Path: <bpf+bounces-51965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA30A3C3D1
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 16:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD187A84C4
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3921F8BDD;
	Wed, 19 Feb 2025 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B7ahYa5B"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA4F198E81
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979469; cv=none; b=oGoRjyZFPUGOHoh0GWNOMXAqUWvL7A5dToU6duqsQ1kmQdYOm92LRBzO9TinWFnZUMcSfa2T+yT/YEvsIbTzsA8FJunGdYdwgawMRnutKYL1+IZiOReJoGks3vyDu0D0Ufkm0zmhHYO2yHIeKY5OVaC65k2NwUT+nmXFLc087Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979469; c=relaxed/simple;
	bh=sfoxJwBmGUYbXaV8RXQ4Kri7ivp02B2shgXZqxLrudQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BZdSkmjDqH2Yp+CQRa/34Va88Gt/H6PR3Z1dgga8Fv0OsYMVz/KltcA79E1gukFWnua5DdxNBcD5cmDpK6W5pR+566TxLdG6ulgb57YcW5v7ulIIPcsYz989QLMIMvCP7yT9uMdqtJ3jGRAE2xDAfm7B2CHTwl/RoQvYA6PL4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B7ahYa5B; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739979464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=meWKQfityZkPF7vIi9KYs1raiX+WMX0AQR+G8s5GJxY=;
	b=B7ahYa5BTcfhMsoSvSrEZrT+70hwuuiCP/+YVQAUv2cf+5JnEjqyD8b3JAhHiHdb3Uw1Ge
	RDdt99WOjFVKbxZt8HbMQlixJXuDHeWqFsIbj+khx2BVN2kd8TCpbd5HNtnOUHJV/lRP5v
	VH+WyXOzMUIMfQ3lY6nHq+80CYswal0=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2] libbpf: Wrap libbpf API direct err with libbpf_err
Date: Wed, 19 Feb 2025 23:37:11 +0800
Message-Id: <20250219153711.29651-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Chen <chen.dylane@gmail.com>

Just wrap the direct err with libbpf_err, keep consistency
with other APIs.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/lib/bpf/libbpf.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

Change list:
- v1 -> v2:
  - wrap err for bpf_map__set_value_size
- v1:
  https://lore.kernel.org/bpf/20250214141717.26847-1-chen.dylane@gmail.com

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da5172..6df258912e1e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9145,12 +9145,12 @@ int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
 	struct bpf_gen *gen;
 
 	if (!opts)
-		return -EFAULT;
+		return libbpf_err(-EFAULT);
 	if (!OPTS_VALID(opts, gen_loader_opts))
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 	gen = calloc(sizeof(*gen), 1);
 	if (!gen)
-		return -ENOMEM;
+		return libbpf_err(-ENOMEM);
 	gen->opts = opts;
 	gen->swapped_endian = !is_native_endianness(obj);
 	obj->gen_loader = gen;
@@ -9262,13 +9262,13 @@ int bpf_program__set_insns(struct bpf_program *prog,
 	struct bpf_insn *insns;
 
 	if (prog->obj->loaded)
-		return -EBUSY;
+		return libbpf_err(-EBUSY);
 
 	insns = libbpf_reallocarray(prog->insns, new_insn_cnt, sizeof(*insns));
 	/* NULL is a valid return from reallocarray if the new count is zero */
 	if (!insns && new_insn_cnt) {
 		pr_warn("prog '%s': failed to realloc prog code\n", prog->name);
-		return -ENOMEM;
+		return libbpf_err(-ENOMEM);
 	}
 	memcpy(insns, new_insns, new_insn_cnt * sizeof(*insns));
 
@@ -9379,11 +9379,11 @@ const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_siz
 int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size)
 {
 	if (log_size && !log_buf)
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 	if (prog->log_size > UINT_MAX)
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 	if (prog->obj->loaded)
-		return -EBUSY;
+		return libbpf_err(-EBUSY);
 
 	prog->log_buf = log_buf;
 	prog->log_size = log_size;
@@ -10307,7 +10307,7 @@ int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 		int err;
 
 		if (map->def.type != BPF_MAP_TYPE_ARRAY)
-			return -EOPNOTSUPP;
+			return libbpf_err(-EOPNOTSUPP);
 
 		mmap_old_sz = bpf_map_mmap_sz(map);
 		mmap_new_sz = array_map_mmap_sz(size, map->def.max_entries);
@@ -10315,7 +10315,7 @@ int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 		if (err) {
 			pr_warn("map '%s': failed to resize memory-mapped region: %s\n",
 				bpf_map__name(map), errstr(err));
-			return err;
+			return libbpf_err(err);
 		}
 		err = map_btf_datasec_resize(map, size);
 		if (err && err != -ENOENT) {
@@ -13070,17 +13070,17 @@ int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map)
 	int err;
 
 	if (!bpf_map__is_struct_ops(map))
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 
 	if (map->fd < 0) {
 		pr_warn("map '%s': can't use BPF map without FD (was it created?)\n", map->name);
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 	}
 
 	st_ops_link = container_of(link, struct bpf_link_struct_ops, link);
 	/* Ensure the type of a link is correct */
 	if (st_ops_link->map_fd < 0)
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 
 	err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
 	/* It can be EBUSY if the map has been used to create or
-- 
2.43.0


