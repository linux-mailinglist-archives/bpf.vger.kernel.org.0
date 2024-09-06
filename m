Return-Path: <bpf+bounces-39128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A0296F5C9
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7121F2567D
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717001CF7DC;
	Fri,  6 Sep 2024 13:48:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD81CF2B3;
	Fri,  6 Sep 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630515; cv=none; b=i3BlqYxn54MOZm+7Ya5K3gSRHPH0hYRMvNL5y1+qAnkVY6wB3eCUpyuK+dNpt6egu0/3tB3EyI7AlP0OiIlDQC15wx0y2+XMXEe3Q0tV11nRQNkm+XRxsiZS3MnvTcyWK1LBIhe00RgzFZpuXDia5qQjZm+Zo/WUSSTU+FxAiiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630515; c=relaxed/simple;
	bh=wlwOWRdYKR00Zm5rmNIKW5fkEehkGxr67EXu3FHs30A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IRor+pQbOpQweMRd0FpwwvompW45hiDtBoK5R6qB9cCtAdo7qGHt6/mR63+mPwfMmrOPJrqjTWCEPyt21H5i2D8FBHSGrxFUzVF5ioHMXgrRODirEc7fQfX03uA9xNN+NJOk/2sZYQPzlZj2/D4Ws68y1bASw8qRG72QY1U/p38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
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
	Jiri Olsa <jolsa@kernel.org>
Cc: Sam James <sam@gentoo.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] libbpf: workaround (another) -Wmaybe-uninitialized false positive
Date: Fri,  6 Sep 2024 14:48:14 +0100
Message-ID: <f6962729197ae7cdf4f6d1512625bd92f2322d31.1725630494.git.sam@gentoo.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We get this with GCC 15 -O3 (at least):
```
libbpf.c: In function ‘bpf_map__init_kern_struct_ops’:
libbpf.c:1109:18: error: ‘mod_btf’ may be used uninitialized [-Werror=maybe-uninitialized]
 1109 |         kern_btf = mod_btf ? mod_btf->btf : obj->btf_vmlinux;
      |         ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
libbpf.c:1094:28: note: ‘mod_btf’ was declared here
 1094 |         struct module_btf *mod_btf;
      |                            ^~~~~~~
In function ‘find_struct_ops_kern_types’,
    inlined from ‘bpf_map__init_kern_struct_ops’ at libbpf.c:1102:8:
libbpf.c:982:21: error: ‘btf’ may be used uninitialized [-Werror=maybe-uninitialized]
  982 |         kern_type = btf__type_by_id(btf, kern_type_id);
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
libbpf.c: In function ‘bpf_map__init_kern_struct_ops’:
libbpf.c:967:21: note: ‘btf’ was declared here
  967 |         struct btf *btf;
      |                     ^~~
```

This is similar to the other libbpf fix from a few weeks ago for
the same modelling-errno issue (fab45b962749184e1a1a57c7c583782b78fad539).

Link: https://bugs.gentoo.org/939106
Signed-off-by: Sam James <sam@gentoo.org>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a3be6f8fac09e..7315120574c29 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -988,7 +988,7 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 {
 	const struct btf_type *kern_type, *kern_vtype;
 	const struct btf_member *kern_data_member;
-	struct btf *btf;
+	struct btf *btf = NULL;
 	__s32 kern_vtype_id, kern_type_id;
 	char tname[256];
 	__u32 i;
@@ -1115,7 +1115,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 	const struct btf *btf = obj->btf;
 	struct bpf_struct_ops *st_ops;
 	const struct btf *kern_btf;
-	struct module_btf *mod_btf;
+	struct module_btf *mod_btf = NULL;
 	void *data, *kern_data;
 	const char *tname;
 	int err;
-- 
2.46.0


