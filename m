Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8928E3D5B80
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhGZNkE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 09:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhGZNj7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 09:39:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8E8C061765
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 07:20:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u3so15720955lff.9
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=innoMiax/6j+Ydu2wz7DZ/eLaBFwTp809yu9WTfkGdU=;
        b=oVX1a29LktyslfuTcX+62an+IK8NNMLRT5wMozGIGx8cCt9NN5d+F3YDG3Aaqe9JpP
         ZhCe2UhVPpbT/4ClJJhdLnRKHEIiUFbVgZOTsjY2Q59Rkt5XJ5jtI1ctgbVIrfI14tGk
         vLKIE5R3kdTrMq0dcZmeTyBg2Tpj9GbdzaysS7kvfst+1DU4qglrgjQaenkZ85r2K1LV
         jMayQJEwYuU05RmQUkUkpTbYduWHYOduzlmi9SXZaZigyFljfW14Kc3bSssHLt0B7XFE
         dNvwkXwKzZboYiyx4EUkxZ8dnCanVXkRxlVUr1wUqN9IdnpmrGNp9xcW0Wy0CNay+eqm
         V0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=innoMiax/6j+Ydu2wz7DZ/eLaBFwTp809yu9WTfkGdU=;
        b=WN41j7xSEnv1JycNGyIjeB2hxfFje+JAUAZGRwSqUpxs3jOzLTwkNG8IaM97DZf0Bk
         Zo3+hv/ia8ItcpLXi/cCnOEGYbSVCB1WSFAx2kf79MMnCaubdbsBuKUnwpyoBfpOYZGS
         nw3DjESCn/VZ3d7nb+ehoG6YNShiDXJ4FI4hjLqkHiQvCYbz6+Qsc9JzqUYfBcMkGYJ0
         WxNXsBCPc0U6k0tKpBvRV7opGuwncVu6A0Eo5O9B7p+E42Jf2KrPhOx2BDMpIiRq88J/
         rqXyWu56ki57VGkL13YivJQtvXHvrQ/5NxxHaKbYDnHRhCgL1ejZdN9NrKE2E4JHRIC9
         +KFw==
X-Gm-Message-State: AOAM531cZZQtJjQXehVaMnyKQxG977Nlsoxw6Tmw7LUdrTgFk45h+oHl
        YlRLFkfzlUmM4w1KutSfBg==
X-Google-Smtp-Source: ABdhPJxbRG9Eup7xA2iQ0q5xmBU4mgCmlg6AIIhTw+DyogAOmTqyFE3svZwaKu4fU+q914jcuVFVsQ==
X-Received: by 2002:a05:6512:3ba2:: with SMTP id g34mr13032656lfv.613.1627309222000;
        Mon, 26 Jul 2021 07:20:22 -0700 (PDT)
Received: from localhost.localdomain (82-181-76-45.bb.dnainternet.fi. [82.181.76.45])
        by smtp.gmail.com with ESMTPSA id n24sm14017lfb.54.2021.07.26.07.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:20:21 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net,
        Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf] selftests/bpf: Use ping6 only if available in tc_redirect
Date:   Thu,  8 Jul 2021 02:17:27 +0000
Message-Id: <20210708021727.5538-1-joamaki@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAEf4BzaSN+aN5RV=anaGewGAmqOWJRZpHtSeMfYcJ2HZ98LqLQ@mail.gmail.com>
References: <CAEf4BzaSN+aN5RV=anaGewGAmqOWJRZpHtSeMfYcJ2HZ98LqLQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the tc_redirect test only use ping6 if it's available and
otherwise fall back to using "ping -6".

Signed-off-by: Jussi Maki <joamaki@gmail.com>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 5703c918812b..932e4ee3f97c 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -13,15 +13,16 @@
 #define _GNU_SOURCE
 
 #include <arpa/inet.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
 #include <linux/limits.h>
 #include <linux/sysctl.h>
-#include <linux/if_tun.h>
-#include <linux/if.h>
 #include <sched.h>
 #include <stdbool.h>
 #include <stdio.h>
-#include <sys/stat.h>
 #include <sys/mount.h>
+#include <sys/stat.h>
+#include <unistd.h>
 
 #include "test_progs.h"
 #include "network_helpers.h"
@@ -389,11 +390,21 @@ static void test_tcp(int family, const char *addr, __u16 port)
 		close(client_fd);
 }
 
-static int test_ping(int family, const char *addr)
+static char *ping_command(int family)
 {
-	const char *ping = family == AF_INET6 ? "ping6" : "ping";
+	if (family == AF_INET6) {
+		/* On some systems 'ping' doesn't support IPv6, so use ping6 if it is present. */
+		if (!system("which ping6 >/dev/null 2>&1"))
+			return "ping6";
+		else
+			return "ping -6";
+	}
+	return "ping";
+}
 
-	SYS("ip netns exec " NS_SRC " %s " PING_ARGS " %s > /dev/null", ping, addr);
+static int test_ping(int family, const char *addr)
+{
+	SYS("ip netns exec " NS_SRC " %s " PING_ARGS " %s > /dev/null", ping_command(family), addr);
 	return 0;
 fail:
 	return -1;
-- 
2.17.1

