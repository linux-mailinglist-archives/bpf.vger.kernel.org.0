Return-Path: <bpf+bounces-26676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412358A37BD
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723421C211F7
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB241514FB;
	Fri, 12 Apr 2024 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7q0P7MC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4387714F122;
	Fri, 12 Apr 2024 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956579; cv=none; b=HmYgE1jh9myW5xbUWdaaUjnEfw1gN00jc/XWQcE1q/FMXxiDfDO9QKBXyod7zDitlZAZzfc251Wblluv9hxnHHa9JBJh0XFS233Jns4kdWrxUSk4eWn6r0CZgJwOzNKP4gJocBXBdj3gsSfLWRFqx5m9aSXy0idfC3MWTn4m7sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956579; c=relaxed/simple;
	bh=q+NUCdJP4mSxrZnr1exlGkXjhSC5UscKjBVbqiYsyl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsaLFsOL2mbzEPVti4zz2ite8QbMGRFIf7x2EAKV/r1ELmey6Eugf82K/Za2ZQ7GEpAPW9yVfxswn8ZJz0Sim4InOaxLig9rLRVrn3u5WwhyQHQayUWw5zKngScp7oH9ISJIk3opTwvk4bobCLQxDLq6sVvFeOAIPiKiBjOFbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7q0P7MC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AE7C3277B;
	Fri, 12 Apr 2024 21:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956578;
	bh=q+NUCdJP4mSxrZnr1exlGkXjhSC5UscKjBVbqiYsyl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7q0P7MCw73jhvIxiHLfQnRbmRLRpbj2hmXhVt8mSCWa6hQWfsPIb8BLrfc8VSWN/
	 njEqoz/iM3bBuYZswtbXHzvt86/pS48V8GvJ8N6oL0JO/5eq4PsjqygjqXYmnY9cFQ
	 ytTCDeKqds2uVklLoSPZjWRj4INb4bZEHw+4IDzC8iGf30GQkaLFQkwHv3aP69zEli
	 Jd+FQOhUhB69lhs/Rwjj106X1dtXAl7+zX0qe7Twru0/OhBg4D6VGTYLif5X/0f9+U
	 IG4uGdbRb9OgORNaturR1RPBHOpSWL+eXsBsXJjcrXrt6p/OQd7zjZIHv6c5ZjuMQe
	 Uc4lM7GPIBnyQ==
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
Subject: [PATCH 03/12] dwarf_loader: Separate creating the cu/dcu pair from processing it
Date: Fri, 12 Apr 2024 18:15:55 -0300
Message-ID: <20240412211604.789632-4-acme@kernel.org>
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

We will need it so that we add the dcu to a list in the same order as
the CUs are in the DWARF file (vmlinux mostly).

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 1dffb3f433cb7c8e..125e361ef2bf3f7b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3207,8 +3207,7 @@ struct dwarf_thread {
 	void			*data;
 };
 
-static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die,
-					    uint8_t pointer_size, void *thr_data)
+static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die, uint8_t pointer_size)
 {
 	/*
 	 * DW_AT_name in DW_TAG_compile_unit can be NULL, first seen in:
@@ -3218,17 +3217,32 @@ static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *c
 	const char *name = attr_string(cu_die, DW_AT_name, dcus->conf);
 	struct cu *cu = cu__new(name ?: "", pointer_size, dcus->build_id, dcus->build_id_len, dcus->filename, dcus->conf->use_obstack);
 	if (cu == NULL || cu__set_common(cu, dcus->conf, dcus->mod, dcus->elf) != 0)
-		return DWARF_CB_ABORT;
+		return NULL;
 
 	struct dwarf_cu *dcu = dwarf_cu__new(cu);
 
-	if (dcu == NULL)
-		return DWARF_CB_ABORT;
+	if (dcu == NULL) {
+		cu__delete(cu);
+		return NULL;
+	}
 
 	dcu->type_unit = dcus->type_dcu;
 	cu->priv = dcu;
 	cu->dfops = &dwarf__ops;
 
+	return dcu;
+}
+
+static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die,
+					    uint8_t pointer_size, void *thr_data)
+{
+	struct dwarf_cu *dcu = dwarf_cus__create_cu(dcus, cu_die, pointer_size);
+
+	if (dcu == NULL)
+		return DWARF_CB_ABORT;
+
+	struct cu *cu = dcu->cu;
+
 	if (die__process_and_recode(cu_die, cu, dcus->conf) != 0 ||
 	    cus__finalize(dcus->cus, cu, dcus->conf, thr_data) == LSK__STOP_LOADING)
 		return DWARF_CB_ABORT;
-- 
2.44.0


