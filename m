Return-Path: <bpf+bounces-77755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4800CCF0869
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 03:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE3B030145A7
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 02:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2564241690;
	Sun,  4 Jan 2026 02:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QHsUUqTL"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDFB239E9E;
	Sun,  4 Jan 2026 02:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493098; cv=none; b=iATHpntrCBBx/+OrvCCS9hWeJ7MHZkW1Lxz+adlKBcPHW0UsjNsIFgC2ZBqCocvj4Xiq2ZsRdL492oRxzRSpXZDRxL3r5+12+dFCkEbeS9TCqWYHddoZTBEsgXWwIrFviST5ekS/MhpS3aDga1MoiGsHeeSIqJ0cuuR2s/YrHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493098; c=relaxed/simple;
	bh=V7y0WPXu/mx7dNLScS1GjFa+Sf32uk1SQYEgjaG1NA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UyiSs99dJBfGQkUwaKiRRS5glexWLNNqZg5Snh5P6yvhfaXTdd2YzESR9HPTjiADR+XaGaAF/jzXykwsrfDjBi2CtsvlU209E7SylZO+daO3zPO7d4MSWzIMSpKDubiZLhHmFlYrvpmwGxISywS9LbAttBFAwcffI9GTCy4PUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QHsUUqTL; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uH
	jbJoYKvM8t/F8Mg4yiCQehxMlmwPPmei3d2I3PHwo=; b=QHsUUqTLkYnnd80D0P
	VRLEMSwIB66ww50HZRbVKbXOslwZI5k/5/1JLY03cPjCybz913i4nQ7YaQjgNVs7
	/YsO6Bnl1Na2DPbSJ8pZ4hDMcBFWoDPMIPM54tagSJ2MjZs2m45fEKk9aTRpIFnF
	B07Td7cyw4oIo32vFnMLjxkI4=
Received: from localhost.localdomain.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBHN2r+zFlpYSkwDw--.25134S2;
	Sun, 04 Jan 2026 10:14:24 +0800 (CST)
From: WanLi Niu <kiraskyler@163.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	WanLi Niu <kiraskyler@163.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WanLi Niu <niuwl1@chinatelecom.cn>,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH v3 bpf-next] bpftool: Make skeleton C++ compatible with explicit casts
Date: Sun,  4 Jan 2026 10:14:02 +0800
Message-Id: <20260104021402.2968-1-kiraskyler@163.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20251231102929.3843-1-kiraskyler@163.com>
References: <20251231102929.3843-1-kiraskyler@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHN2r+zFlpYSkwDw--.25134S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1kAw4DuF45Aw48JF48Crg_yoWrJF4DpF
	47Gw1UtrW5JF45ArW8Kw4UZryrur4rA3W0kF1DJ3y5Zrsava4DXr17tF1UWa43Jr1UtryU
	ta10qF4jqw1DArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zioq2tUUUUU=
X-CM-SenderInfo: 5nlut2pn1ov2i6rwjhhfrp/xtbC2wEkgGlZzQHwsgAA3A

From: WanLi Niu <niuwl1@chinatelecom.cn>

Fix C++ compilation errors in generated skeleton by adding explicit
pointer casts and using integer subtraction for offset calculation.

Use struct outer::inner syntax under __cplusplus to access nested skeleton map
structs, ensuring C++ compilation compatibility while preserving C support

error: invalid conversion from 'void*' to '<obj_name>*' [-fpermissive]
      |         skel = skel_alloc(sizeof(*skel));
      |                ~~~~~~~~~~^~~~~~~~~~~~~~~
      |                          |
      |                          void*

error: arithmetic on pointers to void
      |         skel->ctx.sz = (void *)&skel->links - (void *)skel;
      |                        ~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~

error: assigning to 'struct <obj_name>__<ident> *' from incompatible type 'void *'
      |                 skel-><ident> = skel_prep_map_data((void *)data, 4096,
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                 sizeof(data) - 1);
      |                                                 ~~~~~~~~~~~~~~~~~

error: assigning to 'struct <obj_name>__<ident> *' from incompatible type 'void *'
      |         skel-><ident> = skel_finalize_map_data(&skel->maps.<ident>.initial_value,
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                         4096, PROT_READ | PROT_WRITE, skel->maps.<ident>.map_fd);
      |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: WanLi Niu <niuwl1@chinatelecom.cn>
Co-developed-by: Menglong Dong <dongml2@chinatelecom.cn>
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
changelog:
v3:
- Fix two additional <obj_name>__<ident> type mismatches as suggested by Yonghong Song

v2: https://lore.kernel.org/all/20251231102929.3843-1-kiraskyler@163.com/
- Use generic (struct %1$s *) instead of project-specific (struct trace_bpf *)

v1: https://lore.kernel.org/all/20251231092541.3352-1-kiraskyler@163.com/
---
 tools/bpf/bpftool/gen.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 993c7d9484a4..010861b7d0ea 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -731,10 +731,10 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		{							    \n\
 			struct %1$s *skel;				    \n\
 									    \n\
-			skel = skel_alloc(sizeof(*skel));		    \n\
+			skel = (struct %1$s *)skel_alloc(sizeof(*skel));    \n\
 			if (!skel)					    \n\
 				goto cleanup;				    \n\
-			skel->ctx.sz = (void *)&skel->links - (void *)skel; \n\
+			skel->ctx.sz = (__u64)&skel->links - (__u64)skel;   \n\
 		",
 		obj_name, opts.data_sz);
 	bpf_object__for_each_map(map, obj) {
@@ -755,13 +755,17 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		\n\
 		\";							    \n\
 									    \n\
+		#ifdef __cplusplus                                          \n\
+				skel->%1$s = (struct %3$s::%3$s__%1$s *)skel_prep_map_data((void *)data, %2$zd,\n\
+		#else                                                       \n\
 				skel->%1$s = skel_prep_map_data((void *)data, %2$zd,\n\
+		#endif							    \n\
 								sizeof(data) - 1);\n\
 				if (!skel->%1$s)			    \n\
 					goto cleanup;			    \n\
 				skel->maps.%1$s.initial_value = (__u64) (long) skel->%1$s;\n\
 			}						    \n\
-			", ident, bpf_map_mmap_sz(map));
+			", ident, bpf_map_mmap_sz(map), obj_name);
 	}
 	codegen("\
 		\n\
@@ -857,12 +861,16 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 
 		codegen("\
 		\n\
+		#ifdef __cplusplus					    \n\
+			skel->%1$s = (struct %4$s::%4$s__%1$s *)skel_finalize_map_data(&skel->maps.%1$s.initial_value,\n\
+		#else							    \n\
 			skel->%1$s = skel_finalize_map_data(&skel->maps.%1$s.initial_value,  \n\
+		#endif							    \n\
 							%2$zd, %3$s, skel->maps.%1$s.map_fd);\n\
 			if (!skel->%1$s)				    \n\
 				return -ENOMEM;				    \n\
 			",
-		       ident, bpf_map_mmap_sz(map), mmap_flags);
+		       ident, bpf_map_mmap_sz(map), mmap_flags, obj_name);
 	}
 	codegen("\
 		\n\
-- 
2.39.1


