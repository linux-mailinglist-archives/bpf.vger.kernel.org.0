Return-Path: <bpf+bounces-7030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2104A77067F
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 18:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E5B1C2190C
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31FB1AA67;
	Fri,  4 Aug 2023 16:59:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4D1802C
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 16:59:01 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1EE3C28
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 09:58:59 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5862a6ae535so26942187b3.0
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691168338; x=1691773138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IoWp1WW9wEJkPHwyxe20Xu1TD7FhGSo2kxV7DEObgWs=;
        b=FUfDNvav62N6S+kQn+goOXCrkUlOYQPq+5DcNBaHDLJtCy4KHQGlFHGaRGtwbDfH/N
         MKykPkGq/ZgpRAy6VHM3mFtoFNfWmkRZeFZ2LQQUHwYOOHKlncyJyO2ksaq3ifKS78TI
         Ok73KUej9P3szBg3XC0WP5ta+qmPekIGljju/5jedBkj7DO2++QZps14rDt5O2z+Ixdk
         Vwx7BrY4X8AeYDMkxWOasL3MSYIZMVfWthioYi88cDOugDg9/c6xY1aInvKwI8wbcekg
         f3VOsWbBKdHi62HbQcrjxauwcrId3DpTIczAWq5DdhyaNrfqZC1jZf5T/lIjEICsu8QU
         nouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691168338; x=1691773138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoWp1WW9wEJkPHwyxe20Xu1TD7FhGSo2kxV7DEObgWs=;
        b=jrWoJMmuUSX+0cjK2hY+k5MgazCmPCPjlFspmhSnJ+eY/F9kazicpoYUkgPm1rQz6q
         eL7JaF2XApMtgTDgTiA/fSTWGToDfEScoW72JngvcuI9Pw/m5Xo+sIxGOO1ALWA9WeZJ
         7zUdmeSvrZ0zgI/YQJuIjqpf+i7fbfQotHvO+gk0peOZFGp0l0ExkyVa0ADkxV1wmZtN
         PErSqQSXQP1Rb2/+e4OelsGx56icjrohvNyG5vIATwBnjZ5/tXCJhO5McrRe/wmIHy3q
         malUPLOgdnRSaOUWygVfZcRym9yMB8H5k8fD4JPBbbSmKgBlVLviplFRVMqyQ/Df1Z75
         zv3A==
X-Gm-Message-State: AOJu0YzA4uCxg3LO38QBkC2MTe8G7jLRp38InnwHvrjw0kZRwgg3CZgV
	bpqsuyBuVC7Ei9hM+IBv4RPAhHoJBvnvuQ==
X-Google-Smtp-Source: AGHT+IFqMK51SigYA+zF5msVjSEYm69EL2qwToKaHn0KXV2s818z/yeb7vBbf4OgK1dB3SwVWTltnA==
X-Received: by 2002:a81:4807:0:b0:577:60ba:440a with SMTP id v7-20020a814807000000b0057760ba440amr2552370ywa.50.1691168338116;
        Fri, 04 Aug 2023 09:58:58 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:174:cd0c:d94f:4c1f])
        by smtp.gmail.com with ESMTPSA id v66-20020a0dd345000000b005837b48d16csm824473ywd.84.2023.08.04.09.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:58:57 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	dan.carpenter@linaro.org,
	yonghong.song@linux.dev
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: fix the incorrect verification of port numbers.
Date: Fri,  4 Aug 2023 09:58:31 -0700
Message-Id: <20230804165831.173627-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Check port numbers before calling htons().

According to Dan Carpenter's report, Smatch identified incorrect port
number checks. It is expected that the returned port number is an integer,
with negative numbers indicating errors. However, the value was mistakenly
verified after being translated by htons().

Major changes from v1:

 - Move the variable 'port' to the same line of 'err'.

Fixes: 539c7e67aa4a ("selftests/bpf: Verify that the cgroup_skb filters receive expected packets.")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/cafd6585-d5a2-4096-b94f-7556f5aa7737@moroto.mountain/
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
index 95bab61a1e57..d686ef19f705 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
@@ -110,11 +110,12 @@ static int connect_client_server_v6(int client_fd, int listen_fd)
 		.sin6_family = AF_INET6,
 		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
 	};
-	int err;
+	int err, port;
 
-	addr.sin6_port = htons(get_sock_port_v6(listen_fd));
-	if (addr.sin6_port < 0)
+	port = get_sock_port_v6(listen_fd);
+	if (port < 0)
 		return -1;
+	addr.sin6_port = htons(port);
 
 	err = connect(client_fd, (struct sockaddr *)&addr, sizeof(addr));
 	if (err < 0) {
-- 
2.34.1


