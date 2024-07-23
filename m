Return-Path: <bpf+bounces-35411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FE393A581
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CD21F231B1
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFB0158A03;
	Tue, 23 Jul 2024 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xmh70Lht"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8815884A
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759088; cv=none; b=F+ik8I+7Yy3I4xOvGL2/y0M2aQU6I8KXUQt3DEy4uBVeNfCoW+i7oFJkgnHIdl4fC5flyXn+3vNtXUnipLDSJAZgsGVV7uljlLxCkEGYH8voOuBiiebZE8gto9IyGFyJx4O503Ni0OajHThG0nhQXbweFeGybiqp65RK0d7Qz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759088; c=relaxed/simple;
	bh=ihYgw4M2lkyecXhJKCD3eO5cq80OgeHQK0kthDOzV/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CstDRRPaFTlGspIJf6YQE4sWa80JDEFnEMperoVrtFUGWrcOz+lXxNia44AQTp8/4qohdSKf2dzhk2qcRCQJxlxIL17BPjazQDuHGzIRHeEmD0ePrzZ4jtvM8zTKMqAZN3B5zri/Leyl0ZR5F8dwFySaNwc0dgvve42kvx+hrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xmh70Lht; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-66526e430e0so60426857b3.2
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721759086; x=1722363886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R54fpFcr6bpu9R3suSzipHUdpjYomaDR25zuQ/wjsFM=;
        b=Xmh70LhtxGHPtnDK0ksQMS7NhNPovWk1GWU6J5GJb9NGknDK8AvFvdxr+tBY90BBpK
         4s2o0GDCfymH+xpqNcxiOAIp7BnzjRQsf8SE7F9HnvAnbPI88kyyY3dZUQgtiRZvDwwb
         MHzhn4sG7Cvx+Ff4BkAe0skbTV3ePp9taDaVQLCF1CWXyaw35xp9EMTBU9xOcmUdmHu8
         CwUIepm6y/lcunz/1V/SADaDwdRWWdi/Dkm54S/jTujjSgr6GgLr4pR+fHtCnIBHiNBb
         iehll3FfKwKm8i0KDUNGvIFrGhY9zMHaYmpYMK8HNadQ9w7A7nppDV8A1WsRKYtTVwgW
         JN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759086; x=1722363886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R54fpFcr6bpu9R3suSzipHUdpjYomaDR25zuQ/wjsFM=;
        b=COBGFJ1uf5fCFLOS2Cb9ZR06DAHE9gomhRJHH96xvNp5G2U3aWbYQ9WZWDL5XqqRwH
         fkIrnT0sEQ07C6f5V362FDxXZiLPKO4J8qe67VefF+cI3uiMe7KNdwn3679lZ2jqb1dO
         xlg6mWPk1ifgJPL6QFPzOcLW67+H+RD1xxe5vBuEEOE1wZjQEUNxlEAMUrzqVtajTuVB
         C45P2nqB6F4y05xge64T5nQodQ7QfFoPK7fEUMc5KYef62fb9g088htjFMl2nkzROOmP
         LM2wh3O5w6EajHGV6O/sLV7J4wQjobZpv+D1Nu5SsBpFbdDnyFJmYMI8uDXMTSWmD7rT
         rsew==
X-Gm-Message-State: AOJu0YwlcCg5Y536xt6XdKHlJ4YlKbUa70qWOCmvCxYri+XvEpC5dGTN
	KoQirLkQsBFTLkm+msWVJDu/z+Ah1f9qwH/dxdLCXjqLiShlbYY0iN2yZZIw
X-Google-Smtp-Source: AGHT+IEd0h+eG1INJlCr/NJY0mW72QjGeVhIqQ1gDAK7XENGQvgTm2sP73vYrtuWqKDOkNwlhtuS/Q==
X-Received: by 2002:a05:690c:318e:b0:64a:4161:4f91 with SMTP id 00721157ae682-66ad8cc880dmr108327307b3.14.1721759085920;
        Tue, 23 Jul 2024 11:24:45 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:e02a:b5d8:6984:234c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6695293fd9csm20637577b3.69.2024.07.23.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:24:45 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Monitor traffic for sockmap_listen.
Date: Tue, 23 Jul 2024 11:24:38 -0700
Message-Id: <20240723182439.1434795-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723182439.1434795-1-thinker.li@gmail.com>
References: <20240723182439.1434795-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable traffic monitor for each subtest of sockmap_listen.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index e91b59366030..62683ccb6d56 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -28,6 +28,7 @@
 #include "test_sockmap_listen.skel.h"
 
 #include "sockmap_helpers.h"
+#include "network_helpers.h"
 
 static void test_insert_invalid(struct test_sockmap_listen *skel __always_unused,
 				int family, int sotype, int mapfd)
@@ -1893,14 +1894,21 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 {
 	const char *family_name, *map_name;
 	char s[MAX_TEST_NAME];
+	struct tmonitor_ctx *tmon;
 
 	family_name = family_str(family);
 	map_name = map_type_str(map);
 	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
 	if (!test__start_subtest(s))
 		return;
+
+	tmon = traffic_monitor_start(NULL);
+	ASSERT_TRUE(tmon, "traffic_monitor_start");
+
 	inet_unix_skb_redir_to_connected(skel, map, family);
 	unix_inet_skb_redir_to_connected(skel, map, family);
+
+	traffic_monitor_stop(tmon);
 }
 
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
-- 
2.34.1


