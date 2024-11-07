Return-Path: <bpf+bounces-44201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E997F9BFD0E
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 04:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C3F283E1D
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 03:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD018D65A;
	Thu,  7 Nov 2024 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNwbDRFZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321D617B402;
	Thu,  7 Nov 2024 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730950932; cv=none; b=i6dT3zngJnF1fglhmuYqNoqfB7UZgRK1xlEXdnJMyiOlJN6M0jyrXo4wyDGNo/Ipqfu6FDpHO/zaWoZJ1D+nkQi5Rs7F8+P/JeufweMUdCGX/gmfkgzNQmDMS2E6Y62MWJ5XVD8gWL+JFWAoi/zHqQtVivwOjU8Vw6X0sBgVoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730950932; c=relaxed/simple;
	bh=bes6VF+/tZ3Doc4aMjHGmU/BKzoZuvdTvK3LAfrpBjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+n58BhTdSO8bQmgQAjx1+4RJ54abxGOYGkjNQH0DCNlV8Q6BNzLJDYG+TGXjKYrLU9tnGim1JWbV3Om41JOmjBUitGSTL3CU2mkMjDsj3eemCV+qXg4acOY+o3+RfBHDCRD66dS6AigBRNECS7jlAOTElinx4SoelsmyMJimbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNwbDRFZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72041ff06a0so377758b3a.2;
        Wed, 06 Nov 2024 19:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730950930; x=1731555730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR9Keek2orpgwuio1inl2tEE62ShnL2BJsF5yEukZTQ=;
        b=nNwbDRFZWl88wHwdaxQ8UkNjUcWbWb3jPjv7SfahMDOicAhhn1EXfOJOT5uOuOUh00
         py/ni2N9VKILOsS4b+/dEiCRe2+tqUvtRW32hv7epd8W1Hhb6yLLqjomtXhO5GEtpm8S
         C+/OSpArVewC+fJXl9NDuNNv2USsMZ80xa3MEUyY+MEyXCYs6+hSw9VLkktIpZhUF/56
         Q79FBK0RXiGDdRydvq84mAVMBGUfmNSpd6fdm1JzTE2tOBazZpDBMd6q+Z+z5Dm2rpM+
         pY4LT9g0pEXfEaa7UaUGvs7vBkxpcWCJuwYt5T8PCG7Kcmy3J4ghRK8ypnx7qf3W9Vs5
         rXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730950930; x=1731555730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR9Keek2orpgwuio1inl2tEE62ShnL2BJsF5yEukZTQ=;
        b=TpoMjoqJPOXwgWmi5U/jmbaaJVAWvxZD8AVDSuxYtz1AI5mR3/nKiBlPpGMjHJJwbO
         6KGbroCi9yKakWgYAYhU6xOPbeh+hPhZzh4N8PX4SY7BEjv9/D/fC4HMKlXFMECgGEa6
         wWoOrFXTkgf/1xbhbGKOnuolDHZ/gzdkNsyb0o0o8MrHP6us1tpGqr5WuWHxEt30xbEF
         NojWqkaiQ7ORKsJcZZQBDw5Su0erQb/gILL8YsOCRgKWX6vQtc9ekVAH/s6QEv6OllII
         JvGcRqTs4nVns59LBloX5sQdbSJlR0kPcAdmgGbk2jApqqypQI0XN2ZLLSHJ1vD69ceA
         2J+Q==
X-Gm-Message-State: AOJu0YyGuQcBbJANfCl++CtO+ScVyRpHE31uUGUBHEJNBe89rEl6Wy6G
	+9BDEnWcAAF3i9xEP2VafrspWZ6OVrRGXk6MJca3j4vvqU8NQ4qCOI3Hug==
X-Google-Smtp-Source: AGHT+IFCulYwJCkNZkjB0cYYUsnXaOillODDtzom56d7jChNuUf4l4p0Xyigx/5xtVoQlAqEtv8i3g==
X-Received: by 2002:a05:6a00:a2a:b0:71d:f64d:ec60 with SMTP id d2e1a72fcca58-720c98a3d45mr29260020b3a.7.1730950930071;
        Wed, 06 Nov 2024 19:42:10 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:baaf:f848:1f89:8135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a2367dsm361350b3a.169.2024.11.06.19.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 19:42:09 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [Patch bpf 2/2] selftests/bpf: Add a BPF selftest for bpf_skb_change_tail()
