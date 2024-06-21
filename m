Return-Path: <bpf+bounces-32752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBF8912CE5
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 20:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7FD1C23D42
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 18:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BF516A95F;
	Fri, 21 Jun 2024 18:03:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B774EB51
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993013; cv=none; b=EZYsXNXl81SaxwyN9x9sewz53R5PF1BmqRM/bB6XgenNgZhbkZdz5OEmKqhGBAYsJ2vGbPlaV0fTlXUe0WQlSGf4CowFtPrF4+QvgNlLxhvDwItAT5lpbTpORh70rQlzXnaoaVVRBDU/I3Ct0wGkTE2qJFdc1+nwhE+Z60OyTEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993013; c=relaxed/simple;
	bh=9a5U9VLlASuAu726wmvMRSNNv1bLPjXRuFDOOSafFJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s+1HIsL+gRm/gco/m4cGiws1nBxtUZKI4rnzP00Dn6ow1jfuw+lTlyqjAfcZZnCJX0VGsCOAr3sWW7abTTHW7DlHRAzoGWYr5pe55JK5CYm4YEEAwfIVzPxqlvNr2ttcx0sC4LQtzQ4/0DNZXBnRZvyN4zI6gqmnRHClgzSyFBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a63359aaaa6so330898766b.2
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 11:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718993009; x=1719597809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Li8BKVzMCCDqAgaIvTr/9+kBwAsEjV4vRStWSpPw5pI=;
        b=SUlnhDceHFmA/FPTr5BFVzM7JD+YulE7r6+ZWdh5I/DQF+SB5Ql/ICAJMlfwQH7nfJ
         l3ozLwmdmePDfhZbPD7VZY38mq9MBk3KooL7BQex8Y3IfXJSHpaMWaQiue7K2iblPI/N
         cs7VKVziGd8x9f16aHZGahNrafkebNVT0lvdScco6f8NKJk6Bgu0fgRXfkfIzzxZwCAC
         JZOP5Gkk/lT5MNidDn4ONQL9sDLgmIDduVT+ll4NpSdWHnsRE8oMNMVj6lacQCV+leU5
         L9qIBgHV+ccoXI0ToMCL4L2oySPIEqLCAhge8lhz52MRsBFLfWD/zgSXr5YABQLUCn2s
         iHpA==
X-Gm-Message-State: AOJu0YxS9kDREXR9VKn7Fh6u9X8V3OCJfKelU/8IT5oPWZft9MuLsy1+
	o68PMoPI7uUSfCtHwUKdj3hwizM8CK0rESkcMKUVNBVZRcq6EB3DfZo2wA==
X-Google-Smtp-Source: AGHT+IGUh/WGapYqJa0jrRwCBnE9pgNv+DAt7uzD1f3pKkjrjkQ0dsJhUz9Gd2GBqVH356tybM+hKA==
X-Received: by 2002:a17:906:a849:b0:a6f:1b:8e99 with SMTP id a640c23a62f3a-a6fab7d7ce0mr492088266b.74.1718993008907;
        Fri, 21 Jun 2024 11:03:28 -0700 (PDT)
Received: from yatsenko-fedora-K2202N0103767.thefacebook.com ([2620:10d:c092:500::5:ea9e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf428bb5sm108495066b.13.2024.06.21.11.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:03:28 -0700 (PDT)
From: Mykyta@web.codeaurora.org, Yatsenko@web.codeaurora.org,
	mykyta.yatsenko5@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: test struct_ops bpf map auto-attach
Date: Fri, 21 Jun 2024 19:03:24 +0100
Message-ID: <20240621180324.238379-1-yatsenko@meta.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Adding selftest to verify that struct_ops maps are auto attached by
bpf skeleton's `*__attach` function.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 164f237b24dd..bceff5900016 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -185,6 +185,39 @@ static void test_dctcp(void)
 		close(fd);
 }
 
+static void test_dctcp_autoattach_map(void)
+{
+	struct cb_opts cb_opts = {
+		.cc = "bpf_dctcp",
+	};
+	struct network_helper_opts opts = {
+		.post_socket_cb	= cc_cb,
+		.cb_opts	= &cb_opts,
+	};
+	struct bpf_dctcp *dctcp_skel;
+	struct bpf_link *link;
+
+	dctcp_skel = bpf_dctcp__open_and_load();
+	if (!ASSERT_OK_PTR(dctcp_skel, "bpf_dctcp__open_and_load"))
+		return;
+
+	bpf_map__set_autoattach(dctcp_skel->maps.dctcp, true);
+	bpf_map__set_autoattach(dctcp_skel->maps.dctcp_nouse, false);
+
+	if (!ASSERT_OK(bpf_dctcp__attach(dctcp_skel), "bpf_dctcp__attach"))
+		goto destroy;
+
+	/* struct_ops is auto-attached  */
+	link = dctcp_skel->links.dctcp;
+	if (!ASSERT_OK_PTR(link, "link"))
+		goto destroy;
+
+	do_test(&opts);
+
+destroy:
+	bpf_dctcp__destroy(dctcp_skel);
+}
+
 static char *err_str;
 static bool found;
 
@@ -598,4 +631,6 @@ void test_bpf_tcp_ca(void)
 		test_tcp_ca_kfunc();
 	if (test__start_subtest("cc_cubic"))
 		test_cc_cubic();
+	if (test__start_subtest("dctcp_autoattach_map"))
+		test_dctcp_autoattach_map();
 }
-- 
2.45.0


