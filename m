Return-Path: <bpf+bounces-3055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD91738CA7
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 19:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C47E281647
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC0B1B8FF;
	Wed, 21 Jun 2023 17:03:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901F19932
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 17:03:02 +0000 (UTC)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9FA10C
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:03:01 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-25e7fe2fb9bso2875933a91.3
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687366981; x=1689958981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqzQApHhMin8VkBURTnRCTSovI6vRxx1tWmRLUB4Gqs=;
        b=4zVrGLl70cCQsEam/VuH1reik/sXInjP2h75Cd1XqJpcbkxBgocdqnz4m3dhZng1zW
         2wySJLRXIG0f8vhxlS4JP6U803n+QjX3A2vo+n+j5qGh7d6/VEN74JcJ5Ux2RK6Yk0DR
         kTje1E9HcEJuU6nO/V3hXUXG8YbmZCMXZklwkWZ07tFb9DcIf1UcmvFFCCkYE3afS4dz
         dnN49yh9mpXhIl+rO4vWLjpI1Pt+sawYat8G0ybFNkHjGHcb+ddXTgtb8GyDwwbWAP0n
         Iz3t1nVfg+iBPz0mg7ep77YWAJN7JNulqfBrz6x17TdqtP+OlejzNUoBPo4UDy2gXiDk
         H12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366981; x=1689958981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqzQApHhMin8VkBURTnRCTSovI6vRxx1tWmRLUB4Gqs=;
        b=EnnxqBxO+TQ2qgYiKXsYZZQ23b41+yhDSXcUZyC4Z7vfcJLnD21AHpZLfyn/I2SLZz
         P/SohwBM4rxafJFCPkL7gXeykxJ2R2tRDgdTNbuw1dVpfrNKnYodb4ayk529NasK5ZlH
         rDbHwQEeOjM0HwjhKkbUdDs0wKU45U2uFcMb481sISXa9TavfAmudJgrVq0Avn/oihrZ
         Q2PBw2PFzZcJNkxY/kWv8vjcy0/6lKzo2SKgTVfCxb21VDpcoERru3j/de0WDl+tCP4b
         eAbbejwxss4Q4/JIgnVTmM2XxZNqhCyulL7tX8zaAdu196eeeVV4atVRRx5Qm+KJzb9U
         WcAg==
X-Gm-Message-State: AC+VfDzbkRZ9YxtonKRjVNl75ROjxMO5fUBOA6OHQ/n8W4g48CSBfyS7
	0cP/xtSI9wOH421N0QlkVrMFq8DfF9n8k2LRccLvGv2vazNRNVXUgDy21EE4S5eZAfsRxfCWgHb
	Y/NJQfPJ4Q9dOszKQWjVUvH9NTRBqCYAP0xqhjOoVCwFj86NmQg==
X-Google-Smtp-Source: ACHHUZ7weWorroVTGt8F/JdLZRT+7IQ5TKHAqhzsttedPPzlsv8xagQtAuCbgamA1zqw3sRdjYZPsmc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:c28a:b0:255:f691:9289 with SMTP id
 f10-20020a17090ac28a00b00255f6919289mr2234070pjt.9.1687366980806; Wed, 21 Jun
 2023 10:03:00 -0700 (PDT)
Date: Wed, 21 Jun 2023 10:02:41 -0700
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621170244.1283336-9-sdf@google.com>
Subject: [RFC bpf-next v2 08/11] selftests/bpf: Add helper to query current
 netns cookie
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Will be used by the subsequent selftests.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 21 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index a105c0cd008a..34102fce5a88 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -450,3 +450,24 @@ int get_socket_local_port(int sock_fd)
 
 	return -1;
 }
+
+#ifndef SO_NETNS_COOKIE
+#define SO_NETNS_COOKIE 71
+#endif
+
+__u64 get_net_cookie(void)
+{
+	socklen_t optlen;
+	__u64 optval = 0;
+	int fd;
+
+	fd = socket(AF_LOCAL, SOCK_DGRAM, 0);
+	if (fd >= 0) {
+		optlen = sizeof(optval);
+		getsockopt(fd, SOL_SOCKET, SO_NETNS_COOKIE, &optval, &optlen);
+		close(fd);
+	}
+
+	return optval;
+}
+
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 694185644da6..380047161aac 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -57,6 +57,7 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
+__u64 get_net_cookie(void);
 
 struct nstoken;
 /**
-- 
2.41.0.162.gfafddb0af9-goog


