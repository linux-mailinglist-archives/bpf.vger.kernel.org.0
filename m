Return-Path: <bpf+bounces-36514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CD3949B05
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 00:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FCB28255A
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CE716CD3A;
	Tue,  6 Aug 2024 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJO2SmKk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BDE172BAE
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982379; cv=none; b=Q/2ufT/LnFnT6pTtlKFmUOUwIAukvdy4Czg9Kxu3PIBge7FzAi+dOp71NR1+1asJFmdNZE6Vy6AlwYmcEosoFLd//RR4DWYBBjYuBE1WXITEfHJ6Vq8nvK43shcnHiNbdAIEpSWUT/wanZ2T3fPswXKR7mXiPuckmgDVEqgHjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982379; c=relaxed/simple;
	bh=lt3zhKDlu8UvTCkl6aukz24Ib3BOXXhXSbgrEbKi7Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irPtVO5TE78jEmw29clMeaFXOPLqat/SrbwDl6MoFQhloM4tU+QcA2P27u+Z/4S3VeQA10h1EtDjLaxxMFNODSufhCPBM1hcq5cVX0bADLtDpCIQvi7Hw1iT+b+Ldmc2reeGqtFK+6i93sqcp0f4aKMe95ryvVCQVJVAS3y+JDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJO2SmKk; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66acac24443so11402987b3.1
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 15:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722982377; x=1723587177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo7BwQAJ9kpUbJUpSG/pXEG7Wy/cwb5sOEuOUxiOOIQ=;
        b=UJO2SmKkL6mDdPOq2CZuOiTTUnPbJjf0FYCqbHaukAZunyuZ4ZGZihoPLAsOq4Kr+Z
         ZOLXFSmGv0GduBFBM3zhfdILuG2TG7EMTEOMlvGWF/DcQegt5E2Tv4ZQs3EVi95JDYCf
         t+zCPHXw7Ivi0H7NQwkyD+cUzgkPXjuwIMkqzRBjpKVF/C5XPp91GPYIdPpnoeyEFuqe
         LV8pu+nnO+NGza7RURI8SfjhtQlcGctxLQAPovIT4C/8kxWIdFpzXnykBk9IIbU2H6Ig
         OVQpe+d0AKeQ1ZenjGgn3YQmkQpw91WC0cn/Id3hdTKWH/6uRyFceVLz4+VFGK1W2yHV
         rXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982377; x=1723587177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yo7BwQAJ9kpUbJUpSG/pXEG7Wy/cwb5sOEuOUxiOOIQ=;
        b=xGv85x4VpbsHFcPfmlMj6TcdoT5TbFQQAp8lxy7mf4Mf+6VKFr52Q8mg3IAfdkhoxk
         H4t7YLalLPVjWsoexoIrChZFU2U1HuZ4I51f/+MsNoWtVFYGYz5L5efh9/BYIRe0KMHu
         F0/AJWuSztPFyFXicDOdGStVdMp6dL2HqZWKAFW0p/06NiOIaJl3xyXkIyS/fAriHwpP
         yi0mbRJ7YLvqdtMocuxYdS2IdsgxOfdcghOJVlHXSt0qXISk1f5amYNGpoUcOCE0YwMp
         15SXluVELslPei11JwquO6K73LXWwykXh2UB7AHV+TAlbcMaiqBhjSUP7Hs3Uvncnq5p
         537A==
X-Gm-Message-State: AOJu0Yw6ieBfR1qlV/zDcPqNkEOumYdiZM9IQ6vAn//p7pPJke3HWDL9
	wt2k4WgQtee9AiNl1ylyafbGaLB6Tsv0hRwHdrgIwfa/69bbl3GZQfI5QOIm
X-Google-Smtp-Source: AGHT+IFIwhKxvUvxr/m3viBm4Rh1Q1IjUei8eta7i+YBw1Qn9i90MtHq9vSJWN1Rh04lb1Hxh1gygQ==
X-Received: by 2002:a0d:f243:0:b0:65f:e123:b20a with SMTP id 00721157ae682-6895f9ed912mr170370027b3.6.1722982376632;
        Tue, 06 Aug 2024 15:12:56 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a12d138b6sm16990017b3.88.2024.08.06.15.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:12:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 5/6] selftests/bpf: Monitor traffic for sockmap_listen.
Date: Tue,  6 Aug 2024 15:12:42 -0700
Message-Id: <20240806221243.1806879-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806221243.1806879-1-thinker.li@gmail.com>
References: <20240806221243.1806879-1-thinker.li@gmail.com>
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


