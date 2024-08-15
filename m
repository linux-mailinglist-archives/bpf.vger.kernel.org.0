Return-Path: <bpf+bounces-37248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D009528FD
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 07:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34D6B2217E
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 05:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3092115E5D3;
	Thu, 15 Aug 2024 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEQF+jHm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E9F15E5BE
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699986; cv=none; b=JnQI+MDS5Np+3wdofhLOdMzBiU4fc4BGi/bpBHBIshiyOctCDew7PEn/dWrbp1HEF/y7ZV/gwyYB7QUVh4tm9DWrf+dpTQnvmPyZr62nakH34lfv1Dkn81wB+/mhFL/1/yLaakE6VNAeOTGTQUFYJdLFOR9ImEKLFP5P3D20NEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699986; c=relaxed/simple;
	bh=+256MtGtXqH3tIZf5SuKQTrEI/ogYftJ/lmFCet/oOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gsm5Vff81ya0HFuecdJeO52JogZfBN2LqjFq+E4fTLbr5qdkrbuLVCKafL1P9ZSnfiIq3UOjcmz45BqxNzfLa23wioWnMtw1lhqTqT6iy0uEYAioT0QBZ9cCp5BfP5Z0qYf3W97hM6tlAMFHyc37El7ySohKC6oJTWuwjBwXUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEQF+jHm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-66108213e88so6365297b3.1
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 22:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723699984; x=1724304784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2pSE3wAmvcAyYky8wxrCnDZ8Is1sqrqf4YZxZ2+LCA=;
        b=aEQF+jHmcjjzjYW7s/MwDL4jYDYvxfy/ju5BYtHx5diZaIvfX5aTszUz4Yd0Ly4kNW
         fsamK+67e36A5RQJobGgIKcrwaE5L3njuidn0zyLiNOy7i1pWfGYGimEHzGmZMzqZJXY
         IPy5sZ467IQbmuOLnGM2qVhzbpovKTjWuggCS4st8tYOWmlGxC5XCWmyYBwOzv+Pzm4X
         YbPGnnmYItoDf1vfdfXH0RaEjVj95n8ADKFarkrllk7DVud5oPDw6ziQtU+BD9J+sORz
         8H2GHXYjvNv4GbhM6RUHujrA/WAnO8/8xUjfco1csYX0ijqIM0hoJRIyDwFwa+zltTPz
         GACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723699984; x=1724304784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2pSE3wAmvcAyYky8wxrCnDZ8Is1sqrqf4YZxZ2+LCA=;
        b=ryDwpf0/gUmU6u0EU9t3sFir30ylgjI+TLRWN0L1JR7D0TEeS5m+L+3H7EydgtFCDg
         p3BPy5XvdjA+p09t593ZtYKwIErFBsQ3QKICsvstAUbWXdiBuySkDQLVh0horAoqm2rV
         w+uGiXxAZLTMiMKzni6i8hv5CnGuiJ9SdxAexQR3wgbohKS4D+wvoSMWU51mPxbVBPsE
         SwZcmqSksEhDj0IpwO2IDHKTr4jkIXjyKenDITO7HUdkKbdZ80oz4keTiDiRFnH50qx+
         jIbwGOpnWiNiekun0LHZ2QVxd87BY9KnG1ccFCA6YQWlRohUWkzz4bB6mmrGKRXp/DHu
         WIAg==
X-Gm-Message-State: AOJu0YyTZGwf0oO3Lr8Iklum9QRuagPocXCsUvn0uFnM5I8l4bjEcDXB
	rJEsIJHJhue4ZWln6uGx40piWyHxNsykME5KqAtMUw7nzdHbNkMzQ2bPVMxm
X-Google-Smtp-Source: AGHT+IF0nHy9jC7MEweMHty2tBPCOFurSsCdU5DHUZlFGEr4KvU2wdHx3sa0rs2/ZS0Js7g41EBsrg==
X-Received: by 2002:a05:690c:4d83:b0:64a:efa6:b3d5 with SMTP id 00721157ae682-6ac9a47849bmr68339767b3.37.1723699984207;
        Wed, 14 Aug 2024 22:33:04 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:11c4:fddc:768f:9072])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9da160c7sm1482307b3.118.2024.08.14.22.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 22:33:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 5/6] selftests/bpf: Monitor traffic for sockmap_listen.
Date: Wed, 14 Aug 2024 22:32:53 -0700
Message-Id: <20240815053254.470944-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815053254.470944-1-thinker.li@gmail.com>
References: <20240815053254.470944-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable traffic monitor for each subtest of sockmap_listen.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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


