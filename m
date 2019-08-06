Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B48D283DEB
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 01:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfHFXmR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Aug 2019 19:42:17 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:57073 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbfHFXmR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Aug 2019 19:42:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 14AEC4F7;
        Tue,  6 Aug 2019 19:42:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Aug 2019 19:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=UqiLQ2E5DadWg
        5fCtspaqcHF7Doczlap7dnJTwl4TwI=; b=dMeqx+p7tYKilkRT7llHiBV6jE3XO
        ghEvYAlF3N1Z9zA0dUKQdJugIO1n4NrJB+zyliaDec3kWTImjfGtqTBvwhZhF7Ip
        fNY7hWhhYOPtoiZjfqvBScG7asmk6egXXEh47GjNi7hJzhAWrDivt6cAlwA+5OE2
        6L7x9eYMM+IYs04UPsQaGqg//AL2dMaJnEz9MLqKgWXNkYeK+HNo4He36A2nECOP
        uC6JW2gqR7gkXgi6tXWY7zlp73coj1nuJrKRbfZVlfnk4SzsUmhLJetNModq5myO
        oyjjkvQ79raEHbEBRh7dOLjcd5s/o8e6IYcK2pVYAH4ALUQ+4F2j9XGEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=UqiLQ2E5DadWg5fCtspaqcHF7Doczlap7dnJTwl4TwI=; b=xL3DsEwd
        WqlMl/Wj+DdECNPzQYi8eLvW73wLSR/D59acq2uIbBm6qtkoTyJlhbDO4l5ZOv5w
        lRDdYrh/a3KQMBsdMBPSXq5B70+lBqCJNMdcv4ZuwaTsrbeNSnbBqmj8T+tHsFlK
        H+2xoXM/FXlNrpBne5Z7QMZ7yGUd61Gv2a1toFzP8SCMfIX7MOY5F8MlC3nIC6Qm
        etR/dT6RKQ+BIps+uUZtaFXWsFh8DY3CXlLUKJ9ZVLe2tJfsKrE8GwQDk27seCqO
        ev9orXi6o40+X3dYpYntzwelUfZdPSACXMpdUptIYnFD4bqpJWcwqNtu3xfCqbjd
        3C/N9TvStgvYKg==
X-ME-Sender: <xms:VxBKXdLJavEPeO2SOjU_QsthR_M2J9xxmKcLmBhwZoNDcEz0zhdl_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduuddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:VxBKXTzK4maFlZHA-21y_xheajqjz-OffgI5srmxa7dNCHEWo7ddqg>
    <xmx:VxBKXbu5MxkcQBWLODhkwmMengYd-F6GCY1Ln25ea51sXVcOos4YlA>
    <xmx:VxBKXeAST1_YpWHmQHiHuWuULmLuHKxgTaUzXG2yYJ6yWy_xPY44IA>
    <xmx:VxBKXauNLpA286_inoD7aa6kp7mzQUtWpQe3JZscyQUhrdT_5yhXJw>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id 91A8E80060;
        Tue,  6 Aug 2019 19:42:14 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] tracing/kprobe: Add self test for PERF_EVENT_IOC_QUERY_KPROBE
Date:   Tue,  6 Aug 2019 16:42:01 -0700
Message-Id: <20190806234201.6296-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806234201.6296-1-dxu@dxuuu.xyz>
References: <20190806234201.6296-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 tools/include/uapi/linux/perf_event.h         | 23 ++++++++++
 .../selftests/bpf/prog_tests/attach_probe.c   | 43 +++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..4a5e18606baf 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -447,6 +447,28 @@ struct perf_event_query_bpf {
 	__u32	ids[0];
 };
 
