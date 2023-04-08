Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A3A6DB825
	for <lists+bpf@lfdr.de>; Sat,  8 Apr 2023 04:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjDHC3r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 22:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHC3r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 22:29:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE36C65D
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 19:29:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 20so2165154plk.10
        for <bpf@vger.kernel.org>; Fri, 07 Apr 2023 19:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680920985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhhCJ3JagFk6aPxuLlvnrcDSjcQ4v6yptvfivQV5v5Q=;
        b=lgKKCCn3xtbqCgLareUd1pq7KzScWsMcltlrK+3CpGEaawqAOC3cBKzxLjCcWYUMAj
         sYopE4kIkL+DgPf5BErDbVcUd46FC38q3NaTvnybyMnmjOZl55a0EPFuo85OAQ7F7AZP
         7oAbc3NHpYyrD600oo2odjyPYq5tmYlC2gQND0WJOHnICX4GgRz7xC8LBQfDAJVF1+VE
         P58a5+6CU3+0+CPZa9zK5hPmHwrSqR9UlpLUIheBe9M5chfYRnAsM1TICUbPnWolPFRo
         8yDbPlbImxIL+GGv24rov6VfEF56p20Vn4+rwoDsZoeckfrVXkm8aluB4HZ1oDTjnvDE
         6itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680920985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhhCJ3JagFk6aPxuLlvnrcDSjcQ4v6yptvfivQV5v5Q=;
        b=Z9rcIAJxpwRJcTA6Sdj0FqKpFVBlaPPNym+IbUjIIKfOXuxY2Sar+DI6mFmwEYOb8x
         G8kFi04ADRVVW2RQAelqZV6TYZVnL24KgQuaftjmrnWI45r7oorPELcSRzvh3Ud6KXVN
         LAlvGb3mIONZHJ2J5bRGcQnRWtLi840HHVe35gJhM56/lT0Jod5q1uxI4o/oDdp9EsSC
         5OeDOLL4rURm04Tcpb2g0k5Wr88DKKLu+NccRhskFc6gMGDH2UIRQHNXWU4joJavnDK9
         5iMQorP3CBi33PJYWGEXoBl0XTEnYITA51cWZZ6Y1PVY0eq+5D4W39EzvJoFboz51Gm2
         3JLw==
X-Gm-Message-State: AAQBX9fVrxjrYlNqKGlpiQRP0xdwxpnEvghU46EY8NR2gu22fE9aMDbp
        G96E3AF2shkPE1k3GMQ9Kj8=
X-Google-Smtp-Source: AKy350YUNtYz7hPmWPtxJLpjGVI9YW6wJfAP4fE3OVtSDoht5sx4jxyaoOTzlCe/WQY0bobsILbgJw==
X-Received: by 2002:a17:903:308a:b0:1a2:1513:44bf with SMTP id u10-20020a170903308a00b001a2151344bfmr513454plc.1.1680920985209;
        Fri, 07 Apr 2023 19:29:45 -0700 (PDT)
Received: from localhost (fwdproxy-prn-003.fbsv.net. [2a03:2880:ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id i19-20020a170902eb5300b001a01bb92273sm3517296pli.279.2023.04.07.19.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 19:29:44 -0700 (PDT)
From:   Manu Bretelle <chantr4@gmail.com>
To:     chantr4@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, xukuohai@huawei.com,
        eddyz87@gmail.com, bpf@vger.kernel.org
Subject: [PATCH] selftests/bpf: Reset err when symbol name already exist in kprobe_multi_test
Date:   Fri,  7 Apr 2023 19:29:19 -0700
Message-Id: <20230408022919.54601-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When trying to add a name to the hashmap, an error code of EEXIST is
returned and we continue as names are possibly duplicated in the sys
file.

If the last name in the file is a duplicate, we will continue to the
next iteration of the while loop, and exit the loop with a value of err
set to EEXIST and enter the error label with err set, which causes the
test to fail when it should not.

This change reset err to 0 before continue-ing into the next iteration,
this way, if there is no more data to read from the file we iterate
through, err will be set to 0.

Behaviour prior to this change:
```
test_kprobe_multi_bench_attach:FAIL:get_syms unexpected error: -17
(errno 2)

All error logs:
test_kprobe_multi_bench_attach:FAIL:get_syms unexpected error: -17
(errno 2)
Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
```

After this change:
```
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
```

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 22be0a9a5a0a..2173c4bb555e 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -381,8 +381,10 @@ static int get_syms(char ***symsp, size_t *cntp, bool kernel)
 			continue;
 
 		err = hashmap__add(map, name, 0);
-		if (err == -EEXIST)
+		if (err == -EEXIST) {
+			err = 0;
 			continue;
+		}
 		if (err)
 			goto error;
 
-- 
2.34.1

