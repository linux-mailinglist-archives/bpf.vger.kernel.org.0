Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B711120E19A
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 23:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbgF2U5u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 16:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbgF2TNG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E71C008645
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so1958128wmc.1
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YW2cEsPoVOANORC8b/EG6UO/ChXsjB8EetXmH7OMF1M=;
        b=JcFgNg0sycST8PeN/Ca68zgTFUh+34pry02M4AXkF6JwEzpxpZpXIwUzC8Tt7cjJU4
         C70t3H+bcpRoW/3Pdh5BELZ1NTg7BEZ8ARksDrpbw15l6V6moFJ1ngJfLVAHZ89mE7PM
         3iMJlTiihQUXI3AIfpnT3S3PYrFcRgDzg98YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YW2cEsPoVOANORC8b/EG6UO/ChXsjB8EetXmH7OMF1M=;
        b=FsGWPNIEpzdEsJJ0gglTajI5xXTO9wpwEWNuUzmDFOHmluazTMsY6PV0fTxl/iet11
         QJhydjlisBQVkq0vie1nIB5E9x8ZzakdqY11eFa1gEfXhZeE8KWZnmzHscKZq20ZpvS8
         TS/qbsgWllINJRh7r6ItaNUISv1IUFfiDiQZwOJZJW7JPZeYjFwoRwjUVYy5t8ps6eHQ
         ReNYcZK3FXDIx+W0C9ISZGecDNRMwbubVrJr2L/Dzn5mGXeti2Ac5g16SMOjkxSLXdgK
         QDfpwNuXqlXANM2X+AQZ0vXDfjQIV0yKs7e32nGInPfbRyfSRZFX70jS3/wx0Jp98kJr
         7GGQ==
X-Gm-Message-State: AOAM5302BDr1S7DjChAJSLPjSI6OKHT27gkiLZN5WD0bvNQ982FtnyWA
        5yUf7rpjAQ8n8qZc4wyZd7ra3g==
X-Google-Smtp-Source: ABdhPJyCMTTI5fepeVzQW/4K8YIvYXMEERDWihv0e+7RbHjTB4L35LYo47ifNzqXI18r4+xZL/pjvg==
X-Received: by 2002:a1c:8094:: with SMTP id b142mr13990136wmd.122.1593424789741;
        Mon, 29 Jun 2020 02:59:49 -0700 (PDT)
Received: from antares.lan (d.b.7.8.9.b.a.6.9.b.2.7.e.d.5.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:55de:72b9:6ab9:87bd])
        by smtp.gmail.com with ESMTPSA id y7sm42565369wrt.11.2020.06.29.02.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 02:59:49 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, sdf@google.com,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf v2 5/6] selftests: bpf: pass program and target_fd in flow_dissector_reattach
Date:   Mon, 29 Jun 2020 10:56:29 +0100
Message-Id: <20200629095630.7933-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629095630.7933-1-lmb@cloudflare.com>
References: <20200629095630.7933-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pass 0 as target_fd when attaching and detaching flow dissector.
Additionally, pass the expected program when detaching.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: 1f043f87bb59 ("selftests/bpf: Add tests for attaching bpf_link to netns")
---
 .../bpf/prog_tests/flow_dissector_reattach.c         | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
index 15cb554a66d8..d70adbc7309a 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
@@ -116,7 +116,7 @@ static void test_prog_attach_prog_attach(int netns, int prog1, int prog2)
 	CHECK_FAIL(query_attached_prog_id(netns) != query_prog_id(prog2));
 
 out_detach:
-	err = bpf_prog_detach(0, BPF_FLOW_DISSECTOR);
+	err = bpf_prog_detach2(prog2, 0, BPF_FLOW_DISSECTOR);
 	if (CHECK_FAIL(err))
 		perror("bpf_prog_detach");
 	CHECK_FAIL(prog_is_attached(netns));
@@ -152,7 +152,7 @@ static void test_prog_attach_link_create(int netns, int prog1, int prog2)
 	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, opts);
 	int err, link;
 
-	err = bpf_prog_attach(prog1, -1, BPF_FLOW_DISSECTOR, 0);
+	err = bpf_prog_attach(prog1, 0, BPF_FLOW_DISSECTOR, 0);
 	if (CHECK_FAIL(err)) {
 		perror("bpf_prog_attach(prog1)");
 		return;
@@ -168,7 +168,7 @@ static void test_prog_attach_link_create(int netns, int prog1, int prog2)
 		close(link);
 	CHECK_FAIL(query_attached_prog_id(netns) != query_prog_id(prog1));
 
-	err = bpf_prog_detach(-1, BPF_FLOW_DISSECTOR);
+	err = bpf_prog_detach2(prog1, 0, BPF_FLOW_DISSECTOR);
 	if (CHECK_FAIL(err))
 		perror("bpf_prog_detach");
 	CHECK_FAIL(prog_is_attached(netns));
@@ -188,7 +188,7 @@ static void test_link_create_prog_attach(int netns, int prog1, int prog2)
 
 	/* Expect failure attaching prog when link exists */
 	errno = 0;
-	err = bpf_prog_attach(prog2, -1, BPF_FLOW_DISSECTOR, 0);
+	err = bpf_prog_attach(prog2, 0, BPF_FLOW_DISSECTOR, 0);
 	if (CHECK_FAIL(!err || errno != EEXIST))
 		perror("bpf_prog_attach(prog2) expected EEXIST");
 	CHECK_FAIL(query_attached_prog_id(netns) != query_prog_id(prog1));
@@ -211,7 +211,7 @@ static void test_link_create_prog_detach(int netns, int prog1, int prog2)
 
 	/* Expect failure detaching prog when link exists */
 	errno = 0;
-	err = bpf_prog_detach(-1, BPF_FLOW_DISSECTOR);
+	err = bpf_prog_detach2(prog1, 0, BPF_FLOW_DISSECTOR);
 	if (CHECK_FAIL(!err || errno != EINVAL))
 		perror("bpf_prog_detach expected EINVAL");
 	CHECK_FAIL(query_attached_prog_id(netns) != query_prog_id(prog1));
@@ -231,7 +231,7 @@ static void test_prog_attach_detach_query(int netns, int prog1, int prog2)
 	}
 	CHECK_FAIL(query_attached_prog_id(netns) != query_prog_id(prog1));
 
-	err = bpf_prog_detach(0, BPF_FLOW_DISSECTOR);
+	err = bpf_prog_detach2(prog1, 0, BPF_FLOW_DISSECTOR);
 	if (CHECK_FAIL(err)) {
 		perror("bpf_prog_detach");
 		return;
-- 
2.25.1

