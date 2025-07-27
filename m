Return-Path: <bpf+bounces-64468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6965BB13241
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 00:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5A3189413E
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 22:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F42512C3;
	Sun, 27 Jul 2025 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="o7MJK0Ao"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8E22424E
	for <bpf@vger.kernel.org>; Sun, 27 Jul 2025 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655555; cv=none; b=SP0J3O8YKv7M2o//UzlpO6zRwdlsdiZ7nwVzZAEjI9aDyWtjb2WACjsJyw0kk7b1k9FbzIDb4OpxtPZPB3t5rmyCMD4sWJUZXW24EtRs+DP8xL5WOGH8I2PaR7Il3UVoBqbzrIovQDzzEoa/CT5dQ1+LiIi6wQnXe+IJuZTt/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655555; c=relaxed/simple;
	bh=nWS8Ccu89/p6O4ob9ijbGBAQ6WjTKbMjX9dyjcA8Mrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zx4yP+j4Hc0Krty6rHMgyQiXtpb02s8JnURjPfvla1Q0bCwOsj6mka8ZppnwuvZa5xRdg/uFFJ8Qk60/pzaLqKEjSFDQIDmtW89QYblXJ7a48qPa0F/fwSR/TlLY/iL666/frvIE9I+65KiaUirU0bWeKD0irN1aE+hDjDKkI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=o7MJK0Ao; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=AaI7KSQYYjXv4QOiqz483XldhKZK4GGXOWpyz3BSQy0=; b=o7MJK0Aob2FJMe13C3OktEyiPt
	287Df7mo0otDj6Gu53euPvXOHtzh4AvhM2cWv3yCPlS7JIigyrKjvzdeaoR76d+D5T+3xjuofXs2U
	iLMFoYZ8pjBWJ2tIoXza2CieKMzbcrq9maTgzEqxmG+KcYjc+31OpvBf1J9R53yU1p2RVNGWu7Ito
	VWdT9wBOPJ0kn8r2JuhfvDGVO65MOKiGFwbcWc5ISbu3zHhXh8++1WSPYtKfMCG6Tqpk0SmKbKeok
	SGpgjtz2jQc+RwL1+dfISLd+Mogqt3tukSk3DGTPTBgfjk6OROIGITYFC7IwigiPwTdISZF9ik2Oz
	W+4AOghQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ug9us-000NM4-0V;
	Mon, 28 Jul 2025 00:32:26 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	bpf@vger.kernel.org,
	Lonial Con <kongln9170@gmail.com>
Subject: [PATCH bpf-next 4/4] bpf: Fix oob access in cgroup local storage
Date: Mon, 28 Jul 2025 00:32:23 +0200
Message-ID: <20250727223223.510058-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727223223.510058-1-daniel@iogearbox.net>
References: <20250727223223.510058-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27712/Sun Jul 27 10:35:17 2025)

Lonial reported that an out-of-bounds access in cgroup local storage
can be crafted via tail calls. Given two programs each utilizing a
cgroup local storage with a different value size, and one program
doing a tail call into the other. The verifier will validate each of
the indivial programs just fine. However, in the runtime context
the bpf_cg_run_ctx holds an bpf_prog_array_item which contains the
BPF program as well as any cgroup local storage flavor the program
uses. Helpers such as bpf_get_local_storage() pick this up from the
runtime context:

  ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
  storage = ctx->prog_item->cgroup_storage[stype];

  if (stype == BPF_CGROUP_STORAGE_SHARED)
    ptr = &READ_ONCE(storage->buf)->data[0];
  else
    ptr = this_cpu_ptr(storage->percpu_buf);

For the second program which was called from the originally attached
one, this means bpf_get_local_storage() will pick up the former
program's map, not its own. With mismatching sizes, this can result
in an unintended out-of-bounds access.

To fix this issue, we need to extend bpf_map_owner with an array of
storage_cookie[] to match on i) the exact maps from the original
program if the second program was using bpf_get_local_storage(), or
ii) allow the tail call combination if the second program was not
using any of the cgroup local storage maps.

Fixes: 7d9c3427894f ("bpf: Make cgroup storages shared between programs on the same cgroup")
Reported-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/core.c   | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a41dff574327..63169b1611cc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -281,6 +281,7 @@ struct bpf_map_owner {
 	enum bpf_prog_type type;
 	bool jited;
 	bool xdp_has_frags;
+	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
 };
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 666d4019d87f..7a8201763936 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2371,6 +2371,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	struct bpf_prog_aux *aux = fp->aux;
+	enum bpf_cgroup_storage_type i;
 	bool ret = false;
 
 	if (fp->kprobe_override)
@@ -2386,11 +2387,21 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner->jited = fp->jited;
 		map->owner->xdp_has_frags = aux->xdp_has_frags;
 		map->owner->attach_func_proto = aux->attach_func_proto;
+		for_each_cgroup_storage_type(i) {
+			map->owner->storage_cookie[i] =
+				aux->cgroup_storage[i] ?
+				aux->cgroup_storage[i]->cookie : 0;
+		}
 		ret = true;
 	} else {
 		ret = map->owner->type  == prog_type &&
 		      map->owner->jited == fp->jited &&
 		      map->owner->xdp_has_frags == aux->xdp_has_frags;
+		for_each_cgroup_storage_type_cond(i, ret) {
+			u64 cookie = aux->cgroup_storage[i] ?
+				     aux->cgroup_storage[i]->cookie : 0;
+			ret = map->owner->storage_cookie[i] == cookie || !cookie;
+		}
 		if (ret &&
 		    map->owner->attach_func_proto != aux->attach_func_proto) {
 			switch (prog_type) {
-- 
2.43.0


