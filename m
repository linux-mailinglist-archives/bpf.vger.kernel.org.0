Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11F46E0A7F
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 11:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDMJrz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 05:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjDMJry (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 05:47:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6DB8A7B
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 02:47:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so7674944wms.1
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681379269; x=1683971269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4/oO082dOt4EwITGqWOexRCxEJLa06bqlXdHk1KiCiQ=;
        b=MQSgK8dOR6rR8kFn6rVvivqonifxqMtGS5eN8+7xZ/xMXVUN4gSs16iGt0WYC3ONPD
         mNJuxtwhSsogpq0/sXdjOROyKhrzzAxQ0+mi/gBPPAIvW1QLWH27bNGjhVOszCtN9zOZ
         2RxJ24pSQRTMdMuSla8VSpfk4mA7QM6FlyC4asSqOB1dndCHWT7lEKbRt+64MdLU9kkG
         kfJfj1mN4tN+9pc2ED5v91j1BB0lid0CMHloHApvAnXsdZH8TgxiTdj+XVwmhxpNYat9
         3InXj50cCFkz+2yMYqSpogY6yiwomdY8ltWHYLqYB61MIofTqrvqTWudEIWNgXt0gXcF
         a9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681379269; x=1683971269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/oO082dOt4EwITGqWOexRCxEJLa06bqlXdHk1KiCiQ=;
        b=OAEoU4j7lFsh1ACOiuSyZg24AtZQLpNc5JEnF85SIJekgAyg7SXLGUhOrMCH+DmFaN
         sI5kzGDJkJJe85LMxEGlBHb6YgTX4PZbym++uwB70j2nQM2NMKSbLd4r9L4jAO8hEFGK
         7CcORVeVufW8IFLL0mtRp3ZbltgvOt/gRkv9n1pzC67+iCiycBE2xA2AHBWZMhn99gUK
         TbUuwkHWmoPf91sWuU3nZ7dkO6GN/qDYZYUs8LumfHHL68fEkzfZ1VvsTUhHwq9cDdi3
         +jD+/YVDjRnA3XnnI+EgDA7B1O1/mon/lcTHdmxK9qHo1w1igA9VslrxwfHJ/Sc1PXtW
         vKmQ==
X-Gm-Message-State: AAQBX9da0XBvkSIahi3X5tNJbXNJvG0mFrITCYlZ0jaqdBCGavsbe1hI
        r7dAZAwkFfkOZ0GdT72Wl2aFxg==
X-Google-Smtp-Source: AKy350bZgS+9y7MBg3FzvGhjAHkayG7nGlg3MFuAW+LgzIZnoH2MqXfsSpEeDQm+rO7crZrNouhRDg==
X-Received: by 2002:a05:600c:2286:b0:3ee:5754:f139 with SMTP id 6-20020a05600c228600b003ee5754f139mr1445478wmf.13.1681379269469;
        Thu, 13 Apr 2023 02:47:49 -0700 (PDT)
Received: from tpx1.lan (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c0a4900b003ee6aa4e6a9sm5070674wmq.5.2023.04.13.02.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 02:47:49 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Lorenz Bauer <lmb@isovalent.com>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: fix use of uninitialized op_name in log tests
Date:   Thu, 13 Apr 2023 10:47:40 +0100
Message-Id: <20230413094740.18041-1-lmb@isovalent.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

One of the test assertions uses an uninitialized op_name, which leads
to some headscratching if it fails. Use a string constant instead.

Fixes: b1a7a480a112 ("selftests/bpf: Add fixed vs rotating verifier log tests")
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
index 475092a78deb..8337c6bc5b95 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
@@ -110,7 +110,7 @@ static void verif_log_subtest(const char *name, bool expect_load_error, int log_
 		}
 		if (!ASSERT_EQ(strlen(logs.buf), 24, "log_fixed_25"))
 			goto cleanup;
-		if (!ASSERT_STRNEQ(logs.buf, logs.reference, 24, op_name))
+		if (!ASSERT_STRNEQ(logs.buf, logs.reference, 24, "log_fixed_contents_25"))
 			goto cleanup;
 	}
 
-- 
2.39.2

