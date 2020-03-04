Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B460D178E23
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 11:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbgCDKN7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 05:13:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44920 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387915AbgCDKN5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 05:13:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id i10so589280lfg.11
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 02:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olVifyTMleE2iedo0uCkocgafSknigkP2OP2Ek8xo9Y=;
        b=iPqLt7CUHivuNV8QujDV0W6QulaQWe6wT9uZYQ5ZKRMJDmO8MQGos3/IzH+Krr8TzL
         V1nEmvK5FFV62gRr6+sRztw3JaEsNXJHEpcLHkOLZPkC877v4r1Qx/J/EsqMr2kDeaIJ
         7RQpEjKYkaijGth3oAl+LoIx5x2nAxyaiWqE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olVifyTMleE2iedo0uCkocgafSknigkP2OP2Ek8xo9Y=;
        b=tqPniLYzoTwgmgrDRl4Byvf1j+AA6E5vDBhwYBZxxolLAdebHVuXnR7MmGS1XAOe/+
         l1f0varZ0paofhiAEfYSBe8ztcEXcnFt4YAnUqZwRR4oYFF4S5aPZYedouUNc/lX/qDP
         VWVaqaZ8tHRyvSygwFGEOvEyFOJBrezp+jvYkVUSbpMks36nk+r02MSIIzutaki0XFIZ
         ou0DNwtYLRabZe5VmqqnTq904Q9cK9Yp3f74D10iperi6dVvy199w1NvA3zDqNrtgFlT
         /JtUhnrwlELtry8Cj7CMyI3zad/roF1OVxZlh2F2K71iD8FTbyN/ZnCG7ooSosOqwD2C
         5S2Q==
X-Gm-Message-State: ANhLgQ20DSZmxjRHRjl4nbgRM06ZW4V1zq0LPDHqIBp5fO8LLMPt0wp1
        NiO1f76GnLRJP80Cf4HAloi8/A==
X-Google-Smtp-Source: ADFU+vsuEdVRpVHa3R4OMO85FbKQo1R+1kABMKY1D8/UloF2u7KmlAOlqXrDgoY2Yx6iLysg/Te0XQ==
X-Received: by 2002:ac2:5dd3:: with SMTP id x19mr940358lfq.168.1583316835115;
        Wed, 04 Mar 2020 02:13:55 -0800 (PST)
Received: from localhost.localdomain ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id l7sm341777lfk.65.2020.03.04.02.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:13:54 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     john.fastabend@gmail.com, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 11/12] selftests: bpf: enable UDP sockmap reuseport tests
Date:   Wed,  4 Mar 2020 11:13:16 +0100
Message-Id: <20200304101318.5225-12-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304101318.5225-1-lmb@cloudflare.com>
References: <20200304101318.5225-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove the guard that disables UDP tests now that sockmap
has support for them.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index a1dd13b34d4b..821b4146b7b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -805,12 +805,6 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 	char s[MAX_TEST_NAME];
 	const struct test *t;
 
-	/* SOCKMAP/SOCKHASH don't support UDP yet */
-	if (sotype == SOCK_DGRAM &&
-	    (inner_map_type == BPF_MAP_TYPE_SOCKMAP ||
-	     inner_map_type == BPF_MAP_TYPE_SOCKHASH))
-		return;
-
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
 		if (t->need_sotype && t->need_sotype != sotype)
 			continue; /* test not compatible with socket type */
-- 
2.20.1

