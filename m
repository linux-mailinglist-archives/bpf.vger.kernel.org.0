Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47C9487C37
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 19:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbiAGSbL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 13:31:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348741AbiAGSbJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 13:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641580268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0+QGuDZD6JKYu1gso7X7SNQnKaabaDniZWIHlCYZJk=;
        b=WgUFO3gPIirBAkjaT2TZyidupQuP2y900sQkdA04qX4jA1NpDzaNAVUpV6IZtF/leIHzF8
        5sTWziYZggQ3F2FKT7/F/yfrz4Yc0LgyJPRw3piWgDc9thnVsaS3t7+KgMtERifm1DrV50
        IAs6E0jAgEwEXYKP7eSjil3xJGD00fg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-Z19C04lLPG2k-pMxHffOnQ-1; Fri, 07 Jan 2022 13:31:07 -0500
X-MC-Unique: Z19C04lLPG2k-pMxHffOnQ-1
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso5337431edd.14
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 10:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0+QGuDZD6JKYu1gso7X7SNQnKaabaDniZWIHlCYZJk=;
        b=AooeAnm2ZmI1TbGN+JpG8IPzt23IGbzJUuCwJzPbbQW+SqOi8v8yk5U0kUh5GDzTz6
         wt6uYGeivLLwc5DJ78/2kASTI/pPj30mjGgpMT/5f8QbRszK/P7fhqaIpYx4Tg9HS427
         plvwmb4K6JXpxUUWfT9D1zylaDB8niSyTQFnH3RnZKPpNlQkw7XtiX8sDt+gq0xjOcUr
         oy2PVjXLIQzfxZArgkh/dR8WSv5sHFkcn/zT65KuAV9V5D0E5DrzgNKDxnuotaX3g6NK
         gKPT5M0i/p8qnp5dEutScYYBBzIpS531LvPu7hAVMP6UNA+1dWyWLqt9EDroMpWhmmsA
         Cr4g==
X-Gm-Message-State: AOAM533Eo9kp56kbRq932HBkDC3GPPE8cAPnLnyHFgKvq03bexw1jMwb
        z3RPkKfWYFHDn2g8321Dnbz5ut+wxoBD7R2am5WhE+iqrNec5NtR3n2EStpe10Os+hUekIxGjl1
        k76brrRHfLKDK
X-Received: by 2002:a17:907:2ce5:: with SMTP id hz5mr7385773ejc.153.1641580265650;
        Fri, 07 Jan 2022 10:31:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/hHwHF4XPwRmOaN1izaNdRKskm/x+n7NQfg8PUVUd3iOI9KBc193afMMSKGsNBGVr8r8FLA==
X-Received: by 2002:a17:907:2ce5:: with SMTP id hz5mr7385743ejc.153.1641580265300;
        Fri, 07 Jan 2022 10:31:05 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ky5sm1611267ejc.204.2022.01.07.10.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:31:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 43884181F2C; Fri,  7 Jan 2022 19:31:04 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf 2/2] bpf/selftests: Add check for updating XDP bpf_link with wrong program type
Date:   Fri,  7 Jan 2022 19:30:49 +0100
Message-Id: <20220107183049.311134-2-toke@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107183049.311134-1-toke@redhat.com>
References: <20220107183049.311134-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a check to the xdp_link selftest that the kernel rejects replacing an
XDP program with a different program type on link update. Convert the
selftest to use the preferred ASSERT_* macros while we're at it.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../selftests/bpf/prog_tests/xdp_link.c       | 62 +++++++++----------
 .../selftests/bpf/progs/test_xdp_link.c       |  6 ++
 2 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_link.c b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
