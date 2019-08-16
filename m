Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3872A90AFD
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2019 00:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfHPWcY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Aug 2019 18:32:24 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60457 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727912AbfHPWcX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Aug 2019 18:32:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 84455205D;
        Fri, 16 Aug 2019 18:32:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 16 Aug 2019 18:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=yesvY/W0FWL4U
        zYMEQ08IeYM3+h3idTX3RnYsVHvMY0=; b=KEJzdryqdsreY/zOG+9TDeMhXebTA
        dSu6Ie9PB6la/pHE+elY2HEHANsahAmqvO5b9UzZvsee9kzoOT/JrVR7nXexSrvU
        5kcGaYtdfjBlGdSBU73LP63oCBcJZL7sGlG00zaPWAmF2njS1vW0B5a5XSf59AHc
        KYe4W//16dJCxHOu7BKX3veneLd2+FA57tUDHwn9sXHlLR++wwjCND8aBhJD2vxB
        sjsOdoWBuSCrQQESVL9ht3iHdUB8yi3LHzn/A7GS9JeUlkmXo5bknNJw7SpXuC90
        IlavQ+D0tWatG5cLKWXiFYTV/Uj3tDn3tYXyjcy5d2STyfLsHfkJf8/kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=yesvY/W0FWL4UzYMEQ08IeYM3+h3idTX3RnYsVHvMY0=; b=qHDoRGmQ
        sY9XUMpvH2HeJictVWrtMlX+uhCyG2iVK9+q9Z4CIaJTXqg1KJsSAsacisd9LJXv
        Ph/wHjahDNSfJeUsL6nuWhRachX2NpMEq6SLPZzQUpMyXeiY6VLlg1DvNAf8LZhk
        X6611uueDr1R//hexekAPxC3i9YxfRYqlzX5mZlcc902szsTlnQUui5FuK1RpZ88
        Tp2mFmoM3YqUjwyBA2I2kDp4PIdnZxODLVLaNsxfV95xDsYyywvzrxnKyR+Z8Tdq
        YDrH05kJahHYfALxLekfBoNS0wFYhb+B8GON6aeyWsvHvWvU2CmlAvruTyH2DT5O
        hj63aECBPgNMhw==
X-ME-Sender: <xms:9i5XXaVGvii_NCbSgn_dFi2q4uAxcawzkXil_QRk3OfEsj0dWV69lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudefgedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgv
    rhfuihiivgepfe
X-ME-Proxy: <xmx:9i5XXeWUal1dC49xeNw39TRyvRPyR120T6Bw2hywfJIC_FKQUOqdng>
    <xmx:9i5XXTaTVrgtERJ8QqCS3L8qf14HHxch5La1yWyAI9vC67qB7frdOg>
    <xmx:9i5XXZXsu9A9zcDrSXz6tmJVKvvlP-kBsz6mhrPF_WTxgD301cb01Q>
    <xmx:9i5XXXbvU2Xt3gnVMFvtZ117PLFyjJyQ6X8ezUopYpGxrKYJDGFYMw>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id 973B48005B;
        Fri, 16 Aug 2019 18:32:20 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 4/4] tracing/probe: Add self test for PERF_EVENT_IOC_QUERY_PROBE
Date:   Fri, 16 Aug 2019 15:31:49 -0700
Message-Id: <20190816223149.5714-5-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816223149.5714-1-dxu@dxuuu.xyz>
References: <20190816223149.5714-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 5ecc267d98b0..c14db7557881 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -27,17 +27,27 @@ void test_attach_probe(void)
 	const char *kretprobe_name = "kretprobe/sys_nanosleep";
 	const char *uprobe_name = "uprobe/trigger_func";
 	const char *uretprobe_name = "uretprobe/trigger_func";
+	struct perf_event_query_probe kprobe_query = {};
+	struct perf_event_query_probe kretprobe_query = {};
+	struct perf_event_query_probe uprobe_query = {};
+	struct perf_event_query_probe uretprobe_query = {};
 	const int kprobe_idx = 0, kretprobe_idx = 1;
 	const int uprobe_idx = 2, uretprobe_idx = 3;
 	const char *file = "./test_attach_probe.o";
 	struct bpf_program *kprobe_prog, *kretprobe_prog;
 	struct bpf_program *uprobe_prog, *uretprobe_prog;
 	struct bpf_object *obj;
+	const struct bpf_link_fd *kprobe_fd_link;
+	const struct bpf_link_fd *kretprobe_fd_link;
+	const struct bpf_link_fd *uprobe_fd_link;
+	const struct bpf_link_fd *uretprobe_fd_link;
 	int err, prog_fd, duration = 0, res;
 	struct bpf_link *kprobe_link = NULL;
 	struct bpf_link *kretprobe_link = NULL;
 	struct bpf_link *uprobe_link = NULL;
 	struct bpf_link *uretprobe_link = NULL;
+	int kprobe_fd, kretprobe_fd;
+	int uprobe_fd, uretprobe_fd;
 	int results_map_fd;
 	size_t uprobe_offset;
 	ssize_t base_addr;
@@ -116,6 +126,54 @@ void test_attach_probe(void)
 	/* trigger & validate kprobe && kretprobe */
 	usleep(1);
 
