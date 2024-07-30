Return-Path: <bpf+bounces-35962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE17940226
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 02:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF391C220E4
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 00:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBF04A28;
	Tue, 30 Jul 2024 00:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1La5LRW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831B441D
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299279; cv=none; b=MBWJMVj3WpRagRbW1y4KEBA/e8eW+Xscxc6rQVNh7tEcnV9MazK7FRz8B+oMbqGjxQoIrQWi2Xm0qxzgxkvjO+rkzxw/5LD/x2KBNrpaiH7h6Jxq6k/yB9C7NWAnJ2UpEF9tj6CWgJWelIvEcB8sbiKziQlwoBcLliJWVrymOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299279; c=relaxed/simple;
	bh=Z6/SNAGSLX+CpgEnMdKQeB2ve/C3ELxm74bUFvbXSLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZcZ6bx0f9E1xy9e9NlzN3mfhFPmhLTFxfq9Z6D0yvLL076QwsbZOtNXkWRUm+4lCdtWmMv+V8ZJlD1LqUOdnhLizDElM6NyP/Ty3BS1AAXSDEK0GJ2/0qyqaTPdn0+32c4XrXhSqlMJH9NyVvilEgMTN5yCbExJcIojHMWRdhVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1La5LRW; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-65fe1239f12so19588817b3.0
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 17:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722299277; x=1722904077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGIM65GpqdnQpZOC/A+JSD7trAYFlxTDpB4O8SwUb/0=;
        b=d1La5LRW6n1RQHChX2TnE7wVYFFq+R5SAx5k3TCZG0/byJ/Qjgx7nF1xmnenu9nx8r
         ZnqJBUCbv10NG0EQk51hvar+sg8RG9cuJIwCt6VD0wnOuTI0DBmHbw8vHQyIcgWc5X1i
         xmnq8hLbvLRVD99gocGQ6/KqyuYhG7jOyQ78wN54wu7NTa1/iQWS1SvX61F4a4IzAjQa
         MA33TqILvcvD/+5UWNRcP0AyDOzvO3XXN08dlU4ePTiBvmnWHWKxBJ+nKPtzWvCHCPsF
         HjwSFBQ8YAkdoOlFRJIlZkqcnorMleyBOkjDvnVkqpkLJBzW62SDmkPvMfj8/fPoNk64
         LYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722299277; x=1722904077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGIM65GpqdnQpZOC/A+JSD7trAYFlxTDpB4O8SwUb/0=;
        b=F3ovm03prJ218F0aB1A2mHaywVDMLiG9Frb7DaknfXYmVeG9aFP+YXCV8kLbRwAh0R
         cgGyM1S8EQSUkZk8bJ/98X7Jz8EuppFSTEeOAtUhKouyHYkw499dFE4pP6OcXmb0xunQ
         +0PrWcvqL+UhHEmNt2qa4CMa47lWN4rb1hZBZpUQf5NEcBB41T6MXZbWElJbWTyZqQCz
         2AhzA/gJbqDac7J8F3H6jN2XHkbze6ixrruWneeg2lGBGQF2EGniZCxhoKlOkkQ/tHuv
         pIMbBD/R4rHUOY9kEAa6dkOpOwMVo7cganaCiNqx9dbc04OVKPrgp6CxoJCti3Z4oN1G
         XW7g==
X-Gm-Message-State: AOJu0YxTJgJgEcVj8w2ixQ5OxZMbIkm8UzYjPZvcQwQSUiQf8JJuUAq+
	Em5KFv6wRe7bp8BqVGhXxGjf75++mz+ULRWu8cybT8V8rgnRftQZrU0wENCq
X-Google-Smtp-Source: AGHT+IEqzjuAlwVkpJci9P04Eu6+MniZnGFoV/zAyOSmqLzk9w6YuiRs2fw5EblFncuL/Wfne5fcjQ==
X-Received: by 2002:a0d:e444:0:b0:64a:49a4:3e9 with SMTP id 00721157ae682-67a067278famr81436087b3.19.1722299277309;
        Mon, 29 Jul 2024 17:27:57 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5695:a85f:7b5f:e238])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44c698sm23052177b3.135.2024.07.29.17.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 17:27:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/6] selftests/bpf: Monitor traffic for sockmap_listen.
Date: Mon, 29 Jul 2024 17:27:44 -0700
Message-Id: <20240730002745.1484204-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730002745.1484204-1-thinker.li@gmail.com>
References: <20240730002745.1484204-1-thinker.li@gmail.com>
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
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index e91b59366030..2ca091a30a30 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1893,14 +1893,23 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 {
 	const char *family_name, *map_name;
 	char s[MAX_TEST_NAME];
+	struct netns_obj *netns;
 
 	family_name = family_str(family);
 	map_name = map_type_str(map);
 	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
 	if (!test__start_subtest(s))
 		return;
+
+	netns = netns_new("test", true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		return;
+	system("ip link set lo up");
+
 	inet_unix_skb_redir_to_connected(skel, map, family);
 	unix_inet_skb_redir_to_connected(skel, map, family);
+
+	netns_free(netns);
 }
 
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
-- 
2.34.1


