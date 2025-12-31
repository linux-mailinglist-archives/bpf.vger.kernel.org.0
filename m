Return-Path: <bpf+bounces-77584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9990CEBCA9
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 11:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC66730334FA
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 10:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC88831D757;
	Wed, 31 Dec 2025 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Vt13nKVR"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3622156B;
	Wed, 31 Dec 2025 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767177056; cv=none; b=iOWS8RIvUOPwWsaZkuIjcb5yvsFds8gtIotfOIh9JRci5XMcA9Gnkt5fFn1saqItpc31yEQyACXIz3+qrQW547T7ct2PammXCLH62udHw+KBiIuMP/ZlOvI1HMN7iFBd93WQa8P3KpScEEjpz9+kaPGFsv0Iqf4XcgxSryfI6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767177056; c=relaxed/simple;
	bh=E6GOEO7OGWN8uTZkd4DoD7PX8Vgwk68cu0WdvGQw1rE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AnBrR5G6XCc82ZQL0tEMPFcBjct7BfrKpogRgYoBhoxtkvR7diEMAb472vHn4VE/MkGJQh0z4OPVifvxk7c/Uyt2vI07QbCeyxyRz94iYLP9/CQ40BSPyNX0+AhB0GDmlBDaQlUnAxwVAku+zUs1y251HEQoaDCKbEyiB6sxyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Vt13nKVR; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=q+
	vF4e852W0iY+2nPmQMBu1d7MpMGG3WuLSgVe2U48E=; b=Vt13nKVRgIrN+80PNH
	4pDaBRnD0oqkeCjrNyL151KbqvBIBD3QTdjlq2aZ+0Xwb9m3FAWR00ARLf4A8M9I
	FoGLuDOGKYvvCItI8pKHGdkdU2Og/DY/iZuvahV1DjbLBj3H3KuDrR18eSUDYo6n
	6BsNXZF35Xm0fBurLzdwyslHA=
Received: from localhost.localdomain.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgA3krsW+1Rpf+csKw--.18719S2;
	Wed, 31 Dec 2025 18:29:43 +0800 (CST)
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
Subject: [PATCH v2 bpf-next] bpftool: Make skeleton C++ compatible with explicit casts
Date: Wed, 31 Dec 2025 18:29:29 +0800
Message-Id: <20251231102929.3843-1-kiraskyler@163.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20251231092541.3352-1-kiraskyler@163.com>
References: <20251231092541.3352-1-kiraskyler@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgA3krsW+1Rpf+csKw--.18719S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4xZw1UGF18GryrCry5CFg_yoW8Gr43pF
	4rG347trW3Jr45Aay0gw4rXrW5Wws3Aw40kFWkAa4DZrsavryvqw47tF1jga43XF1jkayY
	v3ZakFy0vw1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEtkuxUUUUU=
X-CM-SenderInfo: 5nlut2pn1ov2i6rwjhhfrp/xtbC9xdzz2lU+xfSTQAA3S

From: WanLi Niu <niuwl1@chinatelecom.cn>

Fix C++ compilation errors in generated skeleton by adding explicit
pointer casts and using integer subtraction for offset calculation.

error: invalid conversion from 'void*' to 'trace_bpf*' [-fpermissive]
      |         skel = skel_alloc(sizeof(*skel));
      |                ~~~~~~~~~~^~~~~~~~~~~~~~~
      |                          |
      |                          void*

error: invalid use of 'void'
      |         skel->ctx.sz = (void *)&skel->links - (void *)skel;

Signed-off-by: WanLi Niu <niuwl1@chinatelecom.cn>
Co-developed-by: Menglong Dong <dongml2@chinatelecom.cn>
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/bpf/bpftool/gen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 993c7d9484a4..71446a776130 100644
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
-- 
2.39.1