Date: Wed,  6 Nov 2024 19:41:41 -0800
Message-Id: <20241107034141.250815-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107034141.250815-1-xiyou.wangcong@gmail.com>
References: <20241107034141.250815-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

As requested by Daniel, we need to add a selftest to cover
bpf_skb_change_tail() cases in skb_verdict. Here we test trimming,
growing and error cases, and validate its expected return values.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 51 +++++++++++++++++++
 .../bpf/progs/test_sockmap_change_tail.c      | 40 +++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 82bfb266741c..fe735fced836 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -12,6 +12,7 @@
 #include "test_sockmap_progs_query.skel.h"
 #include "test_sockmap_pass_prog.skel.h"
 #include "test_sockmap_drop_prog.skel.h"
+#include "test_sockmap_change_tail.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
 #include "sockmap_helpers.h"
@@ -562,6 +563,54 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 		test_sockmap_drop_prog__destroy(drop);
 }
 
+static void test_sockmap_skb_verdict_change_tail(void)
+{
+	struct test_sockmap_change_tail *skel;
+	int err, map, verdict;
+	int c1, p1, sent, recvd;
+	int zero = 0;
+	char b[3];
+
+	skel = test_sockmap_change_tail__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	if (!ASSERT_OK(err, "create_pair()"))
+		goto out;
+	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
+		goto out_close;
+	sent = xsend(p1, "Tr", 2, 0);
+	ASSERT_EQ(sent, 2, "xsend(p1)");
+	recvd = recv(c1, b, 2, 0);
+	ASSERT_EQ(recvd, 1, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
+
+	sent = xsend(p1, "G", 1, 0);
+	ASSERT_EQ(sent, 1, "xsend(p1)");
+	recvd = recv(c1, b, 2, 0);
+	ASSERT_EQ(recvd, 2, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
+
+	sent = xsend(p1, "E", 1, 0);
+	ASSERT_EQ(sent, 1, "xsend(p1)");
+	recvd = recv(c1, b, 1, 0);
+	ASSERT_EQ(recvd, 1, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, -EINVAL, "change_tail_ret");
+
+out_close:
+	close(c1);
+	close(p1);
+out:
+	test_sockmap_change_tail__destroy(skel);
+}
+
 static void test_sockmap_skb_verdict_peek_helper(int map)
 {
 	int err, c1, p1, zero = 0, sent, recvd, avail;
@@ -927,6 +976,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_fionread(true);
 	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
 		test_sockmap_skb_verdict_fionread(false);
+	if (test__start_subtest("sockmap skb_verdict change tail"))
+		test_sockmap_skb_verdict_change_tail();
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
 		test_sockmap_skb_verdict_peek();
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek with link"))
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
new file mode 100644
index 000000000000..2796dd8545eb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 ByteDance */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sock_map_rx SEC(".maps");
+
+long change_tail_ret = 1;
+
+SEC("sk_skb")
+int prog_skb_verdict(struct __sk_buff *skb)
+{
+	char *data, *data_end;
+
+	bpf_skb_pull_data(skb, 1);
+	data = (char *)(unsigned long)skb->data;
+	data_end = (char *)(unsigned long)skb->data_end;
+
+	if (data + 1 > data_end)
+		return SK_PASS;
+
+	if (data[0] == 'T') { /* Trim the packet */
+		change_tail_ret = bpf_skb_change_tail(skb, skb->len - 1, 0);
+		return SK_PASS;
+	} else if (data[0] == 'G') { /* Grow the packet */
+		change_tail_ret = bpf_skb_change_tail(skb, skb->len + 1, 0);
+		return SK_PASS;
+	} else if (data[0] == 'E') { /* Error */
+		change_tail_ret = bpf_skb_change_tail(skb, 65535, 0);
+		return SK_PASS;
+	}
+	return SK_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


