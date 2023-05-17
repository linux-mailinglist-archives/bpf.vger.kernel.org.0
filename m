Return-Path: <bpf+bounces-810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A53707037
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B5E1C20F05
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1226431EF7;
	Wed, 17 May 2023 17:58:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3410966
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:58:01 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A634D10D0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:58:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64cb307d91aso1095233b3a.3
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684346280; x=1686938280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN/K8qzR/Ok4MAMPOdCy9FZws89Kf6N5NS+z8C935+Y=;
        b=ha4n6y6bDxyu6NmIWacOdOQnuf1wrKR2xDnpyy3tJ9gkCNrmWR9dOBSaj4S2MaxbdQ
         Mpsh3C6oQoSXZ4UIDKk3HH2uzHzzdb5ijTYgGNhPYVgwrDjl+PP5Vg7GuWsWsxYdIxF1
         IuIN8kULt+HuNFEYe61YXm+Q2ivL5m2qY0OvI+BZLUYxIJvrhMc9whvAeolG5CBw/1QO
         uKev328NUBzza6S/sUxCrlaIPEws6nSIOPadQ5sHari6SE1CeXDNEc2NB0RhIhSkKjvD
         8FD5EsIXrwLk3r9CaU2p3G/nOfe6B2DqHZ/XhktAIEPkeXG6kXhTy5/eVXF5J6LYZ791
         8aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346280; x=1686938280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZN/K8qzR/Ok4MAMPOdCy9FZws89Kf6N5NS+z8C935+Y=;
        b=J2F3VgXiYI7Chsb5Mgr4D2uKq4+k3jZMuCDQmLEjuZHDm8w25/RTfnY2OV/sBQW/GG
         bRSzWrcDdJJAVBaxZ2PgsdBAPfPbbOP7gn/NwcaYXsooF7tD3LB0IM4NRAF5KOzPTfyy
         KNbJ/9SNy382+1hQGwdJzXEUiP40aKm3kwkefeYqkhUDtuf3e4L1L828ArBYuHHLVVvl
         joX2JUzTOC/AbaOhz1J41kCEqPqthG2xRGIapqii/l0+XXjOfn6dgGwLN+GG5Rm+CVp9
         qBZ+YfAx7G2VeXMTfOoXuz7/NWSZ9YY7F22yVmIdhZYJYQELGaL9vJrfLRkR99NaspvH
         yc8w==
X-Gm-Message-State: AC+VfDyjX26vw8Xt0Djc9ptYTosbLe/6/nIkLnycuoL09SReTOT66zoc
	9qYLHWGUNpamRgH8+PO9JxzlAQ38F+en8UMXjwU=
X-Google-Smtp-Source: ACHHUZ69cRTPoXj1szXbbZ6l9JOu3DWwud8yCaG7CR1UiMHlACe+Qj40+g9qAQHy3moPo5cDBwzsqg==
X-Received: by 2002:a05:6a00:14c9:b0:646:2edb:a23 with SMTP id w9-20020a056a0014c900b006462edb0a23mr800054pfu.1.1684346279927;
        Wed, 17 May 2023 10:57:59 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id c25-20020a62e819000000b0063f172b1c47sm9204638pfi.35.2023.05.17.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:57:59 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com
Subject: [PATCH v8 bpf-next 07/10] selftests/bpf: Add helper to get port using getsockname
Date: Wed, 17 May 2023 17:57:54 +0000
Message-Id: <20230517175754.528242-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The helper will be used to programmatically retrieve
and pass ports in userspace and kernel selftest programs.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 23 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 596caa176582..a105c0cd008a 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -427,3 +427,26 @@ void close_netns(struct nstoken *token)
 	close(token->orig_netns_fd);
 	free(token);
 }
+
+int get_socket_local_port(int sock_fd)
+{
+	struct sockaddr_storage addr;
+	socklen_t addrlen = sizeof(addr);
+	int err;
+
+	err = getsockname(sock_fd, (struct sockaddr *)&addr, &addrlen);
+	if (err < 0)
+		return err;
+
+	if (addr.ss_family == AF_INET) {
+		struct sockaddr_in *sin = (struct sockaddr_in *)&addr;
+
+		return sin->sin_port;
+	} else if (addr.ss_family == AF_INET6) {
+		struct sockaddr_in6 *sin = (struct sockaddr_in6 *)&addr;
+
+		return sin->sin6_port;
+	}
+
+	return -1;
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index f882c691b790..694185644da6 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -56,6 +56,7 @@ int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
 int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
+int get_socket_local_port(int sock_fd);
 
 struct nstoken;
 /**
-- 
2.34.1


