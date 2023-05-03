Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A96F6198
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 00:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjECWyL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 18:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjECWyG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 18:54:06 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9942B4C27
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 15:54:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaed87d8bdso34198955ad.3
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683154445; x=1685746445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgEqw/DaWrH7mQUZEkdtE0vOzpKLcnA0EDsa0jU2Swo=;
        b=AhIvQ4z9G+bRRwlR47L9AnU9VZF/v+Wz+t1CjQYCfJhxBw5tK2aSmvLA/50AQa5dpB
         Lg+v+zGJ+DedfUgKdG2xSPiwg7/vfMXvcYVV3vwhrst5aHV2EP9CtmZVt/6hYew7F6rd
         vQL80J5UnU+idft4KJsMV8Gh33RGT28gfYkzsS8oNXBIwso1Y3JZBE4xOWKK2JUY+ozx
         R3OfH0eJiXwIU4m35omDZEB5QPeUlxLGpYYF5XYi+UXuJFqVgwFfG6vMPHCaTpBiC0vV
         Jr+s361SMESRlXzDd1iUJuo3kAHjhAj0r7G/o67v/aSoHf+x4ltiyiSWaLVoab3BWQzh
         Du+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154445; x=1685746445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgEqw/DaWrH7mQUZEkdtE0vOzpKLcnA0EDsa0jU2Swo=;
        b=fKE23MeWhdz8oMedkqUTVp1sMgbqUQOwG/6RSf+5EKYbUBCFLMMaFN3ZYDMZ38PhDS
         Jk6DOmKNuLAkpj/VvtJHhAojvM6nN7GufU03ZGNsxR1Yl3if4jaCL50aBtUppDlbzsDC
         8AOtgI2r5306XnvMh2sb51oGFEgNlL0FUpsLIWmJMn6pj4HOhUnYweYisv6n5OBxzggt
         SVM5SGoEXpGbeAxWLuHbVcmw5xUZsVWOfO0yMoQGfRD5Sydc84p4zg6u4wKVdZq7NVZN
         ShDvzB7GKKnjYsxhHd1OJOPs2YqZezaYQs80F1QE4XkJTgRcBMyx6i1lzuINvS5TnJB8
         LmCg==
X-Gm-Message-State: AC+VfDypbJBCk1GAtK85Cph3EZNGv/a9kqn96JWvluzgVP/y2f0ZaZQK
        6KxOi8oysIfc5mhQPMIpmfaz0t8RWkYgd1adLNA=
X-Google-Smtp-Source: ACHHUZ6rIINg8Oo7+eMava/vo8SNaT9iNGwrOeSj+8q6srpmYsh82U5cRW4CCAdyWlMTczUTBpl5IA==
X-Received: by 2002:a17:902:a40b:b0:1ab:94:1ee4 with SMTP id p11-20020a170902a40b00b001ab00941ee4mr1527712plq.2.1683154444803;
        Wed, 03 May 2023 15:54:04 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709028a8200b001a641e4738asm2200443plo.1.2023.05.03.15.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:54:04 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, aditi.ghag@isovalent.com
Subject: [PATCH v7 bpf-next 07/10] selftests/bpf: Add helper to get port using getsockname
Date:   Wed,  3 May 2023 22:53:48 +0000
Message-Id: <20230503225351.3700208-8-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
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

