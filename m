Return-Path: <bpf+bounces-6898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1333476F4E0
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 23:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB602823A6
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 21:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2473263CE;
	Thu,  3 Aug 2023 21:53:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB111F16D
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 21:53:39 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE721BF9
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 14:53:35 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d1c988afebfso1684154276.2
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 14:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691099614; x=1691704414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AtXBfM0O9UrCww0tusHMJ9SpFxYaMgFiRYSct6+EVDk=;
        b=jS6hlqtucqAk51WgfiS+f0JgL/ESXuzgej0mCChbHieTiusqRJ2FBFMXkKoVJByDgw
         DZKQd2DmlwTx0P3TkNqy+ZlOBopziiqGXXBvFs3IlGmBd0WVhrKHsT6fA/yQcT+mLsKy
         njCEvNhfo9ya3UJ8pgqndmG90oswK+h+nKSIqNMPCWFlvB/kf0w07qosc4TXwg5IWeIs
         CagnR60IMGdPIZpsHef0Edr30XgyDhMj2JK27Ej8PUENz0YYV9WGht33g7sdiKV7zOez
         bRaQYyp/z4G5E5PIqNZT8D3btJBLMpPPOb66v7bnp2z6B30BTt0p8YNl7pHDkNSC3ftu
         Qx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691099614; x=1691704414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtXBfM0O9UrCww0tusHMJ9SpFxYaMgFiRYSct6+EVDk=;
        b=d4SPif8wkAKB8/dElGUGz2zjHmAxOOMup3fyHf4MpqS8UucFJGBPesMJBV6qnX5534
         oUKSZfTHbXhHP/M2IRKEYWvHhPTQCEjnZSKi56mhBoQwlQzj6NtuKQuCohwPK1RkPEqj
         tWvWWm/X914ynpBks2HPYfl4jDSiHQMafFkk+IzpwSYyPljYyKP8RnXILqKscrffyfPL
         CM6tSWdYVlAdagcosifomEZO8OEo0oBXuhKNuXvnWNfGHarGZCDHeypOXu0XyQtG6OPH
         w9vk/NEP6kZ14H4pJH4W9afq2f3IN5WqMnsNyRe+0xIMQun/JOJsKxdWspBdcKIwRjry
         p7vg==
X-Gm-Message-State: ABy/qLYPCYIXIIgS5SizqAZXhaPhESK/kYMAm8jK31YCXclC8+HlF/MW
	zE2xVN5OdYX88a1Km8IGZhnrhNwbUEs=
X-Google-Smtp-Source: APBJJlGo0qOx57BGzngp5Hwk/VnmeXvEtk6Q60a5L3e3pYBKhrP8blS74mwA+yc41O08FBgGDDmWbA==
X-Received: by 2002:a81:4f4d:0:b0:56d:805:1507 with SMTP id d74-20020a814f4d000000b0056d08051507mr21488939ywb.16.1691099614042;
        Thu, 03 Aug 2023 14:53:34 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c07f:1e98:63f3:8107])
        by smtp.gmail.com with ESMTPSA id k188-20020a816fc5000000b0058461c9524fsm261830ywc.12.2023.08.03.14.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 14:53:33 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	dan.carpenter@linaro.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: fix the incorrect verification of port numbers.
Date: Thu,  3 Aug 2023 14:53:16 -0700
Message-Id: <20230803215316.688220-1-thinker.li@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Check port numbers before calling htons().

According to Dan Carpenter's report, Smatch identified incorrect port
number checks. It is expected that the returned port number is an integer,
with negative numbers indicating errors. However, the value was mistakenly
verified after being translated by htons().

Fixes: 8a8c2231cab2 ("selftests/bpf: fix the incorrect verification of port numbers.")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/cafd6585-d5a2-4096-b94f-7556f5aa7737@moroto.mountain/
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
index 95bab61a1e57..0df95bc88a9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
@@ -110,11 +110,13 @@ static int connect_client_server_v6(int client_fd, int listen_fd)
 		.sin6_family = AF_INET6,
 		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
 	};
+	int port;
 	int err;
 
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


