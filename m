Return-Path: <bpf+bounces-36513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509EC949B03
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 00:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BDE1C21F61
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F287172BD3;
	Tue,  6 Aug 2024 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci6QEDCN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661B170A02
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982377; cv=none; b=ZRyNKur9QdTsacE+Jzk5aHCt5ibvAGWxQ2+8DpOagHUV7lbSCghmrJPKTUfCfqJoEmkeh6XdvBvkTCEcRlcPz6O3JoA1WtS1VtdIXJjaUnnIOQWOm+Fz5nHrRhIoWZ0dxP3A5t8JlmEMR1Zbwif9ZG8vjEFhdMwQX84kY0SB6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982377; c=relaxed/simple;
	bh=7wIP0nj9a2egH90z6cRf9BwLZVqaNqHp/0dFKd5AEQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YAbmJQ7OBmKwTM39Ch3VYO6zRPFYaZocB9lcUSrxBajVY3dp/nHGbTmlrSupYNz+x3C9omTIeQrV2xlvgqZpdqNfeT53fpzQZvqYgsjF0ZANje+mxXFQ/i/QyyIiWU+TvXaVN97cVbj7CEt4PeB3xecKsdh/ip5EoIvvu4A7hRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci6QEDCN; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-690aabe2600so10128837b3.0
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722982375; x=1723587175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG3k6wqWPbDwV0ySmCsyFRprISwu4asFnhPgKGLKgNk=;
        b=ci6QEDCNeSORQ/yr7FZeJcI/+gnVJXhTxmBjBigtbA+YRQi8Jvyfn9MCvMQH+DSaGa
         OyGKGCQV7kUiXCvCzvHG2LhW6xobMi6P14R7ieFdS01mKh/bpPW53Wsz9NNv11nhfe/h
         87YYunPNC9y5yTM+Aoa/0J8g+tUyRCAw1XUlDUKTPH2vOddgbm5HFqzOhL+Lm5vAM/yg
         iqtmueMJUb3h12rJNI0XpZNOQ+JGnIRmudvJA/Ao/4ZQwn5nycfjsyVJd9C2zJRhVcKv
         8SNuewOEVjRwm5pz+mrnQFM66glnYeZ5cZDUm2rhVZpT7SM+UlArcx9CFuCgZIOog9jI
         nhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982375; x=1723587175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG3k6wqWPbDwV0ySmCsyFRprISwu4asFnhPgKGLKgNk=;
        b=Ybl7SyCeiqHrvVCa6JTCMaijoTWZHFTSNVlQgyJpo0JfmPJYhq6mouZ50W5VyTJZNS
         OQoDMle+8DPDWmSFu49PjY75CIw0PXelzileG4i/PfFQOqT+9rv1Y+ci6vOGygXFzSy8
         Bw6uHfgM1zeRupgvPnJ+jZkhfnjBTA7JAG/K83cnIrZBwL9pxU4FPhM9YSVmLoyBQdxj
         efuyDgkiT/2ZTl+lyq0xmZmMbexKXCeBOu0AM9DbWa1JGt1sCGRNYSVjIQcc7dYIefWr
         xXEB/S/y4fwymvlz9zpGcB8DBZt9SIlF2Cb+sZSomKLSVvC9DHQIwhPzJzxt3fc59rvx
         g9LA==
X-Gm-Message-State: AOJu0YzpshBm40k2CNZ1xNY1HbRIzYlr423YrhxpJjkXgroJzvBnpcXH
	8AoPGq6JFAE8GZmAeU8XyE72Qra3SpVeJdlele2c0kRAJJUC3WEAGvAN2LmJ
X-Google-Smtp-Source: AGHT+IGcaqw6CGOKaVj/xdMAZuyE6ycLHho6NSOPNGUVCEsDplWyIenTDN3Mv6xaVLJaPrZpePGmUg==
X-Received: by 2002:a81:5b08:0:b0:685:5939:36d3 with SMTP id 00721157ae682-68963707bd1mr181134247b3.30.1722982375295;
        Tue, 06 Aug 2024 15:12:55 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a12d138b6sm16990017b3.88.2024.08.06.15.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:12:54 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me,
	geliang@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 4/6] selftests/bpf: Monitor traffic for tc_redirect.
Date: Tue,  6 Aug 2024 15:12:41 -0700
Message-Id: <20240806221243.1806879-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806221243.1806879-1-thinker.li@gmail.com>
References: <20240806221243.1806879-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable traffic monitoring for the test case tc_redirect.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 33 +++++++++++++++----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 53b8ffc943dc..0001f38ad9c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -68,6 +68,7 @@
 		__FILE__, __LINE__, strerror(errno), ##__VA_ARGS__)
 
 static const char * const namespaces[] = {NS_SRC, NS_FWD, NS_DST, NULL};
+static struct netns_obj *netns_objs[3];
 
 static int write_file(const char *path, const char *newval)
 {
@@ -87,27 +88,45 @@ static int write_file(const char *path, const char *newval)
 
 static int netns_setup_namespaces(const char *verb)
 {
+	struct netns_obj **ns_obj = netns_objs;
 	const char * const *ns = namespaces;
-	char cmd[128];
 
 	while (*ns) {
-		snprintf(cmd, sizeof(cmd), "ip netns %s %s", verb, *ns);
-		if (!ASSERT_OK(system(cmd), cmd))
-			return -1;
+		if (strcmp(verb, "add") == 0) {
+			*ns_obj = netns_new(*ns, false);
+			if (!*ns_obj) {
+				log_err("netns_new failed");
+				return -1;
+			}
+		} else {
+			if (!*ns_obj) {
+				log_err("netns_obj is NULL");
+				return -1;
+			}
+			netns_free(*ns_obj);
+			*ns_obj = NULL;
+		}
 		ns++;
+		ns_obj++;
 	}
 	return 0;
 }
 
 static void netns_setup_namespaces_nofail(const char *verb)
 {
+	struct netns_obj **ns_obj = netns_objs;
 	const char * const *ns = namespaces;
-	char cmd[128];
 
 	while (*ns) {
-		snprintf(cmd, sizeof(cmd), "ip netns %s %s > /dev/null 2>&1", verb, *ns);
-		system(cmd);
+		if (strcmp(verb, "add") == 0) {
+			*ns_obj = netns_new(*ns, false);
+		} else {
+			if (*ns_obj)
+				netns_free(*ns_obj);
+			*ns_obj = NULL;
+		}
 		ns++;
+		ns_obj++;
 	}
 }
 
-- 
2.34.1


