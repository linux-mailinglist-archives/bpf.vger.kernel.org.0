Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023CB5B2A08
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 01:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIHXQb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 19:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiIHXQY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 19:16:24 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDA2BB00B
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 16:16:23 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id r194-20020a632bcb000000b0043541f027d9so2171081pgr.4
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=WXnjmdIZb8SItePycRIoqj321JtXN7AVWGBtHTjKeOI=;
        b=auGjm7l00c3N6SBaC9Csw5++EgSC1Zm7HpLjON+624O0S5/bgb7pSZH8lkmfJD8olc
         TUZzrspoiyZTAmKxgT+26wsdAF4qvtMrJrk6Oy5hMFZ+2KFfBb+xPadtppIoekqvTkW1
         1cLlHClLCi9F5t2jFo4a60sr+5w5J5nlTozyPD9vGk4vmfp8q35YqvQc62DoRrswc9zA
         8NY93ZOoVuUabfXeGtdta3ZUaIgMqrw4z2GhDDQBK0Kjd3KVwlzY3GgTtKRCxVEmCA2G
         LFQURWaqt0CfaTgAKLfcmaCemq4C6ks5v+J6Fnf2ndojWdrAzbRQu9+jjHYLgLvgIc20
         uVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=WXnjmdIZb8SItePycRIoqj321JtXN7AVWGBtHTjKeOI=;
        b=6qFysHgnpmZjiiJYanwbxjffEf0rAKt8P6dvirqcLOCl9+XPdsxZwJIzmCxI708CR8
         +2663fAyf6WYZPEkGB1uIReqG30uCVFlQ2PLg+uWoS+o0OdqhVnfnzgDxrdSrMO5atoK
         ZUONchDW9fzOpOGQBDB4luvvGwzzo8eiHWWYceEJoyrAN7rP+PTnDBB4WMkVqZr76F38
         9xQzrp7VADqtkfQGWFOPQuhAWHs28l8weOIcyy7Jh9lK6uTmoYztbcHQzc3zAzC6zyM1
         WJ6r5bp+zdeWQ0QJClL8msNmp7mi/fZqFkbRzoAe1q7v/O8O03S6EDZH8bN910lPF4eN
         hx9Q==
X-Gm-Message-State: ACgBeo2gfLFx/jwTkpgS3EQr64QVtMzB5Ym6PbJAQb1zroYvvV6PyGL+
        uxromg3ikdrY62PG8JmAJ2NhW0RiqCfXsDK5tU5FIlXPJDmOC8ChP53ONs0jQr8tJJ31v1TyUwx
        1C5AcqXyqM/iPmsKLcB6wqOwfnfro6ITauEIUmgd9tW7+9vgSvLfvrEe2Q7dMvks=
X-Google-Smtp-Source: AA6agR76kWYppR6kfa4P+bDEZx0kZ2jhPW7byMQzksxO9nCmtRigFEL6Rwc41ifUCULrH+hnkpmkCMinoWT28A==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:90b:10a:b0:200:2849:235f with SMTP id
 p10-20020a17090b010a00b002002849235fmr23407pjz.1.1662678981761; Thu, 08 Sep
 2022 16:16:21 -0700 (PDT)
Date:   Thu,  8 Sep 2022 23:16:14 +0000
In-Reply-To: <cover.1662678623.git.zhuyifei@google.com>
Mime-Version: 1.0
References: <cover.1662678623.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <9b4fc9a27bd52f771b657b4c4090fc8d61f3a6b5.1662678623.git.zhuyifei@google.com>
Subject: [PATCH v3 bpf-next 2/3] selftests/bpf: Deduplicate write_sysctl() to test_progs.c
From:   YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This helper is needed in multiple tests. Instead of copying it over
and over, better to deduplicate this helper to test_progs.c.

test_progs.c is chosen over testing_helpers.c because of this helper's
use of CHECK / ASSERT_*, and the CHECK was modified to use ASSERT_*
so it does not rely on a duration variable.

Suggested-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../bpf/prog_tests/btf_skc_cls_ingress.c      | 20 -------------------
 .../bpf/prog_tests/tcp_hdr_options.c          | 20 -------------------
 tools/testing/selftests/bpf/test_progs.c      | 17 ++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  1 +
 4 files changed, 18 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
index 664ffc0364f4f..7a277035c275b 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
@@ -22,26 +22,6 @@ static __u32 duration;
 
 #define PROG_PIN_FILE "/sys/fs/bpf/btf_skc_cls_ingress"
 
-static int write_sysctl(const char *sysctl, const char *value)
-{
-	int fd, err, len;
-
-	fd = open(sysctl, O_WRONLY);
-	if (CHECK(fd == -1, "open sysctl", "open(%s): %s (%d)\n",
-		  sysctl, strerror(errno), errno))
-		return -1;
-
-	len = strlen(value);
-	err = write(fd, value, len);
-	close(fd);
-	if (CHECK(err != len, "write sysctl",
-		  "write(%s, %s, %d): err:%d %s (%d)\n",
-		  sysctl, value, len, err, strerror(errno), errno))
-		return -1;
-
-	return 0;
-}
-
 static int prepare_netns(void)
 {
 	if (CHECK(unshare(CLONE_NEWNET), "create netns",
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 1fa7720799674..f24436d33cd6f 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -54,26 +54,6 @@ static int create_netns(void)
 	return 0;
 }
 
-static int write_sysctl(const char *sysctl, const char *value)
-{
-	int fd, err, len;
-
-	fd = open(sysctl, O_WRONLY);
-	if (CHECK(fd == -1, "open sysctl", "open(%s): %s (%d)\n",
-		  sysctl, strerror(errno), errno))
-		return -1;
-
-	len = strlen(value);
-	err = write(fd, value, len);
-	close(fd);
-	if (CHECK(err != len, "write sysctl",
-		  "write(%s, %s): err:%d %s (%d)\n",
-		  sysctl, value, err, strerror(errno), errno))
-		return -1;
-
-	return 0;
-}
-
 static void print_hdr_stg(const struct hdr_stg *hdr_stg, const char *prefix)
 {
 	fprintf(stderr, "%s{active:%u, resend_syn:%u, syncookie:%u, fastopen:%u}\n",
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 3561c97701f24..0e9a47f978908 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -943,6 +943,23 @@ int trigger_module_test_write(int write_sz)
 	return 0;
 }
 
+int write_sysctl(const char *sysctl, const char *value)
+{
+	int fd, err, len;
+
+	fd = open(sysctl, O_WRONLY);
+	if (!ASSERT_NEQ(fd, -1, "open sysctl"))
+		return -1;
+
+	len = strlen(value);
+	err = write(fd, value, len);
+	close(fd);
+	if (!ASSERT_EQ(err, len, "write sysctl"))
+		return -1;
+
+	return 0;
+}
+
 #define MAX_BACKTRACE_SZ 128
 void crash_handler(int signum)
 {
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 5fe1365c2bb1e..b090996daee5c 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -384,6 +384,7 @@ int extract_build_id(char *build_id, size_t size);
 int kern_sync_rcu(void);
 int trigger_module_test_read(int read_sz);
 int trigger_module_test_write(int write_sz);
+int write_sysctl(const char *sysctl, const char *value);
 
 #ifdef __x86_64__
 #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
-- 
2.37.2.789.g6183377224-goog

