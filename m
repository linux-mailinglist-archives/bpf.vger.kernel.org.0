Return-Path: <bpf+bounces-26678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F288A37BF
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D71F23C07
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E572A1514FF;
	Fri, 12 Apr 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAWmyaxv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF6A14F122;
	Fri, 12 Apr 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956584; cv=none; b=bw/w+5QUJiB85YYHIL/x+QyjFZX/pYRSoDetcI6K2HUtskqgY2ppMg2Cd3LKZRtk0YiyzXDFGwmeIo0mwnfalQ8HiyAGENVUBEQbsL3tMVnXo+BQnWgL9aOCdIQInrrIzKr/qoilAa2Qe7hLcPCtN4VxGp0PjJSktf4uer6ZVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956584; c=relaxed/simple;
	bh=lZh+YT5icSodMOONQ1qbwDnaEbwSwsYdN6TXHDg3f48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmYdZ4GNB7Ojyu0uQYlzvT4oXEOy4Iy83UDspaATsdsVjwhNluESCWV/nj53xlVdaZ+pGP3zPBBeF+kMDrhW6ujp07JY2xMBQokAUoid23W4nXH2aKXxSfMsVgiXf7yjmE9A621cKN5lEZiuK6OhQcn9tg3E3BtWy9ZBlTdepJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAWmyaxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2366C113CD;
	Fri, 12 Apr 2024 21:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956584;
	bh=lZh+YT5icSodMOONQ1qbwDnaEbwSwsYdN6TXHDg3f48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAWmyaxvREUVRrXVk8gSKplHLJBC9eMxGU9Eyj74l4DmCYa5wm+Avrg+SGj7FJlo2
	 jGlRQtz4dXxmIwcIXoIwNKmfNjo3xuCyZxpp6iip1I7XBB1/qmbJQw6SSWqnrNRTAJ
	 weRCzrabHzM/MjVpUwp0Y9srIp9x1CUj8rKkkxdKdfl/ZDZB6tiCAF3fFu8l/suyYI
	 aFSEml8empUGIxdPnCrP+vreoXv2PnBEOcQyv2jHln9JFckLv/Qbf21i1jOJq15By8
	 +5u/HBIdr5o/29VSTP7AE7yc0KUizJiXXMEi9R3WIvBUsS24KAVdZ0kUQKh/4XMl+P
	 we35pyBqXusqg==
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
Subject: [PATCH 05/12] dwarf_loader: Create the cu/dcu pair in dwarf_cus__nextcu()
Date: Fri, 12 Apr 2024 18:15:57 -0300
Message-ID: <20240412211604.789632-6-acme@kernel.org>
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

dwarf_cus__nextcu() is only used in parallel DWARF loading, and we want
to make sure that we preserve the order of the CUs in the DWARF file
being loaded, so move creating the cu/dcu to under that lock.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 5090509309446890..a7a8b2bea112ba75 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3254,7 +3254,9 @@ static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *c
 	return dwarf_cus__process_cu(dcus, cu_die, dcu->cu, thr_data);
 }
 
-static int dwarf_cus__nextcu(struct dwarf_cus *dcus, Dwarf_Die *die_mem, Dwarf_Die **cu_die, uint8_t *pointer_size, uint8_t *offset_size)
+static int dwarf_cus__nextcu(struct dwarf_cus *dcus, struct dwarf_cu **dcu,
+			     Dwarf_Die *die_mem, Dwarf_Die **cu_die,
+			     uint8_t *pointer_size, uint8_t *offset_size)
 {
 	Dwarf_Off noff;
 	size_t cuhl;
@@ -3274,6 +3276,15 @@ static int dwarf_cus__nextcu(struct dwarf_cus *dcus, Dwarf_Die *die_mem, Dwarf_D
 			dcus->off = noff;
 	}
 
+	if (ret == 0 && *cu_die != NULL) {
+		*dcu = dwarf_cus__create_cu(dcus, *cu_die, *pointer_size);
+		if (*dcu == NULL) {
+			dcus->error = ENOMEM;
+			ret = -1;
+			goto out_unlock;
+		}
+	}
+
 out_unlock:
 	cus__unlock(dcus->cus);
 
@@ -3286,13 +3297,13 @@ static void *dwarf_cus__process_cu_thread(void *arg)
 	struct dwarf_cus *dcus = dthr->dcus;
 	uint8_t pointer_size, offset_size;
 	Dwarf_Die die_mem, *cu_die;
+	struct dwarf_cu *dcu;
 
-	while (dwarf_cus__nextcu(dcus, &die_mem, &cu_die, &pointer_size, &offset_size) == 0) {
+	while (dwarf_cus__nextcu(dcus, &dcu, &die_mem, &cu_die, &pointer_size, &offset_size) == 0) {
 		if (cu_die == NULL)
 			break;
 
-		if (dwarf_cus__create_and_process_cu(dcus, cu_die,
-						     pointer_size, dthr->data) == DWARF_CB_ABORT)
+		if (dwarf_cus__process_cu(dcus, cu_die, dcu->cu, dthr->data) == DWARF_CB_ABORT)
 			goto out_abort;
 	}
 
-- 
2.44.0


