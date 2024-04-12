Return-Path: <bpf+bounces-26677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC058A37BE
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C961F21D3E
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497451514FC;
	Fri, 12 Apr 2024 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvA2u3Ub"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C708514F122;
	Fri, 12 Apr 2024 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956581; cv=none; b=osk/LwS8xNS8SqMLcJ2b/cUgHNwQKT9r4DssSoJOWKoW9TOCguabtebJx/lxrrbSYBlPteZyZGnzrxEOdGoQVE/GsOpJDuBDM986qvwkKSqoqiE6fNfS4TKV7C8fnytyhKuNIT0bzH5I15PFlu+SZo+SUP+LH5bbyAFY+dD1p/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956581; c=relaxed/simple;
	bh=kOiNeJGVcoAa111TeF9EUHg4UgiYzaQpUB2MIZ6+pgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzsrQ5JrThAOLZGky5Gti5lVGSkOZBAAT5sHqleWoheyWa1Fx4yd33DzMNFUAkAXcKbqJSsO763yX1oRm+Di3HOI8LLgsi93SovU5aEC050gxkb/T0XlPE3VoFDGoDYZdOlZuvdFjdCvSnLlS63cSzHudX/qEGaH0gEvMpTlPdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvA2u3Ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43363C2BD11;
	Fri, 12 Apr 2024 21:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956581;
	bh=kOiNeJGVcoAa111TeF9EUHg4UgiYzaQpUB2MIZ6+pgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvA2u3Ubg+jlZCQTrl9KvD7zsTcpAXl7r3DGi77D+p/bC90gPZoRIg5OQlHBFhmO+
	 1KIXif9OuBdKfokgO5V5JUCGoMkil/spVDjtj5BrS+VFDMfqBRzEKRxaAdDFFoYidn
	 YxjnPA/t5vjt/C7q2Mm47l5Xp231yQ2mqTUaG6Pc5O9kwXTlQ2OlnU0I7OuN1Rj/cG
	 mpFnskdUhSyUGnAmI8A/QTN6emgb636y35dBdendsxKhHtT0gUl5zu8TYyEIFloO+O
	 tntgF8L1mSmPYe48o2c1Wbakd4ZI17eGVpNwzLam/jw1hy5lD/uQsHjqgJ95rxpAbv
	 Qjg2G+Tq9U5VA==
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
Subject: [PATCH 04/12] dwarf_loader: Introduce dwarf_cus__process_cu()
Date: Fri, 12 Apr 2024 18:15:56 -0300
Message-ID: <20240412211604.789632-5-acme@kernel.org>
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

Finishing the separation of creating a dcu/cu pair from processing it,
as we'll need to add the new dcu/cu pair to the list under cus__lock(),
so that we process it in order to keep a reproducible BTF encoding.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 125e361ef2bf3f7b..5090509309446890 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3233,6 +3233,16 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf_Die *
 	return dcu;
 }
 
+static int dwarf_cus__process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die,
+				 struct cu *cu, void *thr_data)
+{
+	if (die__process_and_recode(cu_die, cu, dcus->conf) != 0 ||
+	    cus__finalize(dcus->cus, cu, dcus->conf, thr_data) == LSK__STOP_LOADING)
+		return DWARF_CB_ABORT;
+
+       return DWARF_CB_OK;
+}
+
 static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die,
 					    uint8_t pointer_size, void *thr_data)
 {
@@ -3241,13 +3251,7 @@ static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *c
 	if (dcu == NULL)
 		return DWARF_CB_ABORT;
 
-	struct cu *cu = dcu->cu;
-
-	if (die__process_and_recode(cu_die, cu, dcus->conf) != 0 ||
-	    cus__finalize(dcus->cus, cu, dcus->conf, thr_data) == LSK__STOP_LOADING)
-		return DWARF_CB_ABORT;
-
-       return DWARF_CB_OK;
+	return dwarf_cus__process_cu(dcus, cu_die, dcu->cu, thr_data);
 }
 
 static int dwarf_cus__nextcu(struct dwarf_cus *dcus, Dwarf_Die *die_mem, Dwarf_Die **cu_die, uint8_t *pointer_size, uint8_t *offset_size)
-- 
2.44.0


