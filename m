Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA01F15A669
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2020 11:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgBLKcN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Feb 2020 05:32:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43509 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgBLKcM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Feb 2020 05:32:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id r11so1537238wrq.10
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2020 02:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nxmM5jMWanD7C8JzDeFUlJvozImeqTd9EHYHm/dmE58=;
        b=JjxqRs4fS9BA68jBNxNTapss1iDfYEC6xCp04pLUm9NpWGmmvb4316kmsveyr1WPDO
         gwHq9aXrgHtJXXKAWpvYywpQiAXJK63NXJXj4lyyYC/lp5zjwJzU4MdQAqNfiCYcOV+K
         yDV0PKShTSrrOHd7omm2jiUFtiyrcIBQ8s7G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nxmM5jMWanD7C8JzDeFUlJvozImeqTd9EHYHm/dmE58=;
        b=snnhrHcClOpdviPVCOdamXbDOHCLrDloEuo5dn5Z6Jrxq3sK+6ypk6d+eV9mqGAXfb
         B11MqIS9aoRDQD36MT9W5RwOkrC8xS6S82Lrm8ixGLY0TW12JJH0+gtVFRv+C7Arr+57
         wEMkW5cK/5W8W0Yx1GdUfqCHcDAd6yHpsViPO00J31xgOvB5WoYJrKQ2UNgGr1fVnwKZ
         zH3PYkMouNTjJ6LJ6VY6+XGRYQdBOArGXSqwyv1DJ6e5STyTudehoq3srQUE9mAewioj
         Fil2ZrFJzpg4roYhu8ySfIKiTlixmlFrVx49SuoDJMiQHQmCQYEbEJlmjmyWIdJNCcgD
         +m0Q==
X-Gm-Message-State: APjAAAVXEoUUU2XB5IzkWsu0N4qmU5hiO9Ra7iXwoffxhPBj69yP/251
        0nfVR/QCC1jvlMpPoqATiMSEpJWOdRZ52uuF
X-Google-Smtp-Source: APXvYqxzMtmMP2XBb4fASU7mfGPJDdEpR2qxAemrnoMFBhwDvSp+D+MT/AFt8g1PdKMm7Ia7d/q9Sw==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr14726593wrl.96.1581503530883;
        Wed, 12 Feb 2020 02:32:10 -0800 (PST)
Received: from cloudflare.com ([88.157.168.82])
        by smtp.gmail.com with ESMTPSA id b10sm58851wrw.61.2020.02.12.02.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 02:32:10 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf] selftests/bpf: Mark SYN cookie test skipped for UDP sockets
Date:   Wed, 12 Feb 2020 10:32:08 +0000
Message-Id: <20200212103208.438419-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SYN cookie test with reuseport BPF doesn't make sense for UDP sockets. We
don't run it but the test_progs test runner doesn't know about it. Mark the
test as skipped so the test_progs can report correctly how many tests were
skipped.

Fixes: 7ee0d4e97b88 ("selftests/bpf: Switch reuseport tests for test_progs framework")
Reported-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 098bcae5f827..db07a398e8d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -506,8 +506,10 @@ static void test_syncookie(int type, sa_family_t family)
 		.pass_on_failure = 0,
 	};
 
-	if (type != SOCK_STREAM)
+	if (type != SOCK_STREAM) {
+		test__skip();
 		return;
+	}
 
 	/*
 	 * +1 for TCP-SYN and
-- 
2.24.1

