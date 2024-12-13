Return-Path: <bpf+bounces-46816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21709F032D
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 04:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D6B188B40C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 03:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700A617AE1C;
	Fri, 13 Dec 2024 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZydRnaf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560211632F6;
	Fri, 13 Dec 2024 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061285; cv=none; b=UYYvB4iuKMcHU85hEUZ3/VPiXqiIP6fuQkyuKlKaKf/pdXUulP+bex1bJzSd+TobLaG/Gplp5qcrOSghMoum8Hkw8fjdQejygXj8aPKBRn2V2s2UAn67ETmcb9jbnOhEJqXJhKBPLz8AgOkdKmxOaJmr6byO2l/11yUufz2m9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061285; c=relaxed/simple;
	bh=Dpos2a5/Dhy1c0VH+cR80YBZrSf1aEoVojOFeM7PWyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ll+QBIULccXMeAr1QEubgYmk3TWqDgjU6cpsiFknnBUZbRsXS3ZuId06pZiV3PyAFP8eqqQJ3oiSSdZfItV07jy4pqGdRtAHjiXsJb6YRYoKWtL8yEbgBDugoa1my53cBeANm6y8fzuxvQYX01sj2a33Xz+IutHmX/m/hf5Vdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZydRnaf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216426b0865so11913905ad.0;
        Thu, 12 Dec 2024 19:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734061282; x=1734666082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BaMGhiKLCKOWmYTuuhKHDlE6qjNVxEfagQdFSpkv8M=;
        b=NZydRnafziiNdulyVjo3c68qNd+v4QgtZpx3Uc5iCRwX9W8kAtuA9e5Q1fQXhIsiQl
         FvgCcH0teaBnajSYPqb6beKqTEjKNqXtVz3LJY95LWHXyymMqWcNSUWZqM6uRYKdflmL
         pa7dkJTUP0zgwVWP44gRMFpjd3Cd9vj1VVvKq3hajgpcJ34evdIAjKxSQR1uZq2uAU44
         xaMSBK+qHlJfjpv72q4sA4fhOcJmXWVlDxWNMdVOG3RjPr2TbVJ7E9TURCj97WWZY7sw
         VewlbyEQKJJJKNen3i26kpF9dJpxHz3FCVXYPQdI5K6jXDkZ8AN5Xqenc5/flDFnFkNL
         BCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734061282; x=1734666082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BaMGhiKLCKOWmYTuuhKHDlE6qjNVxEfagQdFSpkv8M=;
        b=s44t92hzU1x6jTcpuTWwWPd8Wh6xdlN1oEs1nVKeQPRE2MIXbfaA+Kb+SPJvAH1lLB
         YHQG11IfQV4aPCAxG9zDohEEG4pWcReuEpKqatvi6hNLwac24Wmb3Rb5O9Lg3SyeAfSk
         sR4o2Mpyy+eJYauCAqL6i6GbV7htJtByuKoAnvjvDZHQveUKLXa6nhz0uvWR2rLezgWI
         kQ+vujn8nqk2WMXUjTOQk0dCRNX+emtIqihOpJRLlB7hPNL4MEOLJ8v2LDw8MEdit8OA
         lBpTGPXVfAGtn3OFVBJNZpJXyFg1g8+GuqKm4ZIZsdTBXFNai37+Vs/PxWmxmgCCvlbH
         fQgQ==
X-Gm-Message-State: AOJu0YznnxbC9VshzQsDh6Bqsm+HqDtdPKQWqk64cF6JjcTyLRUi7M41
	z8ySq6YAG67PpqtvJdTn76CG2nFAX9+TBFAQhEtcS3TWX4b/ufhWl6cwGg==
X-Gm-Gg: ASbGncuZKAn9U8wzFkXNZi5MQkqYt47t/sJJa5soik1kQ9AAggINLezu3DAvx4ccjxg
	nGyH8XFD2hWPCD14yZmezsoWP3eH3qBIDErclkEKk3FFIOSjNfM9n4BIe+nB5AtvHLqOTu5FR8C
	CNIXUx3/YI03o/u62OB2h0lM1DXcIvuvl6QOJNgfWhV2Pe2ukFfxL0oem/NA3i9gc+oag0xW565
	3NOvhG3lVEz/kMHU3SK2lCAdCBUvrfab1CrWDtTCO4GVV+ufy0UwaR3ZGjMD9WXc7USKowcyazp
	ae3LyhJcsA==
X-Google-Smtp-Source: AGHT+IH2j1rkvsL0u/aXDueELV/K0yxvtLx/OBygCcMUpjzc6oOjMBEnFaTKQ5RxCEXIfgg/CGCQ7A==
X-Received: by 2002:a17:902:ce85:b0:216:7cbf:951f with SMTP id d9443c01a7336-218929c72b5mr15188245ad.21.1734061282231;
        Thu, 12 Dec 2024 19:41:22 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:a642:75a1:c5bb:c287])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163725faf4sm89526435ad.196.2024.12.12.19.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:41:21 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [Patch bpf v3 2/4] selftests/bpf: Add a BPF selftest for bpf_skb_change_tail()
Date: Thu, 12 Dec 2024 19:40:55 -0800
Message-Id: <20241213034057.246437-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
References: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
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
growing and error cases, and validate its expected return values and the
expected sizes of the payload.

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
index 248754296d97..884ad87783d5 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -12,6 +12,7 @@
 #include "test_sockmap_progs_query.skel.h"
 #include "test_sockmap_pass_prog.skel.h"
 #include "test_sockmap_drop_prog.skel.h"
+#include "test_sockmap_change_tail.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
 #include "sockmap_helpers.h"
@@ -643,6 +644,54 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 		test_sockmap_drop_prog__destroy(drop);
 }
 
+static void test_sockmap_skb_verdict_change_tail(void)
+{
+	struct test_sockmap_change_tail *skel;
+	int err, map, verdict;
+	int c1, p1, sent, recvd;
+	int zero = 0;
+	char buf[2];
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
+	recvd = recv(c1, buf, 2, 0);
+	ASSERT_EQ(recvd, 1, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
+
+	sent = xsend(p1, "G", 1, 0);
+	ASSERT_EQ(sent, 1, "xsend(p1)");
+	recvd = recv(c1, buf, 2, 0);
+	ASSERT_EQ(recvd, 2, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
+
+	sent = xsend(p1, "E", 1, 0);
+	ASSERT_EQ(sent, 1, "xsend(p1)");
+	recvd = recv(c1, buf, 1, 0);
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
@@ -1058,6 +1107,8 @@ void test_sockmap_basic(void)
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


