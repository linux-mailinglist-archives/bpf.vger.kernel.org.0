Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBB26D86EB
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 21:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjDETec (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 15:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDETec (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 15:34:32 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C45459FF
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 12:34:31 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y15-20020a62f24f000000b00627dd180a30so16489674pfl.6
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680723270;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3rfk6WecjFSy5WzvUIqzt2J+eTO4uhJqP4G3dOBpq2w=;
        b=UT48W1Nb0NKV/d5jIrlmhQnU/FKgNd5MiYNtxnV6n74FiAOQbHM3pPvzs7ddVNAxAN
         fJ53qgjhq6TH0jGqQaWOsEyvZ/NI2p8q8+gg/kDOaVSh/OcwF+GpAvQ0FAwnXSEFnRZI
         7ICawzM6Qlsxoomjeq4u995hitiyVTtNP/RXGNL4zWTTjDr3WIQ0lMlsYQ6Kl8buXot8
         5WdGjpwiiYg3U4288tOlJKcvTcDWsH1J5m5F2tmcmmipVi/NgF/BGLo42VvjWl8ZllSz
         BSt/7dcSlFVay6JGdPafy2SqkArk8VUR90a5iTGtYLsRQRor2uqn9kUyHQiIYfXEY0Eh
         C81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680723270;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rfk6WecjFSy5WzvUIqzt2J+eTO4uhJqP4G3dOBpq2w=;
        b=iqm07FccIA1eUbmtrFBfM5mCB67l/1XgXvsx45bcwTpahkAoX8r/bnfYp/nl1YNhNd
         6ObyKyNDPPn3G9UGFuv7T6xTzBgyzwbgBdgvZ5W1RzAvYeoG/i3aQSbEQh0uzlZAF4ce
         eKW4xe3LgoEFuX26JvH2SQ+6je4wG735zQGh75GIGQi7Mw5trw7+7ztF+1L63FwBaSRk
         KuVLWwifeVDOuWAWnPyeSdaxoEPUe1LVqDE+YtLNnaTe1XKOtbbhCuqU9c8+7netd+8b
         f5xYqXYxi9yjZkOZFXN0/HYUOOGVE8glmrD6+SVo0ZkKa3te/J/1bWxG43GKzqokuo6e
         ltSA==
X-Gm-Message-State: AAQBX9dcj6GJKgjJRt9PQeXfROblWGlQ8Y9M2lJEz/YM8ZhWLnbd5DMK
        zrLWqfsoiyzFQ5ssmhNI+/knb8lL7WelhPasL5OWUAhZKFD/JSpfvgBcsb+Kw/kUOrD0+GyvgUa
        wpzg6dlNqdM+/RkazDMZ1Hbqxp7xNNiGGkCDhmO58Z1CiwPaamRTSlU2nxhkoVNk=
X-Google-Smtp-Source: AKy350ac+p1ua3Cv1sHgdOTIxiB7D7eldB7VN1KwUdVxu5aV619GxUvqs9TbZ1TKC8TQ73Krf/gbEGsf9HyeAw==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:90a:4591:b0:234:acfd:c8da with SMTP
 id v17-20020a17090a459100b00234acfdc8damr2691320pjg.2.1680723270131; Wed, 05
 Apr 2023 12:34:30 -0700 (PDT)
Date:   Wed,  5 Apr 2023 19:33:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230405193354.1956209-1-zhuyifei@google.com>
Subject: [PATCH v2 bpf] selftests/bpf: Wait for receive in cg_storage_multi test
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

This can be reliably reproduced by arbitrarily increasing the
loopback latency (thanks to [1]):
  tc qdisc add dev lo root handle 1: htb default 12
  tc class add dev lo parent 1:1 classid 1:12 htb rate 20kbps ceil 20kbps
  tc qdisc add dev lo parent 1:12 netem delay 100ms

Fix this by waiting on the receive end, instead of instantly
returning to the assert. The call to read() will wait for the
default SO_RCVTIMEO timeout of 3 seconds provided by
start_server().

[1] https://gist.github.com/kstevens715/4598301

Reported-by: Martin KaFai Lau <martin.lau@linux.dev>
Link: https://lore.kernel.org/bpf/9c5c8b7e-1d89-a3af-5400-14fde81f4429@linux.dev/
Fixes: 3573f384014f ("selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress")
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
v1 -> v2:
- Changed from a call to poll() to a call to read() (Martin)

 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 621c57222191..63ee892bc757 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -56,8 +56,9 @@ static bool assert_storage_noexist(struct bpf_map *map, const void *key)
 
 static bool connect_send(const char *cgroup_path)
 {
-	bool res = true;
 	int server_fd = -1, client_fd = -1;
+	char message[] = "message";
+	bool res = true;
 
 	if (join_cgroup(cgroup_path))
 		goto out_clean;
@@ -70,7 +71,10 @@ static bool connect_send(const char *cgroup_path)
 	if (client_fd < 0)
 		goto out_clean;
 
-	if (send(client_fd, "message", strlen("message"), 0) < 0)
+	if (send(client_fd, &message, sizeof(message), 0) < 0)
+		goto out_clean;
+
+	if (read(server_fd, &message, sizeof(message)) < 0)
 		goto out_clean;
 
 	res = false;
-- 
2.40.0.348.gf938b09366-goog