index 983ab0b47d30..8660e68383ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
@@ -8,46 +8,47 @@
 
 void serial_test_xdp_link(void)
 {
-	__u32 duration = 0, id1, id2, id0 = 0, prog_fd1, prog_fd2, err;
 	DECLARE_LIBBPF_OPTS(bpf_xdp_set_link_opts, opts, .old_fd = -1);
 	struct test_xdp_link *skel1 = NULL, *skel2 = NULL;
+	__u32 id1, id2, id0 = 0, prog_fd1, prog_fd2;
 	struct bpf_link_info link_info;
 	struct bpf_prog_info prog_info;
 	struct bpf_link *link;
+	int err;
 	__u32 link_info_len = sizeof(link_info);
 	__u32 prog_info_len = sizeof(prog_info);
 
 	skel1 = test_xdp_link__open_and_load();
-	if (CHECK(!skel1, "skel_load", "skeleton open and load failed\n"))
+	if (!ASSERT_OK_PTR(skel1, "skel_load"))
 		goto cleanup;
 	prog_fd1 = bpf_program__fd(skel1->progs.xdp_handler);
 
 	skel2 = test_xdp_link__open_and_load();
-	if (CHECK(!skel2, "skel_load", "skeleton open and load failed\n"))
+	if (!ASSERT_OK_PTR(skel2, "skel_load"))
 		goto cleanup;
 	prog_fd2 = bpf_program__fd(skel2->progs.xdp_handler);
 
 	memset(&prog_info, 0, sizeof(prog_info));
 	err = bpf_obj_get_info_by_fd(prog_fd1, &prog_info, &prog_info_len);
-	if (CHECK(err, "fd_info1", "failed %d\n", -errno))
+	if (!ASSERT_OK(err, "fd_info1"))
 		goto cleanup;
 	id1 = prog_info.id;
 
 	memset(&prog_info, 0, sizeof(prog_info));
 	err = bpf_obj_get_info_by_fd(prog_fd2, &prog_info, &prog_info_len);
-	if (CHECK(err, "fd_info2", "failed %d\n", -errno))
+	if (!ASSERT_OK(err, "fd_info2"))
 		goto cleanup;
 	id2 = prog_info.id;
 
 	/* set initial prog attachment */
 	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, prog_fd1, XDP_FLAGS_REPLACE, &opts);
-	if (CHECK(err, "fd_attach", "initial prog attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "fd_attach"))
 		goto cleanup;
 
 	/* validate prog ID */
 	err = bpf_get_link_xdp_id(IFINDEX_LO, &id0, 0);
-	CHECK(err || id0 != id1, "id1_check",
-	      "loaded prog id %u != id1 %u, err %d", id0, id1, err);
+	if (!ASSERT_OK(err, "id1_check_err") || !ASSERT_EQ(id0, id1, "id1_check_val"))
+		goto cleanup;
 
 	/* BPF link is not allowed to replace prog attachment */
 	link = bpf_program__attach_xdp(skel1->progs.xdp_handler, IFINDEX_LO);
@@ -62,7 +63,7 @@ void serial_test_xdp_link(void)
 	/* detach BPF program */
 	opts.old_fd = prog_fd1;
 	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, -1, XDP_FLAGS_REPLACE, &opts);
-	if (CHECK(err, "prog_detach", "failed %d\n", err))
+	if (!ASSERT_OK(err, "prog_detach"))
 		goto cleanup;
 
 	/* now BPF link should attach successfully */
@@ -73,24 +74,23 @@ void serial_test_xdp_link(void)
 
 	/* validate prog ID */
 	err = bpf_get_link_xdp_id(IFINDEX_LO, &id0, 0);
-	if (CHECK(err || id0 != id1, "id1_check",
-		  "loaded prog id %u != id1 %u, err %d", id0, id1, err))
+	if (!ASSERT_OK(err, "id1_check_err") || !ASSERT_EQ(id0, id1, "id1_check_val"))
 		goto cleanup;
 
 	/* BPF prog attach is not allowed to replace BPF link */
 	opts.old_fd = prog_fd1;
 	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, prog_fd2, XDP_FLAGS_REPLACE, &opts);
-	if (CHECK(!err, "prog_attach_fail", "unexpected success\n"))
+	if (!ASSERT_ERR(err, "prog_attach_fail"))
 		goto cleanup;
 
 	/* Can't force-update when BPF link is active */
 	err = bpf_set_link_xdp_fd(IFINDEX_LO, prog_fd2, 0);
-	if (CHECK(!err, "prog_update_fail", "unexpected success\n"))
+	if (!ASSERT_ERR(err, "prog_update_fail"))
 		goto cleanup;
 
 	/* Can't force-detach when BPF link is active */
 	err = bpf_set_link_xdp_fd(IFINDEX_LO, -1, 0);