+/*
+ * Structure used by below PERF_EVENT_IOC_QUERY_KPROE command
+ * to query information about the kprobe attached to the perf
+ * event.
+ */
+struct perf_event_query_kprobe {
+       /*
+        * Size of structure for forward/backward compatibility
+        */
+       __u32   size;
+       /*
+        * Set by the kernel to indicate number of times this kprobe
+        * was temporarily disabled
+        */
+       __u64   nmissed;
+       /*
+        * Set by the kernel to indicate number of times this kprobe
+        * was hit
+        */
+       __u64   nhit;
+};
+
 /*
  * Ioctls that can be done on a perf event fd:
  */
@@ -462,6 +484,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_QUERY_KPROBE		_IOWR('$', 12, struct perf_event_query_kprobe *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 5ecc267d98b0..5f118e9a1469 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -38,9 +38,12 @@ void test_attach_probe(void)
 	struct bpf_link *kretprobe_link = NULL;
 	struct bpf_link *uprobe_link = NULL;
 	struct bpf_link *uretprobe_link = NULL;
+	int kprobe_fd, kretprobe_fd;
 	int results_map_fd;
 	size_t uprobe_offset;
 	ssize_t base_addr;
+	struct perf_event_query_kprobe kprobe_query;
+	struct perf_event_query_kprobe kretprobe_query;
 
 	base_addr = get_base_addr();
 	if (CHECK(base_addr < 0, "get_base_addr",
@@ -116,6 +119,46 @@ void test_attach_probe(void)
 	/* trigger & validate kprobe && kretprobe */
 	usleep(1);
 
+	kprobe_fd = bpf_link__get_perf_fd(kprobe_link);
+	if (CHECK(kprobe_fd < 0, "kprobe_get_perf_fd",
+	    "failed to get perf fd from kprobe link\n"))
+		goto cleanup;
+
+	kretprobe_fd = bpf_link__get_perf_fd(kretprobe_link);
+	if (CHECK(kprobe_fd < 0, "kprobe_get_perf_fd",
+	    "failed to get perf fd from kprobe link\n"))
+		goto cleanup;
+
+	memset(&kprobe_query, 0, sizeof(kprobe_query));
+	kprobe_query.size = sizeof(kprobe_query);
+	err = ioctl(kprobe_fd, PERF_EVENT_IOC_QUERY_KPROBE, &kprobe_query);
+	if (CHECK(err, "get_kprobe_ioctl",
+		  "failed to issue kprobe query ioctl\n"))
+		goto cleanup;
+	if (CHECK(kprobe_query.nmissed > 0, "get_kprobe_ioctl",
+		  "read incorect nmissed from kprobe_ioctl: %llu\n",
+		  kprobe_query.nmissed))
+		goto cleanup;
+	if (CHECK(kprobe_query.nhit <= 0, "get_kprobe_ioctl",
+		  "read incorect nhit from kprobe_ioctl: %llu\n",
+		  kprobe_query.nhit))
+		goto cleanup;
+
+	memset(&kretprobe_query, 0, sizeof(kretprobe_query));
+	kretprobe_query.size = sizeof(kretprobe_query);
+	err = ioctl(kretprobe_fd, PERF_EVENT_IOC_QUERY_KPROBE, &kretprobe_query);
+	if (CHECK(err, "get_kretprobe_ioctl",
+		  "failed to issue kprobe query ioctl\n"))
+		goto cleanup;
+	if (CHECK(kretprobe_query.nmissed > 0, "get_kretprobe_ioctl",
+		  "read incorect nmissed from kretprobe_ioctl: %llu\n",
+		  kretprobe_query.nmissed))
+		goto cleanup;
+	if (CHECK(kretprobe_query.nhit <= 0, "get_kretprobe_ioctl",
+		  "read incorect nhit from kretprobe_ioctl: %llu\n",
+		  kretprobe_query.nhit))
+		goto cleanup;
+
 	err = bpf_map_lookup_elem(results_map_fd, &kprobe_idx, &res);
 	if (CHECK(err, "get_kprobe_res",
 		  "failed to get kprobe res: %d\n", err))
-- 
2.20.1

