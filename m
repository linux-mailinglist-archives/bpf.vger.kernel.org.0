Return-Path: <bpf+bounces-26682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F6C8A37C3
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932231C2188B
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A9F152179;
	Fri, 12 Apr 2024 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlBmFO7Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FE814F13E;
	Fri, 12 Apr 2024 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956594; cv=none; b=CKwIbOCeXDyTDaNSFmuX5dFqoTSMZV/DkgTqVdlCijBovlC+4UplhqM/YF7QWj0AMgrwdMcixu2LnwJHmTjgZBvgrTVISxmmG7RUJ5U9VyGNndV/dYPdoaTMq4ci1x5QvBcCb5uORaj+1Ra4l5aFrhkI4ueboA6ZVPonN8LSVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956594; c=relaxed/simple;
	bh=z7+fhvSYnE+bw/Mf0nRnQV50P8GFALuiKdWStWfrOt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeS9jKiWZsRTPoaZd1qdOcLLcMXoX2f9XDjhY5jil4flAbgbrkxPsYtQV9FpGBDqUdlWbp61hqbaPY02mykIeS92My4v3D8T2k2eW87b19auXv7H2GpznRey+IpzWnWrB1Iiq9CU7u50zEe4/5ISjDRjPK1XjAt/LMzLjf7LUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlBmFO7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D62C113CC;
	Fri, 12 Apr 2024 21:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956594;
	bh=z7+fhvSYnE+bw/Mf0nRnQV50P8GFALuiKdWStWfrOt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AlBmFO7ZHzcScZjqrmtOpdRDLd4NRqeX3VZo04ggWjnaT4z3qXrd1tQzcgpajVjxl
	 4khrbJWLtvgw8Dytol5dYMvQuOzExA71AiBm9AbPgMLqjY+5Axc9TS/RZMzi7Tzw56
	 V3Jl7gcWuYjAR0ALx+J+6TkdXQDMqD0bKGRipBkIrFJPF2pX7Qa0m7cV2gmOaiM2St
	 6HGtOnz0vM7EWtMtUd+edBlAgsTtKzh13/KNhI8Bq4JCl/afSs08FUfIVhL9ZZKtaY
	 Db5HzXlhc6coaY4o6shRcZFixiuosbQn/T/7HXWQd8WdTZ07SnBuv+//H+akWmzXYI
	 TkqbhqVmp1kdg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 09/12] dwarf_loader: Add the cu to the cus list early, remove on LSK_DELETE
Date: Fri, 12 Apr 2024 18:16:01 -0300
Message-ID: <20240412211604.789632-10-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412211604.789632-1-acme@kernel.org>
References: <20240412211604.789632-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We want to keep it in the same order as in the original DWARF file we're
loading (e.g. vmlinux), we'll only remove it after we load and process
(e.g. convert to BTF).

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index a097b67a2d123b55..3ef22aada6f46f13 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3034,12 +3034,12 @@ static int cus__finalize(struct cus *cus, struct cu *cu, struct conf_load *conf,
 	int lsk = cu__finalize(cu, conf, thr_data);
 	switch (lsk) {
 	case LSK__DELETE:
+		cus__remove(cus, cu);
 		cu__delete(cu);
 		break;
 	case LSK__STOP_LOADING:
 		break;
 	case LSK__KEEPIT:
-		cus__add(cus, cu);
 		break;
 	}
 	return lsk;
@@ -3064,7 +3064,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
 	return 0;
 }
 
-static int __cus__load_debug_types(struct conf_load *conf, Dwfl_Module *mod, Dwarf *dw, Elf *elf,
+static int __cus__load_debug_types(struct cus *cus, struct conf_load *conf, Dwfl_Module *mod, Dwarf *dw, Elf *elf,
 				   const char *filename, const unsigned char *build_id,
 				   int build_id_len, struct cu **cup, struct dwarf_cu *dcup)
 {
@@ -3098,6 +3098,7 @@ static int __cus__load_debug_types(struct conf_load *conf, Dwfl_Module *mod, Dwa
 			cu->dfops = &dwarf__ops;
 
 			*cup = cu;
+			cus__add(cus, cu);
 		}
 
 		Dwarf_Die die_mem;
@@ -3250,6 +3251,8 @@ static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *c
 	if (dcu == NULL)
 		return DWARF_CB_ABORT;
 
+	cus__add(dcus->cus, dcu->cu);
+
 	return dwarf_cus__process_cu(dcus, cu_die, dcu->cu, NULL);
 }
 
@@ -3282,6 +3285,9 @@ static int dwarf_cus__nextcu(struct dwarf_cus *dcus, struct dwarf_cu **dcu,
 			ret = -1;
 			goto out_unlock;
 		}
+		// Do it here to keep all CUs in cus->cus in the same
+		// order as in the DWARF file being loaded (e.g. vmlinux)
+		__cus__add(dcus->cus, (*dcu)->cu);
 	}
 
 out_unlock:
@@ -3496,15 +3502,15 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 	struct dwarf_cu type_dcu;
 	int type_lsk = LSK__KEEPIT;
 
-	int res = __cus__load_debug_types(conf, mod, dw, elf, filename, build_id, build_id_len, &type_cu, &type_dcu);
+	int res = __cus__load_debug_types(cus, conf, mod, dw, elf, filename, build_id, build_id_len, &type_cu, &type_dcu);
 	if (res != 0) {
 		return res;
 	}
 
 	if (type_cu != NULL) {
 		type_lsk = cu__finalize(type_cu, conf, NULL);
-		if (type_lsk == LSK__KEEPIT) {
-			cus__add(cus, type_cu);
+		if (type_lsk == LSK__DELETE) {
+			cus__remove(cus, type_cu);
 		}
 	}
 
-- 
2.44.0