+	kprobe_fd_link = bpf_link__as_fd(kprobe_link);
+	if (CHECK(!kprobe_fd_link, "kprobe_link_as_fd",
+		  "failed to cast link to fd link\n"))
+		goto cleanup;
+
+	kprobe_fd = bpf_link_fd__fd(kprobe_fd_link);
+	if (CHECK(kprobe_fd < 0, "kprobe_get_perf_fd",
+	    "failed to get perf fd from kprobe link\n"))
+		goto cleanup;
+
+	kretprobe_fd_link = bpf_link__as_fd(kretprobe_link);
+	if (CHECK(!kretprobe_fd_link, "kretprobe_link_as_fd",
+		  "failed to cast link to fd link\n"))
+		goto cleanup;
+
+	kretprobe_fd = bpf_link_fd__fd(kretprobe_fd_link);
+	if (CHECK(kretprobe_fd < 0, "kretprobe_get_perf_fd",
+	    "failed to get perf fd from kretprobe link\n"))
+		goto cleanup;
+
+	kprobe_query.size = sizeof(kprobe_query);
+	err = ioctl(kprobe_fd, PERF_EVENT_IOC_QUERY_PROBE, &kprobe_query);
+	if (CHECK(err, "get_kprobe_ioctl",
+		  "failed to issue kprobe query ioctl\n"))
+		goto cleanup;
+	if (CHECK(kprobe_query.nmissed > 0, "get_kprobe_ioctl",
+		  "read incorrect nmissed from kprobe_ioctl: %llu\n",
+		  kprobe_query.nmissed))
+		goto cleanup;
+	if (CHECK(kprobe_query.nhit == 0, "get_kprobe_ioctl",
+		  "read incorrect nhit from kprobe_ioctl: %llu\n",
+		  kprobe_query.nhit))
+		goto cleanup;
+
+	kretprobe_query.size = sizeof(kretprobe_query);
+	err = ioctl(kretprobe_fd, PERF_EVENT_IOC_QUERY_PROBE, &kretprobe_query);
+	if (CHECK(err, "get_kretprobe_ioctl",
+		  "failed to issue kretprobe query ioctl\n"))
+		goto cleanup;
+	if (CHECK(kretprobe_query.nmissed > 0, "get_kretprobe_ioctl",
+		  "read incorrect nmissed from kretprobe_ioctl: %llu\n",
+		  kretprobe_query.nmissed))
+		goto cleanup;
+	if (CHECK(kretprobe_query.nhit <= 0, "get_kretprobe_ioctl",
+		  "read incorrect nhit from kretprobe_ioctl: %llu\n",
+		  kretprobe_query.nhit))
+		goto cleanup;
+
 	err = bpf_map_lookup_elem(results_map_fd, &kprobe_idx, &res);
 	if (CHECK(err, "get_kprobe_res",
 		  "failed to get kprobe res: %d\n", err))
@@ -135,6 +193,54 @@ void test_attach_probe(void)
 	/* trigger & validate uprobe & uretprobe */
 	get_base_addr();
 
+	uprobe_fd_link = bpf_link__as_fd(uprobe_link);
+	if (CHECK(!uprobe_fd_link, "uprobe_link_as_fd",
+		  "failed to cast link to fd link\n"))
+		goto cleanup;
+
+	uprobe_fd = bpf_link_fd__fd(uprobe_fd_link);
+	if (CHECK(uprobe_fd < 0, "uprobe_get_perf_fd",
+	    "failed to get perf fd from uprobe link\n"))
+		goto cleanup;
+
+	uretprobe_fd_link = bpf_link__as_fd(uretprobe_link);
+	if (CHECK(!uretprobe_fd_link, "uretprobe_link_as_fd",
+		  "failed to cast link to fd link\n"))
+		goto cleanup;
+
+	uretprobe_fd = bpf_link_fd__fd(uretprobe_fd_link);
+	if (CHECK(uretprobe_fd < 0, "uretprobe_get_perf_fd",
+	    "failed to get perf fd from uretprobe link\n"))
+		goto cleanup;
+
+	uprobe_query.size = sizeof(uprobe_query);
+	err = ioctl(uprobe_fd, PERF_EVENT_IOC_QUERY_PROBE, &uprobe_query);
+	if (CHECK(err, "get_uprobe_ioctl",
+		  "failed to issue uprobe query ioctl\n"))
+		goto cleanup;
+	if (CHECK(uprobe_query.nmissed > 0, "get_uprobe_ioctl",
+		  "read incorrect nmissed from uprobe_ioctl: %llu\n",
+		  uprobe_query.nmissed))
+		goto cleanup;
+	if (CHECK(uprobe_query.nhit == 0, "get_uprobe_ioctl",
+		  "read incorrect nhit from uprobe_ioctl: %llu\n",
+		  uprobe_query.nhit))
+		goto cleanup;
+
+	uretprobe_query.size = sizeof(uretprobe_query);
+	err = ioctl(uretprobe_fd, PERF_EVENT_IOC_QUERY_PROBE, &uretprobe_query);
+	if (CHECK(err, "get_uretprobe_ioctl",
+		  "failed to issue uretprobe query ioctl\n"))
+		goto cleanup;
+	if (CHECK(uretprobe_query.nmissed > 0, "get_uretprobe_ioctl",
+		  "read incorrect nmissed from uretprobe_ioctl: %llu\n",
+		  uretprobe_query.nmissed))
+		goto cleanup;
+	if (CHECK(uretprobe_query.nhit <= 0, "get_uretprobe_ioctl",
+		  "read incorrect nhit from uretprobe_ioctl: %llu\n",
+		  uretprobe_query.nhit))
+		goto cleanup;
+
 	err = bpf_map_lookup_elem(results_map_fd, &uprobe_idx, &res);
 	if (CHECK(err, "get_uprobe_res",
 		  "failed to get uprobe res: %d\n", err))
-- 
2.20.1

