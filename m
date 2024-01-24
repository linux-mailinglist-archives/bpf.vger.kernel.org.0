Return-Path: <bpf+bounces-20279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D1D83B4E3
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 23:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493131C2334B
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 22:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AF1135419;
	Wed, 24 Jan 2024 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P/FeieDe"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9C5F551
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136274; cv=none; b=DBdksixxZfmfR3VNOp1YkgGFKr99Ox5gBXHu9b9DIzyQc3kS6f63s45msRXM56kuuXAM1OmYKMqj3KYkZm0BcCBAnPrv1e+gTV1aE4UGomrMvm7m9mAAdHn+Wd0xvq3Y6Z7GJPC/hWKRY0wezY9VX+pem09vv9fSGVj0eCi1CVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136274; c=relaxed/simple;
	bh=7G4JTZs9Oh4IXtUJws8KyxPy+eiUaZ/z5NKV2gr7TrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rOFPY509MqNd2Z91DDzABX/TpTkR+8l4DLXAPGI68VxdPCF3EMm4qTpY1sQeHxtfk80BGXzLpWjmj2GvUtDIMNPoOYVxOydjlqs9NMyrrpK16/7UO16avY/IklBlw9OHNACI+b7yqLxyQevjY4WOLD6DdzcJyUqqvCXvwogv8VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P/FeieDe; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706136269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gilc0nvNv9rxYQU8AC4rWwkZQRPxk8elA4heKfpjnvQ=;
	b=P/FeieDeDsvipCh0E77xA19IgYNrCqyWcI4itv0dAwLUR0rZfGzpn8gD7+b2s2Dxwjttp1
	lEUFYK9sgOxhW6P5NOdOb9AE1byvoAsytfmmxa+Hfitii/GlBd9Ph9htkKqB8l9oltfuRv
	QLmFddO6PAdnNVennijhZWG3rsjELOg=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH v2 bpf-next] libbpf: Ensure undefined bpf_attr field stays 0
Date: Wed, 24 Jan 2024 14:44:18 -0800
Message-Id: <20240124224418.2905133-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The commit 9e926acda0c2 ("libbpf: Find correct module BTFs for struct_ops maps and progs.")
sets a newly added field (value_type_btf_obj_fd) to -1 in libbpf when
the caller of the libbpf's bpf_map_create did not define this field by
passing a NULL "opts" or passing in a "opts" that does not cover this
new field. OPT_HAS(opts, field) is used to decide if the field is
defined or not:

	((opts) && opts->sz >= offsetofend(typeof(*(opts)), field))

Once OPTS_HAS decided the field is not defined, that field should
be set to 0. For this particular new field (value_type_btf_obj_fd),
its corresponding map_flags "BPF_F_VTYPE_BTF_OBJ_FD" is not set.
Thus, the kernel does not treat it as a fd field.

Cc: Kui-Feng Lee <thinker.li@gmail.com>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: 9e926acda0c2 ("libbpf: Find correct module BTFs for struct_ops maps and progs.")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
v2: Improve the commit message

 tools/lib/bpf/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 3a35472a17c5..b133acfe08fb 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -192,7 +192,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.btf_key_type_id = OPTS_GET(opts, btf_key_type_id, 0);
 	attr.btf_value_type_id = OPTS_GET(opts, btf_value_type_id, 0);
 	attr.btf_vmlinux_value_type_id = OPTS_GET(opts, btf_vmlinux_value_type_id, 0);
-	attr.value_type_btf_obj_fd = OPTS_GET(opts, value_type_btf_obj_fd, -1);
+	attr.value_type_btf_obj_fd = OPTS_GET(opts, value_type_btf_obj_fd, 0);
 
 	attr.inner_map_fd = OPTS_GET(opts, inner_map_fd, 0);
 	attr.map_flags = OPTS_GET(opts, map_flags, 0);
-- 
2.34.1