-	if (CHECK(!err, "prog_detach_fail", "unexpected success\n"))
+	if (!ASSERT_ERR(err, "prog_detach_fail"))
 		goto cleanup;
 
 	/* BPF link is not allowed to replace another BPF link */
@@ -110,40 +110,40 @@ void serial_test_xdp_link(void)
 	skel2->links.xdp_handler = link;
 
 	err = bpf_get_link_xdp_id(IFINDEX_LO, &id0, 0);
-	if (CHECK(err || id0 != id2, "id2_check",
-		  "loaded prog id %u != id2 %u, err %d", id0, id1, err))
+	if (!ASSERT_OK(err, "id2_check_err") || !ASSERT_EQ(id0, id2, "id2_check_val"))
 		goto cleanup;
 
 	/* updating program under active BPF link works as expected */
 	err = bpf_link__update_program(link, skel1->progs.xdp_handler);
-	if (CHECK(err, "link_upd", "failed: %d\n", err))
+	if (!ASSERT_OK(err, "link_upd"))
 		goto cleanup;
 
 	memset(&link_info, 0, sizeof(link_info));
 	err = bpf_obj_get_info_by_fd(bpf_link__fd(link), &link_info, &link_info_len);
-	if (CHECK(err, "link_info", "failed: %d\n", err))
+	if (!ASSERT_OK(err, "link_info"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(link_info.type, BPF_LINK_TYPE_XDP, "link_type") ||
+	    !ASSERT_EQ(link_info.prog_id, id1, "link_prog_id") ||
+	    !ASSERT_EQ(link_info.xdp.ifindex, IFINDEX_LO, "link_ifindex"))
 		goto cleanup;
 
-	CHECK(link_info.type != BPF_LINK_TYPE_XDP, "link_type",
-	      "got %u != exp %u\n", link_info.type, BPF_LINK_TYPE_XDP);
-	CHECK(link_info.prog_id != id1, "link_prog_id",
-	      "got %u != exp %u\n", link_info.prog_id, id1);
-	CHECK(link_info.xdp.ifindex != IFINDEX_LO, "link_ifindex",
-	      "got %u != exp %u\n", link_info.xdp.ifindex, IFINDEX_LO);
+	/* updating program under active BPF link with different type fails */
+	err = bpf_link__update_program(link, skel1->progs.tc_handler);
+	if (!ASSERT_ERR(err, "link_upd_invalid"))
+		goto cleanup;
 
 	err = bpf_link__detach(link);
-	if (CHECK(err, "link_detach", "failed %d\n", err))
+	if (!ASSERT_OK(err, "link_detach"))
 		goto cleanup;
 
 	memset(&link_info, 0, sizeof(link_info));
 	err = bpf_obj_get_info_by_fd(bpf_link__fd(link), &link_info, &link_info_len);
-	if (CHECK(err, "link_info", "failed: %d\n", err))
+	if (!ASSERT_OK(err, "link_info") ||
+	    !ASSERT_EQ(link_info.prog_id, id1, "link_prog_id") ||
+	    /* ifindex should be zeroed out */
+	    !ASSERT_EQ(link_info.xdp.ifindex, 0, "link_ifindex"))
 		goto cleanup;
-	CHECK(link_info.prog_id != id1, "link_prog_id",
-	      "got %u != exp %u\n", link_info.prog_id, id1);
-	/* ifindex should be zeroed out */
-	CHECK(link_info.xdp.ifindex != 0, "link_ifindex",
-	      "got %u != exp %u\n", link_info.xdp.ifindex, 0);
 
 cleanup:
 	test_xdp_link__destroy(skel1);
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_link.c b/tools/testing/selftests/bpf/progs/test_xdp_link.c
index ee7d6ac0f615..64ff32eaae92 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_link.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_link.c
@@ -10,3 +10,9 @@ int xdp_handler(struct xdp_md *xdp)
 {
 	return 0;
 }
+
+SEC("tc")
+int tc_handler(struct __sk_buff *skb)
+{
+	return 0;
+}
-- 
2.34.1

