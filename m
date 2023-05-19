Return-Path: <bpf+bounces-981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437AD70A2F4
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 00:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AA7281C49
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 22:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F9110968;
	Fri, 19 May 2023 22:52:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3DA6FB7
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 22:52:14 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD21BE47
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae50da739dso26511605ad.1
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684536730; x=1687128730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZN/K8qzR/Ok4MAMPOdCy9FZws89Kf6N5NS+z8C935+Y=;
        b=iBhffobHHYeayDHjG5PlYJVjClji78WcGewRiQNgCu/tZ4v3tHnADsUZoY4CLcX43V
         EGYSBjJK4bSb4MS1R9GMR3nls67JnsD9A/4bNZvDfs/74lr7wKZQs1XaUI48ZFKr80PG
         zbLGLFQfSxsr64RIRuvFQQPN0cwg6UBF5h+HDCkNb15tVwS00PvNPTQwxedRAmD23521
         5IpZpbxmH5s43LBDWW/CVDgBHqtwscNf+QrMQTqHmFpNPQE1JHNGYm7wZw3X9C21anup
         +CmslfsrY1LS+xOnizYq1QeFGYwwbjqVa6k8r0jtmqeweW3U3adZ2lF9gW7oUpfqOSa6
         wAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536730; x=1687128730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZN/K8qzR/Ok4MAMPOdCy9FZws89Kf6N5NS+z8C935+Y=;
        b=IlWuqMYmOzbm/54ZSYgA6pDv2iKKvcPhMiV1DH65AK7ZL5aYG+ChbfNV1TOaoAm+0p
         QEyfS+tQGy1hQoYkBUtllOLMJ1AZINVKH2x1NpDqI4HcqrMLuewI3iqr+k3c9z+//esJ
         QoM5S7C9JJLOW7dwq8r5LT4Z/6FRnowaWqR6sL+XrYAc1mPIdCdvaMXqu93P89NyHv7E
         nzbVKm0kKCZy84b9mhrs4K2sg9EXRIZVTV6FC7RfZZ95SAhUy+ltzMcP5mGKBiOqqbi5
         znhOCxjD1qr1txH25uGiQ374RXgul/OwrJjZh3KX3KxtMEXq8YSTadi1FaoMB2B2FFeQ
         huJg==
X-Gm-Message-State: AC+VfDx+meWB9x2Bm+kWV3Jr9bYzSEtnIP8GEGJdCROoYV81C0CZlUjK
	p5ckCAlc8P8NcxR9JluGxZihrRPtShqc567VWME=
X-Google-Smtp-Source: ACHHUZ78WgK5cbuwgYoHpXRt5liLQRi19UKHJ5t5m4adm9gYe1WVDtaPJgm+v2rePJ9m/fFQdybHgw==
X-Received: by 2002:a17:902:cec2:b0:1ad:c736:209a with SMTP id d2-20020a170902cec200b001adc736209amr4645724plg.56.1684536729962;
        Fri, 19 May 2023 15:52:09 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001a6ed2d0ef8sm117880pld.273.2023.05.19.15.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:52:09 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com
Subject: [PATCH v9 bpf-next 8/9] selftests/bpf: Add helper to get port using getsockname
Date: Fri, 19 May 2023 22:51:56 +0000
Message-Id: <20230519225157.760788-9-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519225157.760788-1-aditi.ghag@isovalent.com>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
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


