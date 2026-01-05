Return-Path: <bpf+bounces-77796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 407DFCF2306
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 08:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00AF930022C2
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 07:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B332D8773;
	Mon,  5 Jan 2026 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IGKO9aQb"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1512D7DDE;
	Mon,  5 Jan 2026 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597256; cv=none; b=kdZSxs2sGQNPt8WX+fyJiGHYqP9xFEQNGge1DXhwkfZr/yKobHdLmDmuI/qCgFKBvScEEYRnfztZ5PIHp0LTBKYgNcuYl98Ny6pH+Jd+GFWcBjZy8t/isfmogG0TLYY5mwAiQissg5VAYdhrKcNDPhzYsuu4gyGIrRpzcEiS1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597256; c=relaxed/simple;
	bh=pKibkbh0guOGqnEclElsVd+BuWpyIRDnDWRsL8+LjQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gdsrJB5353b6f7UPyDJmDKPBtyCWyIGD8H18+NWMB+V5J/SfwArOhiGzO7uVOJb4ogvYcZi7YdPw8gGfaY/zuXRbMMQZwRP18cbdMx+RMy+EpRBSIA2llRHAjWbV6+DqB8GZXBnl4a7LgRgeG+2rBnJ57kxHEpkLPFx8CakMSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IGKO9aQb; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lS
	OwWKkzmcwU2ofJjv1+yQCRqU4vl5zKutjgwfxk59c=; b=IGKO9aQb4Ghoqw1g3c
	xSoFxxmbWNjdsWUvhP7wjf4tbGSPxosiciA88MWVWh+PuYV3ZtzsuMGVp77E+916
	O/WnzQ3wDhO4jZ2F5915ImKzJpN1H8eR4LfaFDbXpDitFnMeNtxdk6CYNkrUj2Fy
	QEe5AaEtvSF96WrRa7NsMZULA=
Received: from localhost.localdomain.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wA3bPlhZFtpZsEBEA--.3803S2;
	Mon, 05 Jan 2026 15:12:35 +0800 (CST)
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
Subject: [PATCH v4 bpf-next] bpftool: Make skeleton C++ compatible with explicit casts
Date: Mon,  5 Jan 2026 15:12:31 +0800
Message-Id: <20260105071231.2501-1-kiraskyler@163.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260104021402.2968-1-kiraskyler@163.com>
References: <20260104021402.2968-1-kiraskyler@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3bPlhZFtpZsEBEA--.3803S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1kAw4DuF45Aw48JF48Crg_yoWrZr17pF
	WxG34UKrW5Jr45ArW8tw4UZry5ur4Fy3WjkFyDJ3y5Zrsava4DXr17tF1UWa43trW8tryU
	t3W0qF4jvw1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi75r7UUUUU=
X-CM-SenderInfo: 5nlut2pn1ov2i6rwjhhfrp/xtbC9wVjv2lbZGUX3AAA3W

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

Minimum reproducer:

	$ cat test.bpf.c
	int val; // placed in .bss section

	#include "vmlinux.h"
	#include <bpf/bpf_helpers.h>

	SEC("raw_tracepoint/sched_wakeup_new") int handle(void *ctx) { return 0; }

	$ cat test.cpp
	#include <cerrno>

	extern "C" {
	#include "test.bpf.skel.h"
	}

	$ bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
	$ clang -g -O2 -target bpf -c test.bpf.c -o test.bpf.o
	$ bpftool gen skeleton test.bpf.o -L  > test.bpf.skel.h
	$ g++ -c test.cpp -I.

Signed-off-by: WanLi Niu <niuwl1@chinatelecom.cn>
Co-developed-by: Menglong Dong <dongml2@chinatelecom.cn>
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
changelog:
v4:
- Add a minimum reproducer to demonstrate the issue, as suggested by Yonghong Song

v3: https://lore.kernel.org/all/20260104021402.2968-1-kiraskyler@163.com/
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


