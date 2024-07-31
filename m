Return-Path: <bpf+bounces-36166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8AD943679
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF62B20F47
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 19:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB23308A;
	Wed, 31 Jul 2024 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy5Q0A2q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A214BF8F
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454312; cv=none; b=FraJfXSr1mC1u5IP9TfFFMAajpnHViXztVnrd2yHNGbxm3fA/wIH3t38McdIvCf4FT8D+nmYa111Z+voMh2e8hE69u4LqqWgoWmsBXaRuVXnvVboEV0RjYEclvm5jtz1Fckt6R+Arc1MXhfPa4Xx+XbxORo/LzxRiRcVaJqufvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454312; c=relaxed/simple;
	bh=/ul/C6ZjsigLS8FDr3ZtbGxjpousw2Kq241S1bLx9/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrvR1E+CWTKJ7krN0C7hl3q7rfc9OP/WMP4oZflT2cFTUyZbglYUdcVli8G8rmJ9WNUbrYXm5bQD574EZKt60GhFomqErnbV/e5RNJqTAnDPIN2DK1V3P55n8VbocNnyvA2wpIW0jU8C8iU6ROq58CF8Rl4vJCuulgjyOjquqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy5Q0A2q; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-65fdfd7b3deso47676607b3.0
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722454309; x=1723059109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGbkONIFNbiyylz2K3bMfOprQ113JXpZbDtfBtb1e6Y=;
        b=Hy5Q0A2qEYXkzHRONVLlID/wKEpl6/XnR2A+Qq51PQ5h8CI8OhUHvG2cFmlPnBwtGN
         y87Q9GvBg5HpegrP6gUepJ8SGBHcYvbwwzI+6xy1c59Aj5WtL5Qn066bevKgyM/Qvdgo
         m8d5XoOl6ZWPkl+W+5xucQzE3yyu2rtr5U/2IC4vrS7h4Nop1huc6H7mSiw8teJXkKdX
         daK/mFeIUH4vijZ96BzaK+a6YOkutFYhjBLLFM/Fo2Gwk3HrLQiQESiacvtl1UlZ2fyK
         T5lcgpm9YCmgi6YAqFJPk7t7c5V1eaz1qm2Vfmv8k3EKYucp8x10r2ukm1zXpjeiJcQs
         J4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722454309; x=1723059109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGbkONIFNbiyylz2K3bMfOprQ113JXpZbDtfBtb1e6Y=;
        b=ppL53o4SgiDt+/E/hACddIxvRN7eELqmClSirjta0CQV6yGR843U56VhUkQzBGTnHz
         eTsl/rcY0LzoF0dOHdf1E6psaDSozRpiVXAKXQha9gsOTpNdAzVYV16pfDWIKLptPrwU
         Px9PHwN3Ib6rvObGNGMe1os3gAY5xBwZcxyz/L3sZrz9Yg54XLYDipnSgbXGbr4igNLo
         yGhHW7BcsXRK37BN6u0xqbKnB/s65LrlnK2+xJMMQkLU3tGc1P96HgO0qMW053Ciz8M1
         JMx8TYF/2REj30KFUZdYz447jyvbMF51m3bmuKkdvHFfPSUrunNzeh6VjAjA7GqMLBqA
         FZdQ==
X-Gm-Message-State: AOJu0YyoauXviXrj00Dhc+lI43kO2BKXjXj8MRX9M/0rQTlPmgjS2yG8
	S2nernpOkUR2MW+ernD4t4EWBNeCZN6/3j9tJpaP1XsZ+qFbsMZDOBUZVHX/
X-Google-Smtp-Source: AGHT+IFk4Sxj/LWtay3zt3yU3STtsLMHvVoTeEa7ZvPrhLMmThQROKmXgc4Gu6P4bPj8DBTAE+IrqA==
X-Received: by 2002:a81:9e50:0:b0:63c:aa2:829d with SMTP id 00721157ae682-6874e68956cmr1490717b3.44.1722454309530;
        Wed, 31 Jul 2024 12:31:49 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c6db:9dfe:1d13:3b2e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024ab1sm30891597b3.91.2024.07.31.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:31:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 5/6] selftests/bpf: Monitor traffic for sockmap_listen.
Date: Wed, 31 Jul 2024 12:31:39 -0700
Message-Id: <20240731193140.758210-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731193140.758210-1-thinker.li@gmail.com>
References: <20240731193140.758210-1-thinker.li@gmail.com>
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
index 9ce0e0e0b7da..2030472fb8e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1926,14 +1926,23 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
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


