Return-Path: <bpf+bounces-36816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A066294DA29
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 04:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6E41F21835
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 02:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE8C1386B3;
	Sat, 10 Aug 2024 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY7RjHhI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70671130AF6
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723257346; cv=none; b=Lyi4qTHtR+F8a/kjAPNmuodMv+6ttNpmrO0Z/Gf8Jqr6enFeUHlMdsbXFYuptcyPXQvHls6dDh9RtiIt5vlBjMJUGAq3b3fribL+3xQN59O4WNr45HHSuhftO0O9xlAg9pOvVwh5at9jejFSSwW+7h+0Jjb8NoVN6Ko9zVXXQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723257346; c=relaxed/simple;
	bh=lt3zhKDlu8UvTCkl6aukz24Ib3BOXXhXSbgrEbKi7Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rt3z/+udtSmALXHt8FI5yGXa8xC8Rw6L/KpYO120xd0spbvd1kgrGEYOOAdgS+4Dk9Qn3dujMOS7qnx8B/jJnnJK/TiuA1RYi98joFa4nFf+GYuldT9lHNaSEh+oIHFwyQrnJv0Aoh9GHdGKY9Jt2XhO6LSfHQoHL78nMWv2vSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY7RjHhI; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-64b417e1511so24269857b3.3
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 19:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723257344; x=1723862144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo7BwQAJ9kpUbJUpSG/pXEG7Wy/cwb5sOEuOUxiOOIQ=;
        b=QY7RjHhIeg3ajNyWmxbVbP7HbaS1S903ZCZe7sgQiFV2aAdynLswO6g2JF0AEK6IwL
         8ioNYLQ8pwM7xt7aBV63MShMp21bDHOsbgB9NigLT0TvNhoJI+5ZiklYMTKDL60sijsj
         hC724WtPzHltEdFIDhq0b8phSATF2CAvCEJKaYY6wSajJbhOOCk7t6jN4VStreTpTLqj
         Dodh4cronVE1LvJneEqAey8RsMLGAdv29Z7ZC+7qV6QT7LrOSHJudoe4PvlRlX00cArF
         jrPrl+nIy54y9N1VvJRvgWoK4vvJZBmAPMrMzwwtNeNOn2ENmekbOMnY4Z1OxO6PYYto
         5W4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723257344; x=1723862144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yo7BwQAJ9kpUbJUpSG/pXEG7Wy/cwb5sOEuOUxiOOIQ=;
        b=GMyp/sc2eyI0YnTMSYg/ojQi9Yjnl0NExNbb33N/AGDaZ0YTjWIUa8P84RPJEu7dOP
         EhIccoL7Iz1eElVllXyGjQc4xchnZTXG9kDeTn8PmGmBnL+B8sNIy/VPcmIlJ80AF2y3
         c4NbDEHw0UR4xj/5FWEqm0xRtRQZeL/mMLDNHME6X7UtGiKVFohjQ7kWCNHE07h1xl0d
         jJhKMuwrzPU4U9zp3i+c89I7w43Q0Pvi8KBFSSI5NQqw4O4pfRy8uPQMBuc0onBIYkqF
         RiRtPt7Y/mMpJ+4xXWZAzkaQkTJixN/m8n6+/nIt0t02Yt6NduRGvnSRUCK+7/WaeYOS
         hyvQ==
X-Gm-Message-State: AOJu0Yy35buKSTybFfuib8U2XWviN1b8IAUt19AqnFDYFGTeMc2uDe3F
	jLaaJ1Gmcuk/VJ8JX0TKiZ+yoGHRe0yboDsfjTABH+cWB2DBtJAlDoSnaY6n
X-Google-Smtp-Source: AGHT+IHab3P302fhCuOEGLOWks5IsymobECv4dg7PY8MY9GqhKxpcYt+Skjn0rCO7SsajBDjl9F9oA==
X-Received: by 2002:a05:690c:2d13:b0:667:8a16:b3d6 with SMTP id 00721157ae682-69ec94497e8mr39772107b3.39.1723257344161;
        Fri, 09 Aug 2024 19:35:44 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:e383:f1a1:d5c5:1cf2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b371sm1280147b3.114.2024.08.09.19.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 19:35:43 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me,
	geliang@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 5/6] selftests/bpf: Monitor traffic for sockmap_listen.
Date: Fri,  9 Aug 2024 19:35:33 -0700
Message-Id: <20240810023534.2458227-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810023534.2458227-1-thinker.li@gmail.com>
References: <20240810023534.2458227-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable traffic monitor for each subtest of sockmap_listen.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 9ce0e0e0b7da..2c502259ec6f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1925,6 +1925,7 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 				int family)
 {
 	const char *family_name, *map_name;
+	struct netns_obj *netns;
 	char s[MAX_TEST_NAME];
 
 	family_name = family_str(family);
@@ -1932,8 +1933,15 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
 	if (!test__start_subtest(s))
 		return;
+
+	netns = netns_new("test", true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		return;
+
 	inet_unix_skb_redir_to_connected(skel, map, family);
 	unix_inet_skb_redir_to_connected(skel, map, family);
+
+	netns_free(netns);
 }
 
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
-- 
2.34.1


