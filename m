Return-Path: <bpf+bounces-77913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EE3CF67AF
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 03:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68049305B1ED
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 02:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5E21D5178;
	Tue,  6 Jan 2026 02:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YxQdRVnu"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005F03A1E92;
	Tue,  6 Jan 2026 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666776; cv=none; b=tq6a0O/4+3B7smUx9x2JOhm+3KpXhgRe6IaNQm1/nDmaLqBLfbvGnfEBmmfv7EZxEEsps7g1SwOUyTMVR7tR5NizKyv4CP9uYGQqcOFcJMXLmThr2Ahw+Xkz1OOghM4HTMcwUDxpeWXJW4F+vg+FNNrYI68HcowK+KYxAI1ewPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666776; c=relaxed/simple;
	bh=EbCn9kbANE7eCm6uterbmNY38HDgNt7chk7kfU5nklQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tsVq8h8FHebz9XJJ/WrouZAS2ldTWrkMSSvgtkAxFR/f/3i1k6hGVHHZHganBwPTyS3x6sltVydyRhU+Jm7ne5cjfqXE4mW32XTV0cblSpsKtZfOUHGALelHxunntqYy33a3+9eY6RG78euR9U6zXMSYi25EhiJ81Yvn6qwpgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YxQdRVnu; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oc
	sj9lYwNUviQnHwZw4RrPehuv0STtzSLtNRAnMc2eU=; b=YxQdRVnufCl9NNi9vn
	uFsK9iQDVsQWrmT0sya83sR6U6qMixPP7PMN2B/D/SLOz7JA2/4EXh5AjSvtBZwH
	0yjQ1T5ZKeVDC7LlLerXKbGvxX2fyVWsYPMl0rBbeku5Yhbz1DWwmreAaV22v4iv
	AQIPAjyGw/WevKoy9AgUPMplY=
Received: from localhost.localdomain.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXpfoSdFxpLl2dEg--.598S2;
	Tue, 06 Jan 2026 10:31:48 +0800 (CST)
From: WanLi Niu <kiraskyler@163.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	jose.marchesi@oracle.com,
	Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH v5 bpf-next] bpftool: Make skeleton C++ compatible with explicit casts
Date: Tue,  6 Jan 2026 10:31:23 +0800
Message-Id: <20260106023123.2928-1-kiraskyler@163.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260105071231.2501-1-kiraskyler@163.com>
References: <20260105071231.2501-1-kiraskyler@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXpfoSdFxpLl2dEg--.598S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1kCr13ZryDKrWDCFW5trb_yoWrWF1kpF
	48Cw1UKrW5Jr45ArW8Kw4UZr1Uuw4Fy3WjyrykJw45ZrsavrykXw17tF1jgasxArW8tFyj
	y3WIqF4DZw1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi75r7UUUUU=
X-CM-SenderInfo: 5nlut2pn1ov2i6rwjhhfrp/xtbC9xWT72lcdBWiAgAA3q

From: WanLi Niu <niuwl1@chinatelecom.cn>

Fix C++ compilation errors in generated skeleton by adding explicit
pointer casts and use char * subtraction for offset calculation

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
v5:
- Use char * arithmetic instead of integer subtraction for offsets as suggested by Andrii Nakryiko
- Use __typeof__() without __cplusplus special casing as suggested by Andrii Nakryiko

v4: https://lore.kernel.org/all/20260105071231.2501-1-kiraskyler@163.com/
- Add a minimum reproducer to demonstrate the issue, as suggested by Yonghong Song

v3: https://lore.kernel.org/all/20260104021402.2968-1-kiraskyler@163.com/
- Fix two additional <obj_name>__<ident> type mismatches as suggested by Yonghong Song

v2: https://lore.kernel.org/all/20251231102929.3843-1-kiraskyler@163.com/
- Use generic (struct %1$s *) instead of project-specific (struct trace_bpf *)

v1: https://lore.kernel.org/all/20251231092541.3352-1-kiraskyler@163.com/
---
 tools/bpf/bpftool/gen.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 993c7d9484a4..2f9e10752e28 100644
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
+			skel->ctx.sz = (char *)&skel->links - (char *)skel; \n\
 		",
 		obj_name, opts.data_sz);
 	bpf_object__for_each_map(map, obj) {
@@ -755,7 +755,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		\n\
 		\";							    \n\
 									    \n\
-				skel->%1$s = skel_prep_map_data((void *)data, %2$zd,\n\
+				skel->%1$s = (__typeof__(skel->%1$s))skel_prep_map_data((void *)data, %2$zd,\n\
 								sizeof(data) - 1);\n\
 				if (!skel->%1$s)			    \n\
 					goto cleanup;			    \n\
@@ -857,7 +857,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 
 		codegen("\
 		\n\
-			skel->%1$s = skel_finalize_map_data(&skel->maps.%1$s.initial_value,  \n\
+			skel->%1$s = (__typeof__(skel->%1$s))skel_finalize_map_data(&skel->maps.%1$s.initial_value,\n\
 							%2$zd, %3$s, skel->maps.%1$s.map_fd);\n\
 			if (!skel->%1$s)				    \n\
 				return -ENOMEM;				    \n\
-- 
2.39.1


