Return-Path: <bpf+bounces-12343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 824B77CB32F
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 21:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B92B20FA4
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 19:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA4B34CF3;
	Mon, 16 Oct 2023 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW/6/yxg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A429425;
	Mon, 16 Oct 2023 19:08:27 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F20C95;
	Mon, 16 Oct 2023 12:08:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c87a85332bso41777565ad.2;
        Mon, 16 Oct 2023 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697483305; x=1698088105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubjkS5+y1rW721gBAWdylENqvUrLaiGAMBOmuqAVODw=;
        b=bW/6/yxgdqmEgrP1CMMGFByYlfcIoHKJFCYGE4rmk9v7dzdm7ls5LM2Hu0+KzNldWS
         vYigARxUnETFQkO/4QwlPhmEY55SCZviq3w7/Zz/4rQFST/bT6AcrKUnLQu5ZA8IWUaH
         /mVPxPraGZz4Q0Jrl3Th+Pla9/1Qr+x7qXDLK7onHCZIHXzGMz7YuqHbeQtNYJ4IOJ1A
         kSZG8Okt6hAtgXbJMCFMyha0xzH9cll5qVUU66OizLrXAVXBL76IOpFsUFnuF16VYRhH
         dXZOMTqLgth7Eok5eOnvgjHMAn282Yt3WDotnbtefoIOYFhb0pb3fW3haWuk85pduCZ/
         KkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697483305; x=1698088105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubjkS5+y1rW721gBAWdylENqvUrLaiGAMBOmuqAVODw=;
        b=d7DX9L3lrWMv2lxnGJXdU1ahl2RrUz8DLygzsgy2pl27sOznE26Qa/EjIDhLj3xe7m
         Y4fCRvkFMeW/ZlUpxkZJ0h7aY+lTunm9ymgenPIi1tBgioaxQkicSyHrjca04NXpkYP1
         6yFhkrWIJGfvnPfMZf14BeYQFHjpUGHoGJ/rmhQIC4Yc+vL3angrIWi23oQb/Tykslbg
         ipQXCuPEUs3oThozxwC6iasxQGDkYL604x5pVdKtXKHp6VJLgGhXF0sP82yj1r0NIcKv
         VKuXP8ZlRpGSQHk+WyRrI/2M5rQVnICQ0T/ygEFNBajkgK9Nd8VInqxjkKrK827DL4IP
         GH+w==
X-Gm-Message-State: AOJu0YyVbwcO3SbMrCH1AaO+0TvIWl8oUudsgBc7TOSCpUr7Ug8XviqO
	kL5JJPGiAv0zsant6y4uwWDDUcVn8iw=
X-Google-Smtp-Source: AGHT+IHjz05cUxibX1otVAS/9iWsfr+1vBo9AGGa8Iqmi6v4NF+OBtrRSsYD/6y9NA1LGcTuf+wMWw==
X-Received: by 2002:a17:903:1212:b0:1c4:387a:3259 with SMTP id l18-20020a170903121200b001c4387a3259mr235762plh.46.1697483304931;
        Mon, 16 Oct 2023 12:08:24 -0700 (PDT)
Received: from john.lan ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001c9bc811d4dsm8803473pla.295.2023.10.16.12.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 12:08:24 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: yangyingliang@huawei.com,
	jakub@cloudflare.com,
	martin.lau@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH bpf 2/2] bpf: sockmap, add af_unix test with both sockets in map
Date: Mon, 16 Oct 2023 12:08:19 -0700
Message-Id: <20231016190819.81307-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231016190819.81307-1-john.fastabend@gmail.com>
References: <20231016190819.81307-1-john.fastabend@gmail.com>
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

This adds a test where both pairs of a af_unix paired socket are put into
a BPF map. This ensures that when we tear down the af_unix pair we don't
have any issues on sockmap side with ordering and reference counting.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 39 ++++++++++++++++---
 .../selftests/bpf/progs/test_sockmap_listen.c |  7 ++++
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 8df8cbb447f1..90e97907c1c1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1824,8 +1824,10 @@ static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
 
-static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
-					int verd_mapfd, enum redir_mode mode)
+static void unix_inet_redir_to_connected(int family, int type,
+					int sock_mapfd, int nop_mapfd,
+					int verd_mapfd,
+					enum redir_mode mode)
 {
 	const char *log_prefix = redir_mode_str(mode);
 	int c0, c1, p0, p1;
@@ -1849,6 +1851,12 @@ static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 	if (err)
 		goto close;
 
+	if (nop_mapfd >= 0) {
+		err = add_to_sockmap(nop_mapfd, c0, c1);
+		if (err)
+			goto close;
+	}
+
 	n = write(c1, "a", 1);
 	if (n < 0)
 		FAIL_ERRNO("%s: write", log_prefix);
@@ -1883,6 +1891,7 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 					    struct bpf_map *inner_map, int family)
 {
 	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	int nop_map = bpf_map__fd(skel->maps.nop_map);
 	int verdict_map = bpf_map__fd(skel->maps.verdict_map);
 	int sock_map = bpf_map__fd(inner_map);
 	int err;
@@ -1892,14 +1901,32 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 		return;
 
 	skel->bss->test_ingress = false;
-	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
+	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+				     sock_map, -1, verdict_map,
+				     REDIR_EGRESS);
+	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+				     sock_map, -1, verdict_map,
 				     REDIR_EGRESS);
-	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+
+	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+				     sock_map, nop_map, verdict_map,
+				     REDIR_EGRESS);
+	unix_inet_redir_to_connected(family, SOCK_STREAM,
+				     sock_map, nop_map, verdict_map,
 				     REDIR_EGRESS);
 	skel->bss->test_ingress = true;
-	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
+	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+				     sock_map, -1, verdict_map,
+				     REDIR_INGRESS);
+	unix_inet_redir_to_connected(family, SOCK_STREAM,
+				     sock_map, -1, verdict_map,
+				     REDIR_INGRESS);
+
+	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+				     sock_map, nop_map, verdict_map,
 				     REDIR_INGRESS);
-	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+	unix_inet_redir_to_connected(family, SOCK_STREAM,
+				     sock_map, nop_map, verdict_map,
 				     REDIR_INGRESS);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
index 464d35bd57c7..b7250eb9c30c 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
@@ -14,6 +14,13 @@ struct {
 	__type(value, __u64);
 } sock_map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, __u64);
+} nop_map SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKHASH);
 	__uint(max_entries, 2);
-- 
2.33.0


