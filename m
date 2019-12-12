Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42FA11CA90
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 11:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfLLKXP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 05:23:15 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:37008 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfLLKXP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:15 -0500
Received: by mail-lf1-f48.google.com with SMTP id b15so1280776lfc.4
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 02:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuEMJfIx5u2dEbHhJ8pDJuD6wkHkL73p459ow9l75N8=;
        b=maG3Fgn7nrfT6t2D+QymsScnidzd8qzemIiyu2xJXkMjGMSQoIGWcZhYI27YLJJpq9
         gX8Bs0D60fd/369sFzwx283hGjNV6DW+yrgHhgHEF5weLlEj9pP+NsiV8+aFuFR+eUjb
         bsb1WNw2x8kacz00JVaaWzcdB9jEWgh5wXn4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuEMJfIx5u2dEbHhJ8pDJuD6wkHkL73p459ow9l75N8=;
        b=fSTpF4XG4vHjtphHM9WAtSTgGX0FSYiocbCpwHnQpUxGfhFGtqnCQoaNqQ84qAE8ua
         dyWMMSUZEub/RfoCJEEqji/kUbPhgaDJtE4rh3uPrb6/TmTI0XfW1X8iyeePeLiYdQwv
         wWCl3SVaoGERVKDfwn36mzm0Wa1W/jYjKLyu6V0gKBCsQ/1rY6uZwRG2X2kjp7F8OT1z
         pzaCJIVbp2J9wFcmQ/EkcZMzaMI+xHgU5HyYQOng4bjxJM/HIJIlq7mXSojQPpUtJlKq
         rb8mAfQax06YOLx1wqypN41g6fSXKWA7ulGAEkMYfXX6X3GccvAL9vrKINtn8/1dDanB
         eVIw==
X-Gm-Message-State: APjAAAWEnj4tEu2E4nrjP2wmhDDwIQ9XoSGekWeeULoKv0j/fQi5/SZF
        CMoGMX24uFj0IeTU5HDc1IldMmZ/MhPMUg==
X-Google-Smtp-Source: APXvYqyVPTz6bud8Zp2/DHVAHjxDG54kLD3VkGKsbhSV3MKA+j2wo/X/TkIVJ9DtYgeXBiPocxME3g==
X-Received: by 2002:ac2:4c31:: with SMTP id u17mr5073393lfq.57.1576146192414;
        Thu, 12 Dec 2019 02:23:12 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id v24sm3125149ljc.18.2019.12.12.02.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:23:11 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Martin Lau <kafai@fb.com>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 09/10] selftests/bpf: Move reuseport tests under prog_tests/
Date:   Thu, 12 Dec 2019 11:22:58 +0100
Message-Id: <20191212102259.418536-10-jakub@cloudflare.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212102259.418536-1-jakub@cloudflare.com>
References: <20191212102259.418536-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do a pure move the show the actual work needed to adapt the tests in
subsequent patch at the cost of breaking test_progs build for the moment.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/Makefile                            | 2 +-
 .../{test_select_reuseport.c => prog_tests/select_reuseport.c}  | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/bpf/{test_select_reuseport.c => prog_tests/select_reuseport.c} (100%)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e0fe01d9ec33..90de7d75b5c6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -28,7 +28,7 @@ LDLIBS += -lcap -lelf -lrt -lpthread
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
 	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
 	test_sock test_btf test_sockmap get_cgroup_id_user test_socket_cookie \
-	test_cgroup_storage test_select_reuseport \
+	test_cgroup_storage \
 	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl test_hashmap \
 	test_cgroup_attach test_progs-no_alu32
 
diff --git a/tools/testing/selftests/bpf/test_select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
similarity index 100%
rename from tools/testing/selftests/bpf/test_select_reuseport.c
rename to tools/testing/selftests/bpf/prog_tests/select_reuseport.c
-- 
2.23.0

