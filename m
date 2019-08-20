Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 271DA96BB9
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbfHTVtI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 17:49:08 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:44007 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730959AbfHTVtI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Aug 2019 17:49:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E6B212D8D;
        Tue, 20 Aug 2019 17:49:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 20 Aug 2019 17:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=wwzGUs2eyk7oG
        KkxpIpcL+YllWVCcAIC2rCVN5UFoSE=; b=sJJ+Nd9KAIanYgid7Uunyl0bcNSWD
        79wzJl5yG56rIJhAeUwgetaTfwIhf3d9uUSWgFtoT+LhJOuAfyyqmc0z31QmeZRT
        qKMeJ724G3fiq4dE5Q/kfq3eDeC+ml2KhblOsJJ5jGvqNQC0dY9UCliRWPsw48+B
        qZ2BEyLWr1dM8srMsUt2lRioKlLsbCkXFCyYDnQ7tagHaxZ/IBRGrpYffJf+MMWb
        p6Y4nnmXxaw4rp4K8Y8yXHawf+qVfN5kFWWnTx/z5euRqlon/2oR9kBAvI1E/EFb
        fK37xLWJCQYTtqPNuYHManTi7XOGxPXJwI14Y5/MyFZhH3G4kF3kxrt1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wwzGUs2eyk7oGKkxpIpcL+YllWVCcAIC2rCVN5UFoSE=; b=KvnfySik
        zzfcW6uLPaAku9Ew9As/y9bTbTLJIYn4ROZsdIQtX8kTfpItLKlr8d4RMmj3K4EN
        UGvCRkv8qM18oy5XYtXOgnHol61u10ysbqArNBim/BfmrlZycdj/S6K7i0ttJGoM
        qhx+EK8orMk0KiTUNLKbbAlYttXIb6TSO1VCE1O3bsAArAf02e12QOzF0Uj2UR14
        wxQBbC/cfiRi6HgfIrGDAI1hyRzjm9iXVgt0AyS7G0+7O+oFA7c/mwqQmfPXk5Am
        Vnx6/BG4n92DGrsqOFjpOfoadIqR5/HqnH83TL3jNbyPCX76kU+liZNtogA3E1/1
        H4BCqMzSbTiLVA==
X-ME-Sender: <xms:0mpcXbXmwmNtV0GqIL9BKNutJDZroJsQp7fCyEwqZPVR9kfZGy4bSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegvddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddvnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgvrhfu
    ihiivgepud
X-ME-Proxy: <xmx:0mpcXZ5ZADLYp2_MJQaVuVVmyLAOHmSvZx-gXaIeAvOFL15wofcBmg>
    <xmx:0mpcXYIx9FdjFoZBUpm4Nr5XsUK_bWn54cWtDFGWGSyv0WSWL1KBgA>
    <xmx:0mpcXfLhL9UQmPiORZSV2shBFLWJwxkD1MdFUwt6u8J2VT-XWbZfpw>
    <xmx:0mpcXZ2cjoSXRtaxDko-zFjRZTu7UmEd5IhVDjNCt2bJZ4nZ09CYbQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id D1F7280060;
        Tue, 20 Aug 2019 17:49:04 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 4/4] tracing/probe: Add self test for PERF_EVENT_IOC_QUERY_PROBE
Date:   Tue, 20 Aug 2019 14:48:19 -0700
Message-Id: <20190820214819.16154-5-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820214819.16154-1-dxu@dxuuu.xyz>
References: <20190820214819.16154-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 5ecc267d98b0..414d5f4f7ccd 100644
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
@@ -116,6 +126,63 @@ void test_attach_probe(void)
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
+	if (CHECK(kprobe_query.size != sizeof(kprobe_query), "get_kprobe_ioctl",
+		  "read incorrect size from kprobe_ioctl: %llu\n",
+		  kprobe_query.size))
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
+	if (CHECK(kretprobe_query.size != sizeof(kretprobe_query),
+		  "get_kretprobe_ioctl",
+		  "read incorrect size from kretprobe_ioctl: %llu\n",
+		  kretprobe_query.size))
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
@@ -135,6 +202,54 @@ void test_attach_probe(void)
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
2.21.0

