Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B756E682B
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjDRPcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjDRPcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:05 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D63F9
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:32:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b50a02bffso1975054b3a.2
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681831924; x=1684423924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktFaKMGngA4cL2xs6PyudZLjddv2AgUi9/a08l00+R4=;
        b=MbSNSub8sfznwsNLTMmkP/VVIzhIHIAnpH+S/C/S5Ita2MC4mk2pL6b356XX05xTKW
         15mF1P0wVuX9LoKm5KFFtNO3k52f8ZuiTV91Utp2YfzqpnchP+o2EfsoW0WDMdQMb1ty
         XfS0acI32c5gCUnMFq96vDxAo5rCvihNGwDqOHEzfJxCIdB7LyaQtBc+xI1Z1J95NkPa
         mXQv1Q9sy93ZQ4cmj6eP4CbQ4Sl4hTOC1UWtF/nB9L4ynD5I+H7c/ysXqYBi0jDAMt8i
         aTWB3r+cOJVD1e8PywQhs4UWAevD8L1JJHceBcyQeyJoN0kPIvSQ92Rjiigfxvxom6Fu
         uHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831924; x=1684423924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktFaKMGngA4cL2xs6PyudZLjddv2AgUi9/a08l00+R4=;
        b=OUUPjYTv+XH3sjRLxd5/CeqQnmMzDAzAx2F4fDkVTvFqxCp7p0oA3/sjg2+uMJrCDo
         kqDc/p9gX0qXQr+WJwd9HdUjaZW66xLqiATDOpfGhoaKfj9ZGGwRHmyRJtlw6ZI2kAmj
         rD2wyUUOIC7IaHSQpUQSpQz2dIBMtW4dXoABRIWBQDj9mtAf4BSAU+Jzca5zS+S/IGHi
         pbHuH3ng4CHblqdNAFBDoTf8Yl5agb4MSYafTineOyiVhmEtJJBn1NERHoHZuGVdMjPr
         i8X24DH4G2K2i8t8re4GCbmKR00cdEZ0KIvFHn/oHo51ewMeCFFhZkka4WJIiVPRZFHo
         BhKA==
X-Gm-Message-State: AAQBX9dHhSH72O4fyXspahJ2MXrjuVLZfNJkPHbHWS8LcfP159q8kJUA
        WWCl8jKfiV55k1PmcAKsUB5MhJTV/kwdarobAeU=
X-Google-Smtp-Source: AKy350bzrP0RkVMtRPcfR57gITKw4L2XfU/Is17BArTQMIBiLyDVYayvOnVWgJZ4e+CyDWBUVV7aKQ==
X-Received: by 2002:a17:902:ec90:b0:19d:1bc1:ce22 with SMTP id x16-20020a170902ec9000b0019d1bc1ce22mr2928834plg.5.1681831923899;
        Tue, 18 Apr 2023 08:32:03 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id ba4-20020a170902720400b001a647709864sm9769630plb.155.2023.04.18.08.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:32:03 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH 6/7] selftests/bpf: Add helper to get port using getsockname
Date:   Tue, 18 Apr 2023 15:31:47 +0000
Message-Id: <20230418153148.2231644-7-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The helper will be used to programmatically retrieve,
and pass ports in userspace and kernel selftest programs.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 28 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 596caa176582..7217cac762f0 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -427,3 +427,31 @@ void close_netns(struct nstoken *token)
 	close(token->orig_netns_fd);
 	free(token);
 }
+
+int get_socket_local_port(int family, int sock_fd, __u16 *out_port)
+{
+	socklen_t addr_len;
+	int err;
+
+	if (family == AF_INET) {
+		struct sockaddr_in addr = {};
+
+		addr_len = sizeof(addr);
+		err = getsockname(sock_fd, (struct sockaddr *)&addr, &addr_len);
+		if (err < 0)
+			return err;
+		*out_port = addr.sin_port;
+		return 0;
+	} else if (family == AF_INET6) {
+		struct sockaddr_in6 addr = {};
+
+		addr_len = sizeof(addr);
+		err = getsockname(sock_fd, (struct sockaddr *)&addr, &addr_len);
+		if (err < 0)
+			return err;
+		*out_port = addr.sin6_port;
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index f882c691b790..ca4a147b58b8 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -56,6 +56,7 @@ int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
 int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
+int get_socket_local_port(int family, int sock_fd, __u16 *out_port);
 
 struct nstoken;
 /**
-- 
2.34.1

