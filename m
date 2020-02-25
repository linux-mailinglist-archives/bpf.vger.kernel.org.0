Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B78F16C2E9
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2020 14:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgBYN4w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Feb 2020 08:56:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38125 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgBYN4w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Feb 2020 08:56:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so3247779wmj.3
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2020 05:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tdUpExQ3hzj21QBKAtvqnsJNrL5zKnYkhtRdt8iWk7k=;
        b=s5u3MDHXfeJEdDUkFi2tRNaJM12+acezT/J5c/Y0dUXkBOk/Z9YD1zJLa8EIPBuT6B
         7h7PRy4x1vohUccQmHB+TwhLO9VWNXD0fiWJOJKZU1nlmtsRs+w7A2QaomMVn+NiNi3u
         6GoTma0klKIR0YB8fQI4/PbM1mqrws28FonEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tdUpExQ3hzj21QBKAtvqnsJNrL5zKnYkhtRdt8iWk7k=;
        b=ZOib4ke1D+oKgawG5M4I+SsiUdKP2HJ0SDwVkqWeNV2MWdzsI8iYXNlGMX+6YS9k2a
         Mh/5/Kyz3JFR0R6NuwAL2ZHOPDhkm3ctdbSMPvklLVhry8u21MrS1t79bwAstAwNsK1s
         eeHoIw+bL2zrxdntVorfk9RUfLTKdzIcufbkFOp3hEMRr79atGZVrBbRcTk9mXxv/KyT
         C8gbyv0A1IfIjVn0ID+XvZV04Y9j0dCLqJLSoD+I7kowmfk7etzO3dzYTizUeKCZQtyd
         lka/p8AsALnY4aP6VPW6Kayao9/12opysNvx1SINbtalMmxthPGeYJ3IhZTKXHqsHanw
         yfXQ==
X-Gm-Message-State: APjAAAVK/JXVSGTMG34Aj6Lk6mnd6zLP2nH7y/sUXO4kIDu0vsmEERlx
        t1YMSlh/BQcLvlZb/qPTtRSNDzqxELFdCg==
X-Google-Smtp-Source: APXvYqwmAujwCf7IqxSUcZ5V29CAKHVHg254H8PhRtUSEgNxQ9uaMCXdJUMj69n1j+nAigX8UVaXsg==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr5662485wmi.31.1582639009440;
        Tue, 25 Feb 2020 05:56:49 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8800:3dea:15ba:1870:8e94])
        by smtp.gmail.com with ESMTPSA id t128sm4463580wmf.28.2020.02.25.05.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 05:56:48 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 7/7] selftests: bpf: enable UDP sockmap reuseport tests
Date:   Tue, 25 Feb 2020 13:56:36 +0000
Message-Id: <20200225135636.5768-8-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225135636.5768-1-lmb@cloudflare.com>
References: <20200225135636.5768-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove the guard that disables UDP tests now that sockmap has support for them.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 68d452bb9fd9..4c09766344a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -816,13 +816,6 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 		if (!test__start_subtest(s))
 			continue;
 
-		if (sotype == SOCK_DGRAM &&
-		    inner_map_type != BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
-			/* SOCKMAP/SOCKHASH don't support UDP yet */
-			test__skip();
-			continue;
-		}
-
 		setup_per_test(sotype, family, inany, t->no_inner_map);
 		t->fn(sotype, family);
 		cleanup_per_test(t->no_inner_map);
-- 
2.20.1

