Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E96D094C
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 17:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjC3PTs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjC3PTq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 11:19:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD2BD332
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l14so12747133pfc.11
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680189505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2aJUrcOGgofhZJGW/JTKC/kLosPU/GUamDiJfbJh5w=;
        b=Bpo80lqtt3mCWIOh5o7yX+EetAM2THbqoIPsZd4lhMb+xjM9/hiEzpAfgxqqZYzZxw
         M7ZHhXdm5QWgoxw2dSxQGs2cgcAVn5hqgu1Lx/zROVTTXLZvN+5tKzB7ZuZQ6uBdrkwX
         UN6UCqm65oFUqJF8ywD/EBrrDVc5u3yxf74YdAI8S+T6qNT0/E0AabGXllvrelufUPQ4
         EKAFznD5KUrmKXAX9PgEZfblrpcX5mxV/PsbeAB82AYpJTt6geUocuKWW1Ge8zay8Cvb
         xSJUkj3LFiE33twK2J8jn6tAPwSRwO93yY/4iIdfXiSCj1GpT0UREY84FsEGRyRZFnEg
         CPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2aJUrcOGgofhZJGW/JTKC/kLosPU/GUamDiJfbJh5w=;
        b=BUibpvz8IMY8yflgP3JK4PmcjgGlytlTb1eFUOVDNXS84RbMzgPE8HwCTXkcu8/0gg
         +TDZl5XJ8MniG4xuxVLwV/iYsAeewbvDyepzEFDLUC24QOhH3gZu7+7ZlwbMimXffd+k
         P3cvPGz9F1MnDajO4bOPK1qugk7Uu6g0OFmdQCxNB0wI0cF2B6mNKEvtl9dLRsj7FbyP
         u1CXOLjAXiqRigrQreuEWvn3oB402GlBlxIFayXoIeRF9h7W0tD3w+/wcgD8rbrpYU00
         sGiR9Zy9TN00xumfUQoc5fvI3mhfOi87VlQ8vk/ipPLn5jA6Bu14GCpsAP5wf/PRF63C
         dAZA==
X-Gm-Message-State: AAQBX9cxDQjYHjVTvIe3gnQsEJc2T0+a+1A3RVHlKCiCtSBhfsLKguvM
        jKP1bqVTnTmGqvYjusDpm3akVRYMY+mhbLtJIiM=
X-Google-Smtp-Source: AKy350azBLJW0b0FOPcCz60g9VaYa1mk2uJDu5E6QYy8tqFIa1IdMDedvwMUGfqgVQMex5BrakCIMg==
X-Received: by 2002:a62:6505:0:b0:627:deeb:af96 with SMTP id z5-20020a626505000000b00627deebaf96mr6005265pfb.11.1680189505108;
        Thu, 30 Mar 2023 08:18:25 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id f17-20020a63de11000000b004fc1d91e695sm23401177pgg.79.2023.03.30.08.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:18:23 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v5 bpf-next 6/7] selftests/bpf: Add helper to get port using getsockname
Date:   Thu, 30 Mar 2023 15:17:57 +0000
Message-Id: <20230330151758.531170-7-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330151758.531170-1-aditi.ghag@isovalent.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 tools/testing/selftests/bpf/network_helpers.c | 14 ++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 596caa176582..4c1dc7cf7390 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -427,3 +427,17 @@ void close_netns(struct nstoken *token)
 	close(token->orig_netns_fd);
 	free(token);
 }
+
+int get_sock_port6(int sock_fd, __u16 *out_port)
+{
+	struct sockaddr_in6 addr = {};
+	socklen_t addr_len = sizeof(addr);
+	int err;
+
+	err = getsockname(sock_fd, (struct sockaddr *)&addr, &addr_len);
+	if (err < 0)
+		return err;
+	*out_port = addr.sin6_port;
+
+	return err;
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index f882c691b790..2ab3b50de0b7 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -56,6 +56,7 @@ int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
 int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
+int get_sock_port6(int sock_fd, __u16 *out_port);
 
 struct nstoken;
 /**
-- 
2.34.1

