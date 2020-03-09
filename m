Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7452B17DE61
	for <lists+bpf@lfdr.de>; Mon,  9 Mar 2020 12:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgCILNy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Mar 2020 07:13:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39119 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCILNa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Mar 2020 07:13:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id f7so4711109wml.4
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2020 04:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QaTFcTkFq4Xguxn8bSzfnksfS0c2jnlyVSoCBPs8eek=;
        b=vhJLcMYmm/qr33TiAo7JT5z9HUaVRDrZxOEz87v6imXUfpQppv5xXULXiHOZUArRRp
         FFGy2atvM1OycOehbNrLU6P63rckxQ5xm5mpMolVJvbPuKMVwijc1yTXJj+7Q6XXNB9u
         mCjeJOvp1kRypn4zZL6FicO2iv+f6FuzwaSm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QaTFcTkFq4Xguxn8bSzfnksfS0c2jnlyVSoCBPs8eek=;
        b=GCHCEGTj+qDmOdLLJjKKPshovgKLw6vNdL2O8OHRNPlRQYGDE8cbSyKadL6qR64N0y
         sDKECK/XLRbWWSgPOIVsHefhRbjAnJ0mMOQwIutoUuHQkzz8w8n9HkbMbNAK7Kign9YT
         Z87gn/fgr/3iUxpmtsgRAUcS0NQRdooN4tE2p2p3hJDLheikGFFMJRO0siKcTpFlvZDL
         e6Cn+EH+6SzYm94xCWe1o6kegrxP16kvwRFH8iTmDZk+sw9lib6ATKXSeVk+O97WXQEh
         Rx8DpxhDSL3IjTGE0LFGVyCImMvQ4hibLemXfjETDqqqc6QCRvwST3Nso6uuhaZMcmNJ
         ouwQ==
X-Gm-Message-State: ANhLgQ3U/3DPtfiL70Po0IaC6IDFOwcnu1A0J+LYfYLQ7b+cdZG4gUXL
        zQ7wpZ5oRv9QpazDeglS0mvAGQ==
X-Google-Smtp-Source: ADFU+vtelcGYQQ7cq2t6WKsONlaRaq72BxVgq3eY1uel/I49QzMryenNk1JX3ZTxqPj2w/PQTT0LSA==
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr18926382wml.57.1583752408076;
        Mon, 09 Mar 2020 04:13:28 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3dcc:c1d:7f05:4873])
        by smtp.gmail.com with ESMTPSA id a5sm25732846wmb.37.2020.03.09.04.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:13:27 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 11/12] selftests: bpf: enable UDP sockmap reuseport tests
Date:   Mon,  9 Mar 2020 11:12:42 +0000
Message-Id: <20200309111243.6982-12-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309111243.6982-1-lmb@cloudflare.com>
References: <20200309111243.6982-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove the guard that disables UDP tests now that sockmap
has support for them.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
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

