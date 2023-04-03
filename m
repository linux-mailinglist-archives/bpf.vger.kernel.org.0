Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CFA6D540F
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 23:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjDCV7u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 17:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjDCV7t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 17:59:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174026A2
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 14:59:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5458201ab8cso309019917b3.23
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 14:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680559187;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bmrk7dYxkwQ5TK9pzLGQaHk+Oh8ppPjY2AwOTGU6a28=;
        b=KcG/ghnkBXvL/0Op8KVOA6oJ1P1SA4V3ZMlhrI2iUUCFLGXwGGv16lgvoNKr8kKen8
         XjUOlxIG6JkM+0XJIb/H4U3HIiQIe8NDPZgxjJ1HVCeFmSqOFuUXJL3njyRl/M/toAcz
         nlSI7eArgDTCjFw5H3OcQcwoVIeuZF/NAvZs9q3sVPRu8JeVG+z0i3J9SLyDmpRXETzi
         XdlCmt/IVfUZMXdkOQN3NiQR492ghWze1/nc2Qxyxs8fMAyjfS6A4rtkZsM9Ulg8f4mu
         Xe5IuyBGOHi2LsgdAQeDpjPrLE+rWxewwukS7qd4oPw6euHqaCFgFpFXR9FilbRLwZKv
         ldTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559187;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bmrk7dYxkwQ5TK9pzLGQaHk+Oh8ppPjY2AwOTGU6a28=;
        b=tBYp6t20i65K4cMEbwfwkotwJtQMK75ftiOaqsnBTh50ABfa1JMt8YjMyE3mG46Jei
         zkidBiT2u4AkO1JYr3W16GMCwJC3OEBf8i87Q5yzZL55jZKO3LlPs+46P0VCjIe5I3sx
         bGIPvmrkyN7Sb7PMkLUcZ7Sr5YQCVuYRqwGnGUrTfMZKntKVRWQ/kIvZtfOKeWR2TiFG
         3jtq0txGT2ZbRvA0bpp48fJLbGGtHnRTNqG6mVN9DH1RwUzLjm+0HSwy6kzqI7ZosKCH
         E853Kz7uN0mwMUzvFkk3p90WReQxJNA3DgUKzRjApQSb8w9pzinsR3wCwLCmnRxcy1eQ
         aJrg==
X-Gm-Message-State: AAQBX9dO5sxJ+tJz95eBkYYeQuena0QJfBYinU28TCfmjx05B9YmcA++
        MCBnwZCNAFi7qiisSSx6v70uY79j7GdCekbh3jAhAPBMFa8dbj6HKwfpo1uC4SSnXiUnb24cjWn
        2xEmh3b/i+kQ8TsSwWEWaBtVgzyJP2yyvq8gxDMQTE7jgXgpzalP0W1hC+hTYsuE=
X-Google-Smtp-Source: AKy350bTzFPTFBitM1W9oVLLa6ILNe3PpRMZQ8zO4fbNIvXRQfi3kuQwbK4xXLR2L6JtKnaJro/XvWDUjsgAKA==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a05:690c:dd0:b0:533:a15a:d33e with SMTP
 id db16-20020a05690c0dd000b00533a15ad33emr11441457ywb.5.1680559187662; Mon,
 03 Apr 2023 14:59:47 -0700 (PDT)
Date:   Mon,  3 Apr 2023 21:58:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230403215834.26675-1-zhuyifei@google.com>
Subject: [PATCH bpf] selftests/bpf: Poll for receive in cg_storage_multi test
From:   YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In some cases the loopback latency might be large enough, causing
the assertion on invocations to be run before ingress prog getting
executed. The assertion would fail and the test would flake.

This can be reliably reproduced by arbitrarily increaing the loopback
latency (thanks to [1]):
  tc qdisc add dev lo root handle 1: htb default 12
  tc class add dev lo parent 1:1 classid 1:12 htb rate 20kbps ceil 20kbps
  tc qdisc add dev lo parent 1:12 netem delay 100ms

Fix this by polling on the receive end and waiting for up to a
second, instead of instantly returning to the assert.

[1] https://gist.github.com/kstevens715/4598301

Reported-by: Martin KaFai Lau <martin.lau@linux.dev>
Link: https://lore.kernel.org/bpf/9c5c8b7e-1d89-a3af-5400-14fde81f4429@linux.dev/
Fixes: 3573f384014f ("selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress")
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../testing/selftests/bpf/prog_tests/cg_storage_multi.c  | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 621c57222191..3b0094a2a353 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -7,6 +7,7 @@
 #include <test_progs.h>
 #include <cgroup_helpers.h>
 #include <network_helpers.h>
+#include <poll.h>
 
 #include "progs/cg_storage_multi.h"
 
@@ -56,8 +57,9 @@ static bool assert_storage_noexist(struct bpf_map *map, const void *key)
 
 static bool connect_send(const char *cgroup_path)
 {
-	bool res = true;
 	int server_fd = -1, client_fd = -1;
+	struct pollfd pollfd;
+	bool res = true;
 
 	if (join_cgroup(cgroup_path))
 		goto out_clean;
@@ -73,6 +75,11 @@ static bool connect_send(const char *cgroup_path)
 	if (send(client_fd, "message", strlen("message"), 0) < 0)
 		goto out_clean;
 
+	pollfd.fd = server_fd;
+	pollfd.events = POLLIN;
+	if (poll(&pollfd, 1, 1000) != 1)
+		goto out_clean;
+
 	res = false;
 
 out_clean:
-- 
2.40.0.348.gf938b09366-goog

