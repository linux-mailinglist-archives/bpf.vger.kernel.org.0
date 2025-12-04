Return-Path: <bpf+bounces-76038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC0ACA3100
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 10:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D44130806A7
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA558334374;
	Thu,  4 Dec 2025 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEdfWufI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBBC1684B4;
	Thu,  4 Dec 2025 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841402; cv=none; b=uFNuG8tMh6lNRvhkkdPN5VJfUlC+4hwexBfQAkoRSteZzoa7SF1/PcPPAlo+y+sQKOBDZAhfuA4Y5pbSimiJ6dgVK1Z20fuvlscxDb09iy+iL+KAo9ZqPnQqnunTQs4VN1dydpCQt/3HPYqp24sVMEAbCxZTpUavv0E0pnau1+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841402; c=relaxed/simple;
	bh=i719IVwzunRk0bUpoVWQH64JzMF6T7ZMbitybqxPC2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q7aNe+QB2VdVa/4MGTzjib88evJ42CZFQVW0TqRKbV4TlWoNgqT0cWnNwcqAavQw0k1Sa0NWkIqPK62uo/5tMeNQjAkLlF2aY1Abyorzl/RpkgmEYb0UJndo+679COMM/kHa8VwGmHGmmilMfQKZhjWsuA/9zW2pAyOTDk0eLcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEdfWufI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFBFC4CEFB;
	Thu,  4 Dec 2025 09:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764841401;
	bh=i719IVwzunRk0bUpoVWQH64JzMF6T7ZMbitybqxPC2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=jEdfWufIW3bt4PIZqF34wJTy52wUxMFXe0CHajkHFHdlqJq37aushI4RZN6VB6hxo
	 +gJ+f4j/64yNc7179Fx8BVyQzhTXDfJ37RKeHkjZWWHPs7dsGReLZeD0t6TLeoUj6C
	 LuTFTSg2C6+VgKIIuSSx3X8VvJMzLbmP+mXMxrzQIsU3NT84MOZjpU0TJQrKkzcwhu
	 MkNJEMMFONt9/RFfKheFFQTiTzvd0q93CFugg/QntLEJ1NIKShBU2CTtonIlSiq5+G
	 7jLZ/CJg+iFj7t7SgQhJu6wmxTrdwxv5njhKMGkwYG/No1VDVPAoTaTdBbfUVsu1O2
	 G/o26FM7XZv0Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Dust Li <dust.li@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Tao Chen <chen.dylane@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: avoid warning for unused register_bpf_struct_ops()
Date: Thu,  4 Dec 2025 10:42:33 +0100
Message-Id: <20251204094312.1029643-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The macro originally introduced in commit f6be98d19985 ("bpf, net:
switch to dynamic registration") causes a warning in the new smc code
because of the way it evaluates the arguments:

In file included from include/linux/bpf_verifier.h:7,
                 from net/smc/smc_hs_bpf.c:13:
net/smc/smc_hs_bpf.c: In function 'bpf_smc_hs_ctrl_init':
include/linux/bpf.h:2076:50: error: statement with no effect [-Werror=unused-value]
 2076 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
      |                                                  ^~~~~~~~~~~~~~~~
net/smc/smc_hs_bpf.c:139:16: note: in expansion of macro 'register_bpf_struct_ops'
  139 |         return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);
      |                ^~~~~~~~~~~~~~~~~~~~~~~

Work around this using an inline function that takes the argument,
the same way as the normal implementation. Since the second argument to
register_bpf_struct_ops() is a type rather than an object, this still
has to be a macro, but it can call a new inline helper internally like
the normal one does.

Fixes: 15f295f55656 ("net/smc: bpf: Introduce generic hook for handshake flow")
Cc: Kui-Feng Lee <thinker.li@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/bpf.h | 2 +-
 include/linux/btf.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6498be4c44f8..eca6966d4f87 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2065,7 +2065,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
 void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc);
 #else
-#define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
+#define register_bpf_struct_ops(st_ops, type) __register_bpf_struct_ops(st_ops)
 static inline bool bpf_try_module_get(const void *data, struct module *owner)
 {
 	return try_module_get(owner);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index f06976ffb63f..799a75209536 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -535,6 +535,11 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
 const struct bpf_struct_ops_desc *bpf_struct_ops_find_value(struct btf *btf, u32 value_id);
 const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
 #else
+struct bpf_struct_ops;
+static inline int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
+{
+	return 0;
+}
 static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
 	return NULL;
-- 
2.39.5


