Return-Path: <bpf+bounces-77580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B66B9CEBAFE
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 10:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD63330164E9
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD03164AF;
	Wed, 31 Dec 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XHaoivZS"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A43148BB;
	Wed, 31 Dec 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767173236; cv=none; b=akPeCBamkcRx2BUpSQTk5VommXk4PNTi75C4uCjRRZMsuUzNPwN8XaBtaeMbx8nbHDULZT0aUXh2hzlOXOJAp4XrJfZDUuBqLnlKvTgh2hIyOe3r+Edc6wriZx32SW6LFhnMY69K/0qRk8KlVjmIcG8V8ueRl5q49DdVyfokvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767173236; c=relaxed/simple;
	bh=9LxLsh02Vy/g5YOUTV15374a1Ei5630xJVV7KbX4zVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=swVenP0AWztIsYRu35di3cPkL8TpCIwCsptc42jtQRFGXKJCJMNOuElA1BTnldyHFpRYNn5Q1hQiXccSQHvY4FhGBzLn/2khR9R5MT3fdoTctwgUw1V+m6FpS47LLYvR1jMT0r47UBDaOV3PzHKkZ3oqGiueDbO3fOaSsaGn8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XHaoivZS; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mk
	ltplsVVF60w10La+HRFzXUxVsRO5LSUW4Tcv6dnoE=; b=XHaoivZS+g0VQz0frt
	FapckDiv2D9CrXEEBUWlhSIdUUANJ5OmJqLPaYBEnBe3sJjZHho1oXEogNnGQguc
	mZsw7Nf04aRhB9tNKsG1ONQZK/o51p/L4z3sLImCO8knij1gkwYA7LDZfJbMLgXa
	6Nh5d+jGBzQsVt3KcsCu5fIHo=
Received: from localhost.localdomain.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBXfgkX7FRpPHO3DQ--.25326S2;
	Wed, 31 Dec 2025 17:25:44 +0800 (CST)
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
Subject: [PATCH bpf-next] bpftool: Make skeleton C++ compatible with explicit casts
Date: Wed, 31 Dec 2025 17:25:41 +0800
Message-Id: <20251231092541.3352-1-kiraskyler@163.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXfgkX7FRpPHO3DQ--.25326S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4xZw1UGF18GryrCry5CFg_yoW8Gry8pF
	4rG347trW3Jr45Aay0gw4rXrW5Wws3Aw40kFWkAa4DZrsavryvqr47tF1jga43XF1jkayY
	v3ZakFyjvwnrArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi75r7UUUUU=
X-CM-SenderInfo: 5nlut2pn1ov2i6rwjhhfrp/xtbC+BmwDWlU7BnymgAA38

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
+			skel = (struct trace_bpf *)skel_alloc(sizeof(*skel));\n\
 			if (!skel)					    \n\
 				goto cleanup;				    \n\
-			skel->ctx.sz = (void *)&skel->links - (void *)skel; \n\
+			skel->ctx.sz = (__u64)&skel->links - (__u64)skel;   \n\
 		",
 		obj_name, opts.data_sz);
 	bpf_object__for_each_map(map, obj) {
-- 
2.39.1


